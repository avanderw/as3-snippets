package net.avdw.graphics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public function fillVoronoiRegion(region:Vector.<Point>, debugColor:uint, graphics:Graphics):void
	{
		graphics.beginFill(debugColor);
		graphics.moveTo(region[0].x, region[0].y);
		for each (var point:Point in region)
		{
			graphics.lineTo(point.x, point.y);
		}
		graphics.endFill();
	}
}