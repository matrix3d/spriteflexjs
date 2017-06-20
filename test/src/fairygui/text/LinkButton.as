package fairygui.text
{
	import flash.display.Sprite;

	internal class LinkButton extends Sprite
	{
		public var owner:HtmlNode;
		
		public function LinkButton():void {
			buttonMode = true;
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, 10, 10);
			graphics.endFill();
		}
	}
}