package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function bounceEaseOut(p:Number):Number
	{
		return 1 - bounceEaseIn(1 - p);
	}

}