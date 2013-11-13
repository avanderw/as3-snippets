package net.avdw.generate
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	public function makeTextureFromPattern(bmpData:BitmapData, width:int, height:int = 0):Shape
	{
		height = height == 0 ? width : height;
		var shape:Shape = new Shape();
		shape.graphics.beginBitmapFill(bmpData);
		shape.graphics.drawRect(0, 0, width, height);
		shape.graphics.endFill();
		return shape;
	}

}