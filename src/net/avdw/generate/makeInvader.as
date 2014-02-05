package net.avdw.generate 
{
	import flash.display.BitmapData;
	public function makeInvader(width:int, height:int, fillRatio:Number = .5, lightToDarkRatio:Number = .5, lightColor:uint = 0xFFCCCCCC, darkColor:uint = 0xFF333333, bmpData:BitmapData = null):BitmapData
		{
			var r:int, useColor:uint;
			if (bmpData == null)
				bmpData = new BitmapData(width, height);
			
			bmpData.fillRect(bmpData.rect, 0);
			
			var col:int = Math.floor(bmpData.width / 2);
			
			for (var c:int = 0; c < col; c++)
				for (r = 0; r < bmpData.height; r++)
					if (Math.random() < fillRatio)
					{
						useColor = Math.random() < lightToDarkRatio ? lightColor : darkColor;
						
						bmpData.setPixel32(c, r, useColor);
						bmpData.setPixel32(bmpData.width - 1 - c, r, useColor);
					}
			
			for (r = 0; r < bmpData.height; r++)
				if (Math.random() < fillRatio)
				{
					useColor = Math.random() < lightToDarkRatio ? lightColor : darkColor;
					bmpData.setPixel32(col, r, useColor);
				}
			
			return bmpData;
		}

}