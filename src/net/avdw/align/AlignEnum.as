package net.avdw.align
{
	public class AlignEnum
	{
		static public const CENTER:AlignEnum = new AlignEnum("CENTER");
		static public const LEFT:AlignEnum = new AlignEnum("LEFT");
		static public const RIGHT:AlignEnum = new AlignEnum("RIGHT");
		
		public var name:String;
		
		public function AlignEnum(name:String)
		{
			this.name = name;
		}
	}
}