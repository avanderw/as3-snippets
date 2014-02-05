package net.avdw.object
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public function getClass(obj:Object):Class
	{
		return Class(getDefinitionByName(getQualifiedClassName(obj)));
	}
}