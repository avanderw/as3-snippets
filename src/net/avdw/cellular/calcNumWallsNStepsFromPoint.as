package net.avdw.cellular
{
	public function calcNumWallsNStepsFromPoint(map:Vector.<Vector.<int>>, px:int, py:int, steps:int):int
	{
		var height:int = map.length;
		var width:int = map[0].length;
		
		var xRange:Object = {low: Math.max(0, px - steps), high: Math.min(width - 1, px + steps)};
		var yRange:Object = {low: Math.max(0, py - steps), high: Math.min(height - 1, py + steps)};
		var wallCount:int = 0;
		
		for (var xi:int = xRange.low; xi <= xRange.high; xi++)
			for (var yi:int = yRange.low; yi <= yRange.high; yi++)
			{
				if (xi == px && yi == py)
					continue;
				
				wallCount += map[yi][xi];
			}
		
		return wallCount;
	}
}