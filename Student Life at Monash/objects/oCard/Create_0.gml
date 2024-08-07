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

tryPlayCard = function() {
	var _playResult = cardData.cost <= oCardController.energy ? cardData.PlayEffect() : -1;
	if (_playResult != -1) {
		// success
		oCardController.energy -= cardData.cost;
		setHover(false);
		with (oCardController.getPile(_playResult)) {
			insertCard(other);
		}
		return true;
	} else {
		// failure
		return false;
	}
}

/// @desc Update depth of card after changing index, dragging or hovering
updateDepth = function() {
	var _inFront = dragged || homeOffsetY != 0;
	depth = _inFront ? -100 : -pileIndex;	
}