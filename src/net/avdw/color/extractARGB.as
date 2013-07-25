package net.avdw.color
{
	/**
	 * Extract four channels (a, r, g, b) from a 32 bit color.
	 *
	 * @param	color	A 32 bit color.
	 * @return	An object with properties a, r, g, b with range [0, 1]
	 */
	public function extractARGB(color:uint):Object
	{
		return {a: (color >> 24 & 0xFF) / 0xFF, r: (color >> 16 & 0xFF) / 0xFF, g: (color >> 8 & 0xFF) / 0xFF, b: (color & 0xFF) / 0xFF};
	}
}