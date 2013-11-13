package net.avdw.demo
{
	import avdw.math.vector2d.Vec2;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	import uk.co.soulwire.gui.SimpleGUI;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	[SWF(backgroundColor="0xFFFFFF",frameRate="60",width="680",height="495")]
	
	public class ReflectionDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/256x256 Yoda.png")]
		private const _yoda:Class;
		private var perlinBmp:Bitmap
		private var i:int;;
		private var refl:Bitmap;
		private var dMap:DisplacementMapFilter;
		public var perlin:Object;
		
		public function ReflectionDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var img:Bitmap = new _yoda();
			img.y = 20;
			img.x = (stage.stageWidth - img.width) / 2;
			
			refl = new _yoda();
			refl.scaleY = -3/4;
			refl.y = img.height + refl.height + 10;
			refl.x = img.x;
			addChild(refl);
			
			perlinBmp = new Bitmap(new BitmapData(img.width, img.height*3/4));
			i = 1;
			
			dMap = new DisplacementMapFilter(perlinBmp.bitmapData, new Point(), BitmapDataChannel.RED, BitmapDataChannel.GREEN, 10, 50, DisplacementMapFilterMode.CLAMP);
			
			addEventListener(Event.ENTER_FRAME, loop);
			addChild(img);
			
			perlin = new Object();
			perlin.baseX = 45;
			perlin.baseY = 5;
			perlin.numOctaves = 3;
			perlin.speed = 1;
			perlin.seamless = false;
			perlin.fractalNoise = true;
			perlin.moveX = 1;
			perlin.moveY = 1 / 8;
			
			var gui:SimpleGUI = new SimpleGUI(this, "Water reflection parameters");
			gui.addSlider("perlin.baseX", 0, 90);
			gui.addSlider("perlin.baseY", 0, 20);
			gui.addSlider("perlin.numOctaves", 1, 8);
			gui.addToggle("perlin.seamless");
			gui.addToggle("perlin.fractalNoise");
			gui.addSlider("perlin.speed", 0.1, 2);
			gui.addSlider("perlin.moveX", -1, 1);
			gui.addSlider("perlin.moveY", -1, 1);			
			gui.show();
		}
		
		private function loop(e:Event):void
		{
			i++;
			perlinBmp.bitmapData.perlinNoise(perlin.baseX, perlin.baseY, perlin.numOctaves, 50, perlin.seamless, perlin.fractalNoise, 7, true, [new Point(i * perlin.moveX/perlin.speed, i * perlin.moveY/perlin.speed)]);
			refl.filters = [dMap];
		}
	
	}

}