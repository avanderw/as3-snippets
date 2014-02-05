package net.avdw.graphics
{
	import fl.motion.BezierSegment;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public function drawBezierSegment(bezier:BezierSegment, graphics:Graphics, resolution:int = 50):void
	{
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