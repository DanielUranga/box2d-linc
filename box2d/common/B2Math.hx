package box2d.common;

import cpp.Float32;

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Vec2')
@:structAccess
extern class B2Vec2 {
	var x : Float32;
	var y : Float32;
	@:native('b2Vec2') public static function create (x : Float32, y : Float32) : B2Vec2;
	@:native('Length') public function length () : Float32;
	@:native('Set') public function set (x : Float32, y : Float32) : Void;
}

class B2Math {}
