package net.avdw.render
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.ConvolutionFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public function renderColorHeightmap(map:Vector.<Vector.<Number>>):BitmapData
	{
		var colorMap:Array = createHeightmapColors();
		var bmpData:BitmapData = renderGrayscaleHeightmap(map);
		bmpData.paletteMap(bmpData, bmpData.rect, new Point(), colorMap[0], colorMap[1], colorMap[2]);
		
		var shadingContrastTransform:ColorTransform = new ColorTransform(2, 2, 2, 1, 160, 160, 160, 0);
		var shadingFilter:ConvolutionFilter = new ConvolutionFilter(3, 3, [-3, -2, 0, -2, 0, 2, 0, 2, 3], 3, 1, true, true);
		var shadingBmpData:BitmapData = new BitmapData(bmpData.width, bmpData.height, false, 0);
		shadingBmpData.applyFilter(bmpData, bmpData.rect, new Point(), shadingFilter);
		
		bmpData.draw(shadingBmpData, null, shadingContrastTransform, BlendMode.MULTIPLY);
		
		return bmpData;
	}

}