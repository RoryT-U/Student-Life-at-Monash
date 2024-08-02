// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Card(_name, _description, _PlayEffect, _DiscardEffect = EmptyScript) constructor {
	name = _name;
	description = _description;
	
	PlayEffect = _playEffect;
	DiscardEffect = _discardEffect; // am i using this correctly? :P
}