package net.avdw.array
{
	import net.avdw.random.randomInteger;
	
	public function randomItemFrom(array:Array):*
	{
		return array[randomInteger(array.length)];
	}
}