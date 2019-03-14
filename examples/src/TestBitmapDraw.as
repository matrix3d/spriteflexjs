package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import spriteflexjs.Stats;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestBitmapDraw extends Sprite
	{
		private var bmd:BitmapData;
		private var sp:Sprite = new Sprite;
		private var matr:Matrix = new Matrix;
		public function TestBitmapDraw() 
		{
			CONFIG::js_only{
				SpriteFlexjs.wmode = "gpu batch";
			}
			var tf:TextField = new TextField;
			tf.defaultTextFormat = new TextFormat(null, 40);
			bmd = new BitmapData(100, 100);
			bmd.noise(1);
			tf.text = "0";
			draw(tf,bmd);
			tf.text = "1";
			draw(tf, bmd,new Matrix(1,0,0,1,bmd.width/2,0));
			tf.text = "2";
			draw(tf, bmd,new Matrix(1,0,0,1,0,bmd.height/2));
			tf.text = "3";
			draw(tf, bmd,new Matrix(1,0,0,1,bmd.width/2,bmd.height/2));
			
			var bmp:Bitmap = new Bitmap(bmd);
			//addChild(bmp);
			
			bmp.x = 70;
			bmp.y = 70;
			addChild(sp);
			
			addChild(new Stats);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			//matr.translate(.1, .1);
			matr.rotate(.01);
			sp.x = mouseX;
			sp.y = mouseY;
			sp.graphics.clear();
			sp.graphics.beginBitmapFill(bmd,matr);
			sp.graphics.drawRect(0, 0, 1000, 1000);
		}
		
		private function draw(tf:TextField, bmd:BitmapData,matr:Matrix=null):void{
			CONFIG::as_only{
				bmd.draw(tf,matr);
			}
			CONFIG::js_only{
				tf.__draw(bmd.ctx,new Matrix);
			}
		}
	}

}