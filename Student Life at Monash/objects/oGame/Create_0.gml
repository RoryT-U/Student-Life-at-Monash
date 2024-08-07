/// @description Initialize

randomize();

global.gamePaused = false;
global.textSpeed = 0.75;
global.iCamera = instance_create_layer(0, 0, layer, oCamera);

/// @desc Certain controls should be disabled under certain animations
global.awaitingAnimation = false;

/// @desc Current level of top most menu (to prevent interaction with lower menus)
global.uiLevel = 0;

display_set_gui_size(RESOLUTION_W, RESOLUTION_H)

room_goto(ROOM_START);