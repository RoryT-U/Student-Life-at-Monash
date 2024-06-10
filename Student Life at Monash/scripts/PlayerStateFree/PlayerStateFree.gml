function PlayerStateFree(){
	// Movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	PlayerCollision();

	// Update Sprite Index
	var _oldSprite = sprite_index;

	if (inputMagnitude != 0){
		direction = inputDirection;
		sprite_index = spriteRun;
	} else {
		sprite_index = spriteIdle;
	}

	if (_oldSprite != sprite_index){
		localFrame = 0;
	}

	PlayerAnimateSprite(); 
	
	if (keyInteract){
		// Check for Entity to Activate
		var _activateX = lengthdir_x(10, direction);
		var _activateY = lengthdir_y(10, direction);
		interact = instance_position(x+_activateX, y+_activateY, pEntity);
		
		// If No Entity or Entity cannot be Activated
		if (interact != noone && interact.entityInteractScript != EmptyScript) {
			script_execute_ext(interact.entityInteractScript, interact.entityInteractArgs);
			
			if (interact.entityNPC){
				with (interact){
					direction = point_direction(x, y, other.x, other.y);
					image_index = CARDINAL_DIR;
				}
			}
		}
	} else if (keyActivate){
		state = PlayerStateRoll;
		moveDistanceRemaining = distanceRoll;	
	}
}