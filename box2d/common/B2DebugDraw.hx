
/*
* Copyright (c) 2015 Daniel Uranga
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

package box2d.common;

import box2d.common.math.B2Transform.B2TransformRef;
import box2d.common.math.B2Vec2;
import box2d.common.math.B2Vec2.B2Vec2Ref;
import cpp.Float32;
import cpp.Pointer;

import flash.display.Sprite;

/**
* Implement and register this class with a b2World to provide debug drawing of physics
* entities in your game.
*/
@:cppInclude('./B2DebugDrawNative.cpp')
@:include('linc_box2d.h')
class B2DebugDraw extends Sprite {

	public var nativeRef : B2Draw.B2DrawRef;

	public function new () {
		super();
		m_drawScale = 1.0;
		m_lineThickness = 1.0;
		m_alpha = 1.0;
		m_fillAlpha = 1.0;
		m_xformScale = 1.0;
		m_drawFlags = 0;
		nativeRef = untyped __cpp__("new B2DebugDrawNative(this)");
	}

	//virtual ~b2DebugDraw() {}

	//enum
	//{
	/** Draw shapes */
	static public var e_shapeBit:Int 			= 0x0001;
	/** Draw joint connections */
	static public var e_jointBit:Int			= 0x0002;
	/** Draw axis aligned bounding boxes */
	static public var e_aabbBit:Int			= 0x0004;
	/** Draw broad-phase pairs */
	static public var e_pairBit:Int			= 0x0008;
	/** Draw center of mass frame */
	static public var e_centerOfMassBit:Int	= 0x0010;
	/** Draw controllers */
	static public var e_controllerBit:Int		= 0x0020;
	//};

	public function setFlags (flags : Int) : Void {
		nativeRef.setFlags(flags);
	}

	/**
	* Set the draw scale
	*/
	public function setDrawScale(drawScale:Float) : Void {
		m_drawScale = drawScale;
	}

	/**
	* Get the draw
	*/
	public function getDrawScale() : Float {
		return m_drawScale;
	}


	/**
	* Set the line thickness
	*/
	public function setLineThickness(lineThickness:Float) : Void {
		m_lineThickness = lineThickness;
	}

	/**
	* Get the line thickness
	*/
	public function getLineThickness() : Float {
		return m_lineThickness;
	}

	/**
	* Set the alpha value used for lines
	*/
	public function setAlpha(alpha:Float) : Void {
		m_alpha = alpha;
	}

	/**
	* Get the alpha value used for lines
	*/
	public function getAlpha() : Float {
		return m_alpha;
	}

	/**
	* Set the alpha value used for fills
	*/
	public function setFillAlpha(alpha:Float) : Void {
		m_fillAlpha = alpha;
	}

	/**
	* Get the alpha value used for fills
	*/
	public function getFillAlpha() : Float {
		return m_fillAlpha;
	}

	/**
	* Set the scale used for drawing XForms
	*/
	public function setXFormScale(xformScale:Float) : Void {
		m_xformScale = xformScale;
	}

	/**
	* Get the scale used for drawing XForms
	*/
	public function getXFormScale() : Float {
		return m_xformScale;
	}

	/**
	* Draw a closed polygon provided in CCW order.
	*/
	public function drawPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color.B2ColorRef) : Void {
		//trace("drawPolygon");
		graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		graphics.moveTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		for (i in 1...vertexCount) {
				graphics.lineTo(vertices.at(i).x * m_drawScale, vertices.at(i).y * m_drawScale);
		}
		graphics.lineTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
	}

	/**
	* Draw a solid closed polygon provided in CCW order.
	*/
	public function drawSolidPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color.B2ColorRef) : Void {
		//trace("drawSolidPolygon " + Std.random(1000));
		graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		graphics.moveTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		graphics.beginFill(color.getColor(), m_fillAlpha);
		for (i in 1...vertexCount) {
			graphics.lineTo(vertices.at(i).x * m_drawScale, vertices.at(i).y * m_drawScale);
		}
		graphics.lineTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		graphics.endFill();
	}

	/**
	* Draw a circle.
	*/
	public function drawCircle (center:B2Vec2Ref, radius:Float, color:B2Color.B2ColorRef) : Void {
		graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
	}

	/**
	* Draw a solid circle.
	*/
	public function drawSolidCircle (center:B2Vec2Ref, radius:Float, axis:B2Vec2Ref, color:B2Color.B2ColorRef) : Void {
		graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		graphics.moveTo(0,0);
		graphics.beginFill(color.getColor(), m_fillAlpha);
		graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		graphics.endFill();
		graphics.moveTo(center.x * m_drawScale, center.y * m_drawScale);
		graphics.lineTo((center.x + axis.x * radius) * m_drawScale, (center.y + axis.y * radius) * m_drawScale);
	}


	/**
	* Draw a line segment.
	*/
	public function drawSegment (p1:B2Vec2Ref, p2:B2Vec2Ref, color:B2Color.B2ColorRef) : Void {
		graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		graphics.moveTo(p1.x * m_drawScale, p1.y * m_drawScale);
		graphics.lineTo(p2.x * m_drawScale, p2.y * m_drawScale);
	}

	/**
	* Draw a transform. Choose your own length scale.
	* @param xf a transform.
	*/
	public function drawTransform (xf:B2TransformRef) : Void {
		graphics.lineStyle(m_lineThickness, 0xff0000, m_alpha);
		graphics.moveTo(xf.p.x * m_drawScale, xf.p.y * m_drawScale);
		graphics.lineTo((xf.p.x + m_xformScale /* *xf.q.col1.x*/) * m_drawScale, (xf.p.y + m_xformScale/* *xf.q.col1.y*/) * m_drawScale);

		graphics.lineStyle(m_lineThickness, 0x00ff00, m_alpha);
		graphics.moveTo(xf.p.x * m_drawScale, xf.p.y * m_drawScale);
		graphics.lineTo((xf.p.x + m_xformScale/* * xf.q.col2.x*/) * m_drawScale, (xf.p.y + m_xformScale/* * xf.q.col2.y*/) * m_drawScale);
	}

	private var m_drawFlags:Int;
	public var m_sprite:Sprite;
	private var m_drawScale:Float;

	private var m_lineThickness:Float;
	private var m_alpha:Float;
	private var m_fillAlpha:Float;
	private var m_xformScale:Float;

}
