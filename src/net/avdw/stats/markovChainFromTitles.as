package net.avdw.stats
{
	public function markovChainFromTitles(titleArray:Array, chainOrder:int = 1):Object
	{
		var tmpChain:Object;
		var chain:Object = {};
		for each (var title:String in titleArray)
		{
			tmpChain = markovChainFromText(title, chainOrder);
			for (var key:String in tmpChain)
			{
				if (chain[key] == null)
				{
					chain[key] = tmpChain[key];
				}
				else
				{
					for each (var word:String in tmpChain[key])
					{
						chain[key].push(word);
					}
				}
			}
		}
		return chain;
	}
}
