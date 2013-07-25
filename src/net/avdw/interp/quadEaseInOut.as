package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quadEaseInOut(p:Number):Number
	{
		return (p < .5) ? quadEaseIn(p * 2) / 2 : quadEaseIn(p * -2 + 2) / -2 + 1;
	}

}