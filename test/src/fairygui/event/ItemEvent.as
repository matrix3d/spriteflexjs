package fairygui.event
{
	import flash.events.Event;
	
	import fairygui.GObject;
	
	public class ItemEvent extends Event 
	{
		public var itemObject:GObject;
		public var stageX:Number;
		public var stageY:Number;
		public var clickCount:int;
		public var rightButton:Boolean;
		
		public static const CLICK:String = "itemClick";
		
		public function ItemEvent(type:String, itemObject:GObject=null,
								  stageX:Number=0, stageY:Number=0, clickCount:int=1, rightButton:Boolean=false) {
			super(type, false, false);
			this.itemObject = itemObject;
			this.stageX = stageX;
			this.stageY = stageY;
			this.clickCount = clickCount;
			this.rightButton = rightButton;
		}
		
		override public function clone():Event {
			return new ItemEvent(type, itemObject, stageX, stageY, clickCount, rightButton);
		}
	}
	
}