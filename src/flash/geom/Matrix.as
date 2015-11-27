package flash.geom
{
   public class Matrix extends Object
   {
       
      public var a:Number;
      
      public var b:Number;
      
      public var c:Number;
      
      public var d:Number;
      
      public var tx:Number;
      
      public var ty:Number;
      
      public function Matrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0)
      {
         super();
         this.a = a;
         this.b = b;
         this.c = c;
         this.d = d;
         this.tx = tx;
         this.ty = ty;
      }
      
      public function clone() : Matrix
      {
         return new Matrix(this.a,this.b,this.c,this.d,this.tx,this.ty);
      }
      
      public function concat(m:Matrix) : void
      {
         var result_a:Number = this.a * m.a;
         var result_b:Number = 0.0;
         var result_c:Number = 0.0;
         var result_d:Number = this.d * m.d;
         var result_tx:Number = this.tx * m.a + m.tx;
         var result_ty:Number = this.ty * m.d + m.ty;
         if(this.b != 0.0 || this.c != 0.0 || m.b != 0.0 || m.c != 0.0)
         {
            result_a = result_a + this.b * m.c;
            result_d = result_d + this.c * m.b;
            result_b = result_b + (this.a * m.b + this.b * m.d);
            result_c = result_c + (this.c * m.a + this.d * m.c);
            result_tx = result_tx + this.ty * m.c;
            result_ty = result_ty + this.tx * m.b;
         }
         this.a = result_a;
         this.b = result_b;
         this.c = result_c;
         this.d = result_d;
         this.tx = result_tx;
         this.ty = result_ty;
      }
      
      public function invert() : void
      {
         var a0:* = NaN;
         var a1:* = NaN;
         var a2:* = NaN;
         var a3:* = NaN;
         var det:* = NaN;
         var result_ty:* = NaN;
         if(this.b == 0.0 && this.c == 0.0)
         {
            this.a = 1 / this.a;
            this.d = 1 / this.d;
            this.b = this.c = 0.0;
            this.tx = -this.a * this.tx;
            this.ty = -this.d * this.ty;
         }
         else
         {
            a0 = this.a;
            a1 = this.b;
            a2 = this.c;
            a3 = this.d;
            det = a0 * a3 - a1 * a2;
            if(det == 0.0)
            {
               this.identity();
               return;
            }
            det = 1 / det;
            this.a = a3 * det;
            this.b = -a1 * det;
            this.c = -a2 * det;
            this.d = a0 * det;
            result_ty = -(this.b * this.tx + this.d * this.ty);
            this.tx = -(this.a * this.tx + this.c * this.ty);
            this.ty = result_ty;
         }
      }
      
      public function identity() : void
      {
         this.a = this.d = 1;
         this.b = this.c = 0.0;
         this.tx = this.ty = 0.0;
      }
      
      public function createBox(scaleX:Number, scaleY:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0) : void
      {
         var u:Number = Math.cos(rotation);
         var v:Number = Math.sin(rotation);
         this.a = u * scaleX;
         this.b = v * scaleY;
         this.c = -v * scaleX;
         this.d = u * scaleY;
         this.tx = tx;
         this.ty = ty;
      }
      
      public function createGradientBox(width:Number, height:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0) : void
      {
         this.createBox(width / 1638.4,height / 1638.4,rotation,tx + width / 2,ty + height / 2);
      }
      
      public function rotate(angle:Number) : void
      {
         var u:Number = Math.cos(angle);
         var v:Number = Math.sin(angle);
         var result_a:Number = u * this.a - v * this.b;
         var result_b:Number = v * this.a + u * this.b;
         var result_c:Number = u * this.c - v * this.d;
         var result_d:Number = v * this.c + u * this.d;
         var result_tx:Number = u * this.tx - v * this.ty;
         var result_ty:Number = v * this.tx + u * this.ty;
         this.a = result_a;
         this.b = result_b;
         this.c = result_c;
         this.d = result_d;
         this.tx = result_tx;
         this.ty = result_ty;
      }
      
      public function translate(dx:Number, dy:Number) : void
      {
         this.tx = this.tx + dx;
         this.ty = this.ty + dy;
      }
      
      public function scale(sx:Number, sy:Number) : void
      {
         this.a = this.a * sx;
         this.b = this.b * sy;
         this.c = this.c * sx;
         this.d = this.d * sy;
         this.tx = this.tx * sx;
         this.ty = this.ty * sy;
      }
      
      public function deltaTransformPoint(point:Point) : Point
      {
         return new Point(this.a * point.x + this.c * point.y,this.d * point.y + this.b * point.x);
      }
      
      public function transformPoint(point:Point) : Point
      {
         return new Point(this.a * point.x + this.c * point.y + this.tx,this.d * point.y + this.b * point.x + this.ty);
      }
      
      public function toString() : String
      {
         return "(a=" + this.a + ", b=" + this.b + ", c=" + this.c + ", d=" + this.d + ", tx=" + this.tx + ", ty=" + this.ty + ")";
      }
      
      [API("674")]
      public function copyFrom(sourceMatrix:Matrix) : void
      {
         this.a = sourceMatrix.a;
         this.b = sourceMatrix.b;
         this.c = sourceMatrix.c;
         this.d = sourceMatrix.d;
         this.tx = sourceMatrix.tx;
         this.ty = sourceMatrix.ty;
      }
      
      [API("674")]
      public function setTo(aa:Number, ba:Number, ca:Number, da:Number, txa:Number, tya:Number) : void
      {
         this.a = aa;
         this.b = ba;
         this.c = ca;
         this.d = da;
         this.tx = txa;
         this.ty = tya;
      }
      
      [API("674")]
      public function copyRowTo(row:uint, vector3D:Vector3D) : void
      {
         switch(row)
         {
            case 0:
               break;
            case 1:
               vector3D.x = this.b;
               vector3D.y = this.d;
               vector3D.z = this.ty;
               break;
            case 2:
            case 3:
               vector3D.x = 0;
               vector3D.y = 0;
               vector3D.z = 1;
               break;
            default:
               vector3D.x = this.a;
               vector3D.y = this.c;
               vector3D.z = this.tx;
         }
      }
      
      [API("674")]
      public function copyColumnTo(column:uint, vector3D:Vector3D) : void
      {
         switch(column)
         {
            case 0:
               break;
            case 1:
               vector3D.x = this.c;
               vector3D.y = this.d;
               vector3D.z = 0;
               break;
            case 2:
            case 3:
               vector3D.x = this.tx;
               vector3D.y = this.ty;
               vector3D.z = 1;
               break;
            default:
               vector3D.x = this.a;
               vector3D.y = this.b;
               vector3D.z = 0;
         }
      }
      
      [API("674")]
      public function copyRowFrom(row:uint, vector3D:Vector3D) : void
      {
         switch(row)
         {
            case 0:
               break;
            case 1:
            case 2:
               this.b = vector3D.x;
               this.d = vector3D.y;
               this.ty = vector3D.z;
               break;
            default:
               this.a = vector3D.x;
               this.c = vector3D.y;
               this.tx = vector3D.z;
         }
      }
      
      [API("674")]
      public function copyColumnFrom(column:uint, vector3D:Vector3D) : void
      {
         switch(column)
         {
            case 0:
               break;
            case 1:
            case 2:
               this.b = vector3D.x;
               this.d = vector3D.y;
               this.ty = vector3D.z;
               break;
            default:
               this.a = vector3D.x;
               this.c = vector3D.y;
               this.tx = vector3D.z;
         }
      }
   }
}
