package net.avdw.generate
{
	import flash.geom.Point;
	import net.avdw.number.SeededRNG;
	
	public function addCaveWaterfalls(map:Vector.<Vector.<int>>, numWaterFalls:int = 4, seed:int = 0):Vector.<Vector.<int>>
	{
		var x:int, y:int;
		var height:int = map.length;
		var width:int = map[0].length;
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		var rng:SeededRNG = new SeededRNG(seed);
		
		var waterFallSpawns:Vector.<Point> = new Vector.<Point>();
		while (waterFallSpawns.length < numWaterFalls)
		{
			x = rng.integer(width);
			y = rng.integer(height);
			
			if (map[y][x] == 0 && y - 1 >= 0 && map[y - 1][x] == 1)
				waterFallSpawns.push(new Point(x, y));
		}
		
		var i:int;
		var waterfall:Point;
		while (waterFallSpawns.length != 0)
		{
			waterfall = waterFallSpawns.pop();
			
			if(map[waterfall.y][waterfall.x] == 0)
				map[waterfall.y][waterfall.x] = 2;
			
			while (waterfall.y + 1 < height && map[waterfall.y + 1][waterfall.x] == 0)
			{
				waterfall.y++;
				map[waterfall.y][waterfall.x] = 2;
			}
			
			if (waterfall.x -1 >= 0 && map[waterfall.y][waterfall.x - 1] == 0)
				waterFallSpawns.push(new Point(waterfall.x - 1, waterfall.y));
			if (waterfall.x +1 < width && map[waterfall.y][waterfall.x + 1] == 0)
				waterFallSpawns.push(new Point(waterfall.x + 1, waterfall.y));
		}
		
		return map;
	}
}