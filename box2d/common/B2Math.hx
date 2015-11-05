package box2d.common;

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:keep
@:native('::cpp::Struct<b2Vec2>')
extern class B2Vec2 {
	var x : Float;
	var y : Float;
	@:native('b2Vec2') public static function create (x : Float, y : Float) : B2Vec2;
	@:native("Length") public function length() : Float;
}

class B2Math {}
