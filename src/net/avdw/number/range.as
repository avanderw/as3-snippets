package net.avdw.number
{
	/**
	 * Returns a number for the range between two values.
	 * @param	firstValue
	 * @param	lastValue
	 * @return a positive value indicating the range between two values
	 */
	public function range(firstValue:Number, lastValue:Number):Number
	{
		return Math.abs(Math.max(firstValue, lastValue) - Math.min(firstValue, lastValue));
	}

}