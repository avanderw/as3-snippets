package net.avdw.random
{	
	import net.avdw.array.randomItemFrom;
	import net.avdw.file.loadLinesFromTextFile;
	
	public function randomRealLastName():String
	{
		return randomItemFrom(loadLinesFromTextFile(Resource.AllLastNamesFile));
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-last-names.txt",mimeType="application/octet-stream")]
	static public const AllLastNamesFile:Class;
}