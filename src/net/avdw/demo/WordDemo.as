package net.avdw.demo
{
	import net.avdw.cypher.substitutionCypher;
	import net.avdw.text.generateWordSearch;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class WordDemo 
	{
		
		public function WordDemo() 
		{
			trace(substitutionCypher("How are you my LUCKY man! Gg Hh"));
			
			generateWordSearch();
		}
		
	}

}