package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function scanlinePattern(size:int = 3, thickness:int = 1, c:uint = 0xFF000000, horizontal:Boolean = true, both:Boolean = false):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0);
		if (horizontal || both)
			for (var row:int = 0; row < thickness; row++)
				for (var col:int = 0; col < size; col++)
					arr[row][col] = c;
		
		if (!horizontal || both)
			for (row = 0; row < size; row++)
				for (col = 0; col < thickness; col++)
					arr[row][col] = c;
		
		return makePattern(arr);
	}
}