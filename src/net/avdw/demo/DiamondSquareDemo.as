package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import net.avdw.generate.diamondSquare;
	import net.avdw.generate.makeOverlayTextureFromPattern;
	import net.avdw.generate.pattern.mosaicPattern;
	import net.avdw.render.*;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class DiamondSquareDemo extends Sprite
	{
		
		public function DiamondSquareDemo() 
		{
			var str:String = "";
			var bmpData:BitmapData = renderColorHeightmap(diamondSquare(257));
			
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.smoothing = false;
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
			
			addChild(makeOverlayTextureFromPattern(mosaicPattern(3), stage.stageWidth, stage.stageHeight));
		}
		
	}

}