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
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * SWF meta data defined for iPad 1 & 2 in landscape mode. 
	 */	
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
	
	/**
	 * This is the main class of the project. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class HungryHero1 extends Sprite
	{
		private var urls:Array = [
			["image","graphics/mySpritesheet.png"],
			["image","graphics/bgLayer1.jpg"],
			["image","graphics/bgWelcome.jpg"],
			["json", "graphics/mySpritesheet.json"],
			
			["image","fonts/bitmap/fontRegular.png"],
			["image","fonts/bitmap/fontScoreLabel.png"],
			["image", "fonts/bitmap/fontScoreValue.png"],
			
			["json","fonts/bitmap/fontRegular.json"],
			["json","fonts/bitmap/fontScoreLabel.json"],
			["json", "fonts/bitmap/fontScoreValue.json"],
			
			["json", "particles/particleCoffee.json"],
			["json", "particles/particleMushroom.json"],
			["image", "particles/texture.png"],
		];
		private var loading:Array;
		public function HungryHero1()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		protected function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			loadNext();
			
		}
		
		private function loadNext():void 
		{
			if (urls.length==0) {
				loadComp();
			}else {
				loading = urls.shift();
				var req:URLRequest= new URLRequest("../../media/"+loading[1])
				if (loading[0]=="image") {
					var imageloader:Loader = new Loader;
					imageloader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageloader_complete);
					imageloader.load(req);
				}else if (loading[0]=="json") {
					var jsonloader:URLLoader = new URLLoader;
					jsonloader.addEventListener(Event.COMPLETE, jsonloader_complete);
					jsonloader.load(req);
				}
			}
		}
		
		private function jsonloader_complete(e:Event):void 
		{
			Assets.assets[loading[1]] = JSON.parse((e.currentTarget as URLLoader).data as String);
			loadNext();
		}
		
		private function imageloader_complete(e:Event):void 
		{
			Assets.assets[loading[1]] = ((e.currentTarget as LoaderInfo).content as Bitmap).bitmapData;
			loadNext();
		}
		
		private function loadComp():void {
			// Initialize Starling object.
			addChild(new Game);
		}
	}
}