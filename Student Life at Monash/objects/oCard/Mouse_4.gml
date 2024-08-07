/// @description card clicking
// You can write your code in this editor

// abort if another card is being dragged
if !dragged && global.draggingCard exit;
// abort if pile is non selectable or is selecting another card
with pile {
	if !selectable exit;
	else if selectedIndex != -1 && selectedIndex != other.pileIndex exit;
}

dragged = !dragged;
updateDepth();

if !dragged {
	// drop card
	global.draggingCard = false;
	
	var _pile = collision_point(x, y, oPile, true, false);
	
	if _pile == noone || _pile.selectable == false {
		// drop on field
		var _playResult = cardData.PlayEffect();
		if (_playResult != -1) {
			// success
			setHover(false);
			with (oCardController.getPile(_playResult)) {
				insertCard(other);
			}
		} else {
			// failure
			with global.lastPile {
				insertCard(other, global.lastIndex);
				selectedIndex = global.lastIndex;
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
	global.draggingCard = true;
	global.lastPile = pile;
	global.lastIndex = pileIndex;
	
	// unhover and remove
	with pile {
		selectedIndex = -1;
		removeCard(other);
	}
}
