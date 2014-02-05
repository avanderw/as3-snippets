package net.avdw.number
{
	public function countBits(number:int, bits:int = 32):int
	{
		var setBits:int = 0;
		for (var i:int = bits; i >= 0; i--)
			if ((number >> i) & 1 == 1)
				setBits++;
		
		return setBits;
	}
}