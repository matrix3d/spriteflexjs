package flash.net
{
	/**
	 * The Responder class provides an object that is used 
	 * in <codeph class="+ topic/ph pr-d/codeph ">NetConnection.call()</codeph> to handle return
	 * values from the server related to the success or failure of
	 * specific operations. When working with <codeph class="+ topic/ph pr-d/codeph ">NetConnection.call()</codeph>,
	 * you may encounter a network operation fault specific to the current operation
	 * or a fault related to the current connection status. Operation errors target
	 * the Responder object instead of the NetConnection object for easier error handling.
	 * @langversion	3.0
	 * @playerversion	Flash 9
	 * @playerversion	Lite 4
	 */
	public class Responder extends Object
	{
		/**
		 * Creates a new Responder object. You pass a Responder object to
		 * NetConnection.call() to handle return values
		 * from the server. You may pass null for either or 
		 * both parameters.
		 * @param	result	The function invoked if the call to the server succeeds and returns a result.
		 * @param	status	The function invoked if the server returns an error.
		 * @langversion	3.0
		 * @playerversion	Flash 9
		 * @playerversion	Lite 4
		 */
		public function Responder (result:Function, status:Function = null)
		{
			
		}
	}
}