/// @description Draw card
// You can write your code in this editor

#macro CARD_IMAGE_Y_OFFSET -25
#macro CARD_TEXT_Y_OFFSET 12

#macro ENERGY_X_OFFSET -20
#macro ENERGY_Y_OFFSET -27

draw_sprite(sprite_index, image_index, x, y + visualOffsetY);

// don't draw contents if flipped
if (image_index = 1) {
	exit;	
}

// image
draw_sprite_ext(sCardImages, cardData.imageID, x, y + visualOffsetY + CARD_IMAGE_Y_OFFSET * image_yscale, image_xscale, image_yscale, 0, c_white, 1);

// text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fCardText);
draw_text_transformed(x, y + visualOffsetY + CARD_TEXT_Y_OFFSET, cardData.description, 0.75, 0.75, 0);

// energy
draw_sprite(sEnergy, 0, x + ENERGY_X_OFFSET, y + ENERGY_Y_OFFSET + visualOffsetY);
draw_text_transformed(x + 1 + ENERGY_X_OFFSET, y - 1 + ENERGY_Y_OFFSET + visualOffsetY, cardData.cost, 0.75, 0.75, 0);
