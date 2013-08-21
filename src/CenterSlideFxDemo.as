package
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.avdw.generate.generateCheckerboard;
	
	import net.avdw.align.centerAlignHorizontally;
	import net.avdw.align.spaceVertically;
	import net.avdw.fx.centerSlideFxRevealVertically;
	import net.avdw.fx.centerSlideFxRevealHorizontally;
	import net.avdw.fx.centerSlideFxHideVertically;
	import net.avdw.fx.centerSlideFxHideHorizontally;
	
	import net.avdw.interp.*;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class CenterSlideFxDemo extends Sprite
	{
		[Embed(source="../../images/239x340 Card Sample 2.png")]
		private const CardClass:Class;
		private var cardBmp:Bitmap;
		private var cardContainer:Sprite;
		private var hideHorizontallyBtn:PushButton;
		private var hideVerticallyBtn:PushButton;
		private var revealHorizontallyBtn:PushButton;
		private var revealVerticallyBtn:PushButton;
		
		public function CenterSlideFxDemo()
		{
			cardBmp = new CardClass();
			cardBmp.x -= cardBmp.width >> 1;
			cardBmp.y -= cardBmp.height >> 1;
			addChild(cardBmp);
			
			cardContainer = new Sprite();
			cardContainer.addChild(cardBmp);
			addChild(cardContainer);
			
			if (stage)
				addedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addEventListener(Event.ENTER_FRAME, rotate);
		}
		
		private function rotate(e:Event):void
		{
			cardContainer.rotation += 1;
		}
		
		private function addedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addChildAt(new Bitmap(generateCheckerboard(stage.stageWidth, stage.stageHeight)), 0);
			
			cardContainer.x = stage.stageWidth >> 1;
			cardContainer.y = stage.stageHeight >> 1;
			
			var duration:int = 1500;
			var comboBox:ComboBox = new ComboBox(this, 0, 0, "interp", 
			[ { label:"quadEaseInOut", value:quadEaseInOut }, { label:"backEaseInOut", value:backEaseInOut }, { label:"circEaseInOut", value:circEaseInOut }
			, { label:"cubicEaseInOut", value:cubicEaseInOut }, { label:"bounceEaseInOut", value:bounceEaseInOut }, { label:"elasticEaseInOut", value:elasticEaseInOut } ]
			);
			comboBox.selectedIndex = 0;
			
			revealVerticallyBtn = new PushButton(this, 0, 0, "Reveal Vertically", function():void
				{
					centerSlideFxRevealVertically(cardBmp, duration, comboBox.selectedItem.value as Function, revealComplete);
					hideAll();
				});
			revealHorizontallyBtn = new PushButton(this, 0, 0, "Reveal Horizontally", function():void
				{
					centerSlideFxRevealHorizontally(cardBmp, duration, comboBox.selectedItem.value as Function, revealComplete);
					hideAll();
				});
			hideVerticallyBtn = new PushButton(this, 0, 0, "Hide Vertically", function():void
				{
					centerSlideFxHideVertically(cardBmp, duration, comboBox.selectedItem.value as Function, hideComplete);
					hideAll();
				});
			hideHorizontallyBtn = new PushButton(this, 0, 0, "Hide Horizontally", function():void
				{
					centerSlideFxHideHorizontally(cardBmp, duration, comboBox.selectedItem.value as Function, hideComplete);
					hideAll();
				});
			
			revealVerticallyBtn.y = (stage.stageHeight >> 1) - revealVerticallyBtn.height * 2 - 10;
			spaceVertically([revealVerticallyBtn, revealHorizontallyBtn, hideVerticallyBtn, hideHorizontallyBtn], 5);
			centerAlignHorizontally([comboBox], stage);
			
			revealHorizontallyBtn.visible = false;
			revealVerticallyBtn.visible = false;
		}
		
		private function hideAll():void
		{
			revealHorizontallyBtn.visible = false;
			revealVerticallyBtn.visible = false;
			hideHorizontallyBtn.visible = false;
			hideVerticallyBtn.visible = false;
		}
		
		private function hideComplete():void
		{
			revealHorizontallyBtn.visible = true;
			revealVerticallyBtn.visible = true;
		}
		
		private function revealComplete():void
		{
			hideHorizontallyBtn.visible = true;
			hideVerticallyBtn.visible = true;
		}
	
	}

}