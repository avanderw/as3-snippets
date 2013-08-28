package net.avdw.array
{
	import net.avdw.random.randomInteger;
	
	public function shuffleArray(array:Array):void
	{
		for (var i:int = array.length; i > 0; i--)
		{
			array.push(array.splice(randomInteger(i), 1));
		}
	}
}