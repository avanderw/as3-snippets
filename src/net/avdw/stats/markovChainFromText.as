package net.avdw.stats
{
	public function markovChainFromText(text:String, chainOrder:int = 2):Object
	{
		var i:int;
		var splitKey:Array;
		var key:String = "";
		
		for (i = 0; i < chainOrder - 1; i++)
			key += " ";
		
		var chain:Object = {};
		text = text.replace(/^\s+|\s+$/g, '').replace(/\s+/g, ' ');
		
		var words:Array = text.split(" ");
		for (i = 0; i < words.length; i++)
		{
			if (chain[key] == null)
				chain[key] = [];
			
			chain[key].push(words[i]);
			
			splitKey = key.split(" ");
			splitKey.push(words[i]);
			splitKey.splice(0, 1);
			key = splitKey.join(" ");
		}
		
		return chain;
	}
}