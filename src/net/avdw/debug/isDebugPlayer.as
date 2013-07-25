package net.avdw.debug
{
	import flash.system.Capabilities;
	
	/**
	 * Determines whether the SWF player is a debug player
	 * 
	 * @return whether the SWF player is a debug player
	 */
	public function isDebugPlayer():Boolean
	{
		return Capabilities.isDebugger;
	}
}