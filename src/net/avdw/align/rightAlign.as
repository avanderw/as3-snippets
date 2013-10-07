package net.avdw.align
{
	import flash.display.Stage;
	
	public function rightAlign(objectsToPosition:Array, withinObject:Object = null):void
	{
		if (!objectsToPosition || objectsToPosition.length == 0)
			return;
		
		var tmpWithinObject:Object;
		for (var i:int = 0; i < objectsToPosition.length; i++)
		{
			if (!objectsToPosition[i] || !objectsToPosition[i].hasOwnProperty("width") || !objectsToPosition[i].hasOwnProperty("x"))
				continue;
			
			if (!withinObject)
				if (objectsToPosition[i].parent)
					tmpWithinObject = objectsToPosition[i].parent;
				else
					continue;
			
			if (withinObject is Stage)
				objectsToPosition[i].x = withinObject.stageWidth - objectsToPosition[i].width;
			else
				objectsToPosition[i].x = tmpWithinObject.x + tmpWithinObject.width - objectsToPosition[i].width;
		}
	}
}