package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.align.centerAlign;
	import net.avdw.generate.addCaveStalactites;
	import net.avdw.generate.addCaveStalagmites;
	import net.avdw.generate.addCaveWaterfalls;
	import net.avdw.generate.fillCaveWithWater;
	import net.avdw.generate.makeIrregularSquareRoom;
	import net.avdw.generate.makeOverlayTextureFromPattern;
	import net.avdw.generate.pattern.*;
	import net.avdw.render.renderCave;
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class IrregularShapedRoomDemo extends Sprite
	{
		public var settings:Object = {width: 200, height: 150, edge: {thickness: 20, minPoints: 5, maxPoints: 8}};
		
		private var bmp:Bitmap = new Bitmap();
		
		public function IrregularShapedRoomDemo()
		{
			bmp.smoothing = false;
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
			
			addChild(makeOverlayTextureFromPattern(scanlinePattern(3), stage.stageWidth, stage.stageHeight));
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addStepper("settings.width", 0, stage.stageWidth / 3);
			gui.addStepper("settings.height", 0, stage.stageHeight / 3);
			gui.addStepper("settings.edge.thickness", 0, (stage.stageWidth / 3) >> 1);
			gui.addStepper("settings.edge.minPoints", 1, 40);
			gui.addStepper("settings.edge.maxPoints", 1, 20);
			gui.addButton("generate", {callback: generate});
			gui.show();
			
			generate();
		}
		
		private function generate():void
		{
			if (bmp.bitmapData != null)
				bmp.bitmapData.dispose();
			
			bmp.bitmapData = new BitmapData(settings.width, settings.height);
			renderCave(fillCaveWithWater(addCaveStalactites(addCaveStalagmites(makeIrregularSquareRoom(settings.width, settings.height, settings.edge.thickness, settings.edge.minPoints, settings.edge.maxPoints))), settings.edge.thickness), bmp.bitmapData);
			centerAlign(bmp, stage);
		}
	}
}