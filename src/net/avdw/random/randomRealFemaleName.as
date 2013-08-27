package net.avdw.random
{
	import net.avdw.file.loadTextFileLines;
	
	public function randomRealFemaleName():String
	{
		var names:Array = loadTextFileLines(Resource.FemaleFirstNamesFile);
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-female-first-names.txt",mimeType="application/octet-stream")]
	static public const FemaleFirstNamesFile:Class;
}