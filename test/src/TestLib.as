package 
{
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestLib 
	{
		
		public function TestLib() 
		{
			var obj:HTMLObjectElement = document.createElement("object") as HTMLObjectElement;
			obj.type = "application/x-shockwave-flash";
			obj.data = "WebMain.swf";
			obj.width = "100%";
			obj.height = "100%";
			var parm:HTMLParamElement = document.createElement("param") as HTMLParamElement;
			parm.name = "wmode";
			parm.value = "direct";
			obj.appendChild(parm);
			document.body.appendChild(obj);
		}
		
	}

}