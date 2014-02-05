package net.avdw.card
{
	import net.avdw.random.randomBoolean;
	/**
	 * 
	 * @return negative = fold, 0 = call, positive = raise
	 */
	public function basePokerAi(rateOfReturn:Number, amountToCall:int = 0):int
	{
		var fold:int = -1;
		var call:int = 0;
		var raise:int = 1;
		var roll:Number = Math.random();
		if (rateOfReturn < 0.8)
			if (roll < 0.95)
				return amountToCall == 0 ? call : fold;
			else
				return raise; // bluff
		else if (rateOfReturn < 1)
			if (roll < 0.8)
				return amountToCall == 0 ? call : fold;
			else if (roll < 0.85) 
				return call;
			else 
				return raise; // bluff
		else if (rateOfReturn < 1.3)
			if (roll < 0.6)
				return call;
			else 
				return raise;
		else if (rateOfReturn >= 1.3)
			if (roll < 0.3)
				return call;
			else
				return raise;
	}
	
}