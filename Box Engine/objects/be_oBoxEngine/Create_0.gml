/// @desc Init Simulation

/*
Keeps track of and updates all boxes in the simulation.
*/

// World
boxes = [];							// All of the boxes in the simulation.
registry = new BEForceRegistry();	// The force registry.
maxContacts = 4;					// The given number of contacts per frame the simulation can handle.
iterations = maxContacts * 2;		// The number of contact iterations used.

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
	return 1;
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
}

#endregion

// Init display
window_set_size(1280, 720);
surface_resize(application_surface, 1280, 720);

// Init scene
fgGravity1 = new BEGravityForceGen(500, 0);
fgGravity2 = new BEGravityForceGen(-500, 0);
inst1 = instance_create_layer(room_width * 0.3, room_height * 0.5, "Instances", be_oBoxChild);
inst2 = instance_create_layer(room_width * 0.7, room_height * 0.5, "Instances", be_oBoxChild);
array_push(boxes, inst1.box);
array_push(boxes, inst2.box);
registry.add(inst1.box, fgGravity1);
registry.add(inst2.box, fgGravity2);