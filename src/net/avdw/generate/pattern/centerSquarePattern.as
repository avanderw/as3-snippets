package net.avdw.generate.pattern
{
	import flash.display.BitmapData;
	import net.avdw.array.makeUintVectorMatrix;
	
	public function centerSquarePattern(size:uint = 5, squareSize:uint = 1, c:uint = 0xFF000000):BitmapData
	{
		var arr:Vector.<Vector.<uint>> = makeUintVectorMatrix(size, size, 0);
		for (var row:int = -Math.floor(squareSize / 2); row <= Math.floor(squareSize / 2); row++)
			for (var col:int = -Math.floor(squareSize / 2); col <= Math.floor(squareSize / 2); col++)
				arr[Math.floor(size / 2) + row][Math.floor(size / 2) + col] = c;
				
		return makePattern(arr);
	}
}