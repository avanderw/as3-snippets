package net.avdw.generate
{
	import net.avdw.array.createNumberVectorMatrix;
	import net.avdw.number.normalize;
	import net.avdw.number.SeededRNG;
	
	/**
	 *
	 * @param	size must be 2^n+1
	 * @param	seed
	 * @return
	 */
	public function diamondSquare(size:int, seed:uint = 0):Vector.<Vector.<Number>>
	{
		seed = seed == 0 ? Math.random() * uint.MAX_VALUE : seed;
		
		var min:Number = Number.MAX_VALUE;
		var max:Number = Number.MIN_VALUE;
		var map:Vector.<Vector.<Number>> = createNumberVectorMatrix(size, size, 0);
		var rng:SeededRNG = new SeededRNG(seed);
		
		map[0][0] = rng.random();
		map[0][size - 1] = rng.random();
		map[size - 1][0] = rng.random();
		map[size - 1][size - 1] = rng.random();
		
		var offset:Number = 0.5;
		for (var length:int = size - 1; length >= 2; length >>= 1, offset *= .5)
		{
			var halfLength:int = length >> 1;
			
			// square
			for (var x:int = 0; x < size - 1; x += length)
			{
				for (var y:int = 0; y < size - 1; y += length)
				{
					var avg:Number = map[x][y] + // top left
						map[x + length][y] + // top right
						map[x][y + length] + // lower left
						map[x + length][y + length]; // lower right
					avg /= 4;
					
					map[x + halfLength][y + halfLength] = avg + rng.float(-offset, offset);
					min = Math.min(min, map[x + halfLength][y + halfLength]);
					max = Math.max(max, map[x + halfLength][y + halfLength]);
				}
			}
			
			// diamond
			for (x = 0; x < size - 1; x += halfLength)
			{
				for (y = (x + halfLength) % length; y < size - 1; y += length)
				{
					avg = map[(x - halfLength + size - 1) % (size - 1)][y] + // left of center
						map[(x + halfLength) % (size - 1)][y] + // right of center
						map[x][(y + halfLength) % (size - 1)] + // below center
						map[x][(y - halfLength + size - 1) % (size - 1)]; // above center
					avg /= 4;
					
					map[x][y] = avg + rng.float(-offset, offset);
					if (x == 0)
						map[size - 1][y] = map[x][y]; // wrap
					if (y == 0)
						map[x][size - 1] = map[x][y]; // wrap
					
					min = Math.min(min, map[x][y]);
					max = Math.max(max, map[x][y]);
				}
			}
		}
		
		for (x = 0; x < size; x++)
			for (y = 0; y < size; y++)
				map[x][y] = normalize(map[x][y], min, max);
		
		return map;
	}
}