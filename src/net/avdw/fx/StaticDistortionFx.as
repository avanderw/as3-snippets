package net.avdw.fx
{
	import flash.display.Bitmap;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import net.avdw.generate.makeStaticDisplacementMap;
	import net.avdw.number.SeededRNG;
	
	public class StaticDistortionFx
	{
		public var minScaleX:int = 0;
		public var maxScaleX:int = 2;
		
		private var displayObj:DisplayObject;
		private var displacementFilter:DisplacementMapFilter;
		
		public function StaticDistortionFx(displayObj:DisplayObject)
		{
			this.displayObj = displayObj;
			displacementFilter = new DisplacementMapFilter(makeStaticDisplacementMap(displayObj.width, displayObj.height * 2), new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED, 0, 1, DisplacementMapFilterMode.COLOR, 0, 0);
			displayObj.addEventListener(Event.ENTER_FRAME, animate);
		}
		
		public function low():void {
			minScaleX = 0;
			maxScaleX = 2;
		}
		
		public function medium():void {
			minScaleX = 2;
			maxScaleX = 6;
		}
		
		public function high():void {
			minScaleX = 12;
			maxScaleX = 25;
		}
		
		private function animate(e:Event):void
		{
			displacementFilter.mapPoint = new Point(0, -Math.random() * displacementFilter.mapBitmap.height / 2);
			displacementFilter.scaleX = SeededRNG.float(minScaleX, maxScaleX);
			
			displayObj.filters = [displacementFilter];
		}
	}

}