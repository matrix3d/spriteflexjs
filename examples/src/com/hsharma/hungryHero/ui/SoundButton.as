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

package com.hsharma.hungryHero.ui
{
	import com.hsharma.hungryHero.Assets;
	import com.hsharma.hungryHero.Button;
	import com.hsharma.hungryHero.StarlingMovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * This class is the sound/mute button.
	 *  
	 * @author hsharma
	 * 
	 */
	public class SoundButton extends Button
	{
		/** Animation shown when sound is playing.  */
		private var mcUnmuteState:StarlingMovieClip;
		
		/** Image shown when the sound is muted. */
		private var imageMuteState:Shape;
		
		public function SoundButton()
		{
			//super(new BitmapData(com.hsharma.hungryHero.Assets.getAtlas().getTexture("soundOff").width, com.hsharma.hungryHero.Assets.getAtlas().getTexture("soundOff").height, true, 0));
			
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
			
			setButtonTextures();
			showUnmuteState();
		}
		
		/**
		 * Set textures for button states. 
		 * 
		 */
		private function setButtonTextures():void
		{
			// Normal state - image
			mcUnmuteState = new StarlingMovieClip(com.hsharma.hungryHero.Assets.getAtlas().getTextures("soundOn"), 3);
			this.addChild(mcUnmuteState);
			
			// Selected state - animation
			imageMuteState =new Shape 
			Assets.getAtlas().getTexture(imageMuteState.graphics,"soundOff");
			this.addChild(imageMuteState);
		}
		
		/**
		 * Show Off State - Show the mute symbol (sound is muted). 
		 * 
		 */
		public function showUnmuteState():void
		{
			mcUnmuteState.visible = true;
			imageMuteState.visible = false;
		}
		
		/**
		 * Show On State - Show the unmute animation (sound is playing). 
		 * 
		 */
		public function showMuteState():void
		{
			mcUnmuteState.visible = false;
			imageMuteState.visible = true;
		}
	}
}