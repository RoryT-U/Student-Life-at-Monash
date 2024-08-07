/// @description Card hover
// You can write your code in this editor

if oCardController.draggingCard || !selectable exit;

var _cardCount = array_length(cards);

// prioritise larger index
if selectedIndex == -1 {
	// look for selected
	for (var i = _cardCount - 1; i >= 0; i--) {
		with cards[i] {
			if mouseInside {
				setHover(true);
				other.selectedIndex = i;
				i = -1;
			}
		}
	}
} else {
	// check if still selected
	with cards[selectedIndex] {
		if !mouseInside {
			setHover(false);
			other.selectedIndex = -1;
		}
	}
}