/// @desc Event
show_debug_message("Box Engine created!");

// Init display
window_set_size(1280, 720);
surface_resize(application_surface, 1280, 720);

// Init scene
registry = new BEForceRegistry();
fgGravity1 = new BEGravityForceGen(500, 0);
fgGravity2 = new BEGravityForceGen(-500, 0);
inst1 = instance_create_layer(room_width * 0.3, room_height * 0.5, "Instances", be_oBoxChild);
inst2 = instance_create_layer(room_width * 0.7, room_height * 0.5, "Instances", be_oBoxChild);
registry.add(inst1.box, fgGravity1);
registry.add(inst2.box, fgGravity2);