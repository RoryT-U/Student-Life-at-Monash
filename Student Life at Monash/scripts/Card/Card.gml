// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro EFFECT_STACK function() {return PILE.STACK;}
#macro EFFECT_DISCARD function() {return PILE.DISCARD;}
#macro EFFECT_UNPLAYABLE function() {return -1;}

enum CARD_TYPE {
	VALUE,
	ACTION
}

enum TARGET {
	NONE,
	CARD,
}

enum PILE {
	DRAW = 0,
	HAND = 1,
	DISCARD = 2,
	STACK = 3,
	EXHAUST = 4,
}

// actions:
// Push [card] to [pile]
// Insert [card] to [pile]
// Exhaust [card]
// Discard [card]
// Play [card]
// Gain [x] energy

// [pile]:
// Draw
// Hand
// Discard
// Stack
// Exhaust

// [Card]:
// Chosen from [pile]
// Next played
// Top of [pile]

function Card(_name, _description, _imageID, _cost, _playEffect = EFFECT_DISCARD, _scoreEffect = EmptyScript, _discardEffect = EmptyScript) constructor {
	name = _name;
	description = _description;
	imageID = _imageID;
	type = "unused lol";
	cost = _cost;
	
	// returns a pile index to determine what pile it ends up in after being played
	// a return index of -1 means the card failed to play and should be returned to hand
	PlayEffect = _playEffect;
	ScoreEffect = _scoreEffect;
	DiscardEffect = _discardEffect; // am i using this correctly? :P
}