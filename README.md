# Box Engine
 A simple physics engine for GameMaker Studio 2 with essentially the scope of being able to have a box push another box around (without any rotations at play). This engine would not have been possible without the book "Game Physics: Engine Development" by Ian Millington. It covers the topic of creating a rigid-body, iterative, impulse-based physics engine in C++. I've used the general architecture and ideas in the book to convert what I felt was necessary in it to get it working in GameMaker Studio 2 LTS. The original physics engine discussed in the book (known as the Cyclone Engine, where the original C++ source code can be viewed here: https://github.com/idmillington/cyclone-physics/tree/master) is much more complex than what I intended to implement, which included fully rotating rigid bodies with a custom collision detection system.
 
 Since I only had the goal to push boxes (without worrying about rotations), I only implemented particles (as point-masses) rather than rigid bodies and assumed only rectangular bounding boxes around said particles. Chronologically, I implemented Vector2s which'll represent the various vectors, particles (called boxes in the engine) which represents the physical object in the simulation, force generators which apply forces to said boxes, the force registry which applies a given force generator to its corresponding box, a contact struct that holds data about a given collision, a contact generator which generates said contact data, and a contact resolver which uses the contact data to resolve collisions. I decided to use GameMaker's built-in collision detection system for many of the contact generators which is why boxes are both a struct and have an object associated with them that has the sprite data used for collision detection.

To use the engine, you can import/export it into a project as a local package (Tools/Import Local Package). Every asset has be_ as a prefix to prevent naming conflicts. Then, create an instance of the be_oBoxEngine object into any room you'd like a physics simulation in. This houses an array of all of the boxes in the simulation and all of the other code required to run the simulation. You can then at any time add a box into the boxes array, add any force generators you'd like to the registry and register them to any boxes you'd like and lastly add any contact generators you'd like. To add to the engine, you can create new force generators by creating a new struct that inherits from it as well as new contact generators that inherit from it as well. For forces, some that are included are gravity, springs, and a top down controller. For contacts, some that are included are a tile collisions and box collisions.

Feel free to use the engine for your game, although I'd probably recommend using GameMaker's built-in engine though. Unless you really want to customize your own physics engine or see a way of creating something that resembles a physics engine in GameMaker. I for one did not expect collision resolution to be as difficult as it was to implement...
