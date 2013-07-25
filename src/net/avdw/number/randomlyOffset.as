package net.avdw.number
{
	public function randomlyOffset(baseNumber:Number, minOffset:Number, maxOffset:Number = NaN, inBothDirections:Boolean = true):Number
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