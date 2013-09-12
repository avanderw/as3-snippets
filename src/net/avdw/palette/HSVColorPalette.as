package net.avdw.palette 
{
	import net.avdw.color.combineARGB;
	import net.avdw.color.convertHSVtoRGB;
	
	public class HSVColorPalette extends AColorPalette
	{
		public var hueNG:Object;
		public var saturationNG:Object;
		public var valueNG:Object;
		
		public function HSVColorPalette(hueNG:Object, saturationNG:Object, valueNG:Object) 
		{
			this.valueNG = valueNG;
			this.saturationNG = saturationNG;
			this.hueNG = hueNG;
		}
		
		override public function generateColor():uint {
			var color:Object = convertHSVtoRGB(hueNG.nextValue(), saturationNG.nextValue(), valueNG.nextValue());
			return combineARGB(1, color.r, color.g, color.b);
		}
	}

}