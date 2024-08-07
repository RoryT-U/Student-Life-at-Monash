// discard hand
text = "End Turn";
onClick = function() {
	with (oCardController) {
		hand.transferCards(discard, hand.cardCount(), function() {drawCards(5)});
	}
}