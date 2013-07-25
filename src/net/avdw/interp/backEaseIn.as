package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function backEaseIn(p:Number):Number
	{
		return p * p * (3 * p - 2);
	}

}