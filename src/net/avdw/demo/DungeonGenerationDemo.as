package net.avdw.demo
{
	import com.greensock.motionPaths.RectanglePath2D;
	import com.nodename.Delaunay.Voronoi;
	import com.nodename.geom.LineSegment;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.avdw.align.centerAlign;
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.cellular.widenSpaces;
	import net.avdw.cellular.smoothEdges;
	import net.avdw.generate.makeDungeon;
	import net.avdw.generate.makeIrregularSquareRoom;
	import net.avdw.generate.makeOverlayTextureFromPattern;
	import net.avdw.generate.pattern.mosaicPattern;
	import net.avdw.graphics.drawFastLineVectorInts;
	import net.avdw.number.SeededRNG;
	import net.avdw.render.renderCave;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class DungeonGenerationDemo extends Sprite
	{
		public var settings:Object = {width: 200, height: 150, minRoomWidth:13, maxRoomWidth:20, minRoomHeight:10, maxRoomHeight:15, roomEdge:2};
		private var bmp:Bitmap = new Bitmap();
		
		public function DungeonGenerationDemo()
		{
			bmp.smoothing = false;
			bmp.scaleX = bmp.scaleY = 3;
			addChild(bmp);
			
			addChild(makeOverlayTextureFromPattern(mosaicPattern(3), stage.stageWidth, stage.stageHeight));
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addStepper("settings.width", 0, 500);
			gui.addStepper("settings.height", 0, 500);
			gui.addStepper("settings.minRoomWidth", 0, 50, { callback:generate } );
			gui.addStepper("settings.maxRoomWidth", 0, 100, { callback:generate } );
			gui.addStepper("settings.minRoomHeight", 0, 50, { callback:generate } );
			gui.addStepper("settings.maxRoomHeight", 0, 50, { callback:generate } );
			gui.addStepper("settings.roomEdge", 1, 50, { callback:generate } );
			gui.addButton("generate", { callback:generate } );
			gui.show();
			
			generate();
		}
		
		private function generate():void
		{
			if (bmp.bitmapData != null)
				bmp.bitmapData.dispose();
			
			bmp.bitmapData = new BitmapData(settings.width, settings.height);
			renderCave(makeDungeon(settings.width, settings.height, settings.minRoomWidth, settings.maxRoomWidth, settings.minRoomHeight, settings.maxRoomHeight, settings.roomEdge), bmp.bitmapData);
			centerAlign(bmp, stage);
		}
		
		
	
	}

}