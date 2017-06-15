package flash.display 
{
	public interface IStage 
	{
		function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean = false):void; 
		function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void; 
		//function dispatchEvent(event:Event):Boolean; 
		function hasEventListener(type:String):Boolean; 
		function willTrigger(type:String):Boolean;
		
		function set x(value:Number):void;
		function set y(value:Number):void;
		function set z(value:Number):void;
		
		function get mouseX():Number;
		function get mouseY():Number;
		function get stageWidth():int;
		function get stageHeight():int;
		
		function get ctx():CanvasRenderingContext2D;
	}

}