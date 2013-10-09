package net.avdw.align
{
	import flash.display.DisplayObjectContainer;
	
	public function centerAlignChildrenVertically(containers:Array, withinObject:Object = null):void
	{
		for each (var container:DisplayObjectContainer in containers)
		{
			var children:Array = [];
			for (var i:int = 0; i < container.numChildren; i++)
				children.push(container.getChildAt(i));
			
			centerAlignVertically(children, withinObject);
		}
	}
}