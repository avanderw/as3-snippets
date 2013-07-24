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
	public function combineARGB(a:Number, r:Number, g:Number, b:Number):uint
	{ 
		return (int(a * 0xFF) << 24) | (int(r * 0xFF) << 16) | (int(g * 0xFF) << 8) | int(b * 0xFF);
	}
}