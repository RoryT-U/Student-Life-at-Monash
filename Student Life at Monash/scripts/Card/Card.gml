// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro EFFECT_STACK function() {return DECK.STACK;}
#macro EFFECT_DISCARD function() {return DECK.DISCARD;}

enum CARD_TYPE {
	VALUE,
	ACTION
}

enum TARGET {
	NONE,
	CARD,
}

enum DECK {
	DECK = 0,
	HAND = 1,
	DISCARD = 2,
	STACK = 3,
	EXHAUST = 4,
}

// actions:
// Push [card] to [deck]
// Insert [card] to [deck]
// Exhaust [card]
// Discard [card]
// Play [card]
// Gain [x] energy

// [Deck]:
// Deck
// Hand
// Discard
// Stack
// Exhaust

// [Card]:
// Chosen from [Deck]
// Next played
// Top of [Deck]

function Card(_name, _description, _imageID, _type, _cost, _playEffect = EFFECT_DISCARD, _scoreEffect = EmptyScript, _discardEffect = EmptyScript) constructor {
	name = _name;
	description = _description;
	imageID = _imageID;
	type = _type;
	cost = _cost;
	
	PlayEffect = _playEffect;
	ScoreEffect = _scoreEffect;
	DiscardEffect = _discardEffect; // am i using this correctly? :P
}