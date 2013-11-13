package net.avdw.demo 
{
	import fl.transitions.TransitionManager;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class BasicTransitionFxDemo extends Sprite
	{
		
		public function BasicTransitionFxDemo() 
		{
			if (stage) startDrag();
			else addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		private function start(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, start);
			
			[Embed(source="../../../../../assets/images/239x340 Card Sample 1.png")]
			const ImgClass:Class;
			
			var bmp:Bitmap = new ImgClass();
			addChild(bmp);
			
			TransitionManager.start(bmp);
		}
		
	}

}