package TestBed
{
  import Box2D.Common.Math.b2Vec2;
  
  /** 
  * ...This class accepts an Array of four b2vec2s (corresponding to the SVG format of Bezier curves) and outputs an array of b2vec2s
  * The returned array contains all of the points that should be declared in an edgeChain version of the curve
  * This is a Flash port of the C++ version at http://www.box2d.org/forum/viewtopic.php?p=9865#p9865
  * The math for transforming a Bezien curve is found at http://www.niksula.cs.hut.fi/~hkankaan/Homepages/bezierfast.html
  * Thanks to Shaktool off the Box2D forums for the help
  * 
  * Quest Yarbrough/Ezion <www.ezqueststudios.com>
  */
  public class b2Bezier 
  {
    
    //Resolution is the number of lines to segment the curve into
    //cPoints must be structured like below.
    //cPoints[0] = starting point
    //cPoints[1] = starting point control point
    //cPoints[2] = end point control point
    //cPoints[3] = end point
    
    public static function parseCurve(cPoints:Array, resolution:Number): Array
    {
      if (resolution == 0) {
        return null;
      }
      
      var f:b2Vec2, fd:b2Vec2, fdd:b2Vec2, fddd:b2Vec2, fdd_per_2:b2Vec2, fddd_per_2:b2Vec2, fddd_per_6:b2Vec2;
      f = new b2Vec2(); fd = new b2Vec2(); fdd = new b2Vec2(); fddd = new b2Vec2();
      fdd_per_2 = new b2Vec2(); fddd_per_2 = new b2Vec2(); fddd_per_6 = new b2Vec2();
      
      var t:Number = 1.0 / resolution;
      var t2:Number = t * t;
      
      //I've tried to optimize the amount of
      //multiplications here, but these are exactly
      //the same formulas that were derived earlier
      //for f(0), f'(0)*t etc.
      
      f.x = cPoints[0].x;
      f.y = cPoints[0].y;
      
      fd.x = 3.0 * t * (cPoints[1].x - cPoints[0].x);
      fd.y = 3.0 * t * (cPoints[1].y - cPoints[0].y);
      
      fdd_per_2.x = 3.0 * t2 * (cPoints[0].x - 2.0 * cPoints[1].x + cPoints[2].x);
      fdd_per_2.y = 3.0 * t2 * (cPoints[0].y - 2.0 * cPoints[1].y + cPoints[2].y);
      
      fddd_per_2.x = 3.0 * t2 * t * (3.0 * (cPoints[1].x - cPoints[2].x) + cPoints[3].x - cPoints[0].x);
      fddd_per_2.y = 3.0 * t2 * t * (3.0 * (cPoints[1].y - cPoints[2].y) + cPoints[3].y - cPoints[0].y);
      
      fddd.x = fddd_per_2.x + fddd_per_2.x;
      fddd.y = fddd_per_2.y + fddd_per_2.y;
      
      fdd.x = fdd_per_2.x + fdd_per_2.x;
      fdd.y = fdd_per_2.y + fdd_per_2.y;
      
      fddd_per_6.x = (1.0 / 3) * fddd_per_2.x;
      fddd_per_6.y = (1.0 / 3) * fddd_per_2.y;
      
      var ret:Array = new Array(resolution);
      
      if (!ret) {
        return null;
      }
      
      for (var loop: int = 0; loop < resolution - 1; loop += 1) {
        ret[loop] = new b2Vec2();
        ret[loop].x = f.x;
        ret[loop].y = f.y;
        
        //trace("(" + ret[loop].x + "," + ret[loop].y + ")");
        
        f.x = f.x + fd.x + fdd_per_2.x + fddd_per_6.x;
        f.y = f.y + fd.y + fdd_per_2.y + fddd_per_6.y;
        
        fd.x = fd.x + fdd.x + fddd_per_2.x;
        fd.y = fd.y + fdd.y + fddd_per_2.y;
        
        fdd.x = fdd.x + fddd.x;
        fdd.y = fdd.y + fddd.y;
        
        fdd_per_2.x = fdd_per_2.x + fddd_per_2.x;
        fdd_per_2.y = fdd_per_2.y + fddd_per_2.y;
      }
      
      ret[ret.length - 1] = new b2Vec2(cPoints[3].x, cPoints[3].y); //last vertice not added by C++ version
      
      //trace("(" + ret[ret.length - 1].x + "," + ret[ret.length - 1].y + ")");
      
      return ret;
    }
  }
}