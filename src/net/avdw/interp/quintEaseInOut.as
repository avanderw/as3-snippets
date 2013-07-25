package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quintEaseInOut(p:Number):Number
	{
		return (p < .5) ? quintEaseIn(p * 2) / 2 : quintEaseIn(p * -2 + 2) / -2 + 1;
	}

}