/// @description Game init

var _ids = [[7, "Add1"], [7, "Stack1"], [1, "Add1"], [1, "Pop"], [1, "Rush"], [1, "AI"], [1, "Grind"], [1, "Times2"]];

for (var i = 0; i < array_length(_ids); i++) {
	repeat (_ids[i][0]) {
		createCard(_ids[i][1], draw);
	}
}

draw.shuffle();
endTurn();