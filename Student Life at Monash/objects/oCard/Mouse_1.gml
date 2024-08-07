/// @description Quick release
// You can write your code in this editor

if (dragged) {
	// last pile should always exist
	if (oCardController.lastPile == noone) {
		show_error("LAST PILE OF DRAGGED CARD NOT SET WTF", true);	
	}
	
	// drop card
	oCardController.draggingCard = false;
	dragged = false;
	
	with oCardController.lastPile {
		insertCard(other, oCardController.lastIndex);
		selectedIndex = oCardController.lastIndex;
	}
}