/// @description Draw card
// You can write your code in this editor

#macro CARD_IMAGE_Y_OFFSET -42
#macro CARD_TEXT_Y_OFFSET 20

draw_self();

// image
draw_sprite(sCardImages, cardID, x, y + CARD_IMAGE_Y_OFFSET);

// text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _texts = ["+1.3", "-6.9"];
draw_text(x, y + CARD_TEXT_Y_OFFSET, _texts[cardID]);