package net.avdw.demo 
{
	import com.adobe.net.MimeTypeMap;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import uk.co.soulwire.gui.SimpleGUI;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	[SWF(backgroundColor="0x0",frameRate="60",width="680",height="495")]
	public class BloomFxDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/256x256 Monster.png")]
		private const _monster:Class;
		[Embed(source="../../../../../assets/images/256x256 Yoda.png")]
		private const _yoda:Class;
		[Embed(source="../../../../../assets/images/300x300 Sun.jpg")]
		private const _sun:Class;
		
		private const images:Array = [new _monster(), new _yoda(), new _sun()];
		private var imageIndex:int = 0;
		
		public var blur:int = 16;
		public var passes:int = 4;
		
		private const matrix:Array = [
			0.3, 0.59, 0.11, 0, 0,
			0.3, 0.59, 0.11, 0, 0,
			0.3, 0.59, 0.11, 0, 0,
			  0,    0,    0, 1, 0];
		private const zero:Point = new Point();
		
		private var result:Bitmap;
		private var grayscale:Bitmap;
		private var image:Bitmap;
		
		public function BloomFxDemo() 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x0)));
			
			var gui:SimpleGUI = new SimpleGUI(this, "Faked Bloom Effect");
			gui.addSlider("blur", 4, 32, { callback:update } );
			gui.addSlider("passes", 1, 6, { callback:update } );
			gui.addButton("Next image", { callback:next } );
			gui.show();
			
			next();
		}
		
		private function next():void {
			if (image != null) {
				removeChild(image);
				removeChild(result);
			}
			
			image = images[imageIndex];
			grayscale = new Bitmap(new BitmapData(image.width, image.height, true, 0x0));
			result = new Bitmap(new BitmapData(image.width, image.height, true, 0x0));
			
			addChild(image);
			addChild(result);
			
			grayscale.bitmapData.applyFilter(image.bitmapData, image.getRect(image), zero, new ColorMatrixFilter(matrix));
			
			result.y = grayscale.y = image.y = stage.stageHeight - image.height;
			result.x = stage.stageWidth - image.width;
			image.x = result.x - result.width-5;
			
			if (++imageIndex == images.length) {
				imageIndex = 0;
			}
			
			update();
		}
		
		private function update():void {
			result.bitmapData.draw(grayscale);
			for (var i:int = 0; i < passes; i++) {
				result.bitmapData.draw(result, null, null, BlendMode.MULTIPLY);
				// result.bitmapData.draw(grayscale, null, null, BlendMode.MULTIPLY); // more pronounced
			}
			result.bitmapData.draw(image, null, null, BlendMode.MULTIPLY);
			result.bitmapData.applyFilter(result.bitmapData, result.getRect(result), zero, new BlurFilter(blur, blur, BitmapFilterQuality.MEDIUM));
			result.bitmapData.draw(image, null, null, BlendMode.ADD);
		}
		
	}

}