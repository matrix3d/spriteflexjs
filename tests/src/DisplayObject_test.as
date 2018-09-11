package
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class DisplayObject_test
	{
		/**
         * <inject_html>
		 *	<link rel="shortcut icon" type="image/png" href="../../js/jasmine/jasmine_favicon.png">
		 *	<link rel="stylesheet" href="../../js/jasmine/jasmine.css">
		 *	<script src="../../js/jasmine/jasmine.js"></script>
		 *	<script src="../../js/jasmine/jasmine-html.js"></script>
		 *	<script src="../../js/jasmine/boot.js"></script>
         * </inject_html>
         */
		public function DisplayObject_test() 
		{
			describe("DisplayObject", function():void {
				
				var displayObject:DisplayObject;
				var shape:Shape;
				
				beforeEach(function():void {
					displayObject = new DisplayObject();
					shape = new Shape();
				});
				
				it("stage", function():void {
					displayObject.stage = Stage.instance;
					expect(displayObject.stage).toEqual(Stage.instance);
				});
				
				it("root equals null", function():void {
					expect(displayObject.root).toBeNull();
				});
				
				it("name", function():void {
					displayObject.name = "DisplayObject";
					expect(displayObject.name).toBe("DisplayObject");
				});
				
				it("parent", function():void {
					expect(displayObject.parent).toBeUndefined();
					Stage.instance.addChild(displayObject);
					expect(displayObject.parent).toEqual(Stage.instance);
				});
				
				it("mask", function():void {
					var newMask:DisplayObject = new DisplayObject();
					displayObject.mask = newMask;
					expect(displayObject.mask).toEqual(newMask);
				});
				
				it("getBounds() for empty, fill and stroke", function():void {
					shape.graphics.clear();
					expect(shape.getBounds(shape).toString()).toBe('(x=0, y=0, w=0, h=0)');
					shape.graphics.beginFill(0x000000);
					shape.graphics.drawRect( -200, -200, 400, 400);
					shape.graphics.lineStyle(3);
					expect(shape.getBounds(shape).toString()).toBe('(x=-200, y=-200, w=400, h=400)');
					shape.graphics.clear();
					shape.graphics.beginFill(0x000000);
					shape.graphics.lineStyle(3);
					shape.graphics.drawRect( -200, -200, 400, 400);
					expect(shape.getBounds(shape).toString()).toBe('(x=-201.5, y=-201.5, w=403, h=403)');
				});
				
				it("getRect() for empty, fill and stroke", function():void {
					shape.graphics.clear();
					expect(shape.getRect(shape).toString()).toBe('(x=0, y=0, w=0, h=0)');
					shape.graphics.beginFill(0x000000);
					shape.graphics.drawRect( -200, -200, 400, 400);
					expect(shape.getRect(shape).toString()).toBe('(x=-200, y=-200, w=400, h=400)');
					shape.graphics.clear();
					shape.graphics.beginFill(0x000000);
					shape.graphics.lineStyle(3);
					shape.graphics.drawRect( -200, -200, 400, 400);
					expect(shape.getRect(shape).toString()).toBe('(x=-200, y=-200, w=400, h=400)');
				});
				
			});
		}
		
	}

}