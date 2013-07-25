package net.avdw.debug
{
	/**
	 * Returns whether the SWF was compiled in debug mode
	 * 
	 * @return whether the SWF was compiled in debug mode
	 */
	public function isDebugBuild():Boolean
	{
		return new Error().getStackTrace().search(/:[0-9]+]$/m) > -1;
	}
}