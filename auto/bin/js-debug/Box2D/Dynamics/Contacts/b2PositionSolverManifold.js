/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Contacts/b2PositionSolverManifold.as
 * Box2D.Dynamics.Contacts.b2PositionSolverManifold
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Contacts.b2PositionSolverManifold');
/* Royale Dependency List: Box2D.Collision.b2Manifold,Box2D.Common.Math.b2Mat22,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,Box2D.Dynamics.Contacts.b2ContactConstraint*/




/**
 * @constructor
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold = function() {
  this.m_normal = new Box2D.Common.Math.b2Vec2();
  this.m_separations = new Array(Box2D.Common.b2Settings.b2_maxManifoldPoints);
  this.m_points = new Array(Box2D.Common.b2Settings.b2_maxManifoldPoints);
  for (var /** @type {number} */ i = 0; i < Box2D.Common.b2Settings.b2_maxManifoldPoints; i++) {
    this.m_points[i] = new Box2D.Common.Math.b2Vec2();
  }
};


Box2D.Dynamics.Contacts.b2PositionSolverManifold.get__circlePointA = function() {
  var value = new Box2D.Common.Math.b2Vec2();
  Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, { circlePointA: { value: value, writable: true }});
  return value;
};
Box2D.Dynamics.Contacts.b2PositionSolverManifold.set__circlePointA = function(value) {
  Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, { circlePointA: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.circlePointA;

Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, /** @lends {Box2D.Dynamics.Contacts.b2PositionSolverManifold} */ {
/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
circlePointA: {
  get: Box2D.Dynamics.Contacts.b2PositionSolverManifold.get__circlePointA,
  set: Box2D.Dynamics.Contacts.b2PositionSolverManifold.set__circlePointA,
  configurable: true}});


Box2D.Dynamics.Contacts.b2PositionSolverManifold.get__circlePointB = function() {
  var value = new Box2D.Common.Math.b2Vec2();
  Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, { circlePointB: { value: value, writable: true }});
  return value;
};
Box2D.Dynamics.Contacts.b2PositionSolverManifold.set__circlePointB = function(value) {
  Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, { circlePointB: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.circlePointB;

Object.defineProperties(Box2D.Dynamics.Contacts.b2PositionSolverManifold, /** @lends {Box2D.Dynamics.Contacts.b2PositionSolverManifold} */ {
/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
circlePointB: {
  get: Box2D.Dynamics.Contacts.b2PositionSolverManifold.get__circlePointB,
  set: Box2D.Dynamics.Contacts.b2PositionSolverManifold.set__circlePointB,
  configurable: true}});


/**
 * @param {Box2D.Dynamics.Contacts.b2ContactConstraint} cc
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.Initialize = function(cc) {
  var /** @type {number} */ i = 0;
  var /** @type {number} */ clipPointX = NaN;
  var /** @type {number} */ clipPointY = NaN;
  var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ planePointY = NaN;
  var /** @type {number} */ planePointX = NaN;
  Box2D.Common.b2Settings.b2Assert(cc.pointCount > 0);
  //var /** @type {number} */ i = 0;
  //var /** @type {number} */ clipPointX = NaN;
  //var /** @type {number} */ clipPointY = NaN;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  //var /** @type {number} */ planePointX = NaN;
  //var /** @type {number} */ planePointY = NaN;
  switch (cc.type) {
    case Box2D.Collision.b2Manifold.e_circles:
      tMat = cc.bodyA.m_xf.R;
      tVec = cc.localPoint;
      var /** @type {number} */ pointAX = cc.bodyA.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
      var /** @type {number} */ pointAY = cc.bodyA.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
      tMat = cc.bodyB.m_xf.R;
      tVec = cc.points[0].localPoint;
      var /** @type {number} */ pointBX = cc.bodyB.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
      var /** @type {number} */ pointBY = cc.bodyB.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
      var /** @type {number} */ dX = pointBX - pointAX;
      var /** @type {number} */ dY = pointBY - pointAY;
      var /** @type {number} */ d2 = dX * dX + dY * dY;
      if (d2 > Number.MIN_VALUE * Number.MIN_VALUE) {
        var /** @type {number} */ d = Math.sqrt(d2);
        this.m_normal.x = dX / d;
        this.m_normal.y = dY / d;
      } else {
        this.m_normal.x = 1.0;
        this.m_normal.y = 0.0;
      }
      this.m_points[0].x = 0.5 * (pointAX + pointBX);
      this.m_points[0].y = 0.5 * (pointAY + pointBY);
      this.m_separations[0] = dX * this.m_normal.x + dY * this.m_normal.y - cc.radius;
      break;
    case Box2D.Collision.b2Manifold.e_faceA:
      tMat = cc.bodyA.m_xf.R;
      tVec = cc.localPlaneNormal;
      this.m_normal.x = tMat.col1.x * tVec.x + tMat.col2.x * tVec.y;
      this.m_normal.y = tMat.col1.y * tVec.x + tMat.col2.y * tVec.y;
      tMat = cc.bodyA.m_xf.R;
      tVec = cc.localPoint;
      planePointX = cc.bodyA.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
      planePointY = cc.bodyA.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
      tMat = cc.bodyB.m_xf.R;
      for (i = 0; i < cc.pointCount; ++i) {
        tVec = cc.points[i].localPoint;
        clipPointX = cc.bodyB.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
        clipPointY = cc.bodyB.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
        this.m_separations[i] = (clipPointX - planePointX) * this.m_normal.x + (clipPointY - planePointY) * this.m_normal.y - cc.radius;
        this.m_points[i].x = clipPointX;
        this.m_points[i].y = clipPointY;
      }
      break;
    case Box2D.Collision.b2Manifold.e_faceB:
      tMat = cc.bodyB.m_xf.R;
      tVec = cc.localPlaneNormal;
      this.m_normal.x = tMat.col1.x * tVec.x + tMat.col2.x * tVec.y;
      this.m_normal.y = tMat.col1.y * tVec.x + tMat.col2.y * tVec.y;
      tMat = cc.bodyB.m_xf.R;
      tVec = cc.localPoint;
      planePointX = cc.bodyB.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
      planePointY = cc.bodyB.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
      tMat = cc.bodyA.m_xf.R;
      for (i = 0; i < cc.pointCount; ++i) {
        tVec = cc.points[i].localPoint;
        clipPointX = cc.bodyA.m_xf.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
        clipPointY = cc.bodyA.m_xf.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
        this.m_separations[i] = (clipPointX - planePointX) * this.m_normal.x + (clipPointY - planePointY) * this.m_normal.y - cc.radius;
        this.m_points[i].Set(clipPointX, clipPointY);
      }
      this.m_normal.x *= -1;
      this.m_normal.y *= -1;
      break;
  }
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.m_normal = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.m_points = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.m_separations = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2PositionSolverManifold', qName: 'Box2D.Dynamics.Contacts.b2PositionSolverManifold', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_normal': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Contacts.b2PositionSolverManifold */ inst, /** * */ v) {return v !== undefined ? inst.m_normal = v : inst.m_normal;}},
        'm_points': { type: 'Array', get_set: function (/** Box2D.Dynamics.Contacts.b2PositionSolverManifold */ inst, /** * */ v) {return v !== undefined ? inst.m_points = v : inst.m_points;}},
        'm_separations': { type: 'Array', get_set: function (/** Box2D.Dynamics.Contacts.b2PositionSolverManifold */ inst, /** * */ v) {return v !== undefined ? inst.m_separations = v : inst.m_separations;}}
      };
    },
    methods: function () {
      return {
        'b2PositionSolverManifold': { type: '', declaredBy: 'Box2D.Dynamics.Contacts.b2PositionSolverManifold'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2PositionSolverManifold', parameters: function () { return [ 'Box2D.Dynamics.Contacts.b2ContactConstraint', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Dynamics.Contacts.b2PositionSolverManifold.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Dynamics.Contacts.b2PositionSolverManifold);