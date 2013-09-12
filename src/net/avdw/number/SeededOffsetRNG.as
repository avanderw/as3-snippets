package net.avdw.number
{
	import net.avdw.number.SeededRNG;
	
	public class SeededOffsetRNG
	{
		private var maxOffset:Number;
		private var minOffset:Number;
		private var seededRNG:SeededRNG;
		private var baseNumber:Number;
		private var inBothDirections:Boolean;
		
		public function SeededOffsetRNG(baseNumber:Number, minOffset:Number, maxOffset:Number = NaN, seed:uint = NaN, inBothDirections:Boolean = true)
		{
			this.inBothDirections = inBothDirections;
			this.baseNumber = baseNumber;
			this.minOffset = minOffset;
			this.maxOffset = maxOffset;
			this.baseNumber = baseNumber;
			
			seededRNG = new SeededRNG(seed == 0 ? Math.random() * uint.MAX_VALUE : seed);
		}
		
		public function nextValue():Number
		{
			if (inBothDirections)
			{
				return baseNumber + seededRNG.sign() * seededRNG.float(minOffset, maxOffset);
			}
			else
			{
				return baseNumber + seededRNG.float(minOffset, maxOffset);
			}
		}
	
	}

}