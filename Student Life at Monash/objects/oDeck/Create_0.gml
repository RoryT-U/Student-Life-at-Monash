/// @description Insert description here
// You can write your code in this editor

#macro SMALL_SPACING 28
#macro LARGE_SPACING 48

cards = [];
selectedIndex = -1;
gapIndex = -1;
selectable = true;
faceDown = false;
spacing = SMALL_SPACING;

discardTarget = noone;

cardCount = function() {
	return array_length(cards);
}

shuffle = function() {
	cards = array_shuffle(cards);
	updateCardHome();
}

/// @desc Insert card at specified index, default to inserting at the end
/// @param {Id.Instance}	_card	Card to insert
/// @param {real}			_index	Index to insert card at, defaults to current card count
insertCard = function(_card, _index = cardCount()) {
	if _card.deck == self {
		return;
	}
	if _index == -1 {
		_index = 0;	
	}
	
	array_insert(cards, _index, _card);
	selectedIndex = _index;
	_card.deck = self;
	_card.image_index = faceDown ? 1 : 0;
	
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
	
	var _boundsLeft = x - (_cardCount / 2) * spacing;
	var _index = floor((_x - _boundsLeft) / spacing);
	
	if _index < 0 {
		_index = 0;
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
	var _cardCount = array_length(cards);
	if (gapIndex == -1 || !selectable) {
		var _leftMost = x - ((_cardCount - 1) / 2) * spacing;
		for (var i = 0; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + i * spacing;
			_card.homeY = y;
			_card.updateDepth();
		}
	} else {
		var _leftMost = x - (_cardCount / 2) * spacing;
		// pre gap
		for (var i = 0; i < gapIndex; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + i * spacing;
			_card.homeY = y;
			_card.updateDepth();
		}
		// post gap
		for (var i = gapIndex; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.deckIndex = i;
			_card.homeX = _leftMost + (i + 1) * spacing;
			_card.homeY = y;
			_card.updateDepth();
		}
	}
}

/// @desc Transfer some number of top cards to another deck (cards of higher index are on top)
/// @param {Id.Instance}	_targetDeck	Deck to transfer cards to
/// @param {real}			_number		Cards to transfer, defaults to all cards
transferCards = function(_targetDeck, _number = cardCount(), _callback = EmptyScript) {
	_number = min(_number, cardCount());
	
	if (_number != 0) {
		var _transferCard = function(_targetDeck) {
			var _currentCard = cards[cardCount() - 1];
			removeCard(_currentCard);
			_targetDeck.insertCard(_currentCard, _targetDeck.cardCount());
		}
	
		var _timer = time_source_create(time_source_game, 0.05, time_source_units_seconds, _transferCard, [_targetDeck], _number);
		time_source_start(_timer);
	}
	
	call_later(0.05 * (_number + 1), time_source_units_seconds, _callback);
}