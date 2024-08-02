/// @description card clicking
// You can write your code in this editor

// abort if another card is being dragged
if !dragged && global.draggingCard exit;
// abort if deck is non selectable or is selecting another card
with deck {
	if !selectable exit;
	else if selectedIndex != -1 && selectedIndex != other.deckIndex exit;
}

dragged = !dragged;
updateDepth();

if !dragged {
	// drop card
	global.draggingCard = false;
	
	var _deck = collision_point(x, y, oDeck, true, false);
	
	if _deck == noone || _deck.selectable == false {
		// drop on field
		setHover(false);
		with (oCardController) {
			cardScore += 1.3;
			discard.insertCard(other, discard.cardCount());
		}
	} else if _deck != deck {
		// add to deck
		with _deck {
			insertCard(other, gapIndex);
			selectedIndex = gapIndex;
			setGapIndex(-1);
		}
	}
} else {
	// pick up card
	global.draggingCard = true;
	
	// unhover and remove
	with deck {
		selectedIndex = -1;
		removeCard(other);
	}
}
