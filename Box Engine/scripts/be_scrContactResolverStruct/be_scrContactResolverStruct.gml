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
	static resolveContacts = function(_contactArray, _numContacts, _dt){}
}