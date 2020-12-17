/**
 * Copyright keim_at_Si ( http://wonderfl.net/user/keim_at_Si )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/9R8a
 */

// forked from saharan's 3D水面 / Water 3D
package {
	import flash.__native.WebGLRenderer;
    import flash.system.LoaderContext;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import com.bit101.components.*;
    import net.hires.debug.*;

    [SWF(frameRate = "30", width="465", height="465")]

    /**
     * Clear Water 3D
     *
     * Click&Drag:Make wave
     * 
     * @author saharan
     * @modifyer keim_at_Si(refraction)
     */
    public class Water3D extends Sprite {
        private const NUM_DETAILS:int = 48;
        private const INV_NUM_DETAILS:Number = 1 / NUM_DETAILS;
        private const MESH_SIZE:Number = 100;
        private var count:uint;
        private var bmd:BitmapData, bmd2:BitmapData;
        private var loader:Loader, loader2:Loader;
        private var vertices:Vector.<Vector3D>;
        private var transformedVertices:Vector.<Number>;
        private var indices:Vector.<int>;
        private var uvt:Vector.<Number>, uvt2:Vector.<Number>;
        private var width2:Number;
        private var height2:Number;
        private var heights:Vector.<Vector.<Number>>;
        private var velocity:Vector.<Vector.<Number>>;
        
/*      // for local
        private var refractionTexture:String = "_env1.png";
        private var reflectionTexture:String = "_env2.png";
/*/     // for wonderfl
        private var refractionTexture:String = "../../assets/b2177f87d979a28b9bcbb6e0b89370e77ce22337";
        private var reflectionTexture:String = "../../assets/bbf12c60cf84e5ab43e059920783d036da25df48";
//*/
        private var viewedAngleH:Number = 0;
        private var viewedAngleV:Number = -20 * 0.017453292519943295;
        private var cameraDistance:Number = MESH_SIZE;
        private var focalLength:Number = MESH_SIZE * 4;
        private var boxHeight:Number = MESH_SIZE*0.75;
        private var refractiveIndex:Number = 1.4;
        private var reflectionLayer:Shape;
        private var refractionLayer:Shape;
        private var cameraPosition:Vector3D = new Vector3D();
        private var m00:Number, m01:Number, m02:Number, m10:Number, m11:Number, m12:Number, m20:Number, m21:Number, m22:Number;
        
        function Water3D() : void {
			CONFIG::js_only{
				SpriteFlexjs.wmode = "gpu batch";
				SpriteFlexjs.renderer = new WebGLRenderer;
			}
			
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

    //-------------------------------------------------- initialize
        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.quality = StageQuality.LOW;
            width2 = 465 / 2;
            height2 = 465 / 2;
            // var s:Stats = new Stats();
            // s.alpha = 0.8;
            // addChild(s);
            count = 0;
            loader = new Loader();
            loader.load(new URLRequest(refractionTexture), new LoaderContext(true));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            loader2 = new Loader();
            loader2.load(new URLRequest(reflectionTexture), new LoaderContext(true));
            loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
            vertices = new Vector.<Vector3D>(NUM_DETAILS * NUM_DETAILS, true);
            transformedVertices = new Vector.<Number>(NUM_DETAILS * NUM_DETAILS * 2, true);
            indices = new Vector.<int>();
            uvt = new Vector.<Number>(NUM_DETAILS * NUM_DETAILS * 2, true);
            uvt2 = new Vector.<Number>(NUM_DETAILS * NUM_DETAILS * 2, true);
            var i:int;
            var j:int;
            // 頂点初期化。外側2つ分は表示しないので無駄な処理＆メモリに・・・
            // [modification] change surface from x-z plane to x-y plane in order to fit together with normal calculation.
            for (i = 2; i < NUM_DETAILS - 2; i++) {
                for (j = 2; j < NUM_DETAILS - 2; j++) {
                    vertices[getIndex(j, i)] = new Vector3D(
                        (j - (NUM_DETAILS - 1) * 0.5) / NUM_DETAILS * MESH_SIZE,
                        (i - (NUM_DETAILS - 1) * 0.5) / NUM_DETAILS * MESH_SIZE, 0);
                    if (i != 2 && j != 2) {
                        indices.push(getIndex(i - 1, j - 1), getIndex(i, j - 1), getIndex(i, j));
                        indices.push(getIndex(i - 1, j - 1), getIndex(i, j), getIndex(i - 1, j));
                    }
                }
            }
            function getIndex(x:int, y:int):int { return y * NUM_DETAILS + x; }
            // 水面関係初期化
            heights = new Vector.<Vector.<Number>>(NUM_DETAILS, true);
            velocity = new Vector.<Vector.<Number>>(NUM_DETAILS, true);
            for (i = 0; i < NUM_DETAILS; i++) {
                heights[i] = new Vector.<Number>(NUM_DETAILS, true);
                velocity[i] = new Vector.<Number>(NUM_DETAILS, true);
                for (j = 0; j < NUM_DETAILS; j++) {
                    heights[i][j] = 0;
                    velocity[i][j] = 0;
                }
            }
            
            // [modification] Rendering layers
            addChild(refractionLayer = new Shape());
            addChild(reflectionLayer = new Shape());
            reflectionLayer.alpha = 0.4;
            // [modification] controlers
            new HUISlider(this, 0, 0, "Angle", function(e:Event):void { viewedAngleV = -e.target.value* 0.017453292519943295;}).setSliderParams(0, 80, 20);
            new HUISlider(this, 0, 20, "Refraction", function(e:Event):void { refractiveIndex = e.target.value;}).setSliderParams(1, 3, 1.4);
            new HUISlider(this, 0, 40, "Reflection", function(e:Event):void { reflectionLayer.alpha = e.target.value;}).setSliderParams(0, 1, 0.4);
        }
        
    //-------------------------------------------------- events
        private function loaded(e:Event) : void {
           // e.target.removeEventListener(e.type, arguments.callee);
            if (loader.content && loader2.content) {
                bmd  = Bitmap(loader.content).bitmapData;
                bmd2 = Bitmap(loader2.content).bitmapData;
                addEventListener(Event.ENTER_FRAME, frame);
            }
        }
        
        private function mouseDown(e:MouseEvent) : void {
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseDrag);
            ripple((mouseY -232.5)/ 465 * MESH_SIZE, (mouseX -232.5)/ 465 * MESH_SIZE, 10);
        }
        
        private function mouseUp(e:MouseEvent) : void {
            stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseDrag);
        }
        
        private function mouseDrag(e:MouseEvent) : void {
            ripple((mouseY -232.5)/ 465 * MESH_SIZE, (mouseX -232.5)/ 465 * MESH_SIZE, 3);
        }
        
        private function ripple(mx:Number, my:Number, intensity:Number) : void {
            var i:int, j:int, dx:Number, dy:Number, acc:Number, imin:int, jmin:int, imax:int, jmax:int;
            mx = (mx / MESH_SIZE + 0.5) * NUM_DETAILS;
            my = (my / MESH_SIZE + 0.5) * NUM_DETAILS;
            imin = (mx > 5) ? int(mx - 3) : 2;
            jmin = (my > 5) ? int(my - 3) : 2;
            imax = (mx < NUM_DETAILS-5) ? int(mx + 4) : (NUM_DETAILS - 1);
            jmax = (my < NUM_DETAILS-5) ? int(my + 4) : (NUM_DETAILS - 1);
            for (i=imin; i<imax; i++) for (j=jmin; j<jmax; j++) {
                dx = mx - i;
                dy = my - j;
                acc = 3 - Math.sqrt(dx * dx + dy * dy);
                if (acc > 0) velocity[i][j] += acc*intensity;
            }
        }
        
    //-------------------------------------------------- on each frame
        private function frame(e:Event = null):void {
            count++;
            move();
            setMesh();
            transformVertices();
            draw();
        }

        private function move():void {
            // ---Water simulation---
            var i:int;
            var j:int;
            for (i = 1; i < NUM_DETAILS - 1; i++) {
                for (j = 1; j < NUM_DETAILS - 1; j++) {
                    heights[i][j] += velocity[i][j];
                    if (heights[i][j] > 100) heights[i][j] = 100;
                    else if (heights[i][j] < -100) heights[i][j] = -100;
                }
            }
            for (i = 1; i < NUM_DETAILS - 1; i++) {
                for (j = 1; j < NUM_DETAILS - 1; j++) {
                    velocity[i][j] = (velocity[i][j] +
                        (heights[i - 1][j] + heights[i][j - 1] + heights[i + 1][j] +
                        heights[i][j + 1] - heights[i][j] * 4) * 0.5) * 0.95;
                }
            }
            
            // why dont I use Matrix3D !?
//            var viewedAngleH:Number =   (mouseX -232.5) / 465 * 40 * 0.017453292519943295,
//                viewedAngleV:Number = -((mouseY -232.5) / 465 * 40 + 40) * 0.017453292519943295;
            var sx:Number = Math.sin(viewedAngleV), sy:Number = Math.sin(viewedAngleH), 
                cx:Number = Math.cos(viewedAngleV), cy:Number = Math.cos(viewedAngleH);
            m00 = cy;
            m01 = 0;
            m02 = -sy;
            m10 = sy*sx;
            m11 = cx;
            m12 = cy*sx;
            m20 = sy*cx;
            m21 = -sx;
            m22 = cy*cx;
            cameraPosition.x = -cameraDistance * m02;
            cameraPosition.y = -cameraDistance * m12;
            cameraPosition.z = -cameraDistance * m22;
        }

        private function setMesh():void {
            // calclate constants
            var rimo:Number = refractiveIndex - 1,
                xymax:Number = MESH_SIZE * 0.45, //MESH_SIZE * 0.5,
                ixymax:Number = 1 / xymax;
            
            for (var i:int = 2; i < NUM_DETAILS - 2; i++) {
                for (var j:int = 2; j < NUM_DETAILS - 2; j++) {
                    const index:int = i * NUM_DETAILS + j;
                    var v:Vector3D = vertices[index];
                    v.z = heights[i][j] * 0.15;
                    
                    // ---Sphere map---
                    var nx:Number, ny:Number, nz:Number;
                    nx = (heights[i][j] - heights[i - 1][j]) * 0.15;
                    ny = (heights[i][j] - heights[i][j - 1]) * 0.15;
                    var len:Number = 1 / Math.sqrt(nx * nx + ny * ny + 1);
                    nx *= len;
                    ny *= len;
                    nz = len;
                    // ちょっと式を変更して平面でもテクスチャが見えるように
                    uvt[index * 2] = nx * 0.5 + 0.5 + ((i - NUM_DETAILS * 0.5) * INV_NUM_DETAILS * 0.25);
                    uvt[index * 2 + 1] = ny * 0.5 + 0.5 + ((NUM_DETAILS * 0.5 - j) * INV_NUM_DETAILS * 0.25);
                    
                    // [modification] Refraction map
                    // incident vector (you can calculate them in the setup if you want faster)
                    var dx:Number = v.x - cameraPosition.x, dy:Number = v.y - cameraPosition.y, dz:Number = v.z - cameraPosition.z;
                    len = 1 / Math.sqrt(dx * dx + dy * dy + dz * dz);
                    dx *= len;
                    dy *= len;
                    dz *= len;
                    // output vector
                    t = (dx * nx + dy * ny + dz) * rimo;
                    dx += nx * t;
                    dy += ny * t;
                    dz += nz * t;
                    // in this calculation, we can omit normalization of output vector !
                    //len = 1 / Math.sqrt(dx * dx + dy * dy + dz * dz);
                    //dx *= len;
                    //dy *= len;
                    //dz *= len;
                    // uv coordinate
                    var t:Number, s:Number, r:Number, hitz:Number, sign:Number;
                    if (dx == 0) {
                        if (dy == 0) {
                            uvt2[index * 2] = uvt2[index * 2 + 1] = 0.5;
                            sign = 0;
                        } else sign = (dy < 0) ? -1 : 1;
                    } else {
                        sign = (dx < 0) ? -1 : 1;
                        t = (sign * xymax - v.x) / dx;
                        s = t * dy + v.y;
                        if (-xymax < s && s < xymax) {
                            hitz = t * dz + v.z;
                            if (hitz > boxHeight) {
                                r = (boxHeight-v.z) / dz;
                                uvt2[index * 2]     = (dx * r + v.x) * ixymax * 0.25 + 0.5;
                                uvt2[index * 2 + 1] = (dy * r + v.y) * ixymax * 0.25 + 0.5;
                            } else {
                                r = boxHeight / (hitz + boxHeight);
                                uvt2[index * 2]     = sign       * r * 0.5 + 0.5;
                                uvt2[index * 2 + 1] = s * ixymax * r * 0.5 + 0.5;
                            }
                            sign = 0;
                        } else sign = (s < 0) ? -1 : 1;
                    }
                    if (sign != 0) {
                        t = (sign * xymax - v.y) / dy;
                        s = t * dx + v.x;
                        hitz = t * dz + v.z;
                        if (hitz > boxHeight) {
                            r = (boxHeight-v.z) / dz;
                            uvt2[index * 2]     = (dx * r + v.x) * ixymax * 0.25 + 0.5;
                            uvt2[index * 2 + 1] = (dy * r + v.y) * ixymax * 0.25 + 0.5;
                        } else {
                            r = boxHeight / (hitz + boxHeight);
                            uvt2[index * 2]     = s * ixymax * r * 0.5 + 0.5;
                            uvt2[index * 2 + 1] = sign       * r * 0.5 + 0.5;
                        }
                    }
                    //trace(v.x,v.y,dx,dy,uvt2[index * 2],uvt2[index * 2+1]);
                }
            }
            //throw new Error("STOPPER!!");
        }
        
        private function transformVertices():void {
            var iz:Number, v:Vector3D, i:int, imax:int = vertices.length;
            for (i = 0; i < imax; i++) {
                v = vertices[i];
                if (v != null) {
                    iz = focalLength / (v.x * m02 + v.y * m12 + v.z * m22 + cameraDistance);
                    transformedVertices[i*2]   = (v.x * m00 + v.y * m10 + v.z * m20) * iz + 232.5;
                    transformedVertices[i*2+1] = (v.x * m01 + v.y * m11 + v.z * m21) * iz + 232.5;
                }
            }
        }
        
        private function draw():void {
            var refractionGraphics:Graphics = refractionLayer.graphics,
                reflectionGraphics:Graphics = reflectionLayer.graphics;
            graphics.clear();
            graphics.beginFill(0x202020);
            graphics.drawRect(0, 0, 465, 465);
            graphics.endFill();
            // [modification] compose all layers
            refractionGraphics.clear();
            refractionGraphics.beginBitmapFill(bmd2);
            refractionGraphics.drawTriangles(transformedVertices, indices, uvt2, TriangleCulling.NEGATIVE);
            refractionGraphics.endFill();
            reflectionGraphics.clear();
            reflectionGraphics.beginBitmapFill(bmd);
            reflectionGraphics.drawTriangles(transformedVertices, indices, uvt, TriangleCulling.NEGATIVE);
            reflectionGraphics.endFill();
        }
    }
}

