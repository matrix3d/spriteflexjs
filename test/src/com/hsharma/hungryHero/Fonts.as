/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package com.hsharma.hungryHero  
{
	import com.hsharma.hungryHero.customObjects.Font;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * This class embeds the bitmap fonts used in the game. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Fonts
	{
		/**
		 *  Regular font used for UI.
		 */		
		//[Embed(source="../../../../media/fonts/bitmap/fontRegular.png")]
		//public static const Font_Regular:Class;
		//
		//[Embed(source="../../../../media/fonts/bitmap/fontRegular.json", mimeType="application/octet-stream")]
		//public static const XML_Regular:Class;
		//
		///**
		 //* Font for score label. 
		 //*/		
		//[Embed(source="../../../../media/fonts/bitmap/fontScoreLabel.png")]
		//public static const Font_ScoreLabel:Class;
		//
		//[Embed(source="../../../../media/fonts/bitmap/fontScoreLabel.json", mimeType="application/octet-stream")]
		//public static const XML_ScoreLabel:Class;
		//
		///**
		 //* Font for score value. 
		 //*/		
		//[Embed(source="../../../../media/fonts/bitmap/fontScoreValue.png")]
		//public static const Font_ScoreValue:Class;
		//
		//[Embed(source="../../../../media/fonts/bitmap/fontScoreValue.json", mimeType="application/octet-stream")]
		//public static const XML_ScoreValue:Class;
		//
		/**
		 * Font objects.
		 */
		//private static var Regular:BitmapFont;
		//private static var ScoreLabel:BitmapFont;
		//private static var ScoreValue:BitmapFont;
		private static var fonts:Object = { };
		
		/**
		 * Returns the BitmapFont (texture + xml) instance's fontName property (there is only oneinstance per app).
		 * @return String 
		 */
		public static function getFont(_fontStyle:String):Font
		{
			if (fonts[_fontStyle] == undefined)
			{
				var texture:BitmapData = Assets.assets["fonts/bitmap/font"+_fontStyle+".png"]//new Fonts["Font_" + _fontStyle]();
				var xml:Object = Assets.assets["fonts/bitmap/font"+_fontStyle+".json"]//JSON.parse((new Fonts["XML_" + _fontStyle]())+"");
				fonts[_fontStyle] = new BitmapFont(texture, xml);
				//StarlingTextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return new Font(fonts[_fontStyle].name, fonts[_fontStyle].size);
		}
	}
}
