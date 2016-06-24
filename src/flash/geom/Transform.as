package flash.geom
{
	import flash.display.DisplayObject;
	
	public class Transform extends Object
	{
		private var _matrix:Matrix=new Matrix;
		private var _colorTransform:ColorTransform=new ColorTransform;
		private var _concatenatedColorTransform:ColorTransform=new ColorTransform;
		private var colorDirty:Boolean = true;
		private var dirty:Boolean = true;
		private var _concatenatedMatrix:Matrix = new Matrix;
		private var invDirty:Boolean = true;
		private var _invMatrix:Matrix = new Matrix;
		private var displayObject:DisplayObject;
		public function Transform(displayObject:DisplayObject)
		{
			super();
			this.ctor(displayObject);
		}
		
		public function get matrix():Matrix  { 
			return _matrix 
		}
		
		public function set matrix(v:Matrix):void  {
			_matrix = v;
			updateTransforms();
		}
		
		public function get colorTransform():ColorTransform  {
			return _colorTransform;
		}
		
		public function set colorTransform(v:ColorTransform):void  {
			_colorTransform = v;
			updateColorTransforms();
		}
		
		public function get concatenatedMatrix():Matrix  { 
			if (dirty)
			{
				_concatenatedMatrix.copyFrom(matrix);
				if (displayObject.parent)
				{
					_concatenatedMatrix.concat(displayObject.parent.transform.concatenatedMatrix);
				}
				dirty = false;
			}
			return _concatenatedMatrix;
		}
		
		public function get concatenatedColorTransform():ColorTransform  { 
			if (colorDirty)
			{
				_concatenatedColorTransform.alphaOffset = _colorTransform.alphaOffset;
				_concatenatedColorTransform.alphaMultiplier = _colorTransform.alphaMultiplier;
				_concatenatedColorTransform.redOffset = _colorTransform.redOffset;
				_concatenatedColorTransform.redMultiplier = _colorTransform.redMultiplier;
				_concatenatedColorTransform.greenOffset = _colorTransform.greenOffset;
				_concatenatedColorTransform.greenMultiplier = _colorTransform.greenMultiplier;
				_concatenatedColorTransform.blueOffset = _colorTransform.blueOffset;
				_concatenatedColorTransform.blueMultiplier = _colorTransform.blueMultiplier;
				if (displayObject.parent)
				{
					_concatenatedColorTransform.concat(displayObject.parent.transform.concatenatedColorTransform);
				}
				colorDirty = false;
			}
			return _concatenatedColorTransform;
		}
		
		public function get pixelBounds():Rectangle  { return null }
		
		private function ctor(displayObject:DisplayObject):void  {
			this.displayObject = displayObject;
		}
		
		public function get matrix3D():Matrix3D  { return null }
		
		public function set matrix3D(param1:Matrix3D):*  {/**/ }
		
		public function getRelativeMatrix3D(param1:DisplayObject):Matrix3D  { return null }
		
		public function get perspectiveProjection():PerspectiveProjection  { return null }
		
		public function set perspectiveProjection(param1:PerspectiveProjection):void  {/**/ }
		public function get invMatrix():Matrix
		{
			if (invDirty)
			{
				_invMatrix.copyFrom(concatenatedMatrix);
				_invMatrix.invert();
				invDirty = false;
			}
			return _invMatrix;
		}
		
		public function updateTransforms():void
		{
			dirty = true;
			invDirty = true;
		}
		
		public function updateColorTransforms():void
		{
			colorDirty = true;
		}
	}
}
