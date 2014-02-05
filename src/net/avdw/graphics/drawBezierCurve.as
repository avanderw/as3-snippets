package net.avdw.graphics
{
	import fl.motion.BezierSegment;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * http://www.eleqtriq.com/2010/04/cubic-bezier-in-flash/
	 *
	 * @param	point0
	 * @param	control0
	 * @param	control1
	 * @param	point1
	 */
	public function drawBezierCurve(point0:Point, control0:Point, control1:Point, point1:Point, graphics:Graphics, resolution:int = 50):void
	{
		var bezier:BezierSegment = new BezierSegment(point0, control0, control1, point1);
		var step:Number = 1 / resolution;
		var t:Number = 0;
		while (t <= 1)
		{
			var pt:Point = bezier.getValue(t);
			t == 0 ? graphics.moveTo(pt.x, pt.y) : graphics.lineTo(pt.x, pt.y);
			t += step;
		}
		pt = bezier.getValue(1);
		graphics.lineTo(pt.x, pt.y);
	}

}