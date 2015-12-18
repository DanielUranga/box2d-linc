package box2d.collision.shapes;

import cpp.Pointer;

@:include('linc_box2d.h')
@:native('b2Shape')
extern class B2Shape {}

@:include('linc_box2d.h')
@:native('::cpp::Reference<b2Shape>')
extern class B2ShapeRef extends B2Shape {}
