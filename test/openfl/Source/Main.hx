package;

import box2d.collision.shapes.B2PolygonShape;
import box2d.collision.shapes.B2Shape;
import box2d.common.math.B2Vec2;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2Fixture;
import box2d.dynamics.B2World;
import cpp.Float32;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Sprite;

class Main extends Sprite {

	var world : B2WorldRef;
	var body : B2BodyRef;
	var groundBody : B2BodyRef;

	var groundSpr : Sprite;
	var bodySpr : Sprite;

	public function new () {

		super ();
		// Define the gravity vector.
		var gravity = B2Vec2.create(0.0, -5.0);

		// Construct a world object, which will hold and simulate the rigid bodies.
		world = B2World.create(gravity);
		// Define the ground body.
		var groundBodyDef = B2BodyDef.create();
		groundBodyDef.position.set(0.0, -10.0);

		// Call the body factory which allocates memory for the ground body
		// from a pool and creates the ground box shape (also from a pool).
		// The body is also added to the world.
		groundBody = world.createBody(groundBodyDef.getReference());
		// Define the ground box shape.
		var groundBox = B2PolygonShape.create();

		// The extents are the half-widths of the box.
		groundBox.setAsBox(150.0, 10.0);

		// Add the ground fixture to the ground body.
		groundBody.createFixtureFromShape(groundBox.getB2ShapeReference(), 0.0);

		// Define the dynamic body. We set its position and call the body factory.
		var bodyDef = B2BodyDef.create();
		bodyDef.type = B2BodyType.b2_dynamicBody();
		bodyDef.position.set(8.0, 10.0);
		body = world.createBody(bodyDef.getReference());

		// Define another box shape for our dynamic body.
		var dynamicBox = B2PolygonShape.create();
		dynamicBox.setAsBox(1.0, 1.0);

		bodySpr = new Sprite();
		var inner = new Sprite();
		var gfx = inner.graphics;
		gfx.beginFill(0xff0000);
		gfx.drawRect(0, 0, 1.0*50.0, 1.0*50.0);
		gfx.endFill();
		inner.x = -bodySpr.width/2;
		inner.y = -bodySpr.height/2;
		bodySpr.addChild(inner);
		addChild(bodySpr);

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

		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);

	}

	static function formatFloat (f : Float32) : String {
		return Std.string(Std.int(f*100) / 100);
	}

	function onEnterFrame (_) {
		// Prepare for simulation. Typically we use a time step of 1/60 of a
		// second (60Hz) and 10 iterations. This provides a high quality simulation
		// in most game scenarios.
		var timeStep = 1.0 / 60.0;
		var velocityIterations = 6;
		var positionIterations = 2;

		// Instruct the world to perform a single step of simulation.
		// It is generally best to keep the time step and iterations fixed.
		world.step(timeStep, velocityIterations, positionIterations);

		// Now print the position and angle of the body.
		var position =  body.getPosition();
		var angle = body.getAngle()/Math.PI*180;

		bodySpr.x = Lib.current.stage.stageWidth - position.x * 50.0;
		bodySpr.y = Lib.current.stage.stageHeight - position.y * 50.0;
		bodySpr.rotation = angle;
		//setSpriteRotation(bodySpr, angle);

		trace(formatFloat(position.x) + " " + formatFloat(position.y) + " " + formatFloat(angle));
	}

}