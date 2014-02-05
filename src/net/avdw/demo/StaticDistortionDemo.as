package net.avdw.demo
{
	import com.greensock.easing.ElasticOut;
	import com.greensock.TweenLite;
	import com.increpare.bfxr.Bfxr;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.avdw.align.centerAlign;
	import net.avdw.file.loadTextFile;
	import net.avdw.fx.StaticDistortionFx;
	import net.avdw.generate.makeBackgroundFromText;
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class StaticDistortionDemo extends Sprite
	{
		public var mute:Boolean = true;
		public var distortion:StaticDistortionFx;
		[Embed(source="StaticDistortionDemo.as",mimeType="application/octet-stream")]
		public const TextFile:Class;
		[Embed(source="../../../../../assets/images/256x256 Yoda.png")]
		public const ImgClass:Class;
		
		private var sprite:Sprite;
		private var hoverSound:Bfxr;
		private var clickSound:Bfxr;
		
		public function StaticDistortionDemo()
		{
			addChild(makeBackgroundFromText(loadTextFile(TextFile), stage.stageWidth, stage.stageHeight));
			
			sprite = new Sprite();
			var img:Bitmap = new ImgClass();
			img.x -= img.width >> 1;
			img.y -= img.height >> 1;
			sprite.addChild(img);
			sprite.x = stage.stageWidth >> 1;
			sprite.y = stage.stageHeight >> 1;
			sprite.buttonMode = true;
			addChild(sprite);
			
			sprite.addEventListener(MouseEvent.ROLL_OVER, rollover);
			sprite.addEventListener(MouseEvent.ROLL_OUT, rollout);
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			sprite.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			distortion = new StaticDistortionFx(sprite);
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addToggle("mute");
			gui.addButton("low", {callback: distortion.low});
			gui.addButton("medium", {callback: distortion.medium});
			gui.addButton("high", {callback: distortion.high});
			gui.addSlider("distortion.minScaleX", 0, 25);
			gui.addSlider("distortion.maxScaleX", 0, 25);
			gui.show();
			
			hoverSound = new Bfxr();
			hoverSound.Load("1,0.5,0.255,0.155,,0.107,0.3,0.5766,,,,,,,,,-0.0456,,-0.0078,,,,,-0.0193,,1,,,0.1,0.0085,0.0154,-0.027,masterVolume,attackTime");
			hoverSound.Cache();
			
			clickSound = new Bfxr();
			clickSound.Load(",0.5,,0.143,,0.1656,0.3,0.28,,,,,,,,,,,,,0.5727,,,,,1,,,0.1,,,,masterVolume");
			clickSound.CacheMutations(.02, 5);
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			sprite.alpha = 1;
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			sprite.alpha = .5;
			if (!mute)
				clickSound.Play();
		}
		
		private function rollout(e:MouseEvent):void
		{
			sprite.alpha = 1;
			distortion.medium();
			TweenLite.to(sprite, .5, {scaleX: 1, scaleY: 1, ease: ElasticOut.ease});
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, reset);
			timer.start();
		}
		
		private function rollover(e:MouseEvent):void
		{
			distortion.high();
			TweenLite.to(sprite, .25, {scaleX: 1.1, scaleY: 1.1, ease: ElasticOut.ease});
			var timer:Timer = new Timer(250, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, reset);
			timer.start();
			if (!mute)
				hoverSound.Play();
		}
		
		private function reset(e:TimerEvent):void
		{
			distortion.low();
		}
	
	}
}
