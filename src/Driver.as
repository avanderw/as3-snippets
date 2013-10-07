package
{
	import avdw.decorator.background.FlatBackground;
	import com.bit101.components.ComboBox;
	import com.bit101.components.FPSMeter;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.align.*;
	import net.avdw.color.*;
	import net.avdw.debug.*;
	import net.avdw.display.addChildren;
	import net.avdw.generate.*;
	import net.avdw.interp.*;
	import net.avdw.number.*;
	import net.avdw.dice.*;
	import net.avdw.random.*;
	import net.avdw.sprite.*;
	import net.avdw.test.*;
	import net.avdw.demo.*;
	import net.avdw.ui.*;
	
	public class Driver extends Sprite
	{
		private const margin:uint = 15;
		private const demos:Array = [];
		private var demoContainer:Sprite;
		private var fpsMeter:Label;
		private var memMeter:Label;
		private var statContainer:Sprite;
		
		public function Driver()
		{
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			SWFProfiler.init(stage, this);
			addChild(new Bitmap(linearGradient(stage.stageWidth, stage.stageHeight, GradientEnum.BG_DARK)));
			
			statContainer = createRectangle(stage.stageWidth, 20, ColorEnum.WHITE.value);
			addChild(statContainer);
			fpsMeter = new Label(statContainer, 0, 0, "FPS: 00");
			memMeter = new Label(statContainer, 0, 0, "MEM: 000.00");
			spaceChildrenHorizontally([statContainer]);
			addEventListener(Event.ENTER_FRAME, updateStats);
			
			var list:List = new List(this, 0, 0, demos);
			list.x = margin;
			list.height = stage.stageHeight - 2 * margin;
			list.width = 200;
			list.alternateRows = true;
			centerAlignVertically([list]);
			list.addEventListener(Event.SELECT, showDemo);
			
			var demoWidth:int = stage.stageWidth - 3 * margin - list.width;
			var demoHeight:int = stage.stageHeight - 2 * margin;
			demoContainer = createRectangle(demoWidth, demoHeight);
			//addChild(demoContainer);
			bottomRightAlign([demoContainer]);
			demoContainer.y -= margin;
			demoContainer.x -= margin;
		}
		
		private function updateStats(e:Event):void 
		{
			if (!isNaN(SWFProfiler.currentFps))
				fpsMeter.text = "FPS: " + SWFProfiler.currentFps.toPrecision(2);
			memMeter.text = "MEM: " + SWFProfiler.currentMem.toPrecision(5);
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