package;

import box2d.collision.shapes.B2PolygonShape;
import box2d.collision.shapes.B2Shape;
import box2d.common.B2Math;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2Fixture.B2FixtureDef;
import box2d.dynamics.B2World;
import cpp.Float32;
import cpp.Pointer;

class Test {

	static function formatFloat (f : Float32) : String {
		return Std.string(Std.int(f*100) / 100);
	}

	static function main() {

		// Define the gravity vector.
		var gravity = B2Vec2.create(0.0, -10.0);

		// Construct a world object, which will hold and simulate the rigid bodies.
		var world = B2World.create(gravity);
		// Define the ground body.
		var groundBodyDef = B2BodyDef.create();
		groundBodyDef.position.set(0.0, -10.0);

		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		var groundBody = world.createBody(groundBodyDef.getReference());
		// Define the ground box shape.
		var groundBox = B2PolygonShape.create();

		// The extents are the half-widths of the box.
		groundBox.setAsBox(50.0, 10.0);

		// Add the ground fixture to the ground body.
		groundBody.createFixtureFromShape(groundBox.getB2ShapeReference(), 0.0);

		// Define the dynamic body. We set its position and call the body factory.
		var bodyDef = B2BodyDef.create();
		bodyDef.type = B2BodyType.b2_dynamicBody();
		bodyDef.position.set(0.0, 4.0);
		var body = world.createBody(bodyDef.getReference());

		// Define another box shape for our dynamic body.
		var dynamicBox = B2PolygonShape.create();
		dynamicBox.setAsBox(1.0, 1.0);

		// Define the dynamic body fixture.
		var fixtureDef = B2FixtureDef.create();
		fixtureDef.shape = dynamicBox.getB2ShapeReference();

		// Set the box density to be non-zero, so it will be dynamic.
		fixtureDef.density = 1.0;

		// Override the default friction.
		fixtureDef.friction = 0.3;

		// Add the shape to the body.
		body.createFixture(fixtureDef.getReference());

		// Prepare for simulation. Typically we use a time step of 1/60 of a
		// second (60Hz) and 10 iterations. This provides a high quality simulation
		// in most game scenarios.
		var timeStep = 1.0 / 60.0;
		var velocityIterations = 6;
		var positionIterations = 2;

		// This is our little game loop.
		for (i in 0...60) {
			// Instruct the world to perform a single step of simulation.
			// It is generally best to keep the time step and iterations fixed.
			world.step(timeStep, velocityIterations, positionIterations);

			// Now print the position and angle of the body.
			var position = body.getPosition();
			var angle = body.getAngle();

			trace(formatFloat(position.x) + " " + formatFloat(position.y) + " " + formatFloat(angle));
		}

		// When the world destructor is called, all bodies and joints are freed. This can
		// create orphaned pointers, so be careful about your world management.
		groundBox.delete();
		dynamicBox.delete();
		world.delete();

		return 0;
	}

}
