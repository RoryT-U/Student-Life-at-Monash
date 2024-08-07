/// @description Game init

var _ids = [0,1,2,3,4,5,6,1,1,1,1,1,0,3,5,3];

for (var i = 0; i < array_length(_ids); i++) {
	createCard(_ids[i], draw);
}

draw.shuffle();
endTurn();