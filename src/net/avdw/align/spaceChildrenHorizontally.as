package net.avdw.align
{
	import flash.display.DisplayObjectContainer;
	
	public function spaceChildrenHorizontally(containers:Array, ... spacingValues):void
	{
		for each (var container:DisplayObjectContainer in containers)
		{
			var children:Array = [];
			for (var i:int = 0; i < container.numChildren; i++)
				children.push(container.getChildAt(i));
			
			spaceHorizontally(children, spacingValues);
		}
	}
}