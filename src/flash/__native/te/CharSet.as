package flash.__native.te 
{
	/**
	 * 想得到实际宽高 就要新建bmd，把虚拟bmd添加到charset
	 * 
如果字符少动态创建没关系，如果字符多，还是不要合并

每次构建buff消耗太大
	 * @author lizhi
	 */
	public class CharSet 
	{
		private var dirty:Boolean = false;//脏了，重新渲染
		private var newChars:Array = [];
		public var image:Object;
		private var ctx:CanvasRenderingContext2D;
		private var gx:int = 0;
		private var gy:int = 0;
		private var chars:Object = {};
		public function CharSet() 
		{
			
		}
		
		public function add(c:Char):void{
			var t:UVTexture=getTexture(c)
			if (t==null){//找不到材质，创建新材质
				t = new UVTexture;
				t.fontSize = c.size;
				t.v = c.v;
				newChars.push(t);
				dirty = true;
				chars[c.v +c.font] = t;
			}
			c.texture = t;
		}
		
		public function getTexture(c:Char):UVTexture{
			var t:UVTexture = chars[c.v +c.font]
			if (t&&t.fontSize>=c.size){
				return t;
			}
			return null;
		}
		
		public function rebuild():void{
			if (dirty){
				if (image == null){
					image = document.createElement("canvas") as HTMLCanvasElement;
					ctx = image.getContext("2d") as CanvasRenderingContext2D;
					image.width = 2048;
					image.height = 2048;
				}
				
				for each(var t:UVTexture in newChars){
					ctx.font = t.fontSize+"px " +"font";
					var measure:TextMetrics = ctx.measureText(t.v);
					//image.width = measure.width;
					//image.height = int(font.substr(0, font.indexOf("px")));
					ctx.textBaseline = "top";
					ctx.fillStyle = "#ffffff"/*fillStyle*/;
					ctx.fillText(t.v, gx, gy);
					t.width = measure.width;
					t.height = t.fontSize;
					t.xadvance = t.width;
					t.u0 = gx;
					t.v0 = gy;
					t.u1 = gx + t.width;
					t.v1 = gy + t.height;
					
					gx += 32;
					if ((gx+32)>2048){
						gx = 0;
						gy += 32;
					}
				}
				
				//宽高改变
				if (false){
					if (image._texture){
						image._texture.dirty = true;
					}
				}
				
				image.dirty = true;
				newChars = [];
				dirty = false;
			}
		}
	}

}