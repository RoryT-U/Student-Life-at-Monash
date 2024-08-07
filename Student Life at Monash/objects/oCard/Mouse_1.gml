/// @description Quick release
// You can write your code in this editor

if (dragged) {
	// last pile should always exist
	if (oCardController.lastPile == noone) {
		show_error("LAST PILE OF DRAGGED CARD NOT SET WTF", true);	
	}
	
	// drop card
	dragged = false;
	oCardController.draggingCard = false;
	
	var _pile = collision_point(x, y, oPile, true, false);
	
	if _pile == noone || _pile.selectable == false {
		// return to hand
		with oCardController.lastPile {
			insertCard(other, oCardController.lastIndex);
			selectedIndex = oCardController.lastIndex;
		}
	} else if _pile != pile {
		// add to pile
		with _pile {
			insertCard(other, gapIndex);
			selectedIndex = gapIndex;
			setGapIndex(-1);
		}
	}
}