package box2d.common.math;

import cpp.Float32;

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Transform')
@:structAccess
extern class B2Transform {
	var p : B2Vec2;
	var q : B2Rot;
	@:native('b2Transform') public static function create () : B2Transform;
}

@:native('::cpp::Reference<b2Transform>')
extern class B2TransformRef extends B2Transform {}
