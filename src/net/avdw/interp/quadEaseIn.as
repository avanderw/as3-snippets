package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quadEaseIn(p:Number):Number
	{
		return Math.pow(p, 2);
	}
}