package fairygui
{
	import flash.display.Stage;
	import flash.geom.Point;
	
	import fairygui.event.DragEvent;
	import fairygui.event.DropEvent;
	
	public class DragDropManager
	{
		private var _agent:GLoader;
		private var _sourceData:Object;
		
		private static var _inst:DragDropManager;
		public static function get inst():DragDropManager
		{
			if(_inst==null)
				_inst = new DragDropManager();
			return _inst;
		}
		
		public function DragDropManager()
		{
			_agent = new GLoader();
			_agent.draggable = true;
			_agent.touchable = false;//important
			_agent.setSize(100,100);
			_agent.setPivot(0.5, 0.5, true);
			_agent.align = AlignType.Center;
			_agent.verticalAlign = VertAlignType.Middle;
			_agent.sortingOrder = int.MAX_VALUE;
			_agent.addEventListener(DragEvent.DRAG_END, __dragEnd);
		}
		
		public function get dragAgent():GObject
		{
			return _agent;
		}
		
		public function get dragging():Boolean
		{
			return _agent.parent!=null;
		}
		
		public function startDrag(source:GObject, icon:String, sourceData:Object, touchPointId:int = -1):void
		{
			if(_agent.parent!=null)
				return;
			
			_sourceData = sourceData;
			_agent.url = icon;
			GRoot.inst.addChild(_agent);
			var pt:Point = GRoot.inst.globalToLocal(source.displayObject.stage.mouseX, source.displayObject.stage.mouseY);
			_agent.setXY(pt.x, pt.y);
			_agent.startDrag(touchPointId);
		}
		
		public function cancel():void
		{
			if(_agent.parent!=null)
			{
				_agent.stopDrag();
				GRoot.inst.removeChild(_agent);
				_sourceData = null;
			}
		}
		
		private function __dragEnd(evt:DragEvent):void
		{
			if(_agent.parent==null) //cancelled
				return;
			
			GRoot.inst.removeChild(_agent);

			var sourceData:Object = _sourceData;
			_sourceData = null;
			
			var obj:GObject = GRoot.inst.getObjectUnderPoint(evt.stageX, evt.stageY);
			while(obj!=null)
			{
				if(obj.hasEventListener(DropEvent.DROP))
				{
					var dropEvt:DropEvent = new DropEvent(DropEvent.DROP, sourceData);
					obj.requestFocus();
					obj.dispatchEvent(dropEvt);
					return;		
				}
				
				obj = obj.parent;
			}
		}
	}
}