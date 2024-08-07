/// @description Insert description here
// You can write your code in this editor

// global variables
global.draggingCard = false;
global.lastPile = noone;
global.lastIndex = -1;

global.cardCatalogue = [
	new Card("A", "Discard", 0, CARD_TYPE.ACTION, 1),
	new Card("B", "Stack", 1, CARD_TYPE.VALUE, 1, EFFECT_STACK, function() {cardScore += 3.1;}),
	new Card("C", "Wack", 2, CARD_TYPE.VALUE, 2, function() {return -1;})
];

cardScore = 0;

draw = noone;
hand = noone;
discard = noone;
stack = noone;
exhaust = noone;

getPile = function(_pileID) {
	return [draw, hand, discard, stack, exhaust][_pileID];	
}

discardHand = function() {
	hand.transferCards(discard);	
}

shufflePile = function(_callback = EmptyScript) {
	discard.transferCards(draw, undefined, _callback);	
	draw.shuffle();
}

drawHand = function(_cards) {
	if (draw.cardCount() < _cards) {
		_cards -= draw.cardCount();
		draw.transferCards(hand);
		
		var _callback = method({draw, hand, _cards}, function() {draw.transferCards(hand, _cards);});
		
		shufflePile(_callback);	
	}
	else
	{
		draw.transferCards(hand, _cards);
	}
}

scoreStack = function() {
	var _number = stack.cardCount() + 1;
	
	// score cards one by one
	var _score = method(
		{i: 0, cards: stack.cards},
		function() {
			// unhover last
			if (i > 0) {
				cards[i-1].setHover(false);
			}
			if (i >= array_length(cards)) {
				return;	
			}
			
			// score current
			with (cards[i]) {
				setHover(true);
				cardData.ScoreEffect();
			}
			i++;
		}
	);
	var _timer = time_source_create(time_source_game, 0.7, time_source_units_seconds, _score, [], _number);
	time_source_start(_timer);
	
	// exhaust all
	var _exhaust = function() {stack.transferCards(exhaust)};
	call_later(0.7 * (_number + 1), time_source_units_seconds, _exhaust);
}