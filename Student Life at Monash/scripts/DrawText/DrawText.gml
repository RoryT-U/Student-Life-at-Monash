// Creates a textbox and starts a conversation.
// @param topic - What topic the dialogue box should use
// @param type - What textbox background should be used
function StartDialogue(_topic, _type=0) {
	if (instance_exists(oTextbox))
		return;
		
	var _inst = instance_create_depth(x, y, -999, oTextbox);
	_inst.setTopic(_topic);
	_inst.backgroundFrame = _type;
}

function Type(_x, _y, _text, _progress, _width) {
	var _drawX = 0;
	var _drawY = 0;
	
	for (var i = 1; i <= _progress; i++) {
		var _char = string_char_at(_text, i);
	
		// Handle normal line breaks
		if (_char == "\n") {
			_drawX = 0;
			_drawY += string_height("A");
		}
		// If we're starting a new word, we can line break
		else if (_char == " ") {
			_drawX += string_width(_char);
			
			var _wordWidth = 0;
			for (var j = i + 1; j <= string_length(_text); j++) {
				var _wordChar = string_char_at(_text, j);
				
				// If we reached the end of the word, stop checking
				if (_wordChar == "\n" || _wordChar == " ")
					break;
				
				// If the current word extends past the width boundary,
				// then move it to the next line
				_wordWidth += string_width(_wordChar);
				if (_drawX + _wordWidth > _width) {
					_drawX = 0;
					_drawY += string_height("A");
					break;
				}
			}
		}
		else {
			// Draw the letter
			draw_text(_x + _drawX, _y + _drawY, _char);
			_drawX += string_width(_char);
		}
	}
}