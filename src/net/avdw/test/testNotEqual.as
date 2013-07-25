package net.avdw.test
{
	public function testNotEqual(... objects):EResult
	{
		if (!objects || objects.length == 0)
			return EResult.FAILED;
		
		while (objects.length != 0)
			if (objects.indexOf(objects.splice(0, 1)[0]) > -1)
				return EResult.FAILED;
		
		return EResult.PASSED;
	}
}