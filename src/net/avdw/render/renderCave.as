package net.avdw.render
{
	import flash.display.BitmapData;
	
	public function renderCave(map:Vector.<Vector.<int>>):BitmapData
	{
		var height:int = map.length;
		var width:int = map[0].length;
		
		var bmpData:BitmapData = new BitmapData(map[0].length, map.length, true, 0);
		for (var y:int = 0; y < height; y++)
		{
			for (var x:int = 0; x < width; x++)
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
				
				if (map[y][x] != 0 && wallCount != 8)
				{
					bmpData.setPixel32(x, y, (0xFF << 24) | 0xE0 * ((wallCount + 3) / 10) << 16 | 0x1010);
				}
				else if (map[y][x] == 0)
				{
					bmpData.setPixel32(x, y, 0xFFE0E0E0);
				}
				else
				{
					bmpData.setPixel32(x, y, 0xFF303030);
				}
			}
		}
		return bmpData;
	}
}