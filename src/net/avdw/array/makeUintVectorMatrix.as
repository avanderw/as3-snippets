package net.avdw.array
{
	public function makeUintVectorMatrix(rows:uint, cols:uint, initValue:uint):Vector.<Vector.<uint>>
	{
		var matrix:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
		for (var y:int = 0; y < rows; y++)
		{
			var row:Vector.<uint> = new Vector.<uint>();
			for (var x:int = 0; x < cols; x++)
				row.push(initValue);
			matrix.push(row);
		}
		return matrix;
	}
}