package net.avdw.demo
{
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class TransitionFxDemo extends Sprite
	{
		
		public function TransitionFxDemo()
		{
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			[Embed(source="../../../../../assets/images/239x340 Card Sample 1.png")]
			const Image1Class:Class;
			[Embed(source="../../../../../assets/images/239x340 Card Sample 2.png")]
			const Image2Class:Class;
			[Embed(source="../../../../../assets/images/239x340 Card Sample 3.png")]
			const Image3Class:Class;
			
			const image1:Bitmap = new Image1Class();
			const image2:Bitmap = new Image2Class();
			
			addChild(image1);
		}
	
	}

}