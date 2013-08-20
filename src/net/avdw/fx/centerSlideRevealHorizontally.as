package net.avdw.fx
{
	import flash.display.DisplayObject;
	
	public function centerSlideRevealHorizontally(displayObject:DisplayObject, effectMillis:int = 1000, interp:Function = null, callback:Function = null):void
	{
		new FxControl(displayObject, effectMillis, interp, callback);
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.getTimer;

import net.avdw.interp.linear;
import net.avdw.number.normalize;

class FxControl
{
	private var displayObject:DisplayObject;
	private var effectMillis:int;
	private var lastMillis:int;
	private var callback:Function;
	private var interp:Function;
	private var fxBmp:Bitmap;
	
	private var halfway:int;
	private var pixelCache:BitmapData;
	private var sideAClipRect:Rectangle;
	private var sideBClipRect:Rectangle;
	private var pointA:Point;
	private var pointB:Point;
	
	public function FxControl(displayObject:DisplayObject, effectMillis:int, interp:Function, callback:Function)
	{
		this.callback = callback;
		this.interp = interp;
		this.effectMillis = effectMillis;
		this.displayObject = displayObject;
		
		if (interp == null)
			this.interp = linear;
		
		lastMillis = getTimer();
		displayObject.visible = false;
		
		var tmpTransformMatrix:Matrix = displayObject.transform.matrix.clone();
		displayObject.transform.matrix = new Matrix();
		pixelCache = new BitmapData(displayObject.width, displayObject.height);
		pixelCache.draw(displayObject);
		displayObject.transform.matrix = tmpTransformMatrix;
		
		fxBmp = new Bitmap(new BitmapData(pixelCache.width, pixelCache.height));
		fxBmp.addEventListener(Event.ENTER_FRAME, animate);
		displayObject.parent.addChild(fxBmp);
		
		setupRectangles();
	}
	
	private function animate(e:Event):void
	{
		var progress:Number = normalize(getTimer() - lastMillis, effectMillis);
		animateRectangles(interp(progress) * halfway);
		
		fxBmp.bitmapData.copyPixels(pixelCache, sideAClipRect, pointA);
		fxBmp.bitmapData.copyPixels(pixelCache, sideBClipRect, pointB);
		fxBmp.transform.matrix = displayObject.transform.matrix;
		
		if (progress >= 1)
		{
			fxBmp.bitmapData.dispose();
			displayObject.parent.removeChild(fxBmp);
			displayObject.visible = true;
			
			fxBmp.removeEventListener(Event.ENTER_FRAME, animate);
			
			if (callback != null)
				callback();
		}
	}
	
	private function setupRectangles():void
	{
		halfway = pixelCache.width >> 1;
		sideAClipRect = new Rectangle(0, 0, 0, pixelCache.height);
		sideBClipRect = new Rectangle(pixelCache.width, 0, 0, pixelCache.height);
		pointA = new Point(halfway, 0);
		pointB = new Point(halfway, 0);
	}
	
	private function animateRectangles(pixels:int):void
	{
		sideAClipRect.width = sideBClipRect.width = pixels;
		pointA.x = halfway - sideAClipRect.width;
		sideBClipRect.x = pixelCache.width - sideBClipRect.width;
	}

}