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

package com.hsharma.hungryHero.screens
{
	import com.hsharma.hungryHero.Assets;
	import com.hsharma.hungryHero.Button;
	import com.hsharma.hungryHero.Fonts;
	import com.hsharma.hungryHero.customObjects.Font;
	import com.hsharma.hungryHero.events.NavigationEvent;
	import com.hsharma.hungryHero.Sounds;
	import com.hsharma.hungryHero.StarlingTextField;
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * This is the welcome or main menu class for the game.
	 *  
	 * @author hsharma
	 * 
	 */
	public class Welcome extends Sprite
	{
		/** Background image. */
		private var bg:Bitmap;
		
		/** Game title. */
		private var title:Shape;
		
		/** Play button. */
		private var playBtn:Button;
		
		/** About button. */
		private var aboutBtn:Button;
		
		/** Hero artwork. */
		private var hero:Shape;

		/** About text field. */
		private var aboutText:StarlingTextField;
		
		/** hsharma.com button. */
		private var hsharmaBtn:Button;
		
		/** Starling Framework button. */
		private var starlingBtn:Button;
		
		/** Back button. */
		private var backBtn:Button;
		
		/** Screen mode - "welcome" or "about". */
		private var screenMode:String;

		/** Current date. */
		private var _currentDate:Date;
		
		/** Font - Regular text. */
		private var fontRegular:Font;
		
		/** Hero art tween object. */
		private var tween_hero:Object;
		
		public function Welcome()
		{
			super();
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawScreen();
		}
		
		/**
		 * Draw all the screen elements. 
		 * 
		 */
		private function drawScreen():void
		{
			// GENERAL ELEMENTS
			
			bg = new Bitmap(com.hsharma.hungryHero.Assets.getTexture("BgWelcome"));
			//Assets.getTexture(bg.graphics,"BgWelcome")
			//bg.blendMode = BlendMode.NONE;
			this.addChild(bg);
			
			title =new Shape//new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture(("welcome_title")));
			title.x = 600;
			title.y = 65;
			Assets.getAtlas().getTexture(title.graphics,"welcome_title")
			this.addChild(title);
			
			// WELCOME ELEMENTS
			
			hero = new Shape;//Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("welcome_hero"));
			Assets.getAtlas().getTexture(hero.graphics,"welcome_hero")
			hero.x = -hero.width;
			hero.y = 130;
			this.addChild(hero);
			
			playBtn = new Button//(com.hsharma.hungryHero.Assets.getAtlas().getTexture("welcome_playButton"));
			Assets.getAtlas().getTexture(playBtn.graphics,"welcome_playButton")
			playBtn.x = 640;
			playBtn.y = 340;
			playBtn.addEventListener(MouseEvent.CLICK, onPlayClick);
			this.addChild(playBtn);
			
			aboutBtn = new Button//(com.hsharma.hungryHero.Assets.getAtlas().getTexture("welcome_aboutButton"));
			Assets.getAtlas().getTexture(aboutBtn.graphics,"welcome_aboutButton")
			aboutBtn.x = 460;
			aboutBtn.y = 460;
			aboutBtn.addEventListener(MouseEvent.CLICK, onAboutClick);
			this.addChild(aboutBtn);
			
			// ABOUT ELEMENTS
			fontRegular = com.hsharma.hungryHero.Fonts.getFont("Regular");
			
			aboutText = new StarlingTextField(480, 600, "", fontRegular.fontName, fontRegular.fontSize, 0xffffff);
			aboutText.text = "Hungry Hero is a free and open source game built on html5 using spriteflexjs.\n\nhttp://www.hungryherogame.com\n\n" +
				" The concept is very simple. The hero is pretty much always hungry and you need to feed him with food." +
				" You score when your Hero eats food.\n\nThere are different obstacles that fly in with a \"Look out!\"" +
				" caution before they appear. Avoid them at all costs. You only have 5 lives. Try to score as much as possible and also" +
				" try to travel the longest distance.";
			aboutText.x = 60;
			aboutText.y = 230;
			//aboutText.hAlign = HAlign.CENTER;
			//aboutText.vAlign = VAlign.TOP;
			aboutText.height = aboutText.textHeight + 30;
			this.addChild(aboutText);
			
			hsharmaBtn = new Button//(com.hsharma.hungryHero.Assets.getAtlas().getTexture("about_hsharmaLogo"));
			Assets.getAtlas().getTexture(hsharmaBtn.graphics,"about_hsharmaLogo")
			hsharmaBtn.x = aboutText.x;
			hsharmaBtn.y = aboutText.y+aboutText.height;//.bounds.bottom;
			hsharmaBtn.addEventListener(MouseEvent.CLICK, onHsharmaBtnClick);
			this.addChild(hsharmaBtn);
			
			starlingBtn = new Button//(com.hsharma.hungryHero.Assets.getAtlas().getTexture("about_starlingLogo"));
			Assets.getAtlas().getTexture(starlingBtn.graphics,"about_starlingLogo")
			starlingBtn.x = aboutText.x + aboutText.width - starlingBtn.width;//= aboutText.bounds.right - starlingBtn.width;
			starlingBtn.y = aboutText.y + aboutText.height;//= aboutText.bounds.bottom;
			starlingBtn.addEventListener(MouseEvent.CLICK, onStarlingBtnClick);
			//this.addChild(starlingBtn);
			
			backBtn = new Button//(com.hsharma.hungryHero.Assets.getAtlas().getTexture("about_backButton"));
			Assets.getAtlas().getTexture(backBtn.graphics,"about_backButton")
			backBtn.x = 660;
			backBtn.y = 350;
			backBtn.addEventListener(MouseEvent.CLICK, onAboutBackClick);
			this.addChild(backBtn);
		}
		
		/**
		 * On back button click from about screen. 
		 * @param event
		 * 
		 */
		private function onAboutBackClick(event:Event):void
		{
			if (!com.hsharma.hungryHero.Sounds.muted) com.hsharma.hungryHero.Sounds.sndCoffee.play();
			
			initialize();
		}
		
		/**
		 * On credits click on hsharma.com image. 
		 * @param event
		 * 
		 */
		private function onHsharmaBtnClick(event:Event):void
		{
			navigateToURL(new URLRequest("http://www.hsharma.com/"), "_blank");
		}
		
		/**
		 * On credits click on Starling Framework image. 
		 * @param event
		 * 
		 */
		private function onStarlingBtnClick(event:Event):void
		{
			navigateToURL(new URLRequest("http://www.gamua.com/starling"), "_blank");
		}
		
		/**
		 * On play button click. 
		 * @param event
		 * 
		 */
		private function onPlayClick(event:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			
			if (!com.hsharma.hungryHero.Sounds.muted) com.hsharma.hungryHero.Sounds.sndCoffee.play();
		}
		
		/**
		 * On about button click. 
		 * @param event
		 * 
		 */
		private function onAboutClick(event:Event):void
		{
			if (!com.hsharma.hungryHero.Sounds.muted) com.hsharma.hungryHero.Sounds.sndMushroom.play();
			showAbout();
		}
		
		/**
		 * Show about screen. 
		 * 
		 */
		public function showAbout():void
		{
			screenMode = "about";
			
			hero.visible = false;
			playBtn.visible = false;
			aboutBtn.visible = false;
			
			aboutText.visible = true;
			hsharmaBtn.visible = true;
			starlingBtn.visible = true;
			backBtn.visible = true;
		}
		
		/**
		 * Initialize welcome screen. 
		 * 
		 */
		public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			
			// If not coming from about, restart playing background music.
			if (screenMode != "about")
			{
				if (!com.hsharma.hungryHero.Sounds.muted) com.hsharma.hungryHero.Sounds.sndBgMain.play(0, 999);
			}
			
			screenMode = "welcome";
			
			hero.visible = true;
			playBtn.visible = true;
			aboutBtn.visible = true;
			
			aboutText.visible = false;
			hsharmaBtn.visible = false;
			starlingBtn.visible = false;
			backBtn.visible = false;
			
			hero.x = -hero.width;
			hero.y = 100;
			
			//tween_hero = new Tween(hero, 4, Transitions.EASE_OUT);
			//tween_hero.animate("x", 80);
			//Starling.juggler.add(tween_hero);
			hero.x = 80;
			
			this.addEventListener(Event.ENTER_FRAME, floatingAnimation);
		}
		
		/**
		 * Animate floating objects. 
		 * @param event
		 * 
		 */
		private function floatingAnimation(event:Event):void
		{
			_currentDate = new Date();
			hero.y = 130 + (Math.cos(_currentDate.getTime() * 0.002)) * 25;
			playBtn.y = 340 + (Math.cos(_currentDate.getTime() * 0.002)) * 10;
			aboutBtn.y = 460 + (Math.cos(_currentDate.getTime() * 0.002)) * 10;
		}
		
		/**
		 * Dispose objects temporarily. 
		 * 
		 */
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, floatingAnimation);
			
			if (screenMode != "about") SoundMixer.stopAll();
		}
	}
}