package net.avdw.array
{
	public function copyIntVectorMatrixInto(fromMatrix:Vector.<Vector.<int>>, toMatrix:Vector.<Vector.<int>>):void
	{
		var height:int = fromMatrix.length;
		var width:int = fromMatrix[0].length;
		
		for (var y:int = 0; y < height; y++)
			for (var x:int = 0; x < width; x++)
				toMatrix[y][x] = fromMatrix[y][x];
	}
}