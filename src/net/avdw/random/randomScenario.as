package net.avdw.random
{
	import net.avdw.array.randomItemFrom;
	import net.avdw.file.loadTextFileLines;
	public function randomScenario():String
	{
		var settings:Array = loadTextFileLines(Resource.Settings);
		var objectives:Array = loadTextFileLines(Resource.Objectives);
		var antagonists:Array = loadTextFileLines(Resource.Antagonists);
		var complications:Array = loadTextFileLines(Resource.Complications);
		
		return [randomItemFrom(settings), randomItemFrom(objectives), randomItemFrom(antagonists), randomItemFrom(complications)].join(" ");
	}
}

class Resource
{
	[Embed(source="../../../../../assets/text/scenario-settings.txt",mimeType="application/octet-stream")]
	static public const Settings:Class;
	[Embed(source="../../../../../assets/text/scenario-objectives.txt",mimeType="application/octet-stream")]
	static public const Objectives:Class;
	[Embed(source="../../../../../assets/text/scenario-antagonists.txt",mimeType="application/octet-stream")]
	static public const Antagonists:Class;
	[Embed(source="../../../../../assets/text/scenario-complications.txt",mimeType="application/octet-stream")]
	static public const Complications:Class;
}