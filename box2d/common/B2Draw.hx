package box2d.common;

import box2d.common.math.B2Transform;
import box2d.common.math.B2Vec2;
import cpp.Float32;
import cpp.Pointer;

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Draw')
extern class B2Draw {
	@:native('SetFlags') public function setFlags (flags : Int) : Int;
	@:native('GetFlags') public function getFlags () : Int;
	@:native('AppendFlags') public function appendFlags (flags : Int) : Void;
}

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('::cpp::Reference<b2Draw>')
extern class B2DrawRef extends B2Draw {}
