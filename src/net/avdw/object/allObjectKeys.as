package net.avdw.object
{
	public function allObjectKeys(obj:Object):Array
	{
		var keys:Array = [];
		for (var key:String in obj) {
			keys.push(key);
		}
		
		return keys;
	}
}