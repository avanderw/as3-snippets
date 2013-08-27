package net.avdw.number
{
	import net.avdw.interp.linear;
	
	/**
	 *
	 * @param	startingNumber
	 * @param	endingNumber
	 * @param	weight how much to interpolate between the startingNumber and endingNumber [0,1]
	 * @param	interpolationFunction
	 * @return
	 */
	public function interpolate(startingNumber:Number, endingNumber:Number, weight:Number, interpolationFunction:Function = null):Number
	{
		if (interpolationFunction == null)
			interpolationFunction = linear;
		
		if (startingNumber < endingNumber)
			return Math.min(endingNumber, startingNumber) + rangeBetween(endingNumber, startingNumber) * interpolationFunction(weight);
		else
			return Math.max(endingNumber, startingNumber) - rangeBetween(endingNumber, startingNumber) * interpolationFunction(weight);
	}
}