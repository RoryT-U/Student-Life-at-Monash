/// @description Draw card
// You can write your code in this editor

#macro CARD_IMAGE_Y_OFFSET -25
#macro CARD_TEXT_Y_OFFSET 12

draw_sprite(sprite_index, image_index, x, y + visualOffsetY);

// don't draw contents if flipped
if (image_index = 1) {
	exit;	
}

// image
draw_sprite_ext(sCardImages, cardID, x, y + visualOffsetY + CARD_IMAGE_Y_OFFSET * image_yscale, image_xscale, image_yscale, 0, c_white, 1);

// text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var _texts = ["+1.3", "Grass", "-6.9"];
draw_set_font(fCardText);
draw_text_transformed(x, y + visualOffsetY + CARD_TEXT_Y_OFFSET, _texts[cardID], 0.75, 0.75, 0);