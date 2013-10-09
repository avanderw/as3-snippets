package net.avdw.align
{
	import flash.display.Stage;
	
	public function bottomAlign(objectsToPosition:Array, withinObject:Object = null):void
	{
		if (!objectsToPosition || objectsToPosition.length == 0)
			return;
		
		var tmpWithinObject:Object;
		for (var i:int = 0; i < objectsToPosition.length; i++)
		{
			if (!objectsToPosition[i] || !objectsToPosition[i].hasOwnProperty("height") || !objectsToPosition[i].hasOwnProperty("y"))
				continue;
			
			if (!withinObject)
				if (objectsToPosition[i].parent)
					tmpWithinObject = objectsToPosition[i].parent;
				else
					continue;
			
			if (withinObject is Stage)
				objectsToPosition[i].y = withinObject.stageHeight - objectsToPosition[i].height;
			else
				objectsToPosition[i].y = tmpWithinObject.y + tmpWithinObject.height - objectsToPosition[i].height;
				
			trace(tmpWithinObject, tmpWithinObject.y, tmpWithinObject.height);
			trace(objectsToPosition[i], objectsToPosition[i].y, objectsToPosition[i].height);
		}
	}
}