package net.avdw.random
{
	import flash.utils.ByteArray;
	
	public function randomRealMaleName():String
	{
		var bytes:ByteArray = new Resource.MaleFirstNamesFile() as ByteArray;
		var names:Array = bytes.toString().split(",");
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/real-male-first-names.csv",mimeType="application/octet-stream")]
	static public const MaleFirstNamesFile:Class;
}