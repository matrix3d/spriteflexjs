/**
 * Copyright lizhi ( http://wonderfl.net/user/lizhi )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/l5NI
 */

package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Utils3D;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author sliz http://game-develop.net/blog/
	 */
	public class TestTree3D extends Sprite
	{
		private var nodes:Vector.<Node>=new Vector.<Node>();
		private var cm:Matrix3D = new Matrix3D();
		private var cvm:Matrix3D = new Matrix3D();
		private var m:Matrix3D = new Matrix3D();
		private var vm:Matrix3D = new Matrix3D();
		private var p:PerspectiveProjection = new PerspectiveProjection();
		private var pm:Matrix3D = p.toMatrix3D();
		private var view:Shape = new Shape();
		
		private var tasks:Array = [];
		public function TestTree3D() 
		{
			addChild(view);
			view.x = 228;
			view.y = 228;
			cm.appendTranslation(0, 0, -500);
			tasks.push(new Node());
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function reset(e:Event):void 
		{
			nodes = new Vector.<Node>();
			tasks = new Array();
			tasks.push(new Node());
		}
		
		private function update(e:Event):void 
		{
			m.identity();
			m.appendTranslation(0, 150, 0);
			m.appendRotation(-view.mouseY/3, Vector3D.X_AXIS);
			m.appendRotation(view.mouseX/3, Vector3D.Y_AXIS);
			render();
			var c:int = 5;
			for (var i:int = tasks.length - 1; i >= 0;i-- ) {
				if (c--<0) {
					return;
				}
				var node:Node = tasks[i];
				tasks.splice(i, 1);
				create(node);
			}
		}

		private function render():void {
			cvm.rawData = cm.rawData.slice();
			cvm.invert();
			vm.rawData = m.rawData.slice();
			vm.append(cvm);
			view.graphics.clear();
			for each(var node:Node in nodes) {
				var v3d:Vector3D = vm.transformVector(node.v3d);
				node.v2d = Utils3D.projectVector(pm, v3d);
				
				var aa:Vector3D = pm.transformVector(v3d);
				trace(1);
			}
			for each(node in nodes) {
				if (node.parent) {
					view.graphics.lineStyle(node.strong / 5*node.v2d.z, 0);
					view.graphics.moveTo(node.parent.v2d.x, node.parent.v2d.y);
					view.graphics.lineTo(node.v2d.x, node.v2d.y);
				}
			}
		}
		public function create(node:Node):void {
			if (node.parent) {
				node.m = new Matrix3D();
				node.strong = node.parent.strong * 0.7;
				node.m.appendTranslation(0, -node.strong*3, 0);
				node.m.appendRotation(55 * Math.random(), Vector3D.Z_AXIS);
				node.m.appendRotation(360 * Math.random(), Vector3D.Y_AXIS);
				node.wm = new Matrix3D();
				node.wm.rawData = node.m.rawData.slice();
				node.wm.append(node.parent.wm);
			}else {
				node.m = new Matrix3D();
				node.wm = node.m;
				node.strong = 60;
			}
			node.v3d = new Vector3D();
			node.v3d = node.wm.transformVector(node.v3d);
			nodes.push(node);
			if (node.strong > 7) {
				var num:int = node.strong / 7;
				while(num-->0){
					var cnode:Node = new Node();
					cnode.parent = node;
					tasks.push(cnode);
				}
			}
		}
	}

}
import flash.geom.Matrix3D;
import flash.geom.Vector3D;
class Node {
	public var wm:Matrix3D;
	public var m:Matrix3D;
	public var v3d:Vector3D;
	public var v2d:Vector3D;
	public var strong:Number;
	public var color:uint;
	public var parent:Node;
	public var childs:Array=[];
}