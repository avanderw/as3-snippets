package net.avdw.generate
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import net.avdw.color.Gradient;
	
	public function linearGradient(width:int, height:int, gradient:Gradient, angle:Number = Math.PI * 0.25):BitmapData
	{
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(width, height, angle);
		
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginGradientFill(GradientType.LINEAR, gradient.colors, gradient.alphas, gradient.ratios, matrix);
		sprite.graphics.drawRect(0, 0, width, height);
		sprite.graphics.endFill();
		
		var bmpData:BitmapData = new BitmapData(width, height, true, 0);
		bmpData.draw(sprite);
		
		return bmpData;
	}
}