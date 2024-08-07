/// @desc Quickly instaniates a button
function QuickButton(_x, _y, _layer, _text, _onClick, _width = 2, _height = 1) {
	var _data = {
		onClick : _onClick,
		text : _text,
	}
	instance_create_layer(_x, _y, _layer, oButton, _data);
}

/// @desc Set enabled of all buttons
function SetButtonsEnabled(_set) {
	with (oButton) {
		setEnabled(_set);	
	}
}