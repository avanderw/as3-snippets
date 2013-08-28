package net.avdw.text
{
	import net.avdw.array.print2x2Matrix;
	import net.avdw.random.randomInteger;
	import net.avdw.random.randomLowerCaseLetter;
	import net.avdw.random.randomWords;
	
	public function generateWordSearch(width:int = 16, height:int = 16):Array
	{
		var i:int;
		var wordSearch:Array = [];
		for (i = 0; i < height; i++)
		{
			var letters:Array = [];
			for (var j:int = 0; j < width; j++)
			{
				letters.push(".");
			}
			wordSearch.push(letters);
		}
		
		var row:int;
		var col:int;
		var words:Array = randomWords(5, 5, 8);
		for each (var word:String in words) {
			var repeat:Boolean = true;
			while (repeat) {
				col = randomInteger(width - word.length);
				row = randomInteger(height);
				
				if (wordSearch[row][col] != "." || wordSearch[row][col + word.length - 1] != "." || wordSearch[row][col + Math.round(word.length * .5)] != ".")
					continue;
				
				for (i = 0; i < word.length; i++)
					wordSearch[row][col + i] = word.charAt(i);
			
				repeat = false;
			}
		}
		print2x2Matrix(wordSearch);
		return wordSearch;
	}
}