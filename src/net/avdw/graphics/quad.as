package net.avdw.graphics
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	public function quad(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int, x4:int, y4:int, color:uint = 0, fill:uint = 0xFF000000):Shape
	{
		var shape:Shape = new Shape();
		with (shape.graphics)
		{
			lineStyle(1, color);
			beginFill(fill);
			moveTo(x1, y1);
			lineTo(x2, y2);
			lineTo(x3, y3);
			lineTo(x4, y4);
			endFill();
		}
		
		return shape;
	}

}