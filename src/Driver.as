package  
{
	import avdw.math.vector2d.Vec2Const;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.avdw.image.convertToGrayscale;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class Driver extends Sprite
	{
		private var ballSpeedY:int = 1;
		private var ballRadius:int = 10;
		private var g:int = 3;
		private var time:int = 1;
		private var ball:Sprite;
		
		private var vy:int = 0;
		private var ay:int = 3;
		
		private var velocity:Vec2Const = new Vec2Const();
		
		public function Driver() 
		{
			ball = new Sprite();
			ball.x = stage.stageWidth / 2;
			ball.y = ballRadius;
			ball.graphics.beginFill(0xFF0000);
			ball.graphics.drawCircle(0, 0, ballRadius);
			ball.graphics.endFill();
			addChild(ball);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			vy += ay;
			ball.y += vy;
			
			if (ball.y + ballRadius > stage.stageHeight) {
				vy = -vy * 0.90;
				ball.y = stage.stageHeight - ballRadius;
			} else if (ball.y -ballRadius < 0) {
			}
		}
		
	}

}