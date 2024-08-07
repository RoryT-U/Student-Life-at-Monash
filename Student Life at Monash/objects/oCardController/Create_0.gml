/// @description Insert description here
// You can write your code in this editor

// for card dragging
draggingCard = false;
lastPile = noone;
lastIndex = -1;
history = [];

stacking = 0;

cardScore = 0;

draw = noone;
hand = noone;
discard = noone;
stack = noone;
exhaust = noone;

energy = 0;
turnEnergy = 3;

turn = 0;

alarm[0] = 1;

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

createCard = function(_id, _pile) {
	var _card = instance_create_layer(_pile.x, _pile.y, "Cards", oCard);
	_card.cardData = variable_clone(cardCatalogue[$ _id]);
	
	_pile.insertCard(_card);
	
	return _card;
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

endTurn = function() {
	hand.transferCards(discard, hand.cardCount(), function() {
		drawCards(5)
	});
	energy = turnEnergy;
	turn += 1;
	stacking = 0;
}

cardCatalogue = {
	"Add1": new Card("Common Sense", "+1", 1, -1, EFFECT_UNPLAYABLE, 
		CLOSURE {cardScore += 1;}
	),
	"Add3": new Card("General Knowledge", "+3", 1, -1, EFFECT_UNPLAYABLE,
		CLOSURE {cardScore += 3;}
	),
	"Times2": new Card("Holy Crap", "Unplayable\nx2", 1, 0, EFFECT_UNPLAYABLE,
		CLOSURE {cardScore *= 2;}
	),
	"Stack1": new Card("Write Up", "Stack 1", 0, 1,
		CLOSURE {
			stacking += 1;
			return PILE.DISCARD;	
		},
	),
	"Pop": new Card("Pop", "Exhaust top\ncard on stack", 0, 1,
		CLOSURE {
			var _card = stack.topCard();
			with (_card) {
				pile.removeCard(self);
				other.exhaust.insertCard(self);
			}
			return PILE.DISCARD;
		},
	),
	"Rush": new Card("Rush", "Stack 2\nStack Negative\nCommon Sense", 2, 1,
		CLOSURE {
			stacking += 2;
			
			with (createCard("Add1", stack).cardData) {
				ScoreEffect = CLOSURE {oCardController.cardScore -= 1};
				description = "-1";
			}
			
			return PILE.DISCARD;
		},
	),
	"AI": new Card("Prompt AI", "Add General Knowledge\nto hand\n50% of being Negative", 2, 0,
		CLOSURE {
			with (createCard("Add3", hand).cardData) {
				if (choose(true, false)) {
					ScoreEffect = CLOSURE {oCardController.cardScore -= 3};
					description = "-3";
				}
			}
			return PILE.DISCARD;
		},
	),
	"Grind": new Card("Grind", "Stack 2\n Draw 1", 2, 2,
		CLOSURE {
			stacking += 2;
			drawCards(1);
			return PILE.DISCARD;
		}
	),
};