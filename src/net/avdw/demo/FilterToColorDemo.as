package net.avdw.demo
{
	import com.bit101.components.ColorChooser;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import net.avdw.image.filter.filterToColor;
	import net.avdw.textfield.createTextField;
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class FilterToColorDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/256x256 Monster.png")]
		private const ImageClass:Class;
		private var filteredBmp:Bitmap;
		private var originalBmp:Bitmap;
		
		public function FilterToColorDemo()
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
			filterToColor(filteredBmp.bitmapData, 0xFF)
			
			var colorSelector:ColorChooser = new ColorChooser(this, 0, 0, 0xFF, process);
			colorSelector.x = (stage.stageWidth - colorSelector.width) / 2;
			colorSelector.y = originalBmp.y - 2 * colorSelector.height;
		}
		
		private function process(e:Event):void
		{
			filteredBmp.bitmapData = originalBmp.bitmapData.clone();
			filterToColor(filteredBmp.bitmapData, e.target.value);
		}
	
	}

}