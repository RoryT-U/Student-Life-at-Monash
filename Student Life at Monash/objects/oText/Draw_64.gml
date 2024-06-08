/// @description Draw Textbox
draw_sprite_stretched(sTextBoxBg, background, x1, y1, x2 - x1, y2 - y1);

DrawSetText(fText, fa_center, fa_top, c_black);

var _print = string_copy(text, 1, textProgress);
draw_text((x1 + x2)  /2, y1 + 8, _print);

draw_set_color(c_white);
draw_text((x1 + x2) / 2, y1 + 7, _print);