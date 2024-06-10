// Draw the box
draw_sprite_stretched(sprite_index, backgroundFrame, x, y, width, height);

var _drawTextX = x;
var _drawTextY = y;
var _drawTextWidth = textWidth;

var _finished = textProgress == textLength;

// Portrait
if (sprite_exists(portraitSprite)) {
	// Shrink text width by the width the portrait will take up
	_drawTextWidth -= portraitWidth + portraitX + padding;
	
	var _drawPortraitX = x + portraitX;
	var _drawPortraitY = y + portraitY;
	var _drawPortraitXscale = 1;
	
	// What side is the portrait on?
	if (portraitSide == PORTRAIT_SIDE.LEFT) {
		// Shift the text over when the portrait is on the left
		_drawTextX += portraitWidth + portraitX + padding;
	}
	else {
		// Shift the portrait itself over when it is on the right
		_drawPortraitX = x + width - portraitWidth - portraitX;
		_drawPortraitXscale = -1;
	}
	
	// Draw portrait backing
	draw_sprite(sPortrait, 0, _drawPortraitX, _drawPortraitY);
	
	// Animate the portrait when typing
	var _subimg = 0;
	if (!_finished)
		_subimg = (textProgress / textSpeed) * (sprite_get_speed(portraitSprite) / game_get_speed(gamespeed_fps));
		
	draw_sprite_ext(portraitSprite, _subimg,
		_drawPortraitX + portraitWidth / 2, _drawPortraitY + portraitHeight / 2,
		_drawPortraitXscale, 1, 0, c_white, 1);
}

// Speaker
if (speakerName != "") {
	// Expand the nameplate if the name is wider than the default width
	var _nameW = max(string_width(speakerName), speakerWidth);
	
	draw_sprite_stretched(sName, 0, x + speakerX, y + speakerY - speakerHeight / 2, _nameW, speakerHeight);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(speakerFont);
	draw_set_color(speakerColor);
	draw_text(x + speakerX + _nameW / 2, y + speakerY, speakerName);
}

// Text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(textFont);
draw_set_color(textColor);
Type(_drawTextX + textX, _drawTextY + textY, text, textProgress, _drawTextWidth);

// Options
if (_finished && optionCount > 0) {
	draw_set_valign(fa_middle);
	draw_set_color(optionTextColor);
	draw_set_font(optionFont);
	for (var i = 0; i < optionCount; i++) {
		var _optX = x + optionX;
		var _optY = y + optionY - (optionCount - i - 1) * optionSpacing;
		
		// Selected option is indented with an arrow
		if (i == currentOption) {
			_optX += optionSelectionIndent;
			draw_sprite(sOptionArrow, 0, _optX, _optY);
		}
		
		draw_sprite_stretched(sTextBoxBg, 0, _optX, _optY - optionHeight / 2, optionWidth, optionHeight);
		draw_text(_optX + optionTextX, _optY, options[i].text);
	}
}