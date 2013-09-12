package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import net.avdw.align.centerAlignHorizontally;
	import net.avdw.display.addChildren;
	import net.avdw.physics.overlap;
	import net.avdw.textfield.createTextField;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class CollisionDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/256x256 Yoda.png")]
		private const YodaClass:Class;
		[Embed(source="../../../../../assets/images/256x256 Monster.png")]
		private const MonsterClass:Class
		
		private var debugBmp:Bitmap;
		private var yodaContainer:DisplayObjectContainer;
		private var monsterContainer:DisplayObjectContainer;
		private var collisionText:TextField;
		private var noCollisionText:TextField;
		
		public function CollisionDemo()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			debugBmp = new Bitmap();
			
			yodaContainer = new Sprite();
			var yodaBmp:Bitmap = new YodaClass();
			yodaBmp.x -= yodaBmp.width / 2;
			yodaBmp.y -= yodaBmp.height / 2;
			yodaContainer.x = stage.stageWidth / 2 - yodaBmp.width / 3;
			yodaContainer.y = stage.stageHeight / 2;
			yodaContainer.addChild(yodaBmp);
			
			monsterContainer = new Sprite();
			var monsterBmp:Bitmap = new MonsterClass();
			monsterBmp.x -= monsterBmp.width / 2;
			monsterBmp.y -= monsterBmp.height / 2;
			monsterContainer.x = stage.stageWidth / 2 + monsterBmp.width / 3;
			monsterContainer.y = stage.stageHeight / 2;
			monsterContainer.addChild(monsterBmp);
			
			collisionText = createTextField("Collision", 16, 0x009900);
			noCollisionText = createTextField("No Collision", 16, 0x990000);
			centerAlignHorizontally([collisionText, noCollisionText], stage);
			collisionText.y = noCollisionText.y = monsterContainer.x - collisionText.textHeight;
			
			addChildren([yodaContainer, monsterContainer, debugBmp, collisionText, noCollisionText], this);
			
			
			addEventListener(Event.ENTER_FRAME, animate);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		private function removedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			removeEventListener(Event.ENTER_FRAME, animate);
		}
		
		private function animate(e:Event):void
		{
			yodaContainer.rotation -= 1;
			monsterContainer.rotation += 1;
			if (overlap(monsterContainer, yodaContainer, stage, 127, debugBmp)) {
				collisionText.visible = true;
				noCollisionText.visible = false;
			} else {
				collisionText.visible = false;
				noCollisionText.visible = true;
			}
		}
	}

}