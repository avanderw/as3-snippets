package net.avdw.file
{
	import flash.utils.ByteArray;
	
	public function loadTextFile(FileToLoad:Class):String
	{
		var bytes:ByteArray = new FileToLoad() as ByteArray;
		return bytes.toString();
	}
}