package net.avdw.algorithm
{
	import com.nodename.Delaunay.Voronoi;
	import flash.geom.Point;
	
	public function lloydRelax(voronoi:Voronoi):void
	{
		var sites:Vector.<Point> = voronoi.siteCoords();
		var region:Vector.<Point>;
		var point:Point;
		var avgX:int, avgY:int;
		for each (var site:Point in sites)
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
}