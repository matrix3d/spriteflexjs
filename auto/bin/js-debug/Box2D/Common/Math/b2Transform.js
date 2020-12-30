/**
 * Generated by Apache Royale Compiler from Box2D/Common/Math/b2Transform.as
 * Box2D.Common.Math.b2Transform
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Common.Math.b2Transform');
/* Royale Dependency List: Box2D.Common.Math.b2Mat22,Box2D.Common.Math.b2Vec2*/




/**
 * The default constructor does nothing (for performance).
 * @constructor
 * @param {Box2D.Common.Math.b2Vec2=} pos
 * @param {Box2D.Common.Math.b2Mat22=} r
 */
Box2D.Common.Math.b2Transform = function(pos, r) {
  pos = typeof pos !== 'undefined' ? pos : null;
  r = typeof r !== 'undefined' ? r : null;
  
  this.position = new Box2D.Common.Math.b2Vec2();
  this.R = new Box2D.Common.Math.b2Mat22();
  if (pos) {
    this.position.SetV(pos);
    this.R.SetM(r);
  }
};


/**
 * Initialize using a position vector and a rotation matrix.
 * @param {Box2D.Common.Math.b2Vec2} pos
 * @param {Box2D.Common.Math.b2Mat22} r
 */
Box2D.Common.Math.b2Transform.prototype.Initialize = function(pos, r) {
  this.position.SetV(pos);
  this.R.SetM(r);
};


/**
 * Set this to the identity transform.
 */
Box2D.Common.Math.b2Transform.prototype.SetIdentity = function() {
  this.position.SetZero();
  this.R.SetIdentity();
};


/**
 * @param {Box2D.Common.Math.b2Transform} x
 */
Box2D.Common.Math.b2Transform.prototype.Set = function(x) {
  this.position.SetV(x.position);
  this.R.SetM(x.R);
};


/** 
 * Calculate the angle that the rotation matrix represents.
 * @return {number}
 */
Box2D.Common.Math.b2Transform.prototype.GetAngle = function() {
  return Math.atan2(this.R.col1.y, this.R.col1.x);
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Common.Math.b2Transform.prototype.position = null;


/**
 * @type {Box2D.Common.Math.b2Mat22}
 */
Box2D.Common.Math.b2Transform.prototype.R = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Common.Math.b2Transform.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2Transform', qName: 'Box2D.Common.Math.b2Transform', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Common.Math.b2Transform.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'position': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Common.Math.b2Transform */ inst, /** * */ v) {return v !== undefined ? inst.position = v : inst.position;}},
        'R': { type: 'Box2D.Common.Math.b2Mat22', get_set: function (/** Box2D.Common.Math.b2Transform */ inst, /** * */ v) {return v !== undefined ? inst.R = v : inst.R;}}
      };
    },
    methods: function () {
      return {
        'b2Transform': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Transform', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', true ,'Box2D.Common.Math.b2Mat22', true ]; }},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Transform', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ,'Box2D.Common.Math.b2Mat22', false ]; }},
        'SetIdentity': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Transform'},
        'Set': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Transform', parameters: function () { return [ 'Box2D.Common.Math.b2Transform', false ]; }},
        'GetAngle': { type: 'Number', declaredBy: 'Box2D.Common.Math.b2Transform'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Common.Math.b2Transform.prototype.ROYALE_COMPILE_FLAGS = 9;
