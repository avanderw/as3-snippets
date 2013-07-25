package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function expoEaseOut(p:Number):Number
	{
		return 1 - expoEaseIn(1 - p);
	}

}