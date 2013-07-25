package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function bounceEaseInOut(p:Number):Number
	{
		return (p < .5) ? bounceEaseIn(p * 2) / 2 : bounceEaseIn(p * -2 + 2) / -2 + 1;
	}

}