package net.avdw.generate
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public function checkerboard(width:int, height:int, cellWidth:int = 32, cellHeight:int = 32, color1:uint = 0xffe7e6e6, color2:uint = 0xffd9d5d5):BitmapData
	{
		var bitmapData:BitmapData = new BitmapData(width, height);
		var numRows:int = Math.ceil(height / cellHeight);
		var numCols:int = Math.ceil(width / cellWidth);
		
		var clipRect:Rectangle = new Rectangle(0, 0, cellWidth, cellHeight);
		
		var y:int;
		var x:int;
		var lastColor:uint = color1;
		
		for (y = 0; y < numRows; y++)
		{
			for (x = 0; x < numCols; x++)
			{
				clipRect.y = y * cellHeight;
				clipRect.x = x * cellWidth;
				bitmapData.fillRect(clipRect, lastColor);
				
				lastColor = (lastColor == color1) ? color2 : color1;
				if (x + 1 == numCols && x % 2 != 0)
					lastColor = (lastColor == color1) ? color2 : color1;
			}
		}
		
		return bitmapData;
	}

}