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
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
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
		private var loadingTf:TextField;
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
			loadingTf = new TextField;
			loadingTf.x = 0
			loadingTf.y = 100;
			loadingTf.autoSize = TextFieldAutoSize.LEFT;
			loadingTf.defaultTextFormat = new TextFormat(null, 30);
			loadingTf.textColor = 0xff0000;
			addChild(loadingTf);
			loadNext();
			
			stage.addEventListener(Event.RESIZE, stage_resize);
		}
		
		private function stage_resize(e:Event):void 
		{
			var scale:Number = Math.min(stage.stageWidth/GameConstants.stageWidth,stage.stageHeight/GameConstants.stageHeight);
			if (scale>1) {
				scale = 1;
			}
			scaleX = scaleY = scale;
		}
		
		private function loadNext():void 
		{
			if (urls.length==0) {
				loadComp();
			}else {
				loading = urls.shift();
				var req:URLRequest = new URLRequest("../../assets/media/" + loading[1])
				loadingTf.text="loading "+loading[1]
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
			if (loadingTf.parent) {
				(loadingTf.parent as DisplayObjectContainer).removeChild(loadingTf);
			}
			Sounds.sndBgMain = Assets.getSound("bgGame");//new Sounds.SND_BG_MAIN() as Sound;
			Sounds.sndBgGame = Assets.getSound("bgWelcome");//new Sounds.SND_BG_GAME() as Sound;
			Sounds.sndEat = Assets.getSound("eat");//new Sounds.SND_EAT() as Sound;
			Sounds.sndCoffee = Assets.getSound("coffee");//new Sounds.SND_COFFEE() as Sound;
			Sounds.sndMushroom = Assets.getSound("mushroom");//new Sounds.SND_MUSHROOM() as Sound;
			Sounds.sndHit = Assets.getSound("hit");//new Sounds.SND_HIT() as Sound;
			Sounds.sndHurt = Assets.getSound("hurt");//new Sounds.SND_HURT() as Sound;
			Sounds.sndLose = Assets.getSound("lose");//new Sounds.SND_LOSE() as Sound;
			addChild(new Game);
		}
	}
}