package net.avdw.physics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public function overlap(displayObjectA:DisplayObject, displayObjectB:DisplayObject, stage:Stage, overlapTolerance:int = 127, debugBmp:Bitmap = null):Boolean
	{
		if (debugBmp != null)
			debugBmp.bitmapData = null;
	
		var intersectionRect:Rectangle = displayObjectA.getRect(stage).intersection(displayObjectB.getRect(stage));
		if (intersectionRect.isEmpty())
			return false;
		
		intersectionRect.x = Math.floor(intersectionRect.x);
		intersectionRect.y = Math.floor(intersectionRect.y);
		intersectionRect.width = Math.ceil(intersectionRect.width);
		intersectionRect.height = Math.ceil(intersectionRect.height);
		
		if (intersectionRect.isEmpty())
			return false;
		
		var overlapAreaData:BitmapData = new BitmapData(intersectionRect.width, intersectionRect.height);
		
		var matrixA:Matrix = displayObjectA.transform.matrix.clone();
		matrixA.translate(-intersectionRect.x, -intersectionRect.y);
		
		var matrixB:Matrix = displayObjectB.transform.matrix.clone();
		matrixB.translate(-intersectionRect.x, -intersectionRect.y);
		
		overlapAreaData.draw(displayObjectA, matrixA, new ColorTransform(0, 0, 0, 1, 255, -255, -255, overlapTolerance), BlendMode.NORMAL);
		overlapAreaData.draw(displayObjectB, matrixB, new ColorTransform(0, 0, 0, 1, 255, 255, 255, overlapTolerance), BlendMode.DIFFERENCE);
		
		if (debugBmp != null)
		{ 
			overlapAreaData.threshold(overlapAreaData, overlapAreaData.rect, new Point(), "!=", 0xFF00FFFF, 0);
			debugBmp.bitmapData = overlapAreaData;
			debugBmp.x = intersectionRect.x;
			debugBmp.y = intersectionRect.y;
		}
		
		var overlapRect:Rectangle = overlapAreaData.getColorBoundsRect(0xFFFFFFFF, 0xFF00FFFF);
		
		if (overlapRect.isEmpty())
			return false;
		
		return true;
	}

}