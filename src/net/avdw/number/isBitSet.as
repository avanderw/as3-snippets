package net.avdw.number
{
	public function isBitSet(value:int, bit:int):Boolean
	{
		return ((value >> bit) & 1) == 1;
	}
}