/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Joints/b2RevoluteJointDef.as
 * Box2D.Dynamics.Joints.b2RevoluteJointDef
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Joints.b2RevoluteJointDef');
/* Royale Dependency List: Box2D.Common.Math.b2Vec2,Box2D.Dynamics.Joints.b2Joint,Box2D.Dynamics.b2Body*/

goog.require('Box2D.Dynamics.Joints.b2JointDef');



/**
 * @constructor
 * @extends {Box2D.Dynamics.Joints.b2JointDef}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef = function() {
  Box2D.Dynamics.Joints.b2RevoluteJointDef.base(this, 'constructor');
  
  this.localAnchorA = new Box2D.Common.Math.b2Vec2();
  this.localAnchorB = new Box2D.Common.Math.b2Vec2();
  this.type = Box2D.Dynamics.Joints.b2Joint.e_revoluteJoint;
  this.localAnchorA.Set(0.0, 0.0);
  this.localAnchorB.Set(0.0, 0.0);
  this.referenceAngle = 0.0;
  this.lowerAngle = 0.0;
  this.upperAngle = 0.0;
  this.maxMotorTorque = 0.0;
  this.motorSpeed = 0.0;
  this.enableLimit = false;
  this.enableMotor = false;
};
goog.inherits(Box2D.Dynamics.Joints.b2RevoluteJointDef, Box2D.Dynamics.Joints.b2JointDef);


/**
 * Initialize the bodies, anchors, and reference angle using the world
 * anchor.
 * @param {Box2D.Dynamics.b2Body} bA
 * @param {Box2D.Dynamics.b2Body} bB
 * @param {Box2D.Common.Math.b2Vec2} anchor
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.Initialize = function(bA, bB, anchor) {
  this.bodyA = bA;
  this.bodyB = bB;
  this.localAnchorA = this.bodyA.GetLocalPoint(anchor);
  this.localAnchorB = this.bodyB.GetLocalPoint(anchor);
  this.referenceAngle = this.bodyB.GetAngle() - this.bodyA.GetAngle();
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.localAnchorA = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.localAnchorB = null;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.referenceAngle = NaN;


/**
 * @type {boolean}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.enableLimit = false;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.lowerAngle = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.upperAngle = NaN;


/**
 * @type {boolean}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.enableMotor = false;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.motorSpeed = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.maxMotorTorque = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2RevoluteJointDef', qName: 'Box2D.Dynamics.Joints.b2RevoluteJointDef', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'localAnchorA': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorA = v : inst.localAnchorA;}},
        'localAnchorB': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.localAnchorB = v : inst.localAnchorB;}},
        'referenceAngle': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.referenceAngle = v : inst.referenceAngle;}},
        'enableLimit': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.enableLimit = v : inst.enableLimit;}},
        'lowerAngle': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.lowerAngle = v : inst.lowerAngle;}},
        'upperAngle': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.upperAngle = v : inst.upperAngle;}},
        'enableMotor': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.enableMotor = v : inst.enableMotor;}},
        'motorSpeed': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.motorSpeed = v : inst.motorSpeed;}},
        'maxMotorTorque': { type: 'Number', get_set: function (/** Box2D.Dynamics.Joints.b2RevoluteJointDef */ inst, /** * */ v) {return v !== undefined ? inst.maxMotorTorque = v : inst.maxMotorTorque;}}
      };
    },
    methods: function () {
      return {
        'b2RevoluteJointDef': { type: '', declaredBy: 'Box2D.Dynamics.Joints.b2RevoluteJointDef'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2RevoluteJointDef', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ,'Box2D.Dynamics.b2Body', false ,'Box2D.Common.Math.b2Vec2', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2RevoluteJointDef.prototype.ROYALE_COMPILE_FLAGS = 9;
