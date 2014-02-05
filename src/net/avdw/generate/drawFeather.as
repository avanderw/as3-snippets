package net.avdw.generate
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.avdw.graphics.drawBezierSegment;
	import net.avdw.graphics.drawPoint;
	import net.avdw.interp.*;
	import net.avdw.math.Vec2;
	import net.avdw.number.SeededOffsetRNG;
	import net.avdw.number.SeededRNG;
	import fl.motion.BezierSegment;
	
	/**
	 * http://www.openprocessing.org/sketch/20673#
	 *
	 * @param	startPoint
	 * @param	endPoint
	 * @param	featherType
	 * @param	color
	 * @param	maxBarbLength
	 */
	public function drawFeather(graphics:Graphics, startPoint:Point, endPoint:Point, featherType:Number, color:uint = 0xFFFFFF, maxBarbLength:int = 100):void
	{
		var rotateBy:Number = 0;
		var addAngle:Number = 0;
		var barbCurviness:Number = 1;
		var barbLengthModifier:Number = 1;
		graphics.clear();
		var alpha:Number = .2;
		graphics.lineStyle(1, color, alpha);
		
		var featherHeight:int = endPoint.subtract(startPoint).length;
		var rachisBasePoint:Vec2 = new Vec2(startPoint.x, startPoint.y);
		var rachisEndPoint:Vec2 = new Vec2(endPoint.x, endPoint.y);
		var rachisEndControl:Vec2 = rachisEndPoint.lerp(rachisBasePoint, .33);
		var rachisBaseControl:Vec2 = rachisBasePoint.lerp(rachisEndPoint, .33);
		
		var rachisVector:Vec2 = rachisEndPoint.sub(rachisBasePoint);
		var rachisNormal:Vec2 = SeededRNG.boolean() ? rachisVector.normalLeft() : rachisVector.normalRight();
		rachisNormal.normalizeSelf().scaleSelf(maxBarbLength * .5).addSelf(rachisEndPoint);
		rachisEndPoint.lerpSelf(rachisNormal, SeededRNG.float(1));
		
		var rachis:BezierSegment = new BezierSegment(rachisBasePoint.point, rachisBaseControl.point, rachisEndControl.point, rachisEndPoint.point);
		
		var barbBase:Vec2 = new Vec2(maxBarbLength * .03, 0);
		var barbBaseControl:Vec2 = new Vec2(maxBarbLength * .25, -maxBarbLength * .25);
		var barbEndControl:Vec2 = new Vec2(maxBarbLength * .75, maxBarbLength * .25);
		var barbEnd:Vec2 = new Vec2(maxBarbLength, 0);
		
		var startAngle:Number = Math.PI / 12;
		for (var barbCount:int = 0; barbCount < featherHeight; barbCount++)
		{
			var barbInterpPoint:Number = barbCount / featherHeight;
			var barbulePoint:Point = rachis.getValue(barbInterpPoint);
			var barbuleVector:Vec2 = new Vec2(barbulePoint.x, barbulePoint.y);
			
			barbLengthModifier = (barbLengthModifier + 1 - backEaseIn(barbInterpPoint) * .3) / 2;
			barbCurviness = (barbCurviness + 1 - expoEaseIn(barbInterpPoint)) / 2;
			
			addAngle = (addAngle + -Math.PI / 4 * SeededRNG.float(1) * featherType * (1 - barbInterpPoint)) / 2;
			rotateBy = (rotateBy + -((Math.PI / 2 - startAngle) * barbInterpPoint + startAngle + addAngle)) / 2;
			
			barbBaseControl.y = (barbBaseControl.y + -maxBarbLength * .25 + SeededRNG.sign() * SeededRNG.integer(20, 41) * (1 - expoEaseOut(barbInterpPoint)) * expoEaseOut(featherType)) / 2;
			barbEndControl.y = (barbEndControl.y + maxBarbLength * .25 + SeededRNG.sign() * SeededRNG.integer(20, 41) * expoEaseOut(featherType) * (1 - expoEaseOut(barbInterpPoint))) / 2;
			barbEnd.y = (barbEnd.y + SeededRNG.sign() * SeededRNG.integer(30, 61) * (1 - expoEaseOut(barbInterpPoint)) * expoEaseOut(featherType)) / 2;
			
			if (SeededRNG.boolean(barbInterpPoint))
			{ // higher chance towards the top
				barbLengthModifier += SeededRNG.float(-.01, .01);
			}
			else
			{ // higher chance towards the bottom
				barbLengthModifier += SeededRNG.float(-.4, 0) * (1 - backEaseOut(barbInterpPoint));
				rotateBy += SeededRNG.float(-.4, .4) * (1 - backEaseOut(barbInterpPoint));
				barbEnd.y += SeededRNG.float(-10, 0) * featherType;
			}
			
			if (SeededRNG.boolean(featherType))
			{ // higher chance towards right
				//barbLengthModifier += SeededRNG.float( -.01, .01);
				rotateBy += SeededRNG.float(-.4, 0) * featherType;
				barbBaseControl.y += SeededRNG.float(-40, 40) * featherType;
				barbEndControl.y += SeededRNG.float(-40, 40) * featherType;
				barbEnd.y += SeededRNG.float(-40, 40) * featherType;
				barbEndControl.x += SeededRNG.float(-maxBarbLength * .1, maxBarbLength * .1) * featherType * (1 - backEaseOut(barbInterpPoint));
				barbBaseControl.x += SeededRNG.float(-maxBarbLength * .1, maxBarbLength * .1) * featherType * (1 - backEaseOut(barbInterpPoint));
			}
			else
			{ // higher chance towards the left
				
			}
			
			var modifier:Vec2 = new Vec2(barbLengthModifier, barbCurviness).scaleSelf(1 - featherType * .4);
			var rightBarb:BezierSegment = new BezierSegment(barbBase.mul(modifier).rotate(rotateBy).add(barbuleVector).point, barbBaseControl.mul(modifier).rotate(rotateBy).add(barbuleVector).point, barbEndControl.mul(modifier).rotate(rotateBy).add(barbuleVector).point, barbEnd.mul(modifier).rotate(rotateBy).add(barbuleVector).point);
			modifier.mulSelf(new Vec2(-1, 1));
			var leftBarb:BezierSegment = new BezierSegment(barbBase.mul(modifier).rotate(-rotateBy).add(barbuleVector).point, barbBaseControl.mul(modifier).rotate(-rotateBy).add(barbuleVector).point, barbEndControl.mul(modifier).rotate(-rotateBy).add(barbuleVector).point, barbEnd.mul(modifier).rotate(-rotateBy).add(barbuleVector).point);
			
			drawBezierSegment(rightBarb, graphics);
			drawBezierSegment(leftBarb, graphics);
		}
	}

}