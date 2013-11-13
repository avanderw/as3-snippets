package net.avdw.demo
{
	import com.junkbyte.console.Console;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import net.avdw.file.loadLinesFromTextFile;
	import net.avdw.file.loadTextFile;
	import net.avdw.object.randomKeyFrom;
	import net.avdw.random.randomWordsFromMarkovChain;
	import net.avdw.stats.markovChainFromText;
	import net.avdw.stats.markovChainFromTitles;
	import uk.co.soulwire.gui.SimpleGUI;
	
	public class MarkovChainDemo extends Sprite
	{
		[Embed(source="../../../../../assets/text/movie-titles.txt",mimeType="application/octet-stream")]
		private const TextFile:Class;
		private var chain:Object;
		
		public var chainOrder:int = 2;
		public var titleLength:int = 5;
		
		public function MarkovChainDemo()
		{
			if (stage)
				start();
			else
				addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		private function start(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, start);
			addEventListener(Event.ENTER_FRAME, buildChain);
			
			var gui:SimpleGUI = new SimpleGUI(this);
			gui.addStepper("chainOrder", 1, 5, { callback:buildChain} );
			gui.addStepper("titleLength", 1, 10);
			gui.addButton("random title", {callback:randomTitle});
			gui.show();
			
			var text:TextField = new TextField();
			text.text = 
		}
		
		private function randomTitle():void 
		{
			trace(randomWordsFromMarkovChain(chain, titleLength, true));
		}
		
		private function buildChain(e:Event = null):void 
		{
			removeEventListener(Event.ENTER_FRAME, buildChain);
			chain = markovChainFromTitles(loadLinesFromTextFile(TextFile), chainOrder);
		}
	}
}