package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import net.avdw.align.centerAlignHorizontally;
	import net.avdw.align.spaceVertically;
	import net.avdw.display.addChildren;
	import net.avdw.number.InterpolatedNG;
	import net.avdw.number.SeededOffsetRNG;
	import net.avdw.number.SeededRangedRNG;
	import net.avdw.number.SeededWalkRNG;
	import net.avdw.number.ConstantNG;
	import net.avdw.palette.HSLColorPalette;
	import net.avdw.textfield.createTextField;
	
	public class HSLColorPaletteDemo extends Sprite
	{
		private var paletteWidth:int;
		private var paletteHeight:int;
		private var displayObjects:Array = [];
		private var colorPalette:HSLColorPalette;
		
		public function HSLColorPaletteDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			paletteWidth = stage.stageWidth * 0.8;
			paletteHeight = stage.stageHeight * 0.1;
			
			var hueOperation:Object = new ConstantNG(Math.random() * 360);
			var saturationOperation:Object = new ConstantNG(0.5);
			var luminanceNG:Object = new ConstantNG(0.5);
			colorPalette = new HSLColorPalette(hueOperation, saturationOperation, luminanceNG);
			
			colorPalette.luminanceNG = new SeededWalkRNG(.5, .01, .05);
			displayObjects.push(createTextField("Luminance randomly walked, from 0.5, minimum walk 0.01, maximum walk 0.05, in both directions"));
			addPalette();
			colorPalette.luminanceNG = new SeededOffsetRNG(.5, .05, .2);
			displayObjects.push(createTextField("Luminance randomly offset from 0.5, minimum offset 0.05, maximum offset 0.2"));
			addPalette();
			colorPalette.luminanceNG = new SeededRangedRNG(.2, .8);
			displayObjects.push(createTextField("Luminance randomly sampled between [0.2 , 0.8]"));
			addPalette();
			colorPalette.luminanceNG = new InterpolatedNG(.2, .8, 20);
			displayObjects.push(createTextField("Luminance interpolated between [0.2 , 0.8], sampled 20 times, linearly"));
			addPalette();
			colorPalette.luminanceNG = new ConstantNG(.5);
			colorPalette.hueNG = new SeededWalkRNG(0, 21, 21, 0, false);
			displayObjects.push(createTextField("Hue walked 21 degrees forward from 0, 20 times"));
			addPalette();
			colorPalette.saturationNG = new InterpolatedNG(0, 1, 20);
			displayObjects.push(createTextField("Same as above with saturation interpolated from 0 to 1, 20 times"));
			addPalette();
			colorPalette.hueNG = new ConstantNG(Math.random() * 360);
			colorPalette.luminanceNG = new SeededRangedRNG(0.4, 0.6);
			colorPalette.saturationNG = colorPalette.luminanceNG;
			displayObjects.push(createTextField("Constant hue with saturation and luminance randomly selected between [0.4 , 0.6]"));
			addPalette();
			
			displayObjects[0].y = 30;
			addChildren(displayObjects, this);
			centerAlignHorizontally(displayObjects, stage);
			spaceVertically(displayObjects);
		}
		
		
		private function addPalette():void
		{
			var paletteBmp:Bitmap = new Bitmap(new BitmapData(paletteWidth, paletteHeight));
			var rect:Rectangle = new Rectangle(0, 0, paletteBmp.width / 20, paletteBmp.height);
			for (var i:int = 0; i < 20; i++)
			{
				paletteBmp.bitmapData.fillRect(rect, colorPalette.generateColor());
				rect.x += rect.width;
			}
			displayObjects.push(paletteBmp);
		}
	
	}

}