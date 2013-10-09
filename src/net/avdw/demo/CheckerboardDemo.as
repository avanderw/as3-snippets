package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.avdw.generate.checkerboard;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class CheckerboardDemo extends Sprite
	{
		
		public function CheckerboardDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(new Bitmap(checkerboard(stage.stageWidth, stage.stageHeight)));
		}
	
	}

}