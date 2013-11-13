package net.avdw.array
{
	public function createIntVectorMatrix(rows:int, cols:int, initValue:int):Vector.<Vector.<int>>
	{
		var matrix:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		for (var y:int = 0; y < rows; y++)
		{
			var row:Vector.<int> = new Vector.<int>();
			for (var x:int = 0; x < cols; x++)
				row.push(initValue);
			matrix.push(row);
		}
		return matrix;
	}
}