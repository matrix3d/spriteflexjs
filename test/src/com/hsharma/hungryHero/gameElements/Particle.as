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
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * This class represents the particles that appear around hero for various power-ups.
	 * These particles use the Particle Systems extension for Starling Framework.
	 *  
	 * @author hsharma
	 * 
	 */
	public class Particle extends Sprite
	{
		/** Type of particle. */
		private var _type:int;
		
		/** Speed X of the particle. */
		private var _speedX:Number;
		
		/** Speed Y of the particle. */
		private var _speedY:Number;
		
		/** Spin value of the particle. */
		private var _spin:Number;
		
		/** Texture of the particle. */
		private var particleImage:Shape=new Shape;
		
		public function Particle(_type:int)
		{
			super();
			mouseChildren = mouseEnabled = false;
			this._type = _type;
			
			switch(_type)
			{
				case com.hsharma.hungryHero.GameConstants.PARTICLE_TYPE_1:
					Assets.getAtlas().getTexture(particleImage.graphics, "particleEat");//new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("particleEat"));
					break;
				case com.hsharma.hungryHero.GameConstants.PARTICLE_TYPE_2:
					//particleImage = //new Bitmap(com.hsharma.hungryHero.Assets.getAtlas().getTexture("particleWindForce"));
					Assets.getAtlas().getTexture(particleImage.graphics, "particleWindForce");
					break;
			}
			
			particleImage.x = particleImage.width/2;
			particleImage.y = particleImage.height/2;
			this.addChild(particleImage);
		}

		/**
		 * Speed X of the particle. 
		 * 
		 */
		public function get speedX():Number { return _speedX; }
		public function set speedX(value:Number):void { _speedX = value; }

		/**
		 * Speed Y of the particle. 
		 * 
		 */
		public function get speedY():Number { return _speedY; }
		public function set speedY(value:Number):void { _speedY = value; }

		/**
		 * Spin value of the particle. 
		 * 
		 */
		public function get spin():Number { return _spin; }
		public function set spin(value:Number):void { _spin = value; }
	}
}