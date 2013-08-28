package net.avdw.random
{
	import net.avdw.array.randomItemFrom;
	import net.avdw.file.loadLinesFromTextFile;
	
	public function randomRealMaleName():String
	{
		return randomItemFrom(loadLinesFromTextFile(Resource.MaleFirstNamesFile));
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-male-first-names.txt",mimeType="application/octet-stream")]
	static public const MaleFirstNamesFile:Class;
}