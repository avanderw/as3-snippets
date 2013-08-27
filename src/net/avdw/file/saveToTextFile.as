package net.avdw.file
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public function saveToTextFile(file:File, data:String, callback:Function = null):void
	{
		var stream:FileStream = new FileStream();
		
		if (callback != null) {
			stream.addEventListener(Event.CLOSE, callback);
		}
		
		stream.openAsync(file, FileMode.WRITE);
		stream.writeUTFBytes(data);
		stream.close();
	}
}