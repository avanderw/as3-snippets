package net.avdw.align
{
	public function bottomRightAlign(objectsToPosition:Array, withinObject:Object = null):void
	{
		rightAlign(objectsToPosition, withinObject);
		bottomAlign(objectsToPosition, withinObject);
	}
}