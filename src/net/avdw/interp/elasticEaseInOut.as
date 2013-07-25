package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function elasticEaseInOut(p:Number):Number
	{
		return (p < .5) ? elasticEaseIn(p * 2) / 2 : elasticEaseIn(p * -2 + 2) / -2 + 1;
	}

}