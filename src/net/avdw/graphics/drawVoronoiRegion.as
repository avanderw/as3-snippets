package net.avdw.graphics
{
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.geom.Point;
	
	public function drawVoronoiRegion(region:Vector.<Point>, graphics:Graphics):void
	{
		if (region == null || region.length == 0)
			return;
		
		var drawCoords:Vector.<Number> = new Vector.<Number>();
		var drawCommands:Vector.<int> = new Vector.<int>();
		
		drawCoords.push(region[0].x, region[0].y);
		drawCommands.push(GraphicsPathCommand.MOVE_TO);
		for each (var point:Point in region)
		{
			drawCoords.push(point.x, point.y);
			drawCommands.push(GraphicsPathCommand.LINE_TO);
		}
		drawCoords.push(region[0].x, region[0].y);
		drawCommands.push(GraphicsPathCommand.LINE_TO);
		
		graphics.drawPath(drawCommands, drawCoords);
	}
}