package net.avdw.graphics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public function drawPoint(point:Object, graphics:Graphics, color:uint = 0xFFFFFF, size:int = 3):void
	{
		if (point.hasOwnProperty("x") && point.hasOwnProperty("y"))
		{
			graphics.beginFill(color);
			graphics.drawCircle(point.x, point.y, size);
			graphics.endFill();
		}
	}
}