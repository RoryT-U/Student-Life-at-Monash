/// @description Insert description here
// You can write your code in this editor

// for card dragging
draggingCard = false;
lastPile = noone;
lastIndex = -1;
history = [];

cardCatalogue = [
	new Card("Vessel of Avarice", "Draw 2", 0, CARD_TYPE.ACTION, 1,
		CLOSURE {
			drawCards(2);
			return PILE.EXHAUST;
		}
	),
	new Card("Common Sense", "Stack\n+1", 1, CARD_TYPE.VALUE, 1, EFFECT_STACK, 
		CLOSURE {cardScore += 1;}
	),
	new Card("Holy Crap", "Stack\nx2", 1, CARD_TYPE.VALUE, 2, EFFECT_STACK,
		CLOSURE {
			cardScore *= 2;
			return PILE.EXHAUST;
		}
	),
	new Card("Rush", "Stack\nDraw 1\n-1", 1, CARD_TYPE.VALUE, 0,
		CLOSURE {
			drawCards(1);
			return PILE.STACK;	
		},
		CLOSURE {
			cardScore -= 1;	
		}
	),
];

cardScore = 0;

draw = noone;
hand = noone;
discard = noone;
stack = noone;
exhaust = noone;

energy = 0;
turnEnergy = 3;

turn = 0;

getPile = function(_pileID) {
	return [draw, hand, discard, stack, exhaust][_pileID];	
}

discardHand = function() {
	hand.transferCards(discard);	
}

/// @desc Shuffle discard into draw pile
shufflePile = function(_callback = EmptyScript) {
	discard.transferCards(draw, undefined, _callback);	
	draw.shuffle();
}

/// @desc Draw a number of cards into hand, shuffling the discard if necessary
drawCards = function(_cards) {

	if (draw.cardCount() < _cards) {
		_cards -= draw.cardCount();
		
		// 3. Draw remaining cards
		var _callback3 = method({test:draw.transferCards, hand, _cards}, function() {test(hand, _cards);});
		
		// 2. Transfer discarded to draw and shuffle
		var _callback2 = method({shufflePile, _callback3}, CLOSURE{shufflePile(_callback3);});
		
		// 1. Draw all in draw pile
		draw.transferCards(hand, undefined, _callback2);
	}
	else
	{
		draw.transferCards(hand, _cards);
	}
}

// turn control
scoreStack = function() {
	SetButtonsEnabled(false);
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
	
	var _leaveGame = CLOSURE {room_goto(rVillage);};
	
	var _exhaust = method({stack, exhaust, _leaveGame}, function() {stack.transferCards(exhaust, undefined, _leaveGame);});
	call_later(0.7 * (_number + 1), time_source_units_seconds, _exhaust);
}
	
alarm[0] = 1;

endTurn = function() {
	hand.transferCards(discard, hand.cardCount(), function() {drawCards(5)});
	energy = turnEnergy;
	turn += 1;
}