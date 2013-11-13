package net.avdw.array
{
	public function createObjectVectorMatrix(rows:int, cols:int, initValue:Object):Vector.<Vector.<Object>>
	{
		var matrix:Vector.<Vector.<Object>> = new Vector.<Vector.<Object>>();
		for (var y:int = 0; y < rows; y++)
		{
			var row:Vector.<Object> = new Vector.<Object>();
			for (var x:int = 0; x < cols; x++)
				row.push(initValue);
			matrix.push(row);
		}
		return matrix;
	}
}