package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.display.GradientType;
	/**
	 * ...
	 * @author Kenny Lerma
	 */
	public class TestComplexDrawing extends Sprite
	{
		
		public function TestComplexDrawing() 
		{
			SpriteFlexjs.autoSize = true;
			
			var airplane:Sprite = new Sprite();
			airplane.x = 511.70;
			airplane.y = 50.10;
			addChild(airplane);
			
			
			var shape_4:Shape = new Shape();
			shape_4.graphics.lineStyle(1, 0x424242, .2);
			shape_4.graphics.moveTo( -39.8, 11.3);
			shape_4.graphics.lineTo( -39.8, 16.8);
			shape_4.graphics.lineTo( -28.8, 13.6);
			shape_4.graphics.lineTo( -28.8, 8.3);
			shape_4.graphics.moveTo( -101.3, 28.5);
			shape_4.graphics.lineTo( -39.8, 11.3);
			shape_4.graphics.moveTo(50.1, -14);
			shape_4.graphics.lineTo(32.8, -9.1);
			shape_4.graphics.lineTo(32.8, 0.5);
			shape_4.graphics.lineTo(50.1, -4.2);
			shape_4.graphics.lineTo(50.1, -14);
			shape_4.graphics.lineTo(101.3, -28.5);
			shape_4.graphics.lineTo(101.3, 9);
			shape_4.graphics.lineTo(101.3, 28.5);
			shape_4.graphics.moveTo(101.3, 9);
			shape_4.graphics.lineTo(25, 28.5);
			shape_4.graphics.moveTo( -28.8, 8.3);
			shape_4.graphics.lineTo(32.8, -9.1);
			shape_4.transform.matrix.tx = -135.3;
			shape_4.transform.matrix.ty = 688.8;
			airplane.addChild(shape_4);
			
			//this.shape_4.graphics.beginStroke("rgba(66,66,66,0.2)").setStrokeStyle(1,1,1).moveTo(-39.8,11.3).lineTo(-39.8,16.8).lineTo(-28.8,13.6).lineTo(-28.8,8.3).closePath().moveTo(-101.3,28.5).lineTo(-39.8,11.3).moveTo(50.1,-14).lineTo(32.8,-9.1).lineTo(32.8,0.5).lineTo(50.1,-4.2).lineTo(50.1,-14).lineTo(101.3,-28.5).lineTo(101.3,9).lineTo(101.3,28.5).moveTo(101.3,9).lineTo(25,28.5).moveTo(-28.8,8.3).lineTo(32.8,-9.1);
			//this.shape_4.setTransform(-135.3,688.8);

			var shape_5:Shape = new Shape();
			shape_5.graphics.lineStyle(3, 0x999999, 1);
			shape_5.graphics.moveTo( -22.7, -27.7);
			shape_5.graphics.lineTo( -22.7, 11.2);
			shape_5.graphics.curveTo( -22.7, 26.2, -7.7, 26.2);
			shape_5.graphics.lineTo(24.2, 26.2);
			shape_5.transform.matrix.tx = 81.5;
			shape_5.transform.matrix.ty = -22;
			airplane.addChild(shape_5);
			
			//beginStroke("#999999").setStrokeStyle(3,0,1).moveTo(-22.7,-27.7).lineTo(-22.7,11.2).curveTo(-22.7,26.2,-7.7,26.2).lineTo(24.2,26.2);
			//shape_5.setTransform(81.5, -22);
			
			
			var shape_6:Shape = new Shape();
			shape_6.graphics.lineStyle(.1, 0xBBBBBB, 1);
			shape_6.graphics.moveTo(125, 0);
			shape_6.graphics.lineTo(230.5, 0);
			shape_6.graphics.moveTo( -125.2, 0);
			shape_6.graphics.lineTo( -230.5, 0);
			shape_6.transform.matrix.tx = -0.4;
			shape_6.transform.matrix.ty = 167.4;
			airplane.addChild(shape_6);
			
			//shape_6.graphics.beginStroke("#BBBBBB").setStrokeStyle(0.1,1,1).moveTo(125,0).lineTo(230.5,0).moveTo(-125.2,0).lineTo(-230.5,0);
			//shape_6.setTransform(-0.4,167.4);

			var shape_7:Shape = new Shape();
			shape_7.graphics.lineStyle(1, 0x000000, .10);
			shape_7.graphics.moveTo(77.1, 129.3);
			shape_7.graphics.lineTo(91.3, -105.1);
			shape_7.graphics.curveTo(92, -114.1, 100.9, -114.1);
			shape_7.graphics.lineTo(104.1, -114.1);
			shape_7.graphics.moveTo(235.3, 52.1);
			shape_7.graphics.lineTo(122.6, 52.1);
			shape_7.graphics.moveTo( -74.1, 129.6);
			shape_7.graphics.lineTo( -88.4, -105.2);
			shape_7.graphics.curveTo( -89, -114.2, -97.9, -114.2);
			shape_7.graphics.lineTo( -101.1, -114.2);
			shape_7.graphics.moveTo( -232.8, 52.1);
			shape_7.graphics.lineTo( -120.1, 52.1);
			shape_7.graphics.moveTo( -235.3, -129.6);
			shape_7.graphics.lineTo( -117.4, -129.6);
			shape_7.transform.matrix.tx = -1.8;
			shape_7.transform.matrix.ty = 318.7;
			airplane.addChild(shape_7);
			//this.shape_7.graphics.beginStroke("rgba(0,0,0,0.102)").setStrokeStyle(1,1,1).moveTo(77.1,129.3).lineTo(91.3,-105.1).curveTo(92,-114.1,100.9,-114.1).lineTo(104.1,-114.1).moveTo(235.3,52.1).lineTo(122.6,52.1).moveTo(-74.1,129.6).lineTo(-88.4,-105.2).curveTo(-89,-114.2,-97.9,-114.2).lineTo(-101.1,-114.2).moveTo(-232.8,52.1).lineTo(-120.1,52.1).moveTo(-235.3,-129.6).lineTo(-117.4,-129.6);
			//this.shape_7.setTransform(-1.8,318.7);

			var shape_8:Shape = new Shape();
			shape_8.graphics.lineStyle(.1, 0x000000, .10);
			shape_8.graphics.moveTo(236.2, -264.1);
			shape_8.graphics.lineTo(118.3, -264.1);
			shape_8.graphics.moveTo(342.9, 264.1);
			shape_8.graphics.lineTo(342.9, 254.8);
			shape_8.graphics.moveTo( -342.9, 254.9);
			shape_8.graphics.lineTo( -342.9, 264.1);
			shape_8.transform.matrix.tx = 0;
			shape_8.transform.matrix.ty = 453.2;
			airplane.addChild(shape_8);
			
			//this.shape_8.graphics.beginStroke("rgba(0,0,0,0.102)").setStrokeStyle(0.1,1,1).moveTo(236.2,-264.1).lineTo(118.3,-264.1).moveTo(342.9,264.1).lineTo(342.9,254.8).moveTo(-342.9,254.9).lineTo(-342.9,264.1);
			//this.shape_8.setTransform(0,453.2);

			var shape_9:Shape = new Shape();
			shape_9.graphics.lineStyle(1, 0x000000, .2);
			shape_9.graphics.moveTo(450.1, -255.6);
			shape_9.graphics.lineTo(450.1, -310.6);
			shape_9.graphics.lineTo(303.1, -319.3);
			shape_9.graphics.lineTo(177, -326.8);
			shape_9.graphics.lineTo(177, -269.4);
			shape_9.graphics.lineTo(178.1, -269.3);
			shape_9.graphics.lineTo(303.1, -262.9);
			shape_9.graphics.moveTo(512, -306.9);
			shape_9.graphics.lineTo(450.1, -310.6);
			shape_9.graphics.moveTo(512, -252.3);
			shape_9.graphics.lineTo(450.1, -255.6);
			shape_9.graphics.moveTo(303.1, -319.3);
			shape_9.graphics.lineTo(303.1, -262.9);
			shape_9.graphics.moveTo(178.1, -269.3);
			shape_9.graphics.lineTo(119.1, -272.3);
			shape_9.graphics.lineTo(119.1, -224);
			shape_9.graphics.moveTo(102, 289.2);
			shape_9.graphics.lineTo(102, 298.8);
			shape_9.graphics.lineTo(84.7, 294);
			shape_9.graphics.lineTo(84.7, 284.3);
			shape_9.graphics.lineTo(102, 289.2);
			shape_9.graphics.lineTo(163.7, 306.5);
			shape_9.graphics.moveTo(33.5, 326.9);
			shape_9.graphics.lineTo(33.5, 307.4);
			shape_9.graphics.lineTo(109.8, 326.9);
			shape_9.graphics.moveTo(33.5, 307.4);
			shape_9.graphics.lineTo(33.5, 269.9);
			shape_9.graphics.lineTo(84.7, 284.3);
			shape_9.graphics.moveTo(174.6, 309.5);
			shape_9.graphics.lineTo(174.6, 315);
			shape_9.graphics.lineTo(163.7, 311.9);
			shape_9.graphics.lineTo(163.7, 306.5);
			shape_9.graphics.lineTo(174.6, 309.5);
			shape_9.graphics.lineTo(236.7, 326.9);
			shape_9.graphics.moveTo( -179.7, -268.9);
			shape_9.graphics.lineTo( -120.8, -271.9);
			shape_9.graphics.lineTo( -120.8, -224);
			shape_9.graphics.moveTo( -304.8, -319);
			shape_9.graphics.lineTo( -178.7, -326.5);
			shape_9.graphics.lineTo( -178.7, -269.1);
			shape_9.graphics.lineTo( -179.7, -268.9);
			shape_9.graphics.moveTo( -304.8, -262.6);
			shape_9.graphics.lineTo( -179.7, -268.9);
			shape_9.graphics.moveTo( -304.8, -262.6);
			shape_9.graphics.lineTo( -304.8, -319);
			shape_9.graphics.moveTo( -451.8, -310.3);
			shape_9.graphics.lineTo( -451.8, -255.3);
			shape_9.graphics.lineTo( -304.8, -262.6);
			shape_9.graphics.moveTo( -512, -306.8);
			shape_9.graphics.lineTo( -451.8, -310.3);
			shape_9.graphics.lineTo( -304.8, -319);
			shape_9.graphics.moveTo( -512, -252.1);
			shape_9.graphics.lineTo( -451.8, -255.3);
			shape_9.transform.matrix.tx = 0.5;
			shape_9.transform.matrix.ty = 390.4;
			airplane.addChild(shape_9);
			
			//this.shape_9.graphics.beginStroke("rgba(0,0,0,0.2)").setStrokeStyle(1,1,1).moveTo(450.1,-255.6).lineTo(450.1,-310.6).lineTo(303.1,-319.3).lineTo(177,-326.8).lineTo(177,-269.4).lineTo(178.1,-269.3).lineTo(303.1,-262.9).closePath().moveTo(512,-306.9).lineTo(450.1,-310.6).moveTo(512,-252.3).lineTo(450.1,-255.6).moveTo(303.1,-319.3).lineTo(303.1,-262.9).moveTo(178.1,-269.3).lineTo(119.1,-272.3).lineTo(119.1,-224).moveTo(102,289.2).lineTo(102,298.8).lineTo(84.7,294).lineTo(84.7,284.3).lineTo(102,289.2).lineTo(163.7,306.5).moveTo(33.5,326.9).lineTo(33.5,307.4).lineTo(109.8,326.9).moveTo(33.5,307.4).lineTo(33.5,269.9).lineTo(84.7,284.3).moveTo(174.6,309.5).lineTo(174.6,315).lineTo(163.7,311.9).lineTo(163.7,306.5).lineTo(174.6,309.5).lineTo(236.7,326.9).moveTo(-179.7,-268.9).lineTo(-120.8,-271.9).lineTo(-120.8,-224).moveTo(-304.8,-319).lineTo(-178.7,-326.5).lineTo(-178.7,-269.1).lineTo(-179.7,-268.9).moveTo(-304.8,-262.6).lineTo(-179.7,-268.9).moveTo(-304.8,-262.6).lineTo(-304.8,-319).moveTo(-451.8,-310.3).lineTo(-451.8,-255.3).lineTo(-304.8,-262.6).moveTo(-512,-306.8).lineTo(-451.8,-310.3).lineTo(-304.8,-319).moveTo(-512,-252.1).lineTo(-451.8,-255.3);
			//this.shape_9.setTransform(0.5,390.4);

			// TODO circle and in wrong place?
			var shape_10:Shape = new Shape();
			shape_10.graphics.lineStyle(1, 0x000000);
			//shape_10.graphics.beginFill(0x000000);
			shape_10.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xCCCCCC, 0x666666], [1,1,1], [0, 54, 255], new Matrix(0, -2.2, -2.1, 11.8, -2.2, -2.1));
			shape_10.graphics.moveTo( -6.2, 6);
			shape_10.graphics.curveTo( -7.7, 4.5, -8.3, 2.4);
			shape_10.graphics.curveTo( -8.5, 1.3, -8.5, -0);
			shape_10.graphics.curveTo( -8.5, -1, -8.3, -2);
			shape_10.graphics.curveTo( -7.9, -4.3, -6.2, -6.1);
			shape_10.graphics.curveTo( -3.6, -8.6, 0, -8.6);
			shape_10.graphics.curveTo(3.6, -8.6, 6, -6.1);
			shape_10.graphics.curveTo(7.4, -4.7, 8.1, -3.1);
			shape_10.graphics.curveTo(8.4, -2.2, 8.6, -1.4);
			shape_10.graphics.lineTo(8.6, -0);
			shape_10.graphics.lineTo(8.6, 1.1);
			shape_10.graphics.curveTo(8.4, 2.3, 7.9, 3.4);
			shape_10.graphics.curveTo(7.3, 4.8, 6, 6);
			shape_10.graphics.curveTo(3.6, 8.6, 0, 8.5);
			shape_10.graphics.curveTo( -3.6, 8.6, -6.2, 6);
			shape_10.graphics.endFill();
			shape_10.transform.matrix.tx = 0.2;
			shape_10.transform.matrix.ty = 620.2;
			airplane.addChild(shape_10);
			
			
			//this.shape_10.graphics.beginRadialGradientFill(["#FFFFFF","#CCCCCC","#666666"],[0,0.212,1],-2.2,-2.1,0,-2.2,-2.1,11.8).beginStroke().moveTo(-6.2,6).curveTo(-7.7,4.5,-8.3,2.4).curveTo(-8.5,1.3,-8.5,-0).curveTo(-8.5,-1,-8.3,-2).curveTo(-7.9,-4.3,-6.2,-6.1).curveTo(-3.6,-8.6,0,-8.6).curveTo(3.6,-8.6,6,-6.1).curveTo(7.4,-4.7,8.1,-3.1).curveTo(8.4,-2.2,8.6,-1.4).lineTo(8.6,-0).lineTo(8.6,1.1).curveTo(8.4,2.3,7.9,3.4).curveTo(7.3,4.8,6,6).curveTo(3.6,8.6,0,8.5).curveTo(-3.6,8.6,-6.2,6).closePath();
			//this.shape_10.setTransform(0.2,620.2);

			var shape_11:Shape = new Shape();
			//shape_11.graphics.beginFill(0x000000);
			shape_11.graphics.beginGradientFill(GradientType.LINEAR, [0xCCCCCC, 0xFFFFFF, 0xCCCCCC], [1, 1, 1], [0, 126, 255], new Matrix(18.6, 54.5, -18.6, 54.5));
			shape_11.graphics.moveTo(7.9, 131.8);
			shape_11.graphics.curveTo(8.4, 113.5, 8.6, 98.3);
			shape_11.graphics.lineTo(8.6, 97.6);
			shape_11.graphics.lineTo(8.7, 79.3);
			shape_11.graphics.lineTo(8.7, 79);
			shape_11.graphics.lineTo(8.7, 73.4);
			shape_11.graphics.lineTo(8.7, 72.4);
			shape_11.graphics.lineTo(8.7, 71);
			shape_11.graphics.lineTo(8.4, 62.3);
			shape_11.graphics.lineTo(8.4, 61.8);
			shape_11.graphics.lineTo(8.1, 56.2);
			shape_11.graphics.lineTo(7.8, 50.6);
			shape_11.graphics.curveTo(6.8, 38.9, 5.1, 32.5);
			shape_11.graphics.curveTo(3.9, 27.8, 2.3, 25.9);
			shape_11.graphics.curveTo(1.7, 25, 0.9, 24.7);
			shape_11.graphics.curveTo(0.5, 24.4, 0, 24.4);
			shape_11.graphics.curveTo( -3, 24.7, -5, 32.3);
			shape_11.graphics.curveTo( -6.5, 38.3, -7.5, 48.8);
			shape_11.graphics.curveTo( -7.6, 49.7, -7.7, 50.8);
			shape_11.graphics.curveTo( -8.1, 56.8, -8.3, 64.4);
			shape_11.graphics.curveTo( -8.6, 71.6, -8.6, 80.2);
			shape_11.graphics.lineTo( -8.6, 84.8);
			shape_11.graphics.curveTo( -8.7, 87.1, -8.6, 89.5);
			shape_11.graphics.lineTo( -8.6, 97.1);
			shape_11.graphics.lineTo( -8.6, 97.9);
			shape_11.graphics.lineTo( -8.6, 98.2);
			shape_11.graphics.curveTo( -8.4, 113.5, -7.8, 131.8);
			shape_11.graphics.lineTo( -12.4, 131.8);
			shape_11.graphics.lineTo( -17.3, -11.1);
			shape_11.graphics.lineTo( -17.6, -20.3);
			shape_11.graphics.curveTo( -23.2, -133.7, 0, -131.7);
			shape_11.graphics.curveTo(23.2, -133.7, 17.5, -20.3);
			shape_11.graphics.lineTo(17.3, -11.1);
			shape_11.graphics.lineTo(12.8, 131.8);
			shape_11.transform.matrix.tx = 0;
			shape_11.transform.matrix.ty = 547.8;
			airplane.addChild(shape_11);
			
			//this.shape_11.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#CCCCCC"],[0,0.494,1],-18.6,54.5,18.6,54.5).beginStroke().moveTo(7.9,131.8).curveTo(8.4,113.5,8.6,98.3).lineTo(8.6,97.6).lineTo(8.7,79.3).lineTo(8.7,79).lineTo(8.7,73.4).lineTo(8.7,72.4).lineTo(8.7,71).lineTo(8.4,62.3).lineTo(8.4,61.8).lineTo(8.1,56.2).lineTo(7.8,50.6).curveTo(6.8,38.9,5.1,32.5).curveTo(3.9,27.8,2.3,25.9).curveTo(1.7,25,0.9,24.7).curveTo(0.5,24.4,0,24.4).curveTo(-3,24.7,-5,32.3).curveTo(-6.5,38.3,-7.5,48.8).curveTo(-7.6,49.7,-7.7,50.8).curveTo(-8.1,56.8,-8.3,64.4).curveTo(-8.6,71.6,-8.6,80.2).lineTo(-8.6,84.8).curveTo(-8.7,87.1,-8.6,89.5).lineTo(-8.6,97.1).lineTo(-8.6,97.9).lineTo(-8.6,98.2).curveTo(-8.4,113.5,-7.8,131.8).lineTo(-12.4,131.8).lineTo(-17.3,-11.1).lineTo(-17.6,-20.3).curveTo(-23.2,-133.7,0,-131.7).curveTo(23.2,-133.7,17.5,-20.3).lineTo(17.3,-11.1).lineTo(12.8,131.8).closePath();
			//this.shape_11.setTransform(0,547.8);

			var shape_12:Shape = new Shape();
			//shape_12.graphics.beginFill(0x000000);
			shape_12.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0x999999], [1, 1], [146, 255], new Matrix(0, 0, 18.5, 8.8, 0, 18.5));
			shape_12.graphics.moveTo( -6.5, 72.5);
			shape_12.graphics.curveTo( -6.9, 63.7, -7.2, 54);
			shape_12.graphics.lineTo( -7.8, 36.2);
			shape_12.graphics.lineTo( -7.8, 36);
			shape_12.graphics.lineTo( -7.8, 34.8);
			shape_12.graphics.curveTo( -8.4, 16.5, -8.6, 1.3);
			shape_12.graphics.lineTo( -8.6, 0.9);
			shape_12.graphics.lineTo( -8.6, 0.2);
			shape_12.graphics.lineTo( -8.6, -7.5);
			shape_12.graphics.curveTo( -8.7, -9.9, -8.6, -12.1);
			shape_12.graphics.lineTo( -8.6, -16.7);
			shape_12.graphics.curveTo( -8.6, -25.3, -8.4, -32.5);
			shape_12.graphics.curveTo( -8.1, -40.1, -7.7, -46.2);
			shape_12.graphics.curveTo( -7.7, -47.2, -7.5, -48.1);
			shape_12.graphics.curveTo( -6.5, -58.6, -5, -64.6);
			shape_12.graphics.curveTo( -3, -72.2, -0, -72.5);
			shape_12.graphics.curveTo(0.4, -72.5, 0.9, -72.2);
			shape_12.graphics.curveTo(1.6, -71.9, 2.2, -71.1);
			shape_12.graphics.curveTo(3.9, -69.1, 5.1, -64.4);
			shape_12.graphics.curveTo(6.7, -58, 7.8, -46.3);
			shape_12.graphics.lineTo(8.1, -40.8);
			shape_12.graphics.lineTo(8.3, -35.1);
			shape_12.graphics.lineTo(8.4, -34.6);
			shape_12.graphics.lineTo(8.7, -25.9);
			shape_12.graphics.curveTo(8.5, -26.8, 8.2, -27.6);
			shape_12.graphics.curveTo(7.5, -29.3, 6.1, -30.7);
			shape_12.graphics.curveTo(3.7, -33.1, 0.1, -33.1);
			shape_12.graphics.curveTo( -3.5, -33.1, -6, -30.7);
			shape_12.graphics.curveTo( -7.7, -28.9, -8.2, -26.5);
			shape_12.graphics.curveTo( -8.4, -25.6, -8.4, -24.6);
			shape_12.graphics.curveTo( -8.4, -23.3, -8.1, -22.1);
			shape_12.graphics.curveTo( -7.6, -20.1, -6, -18.5);
			shape_12.graphics.curveTo( -3.5, -16, 0.1, -16);
			shape_12.graphics.curveTo(3.7, -16, 6.1, -18.5);
			shape_12.graphics.curveTo(7.4, -19.7, 8, -21.1);
			shape_12.graphics.curveTo(8.5, -22.3, 8.7, -23.5);
			shape_12.graphics.lineTo(8.7, -18);
			shape_12.graphics.lineTo(8.7, -17.6);
			shape_12.graphics.lineTo(8.5, 0.6);
			shape_12.graphics.lineTo(8.5, 1.4);
			shape_12.graphics.curveTo(8.4, 16.6, 7.9, 34.8);
			shape_12.graphics.lineTo(7.8, 36);
			shape_12.graphics.lineTo(7.8, 36.2);
			shape_12.graphics.lineTo(7.5, 45.8);
			shape_12.graphics.lineTo(7.3, 51.7);
			shape_12.graphics.curveTo(7.2, 52.4, 7.2, 53.3);
			shape_12.graphics.lineTo(6.6, 72.5);
			shape_12.transform.matrix.tx = 0;
			shape_12.transform.matrix.ty = 644.8;
			airplane.addChild(shape_12);
			
			//this.shape_12.graphics.beginRadialGradientFill(["#FFFFFF","#999999"],[0.573,1],0,18.5,0,0,18.5,8.8).beginStroke().moveTo(-6.5,72.5).curveTo(-6.9,63.7,-7.2,54).lineTo(-7.8,36.2).lineTo(-7.8,36).lineTo(-7.8,34.8).curveTo(-8.4,16.5,-8.6,1.3).lineTo(-8.6,0.9).lineTo(-8.6,0.2).lineTo(-8.6,-7.5).curveTo(-8.7,-9.9,-8.6,-12.1).lineTo(-8.6,-16.7).curveTo(-8.6,-25.3,-8.4,-32.5).curveTo(-8.1,-40.1,-7.7,-46.2).curveTo(-7.7,-47.2,-7.5,-48.1).curveTo(-6.5,-58.6,-5,-64.6).curveTo(-3,-72.2,-0,-72.5).curveTo(0.4,-72.5,0.9,-72.2).curveTo(1.6,-71.9,2.2,-71.1).curveTo(3.9,-69.1,5.1,-64.4).curveTo(6.7,-58,7.8,-46.3).lineTo(8.1,-40.8).lineTo(8.3,-35.1).lineTo(8.4,-34.6).lineTo(8.7,-25.9).curveTo(8.5,-26.8,8.2,-27.6).curveTo(7.5,-29.3,6.1,-30.7).curveTo(3.7,-33.1,0.1,-33.1).curveTo(-3.5,-33.1,-6,-30.7).curveTo(-7.7,-28.9,-8.2,-26.5).curveTo(-8.4,-25.6,-8.4,-24.6).curveTo(-8.4,-23.3,-8.1,-22.1).curveTo(-7.6,-20.1,-6,-18.5).curveTo(-3.5,-16,0.1,-16).curveTo(3.7,-16,6.1,-18.5).curveTo(7.4,-19.7,8,-21.1).curveTo(8.5,-22.3,8.7,-23.5).lineTo(8.7,-18).lineTo(8.7,-17.6).lineTo(8.5,0.6).lineTo(8.5,1.4).curveTo(8.4,16.6,7.9,34.8).lineTo(7.8,36).lineTo(7.8,36.2).lineTo(7.5,45.8).lineTo(7.3,51.7).curveTo(7.2,52.4,7.2,53.3).lineTo(6.6,72.5).closePath();
			//this.shape_12.setTransform(0,644.8);

			var shape_13:Shape = new Shape();
			//shape_13.graphics.beginFill(0x000000);
			shape_13.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x666666], [1, 1], [0, 255], new Matrix(1, 6.8, 5.9, 1, -1.6, -10.9));
			shape_13.graphics.moveTo( -159.3, 63.8);
			shape_13.graphics.lineTo(118.9, -63);
			shape_13.graphics.lineTo(159.2, -81.4);
			shape_13.graphics.lineTo(159.2, -63.8);
			shape_13.graphics.lineTo( -159.3, 81.4);
			shape_13.x = -176.8;
			shape_13.y = 618.2;
			airplane.addChild(shape_13);
			
			//this.shape_13.graphics.beginLinearGradientFill(["#000000","#666666"],[0,1],-1.6,-10.9,6.8,5.9).beginStroke().moveTo(-159.3,63.8).lineTo(118.9,-63).lineTo(159.2,-81.4).lineTo(159.2,-63.8).lineTo(-159.3,81.4).closePath();
			//this.shape_13.setTransform(-176.8,618.2);
/*
			var shape_14:Shape = new Shape();
			this.shape_14.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#CCCCCC"],[0,0.294,1],-20.3,-5.7,59.2,153.1).beginStroke().moveTo(149.7,90.3).lineTo(149.7,70.8).lineTo(149.7,33.3).lineTo(98.6,47.8).lineTo(98.6,57.6).lineTo(81.2,62.2).lineTo(81.2,52.6).lineTo(98.6,47.8).lineTo(81.2,52.6).lineTo(19.6,70).lineTo(81.2,52.6).lineTo(81.2,62.2).lineTo(98.6,57.6).lineTo(98.6,47.8).lineTo(149.7,33.3).lineTo(149.7,70.8).lineTo(73.4,90.3).lineTo(-52.9,90.3).lineTo(8.6,73).lineTo(8.6,78.6).lineTo(19.6,75.4).lineTo(19.6,70).lineTo(8.6,73).lineTo(19.6,70).lineTo(19.6,75.4).lineTo(8.6,78.6).lineTo(8.6,73).lineTo(-52.9,90.3).lineTo(-159.2,90.3).lineTo(-159.2,81.1).lineTo(-159.2,90.3).lineTo(-177.3,90.3).lineTo(-176.9,79.9).lineTo(-159.2,81.1).lineTo(-159.2,75).lineTo(-176.4,73.9).lineTo(-175.7,65.7).lineTo(-152.3,55).lineTo(-152.3,72.6).lineTo(166.2,-72.6).lineTo(166.2,-90.1).lineTo(166.5,-90.3).lineTo(171.3,52.6).lineTo(176,52.6).lineTo(176,53.8).lineTo(176,54).lineTo(176.6,71.8).curveTo(176.9,81.4,177.3,90.3).closePath().moveTo(149.7,90.3).lineTo(73.4,90.3).lineTo(149.7,70.8).lineTo(149.7,90.3).closePath().moveTo(149.7,70.8).closePath();
			this.shape_14.setTransform(-183.8,627);

			var shape_15:Shape = new Shape();
			this.shape_15.graphics.beginLinearGradientFill(["#000000","#666666"],[0,1],4.1,-7.7,-3.7,7.9).beginStroke().moveTo(-159.3,-63.7).lineTo(-159.3,-81.3).lineTo(-119.5,-63.2).lineTo(159.3,63.7).lineTo(159.3,81.3).closePath();
			this.shape_15.setTransform(176.8,618.1);

			var shape_16:Shape = new Shape();
			this.shape_16.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#CCCCCC"],[0,0.294,1],21.2,-5.4,-58.5,152.6).beginStroke().moveTo(159,90.3).lineTo(159,81).lineTo(159,90.3).lineTo(53.3,90.3).lineTo(-8.8,72.9).lineTo(-19.7,69.9).lineTo(-19.7,75.3).lineTo(-8.8,78.4).lineTo(-8.8,72.9).lineTo(53.3,90.3).lineTo(-73.6,90.3).lineTo(-149.9,70.8).lineTo(-149.9,33.3).lineTo(-98.7,47.7).lineTo(-98.7,57.4).lineTo(-81.4,62.2).lineTo(-81.4,52.6).lineTo(-19.7,69.9).lineTo(-81.4,52.6).lineTo(-98.7,47.7).lineTo(-149.9,33.3).lineTo(-149.9,70.8).lineTo(-149.9,90.3).lineTo(-177.3,90.3).lineTo(-176.7,71.1).curveTo(-176.7,70.2,-176.6,69.4).lineTo(-176.4,63.6).lineTo(-176.1,54).lineTo(-176.1,53.8).lineTo(-176,52.6).lineTo(-171.2,52.6).lineTo(-166.7,-90.3).lineTo(-166.4,-90.1).lineTo(-166.4,-72.6).lineTo(152.1,72.4).lineTo(152.1,54.9).lineTo(175.5,65.5).lineTo(176.3,73.8).lineTo(159,74.8).lineTo(159,81).lineTo(176.7,79.8).lineTo(177.3,90.3).closePath().moveTo(-149.9,90.3).lineTo(-149.9,70.8).lineTo(-73.6,90.3).closePath().moveTo(-19.7,75.3).lineTo(-19.7,69.9).lineTo(-8.8,72.9).lineTo(-8.8,78.4).closePath().moveTo(-8.8,72.9).closePath().moveTo(-149.9,70.8).closePath().moveTo(-98.7,57.4).lineTo(-98.7,47.7).lineTo(-81.4,52.6).lineTo(-81.4,62.2).closePath().moveTo(-98.7,47.7).closePath();
			this.shape_16.setTransform(183.9,627);

			var shape_17:Shape = new Shape();
			this.shape_17.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#FFFFFF","#CCCCCC"],[0,0.392,0.616,1],-105.9,-259.2,106.1,-259.2).beginStroke().moveTo(-59.5,292.8).curveTo(-62.2,279,-64.7,265).curveTo(-70.2,233.2,-75.6,195.6).lineTo(-89.9,-39.3).curveTo(-90.4,-48.3,-99.4,-48.3).lineTo(-102.6,-48.3).lineTo(-104.7,-73).lineTo(-105.8,-86.7).lineTo(-106,-88.4).lineTo(-106,-302.4).lineTo(59.1,-302.4).lineTo(59.1,-263.6).curveTo(59.1,-248.6,74.1,-248.6).lineTo(106,-248.6).lineTo(74.1,-248.6).curveTo(59.1,-248.6,59.1,-263.6).lineTo(59.1,-302.4).lineTo(106,-302.4).lineTo(106,-248.6).lineTo(106,-88.4).lineTo(105.9,-86.7).lineTo(104.7,-73).lineTo(102.5,-48.1).lineTo(99.4,-48.1).curveTo(90.4,-48.1,89.8,-39.1).lineTo(75.6,195.3).curveTo(70.2,233.1,64.6,265).curveTo(62.2,279,59.5,292.8).lineTo(57.6,302.2).lineTo(17.8,284.1).lineTo(17.6,283.9).lineTo(17.8,274.8).curveTo(23.5,161.4,0.3,163.3).curveTo(-22.9,161.4,-17.3,274.8).lineTo(-17,283.9).lineTo(-17.3,284.1).lineTo(-57.6,302.4).lineTo(-59.5,292.8).closePath().moveTo(-96.5,15.5).curveTo(-99.7,-15.3,-102.6,-48.3).lineTo(-99.4,-48.3).curveTo(-90.4,-48.3,-89.9,-39.3).lineTo(-75.6,195.6).curveTo(-86.7,117.9,-96.5,15.5).closePath().moveTo(89.8,-39.1).curveTo(90.4,-48.1,99.4,-48.1).lineTo(102.5,-48.1).curveTo(99.7,-15.3,96.7,15.5).curveTo(86.7,117.8,75.6,195.3).closePath().moveTo(102.5,-48.1).closePath().moveTo(-102.6,-48.3).closePath().moveTo(59.1,-302.4).closePath();
			this.shape_17.setTransform(-0.3,252.8);

			var shape_18:Shape = new Shape();
			this.shape_18.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#CCCCCC"],[0,0.518,1],-62.9,-0.1,63,-0.1).beginStroke().moveTo(27.4,154.1).lineTo(-27.9,154.1).curveTo(-48.3,102.5,-56.3,49.4).lineTo(56.4,49.4).curveTo(48.4,102.5,27.9,154.1).closePath().moveTo(-56.3,49.4).curveTo(-57.2,44.3,-57.8,39.1).curveTo(-60.3,17,-62.4,-45.1).curveTo(-64.4,-103,-58.8,-132.3).curveTo(-58.5,-135,-57.9,-137.3).curveTo(-55.9,-146.2,-53.3,-152.6).lineTo(-52.7,-154.1).lineTo(52.6,-154.1).curveTo(54.9,-148.7,57,-141.6).lineTo(57.9,-137.3).lineTo(59.1,-132.3).curveTo(64.3,-103,62.4,-45.1).curveTo(60.4,17,57.7,39.1).curveTo(57.1,44.3,56.4,49.4).closePath().moveTo(59.1,-132.3).lineTo(-58.8,-132.3).closePath().moveTo(-56.3,49.4).closePath();
			this.shape_18.setTransform(-178.3,321.4);

			var shape_19:Shape = new Shape();
			this.shape_19.graphics.beginLinearGradientFill(["#000000","#666666"],[0,1],0.2,-10.1,0.2,10.1).beginStroke().moveTo(-52.6,8.5).curveTo(-50.3,2.7,-47.1,-1.1).curveTo(-39.9,-9.5,-27.9,-8.4).lineTo(27.9,-8.4).curveTo(39.9,-9.5,47.1,-1.1).curveTo(50,2.4,52.3,7.7).lineTo(52.7,8.5).closePath();
			this.shape_19.setTransform(-178.3,158.8);

			var shape_20:Shape = new Shape();
			this.shape_20.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#CCCCCC"],[0,0.518,1],63,-0.1,-63,-0.1).beginStroke().moveTo(-27.4,154.1).lineTo(-28,154.1).curveTo(-48.4,102.5,-56.5,49.4).lineTo(56.2,49.4).curveTo(48.4,102.5,28,154.1).closePath().moveTo(-56.5,49.4).curveTo(-57.2,44.3,-57.8,39.1).curveTo(-60.4,17,-62.5,-45.1).curveTo(-64.3,-103,-59,-132.3).curveTo(-58.6,-135,-58,-137.3).curveTo(-57.4,-139.5,-57.1,-141.6).curveTo(-55,-148.7,-52.7,-154.1).lineTo(52.7,-154.1).lineTo(53.3,-152.7).curveTo(55.9,-146.2,58,-137.3).lineTo(58.9,-132.3).curveTo(64.3,-103,62.5,-45.1).curveTo(60.4,17,57.7,39.1).curveTo(57.2,44.3,56.2,49.4).closePath().moveTo(58.9,-132.3).lineTo(-59,-132.3).closePath().moveTo(-56.5,49.4).closePath();
			this.shape_20.setTransform(177.3,321.4);

			var shape_21:Shape = new Shape();
			this.shape_21.graphics.beginLinearGradientFill(["#000000","#666666"],[0,1],-0.2,-10.1,-0.2,10.1).beginStroke().moveTo(-52.7,8.5).lineTo(-52.4,7.7).curveTo(-50.1,2.4,-47,-1.1).curveTo(-40,-9.5,-28,-8.4).lineTo(28,-8.4).curveTo(40,-9.5,47,-1.1).curveTo(50.2,2.7,52.7,8.5).closePath();
			this.shape_21.setTransform(177.3,158.8);

			var shape_22:Shape = new Shape();
			this.shape_22.graphics.beginLinearGradientFill(["#999999","#FFFFFF"],[0,1],41,-6.6,-60.5,5.2).beginStroke().moveTo(-32.6,182.9).lineTo(-45.5,112.8).lineTo(-45.1,112.8).curveTo(-24.5,61.2,-16.6,8.2).curveTo(-15.8,3.1,-15.2,-2.2).curveTo(-12.5,-24.2,-10.6,-86.3).curveTo(-8.6,-144.2,-13.9,-173.6).lineTo(-15.1,-178.5).lineTo(-16,-182.9).lineTo(0.3,-182.9).lineTo(2.5,-158.2).curveTo(5.3,-125.2,8.5,-94.4).curveTo(18.3,8,29.4,85.7).curveTo(34.8,123.3,40.4,155.1).curveTo(42.8,169.1,45.5,182.9).closePath();
			this.shape_22.setTransform(-105.3,362.7);

			var shape_23:Shape = new Shape();
			this.shape_23.graphics.beginLinearGradientFill(["#999999","#FFFFFF"],[0,1],-42.7,-4.1,58.5,9.3).beginStroke().moveTo(-45.4,182.9).curveTo(-42.7,169.1,-40.2,155.1).curveTo(-34.7,123.2,-29.3,85.4).curveTo(-18.2,7.9,-8.2,-94.4).curveTo(-5.2,-125.2,-2.3,-158).lineTo(-0.1,-182.9).lineTo(15.7,-182.9).curveTo(15.4,-180.8,14.8,-178.5).curveTo(14.2,-176.3,13.7,-173.6).curveTo(8.5,-144.2,10.3,-86.3).curveTo(12.4,-24.2,14.9,-2.2).curveTo(15.5,3.1,16.3,8.2).curveTo(24.4,61.2,44.8,112.8).lineTo(45.4,112.8).lineTo(32.5,182.9).closePath();
			this.shape_23.setTransform(104.6,362.7);

			var shape_24:Shape = new Shape();
			this.shape_24.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#FFFFFF","#CCCCCC"],[0,0.424,0.722,1],-164.7,84.2,-208.7,-138.4).beginStroke().moveTo(-202.7,75.7).lineTo(-202.7,21.1).lineTo(-202.7,-112.2).lineTo(202.5,-112.2).lineTo(202.5,101.8).lineTo(202.7,103.6).lineTo(188.6,103.9).lineTo(188.6,55.9).lineTo(129.6,58.9).lineTo(130.7,58.8).lineTo(130.7,1.3).lineTo(4.6,8.8).lineTo(-142.4,17.5).lineTo(-202.7,21.1).lineTo(-142.4,17.5).lineTo(-142.4,72.6).lineTo(4.6,65.2).lineTo(129.6,58.9).lineTo(188.6,55.9).lineTo(188.6,103.9).lineTo(182.8,104).curveTo(180.5,98.7,177.6,95.2).curveTo(170.4,86.8,158.4,87.9).lineTo(102.6,87.9).curveTo(90.6,86.8,83.4,95.2).curveTo(80.3,99,77.9,104.8).lineTo(77.3,106.3).lineTo(-202.7,112.2).closePath().moveTo(-202.7,75.7).lineTo(-142.4,72.6).closePath().moveTo(188.6,103.9).closePath().moveTo(-142.4,17.5).lineTo(4.6,8.8).lineTo(130.7,1.3).lineTo(130.7,58.8).lineTo(129.6,58.9).lineTo(4.6,65.2).lineTo(4.6,8.8).lineTo(4.6,65.2).lineTo(-142.4,72.6).closePath().moveTo(129.6,58.9).closePath();
			this.shape_24.setTransform(-308.8,62.5);

			var shape_25:Shape = new Shape();
			this.shape_25.graphics.beginLinearGradientFill(["#CCCCCC","#FFFFFF","#FFFFFF","#CCCCCC"],[0,0.424,0.722,1],165.2,84.2,209.2,-138.4).beginStroke().moveTo(-78.5,106.2).lineTo(-79,104.9).curveTo(-81.6,99.1,-84.7,95.3).curveTo(-91.7,86.9,-103.8,87.9).lineTo(-159.7,87.9).curveTo(-171.7,86.9,-178.7,95.3).curveTo(-181.8,98.8,-184.1,104).lineTo(-189.4,103.9).lineTo(-189.4,55.7).lineTo(-130.5,58.7).lineTo(-5.4,65).lineTo(-130.5,58.7).lineTo(-189.4,55.7).lineTo(-189.4,103.9).lineTo(-203.5,103.6).lineTo(-203.4,101.9).lineTo(-203.4,-58.2).lineTo(-203.4,-112.1).lineTo(203.5,-112.1).lineTo(203.5,21.1).lineTo(141.6,17.3).lineTo(-5.4,8.6).lineTo(-131.5,1.1).lineTo(-131.5,58.5).lineTo(-130.5,58.7).lineTo(-131.5,58.5).lineTo(-131.5,1.1).lineTo(-5.4,8.6).lineTo(141.6,17.3).lineTo(141.6,72.4).lineTo(-5.4,65).lineTo(-5.4,8.6).lineTo(-5.4,65).lineTo(141.6,72.4).lineTo(141.6,17.3).lineTo(203.5,21.1).lineTo(203.5,75.6).lineTo(141.6,72.4).lineTo(203.5,75.6).lineTo(203.5,112.1).closePath().moveTo(-5.4,65).closePath().moveTo(203.5,21.1).closePath();
			this.shape_25.setTransform(309.1,62.5);*/
		}
		
	}

}