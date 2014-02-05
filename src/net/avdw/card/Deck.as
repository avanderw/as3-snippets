package net.avdw.card
{
	import net.avdw.random.randomInteger;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Deck
	{
		public const cards:Array = [];
		
		public function Deck()
		{
			var i:int;
			for (i = 0; i < 52; i++)
			{
				cards.push(new Card(i));
			}
		}
		
		public function draw(num:int = 1):Array
		{
			var drawCards:Array = [];
			var i:int;
			for (i = 0; i < num; i++)
			{
				drawCards.push(cards.splice(randomInteger(cards.length), 1)[0]);
			}
			
			return drawCards;
		}
	
	}

}