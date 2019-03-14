package bunnymark{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author Philippe / http://philippe.elsass.me
	 */

	public class Background extends Sprite
	{
		public var cols:int;
		public var rows:int;
		public var texture:BitmapData;
		private var vertices:Vector.<Number>;
		private var indices:Vector.<int>;
		private var uvt:Vector.<Number>;
		private var _width:int;
		private var _height:int;
		private var loader:Loader;

		public function Background() 
		{
			super();
			cols = 1;
			rows = 1;
			texture = new BitmapData(32, 32, true, 0xffff0000);
			texture.perlinNoise(50, 50, 3, 1, true, true);
			loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest("../assets/bunnyMark/grass.png"));
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function loader_complete(e:Event):void 
		{
			texture = (loader.content as Bitmap).bitmapData;
		}

		private function added(e:Event) :void
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			paint();
		}

		private function enterFrame(e:Event) :void
		{
			if (_width == 0 || _height == 0) return;

			var t:Number = getTimer() / 1000.0;
			var sw:Number = _width;
			var sh:Number = _height;
			var kx:Number, ky:Number;
			var ci:int, ri:int;

			for (var j:int = 0; j < rows + 1;j++ )
			{
				ri = j * (cols + 1) * 2;
				for (var i:int = 0; i < cols + 1;i++ )
				{
					ci = ri + i * 2;
					kx = i / cols + Math.cos(t + i) * 0.02;
					ky = j / rows + Math.sin(t + j + i) * 0.02;
					vertices[ci] = sw * kx; 
					vertices[ci + 1] = sh * ky; 
				}
			}
			paint();
		}

		public function setSize(w:int, h:int) :void
		{
			_width = w;
			_height = h;
			build();
			if (parent != null) paint();
		}
		
		private function build():void 
		{
			var sw:Number = _width;
			var sh:Number = _height;
			var uw:Number = sw / texture.width;
			var uh:Number = sh / texture.height;
			var kx:Number, ky:Number;
			var ci:int, ci2:int, ri:int;
			
			vertices = new Vector.<Number>();
			uvt = new Vector.<Number>();
			indices = new Vector.<int>();
			for (var j:int = 0; j < rows + 1;j++ )
			{
				ri = j * (cols + 1) * 2;
				ky = j / rows;
				for (var i:int = 0; i < cols + 1;i++ )
				{
					ci = ri + i * 2;
					kx = i / cols;
					vertices[ci] = sw * kx; 
					vertices[ci + 1] = sh * ky; 
					uvt[ci] = uw * kx; 
					uvt[ci + 1] = uh * ky;
				}
			}
			for (j = 0; j < rows;j++ )
			{
				ri = j * (cols + 1);
				for (i = 0; i < cols;i++ )
				{
					ci = i + ri;
					ci2 = ci + cols + 1;
					indices.push(ci);
					indices.push(ci + 1);
					indices.push(ci2);
					indices.push(ci + 1);
					indices.push(ci2 + 1);
					indices.push(ci2);
				}
			}
		}
		
		private function paint():void 
		{
			graphics.clear();
			graphics.beginBitmapFill(texture);
			graphics.drawTriangles(vertices, indices, uvt);
			//graphics.drawRect(0, 0, stage.stageWidth * 1.2, stage.stageHeight * 1.2); // flat
			graphics.endFill();
		}
		
	}
}