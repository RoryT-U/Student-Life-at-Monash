/// @description Return to home

#macro COMPACT_SCALE 0.1

if dragged {
	x = lerp(x, mouse_x, 0.5);
	y = lerp(y, mouse_y, 0.5);
	
	with collision_point(mouse_x, mouse_y, oPile, true, false) {
		cardInside(other.x, other.y);	
	}
} else {
	x = lerp(x, homeX, 0.2);
	y = lerp(y, homeY, 0.2);
	visualOffsetY = lerp(visualOffsetY, homeOffsetY, 0.2);
	
	//var _homeScale = 1;
	//with (pile) {
	//	if (compact) {
	//		_homeScale = 0.1;	
	//	}
	//}
	//image_xscale = lerp(image_xscale, _homeScale, 0.2);
	//image_yscale = lerp(image_yscale, _homeScale, 0.2);
}