package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function diagonalPattern(size:int = 5, thickness:int = 1, c:uint = 0xFF000000, down:Boolean = false, both:Boolean = false):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0);
		var idx:int = 0;
		for (var count:int = 0; count < size; count++)
		{
			for (var offset:int = 0; offset < thickness; offset++)
			{
				if (down || both)
					arr[count][size - (idx + offset) % size - 1] = c;
				if (!down || both)
					arr[count][(idx + offset) % size] = c;
			}
			
			if (idx == 0)
				idx = size - 1
			else
				idx--;
		}
		
		return makePattern(arr);
	}
}