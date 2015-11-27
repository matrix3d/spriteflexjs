package flash.geom
{
   public class Point extends Object
   {
       
      public var x:Number;
      
      public var y:Number;
      
      public function Point(x:Number = 0, y:Number = 0)
      {
         super();
         this.x = x;
         this.y = y;
      }
      
      public static function interpolate(pt1:Point, pt2:Point, f:Number) : Point
      {
         return new Point(pt2.x + f * (pt1.x - pt2.x),pt2.y + f * (pt1.y - pt2.y));
      }
      
      public static function distance(pt1:Point, pt2:Point) : Number
      {
         return pt1.subtract(pt2).length;
      }
      
      public static function polar(len:Number, angle:Number) : Point
      {
         return new Point(len * Math.cos(angle),len * Math.sin(angle));
      }
      
      public function get length() : Number
      {
         return Math.sqrt(this.x * this.x + this.y * this.y);
      }
      
      public function clone() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function offset(dx:Number, dy:Number) : void
      {
         this.x = this.x + dx;
         this.y = this.y + dy;
      }
      
      public function equals(toCompare:Point) : Boolean
      {
         return toCompare.x == this.x && toCompare.y == this.y;
      }
      
      public function subtract(v:Point) : Point
      {
         return new Point(this.x - v.x,this.y - v.y);
      }
      
      public function add(v:Point) : Point
      {
         return new Point(this.x + v.x,this.y + v.y);
      }
      
      public function normalize(thickness:Number) : void
      {
         var invD:Number = this.length;
         if(invD > 0)
         {
            invD = thickness / invD;
            this.x = this.x * invD;
            this.y = this.y * invD;
         }
      }
      
      public function toString() : String
      {
         return "(x=" + this.x + ", y=" + this.y + ")";
      }
      
      [API("674")]
      public function copyFrom(sourcePoint:Point) : void
      {
         this.x = sourcePoint.x;
         this.y = sourcePoint.y;
      }
      
      [API("674")]
      public function setTo(xa:Number, ya:Number) : void
      {
         this.x = xa;
         this.y = ya;
      }
   }
}
