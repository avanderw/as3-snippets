package net.avdw.color
{
	/**
	 * Combine four 8 bit channels into a 32 bit color.
	 *
	 * @param	a	alpha channel intensity in the range [0:1].
	 * @param	r	red channel intensity in the range [0:1].
	 * @param	g	green channel intensity in the range [0:1].
	 * @param	b	blue channel intensity in the range [0:1].
	 * @return	A 32 bit color.
	 */
	public function combineARGB(a:Number, r:Number, g:Number = -1, b:Number = -1):uint
	{ 
		if (g < 0) g = r;
		if (b < 0) b = g;
		
		return (int(a * 0xFF) << 24) | (int(r * 0xFF) << 16) | (int(g * 0xFF) << 8) | int(b * 0xFF);
	}
}