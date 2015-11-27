package flash.display 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author lizhi
	 */
	public class DisplayObject extends EventDispatcher
	{
		private static var  ID:int = 0;
		private const id:int = ID++;
		private var _stage:Stage;
		public function DisplayObject() 
		{
			if (id == 0) {
				_stage = new Stage;
				_stage.addChild(this);
			}
		}
	  public function get x() : Number{return 0}
      
     public function set x(param1:Number) : void{}
      
     public function get y() : Number{return 0}
      
     public function set y(param1:Number) : void { }
	
	  public function get stage() : Stage { return _stage; } 
		
	}

}