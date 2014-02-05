package net.avdw.random
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public function randomPointsInRectangle(rect:Rectangle, numPoints:int):Vector.<Point>
	{
		var points:Vector.<Point> = new Vector.<Point>();
		for (var i:int = 0; i < numPoints; i++)
			points.push(new Point(randomInteger(rect.x, rect.x+ rect.width), randomInteger(rect.y, rect.y + rect.height)));
		return points;
	}
}