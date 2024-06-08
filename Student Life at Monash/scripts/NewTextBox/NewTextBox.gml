// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(_text, _background){
	// Creates Text or Text Queue Object and sets variables
	with (instance_create_layer(0, 0, "Instances", oText)){
		if (instance_exists(other)){
			originInstance = other.id;
		} else{
			originInstance = noone;
		}
		text = _text;
		background = _background;
	}
	
	with (oPlayer){
		if (state != PlayerStateLocked){
			lastState = state;
			state = PlayerStateLocked;
		}
	}
}