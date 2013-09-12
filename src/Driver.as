package
{
	import com.bit101.components.ComboBox;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.color.*;
	import net.avdw.debug.*;
	import net.avdw.interp.*;
	import net.avdw.number.*;
	import net.avdw.dice.*;
	import net.avdw.random.*;
	import net.avdw.test.*;
	import net.avdw.demo.*;
	
	public class Driver extends Sprite
	{
		private var demoContainer:Sprite;
		
		public function Driver()
		{
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
			
			demoContainer = new Sprite();
			addChild(demoContainer);
			
			var selectorWidth:int = 200;
			var demoSelector:ComboBox = new ComboBox(this, ((stage.stageWidth - selectorWidth) / 2), 5, "please select demo", [FilterToSepiaDemo, FilterToGrayDemo, FilterToColorDemo, CollisionDemo, CenterSlideFxDemo, CheckerboardDemo, HSLColorPaletteDemo, HSVColorPaletteDemo, RGBColorPaletteDemo]);
			demoSelector.width = selectorWidth;
			demoSelector.addEventListener(Event.SELECT, showDemo);
			addChild(demoSelector);
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