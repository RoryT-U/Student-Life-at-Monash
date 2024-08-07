/// @description card clicking
// You can write your code in this editor

// abort if another card is being dragged
if !dragged && oCardController.draggingCard exit;
// abort if pile is non selectable or is selecting another card
with pile {
	if !selectable exit;
	else if selectedIndex != -1 && selectedIndex != other.pileIndex exit;
}

dragged = !dragged;
updateDepth();

if !dragged {
	// drop card
	oCardController.draggingCard = false;
	
	var _pile = collision_point(x, y, oPile, true, false);
	
	if _pile == noone || _pile.selectable == false {
		// drop on field
		if (oCardController.stacking > 0) {
			oCardController.stack.insertCard(self);
			oCardController.stacking -= 1;
		} else if (!tryPlayCard()) {
			// return to hand if failed
			with oCardController.lastPile {
				insertCard(other, oCardController.lastIndex);
				selectedIndex = oCardController.lastIndex;
			}	
		}
	} else if _pile != pile {
		// add to pile
		with _pile {
			insertCard(other, gapIndex);
			selectedIndex = gapIndex;
			setGapIndex(-1);
		}
	}
} else {
	// pick up card
	oCardController.draggingCard = true;
	oCardController.lastPile = pile;
	oCardController.lastIndex = pileIndex;
	
	// unhover and remove
	setHover(false);
	with pile {
		selectedIndex = -1;
		removeCard(other);
	}
}
