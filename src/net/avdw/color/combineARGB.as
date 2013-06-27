package net.avdw.color
{
	/**
	 * Combine four 8 bit channels into a 32 bit color.
	 *
	 * @param	a	The 8 bit alpha channel.
	 * @param	r	The 8 bit red channel.
	 * @param	g	The 8 bit green channel.
	 * @param	b	The 8 bit blue channel.
	 * @return	A 32 bit color.
	 */
	public function combineARGB(a:int, r:int, g:int, b:int):uint
	{
		return (a << 24) | (r << 16) | (g << 8) | b;
	}
}