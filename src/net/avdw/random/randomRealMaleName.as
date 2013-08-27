package net.avdw.random
{
	import net.avdw.file.loadTextFileLines;
	
	public function randomRealMaleName():String
	{
		var names:Array = loadTextFileLines(Resource.MaleFirstNamesFile);
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-male-first-names.txt",mimeType="application/octet-stream")]
	static public const MaleFirstNamesFile:Class;
}