package net.avdw.number
{
	import net.avdw.interp.linear;
	
	public function sampleBetween(startingNumber:Number, endingNumber:Number, numberOfSamples:Number, interpolationFunction:Function = null):Vector.<Number>
	{
		var sampledNumbers:Vector.<Number> = new Vector.<Number>();
		if (interpolationFunction == null)
			interpolationFunction = linear;
		
		for (var i:int = 0; i < numberOfSamples; i++)
			sampledNumbers.push(interpolate(startingNumber, endingNumber, normalize(i, numberOfSamples - 1), interpolationFunction));
		
		return sampledNumbers;
	}
}