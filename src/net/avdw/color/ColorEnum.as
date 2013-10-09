package net.avdw.color 
{
	public class ColorEnum 
	{
		public var value:uint;
		
		static public const WHITE:ColorEnum = new ColorEnum(0xFFFFFF);
		
		public function ColorEnum(value:uint)
		{
			this.value = value;
		}
	}
}