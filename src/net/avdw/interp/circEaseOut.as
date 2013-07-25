package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function circEaseOut(p:Number):Number
	{
		return 1 - circEaseIn(1 - p);
	}

}