package fairygui
{
	public interface IAnimationGear
	{
		function get playing():Boolean;
		function set playing(value:Boolean):void;
		function get frame():int;
		function set frame(value:int):void;
	}
}