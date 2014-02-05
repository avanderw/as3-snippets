package net.avdw.color
{
	public function convertColorToHue(color:uint):uint
	{
		var c:Object = extractARGB(color);
		return convertRGBtoHue(c.r, c.g, c.b);
	}
}