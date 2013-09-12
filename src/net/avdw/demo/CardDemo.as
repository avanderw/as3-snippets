package net.avdw.demo
{
	import flash.display.Sprite;
	import net.avdw.card.blackjackHandValue;
	import net.avdw.card.Deck;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class CardDemo extends Sprite
	{
		
		public function CardDemo()
		{
			var deck:Deck = new Deck();
			var i:int;
			
			for (i = 0; i < 52; i++)
			{
				deck.draw();
			}
			
			
			deck:Deck = new Deck();
			var hand:Array = deck.draw(2);
			
			trace(hand, blackjackHandValue(hand));
		}
	
	}

}