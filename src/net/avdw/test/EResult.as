package net.avdw.test
{
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class EResult
	{
		private var title:String;
		public static const PASSED:EResult = new EResult("PASSED");
		public static const FAILED:EResult = new EResult("FAILED");
		
		public function EResult(title:String)
		{
			this.title = title;
		}
		
		public function toString():String
		{
			return title;
		}
	
	}

}