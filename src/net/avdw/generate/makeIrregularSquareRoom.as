package net.avdw.generate
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.avdw.array.createIntVectorMatrix;
	import net.avdw.graphics.drawFastLine;
	import net.avdw.random.randomInteger;
	import net.avdw.random.randomPointsInRectangle;
	
	/**
	 * http://roguebasin.roguelikedevelopment.org/index.php?title=Irregular_Shaped_Rooms
	 * 
	 * @param	width
	 * @param	height
	 * @param	edge
	 * @param	minPoints
	 * @param	maxPoints
	 * @return
	 */
	public function makeIrregularSquareRoom(width:int, height:int, edge:int, minPoints:int = 1, maxPoints:int = 4):Vector.<Vector.<int>>
	{
		var rectangleTop:Rectangle = new Rectangle(edge, 0, width - 2 * edge, edge);
		var rectangleRight:Rectangle = new Rectangle(width - edge, edge, edge, height - 2 * edge);
		var rectangleBottom:Rectangle = new Rectangle(edge, height - edge, width - 2 * edge, edge);
		var rectangleLeft:Rectangle = new Rectangle(0, edge, edge, height - 2 * edge);
		
		var i:int = 0;
		var drawCoords:Vector.<Point> = new Vector.<Point>();
		drawCoords = drawCoords.concat(randomPointsInRectangle(rectangleTop, randomInteger(minPoints, maxPoints)).sort(function(p1:Point, p2:Point):Number{return p1.x - p2.x;}));
		drawCoords = drawCoords.concat(randomPointsInRectangle(rectangleRight, randomInteger(minPoints, maxPoints)).sort(function(p1:Point, p2:Point):Number{return p1.y - p2.y;}));
		drawCoords = drawCoords.concat(randomPointsInRectangle(rectangleBottom, randomInteger(minPoints, maxPoints)).sort(function(p1:Point, p2:Point):Number{return p2.x - p1.x;}));
		drawCoords = drawCoords.concat(randomPointsInRectangle(rectangleLeft, randomInteger(minPoints, maxPoints)).sort(function(p1:Point, p2:Point):Number{return p2.y - p1.y;}));
		
		var bmpData:BitmapData = new BitmapData(width, height, false, 1);
		var lastPoint:Point = drawCoords[0];
		for each (var point:Point in drawCoords)
		{
			drawFastLine(bmpData, lastPoint.x, lastPoint.y, point.x, point.y, 0);
			lastPoint = point;
		}
		drawFastLine(bmpData, lastPoint.x, lastPoint.y, drawCoords[0].x, drawCoords[0].y, 0);
		
		bmpData.floodFill(width >> 1, height >> 1, 0);
		
		var room:Vector.<Vector.<int>> = createIntVectorMatrix(height, width, 0);
		for (var y:int = 0; y < height; y++) 
			for (var x:int = 0; x < width; x++) 
				room[y][x] = (bmpData.getPixel(x, y));
		bmpData.dispose();
		
		return room;
	}
}