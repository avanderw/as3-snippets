package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function stepPattern(size:int = 9, thickness:int = 1, c:uint = 0xFF000000, down:Boolean = true):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0);
		
		for (var line:int = 0; line < thickness; line++)
			for (var offset:int = 0; offset < Math.ceil(size / 2); offset++)
				if (down)
				{
					arr[line][offset] = c;
					arr[Math.floor(size / 2) + line][Math.floor(size / 2) + offset] = c;
					arr[Math.floor(size / 2) + offset][line] = c;
					arr[offset][Math.floor(size / 2) + line] = c;
				}
				else
				{
					throw new Error("up not implemented");
				}
		
		return makePattern(arr);
	}
}