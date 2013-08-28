package net.avdw.random
{
	import net.avdw.array.randomItemFrom;
	import net.avdw.file.loadLinesFromTextFile;
	
	public function randomWords(number:int = 1, minLength:int = int.MIN_VALUE, maxLength:int = int.MAX_VALUE):Array
	{
		var words:Array = [];
		words = words.concat(loadLinesFromTextFile(Resource.ActionWordListFile));
		words = words.concat(loadLinesFromTextFile(Resource.AdjectiveWordListFile));
		words = words.concat(loadLinesFromTextFile(Resource.AdjectiveExtraWordListFile));
		
		words = words.filter(function(item:String, index:int, array:Array):Boolean {
			return item.length >= minLength && item.length <= maxLength;
		});
		
		var randomWordsArray:Array = [];
		for (var i:int = 0; i < number; i++) {
			randomWordsArray.push(randomItemFrom(words));
		}
		
		return randomWordsArray;
	}
}

class Resource {
	[Embed(source="../../../../../assets/text/action-words.txt",mimeType="application/octet-stream")]
	static public const ActionWordListFile:Class;
	[Embed(source = "../../../../../assets/text/adjectives.txt",mimeType="application/octet-stream")]
	static public const AdjectiveWordListFile:Class;
	[Embed(source = "../../../../../assets/text/adjectives-extra.txt",mimeType="application/octet-stream")]
	static public const AdjectiveExtraWordListFile:Class;
	
}