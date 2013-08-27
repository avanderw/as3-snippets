package
{
	import flash.display.Sprite;
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
		}
	
	}

}