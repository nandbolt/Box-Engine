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
	static resolve = function(_dt)
	{
		resolveVelocity(_dt);
		resolveInterpenetration(_dt);
	}
	
	/// @func	calculateSeparatingVelocity();
	/// @desc	Calculates the velocity for separation.
	static calculateSeparatingVelocity = function()
	{
		var _relativeVelocity = boxes[0].getVelocity();
		if (!is_undefined(boxes[1])) _relativeVelocity.addVector(boxes[1].getVelocity());
		return _relativeVelocity.dotProductVector(normal);
	}
	
	/// @func	resolveVelocity({real} dt);
	/// @desc	Handles impulses for collision.
	static resolveVelocity = function(_dt)
	{
		// Find velocity (real number) in direction of contact
		var _separatingVelocity = calculateSeparatingVelocity();
		
		// Return if resolving isn't necessary
		if (_separatingVelocity > 0) return;
		
		// Calculate new separating velocity
		var _newSepVelocity = -_separatingVelocity * restitution;
		var _deltaVelocity = _newSepVelocity - _separatingVelocity;
		
		// Apply change in velocity in proportion to inverse mass
		var _totalInverseMass = boxes[0].getInverseMass();
		if (!is_undefined(boxes[1])) _totalInverseMass += boxes[1].getInverseMass();
		
		// Return if infinite mass
		if (_totalInverseMass <= 0) return;
		
		// Calculate impulse
		var _impulse = _deltaVelocity / _totalInverseMass;
		
		// Find impulse per unit of inverse mass
		var _impulsePerIMass = new BEVector2(normal.x * _impulse, normal.y * _impulse);
		
		// Apply impulse in direction of contact (proportional to inverse mass)
		var _prevVelocity = boxes[0].getVelocity(), _inverseMass = boxes[0].getInverseMass();
		var _vx = _prevVelocity.x + _impulsePerIMass.x * _inverseMass;
		var _vy = _prevVelocity.y + _impulsePerIMass.y * _inverseMass;
		boxes[0].setVelocity(_vx, _vy);
		if (!is_undefined(boxes[1]))
		{
			// Other box goes in the opposite direction
			_prevVelocity = boxes[1].getVelocity();
			_inverseMass = boxes[1].getInverseMass();
			_vx = _prevVelocity.x + _impulsePerIMass.x * -_inverseMass;
			_vy = _prevVelocity.y + _impulsePerIMass.y * -_inverseMass;
			boxes[1].setVelocity(_vx, _vy);
		}
	}
	
	/// @func	resolveInterpenetration({real} dt);
	/// @desc	Handles interpenetration for collision.
	static resolveInterpenetration = function(_dt)
	{
		
	}
}