package box2d.dynamics;


@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:native('b2Fixture')
class B2Fixture {

}

@:build(linc.Linc.touch())
@:build(linc.Linc.xml('box2d', '../../'))
@:include('linc_box2d.h')
@:native('::cpp::Reference<b2Fixture>')
extern class B2FixtureRef extends B2Fixture {}
