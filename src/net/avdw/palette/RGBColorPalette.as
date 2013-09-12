package net.avdw.palette
{
	import net.avdw.color.combineARGB;
	
	public class RGBColorPalette extends AColorPalette
	{
		public var redNG:Object;
		public var greenNG:Object;
		public var blueNG:Object;
		
		public function RGBColorPalette(redNG:Object, greenNG:Object, blueNG:Object)
		{
			this.blueNG = blueNG;
			this.greenNG = greenNG;
			this.redNG = redNG;
		}
		
		override public function generateColor():uint
		{
			return combineARGB(1, redNG.nextValue(), greenNG.nextValue(), blueNG.nextValue());
		}
	}

}