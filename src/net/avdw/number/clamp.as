package net.avdw.number
{
	
	public function clamp(value:Number, maxValue:Number, minValue:Number = NaN):Number
	{
		if (isNaN(minValue))
			minValue = 0;
		
		return Math.min(maxValue, Math.max(minValue, value));
	}
}