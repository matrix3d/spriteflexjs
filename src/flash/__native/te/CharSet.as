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
		public function CharSet() 
		{
			
		}
		
		public function add(c:Char):void{
			var t:UVTexture=getTexture(c)
			if (t==null){//找不到材质，创建新材质
				t = new UVTexture;
				newChars.push(t);
				dirty = true;
			}
			c.texture = t;
		}
		
		public function getTexture(c:Char):UVTexture{
			return null;
		}
		
		public function rebuild():void{
			if (dirty){
				if (image == null){
					image = document.createElement("canvas") as HTMLCanvasElement;
					ctx = image.getContext("2d") as CanvasRenderingContext2D;
					image.width = 128;
					image.height = 128;
				}
				
				for each(var t:UVTexture in newChars){
					ctx.font = t.fontSize+"px " +"font";
					var measure:TextMetrics = ctx.measureText("fdsafdsafds");
					//image.width = measure.width;
					//image.height = int(font.substr(0, font.indexOf("px")));
					ctx.textBaseline = "top";
					ctx.fillStyle = "#ff0000"/*fillStyle*/;
					ctx.fillText("fdsafdsafds", 0, 0);
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