package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import net.avdw.align.centerAlign;
	import net.avdw.generate.makeCave;
	import net.avdw.generate.makeOverlayTextureFromPattern;
	import net.avdw.generate.pattern.*;
	import net.avdw.render.renderCave;
	import net.avdw.textfield.createTextField;
	import uk.co.soulwire.gui.SimpleGUI;
	
	[SWF(backgroundColor="#000000")]
	
	public class CaveGeneratorDemo extends Sprite
	{
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		private var count:int = 0;
		private var genText:TextField;
		public var cave:Object = {width: 0, height: 0, smoothness: 4, density: 0.35, continuous: true, seed: 0}
		
		public function CaveGeneratorDemo()
		{
			cave.width = 200;
			cave.height = 150;
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addStepper("cave.width", 32, stage.stageWidth, {callback: dimensionChange});
			gui.addStepper("cave.height", 32, stage.stageHeight, {callback: dimensionChange});
			gui.addStepper("cave.smoothness", 1, 16);
			gui.addSlider("cave.density", 0, 1);
			gui.addToggle("cave.continuous");
			gui.addButton("generate", {callback: generate});
			gui.show();
			
			bmp = new Bitmap();
			bmp.smoothing = false;
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
			
			addChild(makeOverlayTextureFromPattern(mosaicPattern(), stage.stageWidth, stage.stageHeight));
			
			genText = createTextField("generating...", 22, 0xFFFFFF);
			centerAlign(genText, stage);
			
			generate();
		}
		
		private function dimensionChange():void
		{
			bmpData = null;
		}
		
		public function generate():void
		{
			addEventListener(Event.ENTER_FRAME, genNextFrame);
			addChild(genText);
			if (contains(bmp)) {
				removeChild(bmp);
			}
		}
		
		private function genNextFrame(e:Event):void
		{
			count++;
			if (count > 2)
			{
				removeEventListener(Event.ENTER_FRAME, genNextFrame);
				
				bmpData = renderCave(makeCave(cave.width, cave.height, cave.smoothness, cave.density, cave.continuous, cave.seed), bmpData);
				bmp.bitmapData = bmpData;
				bmp.x = int((stage.stageWidth - bmp.width) / 2);
				bmp.y = int((stage.stageHeight - bmp.height) / 2);
				count = 0;
				addChildAt(bmp, 0);
				removeChild(genText);
			}
		}
	}
}