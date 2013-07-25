package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function elasticEaseOut(p:Number):Number
	{
		return 1 - elasticEaseIn(1 - p);
	}

}