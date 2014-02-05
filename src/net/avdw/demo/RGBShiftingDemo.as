package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import net.avdw.align.centerAlign;
	import flash.display.BitmapData;
	import net.avdw.display.addChildren;
	import net.avdw.fx.RGBDistortableFx;
	import net.avdw.generate.checkerboard;
	import net.hires.debug.Stats;
	import uk.co.soulwire.gui.SimpleGUI;
	import net.avdw.file.loadTextFile;
	import net.avdw.generate.makeBackgroundFromText;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class RGBShiftingDemo extends Sprite
	{
		public var config:Object = {x: 10, y: 3, scaleX: .2, scaleY: .05, alpha: .5, speed: .8};
		
		[Embed(source="RGBShiftingDemo.as",mimeType="application/octet-stream")]
		public const TextFile:Class;
		[Embed(source="../../../../../assets/images/256x256 Monster.png")]
		private const ImageClass:Class;
		private var img:RGBDistortableFx;
		
		public function RGBShiftingDemo()
		{
			addChild(makeBackgroundFromText(loadTextFile(TextFile), stage.stageWidth, stage.stageHeight));
			
			img = new RGBDistortableFx(new ImageClass());
			centerAlign(img, stage);
			addChild(img);
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addSlider("config.x", 0, 20);
			gui.addSlider("config.y", 0, 20);
			gui.addSlider("config.scaleX", 0, 2);
			gui.addSlider("config.scaleY", 0, 2);
			gui.addSlider("config.alpha", 0, 1);
			gui.addSlider("config.speed", .1, 1);
			gui.addButton("start", {callback: distort});
			gui.addButton("stop", {callback: img.stop});
			gui.show();
			
			var stats:Stats = new Stats();
			addChild(stats);
			stats.x = stage.stageWidth - stats.width;
			
			distort();
		}
		
		private function distort():void
		{
			img.distort(config);
		}
	
	}

}
