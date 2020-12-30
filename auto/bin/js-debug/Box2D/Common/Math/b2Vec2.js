/**
 * Generated by Apache Royale Compiler from Box2D/Common/Math/b2Vec2.as
 * Box2D.Common.Math.b2Vec2
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Common.Math.b2Vec2');
/* Royale Dependency List: Box2D.Common.Math.b2Mat22*/




/**
 * @constructor
 * @param {number=} x_
 * @param {number=} y_
 */
Box2D.Common.Math.b2Vec2 = function(x_, y_) {
  x_ = typeof x_ !== 'undefined' ? x_ : 0;
  y_ = typeof y_ !== 'undefined' ? y_ : 0;
  this.x = x_;
  this.y = y_;
};


/**
 */
Box2D.Common.Math.b2Vec2.prototype.SetZero = function() {
  this.x = 0.0;
  this.y = 0.0;
};


/**
 * @param {number=} x_
 * @param {number=} y_
 */
Box2D.Common.Math.b2Vec2.prototype.Set = function(x_, y_) {
  x_ = typeof x_ !== 'undefined' ? x_ : 0;
  y_ = typeof y_ !== 'undefined' ? y_ : 0;
  this.x = x_;
  this.y = y_;
};


/**
 * @param {Box2D.Common.Math.b2Vec2} v
 */
Box2D.Common.Math.b2Vec2.prototype.SetV = function(v) {
  this.x = v.x;
  this.y = v.y;
};


/**
 * @return {Box2D.Common.Math.b2Vec2}
 */
Box2D.Common.Math.b2Vec2.prototype.GetNegative = function() {
  return new Box2D.Common.Math.b2Vec2(-this.x, -this.y);
};


/**
 */
Box2D.Common.Math.b2Vec2.prototype.NegativeSelf = function() {
  this.x = -this.x;
  this.y = -this.y;
};


/**
 * @nocollapse
 * @param {number} x_
 * @param {number} y_
 * @return {Box2D.Common.Math.b2Vec2}
 */
Box2D.Common.Math.b2Vec2.Make = function(x_, y_) {
  return new Box2D.Common.Math.b2Vec2(x_, y_);
};


/**
 * @return {Box2D.Common.Math.b2Vec2}
 */
Box2D.Common.Math.b2Vec2.prototype.Copy = function() {
  return new Box2D.Common.Math.b2Vec2(this.x, this.y);
};


/**
 * @param {Box2D.Common.Math.b2Vec2} v
 */
Box2D.Common.Math.b2Vec2.prototype.Add = function(v) {
  this.x += v.x;
  this.y += v.y;
};


/**
 * @param {Box2D.Common.Math.b2Vec2} v
 */
Box2D.Common.Math.b2Vec2.prototype.Subtract = function(v) {
  this.x -= v.x;
  this.y -= v.y;
};


/**
 * @param {number} a
 */
Box2D.Common.Math.b2Vec2.prototype.Multiply = function(a) {
  this.x *= a;
  this.y *= a;
};


/**
 * @param {Box2D.Common.Math.b2Mat22} A
 */
Box2D.Common.Math.b2Vec2.prototype.MulM = function(A) {
  var /** @type {number} */ tX = this.x;
  this.x = A.col1.x * tX + A.col2.x * this.y;
  this.y = A.col1.y * tX + A.col2.y * this.y;
};


/**
 * @param {Box2D.Common.Math.b2Mat22} A
 */
Box2D.Common.Math.b2Vec2.prototype.MulTM = function(A) {
  var /** @type {number} */ tX = Box2D.Common.Math.b2Vec2.Dot(this, A.col1);
  this.y = Box2D.Common.Math.b2Vec2.Dot(this, A.col2);
  this.x = tX;
};


/**
 * @param {number} s
 */
Box2D.Common.Math.b2Vec2.prototype.CrossVF = function(s) {
  var /** @type {number} */ tX = this.x;
  this.x = s * this.y;
  this.y = -s * tX;
};


/**
 * @param {number} s
 */
Box2D.Common.Math.b2Vec2.prototype.CrossFV = function(s) {
  var /** @type {number} */ tX = this.x;
  this.x = -s * this.y;
  this.y = s * tX;
};


/**
 * @param {Box2D.Common.Math.b2Vec2} b
 */
Box2D.Common.Math.b2Vec2.prototype.MinV = function(b) {
  this.x = this.x < b.x ? this.x : b.x;
  this.y = this.y < b.y ? this.y : b.y;
};


/**
 * @param {Box2D.Common.Math.b2Vec2} b
 */
Box2D.Common.Math.b2Vec2.prototype.MaxV = function(b) {
  this.x = this.x > b.x ? this.x : b.x;
  this.y = this.y > b.y ? this.y : b.y;
};


/**
 */
Box2D.Common.Math.b2Vec2.prototype.Abs = function() {
  if (this.x < 0)
    this.x = -this.x;
  if (this.y < 0)
    this.y = -this.y;
};


/**
 * @return {number}
 */
Box2D.Common.Math.b2Vec2.prototype.Length = function() {
  return Math.sqrt(this.x * this.x + this.y * this.y);
};


/**
 * @return {number}
 */
Box2D.Common.Math.b2Vec2.prototype.LengthSquared = function() {
  return (this.x * this.x + this.y * this.y);
};


/**
 * @return {number}
 */
Box2D.Common.Math.b2Vec2.prototype.Normalize = function() {
  var /** @type {number} */ length = Math.sqrt(this.x * this.x + this.y * this.y);
  if (length < Number.MIN_VALUE) {
    return 0.0;
  }
  var /** @type {number} */ invLength = 1.0 / length;
  this.x *= invLength;
  this.y *= invLength;
  return length;
};


/**
 * @return {boolean}
 */
Box2D.Common.Math.b2Vec2.prototype.IsValid = function() {
  return Box2D.Common.Math.b2Vec2.MathIsValid(this.x) && Box2D.Common.Math.b2Vec2.MathIsValid(this.y);
};


/**
 * @nocollapse
 * @param {Box2D.Common.Math.b2Vec2} a
 * @param {Box2D.Common.Math.b2Vec2} b
 * @return {number}
 */
Box2D.Common.Math.b2Vec2.Dot = function(a, b) {
  return a.x * b.x + a.y * b.y;
};


/**
 * @nocollapse
 * @param {number} x
 * @return {boolean}
 */
Box2D.Common.Math.b2Vec2.MathIsValid = function(x) {
  return isFinite(x);
};


/**
 * @type {number}
 */
Box2D.Common.Math.b2Vec2.prototype.x = NaN;


/**
 * @type {number}
 */
Box2D.Common.Math.b2Vec2.prototype.y = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Common.Math.b2Vec2.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2Vec2', qName: 'Box2D.Common.Math.b2Vec2', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Common.Math.b2Vec2.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'x': { type: 'Number', get_set: function (/** Box2D.Common.Math.b2Vec2 */ inst, /** * */ v) {return v !== undefined ? inst.x = v : inst.x;}},
        'y': { type: 'Number', get_set: function (/** Box2D.Common.Math.b2Vec2 */ inst, /** * */ v) {return v !== undefined ? inst.y = v : inst.y;}}
      };
    },
    methods: function () {
      return {
        'b2Vec2': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', true ,'Number', true ]; }},
        'SetZero': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'Set': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', true ,'Number', true ]; }},
        'SetV': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ]; }},
        'GetNegative': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'NegativeSelf': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        '|Make': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'Copy': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'Add': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ]; }},
        'Subtract': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ]; }},
        'Multiply': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', false ]; }},
        'MulM': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Mat22', false ]; }},
        'MulTM': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Mat22', false ]; }},
        'CrossVF': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', false ]; }},
        'CrossFV': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', false ]; }},
        'MinV': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ]; }},
        'MaxV': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ]; }},
        'Abs': { type: 'void', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'Length': { type: 'Number', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'LengthSquared': { type: 'Number', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'Normalize': { type: 'Number', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        'IsValid': { type: 'Boolean', declaredBy: 'Box2D.Common.Math.b2Vec2'},
        '|Dot': { type: 'Number', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Box2D.Common.Math.b2Vec2', false ,'Box2D.Common.Math.b2Vec2', false ]; }},
        '|MathIsValid': { type: 'Boolean', declaredBy: 'Box2D.Common.Math.b2Vec2', parameters: function () { return [ 'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Common.Math.b2Vec2.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Common.Math.b2Vec2.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Common.Math.b2Vec2);
