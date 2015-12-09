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

package box2d.dynamics;

import box2d.common.math.B2Vec2;
import box2d.common.math.B2Transform;

#if (openfl || flash || nme)
import cpp.Float32;
import cpp.Pointer;
import flash.display.Sprite;
#end

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Color')
@:structAccess
class B2Color {
	var r : Float32;
	var g : Float32;
	var b : Float32;
	var a : Float32;
	public inline function getColor() : Int {return (Std.int(r*255) << 16) | (Std.int(g*255) << 8) | (Std.int(b*255));}
	//@:native('b2Color') public static function create () : B2Color;
}

@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Draw')
extern class B2Draw {
	@:native('SetFlags') public function setFlags (flags : Int) : Int;
	@:native('GetFlags') public function getFlags () : Int;
	@:native('AppendFlags') public function appendFlags (flags : Int) : Void;

	@:native('DrawPolygon') public function drawPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color) : Void;
	@:native('DrawSolidPolygon') public function drawSolidPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color) : Void;
	@:native('DrawCircle') public function drawCircle (center : B2Vec2, radius : Float32, color : B2Color) : Void;
	@:native('DrawSolidCircle') public function drawSolidCircle(center : B2Vec2, radius : Float32, axis : B2Vec2, color : B2Color) : Void;
	@:native('DrawSegment') public function drawSegment (p1 : B2Vec2, p2 : B2Vec2, color : B2Color) : Void;
	@:native('DrawTransform') public function drawTransform (xf : B2Transform) : Void;

}

/*
@:build(linc.Linc.touch())
@:include('linc_box2d.h')
@:native('b2Draw')
class B2Draw {

}
*/
/**
* Implement and register this class with a b2World to provide debug drawing of physics
* entities in your game.
*/
class B2DebugDraw extends B2Draw {

	public function new () {
		m_drawScale = 1.0;
		m_lineThickness = 1.0;
		m_alpha = 1.0;
		m_fillAlpha = 1.0;
		m_xformScale = 1.0;
		m_drawFlags = 0;
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

	#if (openfl || flash || nme)
	/**
	* Set the sprite
	*/
	public function setSprite(sprite:Sprite) : Void {
		m_sprite = sprite;
	}

	/**
	* Get the sprite
	*/
	public function getSprite() : Sprite {
		return m_sprite;
	}
	#end

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
	override public function drawPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color) : Void {

		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		m_sprite.graphics.moveTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		for (i in 1...vertexCount) {
				m_sprite.graphics.lineTo(vertices.at(i).x * m_drawScale, vertices.at(i).y * m_drawScale);
		}
		m_sprite.graphics.lineTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		#end

	}

	/**
	* Draw a solid closed polygon provided in CCW order.
	*/
	override public function drawSolidPolygon (vertices : Pointer<B2Vec2>, vertexCount : Int, color : B2Color) : Void {
		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		m_sprite.graphics.moveTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		m_sprite.graphics.beginFill(color.getColor(), m_fillAlpha);
		for (i in 1...vertexCount) {
			m_sprite.graphics.lineTo(vertices.at(i).x * m_drawScale, vertices.at(i).y * m_drawScale);
		}
		m_sprite.graphics.lineTo(vertices.at(0).x * m_drawScale, vertices.at(0).y * m_drawScale);
		m_sprite.graphics.endFill();
		#end

	}

	/**
	* Draw a circle.
	*/
	override public function drawCircle (center:B2Vec2, radius:Float, color:B2Color) : Void {

		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		m_sprite.graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		#end

	}

	/**
	* Draw a solid circle.
	*/
	override public function drawSolidCircle (center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color) : Void {

		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		m_sprite.graphics.moveTo(0,0);
		m_sprite.graphics.beginFill(color.getColor(), m_fillAlpha);
		m_sprite.graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		m_sprite.graphics.endFill();
		m_sprite.graphics.moveTo(center.x * m_drawScale, center.y * m_drawScale);
		m_sprite.graphics.lineTo((center.x + axis.x * radius) * m_drawScale, (center.y + axis.y * radius) * m_drawScale);
		#end

	}


	/**
	* Draw a line segment.
	*/
	override public function drawSegment (p1:B2Vec2, p2:B2Vec2, color:B2Color) : Void {

		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, color.getColor(), m_alpha);
		m_sprite.graphics.moveTo(p1.x * m_drawScale, p1.y * m_drawScale);
		m_sprite.graphics.lineTo(p2.x * m_drawScale, p2.y * m_drawScale);
		#end

	}

	/**
	* Draw a transform. Choose your own length scale.
	* @param xf a transform.
	*/
	override public function drawTransform (xf:B2Transform) : Void {

		#if (openfl || flash || nme)
		m_sprite.graphics.lineStyle(m_lineThickness, 0xff0000, m_alpha);
		m_sprite.graphics.moveTo(xf.p.x * m_drawScale, xf.p.y * m_drawScale);
		m_sprite.graphics.lineTo((xf.p.x + m_xformScale /* *xf.q.col1.x*/) * m_drawScale, (xf.p.y + m_xformScale/* *xf.q.col1.y*/) * m_drawScale);

		m_sprite.graphics.lineStyle(m_lineThickness, 0x00ff00, m_alpha);
		m_sprite.graphics.moveTo(xf.p.x * m_drawScale, xf.p.y * m_drawScale);
		m_sprite.graphics.lineTo((xf.p.x + m_xformScale/* * xf.q.col2.x*/) * m_drawScale, (xf.p.y + m_xformScale/* * xf.q.col2.y*/) * m_drawScale);
		#end

	}

	private var m_drawFlags:Int;
	#if (openfl || flash || nme)
	public var m_sprite:Sprite;
	#end
	private var m_drawScale:Float;

	private var m_lineThickness:Float;
	private var m_alpha:Float;
	private var m_fillAlpha:Float;
	private var m_xformScale:Float;

}
