onClick = EmptyScript;
text = "";

selected = false;
clicking = false;

getEnabled = function() {
	return image_index == 3;	
}

setEnabled = function(_set) {
	if (!_set) {
		image_index = 3;
		clicking = false;
	} else {
		if (selected) {
			image_index = 2;
		} else {
			image_index = 0;
		}
	}
}