package net.avdw.textfield
{
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Create a <code>TextField</code> instance and return it.
	 */
	public function createTextField(str:String, size:Number = 9, color:uint = 0, x:Number = 0, y:Number = 0, width:Number = 200, height:Number = 20, multiline:Boolean = false, font:String = "Verdana", autoSize:String = TextFieldAutoSize.LEFT, embedFonts:Boolean = false, selectable:Boolean = false, css:StyleSheet = null):TextField
	{
		var tf:TextField = new TextField();
		var fmt:TextFormat = new TextFormat(font, size, color);
		tf.x = x;
		tf.y = y;
		tf.width = width;
		tf.height = height;
		tf.autoSize = autoSize;
		tf.embedFonts = embedFonts;
		tf.selectable = selectable;
		tf.multiline = multiline;
		tf.textColor = color;
		tf.defaultTextFormat = fmt;
		tf.htmlText = str;
		tf.styleSheet = css;
		return tf;
	}
}