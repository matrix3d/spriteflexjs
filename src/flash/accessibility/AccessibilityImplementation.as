package flash.accessibility
{
	import flash.geom.Rectangle;

	
	public class AccessibilityImplementation extends Object
	{
		
		public var errno:uint;

		public var stub:Boolean;

		
		public function accDoDefaultAction (childID:uint):void
		{
			
		}

		
		public function AccessibilityImplementation()
		{
			
		}

		
		public function accLocation (childID:uint):*
		{
			return null;
		}

		
		public function accSelect (operation:uint, childID:uint):void 
		{
			
		}

		
		public function get_accDefaultAction (childID:uint):String
		{
			return null;
		}

		
		public function get_accFocus ():uint
		{
			return null;
		}

		
		public function get_accName (childID:uint):String
		{
			return null;
		}

		
		public function get_accRole (childID:uint):uint
		{
			return null;
		}

		
		public function get_accSelection ():Array
		{
			return null;
		}

		
		public function get_accState(childID:uint):uint
		{
			return null;
		}

		
		public function get_accValue(childID:uint):String
		{
			return null;
		}

		public function get_selectionActiveIndex():*
		{
			return null;
		}

		public function get_selectionAnchorIndex():*
		{
			return null;
		}

		
		public function getChildIDArray():Array
		{
			return null;
		}

		
		public function isLabeledBy (labelBounds:Rectangle):Boolean
		{
			return false;
		}
	}
}