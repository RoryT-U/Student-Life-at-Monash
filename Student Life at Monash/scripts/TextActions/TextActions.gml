#macro TEXT new TextAction
#macro SPEAKER new SpeakerAction
#macro CHOICE new ChoiceAction
#macro OPTION new OptionAction
#macro GOTO new GotoAction

function DialogueAction() constructor {
	Act = function() { };
}

// Define new text to type out
function TextAction(_text) : DialogueAction() constructor {
	text = _text;

	Act = function(_textbox) {
		_textbox.setText(text);
	}
}

// Set the speaker, optionally its portrait and side the portrait is on
function SpeakerAction(_name, _sprite = undefined, _side = undefined): DialogueAction() constructor {
	name = _name;
	sprite = _sprite;
	side = _side;

	Act = function(_textbox) {
		_textbox.speakerName = name;
		
		if (!is_undefined(sprite))
			_textbox.portraitSprite = sprite;
			
		if (!is_undefined(side))
			_textbox.portraitSide = side;
			
		_textbox.next();
	}
}

// Define a branch in the dialogue
function ChoiceAction(_text) : DialogueAction() constructor {
	text = _text;

	// Fill this array with all the arguments after the first one
	options = [];
	for (var i = 1; i < argument_count; i++)
		array_push(options, argument[i]);

	Act = function(_textbox) {
		_textbox.setText(text);
		_textbox.options = options;
		_textbox.optionCount = array_length(options);
		_textbox.currentOption = 0;
	}
}

// Place options within the ChoiceAction
function OptionAction(_text, _topic): DialogueAction() constructor {
	text = _text;
	topic = _topic;

	Act = function(_textbox) {
		_textbox.setTopic(topic);
	}
}

// Automatically go to a specified topic
function GotoAction(_topic): DialogueAction() constructor {
	topic = _topic;

	Act = function(_textbox) {
		_textbox.setTopic(topic);
	}
}