package net.avdw.fx 
{
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
	public class RefreshBarFx extends Sprite
	{
		private var speed:int;
		private var barHeight:int;
		private var parentHeight:int;
		
		public function RefreshBarFx(parent:DisplayObjectContainer, barHeight:int = 20, speed:int = 5) 
		{
			parentHeight = parent is Stage ? (parent as Stage).stageHeight : parent.height;
			var barWidth:int = parent is Stage ? (parent as Stage).stageWidth : parent.width;
			this.barHeight = barHeight;
			this.speed = speed;
			
			with (graphics)
			{
				beginFill(0, .3);
				drawRect(0, 0, barWidth, barHeight);
				endFill();
			}
			
			filters = [new BlurFilter(0, barHeight*2)];
			blendMode = BlendMode.OVERLAY;
			parent.addChild(this);
			
			reset();
			
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function reset():void 
		{
			y = -barHeight;
		}
		
		private function animate(e:Event):void 
		{
			y += speed;
			if (y > parentHeight + barHeight)
				reset();
		}
		
	}

}