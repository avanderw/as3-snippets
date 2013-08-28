package net.avdw.random
{
	import net.avdw.array.randomItemFrom;
	import net.avdw.text.lowerCaseAlphabet;
	
	public function randomLowerCaseLetter():String
	{
		return randomItemFrom(lowerCaseAlphabet());
	}
}