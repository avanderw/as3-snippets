package net.avdw.generate
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.avdw.interp.*;
	import net.avdw.math.Vec2;
	import net.avdw.number.normalize;
	import net.avdw.number.SeededRNG;
	
	public function scratchLine(graphics:Graphics, start:Point, end:Point, color:uint, strokeWidth:int, alpha:Number = .3, density:Number = .0001, interp:Function = null):void
	{
		interp = interp == null ? sineEaseIn : interp;
		var startV:Vec2 = new Vec2(start.x, start.y);
		var endV:Vec2 = new Vec2(end.x, end.y);
		var normalV:Vec2 = endV.sub(startV).normalLeft().normalize();
		
		graphics.moveTo(startV.x, startV.y);
		graphics.lineStyle(1, color, alpha * .5);
		graphics.lineTo(endV.x, endV.y);
		
		if (density > 0)
			for (var i:Number = 0; i <= 1; i += density)
			{
				var lerpV:Vec2 = startV.lerp(endV, i);
				var length:int = SeededRNG.integer(strokeWidth);
				lerpV.addSelf(normalV.scale(length));
				graphics.moveTo(lerpV.x, lerpV.y);
				lerpV.addSelf(normalV.negate().scale(length * 2));
				graphics.lineStyle(1, color, interp(alpha - normalize(length, strokeWidth) * alpha));
				graphics.lineTo(lerpV.x, lerpV.y);
			}
	}

}