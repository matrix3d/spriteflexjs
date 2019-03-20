package flash.__native.te 
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import org.villekoskela.utils.RectanglePacker;
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
		private var chars:Object = {};
		
		private var tsizew:int = 2048;
		private var tsizeh:int = 2048;
		private var rp:RectanglePacker;
		private var helpRect:Rectangle = new Rectangle;
		public function CharSet() 
		{
			image = document.createElement("canvas") as HTMLCanvasElement;
			ctx = image.getContext("2d") as CanvasRenderingContext2D;
			image.width = tsizew;
			image.height = tsizeh;
			ctx.fillStyle = "rgba(255, 255, 255, 1)"// "#ffffff"/*fillStyle*/;
			ctx.textBaseline = "top";
			
			rp = new RectanglePacker(tsizew, tsizeh,1);
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
			//只保留透明通道，其它通道设置值为255
			if (dirty){
				if (image == null){
				}
				
				var befnum:int = rp.rectangleCount;
				var len:int = newChars.length;
				for (var i:int = 0; i < len;i++ ){
					var t:UVTexture = newChars[i];
					ctx.font = t.fontSize+"px " +"font";
					var measure:TextMetrics = ctx.measureText(t.v);
					t.width = measure.width;
					t.height = t.fontSize;
					t.xadvance = t.width;
					rp.insertRectangle(t.width, t.height, befnum+i);//插入字符
				}
				rp.packRectangles(false);
				for (i = 0; i < len;i++ ){
					t = newChars[i];
					rp.getRectangle(befnum + len-i-1, helpRect);
					ctx.font = t.fontSize+"px " +"font";
					ctx.fillText(t.v, helpRect.x, helpRect.y);
					t.u0 = helpRect.x;
					t.v0 = helpRect.y;
					t.u1 = helpRect.x+helpRect.width;
					t.v1 = helpRect.y + helpRect.height;
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