package net.avdw.color
{
	public class GradientEnum
	{
		static public const BG_DARK:GradientEnum = new GradientEnum([0x181818, 0x040404], [1, 1], [0xFF * .25, 0xFF * .75]);
		static public const NAVBAR_GREEN:GradientEnum = new GradientEnum([0x8DDC0C, 0x40B80A], [1, 1], [0xFF * .25, 0xFF * .75]);
		static public const NAVBAR_BLUE:GradientEnum = new GradientEnum([0x3B679E, 0x2B88D9, 0x207CCA, 0x7DB9E8], [1,1,1,1], [0, 0xFF * .5, 0xFF * .51, 0xFF]);
		
		public var ratios:Array;
		public var alphas:Array;
		public var colors:Array;
		
		public function GradientEnum(colors:Array, alphas:Array, ratios:Array)
		{
			this.ratios = ratios;
			this.alphas = alphas;
			this.colors = colors;
		}
	}
}