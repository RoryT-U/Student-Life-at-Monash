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
/// @param {real}			_index	Index to insert card at, defaults to current card count, index of -1 is translated to 0
insertCard = function(_card, _index = cardCount()) {
	if _card.pile == self {
		return;
	}
	if _index == -1 {
		_index = 0;	
	}
	
	array_insert(cards, _index, _card);
	if (_card.getHover()) {selectedIndex = _index;}
	_card.pile = self;
	_card.image_index = faceDown ? 1 : 0;
	
	updateCardHome();
}

removeCard = function(_card) {
	array_delete(cards, _card.pileIndex, 1);
	_card.pile = noone;
	
	if (selectedIndex == _card.pileIndex) {selectedIndex = -1;}
	
	updateCardHome();
}

/// @desc called every step while card is dragged over pile
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

/// @desc Update position cards return to in pile as well as their index and depth
updateCardHome = function() {
	var _cardCount = array_length(cards);
	if (gapIndex == -1 || !selectable) {
		var _leftMost = x - ((_cardCount - 1) / 2) * spacing;
		for (var i = 0; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.pileIndex = i;
			_card.homeX = _leftMost + i * spacing;
			_card.homeY = y;
			_card.setHover(i == selectedIndex);
			_card.updateDepth();
			//show_debug_message("i: {0} selected {1}",i , selectedIndex);
		}
	} else {
		var _leftMost = x - (_cardCount / 2) * spacing;
		// pre gap
		for (var i = 0; i < gapIndex; i++) {
			var _card = cards[i];
		
			_card.pileIndex = i;
			_card.homeX = _leftMost + i * spacing;
			_card.homeY = y;
			_card.setHover(i == selectedIndex);
			_card.updateDepth();
		}
		// post gap
		for (var i = gapIndex; i < _cardCount; i++) {
			var _card = cards[i];
		
			_card.pileIndex = i;
			_card.homeX = _leftMost + (i + 1) * spacing;
			_card.homeY = y;
			_card.setHover(i == selectedIndex);
			_card.updateDepth();
		}
	}
}

/// @desc Transfer some number of top cards to another pile (cards of higher index are on top). Buttons are disabled during the transfer animation.
/// @param {Id.Instance}	_targetPile	Pile to transfer cards to
/// @param {real}			_number		Cards to transfer, defaults to all cards
transferCards = function(_targetPile, _number = cardCount(), _callback = EmptyScript) {
	SetButtonsEnabled(false);
	var _reEnable = CLOSURE{SetButtonsEnabled(true)};
	
	_number = min(_number, cardCount());
	if (_number > 0) {
		var _transferCard = function(_targetPile) {
			var _card = cards[cardCount()-1]
			removeCard(_card);
			_targetPile.insertCard(_card);
		}
	
		var _timer = time_source_create(time_source_game, 0.05, time_source_units_seconds, _transferCard, [_targetPile], _number);
		time_source_start(_timer);
	}
	
	call_later(0.05 * (_number + 1), time_source_units_seconds, CombineFunctions(_reEnable, _callback));
}