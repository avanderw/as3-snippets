package net.avdw.random
{
	/**
	 * randSign(); // returns 1 or -1 (50% chance of 1)
	 * randSign(0.8); // returns 1 or -1 (80% chance of 1)
	 * @param	chance
	 * @return
	 */
	public function randomSign(chance:Number = 0.5):int
	{
		return (randomBoolean(chance)) ? 1 : -1;
	}
}