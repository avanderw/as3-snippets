package net.avdw.card
{
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Card
	{
		static public const CLUB:int = 0;
		static public const DIAMOND:int = 1;
		static public const HEART:int = 2;
		static public const SPADE:int = 3;
		
		/**
		 * suit = card / 13;
		 * 0..3 - 0 = clubs, 1 = diamonds, 2 = hearts, 3 = spades
		 */
		public var suit:int;
		/**
		 * rank = card % 13
		 * 0..12 - 0 = duece, 1 = 3, 2 = 4 ... 11 = King, 12 = Ace
		 */
		public var rank:int;
		/**
		 * 0..51 - 0 = deuce of clubs, 51 = ace of spades
		 * card = suit * 13 + rank
		 */
		public var card:int;
		
		/**
		 * new Card(13) = Suit.Diamonds, Rank = Deuce
		 * new Card(2, 4) = Suit.Hearts, Rank = 6
		 * @param	... args
		 */
		public function Card(... args)
		{
			if (args == null || args.length == 0)
			{
				throw new Error("arguments need to be provided to the constructor");
			}
			
			if (args.length == 1)
			{
				suit = Math.floor(args[0] / 13);
				rank = args[0] % 13;
			}
			else
			{
				suit = args[0];
				rank = args[1];
			}
		}
		
		public function get value():int {
			return rank + 2;
		}
		
		public function toString():String
		{
			var str:String = "";
			switch (value)
			{
				case 11: 
					str += "J";
					break;
				case 12: 
					str += "Q";
					break;
				case 13: 
					str += "K";
					break;
				case 14: 
					str += "A";
					break;
				default: 
					str += ""+(value);
			}
			
			switch (suit)
			{
				case Card.CLUB: 
					str += "\u2663";
					break;
				case Card.DIAMOND: 
					str += "\u2666";
					break;
				case Card.HEART: 
					str += "\u2665";
					break;
				case Card.SPADE: 
					str += "\u2660";
					break;
				default: 
					throw new Error("suit invalid");
			}
			
			return str;
		}
	}

}