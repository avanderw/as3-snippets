package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function quartEaseOut(p:Number):Number
	{
		return 1 - quartEaseIn(1 - p);
	}

}