package fairygui
{
	import flash.utils.ByteArray;

	public interface IUIPackageReader
	{
		function readDescFile(fileName:String):String;
		function readResFile(fileName:String):ByteArray;
	}
}