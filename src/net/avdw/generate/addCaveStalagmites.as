package net.avdw.generate
{
	import flash.geom.Point;
	import net.avdw.number.SeededRNG;
	
	public function addCaveStalagmites(map:Vector.<Vector.<int>>, numSpawns:int = 8, low:int = 2, high:int = 10, seed:int = 0):Vector.<Vector.<int>>
	{
		var x:int, y:int;
		var height:int = map.length;
		var width:int = map[0].length;
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		var rng:SeededRNG = new SeededRNG(seed);
		
		// spawn locations
		var spawns:Vector.<Point> = new Vector.<Point>();
		while (spawns.length < numSpawns)
		{
			x = rng.integer(width);
			y = rng.integer(height);
			
			if (map[y][x] == 0 && y + 1 < height && map[y + 1][x] == 1)
				spawns.push(new Point(x, y));
		}
		
		// grow spawns
		var length:int;
		while (spawns.length != 0)
		{
			var loc:Point = spawns.pop();
			length = rng.integer(low, high);
			for (var i:int = 0; i < length; i++)
			{
				if (map[loc.y - i][loc.x] == 0)
					map[loc.y - i][loc.x] = 3;
				else
					break;
			}
		}
		
		return map;
	}
}