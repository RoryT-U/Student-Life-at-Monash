/// @description Hover enter

selected = true;

// ignore sprite update if disabled
if (image_index == 3) {exit;}

if (clicking) {
	image_index = 1;	
} else {
	image_index = 2;	
}
