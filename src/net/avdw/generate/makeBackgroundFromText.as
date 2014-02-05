package net.avdw.generate
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import net.avdw.generate.pattern.scanlinePattern;
	
	public function makeBackgroundFromText(text:String, width:int, height:int, textSize:int = 18):Bitmap
	{
		var textfield:TextField = new TextField();
		textfield.text = text;
		textfield.autoSize = TextFieldAutoSize.LEFT;
		textfield.setTextFormat(new TextFormat(null, textSize, 0x92E6EA));
		
		var bmpData:BitmapData = new BitmapData(width, height, false, 0);
		bmpData.draw(textfield, new Matrix(1, 0, 0, 1, 0, -(textfield.height - height)), new ColorTransform(1, 1, 1, .3));
		bmpData.draw(textfield, new Matrix(1, 0, 0, .75, width * .5, 0), new ColorTransform(1, 1, 1, .15));
		bmpData.draw(textfield, new Matrix(1, 0, 0, .5, 0, -(textfield.height * .5 - height)), new ColorTransform(1, 1, 1, .1));
		bmpData.draw(makeOverlayTextureFromPattern(scanlinePattern(), width, height));
		
		var bmp:Bitmap = new Bitmap(bmpData);
		bmp.filters = [new GlowFilter(0, .8, width * .15, height * .3, 3, 1, true)];
		return bmp;
	}

}