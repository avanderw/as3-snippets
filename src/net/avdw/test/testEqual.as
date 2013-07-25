package net.avdw.test
{
	public function testEqual(... objects):EResult
	{
		if (!objects || objects.length == 0)
			return EResult.FAILED;
		
		var compare:Object = objects[0];
		for (var i:int = 1; i < objects.length; i++)
			if (compare != objects[i])
				return EResult.FAILED;
				
		return EResult.PASSED;
	}
}