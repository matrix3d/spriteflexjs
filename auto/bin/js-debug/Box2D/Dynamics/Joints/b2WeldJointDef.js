/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Joints/b2WeldJointDef.as
 * Box2D.Dynamics.Joints.b2WeldJointDef
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Joints.b2WeldJointDef');
/* Royale Dependency List: Box2D.Common.Math.b2Vec2,Box2D.Dynamics.Joints.b2Joint,Box2D.Dynamics.b2Body*/

goog.require('Box2D.Dynamics.Joints.b2JointDef');



/**
 * @constructor
 * @extends {Box2D.Dynamics.Joints.b2JointDef}
 */
Box2D.Dynamics.Joints.b2WeldJointDef = function() {
  Box2D.Dynamics.Joints.b2WeldJointDef.base(this, 'constructor');
  
  this.localAnchorA = new Box2D.Common.Math.b2Vec2();
  this.localAnchorB = new Box2D.Common.Math.b2Vec2();
  this.type = Box2D.Dynamics.Joints.b2Joint.e_weldJoint;
  this.referenceAngle = 0.0;
};
goog.inherits(Box2D.Dynamics.Joints.b2WeldJointDef, Box2D.Dynamics.Joints.b2JointDef);


/**
 * Initialize the bodies, anchors, axis, and reference angle using the world
 * anchor and world axis.
 * @param {Box2D.Dynamics.b2Body} bA
 * @param {Box2D.Dynamics.b2Body} bB
 * @param {Box2D.Common.Math.b2Vec2} anchor
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.Initialize = function(bA, bB, anchor) {
  this.bodyA = bA;
  this.bodyB = bB;
  this.localAnchorA.SetV(this.bodyA.GetLocalPoint(anchor));
  this.localAnchorB.SetV(this.bodyB.GetLocalPoint(anchor));
  this.referenceAngle = this.bodyB.GetAngle() - this.bodyA.GetAngle();
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.localAnchorA = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.localAnchorB = null;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.referenceAngle = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2WeldJointDef', qName: 'Box2D.Dynamics.Joints.b2WeldJointDef', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'localAnchorA': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2WeldJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorA = v : inst.localAnchorA;}},
        'localAnchorB': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2WeldJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorB = v : inst.localAnchorB;}},
        'referenceAngle': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2WeldJointDef */ inst, /** * */ v) {return v !== undefined ? inst.referenceAngle = v : inst.referenceAngle;}}
      };
    },
    methods: function () {
      return {
        'b2WeldJointDef': { type: '', declaredBy: 'Box2D.Dynamics.Joints.b2WeldJointDef'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2WeldJointDef', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ,'Box2D.Dynamics.b2Body', false ,'Box2D.Common.Math.b2Vec2', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2WeldJointDef.prototype.ROYALE_COMPILE_FLAGS = 9;
