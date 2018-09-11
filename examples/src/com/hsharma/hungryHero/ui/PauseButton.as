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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * This class is the pause button for the in-game screen.
	 *  
	 * @author hsharma
	 * 
	 */
	public class PauseButton extends Button
	{
		/** Pause button image. */
		//private var pauseImage:Bitmap;
		
		public function PauseButton()
		{
			//super(new BitmapData(com.hsharma.hungryHero.Assets.getAtlas().getTexture("pauseButton").width, com.hsharma.hungryHero.Assets.getAtlas().getTexture("pauseButton").height, true, 0));
			//super(Assets.getAtlas().bmd, Assets.getAtlas().getTexture(graphics,"pauseButton"));
			//this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Assets.getAtlas().getTexture(graphics, "pauseButton");
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		/*private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Pause Image
			pauseImage = new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("pauseButton"));
			this.addChild(pauseImage);
		}*/
	}
}