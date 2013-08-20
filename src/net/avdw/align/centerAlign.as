package net.avdw.align
{
	import flash.display.DisplayObject;
	
	public function centerAlign(displayObject:DisplayObject, withinObject:Object = null):void
	{
		centerAlignHorizontally([displayObject], withinObject);
		centerAlignVertically([displayObject], withinObject);
	}
}