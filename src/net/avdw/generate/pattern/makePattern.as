package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	
	public function makePattern(pattern:Vector.<Vector.<uint>>):BitmapData
	{
		var bmpData:BitmapData = new BitmapData(pattern[0].length, pattern.length, true, 0);
		for (var y:int = 0; y < bmpData.height; y++)
			for (var x:int = 0; x < bmpData.width; x++)
				bmpData.setPixel32(x, y, pattern[y][x]);
				
		return bmpData;
	}
}