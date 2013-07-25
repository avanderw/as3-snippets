package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function expoEaseInOut(p:Number):Number
	{
		return (p < .5) ? expoEaseIn(p * 2) / 2 : expoEaseIn(p * -2 + 2) / -2 + 1;
	}

}