/// @description Insert description here
// You can write your code in this editor

#macro SPACING 40

cards = [];
selectedIndex = -1;
gapIndex = -1;
selectable = true;

insertCard = function(_card, _index) {
	if _card.deck == self {
		return;
	}
	if _index == -1 {
		_index = 0;	
	}
	
	array_insert(cards, _index, _card);
	_card.deck = self;
	
	updateCardHome();
}

removeCard = function(_card) {
	array_delete(cards, _card.deckIndex, 1);
	_card.deck = noone;
	
	updateCardHome();
}

/// @desc called every step while card is dragged over deck
cardInside = function(_x, _y) {
	var _cardCount = array_length(cards);
	
	var _boundsLeft = x - (_cardCount / 2) * SPACING;
	var _index = floor((_x - _boundsLeft) / SPACING);
	
	if _index < 0 {
		_index = -1;
	} else if _index > _cardCount {
		_index = _cardCount;	
	}
	setGapIndex(_index);
}

setGapIndex = function(_index) {
	if _index != gapIndex {
		gapIndex = _index;
		updateCardHome();
	}
}

/// @desc Update position cards return to in deck as well as their index and depth
updateCardHome = function() {	
	if gapIndex == -1 {
		var _cardCount = array_length(cards);
		var _leftMost = x - ((_cardCount - 1) / 2) * SPACING;
		for (var i = 0; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + i * SPACING;
			_card.homeY= y;
			_card.updateDepth();
		}
	} else {
		var _cardCount = array_length(cards);
		var _leftMost = x - (_cardCount / 2) * SPACING;
		// pre gap
		for (var i = 0; i < gapIndex; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + i * SPACING;
			_card.homeY = y;
			_card.updateDepth();
		}
		// post gap
		for (var i = gapIndex; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + (i + 1) * SPACING;
			_card.homeY = y;
			_card.updateDepth();
		}
	}
}