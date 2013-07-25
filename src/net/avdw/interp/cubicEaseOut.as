package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function cubicEaseOut(p:Number):Number
	{
		return 1 - cubicEaseIn(1 - p);
	}

}