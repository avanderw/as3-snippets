package net.avdw.number
{
	/**
	 * 
	 * @param	value
	 * @param	minValue
	 * @param	maxValue
	 * @return
	 */
	public function normalize(number:Number, firstBound:Number, lastBound:Number = NaN):Number
	{
		if (isNaN(lastBound))
			lastBound = 0;
			
		return (number - Math.min(firstBound, lastBound)) / rangeBetween(firstBound, lastBound);
	}

}