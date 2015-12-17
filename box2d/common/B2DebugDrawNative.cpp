#include "Box2D/Box2D.h"

class B2DebugDrawNative : public b2Draw {
public:

	box2d::common::B2DebugDraw haxeDelegate;

	B2DebugDrawNative(box2d::common::B2DebugDraw inHandle) {
		haxeDelegate = inHandle;
		GCAddRoot((hx::Object **)&(haxeDelegate.mPtr));
	}

	~B2DebugDrawNative() {
		GCRemoveRoot((hx::Object**)&(haxeDelegate.mPtr));
	}

	void DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) override {
		haxeDelegate->drawPolygon(vertices, vertexCount, &color);
	}

	void DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color) override {
		haxeDelegate->drawSolidPolygon(vertices, vertexCount, &color);
	}

	void DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color) override {
		haxeDelegate->drawCircle(&center, radius, &color);
	}

	void DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color) override {

	}

	void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) override {
		haxeDelegate->drawSegment(&p1, &p2, &color);
	}

	void DrawTransform(const b2Transform& xf) override {
		haxeDelegate->drawTransform(&xf);
	}

};
