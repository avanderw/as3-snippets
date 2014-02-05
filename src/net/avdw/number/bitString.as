package net.avdw.number
{
	public function bitString(number:int, bits:int = 32):String
	{
		var str:String = "";
		for (var i:int = bits; i >= 0; i--)
			str += "" + ((number >> i) & 1);
		
		return str;
	}
}