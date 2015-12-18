package box2d.collision.shapes;

import cpp.Pointer;

@:include('linc_box2d.h')
@:native('b2PolygonShape')
extern class B2PolygonShape extends B2Shape {
	@:native('new b2PolygonShape') static function create () : B2PolygonShapeRef;
	@:native('~b2PolygonShape') function delete () : Void;
	@:native('SetAsBox') function setAsBox (hx : Float, hy : Float) : Void;
}

@:include('linc_box2d.h')
@:native('::cpp::Reference<b2PolygonShape>')
extern class B2PolygonShapeRef extends B2PolygonShape {
	public inline function getB2ShapeReference () : Pointer<B2Shape> {
		return cast this;
	}
}
