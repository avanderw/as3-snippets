package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.image.filter.filterToSepia;
	
	public class FilterToSepiaDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/256x256 Monster.png")]
		private const ImageClass:Class;
		private var filteredBmp:Bitmap;
		private var originalBmp:Bitmap;
		
		public function FilterToSepiaDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			originalBmp = new ImageClass();
			originalBmp.x = (stage.stageWidth - 2 * originalBmp.width) / 2;
			originalBmp.y = (stage.stageHeight - originalBmp.height) / 2;
			addChild(originalBmp);
			
			filteredBmp = new Bitmap(originalBmp.bitmapData.clone());
			filteredBmp.x = originalBmp.x + originalBmp.width;
			filteredBmp.y = originalBmp.y;
			addChild(filteredBmp);
			
			filterToSepia(filteredBmp.bitmapData);
		}
	
	}

}