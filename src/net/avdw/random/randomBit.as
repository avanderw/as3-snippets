package net.avdw.random
{
	/**
	 * randBit(); // returns 1 or 0 (50% chance of 1)
	 * randBit(0.8); // returns 1 or 0 (80% chance of 1)
	 * @param	chance
	 * @return
	 */
	public function randomBit(chance:Number = 0.5):int
	{
		return (randomBoolean(chance)) ? 1 : 0;
	}
}