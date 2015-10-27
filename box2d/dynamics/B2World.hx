package box2d.dynamics;

import box2d.common.B2Math.B2Vec2;

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:keep
@:native('b2World')
extern class B2World {
	@:native('b2World') public static function create (gravity : B2Vec2) : B2World;
}
