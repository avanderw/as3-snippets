package net.avdw.test
{
	public function testSmallerThan(size:Number, ... objects):EResult
	{
		if (!objects || objects.length == 0)
			return EResult.FAILED;
		
		while (objects.length != 0)
			if (objects.splice(0, 1) > size)
				return EResult.FAILED;
		
		return EResult.PASSED;
	}

}

