/// @func	BEContactResolver({int} iterations);
/// @desc	The contact resolution routine for contacts. One can be shared for the whole simulation.
function BEContactResolver(_iterations=1) constructor
{
	iterations = _iterations;	// The number of iterations that can be used.
	iterationsUsed = 0;			// For performance tracking.
	
	/// @func	setIterations({int} iterations);
	static setIterations = function(_iterations){ iterations = _iterations; }
	
	/// @func	resolveContacts({array} contactArray, {int} numContacts, {real} dt);
	/// @desc	Resolves a set of contacts for both velocity and interpenetration.
	static resolveContacts = function(_contactArray, _numContacts, _dt)
	{
		iterationsUsed = 0;
		while (iterationsUsed < iterations)
		{
			// Find contact with largest closing velocity
			var _max = 0;
			var _maxIndex = _numContacts;
			for (var _i = 0; _i < _numContacts; _i++)
			{
				var _sepVel = _contactArray[_i].calculateSeparatingVelocity();
				if (_sepVel < _max)
				{
					_max = _sepVel;
					_maxIndex = _i;
				}
			}
			
			// Return if nothing to resolve
			if (_maxIndex == _numContacts) break;
			
			// Resolve contact
			_contactArray[_maxIndex].resolve(_dt);
			
			// Increment
			iterationsUsed++;
		}
	}
}