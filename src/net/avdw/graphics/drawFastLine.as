package net.avdw.graphics
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * Rarely under certain circumstances this method draws discontinuous lines.
	 * The circumstances seem to be when drawing outside the boundaries of the bmpData.
	 * Grabbed the original code from http://www.simppa.fi/blog/extremely-fast-line-algorithm-as3-optimized/
     *
	 * @param	bmpData
	 * @param	point1
	 * @param	point2
	 * @param	color
	 */
	public function drawFastLine(bmpData:BitmapData, x:int, y:int, x2:int, y2:int, color:uint):void
	{		
		var shortLen:int = y2 - y;
		var longLen:int = x2 - x;
		if ((shortLen ^ (shortLen >> 31)) - (shortLen >> 31) > (longLen ^ (longLen >> 31)) - (longLen >> 31))
		{
			shortLen ^= longLen;
			longLen ^= shortLen;
			shortLen ^= longLen;
			
			var yLonger:Boolean = true;
		}
		else
		{
			yLonger = false;
		}
		
		var inc:int = longLen < 0 ? -1 : 1;
		
		var multDiff:Number = longLen == 0 ? shortLen : shortLen / longLen;
		
		if (yLonger)
		{
			for (var i:int = 0; i != longLen; i += inc)
			{
				bmpData.setPixel(x + i * multDiff, y + i, color);
			}
		}
		else
		{
			for (i = 0; i != longLen; i += inc)
			{
				bmpData.setPixel(x + i, y + i * multDiff, color);
			}
		}
	}
}

