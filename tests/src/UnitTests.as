package 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class UnitTests
	{
		
		/**
         * FalconJX will inject html into the index.html file.  Surround with
         * "inject_html" tag as follows:
         *
         * <inject_html>
		 *	<link rel="shortcut icon" type="image/png" href="../../js/jasmine/jasmine_favicon.png">
		 *	<link rel="stylesheet" href="../../js/jasmine/jasmine.css">
		 *	<script src="../../js/jasmine/jasmine.js"></script>
		 *	<script src="../../js/jasmine/jasmine-html.js"></script>
		 *	<script src="../../js/jasmine/boot.js"></script>
         * </inject_html>
         */
		public function UnitTests() 
		{
			describe("Shape", function():void {
				
				var shape:Shape;
				
				beforeEach(function():void {
					shape = new Shape();
				});
				
				it("getBounds()", function():void {
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
				
				it("getRect()", function():void {
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