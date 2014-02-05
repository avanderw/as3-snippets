package net.avdw.array
{
	public function createNumberVectorMatrix(rows:int, cols:int, initValue:Number):Vector.<Vector.<Number>>
	{
		var matrix:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
		for (var y:int = 0; y < rows; y++)
		{
			var row:Vector.<Number> = new Vector.<Number>();
			for (var x:int = 0; x < cols; x++)
				row.push(initValue);
			matrix.push(row);
		}
		return matrix;
	}
}