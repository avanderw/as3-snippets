package net.avdw.demo
{
	import com.bit101.components.Label;
	import com.nodename.Delaunay.Voronoi;
	import com.nodename.geom.LineSegment;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.avdw.number.SeededOffsetRNG;
	import net.avdw.number.SeededWalkRNG;
	import net.avdw.palette.HSLColorPalette;
	import net.avdw.random.randomSign;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class VoronoiDemo extends Sprite
	{
		private const proximitySpriteMap:Sprite = new Sprite();
		private const selectedRegionOverlay:Sprite = new Sprite();
		private const points:Vector.<Point> = new Vector.<Point>();
		private const colors:Vector.<uint> = new Vector.<uint>();
		private var move:Vector.<Point> = new Vector.<Point>();
		private var plotBounds:Rectangle;
		private var palette:HSLColorPalette;
		private var totalSitesLabel:Label;
		private var proximityMap:BitmapData;
		private var voronoi:Voronoi;
		private var lastSite:Point;
		private var gui:SimpleGUI;
		private var moveSiteAtMouse:Boolean = false;
		public var drawMinimumSpanningTree:Boolean = false;
		public var numberOfSites:int = 5;
		public var drawSites:Boolean = true;
		public var drawRegions:Boolean = true;
		public var drawBoundaries:Boolean = true;
		public var redrawProximityMap:Boolean = false;
		public var improvedProximityMap:Boolean = false;
		public var randomMovement:Boolean = true;
		public var lloydsAlgorithm:Boolean = false;
		
		public function VoronoiDemo()
		{
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addChild(selectedRegionOverlay);
			addEventListener(Event.ENTER_FRAME, animate);
			addEventListener(Event.ENTER_FRAME, drawMouseRegion);
		}
		
		private function animate(e:Event):void
		{
			var site:Point;
			if (moveSiteAtMouse)
			{
				site = voronoi.nearestSitePoint(proximityMap, Math.floor(mouseX), Math.floor(mouseY));
				site.x = Math.floor(mouseX);
				site.y = Math.floor(mouseY);
			}
			
			var i:int;
			if (lloydsAlgorithm)
			{
				try
				{
					var sites:Vector.<Point> = points;
					var region:Vector.<Point>;
					var point:Point;
					var avgX:int, avgY:int;
					for each (site in sites)
					{
						avgX = 0;
						avgY = 0;
						region = voronoi.region(site);
						for each (point in region)
						{
							avgX += point.x;
							avgY += point.y;
						}
						
						avgX /= region.length;
						avgY /= region.length;
						
						site.x = avgX;
						site.y = avgY;
					}
				}
				catch (e:Error)
				{
					// who cares
				}
			}
			else if (randomMovement)
			{
				for (i = 0; i < points.length; i++)
				{
					points[i].x += move[i].x;
					points[i].y += move[i].y;
					
					if (points[i].x < 0)
						move[i].x = 1;
					if (points[i].y < 0)
						move[i].y = 1;
					if (points[i].x > plotBounds.width)
						move[i].x = -1;
					if (points[i].y > plotBounds.height)
						move[i].y = -1;
				}
			}
			
			if (lloydsAlgorithm || randomMovement || moveSiteAtMouse)
			{
				redrawProximityMap = true;
				redraw();
			}
		}
		
		private function drawMouseRegion(e:Event):void
		{
			try
			{
				if (proximityMap == null)
					return;
				
				var nearestSiteToMouse:Point = voronoi.nearestSitePoint(proximityMap, Math.floor(mouseX), Math.floor(mouseY));
				if (nearestSiteToMouse == null)
					return;
				
				var region:Vector.<Point> = voronoi.region(nearestSiteToMouse);
				
				if (lastSite == null || !lastSite.equals(nearestSiteToMouse) || randomMovement || lloydsAlgorithm || moveSiteAtMouse)
				{
					lastSite = nearestSiteToMouse;
					selectedRegionOverlay.graphics.clear();
					selectedRegionOverlay.graphics.beginFill(0, .5);
					drawRegion(region, selectedRegionOverlay.graphics);
					selectedRegionOverlay.graphics.endFill();
				}
			}
			catch (e:Error)
			{
				// who cares if it broke
			}
		}
		
		private function addedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			parent.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			parent.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			plotBounds = new Rectangle();
			plotBounds.width = parent.width < 10 ? stage.stageWidth : parent.width;
			plotBounds.height = parent.height < 10 ? stage.stageHeight : parent.height;
			
			proximityMap = new BitmapData(plotBounds.width, plotBounds.height, false, 0);
			
			// palette generator
			var hueNG:SeededOffsetRNG = new SeededOffsetRNG(120, 5, 10);
			var saturationNG:SeededOffsetRNG = new SeededOffsetRNG(.86, .14);
			var luminanceNG:SeededOffsetRNG = new SeededOffsetRNG(.57, .13);
			palette = new HSLColorPalette(hueNG, saturationNG, luminanceNG);
			
			// gui
			gui = new SimpleGUI(this);
			gui.addButton("add points", {callback: addSites});
			gui.addButton("remove points", {callback: removeSites});
			totalSitesLabel = gui.addLabel("Total Sites: " + points.length);
			gui.addGroup();
			gui.addToggle("lloydsAlgorithm", {callback: turnOffRandMove});
			gui.addToggle("randomMovement", {callback: turnOffLloyds});
			gui.addGroup();
			gui.addToggle("drawSites", {callback: redraw});
			gui.addToggle("drawRegions", {callback: redraw});
			gui.addToggle("drawBoundaries", {callback: redraw});
			gui.addToggle("drawMinimumSpanningTree", {callback: redraw});
			gui.addToggle("improvedProximityMap", {callback: fixBoundaryAliasing});
			gui.show();
			
			addSites(25);
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			moveSiteAtMouse = false;
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			moveSiteAtMouse = true;
		}
		
		private function turnOffLloyds():void
		{
			if (randomMovement)
				lloydsAlgorithm = false;
			
			improvedProximityMap = !(randomMovement || lloydsAlgorithm);
			redrawProximityMap = true;
			redraw();
		}
		
		private function turnOffRandMove():void
		{
			if (lloydsAlgorithm)
				randomMovement = false;
			
			improvedProximityMap = !(randomMovement || lloydsAlgorithm);
			redrawProximityMap = true;
			redraw();
		}
		
		private function fixBoundaryAliasing():void
		{
			redrawProximityMap = true;
			redraw();
		}
		
		private function removeSites():void
		{
			var pointsToRemove:int = Math.min(numberOfSites, points.length);
			points.splice(0, pointsToRemove);
			colors.splice(0, pointsToRemove);
			move.splice(0, pointsToRemove);
			
			redrawProximityMap = true;
			redraw();
		}
		
		private function addSites(num:int = 0):void
		{
			var pointsToAdd:int = num == 0 ? numberOfSites : num;
			var newPoint:Point;
			for (var i:int = 0; i < pointsToAdd; i++)
			{
				newPoint = new Point(Math.floor(plotBounds.width * Math.random()), Math.floor(plotBounds.height * Math.random()));
				
				// adding two points on top of each other will break the voronoi
				// stupid slow as well, should rather use a hashmap
				var match:Boolean = false;
				for each (var point:Point in points)
				{
					if (point.equals(newPoint))
					{
						match = true;
					}
				}
				
				if (!match)
				{
					points.push(newPoint);
					colors.push(palette.generateColor());
					move.push(new Point(randomSign(), randomSign()));
				}
				
			}
			
			redrawProximityMap = true;
			redraw();
		}
		
		private function redraw():void
		{
			try
			{
				if (voronoi != null)
					voronoi.dispose();
				
				voronoi = new Voronoi(points, colors, plotBounds);
				totalSitesLabel.text = "Total Sites: " + points.length;
				graphics.clear();
				
				var site:Point;
				var sites:Vector.<Point> = voronoi.siteCoords();
				var regions:Vector.<Vector.<Point>> = voronoi.regions();
				var idx:int = 0;
				for each (site in sites)
				{
					if (drawRegions)
						graphics.beginFill(voronoi.siteColors()[idx]);
					
					if (drawBoundaries)
						graphics.lineStyle(1);
					
					drawRegion(voronoi.region(site), graphics);
					
					if (drawRegions)
						graphics.endFill();
					
					idx++;
				}
				
				// MSP
				var msp:Vector.<LineSegment> = voronoi.spanningTree();
				if (drawMinimumSpanningTree)
					for each (var lineSegment:LineSegment in msp)
					{
						graphics.lineStyle(2, 0xFF0000);
						graphics.moveTo(lineSegment.p0.x, lineSegment.p0.y);
						graphics.lineTo(lineSegment.p1.x, lineSegment.p1.y);
					}
				
				// draw sites
				if (drawSites)
					for each (site in sites)
					{
						graphics.lineStyle(1);
						graphics.beginFill(0x0);
						graphics.drawCircle(site.x, site.y, 1.5);
						graphics.endFill();
					}
				
				if (redrawProximityMap)
				{
					// generate proximity map
					// draws regions with site idx as color
					proximitySpriteMap.graphics.clear();
					proximityMap.fillRect(plotBounds, 0);
					var tmpBmpData:BitmapData = proximityMap.clone();
					for (idx = 0; idx < sites.length; idx++)
					{
						if (improvedProximityMap)
							proximitySpriteMap.graphics.clear();
						
						proximitySpriteMap.graphics.beginFill(idx);
						drawRegion(voronoi.region(sites[idx]), proximitySpriteMap.graphics);
						proximitySpriteMap.graphics.endFill();
						
						// required to remove boundary aliasing
						// redraw all pixels that are not black to the idx
						if (improvedProximityMap)
						{
							// the below draw calls are slow
							// should reduce the plotbounds to improve performance
							tmpBmpData.fillRect(plotBounds, 0);
							tmpBmpData.draw(proximitySpriteMap);
							tmpBmpData.threshold(tmpBmpData, plotBounds, new Point(), "!=", 0, 0xFF000000 | idx, 0x00FFFFFF);
							proximityMap.draw(tmpBmpData, null, null, BlendMode.LIGHTEN); // take the higher value of the two
						}
					}
					if (!improvedProximityMap)
						proximityMap.draw(proximitySpriteMap);
					
					redrawProximityMap = false;
				}
			}
			catch (e:Error)
			{
				// who cares if it broke
			}
		}
		
		private function drawRegion(region:Vector.<Point>, graphics:Graphics):void
		{
			if (region == null || region.length == 0)
				return;
			
			var drawCoords:Vector.<Number> = new Vector.<Number>();
			var drawCommands:Vector.<int> = new Vector.<int>();
			
			drawCoords.push(region[0].x, region[0].y);
			drawCommands.push(GraphicsPathCommand.MOVE_TO);
			for each (var point:Point in region)
			{
				drawCoords.push(point.x, point.y);
				drawCommands.push(GraphicsPathCommand.LINE_TO);
			}
			drawCoords.push(region[0].x, region[0].y);
			drawCommands.push(GraphicsPathCommand.LINE_TO);
			
			graphics.drawPath(drawCommands, drawCoords);
		}
	
	}

}