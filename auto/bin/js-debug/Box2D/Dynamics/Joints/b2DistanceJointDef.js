/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Joints/b2DistanceJointDef.as
 * Box2D.Dynamics.Joints.b2DistanceJointDef
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Joints.b2DistanceJointDef');
/* Royale Dependency List: Box2D.Common.Math.b2Vec2,Box2D.Dynamics.Joints.b2Joint,Box2D.Dynamics.b2Body*/

goog.require('Box2D.Dynamics.Joints.b2JointDef');



/**
 * @constructor
 * @extends {Box2D.Dynamics.Joints.b2JointDef}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef = function() {
  Box2D.Dynamics.Joints.b2DistanceJointDef.base(this, 'constructor');
  
  this.localAnchorA = new Box2D.Common.Math.b2Vec2();
  this.localAnchorB = new Box2D.Common.Math.b2Vec2();
  this.type = Box2D.Dynamics.Joints.b2Joint.e_distanceJoint;
  this.length = 1.0;
  this.frequencyHz = 0.0;
  this.dampingRatio = 0.0;
};
goog.inherits(Box2D.Dynamics.Joints.b2DistanceJointDef, Box2D.Dynamics.Joints.b2JointDef);


/**
 * Initialize the bodies, anchors, and length using the world
 * anchors.
 * @param {Box2D.Dynamics.b2Body} bA
 * @param {Box2D.Dynamics.b2Body} bB
 * @param {Box2D.Common.Math.b2Vec2} anchorA
 * @param {Box2D.Common.Math.b2Vec2} anchorB
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.Initialize = function(bA, bB, anchorA, anchorB) {
  this.bodyA = bA;
  this.bodyB = bB;
  this.localAnchorA.SetV(this.bodyA.GetLocalPoint(anchorA));
  this.localAnchorB.SetV(this.bodyB.GetLocalPoint(anchorB));
  var /** @type {number} */ dX = anchorB.x - anchorA.x;
  var /** @type {number} */ dY = anchorB.y - anchorA.y;
  this.length = Math.sqrt(dX * dX + dY * dY);
  this.frequencyHz = 0.0;
  this.dampingRatio = 0.0;
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.localAnchorA = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.localAnchorB = null;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.length = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.frequencyHz = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.dampingRatio = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2DistanceJointDef', qName: 'Box2D.Dynamics.Joints.b2DistanceJointDef', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'localAnchorA': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2DistanceJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorA = v : inst.localAnchorA;}},
        'localAnchorB': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2DistanceJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorB = v : inst.localAnchorB;}},
        'length': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2DistanceJointDef */ inst, /** * */ v) {return v !== undefined ? inst.length = v : inst.length;}},
        'frequencyHz': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2DistanceJointDef */ inst, /** * */ v) {return v !== undefined ? inst.frequencyHz = v : inst.frequencyHz;}},
        'dampingRatio': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2DistanceJointDef */ inst, /** * */ v) {return v !== undefined ? inst.dampingRatio = v : inst.dampingRatio;}}
      };
    },
    methods: function () {
      return {
        'b2DistanceJointDef': { type: '', declaredBy: 'Box2D.Dynamics.Joints.b2DistanceJointDef'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2DistanceJointDef', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ,'Box2D.Dynamics.b2Body', false ,'Box2D.Common.Math.b2Vec2', false ,'Box2D.Common.Math.b2Vec2', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2DistanceJointDef.prototype.ROYALE_COMPILE_FLAGS = 9;