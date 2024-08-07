// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @desc Packages two anonymous methods into one
function CombineFunctions(_a, _b){
	return method({_a, _b}, CLOSURE{_a(); _b();});
}