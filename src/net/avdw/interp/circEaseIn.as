package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function circEaseIn(p:Number):Number
	{
		return 1 - Math.sqrt(1 - p * p);
	}

}