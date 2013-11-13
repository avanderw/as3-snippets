package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function checkerboardPattern(size:int = 4, c1:uint = 0xFF000000, c2:uint = 0):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0);
		for (var row:int = 0; row < size; row++) 
			for (var col:int = 0; col < size; col++)
				if (row < size / 2)
					arr[row][col] = col < size / 2 ? c1 : c2;
				else
					arr[row][col] = col < size / 2 ? c2 : c1;
				
		
		return makePattern(arr);
	}
}