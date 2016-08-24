package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Vector3D;
	import gl3d.core.Material;
	import gl3d.core.Node3D;
	import gl3d.core.View3D;
	import gl3d.meshs.Meshs;
	import flash.events.Event;
	import gl3d.meshs.Teapot;
	/**
	 * ...
	 * @author lizhi
	 */
	public class TestEngine3D extends Sprite
	{
		private var view1:View3D;
		private var n1:Node3D;
		public function TestEngine3D() 
		{
			view1 = new View3D(0);
			view1.stage3dWidth = view1.stage3dHeight = 400;
			addChild(view1);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			n1 = new Node3D;
			n1.drawable = Teapot.teapot()//Meshs.cube(1, 1, 1);
			n1.material = new Material;
			n1.material.lightAble = false;
			view1.scene.addChild(n1);
			view1.camera.perspective.perspectiveFieldOfViewLH(Math.PI / 4, view1.stage3dWidth/ view1.stage3dHeight, .1, 4000);
			view1.camera.z = -10;
			view1.scene.addChild(n1);
		}
		
		private function enterFrame(e:Event):void 
		{
			n1.matrix.appendRotation(1, Vector3D.X_AXIS);
			n1.matrix.appendRotation(2, Vector3D.Y_AXIS);
			n1.updateTransforms();
			view1.render();
		}
		
	}

}