package flash.display 
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Vector3D;
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
	
	  public function get stage() : Stage { return _stage; } 
	  
	    public function get root() : DisplayObject{return null}
      
       public function get name() : String { return null; }
      
       public function set name(param1:String) : void{}
      
       public function get parent() : DisplayObject/*DisplayObjectContainer*/{return null}
      
       public function get mask() : DisplayObject{return null}
      
       public function set mask(param1:DisplayObject) : void{}
      
       public function get visible() : Boolean{return true}
      
       public function set visible(param1:Boolean) : void{}
      
	   public function get x() : Number{return 0}
      
      public function set x(param1:Number) : void{}
      
      public function get y() : Number{return 0}
      
      public function set y(param1:Number) : void { }
	 
       public function get z() : Number{return 0}
      
       public function set z(param1:Number) : void{}
      
       public function get scaleX() : Number{return 1}
      
       public function set scaleX(param1:Number) : void{}
      
       public function get scaleY() : Number{return 1}
      
       public function set scaleY(param1:Number) : void{}
      
       public function get scaleZ() : Number{return 1}
      
       public function set scaleZ(param1:Number) : void{}
      
       public function get mouseX() : Number{return 0}
      
       public function get mouseY() : Number{return 0}
      
       public function get rotation() : Number{return 0}
      
       public function set rotation(param1:Number) : void{}
      
       public function get rotationX() : Number{return 0}
      
       public function set rotationX(param1:Number) : void{}
      
       public function get rotationY() : Number{return 0}
      
       public function set rotationY(param1:Number) : void{}
      
       public function get rotationZ() : Number{return 0}
      
       public function set rotationZ(param1:Number) : void{}
      
       public function get alpha() : Number{return 0}
      
       public function set alpha(param1:Number) : void{}
      
       public function get width() : Number{return 0}
      
       public function set width(param1:Number) : void{}
      
       public function get height() : Number{return 0}
      
       public function set height(param1:Number) : void{}
      
       public function get cacheAsBitmap() : Boolean{return false}
      
       public function set cacheAsBitmap(param1:Boolean) : void{}
      
       public function get opaqueBackground() : Object{return null}
      
       public function set opaqueBackground(param1:Object) : void{}
      
       public function get scrollRect() : Rectangle{return null}
      
       public function set scrollRect(param1:Rectangle) : void{}
      
       public function get filters() : Array{return null}
      
       public function set filters(param1:Array) : void{}
      
       public function get blendMode() : String{return null}
      
       public function set blendMode(param1:String) : void{}
      
       public function get transform() : Transform{return null}
      
       public function set transform(param1:Transform) : void{}
      
       public function get scale9Grid() : Rectangle{return null}
      
       public function set scale9Grid(param1:Rectangle) : void{}
      
       public function globalToLocal(param1:Point) : Point{return null}
      
       public function localToGlobal(param1:Point) : Point{return null}
      
       public function getBounds(param1:DisplayObject) : Rectangle{return null}
      
       public function getRect(param1:DisplayObject) : Rectangle{return null}
      
       //public function get loaderInfo() : LoaderInfo{return null}
      
      public function hitTestObject(obj:DisplayObject) : Boolean
      {
         return this._hitTest(false,0,0,false,obj);
      }
      
      public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false) : Boolean
      {
         return this._hitTest(true,x,y,shapeFlag,null);
      }
      
       private function _hitTest(param1:Boolean, param2:Number, param3:Number, param4:Boolean, param5:DisplayObject) : Boolean{return false}
      
      // public function get accessibilityProperties() : AccessibilityProperties;
      
     //  public function set accessibilityProperties(param1:AccessibilityProperties) : void;
      
       public function globalToLocal3D(param1:Point) : Vector3D{return null}
      
       public function local3DToGlobal(param1:Vector3D) : Point{return null}
      
       //public function set blendShader(param1:Shader) : void;
      
       public function get metaData() : Object{return null}
      
       public function set metaData(param1:Object) : void{}
	}

}