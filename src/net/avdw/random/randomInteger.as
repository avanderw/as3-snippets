package net.avdw.random
{
	
	/**
	 * randNumber(50); returns a number between 0-50 exclusive
	 * randNumber(20,50); returns a number between 20-50 exclusive
	 * @param	min
	 * @param	max
	 * @return
	 */
	public function randomInteger(min:Number, max:Number = NaN):int
	{
		if (isNaN(max))
		{
			max = min;
			min = 0;
		}
		
		return Math.floor(randomNumber(min, max));
	}

}