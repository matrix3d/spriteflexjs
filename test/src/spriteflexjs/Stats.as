package spriteflexjs 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Stats extends Sprite
	{
		public var tf:TextField;
		public var fpsCounter:int = 0;
		public var fps:int = 0;
		public var lastTime:int = -10000;
		public function Stats() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			tf = new TextField();
			tf.mouseEnabled = tf.selectable = false;
			tf.defaultTextFormat = new TextFormat("Courier New",24);
			addChild(tf);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.height = 25;
		}

		private function enterFrame(e:Event):void 
		{
			var time:int = getTimer();
			if (time-1000>lastTime) {
				fps = fpsCounter;
				if (fps > 0) fps--;
				fpsCounter = 0;
				lastTime = time;
			}
			fpsCounter++;
			
			var text:String = "";
			text += "fps : " + fps + " / " ;
			if (stage!=null) {
				text +=  stage.frameRate;
			}
			CONFIG::js_only{
				text += "\ndc  : " + SpriteFlexjs.drawCounter;
				if (SpriteFlexjs.batDrawCounter>0){
					text += "\nbdc : " + SpriteFlexjs.batDrawCounter;
				}
			}
			if(tf.text!=text){
			tf.text = text;
			
			graphics.clear();
			graphics.beginFill(0xffffff, .7);
			graphics.drawRect(0, 0, tf.textWidth, tf.textHeight);
			}
		}
		
	}
}