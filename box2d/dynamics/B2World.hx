package box2d.dynamics;

import box2d.common.B2Math.B2Vec2;

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:keep
extern class B2World {
	@:native('new b2World') public static function create (gravity : B2Vec2) : B2WorldRef;
	@:native('~b2World') public function delete() : Void;
	@:native('GetGravity') public function getGravity() : B2Vec2;
}

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:keep
@:native('::cpp::Reference<b2World>')
extern class B2WorldRef extends B2World {}
