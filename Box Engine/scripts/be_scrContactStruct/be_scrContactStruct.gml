/// @func   BEContact({Struct.BEBox} box1, {Struct.BEBox} box2);
/// @desc   Holds the contact data between two boxes. Resolving a contact involves removing their
///			interpenetration and applying sufficient impulse to keep them apart.
function BEContact(_box1=undefined, _box2=undefined) constructor
{
	boxes = [_box1, _box2];			// The second box can be undefined if it is scenery.
	
	restitution = 1;				// How quickly the boxes will separate (1 = bounce apart, 0 = stick together).
	
	normal = new BEVector2(0, -1);	// Contact normal from the perspective of the first box.
	
	penetration = 0;				// How much the boxes are intersecting
	
	/// @func	resolve({real} dt);
	/// @desc	Resolves contact, both for velocity and interpenetration.
	static resolve = function(_dt){}
	
	/// @func	calculateSeparatingVelocity();
	/// @desc	Calculates the velocity for separation.
	static calculateSeparatingVelocity = function(){}
	
	/// @func	resolveVelocity({real} dt);
	/// @desc	Handles impulses for collision.
	static resolveVelocity = function(_dt){}
	
	/// @func	resolveInterpenetration({real} dt);
	/// @desc	Handles interpenetration for collision.
	static resolveInterpenetration = function(_dt){}
}