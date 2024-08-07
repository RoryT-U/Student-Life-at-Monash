/// @description Score
// You can write your code in this editor

#macro STATUS_TEXT_X room_width / 2
#macro STATUS_TEXT_Y 94

draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _text = string("Turn: {0}, Energy: {1}/{2}, Score: {3}", turn, energy, turnEnergy, cardScore);
draw_text(x, y, _text);

if (stacking > 0) {
	var _status = string("Stacking {0}", stacking);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(STATUS_TEXT_X, STATUS_TEXT_Y, _status);	
}