package net.avdw.number
{
	public class SeededRangedRNG
	{
		private var high:Number;
		private var low:Number;
		private var seededRNG:SeededRNG;
		
		public function SeededRangedRNG(low:Number, high:Number = NaN, seed:uint = NaN)
		{
			this.low = low;
			this.high = high;
			
			seededRNG = new SeededRNG(seed == 0 ? Math.random() * uint.MAX_VALUE : seed);
		}
		
		public function nextValue():Number
		{
			return seededRNG.float(low, high);
		}
	
	}

}