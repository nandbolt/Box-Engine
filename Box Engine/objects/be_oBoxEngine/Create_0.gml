/// @desc Init Simulation

/*
Keeps track of and updates all boxes in the simulation.
*/

// World
boxes = [];											// All of the boxes in the simulation.
maxContacts = 4;									// The given number of contacts per frame the simulation can handle.
iterations = maxContacts * 2;						// The number of contact iterations used.
calculateIterations	= (iterations == 0);			// Whether the number of iterations to for contact resolver should be calculated every frame.
registry = new BEForceRegistry();					// The force registry.
resolver = new BEContactResolver(iterations);		// The contact resolver.
contactGens = [];									// The contact generators.
contacts = array_create(maxContacts, undefined);	// The list of contacts.
for (var _i = 0; _i < array_length(contacts); _i++)	// Init list of contacts.
{
	contacts[_i] = new BEContact();
}
nextContactIdx = 0;									// The current contact write position.

#region Functions

/// @func	startFrame();
/// @desc	Gets boxes ready to be processed.
startFrame = function()
{
	// Loop through boxes
	for (var _i = 0; _i < array_length(boxes); _i++)
	{
		// Clear forces
		boxes[_i].clearNetForce();
	}
}

/// @func	generateContacts();
/// @desc	Calls all registered contact generators to report their contacts. Returns number of contacts.
generateContacts = function()
{
	var _limit = maxContacts;
	
	// Init next contact
	nextContactIdx = 0;
	
	// Loop through contact generators
	for (var _i = 0; _i < array_length(contactGens); _i++)
	{
		// Add contact to contact generator (???)
		var _used = contactGens[_i].addContact(nextContactIdx, _limit);
		_limit -= _used;
		nextContactIdx += _used;
		
		// Break if ran out of contacts to fill, meaning we're missing contacts.
		if (_limit <= 0) break;
	}
	
	return maxContacts - _limit;
}

/// @func	integrate({real} dt);
/// @desc	Moves each box forward in time.
integrate = function(_dt)
{
	// Loop through boxes
	for (var _i = 0; _i < array_length(boxes); _i++)
	{
		// Integrate each box in time
		boxes[_i].integrate(_dt);
	}
}

/// @func	runPhysics({real} dt);
/// @desc	Runs a physics update on the simulation.
runPhysics = function(_dt)
{
	// Apply force generators
	registry.updateForces(_dt);
	
	// Integrate objects
	integrate(_dt);
	
	// Generate contacts
	var _usedContacts = generateContacts();
	
	// Process contacts
	if (_usedContacts > 0)
	{
		if (calculateIterations) resolver.setIterations(_usedContacts * 2);
		resolver.resolveContacts(contacts, _usedContacts, _dt);
	}
}

#endregion

// Init display
window_set_size(1280, 720);
surface_resize(application_surface, 1280, 720);

// Init scene
fgGravity = new BEGravityForceGen();
fgController = new BETopDownControllerForceGen();
cgTiles = new BETileContactGen();
inst1 = instance_create_layer(room_width * 0.3, room_height * 0.5, "Instances", be_oBoxChild);
inst2 = instance_create_layer(room_width * 0.7, room_height * 0.5, "Instances", be_oBoxChild);
array_push(boxes, inst1.box);
array_push(boxes, inst2.box);
registry.add(inst1.box, fgController);
registry.add(inst2.box, fgGravity);
array_push(contactGens, cgTiles);