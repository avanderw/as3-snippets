package net.avdw.random
{	
	import net.avdw.file.loadTextFileLines;
	public function randomRealLastName():String
	{
		var names:Array = loadTextFileLines(Resource.AllLastNamesFile);
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/real-last-names.txt",mimeType="application/octet-stream")]
	static public const AllLastNamesFile:Class;
}