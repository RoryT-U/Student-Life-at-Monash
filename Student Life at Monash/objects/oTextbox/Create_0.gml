/// Customizable Properties

// Input
confirmKey = vk_space; // button to press to go to the next page
upKey = vk_up; // button to press to move up in options
downKey = vk_down; // button to press to move down in options
maxInputDelay = 5; // how many frames to ignore input
inputDelay = maxInputDelay;

// Position
margin = 4; // how much space the textbox gets from the edges of the screen
padding = 8; // how much space things inside the textbox get
width = display_get_gui_width() - margin * 2;
height = 64;

x = (display_get_gui_width() - width) / 2;
y = display_get_gui_height() - height - margin;

// Text
textFont = fText;
textColor = c_white;
textSpeed = 0.6;
textX = padding;
textY = padding*2;
textWidth = width - padding * 2;

backgroundFrame = 1;

// Portrait
portraitX = padding;
portraitY = padding;

// Speaker
speakerX = padding;
speakerY = 0;
speakerFont = fText;
speakerColor = #464633;

// Option
optionX = padding;
optionY = padding * -3;
optionSpacing = 25;
optionSelectionIndent = 8;
optionWidth = 80;
optionHeight = 25;
optionTextX = 10;
optionFont = fOptionText;
optionTextColor = c_white;

/// Private properties
actions = [];
currentAction = -1;

text = "";
textProgress = 0;
textLength = 0;

portraitSprite = -1;
portraitWidth = sprite_get_width(sPortrait);
portraitHeight = sprite_get_height(sPortrait);
portraitSide = PORTRAIT_SIDE.LEFT;

enum PORTRAIT_SIDE {
	LEFT,
	RIGHT
}

speakerName = "";
speakerWidth = sprite_get_width(sName);
speakerHeight = sprite_get_height(sName);

options = [];
currentOption = 0;
optionCount = 0;

/// Methods

// Start a conversation
setTopic = function(_topic) {
	actions = global.topics[$ _topic];
	currentAction = -1;

	next();
	
	// Lock Player State
	with (oPlayer){
		if (state != PlayerStateLocked){
			lastState = state;
			state = PlayerStateLocked;
		}
	}
}

// Move to the next action, or close the textbox if out of actions
next = function() {
	currentAction++;
	if (currentAction >= array_length(actions)) {
		instance_destroy();
			
		// Lock Player State
		with (oPlayer){
			state = lastState;	
		}
	}
	else {
		actions[currentAction].Act(id);
	}
}

// Set the text that should be typed out
setText = function(_newText) {
	text = _newText;
	textLength = string_length(_newText);
	textProgress = 0;
}