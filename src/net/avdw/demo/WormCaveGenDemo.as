package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import net.avdw.array.*;
	import net.avdw.cellular.*;
	import net.avdw.number.*;
	import net.avdw.random.*;
	import uk.co.soulwire.gui.SimpleGUI;
	import net.avdw.generate.*;
	import net.avdw.generate.pattern.*;
	import net.avdw.align.*;
	import net.avdw.textfield.*;
	import net.avdw.render.*;
	
	/**
	 * http://noelberry.ca/2011/04/procedural-generation-the-caves/
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class WormCaveGenDemo extends Sprite
	{
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		private var count:int = 0;
		private var genText:TextField;
		public var cave:Object = { width: 0, height: 0, digPercentage: .4, minerSpawnChance: 0.05, minerMoveDiagonally: false, smooth: true, smoothAmount: 1, fillGaps: true, fillAmount: 1, seed: 0, numWaterfalls: 4}
		
		public function WormCaveGenDemo()
		{
			cave.width = 200;
			cave.height = 150;
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addStepper("cave.width", 32, stage.stageWidth, {callback: dimensionChange});
			gui.addStepper("cave.height", 32, stage.stageHeight, {callback: dimensionChange});
			gui.addSlider("cave.digPercentage", 0.1, 0.9);
			gui.addSlider("cave.minerSpawnChance", 0.005, 0.05);
			gui.addToggle("cave.minerMoveDiagonally", {callback: generate});
			gui.addToggle("cave.smooth", {callback: generate});
			gui.addStepper("cave.smoothAmount", 0, 5, {callback: generate});
			gui.addToggle("cave.fillGaps", {callback: generate});
			gui.addStepper("cave.fillAmount", 0, 5, {callback: generate});
			gui.addSlider("cave.numWaterfalls", 0, 30);
			gui.addButton("generate", {callback: generate});
			gui.show();
			
			bmp = new Bitmap();
			bmp.smoothing = false;
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
			
			addChild(makeOverlayTextureFromPattern(mosaicPattern(), stage.stageWidth, stage.stageHeight));
			
			genText = createTextField("generating...", 22);
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
			if (contains(bmp))
			{
				removeChild(bmp);
			}
		}
		
		private function genNextFrame(e:Event):void
		{
			count++;
			if (count > 2)
			{
				removeEventListener(Event.ENTER_FRAME, genNextFrame);
				
				bmpData = renderCave(fillCaveWithWater(addCaveWaterfalls(makeWormCave(cave.width, cave.height, cave.digPercentage, cave.minerSpawnChance, cave.minerMoveDiagonally, cave.smooth, cave.smoothAmount, cave.fillGaps, cave.fillAmount, cave.seed), cave.numWaterfalls, cave.seed)), bmpData);
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
