package net.avdw.interp
{
	/**
	 *
	 * @param	p	number in the range [-1,1]
	 * @return
	 */
	public function bounceEaseIn(p:Number):Number
	{
		var pow2:Number, bounce:Number = 4;
		
		while (p < ((pow2 = Math.pow(2, --bounce)) - 1) / 11)
		{
		}
		return 1 / Math.pow(4, 3 - bounce) - 7.5625 * Math.pow((pow2 * 3 - 2) / 22 - p, 2);
	}

}