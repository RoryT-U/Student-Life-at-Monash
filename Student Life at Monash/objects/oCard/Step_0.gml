/// @description Return to home
// You can write your code in this editor

if dragged {
	x = lerp(x, mouse_x, 0.5);
	y = lerp(y, mouse_y, 0.5);
	
	with collision_point(mouse_x, mouse_y, oDeck, true, false) {
		cardInside(other.x, other.y);	
	}
} else {
	x = lerp(x, homeX, 0.2);
	y = lerp(y, homeY + homeOffsetY, 0.2);
}