/// @description Score
// You can write your code in this editor

draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _text = string("Turn: {0}, Energy: {1}/{2}, Score: {3}", turn, energy, turnEnergy, cardScore);
draw_text(x, y, _text);