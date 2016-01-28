package box2d.common.math;

import cpp.Float32;

@:include('linc_box2d.h')
@:native('b2Vec2')
@:structAccess
extern class B2Vec2 {
	var x : Float32;
	var y : Float32;
	@:native('b2Vec2') static function create (x : Float32, y : Float32) : B2Vec2;
	@:native('Length') function length () : Float32;
	@:native('Set') function set (x : Float32, y : Float32) : Void;
	inline function add (v : B2Vec2) : Void { this.x += v.x; this.y += v.y; };
	inline function assign (v : B2Vec2) : Void { this.x = v.x; this.y = v.y; };
}

@:native('::cpp::Reference<b2Vec2>')
extern class B2Vec2Ref extends B2Vec2 {}
