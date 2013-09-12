package net.avdw.number
{
	public class ConstantNG
	{
		private var number:Number;
		
		public function ConstantNG(number:Number)
		{
			this.number = number;
		}
		
		public function nextValue():Number
		{
			return number;
		}
	}

}