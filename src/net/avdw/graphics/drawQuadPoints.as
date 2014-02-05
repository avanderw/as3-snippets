package net.avdw.graphics
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	public function drawQuadPoints(bmpData:BitmapData, p1:Point, p2:Point, p3:Point, p4:Point, color:uint = 0, fill:uint = 0xFF000000):Shape
	{
		var shape:Shape = new Shape();
		with (shape.graphics)
		{
			lineStyle(1, color);
			beginFill(fill);
			moveTo(p1.x, p1.y);
			lineTo(p2.x, p2.y);
			lineTo(p3.x, p3.y);
			lineTo(p4.x, p4.y);
			endFill();
		}
		
		bmpData.draw(shape);
		
		return shape;
	}

}