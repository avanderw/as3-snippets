package net.avdw.array
{
	public function toArray(iterable:*):Array
	{
		var array:Array = [];
		for each (var elem:Object in iterable)
			array.push(elem);
		return array;
	}
}