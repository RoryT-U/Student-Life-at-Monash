/// @description Insert description here
// You can write your code in this editor

dragged = false;
deck = noone;
deckIndex = -1;

mouseInside = false;

homeX = x;
homeY = y;

homeOffsetY = 0;

// random card
cardID = choose(0, 1);
// card = struct

setHover = function(_set) {
	if _set {
		homeOffsetY = -10;	
	} else {
		homeOffsetY = 0;
	}
	updateDepth();
}

/// @desc Update depth of card after changing index, dragging or hovering
updateDepth = function() {
	var _inFront = dragged || homeOffsetY != 0;
	depth = _inFront ? -1000 : -deckIndex;	
}