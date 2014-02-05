package net.avdw.generate
{
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.cellular.calcNumWallsNStepsFromPoint;
	import net.avdw.cellular.fillGapsAndSmooth;
	import net.avdw.cellular.smoothEdges;
	import net.avdw.number.SeededRNG;
	
	/**
	 * http://roguebasin.roguelikedevelopment.org/index.php?title=Cellular_Automata_Method_for_Generating_Random_Cave-Like_Levels
	 * 
	 * @param	width
	 * @param	height
	 * @param	smoothness
	 * @param	density (continuous) ? .35 : .5
	 * @param	continuous reduces isolated caves
	 * @param	seed
	 * @return
	 */
	public function makeCave(width:int, height:int = 0, smoothness:int = 4, density:Number = 0.35, continuous:Boolean = true, seed:int = 0):Vector.<Vector.<int>>
	{
		seed = seed == 0 ? Math.random() * int.MAX_VALUE : seed;
		height = height == 0 ? width : height;
		var rnd:SeededRNG = new SeededRNG(seed);
		
		var map:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		for (var y:int = 0; y < height; y++)
		{
			var row:Vector.<int> = new Vector.<int>();
			for (var x:int = 0; x < width; x++)
				row.push(rnd.bit(density));
			map.push(row);
		}
		
		if (continuous)
			fillGapsAndSmooth(map, smoothness);
		
		smoothEdges(map, smoothness);
		
		return map;
	}

}