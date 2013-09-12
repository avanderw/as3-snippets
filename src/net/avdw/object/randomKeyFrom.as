package net.avdw.object
{
	public function randomKeyFrom(obj:Object):String
	{
		var keys:Array = allObjectKeys(obj);
		return keys[Math.floor(Math.random() * keys.length)];
	}
}