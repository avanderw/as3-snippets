package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.avdw.image.filterColor;
	import net.avdw.image.filterGray;
	import net.avdw.image.filterSepia;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Driver extends Sprite
	{
		[Embed(source = "../../Images/monster.png")]
		private const Monster:Class;
		
		public function Driver() 
		{
			var bmp1:Bitmap = new Monster();
			var bmp2:Bitmap = new Monster();
			var bmp3:Bitmap = new Monster();
			
			bmp2.x = bmp1.width;
			bmp3.x = bmp2.x + bmp2.width;
			
			addChild(bmp1);
			addChild(bmp2);
			addChild(bmp3);
			
			//colorImageGray(bmp.bitmapData);
			filterColor(bmp2.bitmapData, 0xD8C3FA);
			filterSepia(bmp3.bitmapData);
			//colorImageSepia(bmp.bitmapData);
		}
		
	}

}