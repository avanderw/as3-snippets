package net.avdw.fx
{
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import net.avdw.number.SeededRNG;
	
	public class RGBDistortableFx extends flash.display.Sprite
	{
		private var distorting:Boolean = false;
		private var r:Bitmap;
		private var g:Bitmap;
		private var b:Bitmap;
		private var config:Object;
		
		public function RGBDistortableFx(displayObj:DisplayObject)
		{
			TweenPlugin.activate([AutoAlphaPlugin]);var bmpData:BitmapData = new BitmapData(displayObj.width, displayObj.height, true, 0);
			r = new Bitmap(bmpData.clone());
			
			bmpData.draw(displayObj);
			r.bitmapData.copyChannel(bmpData, bmpData.rect, new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			g = new Bitmap(r.bitmapData.clone());
			b = new Bitmap(r.bitmapData.clone());
			
			r.bitmapData.copyChannel(bmpData, bmpData.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED);
			g.bitmapData.copyChannel(bmpData, bmpData.rect, new Point(), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
			b.bitmapData.copyChannel(bmpData, bmpData.rect, new Point(), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
			
			r.blendMode = BlendMode.NORMAL;
			g.blendMode = BlendMode.SCREEN;
			b.blendMode = BlendMode.SCREEN;
			
			addChild(r);
			addChild(g);
			addChild(b);
		}
		
		public function distort(config:Object = null):void
		{
			if (config == null)
				config = {x: 10, y: 3, scaleX: .2, scaleY: .05, alpha: .5, speed: .8};
			
			this.config = config;
			distorting = true;
			
			tween(r);
			tween(g);
			tween(b);
		}
		
		public function stop():void
		{
			distorting = false;
		}
		
		private function tween(bmp:Bitmap):void
		{
			var vars:TweenLiteVars = new TweenLiteVars();
			if (distorting)
			{
				if (config.hasOwnProperty("x"))
					vars.x(SeededRNG.integer(-config.x / 2, config.x / 2));
				
				if (config.hasOwnProperty("y"))
					vars.y(SeededRNG.integer(-config.y / 2, config.y / 2));
				
				if (config.hasOwnProperty("scaleX"))
					vars.scaleX(SeededRNG.float(1 - config.scaleX / 2, 1 + config.scaleX / 2));
				
				if (config.hasOwnProperty("scaleY"))
					vars.scaleY(SeededRNG.float(1 - config.scaleY / 2, 1 + config.scaleY / 2));
				
				if (config.hasOwnProperty("alpha"))
					vars.autoAlpha(SeededRNG.float(1 - config.alpha, 1));
				
				vars.onComplete(tween, [bmp]);
			} else { 
				vars.x(0);
				vars.y(0);
				vars.scaleX(1);
				vars.scaleY(1);
				vars.autoAlpha(1);
			}
			
			vars.ease(Sine.easeInOut);
			TweenLite.to(bmp, SeededRNG.float(.1, config.hasOwnProperty("speed") ? 1.1 - config.speed : .2), vars);
		}
	}
}