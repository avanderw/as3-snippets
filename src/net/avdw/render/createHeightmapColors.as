package net.avdw.render
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * Extracts RGB from a gradient of 256x1 with colors
	 * (blue, light brown green, dark brown, white)
	 */
	public function createHeightmapColors():Array
	{
		var mat:Matrix = new Matrix();
		mat.createGradientBox(256, 1, 0, 0, 0);
		
		var gradient:Object = {
			color: [0x000080, 0x0066ff, 0xcc9933, 0x00cc00, 0x996600, 0xffffff], 
			alpha: [1, 1, 1, 1, 1, 1], 
			ratio: [0, 84, 96, 128, 168, 224] };
		
		var gradientBar:Shape = new Shape();
		var g:Graphics = gradientBar.graphics;
		g.clear();
		g.beginGradientFill("linear", gradient.color, gradient.alpha, gradient.ratio, mat);
		g.drawRect(0, 0, 256, 1);
		g.endFill();
		
		var mapR:Array = new Array(256);
		var mapG:Array = new Array(256);
		var mapB:Array = new Array(256);
		
		var gmap:BitmapData = new BitmapData(256, 1, false, 0);
		gmap.draw(gradientBar);
		for (var i:int = 0; i < 256; i++)
		{
			var color:uint = gmap.getPixel(i, 0);
			mapR[i] = color & 0xff0000; 
			mapG[i] = color & 0x00ff00; 
			mapB[i] = color & 0x0000ff; 
		}
		gmap.dispose();
		
		return [mapR, mapG, mapB];	
	}

}