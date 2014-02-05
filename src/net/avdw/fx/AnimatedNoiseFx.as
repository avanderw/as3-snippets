package net.avdw.fx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class AnimatedNoiseFx extends Bitmap
	{
		
		public function AnimatedNoiseFx(parent:DisplayObjectContainer, overlay:Boolean = true) 
		{
			var _width:int = parent is Stage ? (parent as Stage).stageWidth : parent.width;
			var _height:int = parent is Stage ? (parent as Stage).stageHeight : parent.height;
			
			bitmapData = new BitmapData(_width, _height, false, 0);			
			
			addEventListener(Event.ENTER_FRAME, animate);
			blendMode = overlay ? BlendMode.OVERLAY : BlendMode.NORMAL;
			alpha = overlay ? 0.2 : 1;
			parent.addChild(this);
		}
		
		private function animate(e:Event):void 
		{
			bitmapData.noise(Math.random() * int.MAX_VALUE, 0, 255, BitmapDataChannel.RED | BitmapDataChannel.GREEN | BitmapDataChannel.BLUE, true);
		}
		
	}

}