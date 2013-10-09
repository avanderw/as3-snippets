package net.avdw.stats
{
	
	public function rollDice(numDice:int = 2, numSides:int = 6, bonus:int = 0, highThrowsToRemove:int = 0, lowThrowsToRemove:int = 0):Number
	{
		var i:int;
		var rolls:Array = [];
		
		for (i = 0; i < numDice; i++)
			rolls.push(Math.floor(Math.random() * numSides));
		
		rolls.sort(Array.NUMERIC);
		rolls.splice(0, lowThrowsToRemove);
		rolls.splice(rolls.length - highThrowsToRemove);
		
		var value:int = 0;
		for (i = 0; i < rolls.length; i++)
			value += rolls[i];
		
		return value + bonus;
	}

}