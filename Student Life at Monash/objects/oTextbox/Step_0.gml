// Get input
var _confirm = keyboard_check_pressed(confirmKey);

// Type out the text
textProgress = min(textProgress + textSpeed, textLength);

// Ignore inputs when delay is active
if (inputDelay > 0) {
	inputDelay--;
	exit;
}

// Are we finished typing?
if (textProgress == textLength) {
	if (optionCount > 0) {
		var _up = keyboard_check_pressed(upKey);
		var _down = keyboard_check_pressed(downKey);
		
		// Cycle through available options
		var _change = _down - _up;
		if (_change != 0) {
			currentOption += _change;
		
			// Wrap to first and last option
			if (currentOption < 0)
				currentOption = optionCount - 1;
			else if (currentOption >= optionCount)
				currentOption = 0;
		}
		
		// Select an option!
		if (_confirm) {
			var _option = options[currentOption];
			options = [];
			optionCount = 0;
			
			_option.Act(id);
		}
	}
	else if (_confirm) {
		next();
	}
}
else if (_confirm) {
	textProgress = textLength;
}
