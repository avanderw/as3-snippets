package net.avdw.file
{
	import flash.utils.ByteArray;
	
	public function loadTextFileLines(FileToLoad:Class):Array
	{
		var bytes:ByteArray = new FileToLoad() as ByteArray;
		return bytes.toString().split("\n");
	}
}