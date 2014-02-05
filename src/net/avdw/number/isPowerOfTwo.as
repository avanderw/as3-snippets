package net.avdw.number
{
	/**
	 * Determines if a value is a power of 2
	 *
	 * @param	val
	 * @return
	 */
	public function isPowerOfTwo(val:uint):Boolean
	{
		return (val != 0) && ((val & (val - 1)) == 0);
	}
}