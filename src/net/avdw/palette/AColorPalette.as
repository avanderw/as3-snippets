package net.avdw.palette
{
	
	public class AColorPalette
	{
		
		public function generateColor():uint
		{
			throw new Error("this method must be overridden");
		}
		
		public function generatePalette(paletteSize:uint):Vector.<uint>
		{
			var palette:Vector.<uint> = new Vector.<uint>();
			for (var i:int = 0; i < paletteSize; i++)
			{
				palette.push(generateColor());
			}
			return palette;
		}
	
	}

}