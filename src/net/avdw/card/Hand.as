package net.avdw.card
{
	import net.avdw.number.bitString;
	import net.avdw.number.countBits;
	import net.avdw.number.isBitSet;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Hand
	{
		public var cards:Array = new Array(4);
		
		public function Hand(cards:Array = null)
		{
			if (cards)
				addCards(cards);
		}
		
		public function countCards():int
		{
			return countBits(cards[0], 13) + countBits(cards[1], 13) + countBits(cards[2], 13) + countBits(cards[3], 13);
		}
		
		public function addCards(cards:Array):void
		{
			for each (var card:Card in cards)
				this.cards[card.suit] |= (1 << card.rank);
		}
		
		/**
		 * at least 5 cards of the same suit
		 * @return
		 */
		public function isFlush():Boolean
		{
			return countBits(cards[0], 12) > 4 || countBits(cards[1], 12) > 4 || countBits(cards[2], 12) > 4 || countBits(cards[3], 12) > 4;
		}
		
		/**
		 * at least 5 cards sequentially following each other
		 * @return
		 */
		public function isStraight():Boolean
		{
			var uniqueRanks:int = cards[0] | cards[1] | cards[2] | cards[3];
			var count:int = 0;
			for (var i:int = 12; i >= 0; i--)
			{
				if ((uniqueRanks >> i) & 1 == 1)
					count++;
				else
					count = 0;
				
				if (count == 5)
					return true;
			}
			
			return false;
		}
		
		/**
		 * at least 4 cards of the same rank
		 * @return
		 */
		public function isFourOfAKind():Boolean
		{
			var fourOfAKindRanks:int = cards[0] & cards[1] & cards[2] & cards[3];
			for (var i:int = 12; i >= 0; i--)
				if ((fourOfAKindRanks >> i) & 1 == 1)
					return true;
			
			return false;
		}
		
		/**
		 * at least 3 of one suit and 2 of another
		 * @return
		 */
		public function isFullHouse():Boolean
		{
			var clubs:int = countBits(cards[0], 12);
			var diamonds:int = countBits(cards[1], 12);
			var hearts:int = countBits(cards[2], 12);
			var spades:int = countBits(cards[3], 12);
			
			return ((clubs > 2 && (diamonds > 1 || hearts > 1 || spades > 1)) || (diamonds > 2 && (clubs > 1 || hearts > 1 || spades > 1)) || (hearts > 2 && (clubs > 1 || diamonds > 1 || spades > 1)) || (spades > 2 && (clubs > 1 || diamonds > 1 || hearts > 1)));
		}
		
		/**
		 * at least 3 of the same rank
		 * @return
		 */
		public function isThreeOfAKind():Boolean
		{
			var count:int = 0;
			for (var i:int = 12; i >= 0; i--)
			{
				count = 0;
				if ((cards[0] >> i) & 1 == 1)
					count++;
				if ((cards[1] >> i) & 1 == 1)
					count++;
				if ((cards[2] >> i) & 1 == 1)
					count++;
				if ((cards[3] >> i) & 1 == 1)
					count++;
				
				if (count > 2)
					return true;
			}
			
			return false;
		}
		
		/**
		 * at least 2 of same rank and 2 of another
		 * @return
		 */
		public function isTwoPair():Boolean
		{
			var foundPair:Boolean = false;
			var count:int = 0;
			for (var i:int = 12; i >= 0; i--)
			{
				count = 0;
				if ((cards[0] >> i) & 1 == 1)
					count++;
				if ((cards[1] >> i) & 1 == 1)
					count++;
				if ((cards[2] >> i) & 1 == 1)
					count++;
				if ((cards[3] >> i) & 1 == 1)
					count++;
				
				if (count > 1)
					if (foundPair)
						return true;
					else
						foundPair = true;
			}
			
			return false;
		}
		
		/**
		 * at least 2 of same rank
		 * @return
		 */
		public function isPair():Boolean
		{
			var count:int = 0;
			for (var i:int = 12; i >= 0; i--)
			{
				count = 0;
				if ((cards[0] >> i) & 1 == 1)
					count++;
				if ((cards[1] >> i) & 1 == 1)
					count++;
				if ((cards[2] >> i) & 1 == 1)
					count++;
				if ((cards[3] >> i) & 1 == 1)
					count++;
				
				if (count > 1)
					return true;
			}
			
			return false;
		}
		
		public function totalSuits():int
		{
			var suits:int = 0;
			if (cards[0] > 0)
				suits++;
			if (cards[1] > 0)
				suits++;
			if (cards[2] > 0)
				suits++;
			if (cards[3] > 0)
				suits++;
			return suits;
		}
		
		public function highCard():Card
		{
			for (var i:int = 12; i >= 0; i--)
			{
				if ((cards[3] >> i) & 1 == 1)
					return new Card(39 + i);
				if ((cards[2] >> i) & 1 == 1)
					return new Card(26 + i);
				if ((cards[1] >> i) & 1 == 1)
					return new Card(13 + i);
				if ((cards[0] >> i) & 1 == 1)
					return new Card(0 + i);
			}
			
			throw new Error("card unknown");
		}
		
		public function pokerValue():int
		{
			var value:int = 0;
			if (isFlush() && isStraight())
				if (highCard().rank == 12)
					value = 9;
				else
					value = 8;
			else if (isFourOfAKind())
				value = 7;
			else if (isFullHouse())
				value = 6;
			else if (isFlush())
				value = 5;
			else if (isStraight())
				value = 4;
			else if (isThreeOfAKind())
				value = 3;
			else if (isTwoPair())
				value = 2;
			else if (isPair())
				value = 1;
			else
				value = 0;
			
			return (value << 8) | highCard().rank;
		}
		
		public function toString():String
		{
			var str:String = "";
			for (var i:int = 12; i >= 0; i--)
			{
				if (isBitSet(cards[0], i))
					str += new Card(i) + " ";
				if (isBitSet(cards[1], i))
					str += new Card(13 + i) + " ";
				if (isBitSet(cards[2], i))
					str += new Card(26 + i) + " ";
				if (isBitSet(cards[3], i))
					str += new Card(39 + i) + " ";
			}
			
			return str.substr(0, str.length - 1);
		}
		
		public function runPokerTest():String
		{
			var result:String = "" + this;
			if (isFlush() && isStraight())
				if (highCard().rank == 12)
					result += " royal flush";
				else
					result += " straight flush";
			else if (isFourOfAKind())
				result += " four of a kind";
			else if (isFullHouse())
				result += " full house";
			else if (isFlush())
				result += " flush";
			else if (isStraight())
				result += " straight";
			else if (isThreeOfAKind())
				result += " three of a kind";
			else if (isTwoPair())
				result += " two pair";
			else if (isPair())
				result += " pair";
			else
				result += " high card";
			return result;
		}
		
		static public function testPoker():void
		{
			trace(new Hand([new Card(12), new Card(11), new Card(10), new Card(9), new Card(8)]).runPokerTest());
			trace(new Hand([new Card(11), new Card(10), new Card(9), new Card(8), new Card(7)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(25), new Card(38), new Card(51), new Card(8)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(7), new Card(3), new Card(14), new Card(16)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(10), new Card(8), new Card(6), new Card(4)]).runPokerTest());
			trace(new Hand([new Card(25), new Card(11), new Card(10), new Card(9), new Card(8)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(25), new Card(38), new Card(9), new Card(8)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]).runPokerTest());
			trace(new Hand([new Card(12), new Card(25), new Card(3), new Card(21), new Card(32)]).runPokerTest());
			trace(new Hand([new Card(25), new Card(28), new Card(3), new Card(21), new Card(32)]).runPokerTest());
			
			trace(new Hand([new Card(12), new Card(10), new Card(8), new Card(6), new Card(4)]), ">", new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]), new Hand([new Card(12), new Card(10), new Card(8), new Card(6), new Card(4)]).pokerValue() > new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]).pokerValue());
			trace(new Hand([new Card(12), new Card(25), new Card(38), new Card(51), new Card(8)]), "<", new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]), new Hand([new Card(12), new Card(25), new Card(38), new Card(51), new Card(8)]).pokerValue() < new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]).pokerValue());
			trace(new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]), "=", new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(33)]), new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(32)]).pokerValue() == new Hand([new Card(12), new Card(25), new Card(8), new Card(21), new Card(33)]).pokerValue());
		}
	}

}