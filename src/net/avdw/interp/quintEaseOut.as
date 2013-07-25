package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quintEaseOut(p:Number):Number
	{
		return 1 - quintEaseIn(1 - p);
	}
}