package  flash.geom{
	import flash.geom.Orientation3D;
	import flash.geom.Vector3D;
	public class Matrix3D {
		public function Matrix3D(v : Vector.<Number> = null) : void { 
			if(v != null && v.length == 16) this.rawData = v;
			else this.rawData = Vector.<Number>([1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0]);
		}
		
		public function get determinant() : Number { return get_determinant(); }
		public function set determinant( __v : Number ) : void { $determinant = __v; }
		protected var $determinant : Number;
		public function get position() : flash.geom.Vector3D { return get_position(); }
		public function set position( __v : flash.geom.Vector3D ) : void { set_position(__v); }
		protected var $position : flash.geom.Vector3D;
		public var rawData : Vector.<Number>;
		public function append(lhs : Matrix3D) : void {
			var m111 : Number = this.rawData[0];
			var m121 : Number = this.rawData[4];
			var m131 : Number = this.rawData[8];
			var m141 : Number = this.rawData[12];
			var m112 : Number = this.rawData[1];
			var m122 : Number = this.rawData[5];
			var m132 : Number = this.rawData[9];
			var m142 : Number = this.rawData[13];
			var m113 : Number = this.rawData[2];
			var m123 : Number = this.rawData[6];
			var m133 : Number = this.rawData[10];
			var m143 : Number = this.rawData[14];
			var m114 : Number = this.rawData[3];
			var m124 : Number = this.rawData[7];
			var m134 : Number = this.rawData[11];
			var m144 : Number = this.rawData[15];
			var m211 : Number = lhs.rawData[0];
			var m221 : Number = lhs.rawData[4];
			var m231 : Number = lhs.rawData[8];
			var m241 : Number = lhs.rawData[12];
			var m212 : Number = lhs.rawData[1];
			var m222 : Number = lhs.rawData[5];
			var m232 : Number = lhs.rawData[9];
			var m242 : Number = lhs.rawData[13];
			var m213 : Number = lhs.rawData[2];
			var m223 : Number = lhs.rawData[6];
			var m233 : Number = lhs.rawData[10];
			var m243 : Number = lhs.rawData[14];
			var m214 : Number = lhs.rawData[3];
			var m224 : Number = lhs.rawData[7];
			var m234 : Number = lhs.rawData[11];
			var m244 : Number = lhs.rawData[15];
			this.rawData[0] = m111 * m211 + m112 * m221 + m113 * m231 + m114 * m241;
			this.rawData[1] = m111 * m212 + m112 * m222 + m113 * m232 + m114 * m242;
			this.rawData[2] = m111 * m213 + m112 * m223 + m113 * m233 + m114 * m243;
			this.rawData[3] = m111 * m214 + m112 * m224 + m113 * m234 + m114 * m244;
			this.rawData[4] = m121 * m211 + m122 * m221 + m123 * m231 + m124 * m241;
			this.rawData[5] = m121 * m212 + m122 * m222 + m123 * m232 + m124 * m242;
			this.rawData[6] = m121 * m213 + m122 * m223 + m123 * m233 + m124 * m243;
			this.rawData[7] = m121 * m214 + m122 * m224 + m123 * m234 + m124 * m244;
			this.rawData[8] = m131 * m211 + m132 * m221 + m133 * m231 + m134 * m241;
			this.rawData[9] = m131 * m212 + m132 * m222 + m133 * m232 + m134 * m242;
			this.rawData[10] = m131 * m213 + m132 * m223 + m133 * m233 + m134 * m243;
			this.rawData[11] = m131 * m214 + m132 * m224 + m133 * m234 + m134 * m244;
			this.rawData[12] = m141 * m211 + m142 * m221 + m143 * m231 + m144 * m241;
			this.rawData[13] = m141 * m212 + m142 * m222 + m143 * m232 + m144 * m242;
			this.rawData[14] = m141 * m213 + m142 * m223 + m143 * m233 + m144 * m243;
			this.rawData[15] = m141 * m214 + m142 * m224 + m143 * m234 + m144 * m244;
		}
		
		public function appendRotation(degrees : Number,axis : flash.geom.Vector3D,pivotPoint : flash.geom.Vector3D = null) : void {
			var m : Matrix3D = Matrix3D.getAxisRotation(axis.x,axis.y,axis.z,degrees);
			if(pivotPoint != null) {
				var p : flash.geom.Vector3D = pivotPoint;
				m.appendTranslation(p.x,p.y,p.z);
			};
			this.append(m);
		}
		
		public function appendScale(xScale : Number,yScale : Number,zScale : Number) : void {
			this.append(new Matrix3D(Vector.<Number>([xScale,0.0,0.0,0.0,0.0,yScale,0.0,0.0,0.0,0.0,zScale,0.0,0.0,0.0,0.0,1.0])));
		}
		
		public function appendTranslation(x : Number,y : Number,z : Number) : void {
			this.rawData[12] += x;
			this.rawData[13] += y;
			this.rawData[14] += z;
		}
		
		public function clone() : Matrix3D {
			return new Matrix3D(this.rawData.concat());
		}
		
		public function copyColumnFrom(column : int,vector3D : flash.geom.Vector3D) : void {
			switch(column) {
			case 0:
			{
				this.rawData[0] = vector3D.x;
				this.rawData[1] = vector3D.y;
				this.rawData[2] = vector3D.z;
				this.rawData[3] = vector3D.w;
			}
			break;
			case 1:
			{
				this.rawData[4] = vector3D.x;
				this.rawData[5] = vector3D.y;
				this.rawData[6] = vector3D.z;
				this.rawData[7] = vector3D.w;
			}
			break;
			case 2:
			{
				this.rawData[8] = vector3D.x;
				this.rawData[9] = vector3D.y;
				this.rawData[10] = vector3D.z;
				this.rawData[11] = vector3D.w;
			}
			break;
			case 3:
			{
				this.rawData[12] = vector3D.x;
				this.rawData[13] = vector3D.y;
				this.rawData[14] = vector3D.z;
				this.rawData[15] = vector3D.w;
			}
			break;
			default:
			throw new Error("Error, Column " + column + " out of bounds [0, ..., 3]");
			break;
			}
		}
		
		public function copyColumnTo(column : int,vector3D : flash.geom.Vector3D) : void {
			switch(column) {
			case 0:
			{
				vector3D.x = this.rawData[0];
				vector3D.y = this.rawData[1];
				vector3D.z = this.rawData[2];
				vector3D.w = this.rawData[3];
			}
			break;
			case 1:
			{
				vector3D.x = this.rawData[4];
				vector3D.y = this.rawData[5];
				vector3D.z = this.rawData[6];
				vector3D.w = this.rawData[7];
			}
			break;
			case 2:
			{
				vector3D.x = this.rawData[8];
				vector3D.y = this.rawData[9];
				vector3D.z = this.rawData[10];
				vector3D.w = this.rawData[11];
			}
			break;
			case 3:
			{
				vector3D.x = this.rawData[12];
				vector3D.y = this.rawData[13];
				vector3D.z = this.rawData[14];
				vector3D.w = this.rawData[15];
			}
			break;
			default:
			throw new Error("Error, Column " + column + " out of bounds [0, ..., 3]");
			break;
			}
		}
		
		public function copyFrom(other : Matrix3D) : void {
			this.rawData = other.rawData.concat();
		}
		
		public function copyRawDataFrom(vector : Vector.<Number>,index : uint = 0,transpose : Boolean = false) : void {
			if(transpose) this.transpose();
			var l : uint = vector.length - index;
			{
				var _g : int = 0;
				while(_g < int(l)) {
					var c : int = _g++;
					this.rawData[c] = vector[c + index];
				}
			};
			if(transpose) this.transpose();
		}
		
		public function copyRawDataTo(vector : Vector.<Number>,index : uint = 0,transpose : Boolean = false) : void {
			if(transpose) this.transpose();
			var l : uint = this.rawData.length;
			{
				var _g : int = 0;
				while(_g < int(l)) {
					var c : int = _g++;
					vector[c + index] = this.rawData[c];
				}
			};
			if(transpose) this.transpose();
		}
		
		public function copyRowFrom(row : uint,vector3D : flash.geom.Vector3D) : void {
			switch(row) {
			case 0:
			{
				this.rawData[0] = vector3D.x;
				this.rawData[4] = vector3D.y;
				this.rawData[8] = vector3D.z;
				this.rawData[12] = vector3D.w;
			}
			break;
			case 1:
			{
				this.rawData[1] = vector3D.x;
				this.rawData[5] = vector3D.y;
				this.rawData[9] = vector3D.z;
				this.rawData[13] = vector3D.w;
			}
			break;
			case 2:
			{
				this.rawData[2] = vector3D.x;
				this.rawData[6] = vector3D.y;
				this.rawData[10] = vector3D.z;
				this.rawData[14] = vector3D.w;
			}
			break;
			case 3:
			{
				this.rawData[3] = vector3D.x;
				this.rawData[7] = vector3D.y;
				this.rawData[11] = vector3D.z;
				this.rawData[15] = vector3D.w;
			}
			break;
			default:
			throw new Error("Error, Row " + ("" + row) + " out of bounds [0, ..., 3]");
			break;
			}
		}
		
		public function copyRowTo(row : int,vector3D : flash.geom.Vector3D) : void {
			switch(row) {
			case 0:
			{
				vector3D.x = this.rawData[0];
				vector3D.y = this.rawData[4];
				vector3D.z = this.rawData[8];
				vector3D.w = this.rawData[12];
			}
			break;
			case 1:
			{
				vector3D.x = this.rawData[1];
				vector3D.y = this.rawData[5];
				vector3D.z = this.rawData[9];
				vector3D.w = this.rawData[13];
			}
			break;
			case 2:
			{
				vector3D.x = this.rawData[2];
				vector3D.y = this.rawData[6];
				vector3D.z = this.rawData[10];
				vector3D.w = this.rawData[14];
			}
			break;
			case 3:
			{
				vector3D.x = this.rawData[3];
				vector3D.y = this.rawData[7];
				vector3D.z = this.rawData[11];
				vector3D.w = this.rawData[15];
			}
			break;
			default:
			throw new Error("Error, Row " + row + " out of bounds [0, ..., 3]");
			break;
			}
		}
		
		public function copyToMatrix3D(other : Matrix3D) : void {
			other.rawData = this.rawData.concat();
		}
		
		public function decompose(orientationStyle : String = null) : Vector.<flash.geom.Vector3D> {
			if(orientationStyle == null) orientationStyle = flash.geom.Orientation3D.EULER_ANGLES;
			var vec : Vector.<flash.geom.Vector3D> = new Vector.<flash.geom.Vector3D>();
			var m : Matrix3D = this.clone();
			var mr : Vector.<Number> = m.rawData.concat();
			var pos : flash.geom.Vector3D = new flash.geom.Vector3D(mr[12],mr[13],mr[14]);
			mr[12] = 0;
			mr[13] = 0;
			mr[14] = 0;
			var scale : flash.geom.Vector3D = new flash.geom.Vector3D();
			scale.x = Math.sqrt(mr[0] * mr[0] + mr[1] * mr[1] + mr[2] * mr[2]);
			scale.y = Math.sqrt(mr[4] * mr[4] + mr[5] * mr[5] + mr[6] * mr[6]);
			scale.z = Math.sqrt(mr[8] * mr[8] + mr[9] * mr[9] + mr[10] * mr[10]);
			if(mr[0] * (mr[5] * mr[10] - mr[6] * mr[9]) - mr[1] * (mr[4] * mr[10] - mr[6] * mr[8]) + mr[2] * (mr[4] * mr[9] - mr[5] * mr[8]) < 0) scale.z = -scale.z;
			mr[0] /= scale.x;
			mr[1] /= scale.x;
			mr[2] /= scale.x;
			mr[4] /= scale.y;
			mr[5] /= scale.y;
			mr[6] /= scale.y;
			mr[8] /= scale.z;
			mr[9] /= scale.z;
			mr[10] /= scale.z;
			var rot : flash.geom.Vector3D = new flash.geom.Vector3D();
			switch(orientationStyle) {
			case flash.geom.Orientation3D.AXIS_ANGLE:
			{
				rot.w = Math.acos((mr[0] + mr[5] + mr[10] - 1) / 2);
				var len : Number = Math.sqrt((mr[6] - mr[9]) * (mr[6] - mr[9]) + (mr[8] - mr[2]) * (mr[8] - mr[2]) + (mr[1] - mr[4]) * (mr[1] - mr[4]));
				if(len != 0) {
					rot.x = (mr[6] - mr[9]) / len;
					rot.y = (mr[8] - mr[2]) / len;
					rot.z = (mr[1] - mr[4]) / len;
				}
				else rot.x = rot.y = rot.z = 0;
			}
			break;
			case flash.geom.Orientation3D.QUATERNION:
			{
				var tr : Number = mr[0] + mr[5] + mr[10];
				if(tr > 0) {
					rot.w = Math.sqrt(1 + tr) / 2;
					rot.x = (mr[6] - mr[9]) / (4 * rot.w);
					rot.y = (mr[8] - mr[2]) / (4 * rot.w);
					rot.z = (mr[1] - mr[4]) / (4 * rot.w);
				}
				else if(mr[0] > mr[5] && mr[0] > mr[10]) {
					rot.x = Math.sqrt(1 + mr[0] - mr[5] - mr[10]) / 2;
					rot.w = (mr[6] - mr[9]) / (4 * rot.x);
					rot.y = (mr[1] + mr[4]) / (4 * rot.x);
					rot.z = (mr[8] + mr[2]) / (4 * rot.x);
				}
				else if(mr[5] > mr[10]) {
					rot.y = Math.sqrt(1 + mr[5] - mr[0] - mr[10]) / 2;
					rot.x = (mr[1] + mr[4]) / (4 * rot.y);
					rot.w = (mr[8] - mr[2]) / (4 * rot.y);
					rot.z = (mr[6] + mr[9]) / (4 * rot.y);
				}
				else {
					rot.z = Math.sqrt(1 + mr[10] - mr[0] - mr[5]) / 2;
					rot.x = (mr[8] + mr[2]) / (4 * rot.z);
					rot.y = (mr[6] + mr[9]) / (4 * rot.z);
					rot.w = (mr[1] - mr[4]) / (4 * rot.z);
				}
			}
			break;
			case flash.geom.Orientation3D.EULER_ANGLES:
			{
				rot.y = Math.asin(-mr[2]);
				if(mr[2] != 1 && mr[2] != -1) {
					rot.x = Math.atan2(mr[6],mr[10]);
					rot.z = Math.atan2(mr[1],mr[0]);
				}
				else {
					rot.z = 0;
					rot.x = Math.atan2(mr[4],mr[5]);
				}
			}
			break;
			};
			vec.push(pos);
			vec.push(rot);
			vec.push(scale);
			return vec;
		}
		
		public function deltaTransformVector(v : flash.geom.Vector3D) : flash.geom.Vector3D {
			var x : Number = v.x;
			var y : Number = v.y;
			var z : Number = v.z;
			return new flash.geom.Vector3D(x * this.rawData[0] + y * this.rawData[4] + z * this.rawData[8] + this.rawData[3],x * this.rawData[1] + y * this.rawData[5] + z * this.rawData[9] + this.rawData[7],x * this.rawData[2] + y * this.rawData[6] + z * this.rawData[10] + this.rawData[11],0);
		}
		
		public function identity() : void {
			this.rawData = Vector.<Number>([1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0]);
		}
		
		public function interpolateTo(toMat : Matrix3D,percent : Number) : void {
			var _g : int = 0;
			while(_g < 16) {
				var i : int = _g++;
				this.rawData[i] = this.rawData[i] + (toMat.rawData[i] - this.rawData[i]) * percent;
			}
		}
		
		public function invert() : Boolean {
			var d : Number = this.get_determinant();
			var invertable : Boolean = Math.abs(d) > 0.00000000001;
			if(invertable) {
				d = 1 / d;
				var m11 : Number = this.rawData[0];
				var m21 : Number = this.rawData[4];
				var m31 : Number = this.rawData[8];
				var m41 : Number = this.rawData[12];
				var m12 : Number = this.rawData[1];
				var m22 : Number = this.rawData[5];
				var m32 : Number = this.rawData[9];
				var m42 : Number = this.rawData[13];
				var m13 : Number = this.rawData[2];
				var m23 : Number = this.rawData[6];
				var m33 : Number = this.rawData[10];
				var m43 : Number = this.rawData[14];
				var m14 : Number = this.rawData[3];
				var m24 : Number = this.rawData[7];
				var m34 : Number = this.rawData[11];
				var m44 : Number = this.rawData[15];
				this.rawData[0] = d * (m22 * (m33 * m44 - m43 * m34) - m32 * (m23 * m44 - m43 * m24) + m42 * (m23 * m34 - m33 * m24));
				this.rawData[1] = -d * (m12 * (m33 * m44 - m43 * m34) - m32 * (m13 * m44 - m43 * m14) + m42 * (m13 * m34 - m33 * m14));
				this.rawData[2] = d * (m12 * (m23 * m44 - m43 * m24) - m22 * (m13 * m44 - m43 * m14) + m42 * (m13 * m24 - m23 * m14));
				this.rawData[3] = -d * (m12 * (m23 * m34 - m33 * m24) - m22 * (m13 * m34 - m33 * m14) + m32 * (m13 * m24 - m23 * m14));
				this.rawData[4] = -d * (m21 * (m33 * m44 - m43 * m34) - m31 * (m23 * m44 - m43 * m24) + m41 * (m23 * m34 - m33 * m24));
				this.rawData[5] = d * (m11 * (m33 * m44 - m43 * m34) - m31 * (m13 * m44 - m43 * m14) + m41 * (m13 * m34 - m33 * m14));
				this.rawData[6] = -d * (m11 * (m23 * m44 - m43 * m24) - m21 * (m13 * m44 - m43 * m14) + m41 * (m13 * m24 - m23 * m14));
				this.rawData[7] = d * (m11 * (m23 * m34 - m33 * m24) - m21 * (m13 * m34 - m33 * m14) + m31 * (m13 * m24 - m23 * m14));
				this.rawData[8] = d * (m21 * (m32 * m44 - m42 * m34) - m31 * (m22 * m44 - m42 * m24) + m41 * (m22 * m34 - m32 * m24));
				this.rawData[9] = -d * (m11 * (m32 * m44 - m42 * m34) - m31 * (m12 * m44 - m42 * m14) + m41 * (m12 * m34 - m32 * m14));
				this.rawData[10] = d * (m11 * (m22 * m44 - m42 * m24) - m21 * (m12 * m44 - m42 * m14) + m41 * (m12 * m24 - m22 * m14));
				this.rawData[11] = -d * (m11 * (m22 * m34 - m32 * m24) - m21 * (m12 * m34 - m32 * m14) + m31 * (m12 * m24 - m22 * m14));
				this.rawData[12] = -d * (m21 * (m32 * m43 - m42 * m33) - m31 * (m22 * m43 - m42 * m23) + m41 * (m22 * m33 - m32 * m23));
				this.rawData[13] = d * (m11 * (m32 * m43 - m42 * m33) - m31 * (m12 * m43 - m42 * m13) + m41 * (m12 * m33 - m32 * m13));
				this.rawData[14] = -d * (m11 * (m22 * m43 - m42 * m23) - m21 * (m12 * m43 - m42 * m13) + m41 * (m12 * m23 - m22 * m13));
				this.rawData[15] = d * (m11 * (m22 * m33 - m32 * m23) - m21 * (m12 * m33 - m32 * m13) + m31 * (m12 * m23 - m22 * m13));
			};
			return invertable;
		}
		
		public function pointAt(pos : flash.geom.Vector3D,at : flash.geom.Vector3D = null,up : flash.geom.Vector3D = null) : void {
			if(at == null) at = new flash.geom.Vector3D(0,0,-1);
			if(up == null) up = new flash.geom.Vector3D(0,-1,0);
			var dir : flash.geom.Vector3D = at.subtract(pos);
			var vup : flash.geom.Vector3D = up.clone();
			var right : flash.geom.Vector3D;
			dir.normalize();
			vup.normalize();
			var dir2 : flash.geom.Vector3D = dir.clone();
			dir2.scaleBy(vup.dotProduct(dir));
			vup = vup.subtract(dir2);
			if(vup.length > 0) vup.normalize();
			else if(dir.x != 0) vup = new flash.geom.Vector3D(-dir.y,dir.x,0);
			else vup = new flash.geom.Vector3D(1,0,0);
			right = vup.crossProduct(dir);
			right.normalize();
			this.rawData[0] = right.x;
			this.rawData[4] = right.y;
			this.rawData[8] = right.z;
			this.rawData[12] = 0.0;
			this.rawData[1] = vup.x;
			this.rawData[5] = vup.y;
			this.rawData[9] = vup.z;
			this.rawData[13] = 0.0;
			this.rawData[2] = dir.x;
			this.rawData[6] = dir.y;
			this.rawData[10] = dir.z;
			this.rawData[14] = 0.0;
			this.rawData[3] = pos.x;
			this.rawData[7] = pos.y;
			this.rawData[11] = pos.z;
			this.rawData[15] = 1.0;
		}
		
		public function prepend(rhs : Matrix3D) : void {
			var m111 : Number = rhs.rawData[0];
			var m121 : Number = rhs.rawData[4];
			var m131 : Number = rhs.rawData[8];
			var m141 : Number = rhs.rawData[12];
			var m112 : Number = rhs.rawData[1];
			var m122 : Number = rhs.rawData[5];
			var m132 : Number = rhs.rawData[9];
			var m142 : Number = rhs.rawData[13];
			var m113 : Number = rhs.rawData[2];
			var m123 : Number = rhs.rawData[6];
			var m133 : Number = rhs.rawData[10];
			var m143 : Number = rhs.rawData[14];
			var m114 : Number = rhs.rawData[3];
			var m124 : Number = rhs.rawData[7];
			var m134 : Number = rhs.rawData[11];
			var m144 : Number = rhs.rawData[15];
			var m211 : Number = this.rawData[0];
			var m221 : Number = this.rawData[4];
			var m231 : Number = this.rawData[8];
			var m241 : Number = this.rawData[12];
			var m212 : Number = this.rawData[1];
			var m222 : Number = this.rawData[5];
			var m232 : Number = this.rawData[9];
			var m242 : Number = this.rawData[13];
			var m213 : Number = this.rawData[2];
			var m223 : Number = this.rawData[6];
			var m233 : Number = this.rawData[10];
			var m243 : Number = this.rawData[14];
			var m214 : Number = this.rawData[3];
			var m224 : Number = this.rawData[7];
			var m234 : Number = this.rawData[11];
			var m244 : Number = this.rawData[15];
			this.rawData[0] = m111 * m211 + m112 * m221 + m113 * m231 + m114 * m241;
			this.rawData[1] = m111 * m212 + m112 * m222 + m113 * m232 + m114 * m242;
			this.rawData[2] = m111 * m213 + m112 * m223 + m113 * m233 + m114 * m243;
			this.rawData[3] = m111 * m214 + m112 * m224 + m113 * m234 + m114 * m244;
			this.rawData[4] = m121 * m211 + m122 * m221 + m123 * m231 + m124 * m241;
			this.rawData[5] = m121 * m212 + m122 * m222 + m123 * m232 + m124 * m242;
			this.rawData[6] = m121 * m213 + m122 * m223 + m123 * m233 + m124 * m243;
			this.rawData[7] = m121 * m214 + m122 * m224 + m123 * m234 + m124 * m244;
			this.rawData[8] = m131 * m211 + m132 * m221 + m133 * m231 + m134 * m241;
			this.rawData[9] = m131 * m212 + m132 * m222 + m133 * m232 + m134 * m242;
			this.rawData[10] = m131 * m213 + m132 * m223 + m133 * m233 + m134 * m243;
			this.rawData[11] = m131 * m214 + m132 * m224 + m133 * m234 + m134 * m244;
			this.rawData[12] = m141 * m211 + m142 * m221 + m143 * m231 + m144 * m241;
			this.rawData[13] = m141 * m212 + m142 * m222 + m143 * m232 + m144 * m242;
			this.rawData[14] = m141 * m213 + m142 * m223 + m143 * m233 + m144 * m243;
			this.rawData[15] = m141 * m214 + m142 * m224 + m143 * m234 + m144 * m244;
		}
		
		public function prependRotation(degrees : Number,axis : flash.geom.Vector3D,pivotPoint : flash.geom.Vector3D = null) : void {
			var m : Matrix3D = Matrix3D.getAxisRotation(axis.x,axis.y,axis.z,degrees);
			if(pivotPoint != null) {
				var p : flash.geom.Vector3D = pivotPoint;
				m.appendTranslation(p.x,p.y,p.z);
			};
			this.prepend(m);
		}
		
		public function prependScale(xScale : Number,yScale : Number,zScale : Number) : void {
			this.prepend(new Matrix3D(Vector.<Number>([xScale,0.0,0.0,0.0,0.0,yScale,0.0,0.0,0.0,0.0,zScale,0.0,0.0,0.0,0.0,1.0])));
		}
		
		public function prependTranslation(x : Number,y : Number,z : Number) : void {
			var m : Matrix3D = new Matrix3D();
			m.set_position(new flash.geom.Vector3D(x,y,z));
			this.prepend(m);
		}
		
		public function recompose(components : Vector.<flash.geom.Vector3D>,orientationStyle : String = null) : Boolean {
			if(components.length < 3 || components[2].x == 0 || components[2].y == 0 || components[2].z == 0) return false;
			if(orientationStyle == null) orientationStyle = flash.geom.Orientation3D.EULER_ANGLES;
			this.identity();
			var scale : Array = [];
			scale[0] = scale[1] = scale[2] = components[2].x;
			scale[4] = scale[5] = scale[6] = components[2].y;
			scale[8] = scale[9] = scale[10] = components[2].z;
			switch(orientationStyle) {
			case flash.geom.Orientation3D.EULER_ANGLES:
			{
				var cx : Number = Math.cos(components[1].x);
				var cy : Number = Math.cos(components[1].y);
				var cz : Number = Math.cos(components[1].z);
				var sx : Number = Math.sin(components[1].x);
				var sy : Number = Math.sin(components[1].y);
				var sz : Number = Math.sin(components[1].z);
				this.rawData[0] = cy * cz * scale[0];
				this.rawData[1] = cy * sz * scale[1];
				this.rawData[2] = -sy * scale[2];
				this.rawData[3] = 0;
				this.rawData[4] = (sx * sy * cz - cx * sz) * scale[4];
				this.rawData[5] = (sx * sy * sz + cx * cz) * scale[5];
				this.rawData[6] = sx * cy * scale[6];
				this.rawData[7] = 0;
				this.rawData[8] = (cx * sy * cz + sx * sz) * scale[8];
				this.rawData[9] = (cx * sy * sz - sx * cz) * scale[9];
				this.rawData[10] = cx * cy * scale[10];
				this.rawData[11] = 0;
				this.rawData[12] = components[0].x;
				this.rawData[13] = components[0].y;
				this.rawData[14] = components[0].z;
				this.rawData[15] = 1;
			}
			break;
			default:
			{
				var x : Number = components[1].x;
				var y : Number = components[1].y;
				var z : Number = components[1].z;
				var w : Number = components[1].w;
				if(orientationStyle==flash.geom.Orientation3D.AXIS_ANGLE) {
					x *= Math.sin(w / 2);
					y *= Math.sin(w / 2);
					z *= Math.sin(w / 2);
					w = Math.cos(w / 2);
				};
				this.rawData[0] = (1 - 2 * y * y - 2 * z * z) * scale[0];
				this.rawData[1] = (2 * x * y + 2 * w * z) * scale[1];
				this.rawData[2] = (2 * x * z - 2 * w * y) * scale[2];
				this.rawData[3] = 0;
				this.rawData[4] = (2 * x * y - 2 * w * z) * scale[4];
				this.rawData[5] = (1 - 2 * x * x - 2 * z * z) * scale[5];
				this.rawData[6] = (2 * y * z + 2 * w * x) * scale[6];
				this.rawData[7] = 0;
				this.rawData[8] = (2 * x * z + 2 * w * y) * scale[8];
				this.rawData[9] = (2 * y * z - 2 * w * x) * scale[9];
				this.rawData[10] = (1 - 2 * x * x - 2 * y * y) * scale[10];
				this.rawData[11] = 0;
				this.rawData[12] = components[0].x;
				this.rawData[13] = components[0].y;
				this.rawData[14] = components[0].z;
				this.rawData[15] = 1;
			}
			break;
			};
			if(components[2].x == 0) this.rawData[0] = 1e-15;
			if(components[2].y == 0) this.rawData[5] = 1e-15;
			if(components[2].z == 0) this.rawData[10] = 1e-15;
			return !(components[2].x == 0 || components[2].y == 0 || components[2].y == 0);
		}
		
		public function transformVector(v : flash.geom.Vector3D) : flash.geom.Vector3D {
			var x : Number = v.x;
			var y : Number = v.y;
			var z : Number = v.z;
			return new flash.geom.Vector3D(x * this.rawData[0] + y * this.rawData[4] + z * this.rawData[8] + this.rawData[12],x * this.rawData[1] + y * this.rawData[5] + z * this.rawData[9] + this.rawData[13],x * this.rawData[2] + y * this.rawData[6] + z * this.rawData[10] + this.rawData[14],x * this.rawData[3] + y * this.rawData[7] + z * this.rawData[11] + this.rawData[15]);
		}
		
		public function transformVectors(vin : Vector.<Number>,vout : Vector.<Number>) : void {
			var i : int = 0;
			while(i + 3 <= vin.length) {
				var x : Number = vin[i];
				var y : Number = vin[i + 1];
				var z : Number = vin[i + 2];
				vout[i] = x * this.rawData[0] + y * this.rawData[4] + z * this.rawData[8] + this.rawData[12];
				vout[i + 1] = x * this.rawData[1] + y * this.rawData[5] + z * this.rawData[9] + this.rawData[13];
				vout[i + 2] = x * this.rawData[2] + y * this.rawData[6] + z * this.rawData[10] + this.rawData[14];
				i += 3;
			}
		}
		
		public function transpose() : void {
			var oRawData : Vector.<Number> = this.rawData.concat();
			this.rawData[1] = oRawData[4];
			this.rawData[2] = oRawData[8];
			this.rawData[3] = oRawData[12];
			this.rawData[4] = oRawData[1];
			this.rawData[6] = oRawData[9];
			this.rawData[7] = oRawData[13];
			this.rawData[8] = oRawData[2];
			this.rawData[9] = oRawData[6];
			this.rawData[11] = oRawData[14];
			this.rawData[12] = oRawData[3];
			this.rawData[13] = oRawData[7];
			this.rawData[14] = oRawData[11];
		}
		
		private function get_determinant() : Number {
			return (this.rawData[0] * this.rawData[5] - this.rawData[4] * this.rawData[1]) * (this.rawData[10] * this.rawData[15] - this.rawData[14] * this.rawData[11]) - (this.rawData[0] * this.rawData[9] - this.rawData[8] * this.rawData[1]) * (this.rawData[6] * this.rawData[15] - this.rawData[14] * this.rawData[7]) + (this.rawData[0] * this.rawData[13] - this.rawData[12] * this.rawData[1]) * (this.rawData[6] * this.rawData[11] - this.rawData[10] * this.rawData[7]) + (this.rawData[4] * this.rawData[9] - this.rawData[8] * this.rawData[5]) * (this.rawData[2] * this.rawData[15] - this.rawData[14] * this.rawData[3]) - (this.rawData[4] * this.rawData[13] - this.rawData[12] * this.rawData[5]) * (this.rawData[2] * this.rawData[11] - this.rawData[10] * this.rawData[3]) + (this.rawData[8] * this.rawData[13] - this.rawData[12] * this.rawData[9]) * (this.rawData[2] * this.rawData[7] - this.rawData[6] * this.rawData[3]);
		}
		
		private function get_position() : flash.geom.Vector3D {
			return new flash.geom.Vector3D(this.rawData[12],this.rawData[13],this.rawData[14]);
		}
		
		private function set_position(val : flash.geom.Vector3D) : flash.geom.Vector3D {
			this.rawData[12] = val.x;
			this.rawData[13] = val.y;
			this.rawData[14] = val.z;
			return val;
		}
		
		static public function interpolate(thisMat : Matrix3D,toMat : Matrix3D,percent : Number) : Matrix3D {
			var m : Matrix3D = new Matrix3D();
			{
				var _g : int = 0;
				while(_g < 16) {
					var i : int = _g++;
					m.rawData[i] = thisMat.rawData[i] + (toMat.rawData[i] - thisMat.rawData[i]) * percent;
				}
			};
			return m;
		}
		
		static protected function getAxisRotation(x : Number,y : Number,z : Number,degrees : Number) : Matrix3D {
			var m : Matrix3D = new Matrix3D();
			var a1 : flash.geom.Vector3D = new flash.geom.Vector3D(x,y,z);
			var rad : Number = -degrees * (Math.PI / 180);
			var c : Number = Math.cos(rad);
			var s : Number = Math.sin(rad);
			var t : Number = 1.0 - c;
			m.rawData[0] = c + a1.x * a1.x * t;
			m.rawData[5] = c + a1.y * a1.y * t;
			m.rawData[10] = c + a1.z * a1.z * t;
			var tmp1 : Number = a1.x * a1.y * t;
			var tmp2 : Number = a1.z * s;
			m.rawData[4] = tmp1 + tmp2;
			m.rawData[1] = tmp1 - tmp2;
			tmp1 = a1.x * a1.z * t;
			tmp2 = a1.y * s;
			m.rawData[8] = tmp1 - tmp2;
			m.rawData[2] = tmp1 + tmp2;
			tmp1 = a1.y * a1.z * t;
			tmp2 = a1.x * s;
			m.rawData[9] = tmp1 + tmp2;
			m.rawData[6] = tmp1 - tmp2;
			return m;
		}
		
	}
}
