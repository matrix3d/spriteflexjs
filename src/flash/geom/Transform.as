package flash.geom
{
   import flash.display.DisplayObject;
   
   public class Transform extends Object
   {
       private var _matrix:Matrix;
      public function Transform(displayObject:DisplayObject)
      {
         super();
         this.ctor(displayObject);
		 _matrix = new Matrix;
      }
      
       public function get matrix() : Matrix{return _matrix}
      
       public function set matrix(param1:Matrix) : void{}
      
       public function get colorTransform() : ColorTransform{return null}
      
       public function set colorTransform(param1:ColorTransform) : void{}
      
       public function get concatenatedMatrix() : Matrix{return null}
      
       public function get concatenatedColorTransform() : ColorTransform{return null}
      
       public function get pixelBounds() : Rectangle{return null}
      
       private function ctor(param1:DisplayObject) : void{}
      
       public function get matrix3D() : Matrix3D{return null}
      
       public function set matrix3D(param1:Matrix3D) : *{}
      
       public function getRelativeMatrix3D(param1:DisplayObject) : Matrix3D{return null}
      
       public function get perspectiveProjection() : PerspectiveProjection{return null}
      
       public function set perspectiveProjection(param1:PerspectiveProjection) : void{}
   }
}
