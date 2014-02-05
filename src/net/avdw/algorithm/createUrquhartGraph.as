package net.avdw.algorithm
{
	import com.nodename.Delaunay.Triangle;
	import com.nodename.Delaunay.Voronoi;
	import com.nodename.geom.LineSegment;
	import net.avdw.object.allObjectKeys;
	
	public function createUrquhartGraph(voronoi:Voronoi):Vector.<LineSegment>
	{
		var hash:String;
		var hashline:Function = function(line:LineSegment):String
		{
			return "" + Math.max(line.p0.x, line.p1.x) + "" + Math.min(line.p0.x, line.p1.x) + "" + Math.max(line.p0.y, line.p1.y) + "" + Math.min(line.p0.y, line.p1.y);
		};
		
		var uniqueSegments:Object = {};
		var line1:LineSegment, line2:LineSegment, line3:LineSegment;
		var triangles:Vector.<Triangle> = voronoi.delaunayTriangles();
		for each (var triangle:Triangle in triangles)
		{
			line1 = new LineSegment(triangle.sites[0].coord, triangle.sites[1].coord);
			line2 = new LineSegment(triangle.sites[1].coord, triangle.sites[2].coord);
			line3 = new LineSegment(triangle.sites[2].coord, triangle.sites[0].coord);
			
			var maxLength:Number = Math.max(line1.length, line2.length, line3.length);
			if (uniqueSegments[hashline(line1)] == null)
				uniqueSegments[hashline(line1)] = {line: line1, toRemove: false};
			if (uniqueSegments[hashline(line2)] == null)
				uniqueSegments[hashline(line2)] = {line: line2, toRemove: false};
			if (uniqueSegments[hashline(line3)] == null)
				uniqueSegments[hashline(line3)] = {line: line3, toRemove: false};
			
			// cannot inline above for some reason
			if (line1.length == maxLength)
				uniqueSegments[hashline(line1)].toRemove = true;
			if (line2.length == maxLength)
				uniqueSegments[hashline(line2)].toRemove = true;
			if (line3.length == maxLength)
				uniqueSegments[hashline(line3)].toRemove = true;
		}
		
		var objectKeys:Array = allObjectKeys(uniqueSegments);
		var urquhartGraph:Vector.<LineSegment> = new Vector.<LineSegment>();
		for each (var key:String in objectKeys)
			if (uniqueSegments[key].toRemove == false)
				urquhartGraph.push(uniqueSegments[key].line);
		
		return urquhartGraph;
	}
}