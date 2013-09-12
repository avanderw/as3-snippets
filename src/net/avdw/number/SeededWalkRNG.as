package net.avdw.number
{
	import net.avdw.number.SeededRNG;
	
	public class SeededWalkRNG
	{
		private var maxWalk:Number;
		private var minWalk:Number;
		private var baseNumber:Number;
		private var inBothDirections:Boolean;
		private var seededRNG:SeededRNG;
		
		public function SeededWalkRNG(baseNumber:Number, minWalk:Number, maxWalk:Number = NaN, seed:uint = NaN, inBothDirections:Boolean = true)
		{
			this.inBothDirections = inBothDirections;
			this.minWalk = minWalk;
			this.maxWalk = maxWalk;
			this.baseNumber = baseNumber;
			
			seededRNG = new SeededRNG(seed == 0 ? Math.random() * uint.MAX_VALUE : seed);
		}
		
		public function nextValue():Number
		{
			
			if (inBothDirections)
			{
				return baseNumber += seededRNG.sign() * seededRNG.float(minWalk, maxWalk);
			}
			else
			{
				return baseNumber += seededRNG.float(minWalk, maxWalk);
			}
		}
	
	}

}