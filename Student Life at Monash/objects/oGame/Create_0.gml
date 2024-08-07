/// @description Initialize

randomize();

global.gamePaused = false;
global.textSpeed = 0.75;
global.iCamera = instance_create_layer(0, 0, layer, oCamera);

/// @desc Current depth of top most menu (to prevent interaction with lower menus) (note lower depth means closer to camera)
global.uiDepth = 0;

display_set_gui_size(RESOLUTION_W, RESOLUTION_H)

room_goto(ROOM_START);