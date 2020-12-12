package flash.geom
{
   public class PerspectiveProjection extends Object
   {
	   private var _fieldOfView:Number = 55;
	   private var _projectionCenter:Point = new Point(250, 250);
      public function PerspectiveProjection()
      {
      }
      
     private function ctor() : void{}
      
     public function get fieldOfView() : Number{return _fieldOfView}
      
     public function set fieldOfView(param1:Number) : void{
		 _fieldOfView = param1;
	 }
      
     public function get projectionCenter() : Point{return _projectionCenter}
      
     public function set projectionCenter(param1:Point) : void{
		 _projectionCenter = param1;
	 }
      
     public function get focalLength() : Number{ 
		return 1 / Math.tan(_fieldOfView / 2 * Math.PI / 180) * 250;
	 }
      
     public function set focalLength(param1:Number) : void{
		 _fieldOfView=Math.atan(250 / param1) * 2 * 180 / Math.PI;
	 }
      
     public function toMatrix3D() : Matrix3D{
		 var m:Matrix3D = new Matrix3D();
		 m.rawData=Vector.<Number>([
				focalLength,0,0,0,
			0,focalLength,0,0,
			0,0,1,1,
			0,0,0,0
			]);
			return m;
	 }
   }
}
