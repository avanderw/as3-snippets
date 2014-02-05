package net.avdw.demo
{
	import com.nodename.Delaunay.Site;
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.nodename.Delaunay.Voronoi;
	import com.nodename.geom.LineSegment;
	import net.avdw.algorithm.createUrquhartGraph;
	import net.avdw.algorithm.lloydRelax;
	import net.avdw.generate.checkerboard;
	import net.avdw.interp.quadEaseOut;
	import net.avdw.number.SeededRNG;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class UrquhartGraphDemo extends Sprite
	{
		private var voronoi:Voronoi;
		private var drawing:Sprite;
		
		public var drawDelaunayTriangulation:Boolean = true;
		public var drawUrquhartGraph:Boolean = true;
		public var drawMinimumSpanningTree:Boolean = false;
		
		public function UrquhartGraphDemo()
		{
			addChild(new Bitmap(checkerboard(stage.stageWidth, stage.stageHeight)));
			drawing = new Sprite();
			addChild(drawing);
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addToggle("drawDelaunayTriangulation", {callback: draw});
			gui.addToggle("drawUrquhartGraph", {callback: draw});
			gui.addToggle("drawMinimumSpanningTree", {callback: draw});
			gui.addButton("generate", {callback: generate});
			gui.show();
			
			generate();
		}
		
		private function generate():void
		{
			var points:Vector.<Point> = new Vector.<Point>();
			var colors:Vector.<uint> = new Vector.<uint>();
			var region:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			for (var i:int = 0; i < 100; i++)
			{
				var t:Number = Math.random() * Math.PI * 2;
				var rad:Number = (stage.stageHeight * .4) * quadEaseOut(Math.random());
				points.push(new Point((stage.stageWidth >> 1) + rad * Math.cos(t), (stage.stageHeight >> 1) + rad * Math.sin(t)));
				colors.push(0);
			}
			voronoi = new Voronoi(points, colors, region);
			lloydRelax(voronoi);
			draw();
		}
		
		private function draw():void
		{
			drawing.graphics.clear();
			drawing.graphics.lineStyle(1, 0x99CCCC);
			if (drawDelaunayTriangulation)
				drawLineSegments(drawing.graphics, voronoi.delaunayTriangulation());
			
			drawing.graphics.lineStyle(1, 0);
			if (drawUrquhartGraph)
				drawLineSegments(drawing.graphics, createUrquhartGraph(voronoi));
			
			drawing.graphics.lineStyle(1, 0xFF0000);
			if (drawMinimumSpanningTree)
				drawLineSegments(drawing.graphics, voronoi.spanningTree());
			
			drawing.graphics.lineStyle(1, 0);
			drawing.graphics.beginFill(0x999999);
			for each (var site:Point in voronoi.siteCoords())
				drawing.graphics.drawCircle(site.x, site.y, 3);
			drawing.graphics.endFill();
		}
		
		private function drawLineSegments(graphics:Graphics, segments:Vector.<LineSegment>):void
		{
			for each (var segment:LineSegment in segments)
			{
				graphics.moveTo(segment.p0.x, segment.p0.y);
				graphics.lineTo(segment.p1.x, segment.p1.y);
			}
		}
	}
}