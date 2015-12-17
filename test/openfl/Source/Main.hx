package;

import box2d.collision.shapes.B2PolygonShape;
import box2d.collision.shapes.B2Shape;
import box2d.common.math.B2Vec2;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2Fixture;
import box2d.dynamics.B2World;
import box2d.common.B2Draw;
import box2d.common.B2DebugDraw;
import cpp.Float32;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Sprite;

class Main extends Sprite {

	var world : B2WorldRef;
	var body : B2BodyRef;
	var groundBody : B2BodyRef;

	var debugDraw : B2DebugDraw;

	public function new () {

		super ();
		// Define the gravity vector.
		var gravity = B2Vec2.create(0.0, 50.0);

		// Construct a world object, which will hold and simulate the rigid bodies.
		world = B2World.create(gravity);
		// Define the ground body.
		var groundBodyDef = B2BodyDef.create();
		groundBodyDef.position.set(Lib.current.stage.stageWidth/2, Lib.current.stage.stageHeight - 5.0);

		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		groundBody = world.createBody(groundBodyDef.getPointer());
		// Define the ground box shape.
		var groundBox = B2PolygonShape.create();

		// The extents are the half-widths of the box.
		groundBox.setAsBox(Lib.current.stage.stageWidth, 10.0);

		// Add the ground fixture to the ground body.
		groundBody.createFixtureFromShape(groundBox.getB2ShapeReference(), 0.0);

		// Define the dynamic body. We set its position and call the body factory.
		var bodyDef = B2BodyDef.create();
		bodyDef.type = B2BodyType.b2_dynamicBody();
		bodyDef.position.set(100.0, 25.0);
		bodyDef.angularVelocity = 20.0;
		body = world.createBody(bodyDef.getPointer());

		// Define another box shape for our dynamic body.
		var dynamicBox = B2PolygonShape.create();
		dynamicBox.setAsBox(20.0, 20.0);

		// Define the dynamic body fixture.
		var fixtureDef = B2FixtureDef.create();
		fixtureDef.shape = dynamicBox.getB2ShapeReference();

		// Set the box density to be non-zero, so it will be dynamic.
		fixtureDef.density = 1.0;

		// Override the default friction.
		fixtureDef.friction = 0.3;

		fixtureDef.restitution = 0.5;

		// Add the shape to the body.
		body.createFixture(fixtureDef.getReference());

		debugDraw = new B2DebugDraw();
		debugDraw.setFlags(1|2|4|8|10|20);

		addChild(debugDraw);

		world.setDebugDraw(debugDraw.nativeRef);

		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		var fps = new openfl.display.FPS(10.0, 10.0, 0xff0000);
		addChild(fps);
	}

	static function formatFloat (f : Float32) : String {
		return Std.string(Std.int(f*100) / 100);
	}

	function onEnterFrame (_) {
		// Prepare for simulation. Typically we use a time step of 1/60 of a
		// second (60Hz) and 10 iterations. This provides a high quality simulation
		// in most game scenarios.
		var timeStep = 1.0 / 60.0;
		var velocityIterations = 10;
		var positionIterations = 3;

		// Instruct the world to perform a single step of simulation.
		// It is generally best to keep the time step and iterations fixed.
		world.step(timeStep, velocityIterations, positionIterations);

		debugDraw.graphics.clear();
		world.drawDebugData();

	}

}