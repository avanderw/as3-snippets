package net.avdw.card
{
	public function blackjackHandValue(cards:Array):int
	{
		var numAces:int = 0;
		var value:int = 0;
		for each (var card:Card in cards)
		{
			if (card.value < 10)
				value += card.value;
			else if (card.value < 14)
				value += 10;
			else
			{
				value += 11;
				numAces++;
			}
		}
		while (value > 21 && numAces > 0)
		{
			value -= 10;
			numAces--;
		}
		return value;
	}
}