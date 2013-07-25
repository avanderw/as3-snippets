package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function cubicEaseInOut(p:Number):Number
	{
		return (p < .5) ? cubicEaseIn(p * 2) / 2 : cubicEaseIn(p * -2 + 2) / -2 + 1;
	}

}