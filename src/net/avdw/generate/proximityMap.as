package net.avdw.generate
{
	import com.nodename.Delaunay.Voronoi;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.avdw.graphics.drawFastLine;
	import net.avdw.number.clamp;
	
	/**
	 * The floodFill will fill adjacent cells if the line is broken.
	 * The current line algorithm seems to draw discontinuous lines under certain circumstances.
	 *
	 * @param	voronoi
	 * @param	bmpData
	 * @return
	 */
	public function proximityMap(voronoi:Voronoi, bmpData:BitmapData = null):BitmapData
	{
		if (bmpData == null)
		{
			bmpData = new BitmapData(voronoi.plotBounds.width, voronoi.plotBounds.height, false, 0);
		}
		
		var i:int;
		var region:Vector.<Point>;
		var point1:Point;
		var point2:Point;
		var sites:Vector.<Point> = voronoi.siteCoords();
		
		for (i = 0; i < sites.length; i++)
		{
			region = voronoi.region(sites[i]);
			
			point1 = region[0];
			for (var j:int = 1; j < region.length; j++)
			{
				point2 = region[j];
				drawFastLine(bmpData, clamp(point1.x, voronoi.plotBounds.width), clamp(point1.y, voronoi.plotBounds.height), clamp(point2.x, voronoi.plotBounds.width), clamp(point2.y, voronoi.plotBounds.height), i);
				point1 = point2;
			}
			
			drawFastLine(bmpData, clamp(point1.x, voronoi.plotBounds.width), clamp(point1.y, voronoi.plotBounds.height), clamp(region[0].x, voronoi.plotBounds.width), clamp(region[0].y, voronoi.plotBounds.height), i);
		}
		
		for (i = 0; i < sites.length; i++)
		{
			bmpData.floodFill(sites[i].x, sites[i].y, i);
		}
		
		return bmpData;
	}

}