package
{
	import avdw.decorator.background.FlatBackground;
	import com.bit101.components.ComboBox;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.color.*;
	import net.avdw.debug.*;
	import net.avdw.generate.linearGradient;
	import net.avdw.interp.*;
	import net.avdw.number.*;
	import net.avdw.dice.*;
	import net.avdw.random.*;
	import net.avdw.test.*;
	import net.avdw.demo.*;
	import net.avdw.ui.Navbar;
	
	public class Driver extends Sprite
	{
		private var demoContainer:Sprite;
		
		public function Driver()
		{
			addChild(new Bitmap(linearGradient(stage.stageWidth, stage.stageHeight, Gradient.BG_DARK)));
			addChild(new DemoContainer());
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var str:String = "Quick and dirty tests:";
			str += "\nnet.avdw.color.combineARGB:	" + testEqual(combineARGB(1, 0, 0.5, 0), 4278222592);
			str += "\nnet.avdw.color.extractARGB:	" + testEqual(extractARGB(0xff003300).g, 0.2);
			str += "\nnet.avdw.number.rangeBetween:	" + testEqual(rangeBetween(5, -2), rangeBetween(-2, 5));
			str += "\nnet.avdw.number.normalize:\t\t" + testEqual(normalize(3, -2, 6), normalize(3, 6, -2), normalize(5, 8));
			str += "\nnet.avdw.number.interpolate:	" + testEqual(interpolate(-2, 2, 0.25), -interpolate(2, -2, 0.25));
			str += "\nnet.avdw.number.interpolate:	" + testNotEqual(interpolate(2, -2, 0.25, cubicEaseIn), interpolate(-2, 2, 0.25), interpolate(2, -2, 0.25));
			str += "\nnet.avdw.dice.roll:			" + testSmallerThan(7, roll(6), roll(6), roll(6));
			str += "\nnet.avdw.random.names:		" + randomRealMaleName() + " & " + randomRealFemaleName() + " " + randomRealLastName();
			str += "\nnet.avdw.random.scenario:		" + randomScenario();
			trace(str);
			
			//demoContainer = new Sprite();
			//addChild(demoContainer);
			
			//var selectorWidth:int = 200;
			//var demoSelector:ComboBox = new ComboBox(this, ((stage.stageWidth - selectorWidth) / 2), 5, "please select demo", [FilterToSepiaDemo, FilterToGrayDemo, FilterToColorDemo, CollisionDemo, CenterSlideFxDemo, CheckerboardDemo, HSLColorPaletteDemo, HSVColorPaletteDemo, RGBColorPaletteDemo]);
			//demoSelector.width = selectorWidth;
			//demoSelector.addEventListener(Event.SELECT, showDemo);
			//addChild(demoSelector);
		}
		
		private function showDemo(e:Event):void
		{
			if (demoContainer.numChildren != 0)
				demoContainer.removeChildren();
			if (e.target.selectedItem != null)
				demoContainer.addChild(new e.target.selectedItem());
		}
	}
}

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BevelFilter;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import net.avdw.color.Gradient;
import net.avdw.generate.checkerboard;
import net.avdw.random.randomRealMaleName;
import net.avdw.random.randomRealLastName;
import net.avdw.sprite.createRectangle;
import net.avdw.textfield.createTextField;
import net.avdw.ui.Navbar;

class DemoContainer extends Sprite
{
	private const MARGIN:int = 64;
	private var textfield:TextField;
	
	public function DemoContainer()
	{
		filters = [new GlowFilter(0x0)];
		textfield = createTextField("\t\t\t\t\t\t\t\t", 12, 0x0, TextFieldAutoSize.CENTER, true);
		
		if (stage)
			addedToStage();
		else
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	private function nextDemo(e:MouseEvent):void 
	{
		textfield.text = randomRealMaleName() + " " + randomRealMaleName() + " " + randomRealLastName();
	}
	
	private function prevDemo(e:MouseEvent):void 
	{
		textfield.text = randomRealMaleName() + " " + randomRealMaleName() + " " + randomRealLastName();
	}
	
	private function addedToStage(e:Event = null):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		graphics.beginFill(0x202020);
		graphics.drawRect(0, 0, stage.stageWidth - 2 * MARGIN, stage.stageHeight - MARGIN);
		graphics.endFill();
		
		this.x = MARGIN;
		this.y = MARGIN * .5;
	
		addChild(new Bitmap(checkerboard(width, height, height * .06, height * .06, 0xFF111111, 0xFF171717)));
		
		var navbar:Navbar = new Navbar();
		navbar.addLeft(new Button(Button.LEFT, prevDemo));
		navbar.addCenter(textfield);
		navbar.addRight(new Button(Button.RIGHT, nextDemo));
		addChild(navbar);
	}
}

class Button extends Sprite
{
	[Embed(source="../../assets/images/icons/colored-developer-buttons/arrow left Blue.png")]
	private const LEFT_ARROW:Class;
	[Embed(source="../../assets/images/icons/colored-developer-buttons/arrow right Blue.png")]
	private const RIGHT_ARROW:Class;
	
	
	static public const LEFT:String = "left";
	static public const RIGHT:String = "right";
	
	private var callback:Function;
	
	public function Button(direction:String, callback:Function)
	{
		this.callback = callback;
		addChild(direction == LEFT ? new LEFT_ARROW() : new RIGHT_ARROW());
		
		addEventListener(MouseEvent.ROLL_OVER, rollOver);
		addEventListener(MouseEvent.ROLL_OUT, rollOut);
		addEventListener(MouseEvent.CLICK, callback);
		addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
	}
	
	private function removedFromStage(e:Event):void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		removeEventListener(MouseEvent.ROLL_OVER, rollOver);
		removeEventListener(MouseEvent.ROLL_OUT, rollOut);
		removeEventListener(MouseEvent.CLICK, callback);
	}
	
	private function rollOut(e:MouseEvent):void 
	{
		filters = [];
		Mouse.cursor = MouseCursor.AUTO;
	}
	
	private function rollOver(e:MouseEvent):void 
	{
		filters = [new GlowFilter(0xFFFFFF)];
		Mouse.cursor = MouseCursor.BUTTON;
	}
}
