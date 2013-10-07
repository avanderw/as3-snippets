package net.avdw.ui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import net.avdw.align.centerAlign;
	import net.avdw.align.centerAlignChildrenVertically;
	import net.avdw.align.centerAlignHorizontally;
	import net.avdw.align.centerAlignVertically;
	import net.avdw.align.rightAlignHorizontally;
	import net.avdw.align.spaceChildrenHorizontally;
	import net.avdw.align.spaceHorizontally;
	import net.avdw.color.Gradient;
	import net.avdw.display.addChildren;
	import net.avdw.enum.AlignEnum;
	import net.avdw.generate.linearGradient;
	
	public class Navbar extends Sprite
	{
		private const leftContent:Sprite = new Sprite();
		private const centerContent:Sprite = new Sprite();
		private const rightContent:Sprite = new Sprite();
		
		private var _height:int;
		private var gradient:Gradient;
		
		public function Navbar(gradient:Gradient = null, height:int = 40)
		{
			this.gradient = gradient == null ? Gradient.NAVBAR_GREEN : gradient;
			this._height = height;
			
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addChild(new Bitmap(linearGradient(parent.width, _height, gradient, Math.PI * .5)));
			addChildren([leftContent, centerContent, rightContent], this);
			
			alignContent();
		}
		
		private function alignContent():void
		{
			spaceChildrenHorizontally([leftContent, centerContent, rightContent], 5);
			centerAlignChildrenVertically([leftContent, centerContent, rightContent]);
			centerAlignVertically([leftContent, centerContent, rightContent]);
			centerAlignHorizontally([centerContent]);
			rightAlignHorizontally([rightContent]);
			
			leftContent.x = 5;
			rightContent.x = rightContent.x > 5 ? rightContent.x - 5 : 0;
		}
		
		public function addRight(content:DisplayObject):void
		{
			rightContent.addChild(content);
			alignContent();
		}
		
		public function addCenter(content:DisplayObject):void
		{
			centerContent.addChild(content);
			alignContent();
		}
		
		public function addLeft(content:DisplayObject):void
		{
			leftContent.addChild(content);
			alignContent();
		}
	}
}