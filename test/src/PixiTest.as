package 
{
	import PIXI.Container;
	import PIXI.Sprite;
	import PIXI.SystemRenderer;
	import PIXI.Texture;
	import PIXI.WebGLRenderer;
	import bunnymark.TileTestPixi;
	/**
	 * ...
	 * @author lizhi
	 */
	public class PixiTest 
	{
		private var stage:Container;
		private var renderer:SystemRenderer;
		private var s:Sprite;
		private var tt:TileTestPixi
		public function PixiTest() 
		{
			renderer = new WebGLRenderer(480,640);
			document.body.appendChild(renderer.view);
			
			stage = new Container;
			
			var t:Texture = Texture.fromImage("http://192.168.1.250/flexjs/assets/wood.jpg");
			
			s = new Sprite(t);
			s.anchor.x = .5;
			s.anchor.y = .5;
			s.position.x = 400;
			s.position.y = 300;
			stage.addChild(s);
			tt = new TileTestPixi;
			stage.addChild(tt);
			
			animate();
		}
		
		private function animate():void{
			requestAnimationFrame(animate);
			tt.enterFrame();
			s.rotation += .1;
			renderer.render(stage);
		}
	}

}