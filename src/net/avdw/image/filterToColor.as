package net.avdw.image
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.avdw.color.extractARGB;
	
	/**
	 * Makes a bitmap data object the color provided.
	 * 
	 * @param	destBitmapData		The destination bitmap data object.
	 * @param	color				The color to make the image.
	 * @param	sourceBitmapData	The source bitmap data where the pixel data is retrieved. The destination bitmap data will be used if not provided.
	 * @param	sourceRect			The clipping rectangle for the source bitmap data. No clipping will occur if not provided.
	 * @param	destPoint			The upper left point to draw the clipping into the destination bitmap data. (0,0) will be used if not provided.
	 */
	public function filterToColor(destBitmapData:BitmapData, color:uint, sourceBitmapData:BitmapData = null, sourceRect:Rectangle = null, destPoint:Point = null):void
	{
		var target:Object = extractARGB(color);
		
		const recolorFilter:Array = [
			0.15, 0.295, 0.055, 0, target.r / 2,
			0.15, 0.295, 0.055, 0, target.g / 2,
			0.15, 0.295, 0.055, 0, target.b / 2,
			   0,     0,     0, 1, 0
		];
		
		sourceBitmapData = (sourceBitmapData == null) ? destBitmapData : sourceBitmapData;
		sourceRect = (sourceRect == null) ? sourceBitmapData.rect : sourceRect;
		destPoint = (destPoint == null) ? new Point() : destPoint;
		
		destBitmapData.applyFilter(sourceBitmapData, sourceRect, destPoint, new ColorMatrixFilter(recolorFilter));
	}
}