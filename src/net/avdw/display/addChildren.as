package net.avdw.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public function addChildren(children:Array, displayObject:DisplayObjectContainer):void
	{
		for (var i:int = 0; i < children.length; i++)
		{
			if (!(children[i] is DisplayObject))
				continue;
			
			displayObject.addChild(children[i]);
		}
	}
}