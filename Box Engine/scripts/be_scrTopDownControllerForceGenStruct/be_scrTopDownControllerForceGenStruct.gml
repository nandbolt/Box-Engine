/// @func	BETopDownControllerForceGen();
function BETopDownControllerForceGen() : BEForceGen() constructor
{
	controllerInput = new BEVector2();
	
	/// @func	updateForce({Struct.BEBox} box, {real} dt);
	/// @desc	Applies controller forces to the box.
	static updateForce = function(_box, _dt)
	{
		// Return if infinite mass
		if (!_box.hasFiniteMass()) return;
		
		// Update controller input
		controllerInput.x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		controllerInput.y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
		controllerInput.normalize();
		controllerInput.scale(100);
		
		// Apply controller
		_box.addForceVector(controllerInput);
	}
}