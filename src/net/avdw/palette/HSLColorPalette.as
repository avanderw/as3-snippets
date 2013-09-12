package net.avdw.palette
{
	import net.avdw.color.combineARGB;
	import net.avdw.color.convertHSLtoRGB;
	import net.avdw.number.clamp;
	
	public class HSLColorPalette extends AColorPalette
	{
		public var hueNG:Object;
		public var saturationNG:Object;
		public var luminanceNG:Object;
		
		public function HSLColorPalette(hueNG:Object, saturationNG:Object, luminanceNG:Object)
		{
			this.luminanceNG = luminanceNG;
			this.saturationNG = saturationNG;
			this.hueNG = hueNG;
		}
		
		override public function generateColor():uint
		{
			var color:Object = convertHSLtoRGB(hueNG.nextValue(), clamp(saturationNG.nextValue(), 1), clamp(luminanceNG.nextValue(), 1));
			return combineARGB(1, color.r, color.g, color.b);
		}
	}

}