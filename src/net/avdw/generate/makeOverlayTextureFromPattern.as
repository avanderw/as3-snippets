package net.avdw.generate
{
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.BitmapData;
	
	public function makeOverlayTextureFromPattern(bmpData:BitmapData, width:int, height:int = 0):Shape
	{
		var shape:Shape = makeTextureFromPattern(bmpData, width, height);
		shape.blendMode = BlendMode.OVERLAY;
		return shape;
	}
}