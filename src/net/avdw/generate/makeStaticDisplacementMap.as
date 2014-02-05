package net.avdw.generate
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import net.avdw.color.combineARGB;
	import net.avdw.graphics.drawFastLine;
	
	public function makeStaticDisplacementMap(width:int, height:int):BitmapData
	{
		var bmpData:BitmapData = new BitmapData(width, height, false, 0x888888);
		var noise:BitmapData = bmpData.clone();
		noise.noise(Math.random() * int.MAX_VALUE, 0, 255, BitmapDataChannel.RED, true);
		
		var numLines:int = width * 10;
		for (var i:int = 0; i < numLines; i++)
		{
			var x:int = Math.random() * width;
			var y:int = Math.random() * height;
			var length:int = Math.random() * width * .2;
			drawFastLine(bmpData, x, y, x + length, y, combineARGB(1, Math.random()));
		}
		bmpData.draw(noise, null, null, BlendMode.OVERLAY);
		return bmpData;
	}

}