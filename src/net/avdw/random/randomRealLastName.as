package net.avdw.random
{
	import flash.utils.ByteArray;
	
	public function randomRealLastName():String
	{
		var bytes:ByteArray = new Resource.AllLastNamesFile() as ByteArray;
		var names:Array = bytes.toString().split(",");
		
		return names[Math.floor(Math.random() * names.length)];
	}
}

class Resource
{
	[Embed(source="../../../../../assets/real-last-names.csv",mimeType="application/octet-stream")]
	static public const AllLastNamesFile:Class;
}