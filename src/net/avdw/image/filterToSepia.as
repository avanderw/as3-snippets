package net.avdw.image 
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Makes a bitmap data object sepia.
	 * 
	 * @param	destBitmapData 		The destination bitmap data object.
	 * @param	sourceBitmapData	The source bitmap data where the pixel data is retrieved. The destination bitmap data will be used if not provided.
	 * @param	sourceRect			The clipping rectangle for the source bitmap data. No clipping will occur if not provided.
	 * @param	destPoint			The upper left point to draw the clipping into the destination bitmap data. (0,0) will be used if not provided.
	 */
	public function filterToSepia(destBitmapData:BitmapData, sourceBitmapData:BitmapData = null, sourceRect:Rectangle = null, destPoint:Point = null):void
	{
		const sepiaFilter:Array = [
			 0.5, 0.59, 0.11, 0, 0,
			 0.4, 0.59, 0.11, 0, 0,
			0.16, 0.59, 0.11, 0, 0,
			   0,    0,    0, 1, 0
		];
		
		sourceBitmapData = (sourceBitmapData == null) ? destBitmapData : sourceBitmapData;
		sourceRect = (sourceRect == null) ? sourceBitmapData.rect : sourceRect;
		destPoint = (destPoint == null) ? new Point() : destPoint;
		
		destBitmapData.applyFilter(sourceBitmapData, sourceRect, destPoint, new ColorMatrixFilter(sepiaFilter));
	}

}