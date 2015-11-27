package flash.geom
{
   [Version("10")]
   public class PerspectiveProjection extends Object
   {
       
      public function PerspectiveProjection()
      {
         super();
         this.ctor();
      }
      
     private function ctor() : void{}
      
     public function get fieldOfView() : Number{return 0}
      
     public function set fieldOfView(param1:Number) : void{}
      
     public function get projectionCenter() : Point{return null}
      
     public function set projectionCenter(param1:Point) : *{return null}
      
     public function get focalLength() : Number{return 0}
      
     public function set focalLength(param1:Number) : void{}
      
     public function toMatrix3D() : Matrix3D{return null}
   }
}
