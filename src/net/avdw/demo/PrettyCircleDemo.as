package net.avdw.demo
{
	import avdw.action.ScreenshotAction;
	import avdw.math.vector2d.Vec2;
	import avdw.math.vector2d.Vec2Const;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.ShaderParameter;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import uk.co.soulwire.gui.SimpleGUI;
	import utils.color.HSLtoRGB;
	import utils.color.toRGBComponents;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	[SWF(backgroundColor="0x0",frameRate="30",width="680",height="495")]
	public class PrettyCircleDemo extends Sprite
	{
		private var blurNoneLayer:Sprite= new Sprite();
		private var blur2xLayer:Sprite= new Sprite();
		private var blur4xLayer:Sprite= new Sprite();
		private var blur8xLayer:Sprite = new Sprite();
		public var brightnessLayer:Sprite = new Sprite();
		public var numCircles:int = 50;
		public var circleMinSize:int = 10;
		public var circleVariability:int = 50;
		
		public function PrettyCircleDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var hypV:Vec2Const = new Vec2Const(stage.stageWidth, stage.stageHeight);
			var heightV:Vec2Const = new Vec2Const(0, stage.stageHeight);
			var heightProjHypV:Vec2Const = hypV.normalize().scaleSelf(heightV.dot(hypV.normalize()));
			var displaceV:Vec2Const = heightV.sub(heightProjHypV);
			var colorLayer:Bitmap = new Bitmap(new BitmapData(hypV.length(), displaceV.length()*2));
			for (var x:int = 0; x < hypV.length(); x++) {
				for (var y:int = 0; y < displaceV.length()*2; y++) {
					var color:Object = HSLtoRGB((x / hypV.length()) * 360, 0.5, 0.5);
					colorLayer.bitmapData.setPixel(x, y, toRGBComponents(color.r * 0xFF, color.g * 0xFF, color.b * 0xFF));
				}
			}
			colorLayer.blendMode = BlendMode.MULTIPLY;
			colorLayer.rotation = -hypV.getDegrees();
			colorLayer.y = stage.stageHeight; // move origin to bottom left
			colorLayer.x += displaceV.x;
			colorLayer.y -= displaceV.y;
			
			brightnessLayer.graphics.beginFill(0xFFFFFF);
			brightnessLayer.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			brightnessLayer.graphics.endFill();
			brightnessLayer.blendMode = BlendMode.OVERLAY;
			
			blur2xLayer.filters = [new BlurFilter()];
			blur4xLayer.filters = [new BlurFilter(8, 8)];
			blur8xLayer.filters = [new BlurFilter(64, 64)];
			
			addChild(blur8xLayer);
			addChild(blur4xLayer);
			addChild(blur2xLayer);
			addChild(blurNoneLayer);
			addChild(colorLayer);
			addChild(brightnessLayer);
			
			generate();
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addSlider("numCircles", 25, 75);
			gui.addSlider("circleMinSize", 5, 25);
			gui.addSlider("circleVariability", 0, 75);
			gui.addButton("generate", { callback: generate } );
			gui.show();
		}
		
		private function generate():void {
			resetLayer(blurNoneLayer);
			resetLayer(blur2xLayer);
			resetLayer(blur4xLayer);
			resetLayer(blur8xLayer);
			
			for (var i:int = 0; i < numCircles; i++ ) {
				drawCircle(blurNoneLayer);
				drawCircle(blur2xLayer);
				drawCircle(blur4xLayer);
				drawCircle(blur8xLayer);
			}
		}
	
		
		private function drawCircle(s:Sprite):void {
			var gradientMatrix:Matrix = new Matrix();
			var rad:int = Math.random() * circleVariability + circleMinSize;
			var x:int = Math.random() * stage.stageWidth;
			var y: int = Math.random() * stage.stageHeight;
			gradientMatrix.createGradientBox(rad*2, rad*2, 0, x-rad, y-rad);
			s.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xFFFFFF], [0.075, 0.15], [0, 255], gradientMatrix);
			s.graphics.drawCircle(x, y, rad);
		}
		
		private function resetLayer(s:Sprite):void {
			s.graphics.clear();
			s.graphics.lineStyle(1.5, 0xFFFFFF, 0.15);
		}
	}

}