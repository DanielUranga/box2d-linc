package box2d.dynamics;

import box2d.common.B2Math.B2Vec2;
import cpp.Float32;

@:enum
abstract B2BodyType(Int)
from Int to Int {
	var b2_staticBody = 0;
	var b2_kinematicBody = 1;
	var b2_dynamicBody = 2;
}

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:keep
@:native('::cpp::Struct<b2BodyDef>')
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
	@:native('b2BodyDef') public static function create () : B2BodyDef;
}
