package net.avdw.number
{
	
	public class InterpolatedNG
	{
		private var sampledNumbers:Vector.<Number>;
		private var startingNumber:Number;
		private var endingNumber:Number;
		private var numberOfSamples:Number;
		private var currentIndex:int = -1;
		private var direction:int = 1;
		private var wrap:Boolean;
		
		public function InterpolatedNG(startingNumber:Number, endingNumber:Number, numberOfSamples:Number, interpolationFunction:Function = null, wrap:Boolean = false)
		{
			this.wrap = wrap;
			this.numberOfSamples = numberOfSamples;
			this.endingNumber = endingNumber;
			this.startingNumber = startingNumber;
			
			sampledNumbers = sampleBetween(startingNumber, endingNumber, numberOfSamples, interpolationFunction);
		}
		
		public function nextValue():Number
		{
			currentIndex += direction;
			
			if (currentIndex < 0 || currentIndex == numberOfSamples)
			{
				if (wrap)
				{
					currentIndex %= sampledNumbers.length;
				}
				else
				{
					direction *= -1;
					currentIndex += direction;
				}
			}
			
			return sampledNumbers[currentIndex];
		}
	}
}