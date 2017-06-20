package fairygui.text {
	import flash.display.DisplayObject;
	
	public interface IRichTextObjectFactory {
		function createObject(src:String, width:int, height:int):DisplayObject;
		function freeObject(obj:DisplayObject):void;
	}
}