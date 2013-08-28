package net.avdw.random
{
	import net.avdw.array.randomItemFrom;
	import net.avdw.file.loadLinesFromTextFile;
	
	public function randomRealFemaleName():String
	{
		return randomItemFrom(loadLinesFromTextFile(Resource.FemaleFirstNamesFile));
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-female-first-names.txt",mimeType="application/octet-stream")]
	static public const FemaleFirstNamesFile:Class;
}