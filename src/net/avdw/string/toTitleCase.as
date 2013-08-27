package net.avdw.string
{
	public function toTitleCase(str:String):String
	{
		var lstr:String = str.toLowerCase();
		return lstr.replace(/\b([a-z])/g, function($0:*):*
			{
				return $0.toUpperCase();
			});
	}

}