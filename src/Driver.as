package
{
	import avdw.math.noise.generator.CBillow2D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.avdw.libnoise.noise.billowNoise;
	import net.avdw.libnoise.noise.ridgedMultiNoise;
	import net.avdw.libnoise.noise.perlinNoise;
	import net.avdw.libnoise.noise.voronoiNoise;
	import net.avdw.color.combineARGB;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Driver extends Sprite
	{
		private var bmpData:BitmapData;
		
		public function Driver()
		{
			bmpData = new BitmapData(64, 64);
			
			if (stage) voronoi();
			else addEventListener(Event.ADDED_TO_STAGE, voronoi);
			
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.scaleX = bmp.scaleY = 4;
			addChild(bmp);
		}
		
		private function voronoi(e:Event = null):void 
		{
			bmpData.lock();
			
			var seed:uint = Math.random() * 0xFF;
			for (var y:int = 0; y < bmpData.height; y++)
			{
				for (var x:int = 0; x < bmpData.width; x++)
				{
					var xDim:Number = x / (bmpData.width - 1);
					var yDim:Number = y / (bmpData.height - 1);
					var zDim:Number = 5;
					var enableDistance:Boolean = true;
					
					var noise:Number = voronoiNoise(xDim, yDim , zDim, seed, enableDistance, 8);
					
					var byte:int = (noise + 1) * 0xFF * .5;
					var color:uint = combineARGB(255, byte, byte, byte);
					bmpData.setPixel(x, y, color);
				}
			}
			bmpData.unlock();
			
		}
	
	}
}