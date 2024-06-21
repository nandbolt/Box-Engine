/// @func	BEPlatformerControllerForceGen();
/// @desc	A platformer controller force generator. Applies the force of a controller pushing the box in a platformer.
function BEPlatformerControllerForceGen() : BEForceGen() constructor
{
	controllerInput = new BEVector2();
	moveStrength = 200;
	jumpStrength = 12000;
	
	/// @func	updateForce({Struct.BEBox} box, {real} dt);
	/// @desc	Applies controller forces to the box.
	static updateForce = function(_box, _dt)
	{
		// Update move input
		controllerInput.x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		controllerInput.scale(moveStrength);
		
		// Update jump input
		if (keyboard_check_pressed(vk_space)) controllerInput.y = -jumpStrength;
		else controllerInput.y = 0;
		
		// Apply controller
		_box.addForceVector(controllerInput);
	}
}