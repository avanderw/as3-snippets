package net.avdw.random
{
	import flash.utils.ByteArray;
	
	public function randomRealFemaleName():String
	{
		var bytes:ByteArray = new Resource.FemaleFirstNamesFile() as ByteArray;
		var names:Array = bytes.toString().split(",");
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/real-female-first-names.csv",mimeType="application/octet-stream")]
	static public const FemaleFirstNamesFile:Class;
}