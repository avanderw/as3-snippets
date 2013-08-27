package net.avdw.random
{
	public function randomOffsetFrom(baseNumber:Number, minOffset:Number, maxOffset:Number = NaN, inBothDirections:Boolean = true):Number
	{
		if (inBothDirections)
		{
			return baseNumber + SeededRNG.sign() * SeededRNG.float(minOffset, maxOffset);
		}
		else
		{
			return baseNumber + SeededRNG.float(minOffset, maxOffset);
		}
	}
}