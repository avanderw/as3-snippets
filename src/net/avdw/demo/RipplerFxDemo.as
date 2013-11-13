package net.avdw.demo 
{
	import avdw.action.ScreenshotAction;
	import avdw.action.ThumbshotAction;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.avdw.fx.RipplerFx;
	import uk.co.soulwire.gui.SimpleGUI;
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	[SWF(backgroundColor="0xFFFFFF",frameRate="60",width="680",height="495")]
	public class RipplerFxDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/680x495 Leaf Poster.jpg")]
		private var _sourceImage:Class;
		
		private var _target:Bitmap;
		private var _rippler:RipplerFx;
		
		public var impact:Object;
		public var displacement:Object;
		
		public function RipplerFxDemo() 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			ScreenshotAction.addTo(stage);
			ThumbshotAction.addTo(stage);
			
			impact = new Object();
			impact.size = 5;
			impact.alpha = 0.9;
			
			displacement = new Object();
			displacement.strength = 30;
			displacement.scale = 2;
			
			_target = new Bitmap(new _sourceImage().bitmapData);
			addChild(_target);
			
			_rippler = new RipplerFx(_target, displacement.strength, displacement.scale);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, startRipple);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopRipple);
			stage.addEventListener(MouseEvent.CLICK, ripple);
			
			var gui:SimpleGUI = new SimpleGUI(this, "Controls");
			gui.addSlider("displacement.strength", 2, 80, {callback:replaceRippler});
			gui.addSlider("displacement.scale", 1, 12, { callback:replaceRippler } );
			gui.addSlider("impact.size", 1, 40);
			gui.addSlider("impact.alpha", 0, 1);
			gui.addLabel("Click on image and drag");
			gui.show();
		}
		
		private function replaceRippler():void {
			_rippler.destroy();
			_rippler = new RipplerFx(_target, displacement.strength, displacement.scale);
		}
		
		private function stopRipple(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, ripple);			
		}
		
		private function startRipple(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, ripple);
		}
		
		private function ripple(e:MouseEvent):void 
		{
			_rippler.drawRipple(mouseX, mouseY, impact.size, impact.alpha);
		}
		
	}

}