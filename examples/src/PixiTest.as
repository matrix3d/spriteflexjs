package 
{
	import PIXI.Container;
	import PIXI.Graphics;
	import PIXI.Sprite;
	import PIXI.SystemRenderer;
	import PIXI.Text;
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
		private var tt:TileTestPixi;
		
		/**
		 * <inject_html>
		 * <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pixi.js/4.0.3/pixi.min.js"></script>
		 * </inject_html>
		 */
		public function PixiTest() 
		{
			renderer = new WebGLRenderer(480,640);
			document.body.appendChild(renderer.view);
			
			stage = new Container;
			
			var t:Texture = Texture.fromImage("../assets/wood.jpg");
			
			s = new Sprite(t);
			s.anchor.x = .5;
			s.anchor.y = .5;
			s.position.x = 400;
			s.position.y = 300;
			stage.addChild(s);
			tt = new TileTestPixi;
			stage.addChild(tt);
			
			animate();
			
			var gr:Graphics = new Graphics;
			gr.lineColor = 0xffffffff;
			gr.moveTo(0, 0);
			gr.lineTo(100, 100);
			stage.addChild(gr);
			
			var pt:Text = new Text("fdsfds");
			stage.addChild(pt);
		}
		
		private function animate():void{
			requestAnimationFrame(animate);
			tt.enterFrame();
			s.rotation += .1;
			renderer.render(stage);
		}
	}

}