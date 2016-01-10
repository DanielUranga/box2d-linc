package;

import box2d.collision.shapes.B2PolygonShape;
import box2d.common.math.B2Vec2;
import box2d.dynamics.B2Body;
import box2d.dynamics.B2Fixture;
import box2d.dynamics.B2World;

// Example based on https://github.com/erincatto/Box2D/blob/master/Box2D/HelloWorld/HelloWorld.cpp
class Main {

	public static function main () {
		
		var gravity = B2Vec2.create(0.0, -10.0);
		var world = B2World.create(gravity);

		var groundBodyDef = B2BodyDef.create();
		groundBodyDef.position.set(0.0, -10.0);
		
		var groundBody = world.createBody(groundBodyDef.getPointer());

		var groundBox = B2PolygonShape.create();
		groundBox.setAsBox(50.0, 10.0);

		groundBody.createFixtureFromShape(groundBox.getB2ShapeReference(), 0.0);

		var bodyDef = B2BodyDef.create();
		bodyDef.type = B2BodyType.b2_dynamicBody();
		bodyDef.position.set(0.0, 4.0);

		var body = world.createBody(bodyDef.getPointer());
		var dynamicBox = B2PolygonShape.create();
		dynamicBox.setAsBox(1.0, 1.0);

		var fixtureDef = B2FixtureDef.create();
		fixtureDef.shape = dynamicBox.getB2ShapeReference();
		fixtureDef.density = 1.0;
		fixtureDef.friction = 1.0;

		body.createFixture(fixtureDef.getReference());

		var timeStep = 1.0/60.0;
		var velocityIterations = 6;
		var positionIterations = 2;

		for (i in 0...60) {
			world.step(timeStep, velocityIterations, positionIterations);
			var position = body.getPosition();
			var angle = body.getAngle();
			trace(position.x + " " + position.y + " " + angle);
		}

		world.delete();

	}

}
