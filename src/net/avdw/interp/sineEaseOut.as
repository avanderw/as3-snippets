package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function sineEaseOut(p:Number):Number
	{
		return 1 - sineEaseIn(1 - p);
	}

}