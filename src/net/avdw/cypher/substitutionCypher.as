package net.avdw.cypher
{
	import net.avdw.array.shuffleArray;
	import net.avdw.text.lowerCaseAlphabet;
	
	public function substitutionCypher(text:String):String
	{
		const alphabet:Array = lowerCaseAlphabet();
		const substitution:Array = lowerCaseAlphabet();
		shuffleArray(substitution);
		
		var encodedText:String = "";
		for (var i:int = 0; i < text.length; i++)
			if (alphabet.indexOf(text.charAt(i)) != -1)
				encodedText += substitution[alphabet.indexOf(text.charAt(i))];
			else if (alphabet.indexOf(text.charAt(i).toLowerCase()) != -1)
				encodedText += String(substitution[alphabet.indexOf(text.charAt(i).toLowerCase())]).toUpperCase();
			else
				encodedText +=  text.charAt(i);
			
		return encodedText;
	}
}