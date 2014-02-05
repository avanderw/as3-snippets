package net.avdw.generate
{
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.cellular.fillGapsAndSmooth;
	import net.avdw.cellular.smoothEdges;
	import net.avdw.number.clamp;
	import net.avdw.number.SeededRNG;
	
	public function makeWormCave(width:int, height:int = 0, digPercentage:Number = 0.5, minerSpawnChance:Number = 0.02, minerMoveDiagonally:Boolean = true, smooth:Boolean = true, smoothAmount:int = 1, fillGaps:Boolean = true, fillAmount:int = 1, seed:int = 0):Vector.<Vector.<int>>
	{
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		height = height == 0 ? width : height;
		var rng:SeededRNG = new SeededRNG(seed);
		
		var dugBlocks:int = 0;
		var maxBlocks:int = width * height;
		var map:Vector.<Vector.<int>> = createIntVectorMatrix(height, width, 1);
		var miners:Vector.<Miner> = new Vector.<Miner>();
		miners.push(new Miner(width >> 1, height >> 1));
		
		while (dugBlocks / maxBlocks < digPercentage)
			for each (var miner:Miner in miners)
			{
				if (!miner.dig(map, minerMoveDiagonally))
					miners.splice(miners.indexOf(miner), 1);
				else
					dugBlocks++;
				
				if (rng.boolean(minerSpawnChance))
					miners.push(new Miner(miner.cell.x, miner.cell.y));
				
				if (miners.length == 0)
					miners.push(new Miner(clamp(miner.cell.x + rng.sign(.5) * 2, width - 2, 1), clamp(miner.cell.y + rng.sign(.5) * 2, height - 2, 1)));
			}
		
		if (fillGaps)
			fillGapsAndSmooth(map, fillAmount);
		
		if (smooth)
			smoothEdges(map, smoothAmount);
		
		return map;
	}

}
import flash.geom.Point;
import net.avdw.number.SeededRNG;

class Miner
{
	public var cell:Point;
	
	public function Miner(x:int, y:int)
	{
		cell = new Point(x, y);
	}
	
	public function dig(map:Vector.<Vector.<int>>, minerMoveDiagonally:Boolean = true, rng:SeededRNG = null):Boolean
	{
		map[cell.y][cell.x] = 0;
		
		var moveToCells:Vector.<Point> = new Vector.<Point>();
		var xRange:Object = {low: Math.max(1, cell.x - 1), high: Math.min(map[0].length - 2, cell.x + 1)};
		var yRange:Object = {low: Math.max(1, cell.y - 1), high: Math.min(map.length - 2, cell.y + 1)};
		
		for (var x:int = xRange.low; x <= xRange.high; x++)
			for (var y:int = yRange.low; y <= yRange.high; y++)
			{
				if ((x == cell.x && y == cell.y) || (!minerMoveDiagonally && ((x == cell.x - 1 && y == cell.y - 1) || (x == cell.x + 1 && y == cell.y - 1) || (x == cell.x - 1 && y == cell.y + 1) || (x == cell.x + 1 && y == cell.y + 1))))
					continue;
				
				if (map[y][x] == 1)
					moveToCells.push(new Point(x, y));
			}
		
		if (moveToCells.length == 0)
			return false;
		
		if (rng == null)
			rng = new SeededRNG(Math.random() * int.MAX_VALUE);
		
		cell = moveToCells[rng.integer(moveToCells.length)];
		return true;
	}
}