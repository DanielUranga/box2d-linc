package box2d.collision.shapes;

import box2d.common.math.B2Vec2;
import cpp.Pointer;

@:include('linc_box2d.h')
@:native('b2EdgeShape')
extern class B2EdgeShape extends B2Shape {
	@:native('new b2EdgeShape') static function create () : B2EdgeShapeRef;
	@:native('Set') function set (v1 : B2Vec2, v2 : B2Vec2) : Void;
	@:native('~b2EdgeShape') function delete () : Void;
}

@:include('linc_box2d.h')
@:native('::cpp::Reference<b2EdgeShape>')
extern class B2EdgeShapeRef extends B2EdgeShape {
	public inline function getB2ShapeReference () : Pointer<B2Shape> {
		var t = this;
		return untyped __cpp__("((::cpp::Pointer< b2Shape >)((b2Shape*)t))");
	}
}
