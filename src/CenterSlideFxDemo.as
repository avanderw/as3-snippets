package
{
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.avdw.align.spaceVertically;
	import net.avdw.fx.centerSlideRevealVertically;
	import net.avdw.fx.centerSlideRevealHorizontally;
	import net.avdw.fx.centerSlideHideVertically;
	import net.avdw.fx.centerSlideHideHorizontally;
	import net.avdw.interp.expoEaseOut;
	
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
			
			cardContainer.x = stage.stageWidth >> 1;
			cardContainer.y = stage.stageHeight >> 1;
			
			var revealVerticallyBtn:PushButton = new PushButton(this, 0, 0, "Reveal Vertically", function():void
				{
					centerSlideRevealVertically(cardBmp);
				});
			var revealHorizontallyBtn:PushButton = new PushButton(this, 0, 0, "Reveal Horizontally", function():void
				{
					centerSlideRevealHorizontally(cardBmp);
				});
			var hideVerticallyBtn:PushButton = new PushButton(this, 0, 0, "Hide Vertically", function():void
				{
					centerSlideHideVertically(cardBmp);
				});
			var hideHorizontallyBtn:PushButton = new PushButton(this, 0, 0, "Hide Horizontally", function():void
				{
					centerSlideHideHorizontally(cardBmp);
				});
			
			spaceVertically([revealVerticallyBtn, revealHorizontallyBtn, hideVerticallyBtn, hideHorizontallyBtn], 5);
		}
	
	}

}