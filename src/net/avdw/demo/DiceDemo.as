package net.avdw.demo
{
	import com.bit101.charts.BarChart;
	import com.bit101.components.Label;
	import com.bit101.components.TextArea;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import net.avdw.align.*;
	import net.avdw.color.GradientEnum;
	import net.avdw.stats.rollDice;
	import net.avdw.generate.*;
	import uk.co.soulwire.gui.SimpleGUI;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class DiceDemo extends Sprite
	{
		private const distributionData:Array = [];
		private const basicData:Array = [];
		private const critData:Array = [];
		private var distributionChart:BarChart;
		private var minBasicLabel:Label;
		private var maxBasicLabel:Label;
		private var rangeBasicLabel:Label;
		private var mostFreqBasicLabel:Label;
		private var minCritLabel:Label;
		private var maxCritLabel:Label;
		private var rangeCritLabel:Label;
		private var mostFreqCritLabel:Label;
		private var minDistributionLabel:Label;
		private var maxDistributionLabel:Label;
		private var rangeDistributionLabel:Label;
		private var mostFreqDistributionLabel:Label;
		private var mostFreqSuccessCritLabel:Label;
		private var critChart:BarChart;
		private var basicChart:BarChart;
		public var numDice:int = 3;
		public var numSides:int = 6;
		public var bonus:int = -1;
		public var numRolls:int = 5000;
		public var numHighToRemove:int = 1;
		public var numLowToRemove:int = 0;
		public var critNumDice:int = 3;
		public var critNumSides:int = 6;
		public var critBonus:int = 3;
		public var critNumHighToRemove:int = 0;
		public var critNumLowToRemove:int = 1;
		public var critChance:Number = 0.2;
		public var addCriticals:Boolean = true;
		
		public function DiceDemo()
		{
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			if (parent is Stage)
				addChild(new Bitmap(checkerboard((parent as Stage).stageWidth, (parent as Stage).stageHeight, 32, 32, 0xFF101010, 0xFF151515)));
			else
				addChild(new Bitmap(checkerboard(parent.width, parent.height, 32, 32, 0xFF101010, 0xFF151515)));
			
			var chartWidth:int = 187;
			var chartContainer:Sprite = new Sprite();
			basicChart = new BarChart(chartContainer, 1, 0, basicData);
			critChart = new BarChart(chartContainer, basicChart.x + chartWidth + 1, 0, critData);
			distributionChart = new BarChart(chartContainer, critChart.x + chartWidth + 1, 0, distributionData);
			addChild(chartContainer);
			
			basicChart.width = critChart.width = distributionChart.width = chartWidth;
			
			basicChart.autoScale = false;
			critChart.autoScale = false;
			distributionChart.autoScale = false;
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addGroup("basic settings");
			gui.addStepper("numDice", 1, 12, {callback: roll});
			gui.addStepper("numSides", 1, 60, {callback: roll});
			gui.addStepper("bonus", -30, 30, {callback: roll});
			gui.addStepper("numLowToRemove", 0, 12, {callback: roll});
			gui.addStepper("numHighToRemove", 0, 12, {callback: roll});
			
			gui.addColumn("critical settings");
			gui.addStepper("critNumDice", 1, 12, {label: "Num Dice", callback: roll});
			gui.addStepper("critNumSides", 1, 60, {label: "Num Sides", callback: roll});
			gui.addStepper("critBonus", -30, 30, {label: "Bonus", callback: roll});
			gui.addStepper("critNumLowToRemove", 0, 12, {label: "Num Low To Remove", callback: roll});
			gui.addStepper("critNumHighToRemove", 0, 12, {label: "Num High To Remove", callback: roll});
			
			gui.addColumn("controls");
			gui.addSlider("critChance", 0, 1, { callback: roll } );
			gui.addToggle("addCriticals", { callback:roll } );
			gui.addSlider("numRolls", 500, 10000, {callback: roll});
			gui.addButton("reroll", {callback: roll});
			
			gui.show();
			
			minBasicLabel = new Label(chartContainer, basicChart.x, basicChart.y + basicChart.height + 1, "");
			maxBasicLabel = new Label(chartContainer, basicChart.x, minBasicLabel.y + minBasicLabel.height, "");
			rangeBasicLabel = new Label(chartContainer, basicChart.x, maxBasicLabel.y + maxBasicLabel.height, "");
			mostFreqBasicLabel = new Label(chartContainer, basicChart.x, rangeBasicLabel.y + rangeBasicLabel.height, "");
			
			minCritLabel = new Label(chartContainer, critChart.x, critChart.y + critChart.height + 1, "");
			maxCritLabel = new Label(chartContainer, critChart.x, minCritLabel.y + minCritLabel.height, "");
			rangeCritLabel = new Label(chartContainer, critChart.x, maxCritLabel.y + maxCritLabel.height, "");
			mostFreqCritLabel = new Label(chartContainer, critChart.x, rangeCritLabel.y + rangeCritLabel.height, "");
			
			minDistributionLabel = new Label(chartContainer, distributionChart.x, distributionChart.y + distributionChart.height + 1, "");
			maxDistributionLabel = new Label(chartContainer, distributionChart.x, minDistributionLabel.y + minDistributionLabel.height, "");
			rangeDistributionLabel = new Label(chartContainer, distributionChart.x, maxDistributionLabel.y + maxDistributionLabel.height, "");
			mostFreqDistributionLabel = new Label(chartContainer, distributionChart.x, rangeDistributionLabel.y + rangeDistributionLabel.height, "");
			mostFreqSuccessCritLabel = new Label(chartContainer, distributionChart.x, mostFreqDistributionLabel.y + mostFreqDistributionLabel.height, "");
			
			roll();
			
			chartContainer.y = 172;
			chartContainer.x = 1;
			
			var textArea:Label = new Label(this, chartContainer.x, chartContainer.y + chartContainer.height + 18);
			textArea.width = chartContainer.width;
			textArea.text = "Removing dice skews the distribution to the right when removing the lowest dice and to the left when removing the highest dice.\n"
				+ "Adding successful criticals skews distribution to the right whilst removing successful criticals skews the distribution to the left.\n"
				+ "Use asymmetry to make higher-than-average or lower-than-average value occur more often. Attribute rolls often make higher than average\n"
				+ "values more common, using max, best of three, or rerolling the lowest. Damage rolls often make lower than average values more common,\n"
				+ "using min, or critical bonuses. Random encounter difficulty also often makes lower than average values more common. Use the number of\n"
				+ "rolls to control the variance. A low number of rolls corresponds to a high variance, and vice versa. Use the offset and die size to control\n"
				+ "the scale. If you want the random numbers to range from X to Y, then each of the N rolls should produce a random number from 0 to (Y-X)/N,\n"
				+ "and add X to the sum. Positive offsets can be used for bonus damage or bonus attributes; negative offsets can be used for blocking damage.";
		}
		
		private function roll():void
		{
			distributionData.splice(0, distributionData.length);
			basicData.splice(0, basicData.length);
			critData.splice(0, critData.length);
			
			var i:int, basic:int, crit:int, combined:int;
			for (i = 0; i < numRolls; i++)
			{
				basic = rollDice(numDice, numSides, bonus, numHighToRemove, numLowToRemove);
				crit = rollDice(critNumDice, critNumSides, critBonus, critNumHighToRemove, critNumLowToRemove);
				combined = Math.random() < critChance ? (addCriticals) ? basic + crit : basic - crit : basic;
				
				bucket(basicData, basic);
				bucket(critData, crit);
				bucket(distributionData, combined);
			}
			
			fillEmpty(basicData);
			fillEmpty(critData);
			fillEmpty(distributionData);
			
			statsWith(basicData, minBasicLabel, maxBasicLabel, mostFreqBasicLabel, rangeBasicLabel);
			statsWith(critData, minCritLabel, maxCritLabel, mostFreqCritLabel, rangeCritLabel);
			statsWith(distributionData, minDistributionLabel, maxDistributionLabel, mostFreqDistributionLabel, rangeDistributionLabel);
			mostFreqSuccessCritLabel.text = "Most Freq Successful Critical: " + (basicData.indexOf(Math.max.apply(this, basicData)) + critData.indexOf(Math.max.apply(this, critData)));
			
			basicChart.maximum = Math.max.apply(this, basicData);
			basicChart.draw();
			critChart.maximum = Math.max.apply(this, critData);
			critChart.draw();
			distributionChart.maximum = Math.max.apply(this, distributionData);
			distributionChart.draw();
		}
		
		private function fillEmpty(distributionData:Array):void
		{
			for (var i:int = 0; i < distributionData.length; i++)
				if (!distributionData[i])
					distributionData[i] = 0;
		}
		
		private function bucket(distributionData:Array, combined:int):void
		{
			if (!distributionData[combined])
				distributionData[combined] = 0;
			
			distributionData[combined]++;
		}
		
		private function statsWith(distributionData:Array, minLabel:Label, maxLabel:Label, mostFreqLabel:Label, rangeLabel:Label):void
		{
			var i:int = 0;
			while (i < distributionData.length && distributionData[i] == 0)
				i++;
			
			minLabel.text = "Min Roll: " + i;
			maxLabel.text = "Max Roll: " + (distributionData.length - 1);
			mostFreqLabel.text = "Most Frequent Roll: " + (distributionData.indexOf(Math.max.apply(this, distributionData)));
			rangeLabel.text = "Range: " + (distributionData.length - i - 1);
		}
	
	}

}