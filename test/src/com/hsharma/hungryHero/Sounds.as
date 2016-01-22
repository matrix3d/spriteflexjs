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
	import flash.media.Sound;
	import flash.net.URLRequest;

	/**
	 * This class holds all the sound embeds and objects that are used in the game. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Sounds
	{
		/**
		 * Embedded sound files. 
		 */		
		/*[Embed(source="../../../../media/sounds/bgGame.mp3")]
		public static const SND_BG_GAME:Class;
		
		[Embed(source="../../../../media/sounds/bgWelcome.mp3")]
		public static const SND_BG_MAIN:Class;
		
		[Embed(source="../../../../media/sounds/eat.mp3")]
		public static const SND_EAT:Class;
		
		[Embed(source="../../../../media/sounds/coffee.mp3")]
		public static const SND_COFFEE:Class;
		
		[Embed(source="../../../../media/sounds/mushroom.mp3")]
		public static const SND_MUSHROOM:Class;
		
		[Embed(source="../../../../media/sounds/hit.mp3")]
		public static const SND_HIT:Class;
		
		[Embed(source="../../../../media/sounds/hurt.mp3")]
		public static const SND_HURT:Class;
		
		[Embed(source="../../../../media/sounds/lose.mp3")]
		public static const SND_LOSE:Class;*/
		
		/**
		 * Initialized Sound objects. 
		 */		
		public static var sndBgMain:Sound //= Assets.getSound("bgGame");//new Sounds.SND_BG_MAIN() as Sound;
		public static var sndBgGame:Sound //= Assets.getSound("bgWelcome");//new Sounds.SND_BG_GAME() as Sound;
		public static var sndEat:Sound //= Assets.getSound("eat");//new Sounds.SND_EAT() as Sound;
		public static var sndCoffee:Sound //= Assets.getSound("coffee");//new Sounds.SND_COFFEE() as Sound;
		public static var sndMushroom:Sound //= Assets.getSound("mushroom");//new Sounds.SND_MUSHROOM() as Sound;
		public static var sndHit:Sound //= Assets.getSound("hit");//new Sounds.SND_HIT() as Sound;
		public static var sndHurt:Sound //= Assets.getSound("hurt");//new Sounds.SND_HURT() as Sound;
		public static var sndLose:Sound //= Assets.getSound("lose");//new Sounds.SND_LOSE() as Sound;
		
		/**
		 * Sound mute status. 
		 */
		public static var muted:Boolean = false;
	}
}