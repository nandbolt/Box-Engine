/// @desc Event
show_debug_message("Box Engine created!");

// Init display
window_set_size(1280, 720);
surface_resize(application_surface, 1280, 720);

// Init scene
registry = new BEForceRegistry();
fgGravity = new BEGravityForceGen();
inst1 = instance_create_layer(room_width * 0.4, room_height * 0.5, "Instances", be_oBox);
inst2 = instance_create_layer(room_width * 0.6, room_height * 0.2, "Instances", be_oBox);
registry.add(inst1.box, fgGravity);
registry.add(inst2.box, fgGravity);