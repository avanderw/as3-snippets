package net.avdw.generate
{
	import com.nodename.Delaunay.Voronoi;
	import com.nodename.geom.LineSegment;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.cellular.widenSpaces;
	import net.avdw.graphics.drawFastLineVectorInts;
	import net.avdw.number.SeededRNG;
	
	public function makeDungeon(width:int = 200, height:int = 150, minRoomWidth:int = 13, maxRoomWidth:int = 20, minRoomHeight:int = 10, maxRoomHeight:int = 15, roomEdge:int = 2, seed:int = 0):Vector.<Vector.<int>>
	{
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		height = height == 0 ? width : height;
		var rng:SeededRNG = new SeededRNG(seed);
		
		var centers:Vector.<Point> = new Vector.<Point>();
		var colors:Vector.<uint> = new Vector.<uint>();
		var map:Vector.<Vector.<int>> = createIntVectorMatrix(height, width, 1);
		var isSpace:Boolean = true;
		while (isSpace)
		{
			var roomData:Vector.<Vector.<int>> = makeIrregularSquareRoom(rng.integer(minRoomWidth, maxRoomWidth), rng.integer(minRoomHeight, maxRoomHeight), roomEdge, 2, 5);
			var roomWidth:int = roomData[0].length;
			var roomHeight:int = roomData.length;
			var pointInMap:Point = new Point();
			var fits:Boolean = false;
			var x:int, y:int;
			var iteration:int = 0;
			while (!fits && isSpace)
			{
				fits = true;
				pointInMap.x = rng.integer(1, width - (roomWidth + 2 * roomEdge) - 1);
				pointInMap.y = rng.integer(1, height - (roomHeight + 2 * roomEdge) - 1);
				for (x = 0; x < roomWidth && fits; x++)
					for (y = 0; y < roomHeight && fits; y++)
						if (map[pointInMap.y + y][pointInMap.x + x] == 0)
							fits = false;
				
				iteration++;
				if (iteration > 100)
					isSpace = false;
			}
			
			if (fits)
			{
				for (x = 0; x < roomWidth && fits; x++)
					for (y = 0; y < roomHeight && fits; y++)
						map[pointInMap.y + y][pointInMap.x + x] = roomData[y][x];
				
				centers.push(new Point(pointInMap.x + (roomWidth >> 1), pointInMap.y + (roomHeight >> 1)));
				colors.push(0);
			}
		}
		
		var plotBounds:Rectangle = new Rectangle(0, 0, width, height);
		var voronoi:Voronoi = new Voronoi(centers, colors, plotBounds);
		var shortestPath:Vector.<LineSegment> = voronoi.spanningTree();
		for each (var line:LineSegment in shortestPath)
		{
			drawFastLineVectorInts(map, line.p0.x, line.p0.y, line.p1.x, line.p1.y, 0);
			drawFastLineVectorInts(map, line.p0.x + 1, line.p0.y + 1, line.p1.x + 1, line.p1.y + 1, 0);
			drawFastLineVectorInts(map, line.p0.x - 1, line.p0.y + 1, line.p1.x - 1, line.p1.y + 1, 0);
			drawFastLineVectorInts(map, line.p0.x + 1, line.p0.y - 1, line.p1.x + 1, line.p1.y - 1, 0);
			drawFastLineVectorInts(map, line.p0.x - 1, line.p0.y - 1, line.p1.x - 1, line.p1.y - 1, 0);
		}
		
		widenSpaces(map, 1);
		
		return map;
	}
}