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

package com.hsharma.hungryHero.gameElements
{
	import com.hsharma.hungryHero.Assets;
	import com.hsharma.hungryHero.GameConstants;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * This class defines each of background layers used in the InGame screen.
	 *  
	 * @author hsharma
	 * 
	 */
	public class BgLayer extends Sprite
	{
		/** Layer identification. */
		private var _layer:int;
		
		/** Primary image. */
		private var image1:DisplayObject;
		
		/** Secondary image. */
		private var image2:DisplayObject;
		
		/** Parallax depth - used to decide speed of the animation. */
		private var _parallaxDepth:Number;
		
		public function BgLayer(_layer:int)
		{
			super();
			this._layer = _layer;
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
			
			if (_layer == 1)
			{
				image1 = new Bitmap(com.hsharma.hungryHero.Assets.getTexture("BgLayer" + _layer));
				//image1.blendMode = BlendMode.NONE;
				image2 = new Bitmap(com.hsharma.hungryHero.Assets.getTexture("BgLayer" + _layer));
				//image2.blendMode = BlendMode.NONE;
			}
			else
			{
				image1 = new Shape;//new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("bgLayer" + _layer));
				image2 = new Shape;//new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("bgLayer" + _layer));
				Assets.getAtlas().getTexture((image1 as Shape).graphics,"bgLayer" + _layer)
				Assets.getAtlas().getTexture((image2 as Shape).graphics,"bgLayer" + _layer)
			}
			
			image1.x = 0;
			image1.y = GameConstants.stageHeight - image1.height;
			
			image2.x = image2.width;
			image2.y = image1.y;
			
			this.addChild(image1);
			this.addChild(image2);
		}

		/**
		 * Parallax depth. 
		 * 
		 */
		public function get parallaxDepth():Number { return _parallaxDepth; }
		public function set parallaxDepth(value:Number):void { _parallaxDepth = value; }
	}
}