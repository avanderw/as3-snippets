package net.avdw.generate
{
	import flash.geom.Point;
	
	public function fillCaveWithWater(map:Vector.<Vector.<int>>, depth:int = 15):Vector.<Vector.<int>>
	{
		var x:int, y:int;
		var height:int = map.length;
		var width:int = map[0].length;
		
		var lowestPoint:int;
		for (y = height - 1; y > 0; y--)
			for (x = 0; x < width; x++)
				if (lowestPoint == 0 && map[y][x] == 0)
					lowestPoint = y;
		
		for (y = lowestPoint; y > lowestPoint - depth; y--)
			for (x = 0; x < width; x++)
				if (map[y][x] == 0)
					map[y][x] = 2;
		
		return map;
	}
}