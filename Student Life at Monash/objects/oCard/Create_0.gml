/// @description Insert description here
// You can write your code in this editor

dragged = false;
pile = noone;
pileIndex = -1;

mouseInside = false;

homeX = x;
homeY = y;

visualOffsetY = 0;
homeOffsetY = 0;

// random card
cardData = variable_clone(oCardController.cardCatalogue[choose(0, 1, 2)]);
// card = struct

getHover = function() {
	return homeOffsetY != 0;	
}

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
	depth = _inFront ? -1000 : -pileIndex;	
}