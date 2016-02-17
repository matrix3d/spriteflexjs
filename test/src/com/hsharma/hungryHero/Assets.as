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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * This class holds all embedded textures, fonts and sounds and other embedded files.  
	 * By using static access methods, only one instance of the asset file is instantiated. This 
	 * means that all Image types that use the same bitmap will use the same Texture on the video card.
	 * 
	 * @author hsharma
	 * 
	 */
	public class Assets
	{
		public static var assets:Object = { };
		/**
		 * Texture Atlas 
		 */
		//[Embed(source = "../../../../media/graphics/mySpritesheet.png")]
		//public static var AtlasTextureGame:BitmapData;
		
		//[Embed(source = "../../../../media/graphics/mySpritesheet.json", mimeType = "application/octet-stream")]
		//public static var AtlasXmlGame:Object;
		
		/**
		 * Background Assets 
		 */
		//[Embed(source="../../../../media/graphics/bgLayer1.jpg")]
		//public static var BgLayer1:BitmapData;
		
		//[Embed(source="../../../../media/graphics/bgWelcome.jpg")]
		//public static var BgWelcome:BitmapData;
		
		/**
		 * Texture Cache 
		 */
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:BitmapData = assets["graphics/mySpritesheet.png"];//getTexture("AtlasTextureGame");
				var xml:Object = assets["graphics/mySpritesheet.json"];//AtlasXmlGame;//JSON.parse((new AtlasXmlGame())+"");
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):BitmapData
		{
			if (gameTextures[name] == undefined)
			{
				//var bitmap:Bitmap = new Assets[name]();
				assets["BgLayer1"] = assets["graphics/bgLayer1.jpg"];
				assets["BgWelcome"] = assets["graphics/bgLayer1.jpg"];
				gameTextures[name] = assets[name];//bitmap.bitmapData;//Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		public static function getSound(name:String):Sound {
			return new Sound(new URLRequest("../../assets/media/sounds/"+name+".mp3"));
		}
	}
}
