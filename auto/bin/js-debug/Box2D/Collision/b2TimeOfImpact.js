/**
 * Generated by Apache Royale Compiler from Box2D/Collision/b2TimeOfImpact.as
 * Box2D.Collision.b2TimeOfImpact
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Collision.b2TimeOfImpact');
/* Royale Dependency List: Box2D.Collision.b2Distance,Box2D.Collision.b2DistanceInput,Box2D.Collision.b2DistanceOutput,Box2D.Collision.b2DistanceProxy,Box2D.Collision.b2SeparationFunction,Box2D.Collision.b2SimplexCache,Box2D.Collision.b2TOIInput,Box2D.Common.Math.b2Math,Box2D.Common.Math.b2Sweep,Box2D.Common.Math.b2Transform,Box2D.Common.b2Settings*/




/**
 * @constructor
 */
Box2D.Collision.b2TimeOfImpact = function() {
};


/**
 * @private
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.b2_toiCalls = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.b2_toiIters = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.b2_toiMaxIters = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.b2_toiRootIters = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.b2_toiMaxRootIters = 0;


Box2D.Collision.b2TimeOfImpact.get__s_cache = function() {
  var value = new Box2D.Collision.b2SimplexCache();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_cache: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_cache = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_cache: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Collision.b2SimplexCache}
 */
Box2D.Collision.b2TimeOfImpact.s_cache;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Collision.b2SimplexCache}
 */
s_cache: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_cache,
  set: Box2D.Collision.b2TimeOfImpact.set__s_cache,
  configurable: true}});


Box2D.Collision.b2TimeOfImpact.get__s_distanceInput = function() {
  var value = new Box2D.Collision.b2DistanceInput();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_distanceInput: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_distanceInput = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_distanceInput: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Collision.b2DistanceInput}
 */
Box2D.Collision.b2TimeOfImpact.s_distanceInput;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Collision.b2DistanceInput}
 */
s_distanceInput: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_distanceInput,
  set: Box2D.Collision.b2TimeOfImpact.set__s_distanceInput,
  configurable: true}});


Box2D.Collision.b2TimeOfImpact.get__s_xfA = function() {
  var value = new Box2D.Common.Math.b2Transform();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_xfA: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_xfA = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_xfA: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Common.Math.b2Transform}
 */
Box2D.Collision.b2TimeOfImpact.s_xfA;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Common.Math.b2Transform}
 */
s_xfA: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_xfA,
  set: Box2D.Collision.b2TimeOfImpact.set__s_xfA,
  configurable: true}});


Box2D.Collision.b2TimeOfImpact.get__s_xfB = function() {
  var value = new Box2D.Common.Math.b2Transform();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_xfB: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_xfB = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_xfB: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Common.Math.b2Transform}
 */
Box2D.Collision.b2TimeOfImpact.s_xfB;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Common.Math.b2Transform}
 */
s_xfB: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_xfB,
  set: Box2D.Collision.b2TimeOfImpact.set__s_xfB,
  configurable: true}});


Box2D.Collision.b2TimeOfImpact.get__s_fcn = function() {
  var value = new Box2D.Collision.b2SeparationFunction();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_fcn: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_fcn = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_fcn: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Collision.b2SeparationFunction}
 */
Box2D.Collision.b2TimeOfImpact.s_fcn;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Collision.b2SeparationFunction}
 */
s_fcn: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_fcn,
  set: Box2D.Collision.b2TimeOfImpact.set__s_fcn,
  configurable: true}});


Box2D.Collision.b2TimeOfImpact.get__s_distanceOutput = function() {
  var value = new Box2D.Collision.b2DistanceOutput();
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_distanceOutput: { value: value, writable: true }});
  return value;
};
Box2D.Collision.b2TimeOfImpact.set__s_distanceOutput = function(value) {
  Object.defineProperties(Box2D.Collision.b2TimeOfImpact, { s_distanceOutput: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Collision.b2DistanceOutput}
 */
Box2D.Collision.b2TimeOfImpact.s_distanceOutput;

Object.defineProperties(Box2D.Collision.b2TimeOfImpact, /** @lends {Box2D.Collision.b2TimeOfImpact} */ {
/**
 * @private
 * @type {Box2D.Collision.b2DistanceOutput}
 */
s_distanceOutput: {
  get: Box2D.Collision.b2TimeOfImpact.get__s_distanceOutput,
  set: Box2D.Collision.b2TimeOfImpact.set__s_distanceOutput,
  configurable: true}});


/**
 * @nocollapse
 * @param {Box2D.Collision.b2TOIInput} input
 * @return {number}
 */
Box2D.Collision.b2TimeOfImpact.TimeOfImpact = function(input) {
  var /** @type {number} */ x = NaN;
  ++Box2D.Collision.b2TimeOfImpact.b2_toiCalls;
  var /** @type {Box2D.Collision.b2DistanceProxy} */ proxyA = input.proxyA;
  var /** @type {Box2D.Collision.b2DistanceProxy} */ proxyB = input.proxyB;
  var /** @type {Box2D.Common.Math.b2Sweep} */ sweepA = input.sweepA;
  var /** @type {Box2D.Common.Math.b2Sweep} */ sweepB = input.sweepB;
  Box2D.Common.b2Settings.b2Assert(sweepA.t0 == sweepB.t0);
  Box2D.Common.b2Settings.b2Assert(1.0 - sweepA.t0 > Number.MIN_VALUE);
  var /** @type {number} */ radius = proxyA.m_radius + proxyB.m_radius;
  var /** @type {number} */ tolerance = input.tolerance;
  var /** @type {number} */ alpha = 0.0;
  
/**
 * @const
 * @type {number}
 */
var k_maxIterations = 1000;
  var /** @type {number} */ iter = 0;
  var /** @type {number} */ target = 0.0;
  Box2D.Collision.b2TimeOfImpact.s_cache.count = 0;
  Box2D.Collision.b2TimeOfImpact.s_distanceInput.useRadii = false;
  for (;;) {
    sweepA.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfA, alpha);
    sweepB.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfB, alpha);
    Box2D.Collision.b2TimeOfImpact.s_distanceInput.proxyA = proxyA;
    Box2D.Collision.b2TimeOfImpact.s_distanceInput.proxyB = proxyB;
    Box2D.Collision.b2TimeOfImpact.s_distanceInput.transformA = Box2D.Collision.b2TimeOfImpact.s_xfA;
    Box2D.Collision.b2TimeOfImpact.s_distanceInput.transformB = Box2D.Collision.b2TimeOfImpact.s_xfB;
    Box2D.Collision.b2Distance.Distance(Box2D.Collision.b2TimeOfImpact.s_distanceOutput, Box2D.Collision.b2TimeOfImpact.s_cache, Box2D.Collision.b2TimeOfImpact.s_distanceInput);
    if (Box2D.Collision.b2TimeOfImpact.s_distanceOutput.distance <= 0.0) {
      alpha = 1.0;
      break;
    }
    Box2D.Collision.b2TimeOfImpact.s_fcn.Initialize(Box2D.Collision.b2TimeOfImpact.s_cache, proxyA, Box2D.Collision.b2TimeOfImpact.s_xfA, proxyB, Box2D.Collision.b2TimeOfImpact.s_xfB);
    var /** @type {number} */ separation = Box2D.Collision.b2TimeOfImpact.s_fcn.Evaluate(Box2D.Collision.b2TimeOfImpact.s_xfA, Box2D.Collision.b2TimeOfImpact.s_xfB);
    if (separation <= 0.0) {
      alpha = 1.0;
      break;
    }
    if (iter == 0) {
      if (separation > radius) {
        target = Box2D.Common.Math.b2Math.Max(radius - tolerance, 0.75 * radius);
      } else {
        target = Box2D.Common.Math.b2Math.Max(separation - tolerance, 0.02 * radius);
      }
    }
    if (separation - target < 0.5 * tolerance) {
      if (iter == 0) {
        alpha = 1.0;
        break;
      }
      break;
    }
    var /** @type {number} */ newAlpha = alpha;
    var /** @type {number} */ x1 = alpha;
    var /** @type {number} */ x2 = 1.0;
    var /** @type {number} */ f1 = separation;
    sweepA.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfA, x2);
    sweepB.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfB, x2);
    var /** @type {number} */ f2 = Box2D.Collision.b2TimeOfImpact.s_fcn.Evaluate(Box2D.Collision.b2TimeOfImpact.s_xfA, Box2D.Collision.b2TimeOfImpact.s_xfB);
    if (f2 >= target) {
      alpha = 1.0;
      break;
    }
    var /** @type {number} */ rootIterCount = 0;
    for (;;) {
      //var /** @type {number} */ x = NaN;
      if (rootIterCount & 1) {
        x = x1 + (target - f1) * (x2 - x1) / (f2 - f1);
      } else {
        x = 0.5 * (x1 + x2);
      }
      sweepA.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfA, x);
      sweepB.GetTransform(Box2D.Collision.b2TimeOfImpact.s_xfB, x);
      var /** @type {number} */ f = Box2D.Collision.b2TimeOfImpact.s_fcn.Evaluate(Box2D.Collision.b2TimeOfImpact.s_xfA, Box2D.Collision.b2TimeOfImpact.s_xfB);
      if (Box2D.Common.Math.b2Math.Abs(f - target) < 0.025 * tolerance) {
        newAlpha = x;
        break;
      }
      if (f > target) {
        x1 = x;
        f1 = f;
      } else {
        x2 = x;
        f2 = f;
      }
      ++rootIterCount;
      ++Box2D.Collision.b2TimeOfImpact.b2_toiRootIters;
      if (rootIterCount == 50) {
        break;
      }
    }
    Box2D.Collision.b2TimeOfImpact.b2_toiMaxRootIters = (Box2D.Common.Math.b2Math.Max(Box2D.Collision.b2TimeOfImpact.b2_toiMaxRootIters, rootIterCount)) >> 0;
    if (newAlpha < (1.0 + 100.0 * Number.MIN_VALUE) * alpha) {
      break;
    }
    alpha = newAlpha;
    iter++;
    ++Box2D.Collision.b2TimeOfImpact.b2_toiIters;
    if (iter == k_maxIterations) {
      break;
    }
  }
  Box2D.Collision.b2TimeOfImpact.b2_toiMaxIters = (Box2D.Common.Math.b2Math.Max(Box2D.Collision.b2TimeOfImpact.b2_toiMaxIters, iter)) >> 0;
  return alpha;
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Collision.b2TimeOfImpact.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2TimeOfImpact', qName: 'Box2D.Collision.b2TimeOfImpact', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Collision.b2TimeOfImpact.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    methods: function () {
      return {
        '|TimeOfImpact': { type: 'Number', declaredBy: 'Box2D.Collision.b2TimeOfImpact', parameters: function () { return [ 'Box2D.Collision.b2TOIInput', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Collision.b2TimeOfImpact.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Collision.b2TimeOfImpact.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Collision.b2TimeOfImpact);