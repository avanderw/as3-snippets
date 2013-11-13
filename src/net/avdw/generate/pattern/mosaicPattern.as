package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function mosaicPattern(size:int = 3, c1:uint = 0xFFFFFFFF, c2:uint = 0xFF000000):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0xFF000000);
		
		arr[0][0] = c1;
		arr[size - 1][size - 1] = c2;
		
		for (var i:int = 1; i < size - 1; i++)
		{
			arr[i][0] = c1;
			arr[i][size - 1] = c2;
		}
		
		for (i = 1; i < size - 1; i++)
		{
			arr[0][i] = c1;
			arr[size - 1][i] = c2;
		}
		
		return makePattern(arr);
	}

}