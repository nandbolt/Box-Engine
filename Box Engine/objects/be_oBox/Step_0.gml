/// @desc Event
var _dt = delta_time / 1000000;

// Reset net force
box.netForce.set();

// Apply move force
box.netForce.set((keyboard_check(ord("D")) - keyboard_check(ord("A"))) * 100, (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * 100);
if (box.netForce.magnitude() == 0) box.setDamping(0.1);
else box.setDamping(1);

// Integrate box
box.integrate(_dt);