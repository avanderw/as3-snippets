package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import net.avdw.align.centerAlignHorizontally;
	import net.avdw.align.spaceVertically;
	import net.avdw.display.addChildren;
	import net.avdw.interp.linear;
	import net.avdw.number.InterpolatedNG;
	import net.avdw.number.SeededOffsetRNG;
	import net.avdw.number.SeededRangedRNG;
	import net.avdw.number.SeededRNG;
	import net.avdw.number.SeededWalkRNG;
	import net.avdw.number.ConstantNG;
	import net.avdw.palette.HSVColorPalette;
	import net.avdw.textfield.createTextField;
	
	public class HSVColorPaletteDemo extends Sprite
	{
		private var paletteWidth:int;
		private var paletteHeight:int;
		private var displayObjects:Array = [];
		private var colorPalette:HSVColorPalette;
		
		public function HSVColorPaletteDemo()
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
			
			var hueNG:Object = new ConstantNG(Math.random() * 360);
			var saturationNG:Object = new ConstantNG(0.5);
			var valueNG:Object = new ConstantNG(0.5);
			colorPalette = new HSVColorPalette(hueNG, saturationNG, valueNG);
			
			colorPalette.valueNG = new SeededWalkRNG(.5, .01, .05);
			displayObjects.push(createTextField("Value randomly walked, from 0.5, minimum walk 0.01, maximum walk 0.05, in both directions"));
			addPalette();
			colorPalette.valueNG = new SeededOffsetRNG(.5, .05, .2);
			displayObjects.push(createTextField("Value randomly offset from 0.5, minimum offset 0.05, maximum offset 0.2"));
			addPalette();
			colorPalette.valueNG = new SeededRangedRNG(.2, .8);
			displayObjects.push(createTextField("Value randomly sampled between [0.2 , 0.8]"));
			addPalette();
			colorPalette.valueNG = new InterpolatedNG(.2, .8, 20, linear, true);
			displayObjects.push(createTextField("Value interpolated between [0.2 , 0.8], sampled 20 times, linearly"));
			addPalette();
			colorPalette.saturationNG = new InterpolatedNG(.2, .8, 20, linear, true);
			displayObjects.push(createTextField("Same as above with saturation interpolated as well"));
			addPalette();
			colorPalette.saturationNG = new SeededRangedRNG(1);
			displayObjects.push(createTextField("Same as above with completely random saturation"));
			addPalette();
			colorPalette.saturationNG = new SeededOffsetRNG(0.5, 0.1, 0.2);
			displayObjects.push(createTextField("Same as above with offset saturation from 0.5, minimum 0.1, maximum 0.2"));
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