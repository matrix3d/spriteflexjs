package 
{
	import flash.display.*;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestGradients extends Sprite
	{
		
		private var _shape0:Shape;
		private var _stroke0:Shape;
		
		public function TestGradients()
        {				
			SpriteFlexjs.stageWidth = 550;
			SpriteFlexjs.stageHeight = 400;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.canvas.style.backgroundColor = 'rgba(102,204,255,255)';
			stage.frameRate = 30;
			
						// Green
			_shape0 = new Shape();
			_shape0.graphics.beginGradientFill('radial',[0x00fd02,0xffffff],[1.000000,1.000000],[0,255],new Matrix(0.172592,0.000000,0.000000,0.172592,299.950012,200.000000));
			_shape0.graphics.moveTo(400.0,300.0);
			_shape0.graphics.lineTo(400.0,100.0);
			_shape0.graphics.lineTo(200.0,100.0);
			_shape0.graphics.lineTo(200.0,300.0);
			_shape0.graphics.lineTo(400.0,300.0);
			addChild(_shape0);

			_stroke0 = new Shape();
			_stroke0.graphics.lineStyle(4.0,0xcc9966,1.000000, false, 'normal', 'square', 'miter');
			_stroke0.graphics.moveTo(200.0,100.0);
			_stroke0.graphics.lineTo(400.0,100.0);
			_stroke0.graphics.lineTo(400.0,300.0);
			_stroke0.graphics.lineTo(200.0,300.0);
			_stroke0.graphics.lineTo(200.0,100.0);
			addChild(_stroke0);

        }
		
	}

}