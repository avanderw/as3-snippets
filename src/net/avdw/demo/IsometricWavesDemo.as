package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.Point;
	import net.avdw.color.combineARGB;
	import net.avdw.graphics.quad;
	import net.avdw.number.square;
	import net.hires.debug.Stats;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * http://www.openprocessing.org/sketch/5671
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class IsometricWavesDemo extends Sprite
	{
		private var bmp:Bitmap;
		private var halfw:int;
		private var halfh:int;
		private var a:Number = 0;
		private var c1:uint;
		private const c2:Number = combineARGB(1, .3);
		private const c3:Number = combineARGB(1, .6);
		private const iso1:Point = new Point;
		private const iso2:Point = new Point;
		private const iso3:Point = new Point;
		private const iso4:Point = new Point;
		
		public var settings:Object = {period: 0.55, speed: 0.08, base:40, size:7, blockSize: 17};
		
		public function IsometricWavesDemo()
		{
			stage.quality = StageQuality.LOW;
			
			halfw = stage.stageWidth >> 1;
			halfh = stage.stageHeight >> 1;
			
			bmp = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xFFFFFF));
			addChild(bmp);
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addSlider("settings.period", 0, 1);
			gui.addSlider("settings.speed", 0, .5);
			gui.addSlider("settings.base", 24, 64);
			gui.addStepper("settings.size", 1, 10);
			gui.addStepper("settings.blockSize", 8, 24);
			gui.show();
			
			var stats:Stats = new Stats();
			addChild(stats);
			stats.x = stage.stageWidth - stats.width;
			
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(e:Event):void
		{
			var zt:Number, zm:Number, xt:Number, xm:Number;
			var y:int;
			
			a -= settings.speed;
			bmp.bitmapData.fillRect(bmp.bitmapData.rect, 0xFFFFFF);
			for (var x:int = -settings.size; x < settings.size; x++)
			{
				for (var z:int = -settings.size; z < settings.size; z++)
				{
					y = 24 * Math.cos(settings.period * distance(x, z, 0, 0) + a);
					
					xm = x * settings.blockSize - (settings.blockSize >> 1);
					xt = x * settings.blockSize + (settings.blockSize >> 1);
					zm = z * settings.blockSize - (settings.blockSize >> 1);
					zt = z * settings.blockSize + (settings.blockSize >> 1);
					
					iso1.x = xm - zm + halfw;
					iso1.y = (xm + zm) * .5 + halfh;
					iso2.x = xm - zt + halfw;
					iso2.y = (xm + zt) * .5 + halfh;
					iso3.x = xt - zt + halfw;
					iso3.y = (xt + zt) * .5 + halfh;
					iso4.x = xt - zm + halfw;
					iso4.y = (xt + zm) * .5 + halfh;
					
					bmp.bitmapData.draw(quad(iso2.x, iso2.y - y, iso3.x, iso3.y - y, iso3.x, iso3.y + settings.base, iso2.x, iso2.y + settings.base, 0, c2));
					bmp.bitmapData.draw(quad(iso3.x, iso3.y-y, iso4.x, iso4.y - y, iso4.x, iso4.y + settings.base, iso3.x, iso3.y + settings.base, 0, c3));
					
					c1 = combineARGB(1, (210 + y) / 255);
					bmp.bitmapData.draw(quad(iso1.x, iso1.y - y, iso2.x, iso2.y - y, iso3.x, iso3.y - y, iso4.x, iso4.y - y, 0, c1));
				}
			}
		}
		
		private function distance(x:Number, z:Number, cx:Number, cz:Number):Number
		{
			return Math.sqrt(square(cx - x) + square(cz - z));
		}
	
	}

}