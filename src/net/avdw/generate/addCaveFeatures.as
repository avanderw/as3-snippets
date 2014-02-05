package net.avdw.generate
{
	public function addCaveFeatures(map:Vector.<Vector.<int>>):Vector.<Vector.<int>>
	{
		addCaveStalactites(map);
		addCaveStalagmites(map);
		addCaveWaterfalls(map);
		fillCaveWithWater(map);
		
		return map;
	}
}