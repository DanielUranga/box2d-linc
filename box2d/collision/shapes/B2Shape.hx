package box2d.collision.shapes;

import cpp.Pointer;

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../../'))
@:include('linc_box2d.h')
@:native('b2Shape')
extern class B2Shape {
	public inline function getB2ShapeReference () : Pointer<B2Shape> {
		return Pointer.addressOf(this);
	}
}

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../../'))
@:include('linc_box2d.h')
@:native('::cpp::Reference<b2Shape>')
extern class B2ShapeRef extends B2Shape {}
