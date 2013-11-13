package net.avdw.generate
{
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.number.SeededRNG;
	public function makeCave(width:int, height:int = 0, smoothness:int = 4, seed:int = 0):Vector.<Vector.<int>>
	{
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		height = height == 0 ? width : height;
		var rnd:SeededRNG = new SeededRNG(seed);
		
		var map:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		for (var y:int = 0; y < height; y++)
		{
			var row:Vector.<int> = new Vector.<int>();
			for (var x:int = 0; x < width; x++)
				row.push(rnd.bit());
			map.push(row);
		}
		
		for (var i:int = 0; i < smoothness; i++)
		{
			var mapBuffer:Vector.<Vector.<int>> = createIntVectorMatrix(height, width, 0);
			for (y = 0; y < height; y++)
			{
				for (x = 0; x < width; x++)
				{
					var xRange:Object = {low: Math.max(0, x - 1), high: Math.min(width - 1, x + 1)};
					var yRange:Object = {low: Math.max(0, y - 1), high: Math.min(height - 1, y + 1)};
					var wallCount:int = 0;
					
					for (var xi:int = xRange.low; xi <= xRange.high; xi++)
					{
						for (var yi:int = yRange.low; yi <= yRange.high; yi++)
						{
							if (xi == x && yi == y)
								continue;
							
							wallCount += map[yi][xi];
						}
					}
					
					var isWallWith4Walls:Boolean = map[y][x] == 1 && wallCount == 4;
					var hasMoreThanFiveWalls:Boolean = wallCount >= 5;
					var isBorder:Boolean = x == 0 || y == 0 || x == width - 1 || y == height - 1;
					
					mapBuffer[y][x] = (isWallWith4Walls || hasMoreThanFiveWalls || isBorder) ? 1 : 0;
				}
			}
			map = mapBuffer;
		}
		
		return map;
	}

}