package
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestKLine extends Sprite
	{
		private var datas:Array = [];
		private var kline:Sprite = new Sprite;
		private var labelTF:TextField = new TextField;
		private var fontsize:int = 30;
		private var ox:Number = fontsize*3.2;
		private var ox2:Number = ox+100;
		private var oy:Number = 30;
		private var numdot:int = 2;
		private var debugTf:TextField = new TextField;
		private var timer:Timer = new Timer(5000);
		public function TestKLine()
		{
			//addChild(debugTf);
			debugTf.autoSize = "left";
			CONFIG::js_only{
			SpriteFlexjs.autoSize = true;
			}
			var p:Object = stage.loaderInfo.parameters;
			if (p["numdot"]){
				numdot = p["numdot"];
			}
			if (p["textwidth"]){
				ox = p["textwidth"];
				ox2 = ox + 100;
			}
			labelTF.defaultTextFormat=new TextFormat(null,fontsize);
			labelTF.background = true;
			labelTF.backgroundColor = 0xdb5f4a;
			labelTF.textColor = 0xffffff;
			labelTF.autoSize = "left";
			stage.addEventListener(Event.RESIZE, resize);
			var loader:URLLoader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, loader_complete_all);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioError);
			loader.load(new URLRequest(
			//"http://120.26.39.108:9090/getAllMobilePrice.do?pcode=XTAG200G"
			"http://121.43.100.114:9095/pass/marketTimeList?pcode=CU10"
			+"&v="+Math.random()));
			addChild(kline);
			kline.y = oy;
			//update();
			
		}
		
		public function start():void{
			timer.start();
		}
		
		public function stop():void{
			timer.stop();
		}
		
		private function loader_ioError(e:IOErrorEvent):void 
		{
			loader_complete_all(null);
		}
		
		private function timer_timer(e:TimerEvent):void 
		{
			var loader:URLLoader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest(
				//"http://120.26.39.108:9090/getNewMobilePrice.do?pcode=XTAG100G"
				"http://121.43.100.114:9095/pass/newMarketTimeList?pcode=CU10"
				+"&v="+Math.random()));
			//todo del
			//addData(10*Math.random());
			//update();
		}
		private function loader_complete_all(e:Event):void 
		{
			//debugTf.appendText("loadercompall");
			if(e)
			var loader:URLLoader = e.currentTarget as URLLoader;
			if (loader){
				var obj:Object = JSON.parse(loader.data + "");
				for each(var o:Object in obj["content"]){
					var d:Number = o["price"];
					addData(d);
				}
				update();
			}
			timer.addEventListener(TimerEvent.TIMER, timer_timer);
			start();
		}
		private function loader_complete(e:Event):void 
		{
			var loader:URLLoader = e.currentTarget as URLLoader;
			var obj:Object = JSON.parse(loader.data + "");
			var content:Object = obj["content"];
			if (content[0]){
				content = content[0];
			}
			var d:Number = content["price"];
			addData(d);
			update();
		}
		
		private function addData(data:Number):void{
			datas.unshift(data);
			if (datas.length > 120){
				datas.length = 120;
			}
		}
		
		private function resize(e:Event):void 
		{
			update();
		}
		
		private function update():void{
			var min:Number = 100000;
			var max:Number =-100000;
			for each(var d:Number in datas){
				if (d<min){
					min = d;
				}
				if (d > max){
					max = d;
				}
			}
			
			var w:Number = stage.stageWidth;
			var w2:Number = (w - ox2) / 120;
			
			kline.removeChildren();
			kline.graphics.clear();
			kline.graphics.lineStyle(0,0x555555);
			//trace(min, max);
			var s:Number = 0.05;
			while (true){
				var minV:Number = Math.floor(min / s);// * s;
				var maxV:Number = Math.ceil(max / s);// * s;
				var numline:int = maxV - minV;
				if (numline < 4){
					for (; numline < 3;numline++ ){
						if ((numline%2)==0){
							minV -= 1;
						}else{
							maxV += 1;
						}
					}
					
					var h:Number =  int((stage.stageHeight - 2 * oy) / numline);
					/*numdot = 0;
					var n:String = s + "";
					var di:int = n.indexOf(".");
					if (di ==-1){
						numdot = 0;
					}else{
						n=n.substr(di+1)
						numdot = n.length;
					}*/
					for (var i:int = 0; i <= numline; i++ ){
						var y:Number = getY(minV + i, minV, maxV, s, h);
						drawDashLine(kline.graphics, 0, y, w-ox, y,2);
						var tf:TextField = new TextField;
						tf.defaultTextFormat=new TextFormat(null,fontsize);
						tf.autoSize = "left";
						kline.addChild(tf);
						tf.text = ""+((minV + i)*s).toFixed(numdot);
						tf.y = y-tf.height/2;
						tf.x = w - ox;
						//debugTf.appendText("tf,"+y+","+tf.height+"\n")
					}
					break;
				}
				if (s<.1){
					s += .05;
				}else if (s==.1){
					s = .5;
				}else if(s<1){
					s += .5;
				}else if(s==1){
					s = 5;
				}else{
					s += 5;
				}
			}
			kline.graphics.lineStyle(2, 0xdb5f4a);
			for (i = 0; i < datas.length; i++ ){
				d = datas[i];
				y = getY(d/s, minV, maxV, s, h);
				var x:Number = w - i * w2-ox2;
				if(i==0){
					kline.graphics.moveTo(x + ox2-ox, y);
					kline.addChild(labelTF);
					labelTF.text = d.toFixed(numdot) + "";
					labelTF.y = y - labelTF.height / 2;
					labelTF.x = w - ox;
					//debugTf.appendText("ltf,"+labelTF.y+","+tf.height+"\n")
				}
				kline.graphics.lineTo(x, y);
				if (x < 0){
					break;
				}
			}
		}
		
		private function getY(v:Number, min:Number, max:Number,s:Number,h:Number):Number{
			return Math.round((max - v)  * h)+.5;
		}
		
		private function drawDashLine(ctx:Graphics, x1:Number, y1:Number, x2:Number, y2:Number, dashLen:Number=5):void
		{
			var xpos:Number = x2 - x1;//得到横向的高度;
			var ypos:Number = y2 - y1; //得到纵向的高度;
			var numDashes:Number = Math.floor(Math.sqrt(xpos * xpos + ypos * ypos) / dashLen);
			//利用正切获取斜边的长度除以虚线长度，得到要分为多少段;
			for (var i:int = 0; i < numDashes; i++)
			{
				if (i % 2 === 0)
				{
					ctx.moveTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
						//有了横向宽度和多少段，得出每一段是多长，起点 + 每段长度 * i = 要绘制的起点；
				}
				else
				{
					ctx.lineTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
				}
			}
		}
	
	}

}