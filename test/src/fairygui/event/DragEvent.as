package fairygui.event
{
	import flash.events.Event;
	
	public class DragEvent extends Event 
	{
		public var stageX:Number;
		public var stageY:Number;
		public var touchPointID:int;
		
		public static const DRAG_START:String = "startDrag";
		public static const DRAG_END:String = "endDrag";
		public static const DRAG_MOVING:String = "dragMoving";
		
		public function DragEvent(type:String, stageX:Number=0, stageY:Number=0, touchPointID:int=-1)
		{
			super(type, false, true);

			this.stageX = stageX;
			this.stageY = stageY;
			this.touchPointID = touchPointID;
		}
		
		override public function clone():Event {
			return new DragEvent(type, stageX, stageY, touchPointID);
		}
	}
}