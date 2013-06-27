package net.avdw.image
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.avdw.color.extractARGB;
	
	public function filterColor(destBitmapData:BitmapData, color:uint, sourceBitmapData:BitmapData = null, sourceRect:Rectangle = null, destPoint:Point = null):void
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