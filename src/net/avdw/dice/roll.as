package net.avdw.dice
{
	
	public function roll(sides:int):Number
	{
		return Math.ceil(Math.random() * sides); 
	}

}