/**
 * Generated by Apache Royale Compiler from Box2D/Collision/b2Manifold.as
 * Box2D.Collision.b2Manifold
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Collision.b2Manifold');
/* Royale Dependency List: Box2D.Collision.b2ManifoldPoint,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,org.apache.royale.utils.Language*/




/**
 * @constructor
 */
Box2D.Collision.b2Manifold = function() {
  this.m_points = new Array(Box2D.Common.b2Settings.b2_maxManifoldPoints);
  for (var /** @type {number} */ i = 0; i < Box2D.Common.b2Settings.b2_maxManifoldPoints; i++) {
    this.m_points[i] = new Box2D.Collision.b2ManifoldPoint();
  }
  this.m_localPlaneNormal = new Box2D.Common.Math.b2Vec2();
  this.m_localPoint = new Box2D.Common.Math.b2Vec2();
};


/**
 */
Box2D.Collision.b2Manifold.prototype.Reset = function() {
  for (var /** @type {number} */ i = 0; i < Box2D.Common.b2Settings.b2_maxManifoldPoints; i++) {
    this.m_points[i].Reset();
  }
  this.m_localPlaneNormal.SetZero();
  this.m_localPoint.SetZero();
  this.m_type = 0;
  this.m_pointCount = 0;
};


/**
 * @param {Box2D.Collision.b2Manifold} m
 */
Box2D.Collision.b2Manifold.prototype.Set = function(m) {
  this.m_pointCount = m.m_pointCount;
  for (var /** @type {number} */ i = 0; i < Box2D.Common.b2Settings.b2_maxManifoldPoints; i++) {
    this.m_points[i].Set(/* implicit cast */ org.apache.royale.utils.Language.as(m.m_points[i], Box2D.Collision.b2ManifoldPoint, true));
  }
  this.m_localPlaneNormal.SetV(m.m_localPlaneNormal);
  this.m_localPoint.SetV(m.m_localPoint);
  this.m_type = m.m_type;
};


/**
 * @return {Box2D.Collision.b2Manifold}
 */
Box2D.Collision.b2Manifold.prototype.Copy = function() {
  var /** @type {Box2D.Collision.b2Manifold} */ copy = new Box2D.Collision.b2Manifold();
  copy.Set(this);
  return copy;
};


/**
 * @type {Array}
 */
Box2D.Collision.b2Manifold.prototype.m_points = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Collision.b2Manifold.prototype.m_localPlaneNormal = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Collision.b2Manifold.prototype.m_localPoint = null;


/**
 * @type {number}
 */
Box2D.Collision.b2Manifold.prototype.m_type = 0;


/**
 * @type {number}
 */
Box2D.Collision.b2Manifold.prototype.m_pointCount = 0;


/**
 * @nocollapse
 * @const
 * @type {number}
 */
Box2D.Collision.b2Manifold.e_circles = 0x1;


/**
 * @nocollapse
 * @const
 * @type {number}
 */
Box2D.Collision.b2Manifold.e_faceA = 0x2;


/**
 * @nocollapse
 * @const
 * @type {number}
 */
Box2D.Collision.b2Manifold.e_faceB = 0x4;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Collision.b2Manifold.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2Manifold', qName: 'Box2D.Collision.b2Manifold', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Collision.b2Manifold.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_points': { type: 'Array', get_set: function (/** Box2D.Collision.b2Manifold */ inst, /** * */ v) {return v !== undefined ? inst.m_points = v : inst.m_points;}},
        'm_localPlaneNormal': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Collision.b2Manifold */ inst, /** * */ v) {return v !== undefined ? inst.m_localPlaneNormal = v : inst.m_localPlaneNormal;}},
        'm_localPoint': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Collision.b2Manifold */ inst, /** * */ v) {return v !== undefined ? inst.m_localPoint = v : inst.m_localPoint;}},
        'm_type': { type: 'int', get_set: function (/** Box2D.Collision.b2Manifold */ inst, /** * */ v) {return v !== undefined ? inst.m_type = v : inst.m_type;}},
        'm_pointCount': { type: 'int', get_set: function (/** Box2D.Collision.b2Manifold */ inst, /** * */ v) {return v !== undefined ? inst.m_pointCount = v : inst.m_pointCount;}}
      };
    },
    methods: function () {
      return {
        'b2Manifold': { type: '', declaredBy: 'Box2D.Collision.b2Manifold'},
        'Reset': { type: 'void', declaredBy: 'Box2D.Collision.b2Manifold'},
        'Set': { type: 'void', declaredBy: 'Box2D.Collision.b2Manifold', parameters: function () { return [ 'Box2D.Collision.b2Manifold', false ]; }},
        'Copy': { type: 'Box2D.Collision.b2Manifold', declaredBy: 'Box2D.Collision.b2Manifold'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Collision.b2Manifold.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Collision.b2Manifold.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Collision.b2Manifold);
