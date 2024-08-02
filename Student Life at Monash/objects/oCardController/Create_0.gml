/// @description Insert description here
// You can write your code in this editor

cardScore = 0;

deck = noone;
hand = noone;
discard = noone;

discardHand = function() {
	hand.transferCards(discard);	
}

shuffleDeck = function(_callback = EmptyScript) {
	discard.transferCards(deck, undefined, _callback);	
	deck.shuffle();
}

drawHand = function(_cards) {
	if (deck.cardCount() < _cards) {
		_cards -= deck.cardCount();
		deck.transferCards(hand);
		
		var _callback = method({deck, hand, _cards}, function() {deck.transferCards(hand, _cards);});
		
		shuffleDeck(_callback);	
	}
	else
	{
		deck.transferCards(hand, _cards);
	}
}