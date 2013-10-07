package net.avdw.sprite
{
	import flash.display.Sprite;
	
	public function createRectangle(width:int, height:int, color:uint = 0x0):Sprite
	{
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginFill(color);
		sprite.graphics.drawRect(0, 0, width, height);
		sprite.graphics.endFill();
		return sprite;
	}
}