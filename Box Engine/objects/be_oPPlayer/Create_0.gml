// Inherit the parent event
event_inherited();

// Add to box engine
fgController = new BEPlatformerControllerForceGen();
with (be_oBoxEngine)
{
	array_push(boxes, other.box);
	registry.add(other.box, other.fgController);
	registry.add(other.box, be_oPWorld.fgGravity);
}