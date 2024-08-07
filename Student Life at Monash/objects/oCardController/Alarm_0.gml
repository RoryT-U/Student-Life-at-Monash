/// @description Game init

var _ids = [1,1,1,1,1,0,2,3,3];

for (var i = 0; i < array_length(_ids); i++) {
	var _card = instance_create_layer(-60, 0, "Cards", oCard);
	_card.cardData = variable_clone(cardCatalogue[_ids[i]]);
	draw.insertCard(_card);
	draw.shuffle();
}

endTurn();