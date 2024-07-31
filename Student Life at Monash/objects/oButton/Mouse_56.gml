/// @description Click event

// Holding left cursor over the button, moving the cursor off and back on, and releasing counts as a click
// This matches the behaviour of my chrome minimise button lmao
if (clicking && selected) {
	clicking = false;
	image_index = 2;
	onClick();
}