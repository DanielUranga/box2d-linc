package box2d.collision.shapes;

import cpp.Pointer;

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2PolygonShape')
extern class B2PolygonShape extends B2Shape {
	@:native('new b2PolygonShape') public static function create () : B2PolygonShapeRef;
	@:native('~b2PolygonShape') public function delete () : Void;
	@:native('SetAsBox') public function setAsBox (hx : Float, hy : Float) : Void;
}

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('::cpp::Reference<b2PolygonShape>')
extern class B2PolygonShapeRef extends B2PolygonShape {
	public inline function getB2ShapeReference () : Pointer<B2Shape> {
		return cast this;
	}
}
