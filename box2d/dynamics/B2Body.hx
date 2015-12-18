package box2d.dynamics;

import box2d.collision.shapes.B2Shape;
import box2d.common.math.B2Vec2;
import cpp.Float32;
import cpp.Pointer;

extern class B2BodyType {
	public static inline function b2_staticBody () : B2BodyType return untyped __cpp__('b2_staticBody');
	public static inline function b2_kinematicBody () : B2BodyType return untyped __cpp__('b2_kinematicBody');
	public static inline function b2_dynamicBody () : B2BodyType return untyped __cpp__('b2_dynamicBody');
}

@:include('linc_box2d.h')
@:native('b2BodyDef')
@:structAccess
extern class B2BodyDef {
	var type : B2BodyType;
	var position : B2Vec2;
	var linearVelocity : B2Vec2;
	var angle : Float32;
	var angularVelocity : Float32;
	var linearDamping : Float32;
	var angularDamping : Float32;
	var allowSleep : Bool;
	var awake : Bool;
	var fixedRotation : Bool;
	var bullet : Bool;
	var active : Bool;
	var gravityScale : Float32;
	@:native('b2BodyDef') static function create () : B2BodyDef;
	inline function getPointer () : Pointer<B2BodyDef> return Pointer.addressOf(this);
}

@:include('linc_box2d.h')
@:native('b2Body')
extern class B2Body {
	@:native('CreateFixture') function createFixture (def : Pointer<B2Fixture.B2FixtureDef>) : B2Fixture.B2FixtureRef;
	@:native('CreateFixture') function createFixtureFromShape (shape : Pointer<B2Shape>, density : Float32) : B2Fixture.B2FixtureRef;
	@:native('GetLocalCenter') function getLocalCenter () : B2Vec2;
	@:native('GetPosition') function getPosition () : B2Vec2;
	@:native('GetAngle') function getAngle () : Float32;
}

@:include('linc_box2d.h')
@:native('::cpp::Reference<b2Body>')
extern class B2BodyRef extends B2Body {}
