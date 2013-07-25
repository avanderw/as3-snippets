package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function backEaseOut(p:Number):Number
	{
		return 1 - backEaseIn(1 - p);
	}

}