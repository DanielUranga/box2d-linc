package box2d.common;

import cpp.Float32;

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Color')
@:structAccess
extern class B2Color {
	var r : Float32;
	var g : Float32;
	var b : Float32;
	var a : Float32;
	public inline function getColor() : Int {return (Std.int(r*255) << 16) | (Std.int(g*255) << 8) | (Std.int(b*255));}
}

@:native('::cpp::Reference<b2Color>')
extern class B2ColorRef extends B2Color {}
