package net.avdw.fx
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * Does not clear memory when done
	 * Currently leaves for garbage collection
	 * Consider caching a large area of perlin noise to pull effect data from
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class DisintegrateFx
	{
		static private const zeroPoint:Point = new Point();
		static private const particleColorTransform:ColorTransform = new ColorTransform(0.8, 0.85, 0.9);
		
		public var parameters:DisintegrateParameter = new DisintegrateParameter();
		
		private var effectArea:Rectangle;
		
		private var blackBmp:BitmapData;
		private var burnAreaBmp:BitmapData;
		private var burnColorBmp:BitmapData;
		private var generatedPerlin:BitmapData;
		private var imageBmp:BitmapData;
		private var particleSelectorBmp:BitmapData;
		private var particleSelectionMask:BitmapData;
		private var selectedBurnParticles:BitmapData;
		private var transparentBmp:BitmapData;
		
		private var parent:DisplayObjectContainer;
		private var effectContainer:Sprite;
		private var twinkleLayer:Bitmap;
		private var effectLayer:Bitmap;
		private var particleLayer:Bitmap;
		private var displayObject:DisplayObject;
		
		public function DisintegrateFx(displayObject:DisplayObject)
		{
			this.displayObject = displayObject;
		}
		
		public function start():void
		{
			var margin:uint = parameters.particle.speed * 16;
			
			// setup common effect resources
			effectArea = new Rectangle(0, 0, displayObject.width, displayObject.height + 2 * margin);
			transparentBmp = new BitmapData(effectArea.width, effectArea.height, true, 0x00000000);
			blackBmp = new BitmapData(displayObject.width, effectArea.height, true, 0xff000000);
			
			// draw the display object into a bitmap
			imageBmp = transparentBmp.clone();
			imageBmp.draw(displayObject, new Matrix(1, 0, 0, 1, 0, margin));
			
			// setup the burn color bitmap to select from
			burnColorBmp = new BitmapData(effectArea.width, effectArea.height, true, parameters.burn.color);
			burnAreaBmp = burnColorBmp.clone();
			selectedBurnParticles = burnColorBmp.clone();
			particleSelectionMask = blackBmp.clone();
			
			// create the perlin noise to create mask from
			generatedPerlin = new BitmapData(effectArea.width, effectArea.height);
			generatedPerlin.perlinNoise(parameters.perlin.area, parameters.perlin.area, parameters.perlin.octaves, int(Math.random() * int.MAX_VALUE), false, true, 0, true);
			
			// overlay gradient over perlin noise to control effect direction
			var generatedGradient:Sprite = new Sprite();
			var gradientBox:Matrix = new Matrix();
			gradientBox.createGradientBox(effectArea.width, effectArea.height, parameters.gradient.direction, 0, 0);
			with (generatedGradient.graphics)
			{
				beginGradientFill(GradientType.LINEAR, [0x000000, 0xffffff], [parameters.gradient.strength, parameters.gradient.strength], [0, 255], gradientBox);
				drawRect(0, 0, effectArea.width, effectArea.height);
				endFill();
			}
			generatedPerlin.draw(generatedGradient);
			
			// create the particle selector bitmap
			var generatedNoise:BitmapData = transparentBmp.clone();
			generatedNoise.noise(int(Math.random() * int.MAX_VALUE), 0, 255, 7, true);
			particleSelectorBmp = blackBmp.clone();
			particleSelectorBmp.threshold(generatedNoise, effectArea, zeroPoint, ">", 0x00f00000, 0x00000000, 0x00ff0000, false);
			
			// create a effectContainer for the layers
			effectContainer = new Sprite();
			effectContainer.x = displayObject.x;
			effectContainer.y = displayObject.y - margin;
			
			// particleLayer layer
			particleLayer = new Bitmap(transparentBmp.clone());
			particleLayer.blendMode = BlendMode.ADD;
			effectContainer.addChild(particleLayer);
			
			// twinkleLayer layer
			twinkleLayer = new Bitmap(new BitmapData(effectArea.width / parameters.twinkle.size, effectArea.height / parameters.twinkle.size, true, 0x00000000), PixelSnapping.ALWAYS, true);
			twinkleLayer.blendMode = BlendMode.ADD;
			effectContainer.addChild(twinkleLayer);
			
			// image layer
			effectLayer = new Bitmap(transparentBmp.clone());
			effectContainer.addChild(effectLayer);
			
			// remove display object and add the effectContainer
			parent = displayObject.parent;
			var childIndex:int = parent.getChildIndex(displayObject);
			parent.removeChild(displayObject);
			parent.addChildAt(effectContainer, childIndex);
			
			// animation controls
			var animationTimer:Timer = new Timer(1000 / 30, 0.03 * parameters.duration);
			animationTimer.addEventListener(TimerEvent.TIMER, animationStep);
			animationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, animationComplete);
			animationTimer.start();
		}
		
		private function animationStep(e:TimerEvent):void
		{
			var upperThresholdColor:uint = e.target.currentCount / e.target.repeatCount * 0xff0000;
			var lowerThresholdColor:uint = (e.target.currentCount - parameters.burn.width) / e.target.repeatCount * 0xff0000;
			
			// lock the viewable layers
			effectLayer.bitmapData.lock();
			twinkleLayer.bitmapData.lock();
			particleLayer.bitmapData.lock();
			
			// reset the effect layer with the full image bitmap
			effectLayer.bitmapData.copyPixels(blackBmp, effectArea, zeroPoint);
			effectLayer.bitmapData.copyPixels(imageBmp, effectArea, zeroPoint);
			
			// reset the burn area and remove what is above and below the width threshold using the generated perlin as a mask
			burnAreaBmp.copyPixels(burnColorBmp, effectArea, zeroPoint);
			burnAreaBmp.threshold(generatedPerlin, effectArea, zeroPoint, ">", upperThresholdColor, 0x00000000, 0x00ff0000, false);
			burnAreaBmp.threshold(generatedPerlin, effectArea, zeroPoint, "<", lowerThresholdColor, 0x00000000, 0x00ff0000, false);
			
			// overlay the burn area over the image and remove from the image that which is below the threshold
			effectLayer.bitmapData.copyPixels(burnAreaBmp, effectArea, zeroPoint, null, null, true);
			effectLayer.bitmapData.copyChannel(imageBmp, effectArea, zeroPoint, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			effectLayer.bitmapData.threshold(generatedPerlin, effectArea, zeroPoint, "<", lowerThresholdColor, 0x00000000, 0x00ff0000, false);
			
			// setup the mask for the particle selection using the particle selector bitmap
			particleSelectionMask.copyPixels(blackBmp, effectArea, zeroPoint);
			burnAreaBmp.copyChannel(imageBmp, effectArea, zeroPoint, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			particleSelectionMask.copyPixels(burnAreaBmp, effectArea, zeroPoint, null, null, true);
			particleSelectionMask.copyPixels(particleSelectorBmp, effectArea, zeroPoint, null, null, true);
			
			// use the particle selection mask to select particles from the burn color bitmap
			selectedBurnParticles.copyPixels(burnColorBmp, effectArea, zeroPoint);
			selectedBurnParticles.copyChannel(particleSelectionMask, effectArea, zeroPoint, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			
			// overlay the particles into the particle layer and run the color transform
			particleLayer.bitmapData.copyPixels(selectedBurnParticles, effectArea, zeroPoint, null, null, true);
			particleLayer.bitmapData.colorTransform(effectArea, particleColorTransform);
			
			// move the particles upwards
			var particlePoint:Point = new Point(0, -parameters.particle.speed);
			particleLayer.bitmapData.copyPixels(particleLayer.bitmapData, effectArea, particlePoint);
			
			// neat trick to generate a glow on particles by pixelsnapping when scaling down whereafter you scale up for the glow
			twinkleLayer.bitmapData.copyPixels(transparentBmp, effectArea, zeroPoint);
			twinkleLayer.scaleX = twinkleLayer.scaleY = parameters.twinkle.size;
			var twinkleMatrix:Matrix = new Matrix(1 / parameters.twinkle.size, 0, 0, 1 / parameters.twinkle.size);
			twinkleLayer.bitmapData.draw(particleLayer.bitmapData, twinkleMatrix);
			
			// unlock the viewable layers
			particleLayer.bitmapData.unlock();
			twinkleLayer.bitmapData.unlock();
			effectLayer.bitmapData.unlock();
		}
		
		private function animationComplete(e:TimerEvent):void
		{
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, animationComplete);
			e.target.removeEventListener(TimerEvent.TIMER, animationStep);
			
			parent.removeChild(effectContainer);
		}
	
	}
}

class DisintegrateParameter
{
	public var duration:uint = 4000;
	public var twinkle:Twinkle = new Twinkle();
	public var particle:Particle = new Particle();
	public var burn:Burn = new Burn();
	public var perlin:Perlin = new Perlin();
	public var gradient:Gradient = new Gradient();
	
	public function DisintegrateParameter()
	{
	}

}

class Twinkle
{
	public var size:uint = 4;
}

class Particle
{
	public var speed:Number = 2;
}

class Perlin
{
	public var octaves:int = 8;
	public var area:int = 150;
}

class Gradient
{
	public var strength:Number = 0.5;
	public var direction:Number = Math.PI * 0.5;
}

class Burn
{
	public var width:Number = 1;
	
	private var _color:uint = 0xFFFFFFFF;
	
	public function get color():uint
	{
		return _color;
	}
	
	public function set color(value:uint):void
	{
		if ((value & 0xFF000000) == 0)
		{
			value |= 0xFF000000;
		}
		_color = value;
	}

}