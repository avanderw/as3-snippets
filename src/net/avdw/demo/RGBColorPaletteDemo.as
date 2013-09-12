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
	import net.avdw.palette.RGBColorPalette;
	import net.avdw.textfield.createTextField;
	
	public class RGBColorPaletteDemo extends Sprite
	{
		private var paletteWidth:int;
		private var paletteHeight:int;
		private var displayObjects:Array = [];
		private var colorPalette:RGBColorPalette;
		
		public function RGBColorPaletteDemo()
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
			
			var redNG:Object = new ConstantNG(0);
			var greenNG:Object = new ConstantNG(0);
			var blueNG:Object = new ConstantNG(0);
			colorPalette = new RGBColorPalette(redNG, greenNG, blueNG);
			
			colorPalette.redNG = new InterpolatedNG(0, 1, 20);
			displayObjects.push(createTextField("Red interpolated between [0 , 1], sampled 20 times, linearly"));
			addPalette();
			colorPalette.redNG = new SeededRangedRNG(.3, .7);
			displayObjects.push(createTextField("Red random between [0.3 , 0.7]"));
			addPalette();
			colorPalette.redNG = new ConstantNG(0);
			colorPalette.greenNG = new InterpolatedNG(0, 1, 20);
			displayObjects.push(createTextField("Green interpolated between [0 , 1], sampled 20 times, linearly"));
			addPalette();
			colorPalette.greenNG = new SeededRangedRNG(.3, .7);
			displayObjects.push(createTextField("Green random between [0.3 , 0.7]"));
			addPalette();
			colorPalette.greenNG = new ConstantNG(0);
			colorPalette.blueNG = new InterpolatedNG(0, 1, 20);
			displayObjects.push(createTextField("Blue interpolated between [0 , 1], sampled 20 times, linearly"));
			addPalette();
			colorPalette.blueNG = new SeededRangedRNG(.3, .7);
			displayObjects.push(createTextField("Blue random between [0.3 , 0.7]"));
			addPalette();
			colorPalette.greenNG = new SeededRangedRNG(.3, .7);
			colorPalette.redNG = new InterpolatedNG(0, 1, 20);
			displayObjects.push(createTextField("Blue random between [0.3 , 0.7], Green random between [0.3 , 0.7], Red interpolated between [0 , 1], linearly"));
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