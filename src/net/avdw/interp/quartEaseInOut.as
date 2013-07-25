package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quartEaseInOut(p:Number):Number
	{
		return (p < .5) ? quartEaseIn(p * 2) / 2 : quartEaseIn(p * -2 + 2) / -2 + 1;
	}

}