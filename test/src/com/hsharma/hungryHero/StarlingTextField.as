package com.hsharma.hungryHero 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author lizhi
	 */
	public class StarlingTextField extends TextField
	{
		
		public function StarlingTextField(width:Number,height:Number,text:String,fontName:String,fontSize:Number,color:int) 
		{
			this.width = width;
			this.height = height;
			wordWrap = true;
			defaultTextFormat = new TextFormat(fontName,fontSize, color);
			this.text = text;
		}
		
	}

}