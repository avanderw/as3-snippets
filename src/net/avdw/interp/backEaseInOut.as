package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function backEaseInOut(p:Number):Number
	{
		return (p < .5) ? backEaseIn(p * 2) / 2 : backEaseIn(p * -2 + 2) / -2 + 1;
	}

}