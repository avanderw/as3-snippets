package net.avdw.fx
{
	import flash.display.DisplayObject;
	
	public class CenterSlideFx
	{
		static public function hideHorizontally(displayObject:DisplayObject, effectMillis:int = 1000, interp:Function = null, callback:Function = null):void
		{
			new HorizontalControl(displayObject, effectMillis, interp, callback).hide();
		}
		
		static public function hideVertically(displayObject:DisplayObject, effectMillis:int = 1000, interp:Function = null, callback:Function = null):void
		{
			new VerticalControl(displayObject, effectMillis, interp, callback).hide();
		}
		
		static public function revealHorizontally(displayObject:DisplayObject, effectMillis:int = 1000, interp:Function = null, callback:Function = null):void
		{
			new HorizontalControl(displayObject, effectMillis, interp, callback).reveal();
		}
		
		static public function revealVertically(displayObject:DisplayObject, effectMillis:int = 1000, interp:Function = null, callback:Function = null):void
		{
			new VerticalControl(displayObject, effectMillis, interp, callback).reveal();
		}
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
	private var interp:Function;
	private var fxBmp:Bitmap;
	private var callback:Function;
	private var isReveal:Boolean;
	
	protected var halfway:int;
	protected var pixelCache:BitmapData;
	protected var srcSideAClipRect:Rectangle;
	protected var srcSideBClipRect:Rectangle;
	protected var dstPointA:Point;
	protected var dstPointB:Point;
	
	public function FxControl(displayObject:DisplayObject, effectMillis:int, interp:Function, callback:Function)
	{
		this.callback = callback;
		this.interp = interp;
		this.effectMillis = effectMillis;
		this.displayObject = displayObject;
		
		if (interp == null)
			this.interp = linear;
		
		setup();
	}
	
	public function reveal():void {
		isReveal = true;
		fxBmp.addEventListener(Event.ENTER_FRAME, animate);
	}
	
	public function hide():void {
		isReveal = false;
		fxBmp.addEventListener(Event.ENTER_FRAME, animate);
	}
	
	protected function setup():void
	{
		lastMillis = getTimer();
		displayObject.visible = false;
		
		// create pixel cache, without transforms
		var tmpTransformMatrix:Matrix = displayObject.transform.matrix.clone();
		displayObject.transform.matrix = new Matrix();
		pixelCache = new BitmapData(displayObject.width, displayObject.height, true, 0);
		pixelCache.draw(displayObject);
		displayObject.transform.matrix = tmpTransformMatrix;
		
		fxBmp = new Bitmap(new BitmapData(pixelCache.width, pixelCache.height));
		displayObject.parent.addChild(fxBmp);
	}
	
	protected function resizeRectangles(pixels:int):void
	{
		throw new Error("this method is abstract");
	}

	private function animate(e:Event):void
	{
		var progress:Number = normalize(getTimer() - lastMillis, effectMillis);
		var pixels:int = interp(progress) * halfway;
		resizeRectangles(isReveal ? pixels : halfway - pixels);
		
		fxBmp.bitmapData.fillRect(fxBmp.bitmapData.rect, 0x0);
		fxBmp.bitmapData.copyPixels(pixelCache, srcSideAClipRect, dstPointA, null, null, true);
		fxBmp.bitmapData.copyPixels(pixelCache, srcSideBClipRect, dstPointB, null, null, true);
		fxBmp.transform.matrix = displayObject.transform.matrix;
		
		if (progress >= 1)
		{
			fxBmp.removeEventListener(Event.ENTER_FRAME, animate);
			fxBmp.bitmapData.dispose();
			displayObject.parent.removeChild(fxBmp);
			
			displayObject.visible = isReveal;
		
			if (callback != null)
				callback();
		}
	}
}

class HorizontalControl extends FxControl
{
	public function HorizontalControl(displayObject:DisplayObject, effectMillis:int, interp:Function, callback:Function)
	{
		super(displayObject, effectMillis, interp, callback);
	}
	
	override protected function resizeRectangles(pixels:int):void
	{
		srcSideAClipRect.width = srcSideBClipRect.width = pixels;
		dstPointA.x = halfway - srcSideAClipRect.width;
		srcSideBClipRect.x = pixelCache.width - srcSideBClipRect.width;
	}
	
	override protected function setup():void 
	{
		super.setup();
		halfway = pixelCache.width >> 1;
		
		dstPointA = new Point(0, 0);
		srcSideAClipRect = new Rectangle(0, 0, 0, pixelCache.height);
		
		dstPointB = new Point(halfway, 0);
		srcSideBClipRect = new Rectangle(0, 0, 0, pixelCache.height);
	}
}

class VerticalControl extends FxControl
{
	public function VerticalControl(displayObject:DisplayObject, effectMillis:int, interp:Function, callback:Function)
	{
		super(displayObject, effectMillis, interp, callback);
	}

	override protected function resizeRectangles(pixels:int):void
	{
		srcSideAClipRect.height = srcSideBClipRect.height = pixels;
		dstPointA.y = halfway - srcSideAClipRect.height;
		srcSideBClipRect.y = pixelCache.height - srcSideBClipRect.height;
	}
	
	override protected function setup():void 
	{
		super.setup();
		halfway = pixelCache.height >> 1;
		
		dstPointA = new Point(0, 0);
		srcSideAClipRect = new Rectangle(0, 0, pixelCache.width, 0);
		
		dstPointB = new Point(0, halfway);
		srcSideBClipRect = new Rectangle(0, 0, pixelCache.width, 0);
	}
}