package net.avdw.cellular
{
	import net.avdw.array.copyIntVectorMatrixInto;
	import net.avdw.array.createIntVectorMatrix;
	
	public function fillGapsAndSmooth(map:Vector.<Vector.<int>>, smoothness:int):void
	{
		var i:int, x:int, y:int;
		var height:int = map.length;
		var width:int = map[0].length;
		
		var mapBuffer:Vector.<Vector.<int>>;
		var oneStepWallCount:int;
		var twoStepWallCount:int;
		
		var isBorder:Boolean;
		var atLeast5Walls:Boolean;
		var atMost2Walls:Boolean;
		
		for (i = 0; i < smoothness; i++)
		{
			mapBuffer = createIntVectorMatrix(height, width, 0);
			for (y = 0; y < height; y++)
			{
				for (x = 0; x < width; x++)
				{
					oneStepWallCount = calcNumWallsNStepsFromPoint(map, x, y, 1);
					twoStepWallCount = calcNumWallsNStepsFromPoint(map, x, y, 2);
					
					isBorder = x == 0 || y == 0 || x == width - 1 || y == height - 1;
					atLeast5Walls = oneStepWallCount >= 5 || (oneStepWallCount + map[y][x]) >= 5;
					atMost2Walls = (twoStepWallCount + map[y][x]) <= 2;
					
					mapBuffer[y][x] = (isBorder || atLeast5Walls || atMost2Walls) ? 1 : 0;
				}
			}
			copyIntVectorMatrixInto(mapBuffer, map);
		}
	}
}