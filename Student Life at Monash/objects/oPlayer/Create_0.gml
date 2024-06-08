state = PlayerStateFree;
lastState = state;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
distanceRoll = 52;

spriteIdle = sPlayer;
spriteRun = sPlayerRun;
spriteRoll = sPlayerRoll
localFrame = 0;


// Player Inputs
keyLeft = false;
keyRight = false;
keyUp = false;
keyDown = false;

keyActivate = false;
keyAttack = false;
keyItem = false;

inputDirection = 0;
inputMagnitude = 0;