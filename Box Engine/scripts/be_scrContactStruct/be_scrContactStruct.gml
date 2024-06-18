/// @func   BEContact({Struct.BEBox} box1, {Struct.BEBox} box2);
/// @desc   Holds the contact data between two boxes. Resolving a contact involves removing their
///			interpenetration and applying sufficient impulse to keep them apart.
function BEContact(_box1=undefined, _box2=undefined) constructor
{
	boxes = [_box1, _box2];			// The second box can be undefined if it is scenery.
	
	restitution = 0;				// How quickly the boxes will separate (1 = bounce apart, 0 = stick together).
	
	normal = new BEVector2(0, -1);	// Contact normal from the perspective of the first box.
}