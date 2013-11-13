package net.avdw.random
{
	import net.avdw.object.randomKeyFrom;

	public function randomWordsFromMarkovChain(chain:Object, maxWords:int, stopWhenChainIsBroken:Boolean = false):String
	{
		var splitKey:Array;
		var word:String;
		var words:String = "";
		var wordCount:int = 0;
		var key:String = "";

		for (var i:int = 0; i < randomKeyFrom(chain).split(" ").length - 1; i++)
			key += " ";
		
		while (wordCount < maxWords)
		{
			if (chain[key] == null)
				if (stopWhenChainIsBroken)
					break;
				else
					key = randomKeyFrom(chain);
			
			word = chain[key][Math.floor(Math.random() * chain[key].length)];
			words += word + " ";
			
			splitKey = key.split(" ");
			splitKey.push(word);
			splitKey.splice(0, 1);
			key = splitKey.join(" ");
			
			wordCount++;
		}
		return words;
	}
}