/// @desc Event
show_debug_message("Box Engine created!");

// Set display
window_set_size(1280, 720);
surface_resize(application_surface, 1280, 720);

// Create a box
instance_create_layer(room_width * 0.5, room_height * 0.5, "Instances", be_oBox);