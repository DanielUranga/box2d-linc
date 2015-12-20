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
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.display.Sprite;

class Main extends Sprite {

	var world : B2WorldRef;
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
		var groundBody = world.createBody(groundBodyDef.getPointer());
		// Define the ground box shape.
		var groundBox = B2PolygonShape.create();

		// The extents are the half-widths of the box.
		groundBox.setAsBox(Lib.current.stage.stageWidth*2, 10.0);

		// Add the ground fixture to the ground body.
		groundBody.createFixtureFromShape(groundBox.getB2ShapeReference(), 0.0);

		debugDraw = new B2DebugDraw();
		debugDraw.setFlags(1);

		addChild(debugDraw);

		world.setDebugDraw(debugDraw.nativeRef);

		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		var fps = new openfl.display.FPS(10.0, 10.0, 0xff0000);
		addChild(fps);

		var text = new TextField();
		var format = new TextFormat();
		format.size = 20;
		format.font = "Arial";
		format.color = 0x558855;
		text.autoSize = TextFieldAutoSize.LEFT;
		text.selectable = false;
		text.text = "Start clicking to add boxes.";
		text.setTextFormat(format);
		text.x = Lib.current.stage.stageWidth/2 - text.width/2;
		text.y = Lib.current.stage.stageHeight/2 - text.height/2;
		addChild(text);

		Lib.current.stage.addEventListener(MouseEvent.CLICK, function (m : MouseEvent) addBox(m.stageX, m.stageY));

	}

	function addBox (x : Float, y : Float) {
		// Define the dynamic body. We set its position and call the body factory.
		var bodyDef = B2BodyDef.create();
		bodyDef.type = B2BodyType.b2_dynamicBody();
		bodyDef.position.set(x, y);
		bodyDef.angularVelocity = Math.random()*20.0-10.0;
		var body = world.createBody(bodyDef.getPointer());

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