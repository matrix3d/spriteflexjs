/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Joints/b2LineJoint.as
 * Box2D.Dynamics.Joints.b2LineJoint
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Joints.b2LineJoint');
/* Royale Dependency List: Box2D.Common.Math.b2Mat22,Box2D.Common.Math.b2Math,Box2D.Common.Math.b2Transform,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,Box2D.Dynamics.Joints.b2LineJointDef,Box2D.Dynamics.b2Body,Box2D.Dynamics.b2TimeStep*/

goog.require('Box2D.Dynamics.Joints.b2Joint');



/** @asprivate 
 * @constructor
 * @extends {Box2D.Dynamics.Joints.b2Joint}
 * @param {Box2D.Dynamics.Joints.b2LineJointDef} def
 */
Box2D.Dynamics.Joints.b2LineJoint = function(def) {
  
  this.m_localAnchor1 = new Box2D.Common.Math.b2Vec2();
  this.m_localAnchor2 = new Box2D.Common.Math.b2Vec2();
  this.m_localXAxis1 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_axis = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_perp = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_K = new Box2D.Common.Math.b2Mat22();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse = new Box2D.Common.Math.b2Vec2();
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ tY = NaN;
  Box2D.Dynamics.Joints.b2LineJoint.base(this, 'constructor', def);
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ tX = NaN;
  //var /** @type {number} */ tY = NaN;
  this.m_localAnchor1.SetV(def.localAnchorA);
  this.m_localAnchor2.SetV(def.localAnchorB);
  this.m_localXAxis1.SetV(def.localAxisA);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1.x = -this.m_localXAxis1.y;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1.y = this.m_localXAxis1.x;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.SetZero();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass = 0.0;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse = 0.0;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation = def.lowerTranslation;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation = def.upperTranslation;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_maxMotorForce = def.maxMotorForce;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorSpeed = def.motorSpeed;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit = def.enableLimit;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor = def.enableMotor;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.SetZero();
  this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.SetZero();
};
goog.inherits(Box2D.Dynamics.Joints.b2LineJoint, Box2D.Dynamics.Joints.b2Joint);


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetAnchorA = function() {
  return this.m_bodyA.GetWorldPoint(this.m_localAnchor1);
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetAnchorB = function() {
  return this.m_bodyB.GetWorldPoint(this.m_localAnchor2);
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetReactionForce = function(inv_dt) {
  return new Box2D.Common.Math.b2Vec2(inv_dt * (this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x), inv_dt * (this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y));
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetReactionTorque = function(inv_dt) {
  return inv_dt * this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y;
};


/**
 * Get the current joint translation, usually in meters.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetJointTranslation = function() {
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {Box2D.Common.Math.b2Vec2} */ p1 = bA.GetWorldPoint(this.m_localAnchor1);
  var /** @type {Box2D.Common.Math.b2Vec2} */ p2 = bB.GetWorldPoint(this.m_localAnchor2);
  var /** @type {number} */ dX = p2.x - p1.x;
  var /** @type {number} */ dY = p2.y - p1.y;
  var /** @type {Box2D.Common.Math.b2Vec2} */ axis = bA.GetWorldVector(this.m_localXAxis1);
  var /** @type {number} */ translation = axis.x * dX + axis.y * dY;
  return translation;
};


/**
 * Get the current joint translation speed, usually in meters per second.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetJointSpeed = function() {
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  tMat = bA.m_xf.R;
  var /** @type {number} */ r1X = this.m_localAnchor1.x - bA.m_sweep.localCenter.x;
  var /** @type {number} */ r1Y = this.m_localAnchor1.y - bA.m_sweep.localCenter.y;
  var /** @type {number} */ tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
  r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
  r1X = tX;
  tMat = bB.m_xf.R;
  var /** @type {number} */ r2X = this.m_localAnchor2.x - bB.m_sweep.localCenter.x;
  var /** @type {number} */ r2Y = this.m_localAnchor2.y - bB.m_sweep.localCenter.y;
  tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
  r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
  r2X = tX;
  var /** @type {number} */ p1X = bA.m_sweep.c.x + r1X;
  var /** @type {number} */ p1Y = bA.m_sweep.c.y + r1Y;
  var /** @type {number} */ p2X = bB.m_sweep.c.x + r2X;
  var /** @type {number} */ p2Y = bB.m_sweep.c.y + r2Y;
  var /** @type {number} */ dX = p2X - p1X;
  var /** @type {number} */ dY = p2Y - p1Y;
  var /** @type {Box2D.Common.Math.b2Vec2} */ axis = bA.GetWorldVector(this.m_localXAxis1);
  var /** @type {Box2D.Common.Math.b2Vec2} */ v1 = bA.m_linearVelocity;
  var /** @type {Box2D.Common.Math.b2Vec2} */ v2 = bB.m_linearVelocity;
  var /** @type {number} */ w1 = bA.m_angularVelocity;
  var /** @type {number} */ w2 = bB.m_angularVelocity;
  var /** @type {number} */ speed = (dX * (-w1 * axis.y) + dY * (w1 * axis.x)) + (axis.x * (((v2.x + (-w2 * r2Y)) - v1.x) - (-w1 * r1Y)) + axis.y * (((v2.y + (w2 * r2X)) - v1.y) - (w1 * r1X)));
  return speed;
};


/**
 * Is the joint limit enabled?
 * @return {boolean}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.IsLimitEnabled = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit;
};


/**
 * Enable/disable the joint limit.
 * @param {boolean} flag
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.EnableLimit = function(flag) {
  this.m_bodyA.SetAwake(true);
  this.m_bodyB.SetAwake(true);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit = flag;
};


/**
 * Get the lower joint limit, usually in meters.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetLowerLimit = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation;
};


/**
 * Get the upper joint limit, usually in meters.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetUpperLimit = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation;
};


/**
 * Set the joint limits, usually in meters.
 * @param {number} lower
 * @param {number} upper
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.SetLimits = function(lower, upper) {
  this.m_bodyA.SetAwake(true);
  this.m_bodyB.SetAwake(true);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation = lower;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation = upper;
};


/**
 * Is the joint motor enabled?
 * @return {boolean}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.IsMotorEnabled = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor;
};


/**
 * Enable/disable the joint motor.
 * @param {boolean} flag
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.EnableMotor = function(flag) {
  this.m_bodyA.SetAwake(true);
  this.m_bodyB.SetAwake(true);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor = flag;
};


/**
 * Set the motor speed, usually in meters per second.
 * @param {number} speed
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.SetMotorSpeed = function(speed) {
  this.m_bodyA.SetAwake(true);
  this.m_bodyB.SetAwake(true);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorSpeed = speed;
};


/**
 * Get the motor speed, usually in meters per second.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetMotorSpeed = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_motorSpeed;
};


/**
 * Set the maximum motor force, usually in N.
 * @param {number} force
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.SetMaxMotorForce = function(force) {
  this.m_bodyA.SetAwake(true);
  this.m_bodyB.SetAwake(true);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_maxMotorForce = force;
};


/**
 * Get the maximum motor force, usually in N.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetMaxMotorForce = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_maxMotorForce;
};


/**
 * Get the current motor force, usually in N.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.GetMotorForce = function() {
  return this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse;
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.InitVelocityConstraints = function(step) {
  var /** @type {number} */ tX = NaN;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ tX = NaN;
  this.m_localCenterA.SetV(bA.GetLocalCenter());
  this.m_localCenterB.SetV(bB.GetLocalCenter());
  var /** @type {Box2D.Common.Math.b2Transform} */ xf1 = bA.GetTransform();
  var /** @type {Box2D.Common.Math.b2Transform} */ xf2 = bB.GetTransform();
  tMat = bA.m_xf.R;
  var /** @type {number} */ r1X = this.m_localAnchor1.x - this.m_localCenterA.x;
  var /** @type {number} */ r1Y = this.m_localAnchor1.y - this.m_localCenterA.y;
  tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
  r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
  r1X = tX;
  tMat = bB.m_xf.R;
  var /** @type {number} */ r2X = this.m_localAnchor2.x - this.m_localCenterB.x;
  var /** @type {number} */ r2Y = this.m_localAnchor2.y - this.m_localCenterB.y;
  tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
  r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
  r2X = tX;
  var /** @type {number} */ dX = bB.m_sweep.c.x + r2X - bA.m_sweep.c.x - r1X;
  var /** @type {number} */ dY = bB.m_sweep.c.y + r2Y - bA.m_sweep.c.y - r1Y;
  this.m_invMassA = bA.m_invMass;
  this.m_invMassB = bB.m_invMass;
  this.m_invIA = bA.m_invI;
  this.m_invIB = bB.m_invI;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.SetV(Box2D.Common.Math.b2Math.MulMV(xf1.R, this.m_localXAxis1));
  this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 = (dX + r1X) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y - (dY + r1Y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 = r2X * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y - r2Y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass = this.m_invMassA + this.m_invMassB + this.m_invIA * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 + this.m_invIB * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass = this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass > Number.MIN_VALUE ? 1.0 / this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass : 0.0;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.SetV(Box2D.Common.Math.b2Math.MulMV(xf1.R, this.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1));
  this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 = (dX + r1X) * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y - (dY + r1Y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 = r2X * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y - r2Y * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x;
  var /** @type {number} */ m1 = this.m_invMassA;
  var /** @type {number} */ m2 = this.m_invMassB;
  var /** @type {number} */ i1 = this.m_invIA;
  var /** @type {number} */ i2 = this.m_invIB;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x = m1 + m2 + i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.y = i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col2.x = this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.y;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col2.y = m1 + m2 + i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
  if (this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit) {
    var /** @type {number} */ jointTransition = this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x * dX + this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y * dY;
    if (Box2D.Common.Math.b2Math.Abs(this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation - this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation) < 2.0 * Box2D.Common.b2Settings.b2_linearSlop) {
      this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_equalLimits;
    } else if (jointTransition <= this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation) {
      if (this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState != Box2D.Dynamics.Joints.b2Joint.e_atLowerLimit) {
        this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_atLowerLimit;
        this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y = 0.0;
      }
    } else if (jointTransition >= this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation) {
      if (this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState != Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
        this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit;
        this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y = 0.0;
      }
    } else {
      this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
      this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y = 0.0;
    }
  } else {
    this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
  }
  if (this.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor == false) {
    this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse = 0.0;
  }
  if (step.warmStarting) {
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x *= step.dtRatio;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y *= step.dtRatio;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse *= step.dtRatio;
    var /** @type {number} */ PX = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
    var /** @type {number} */ PY = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y;
    var /** @type {number} */ L1 = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1;
    var /** @type {number} */ L2 = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 + (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
    bA.m_linearVelocity.x -= this.m_invMassA * PX;
    bA.m_linearVelocity.y -= this.m_invMassA * PY;
    bA.m_angularVelocity -= this.m_invIA * L1;
    bB.m_linearVelocity.x += this.m_invMassB * PX;
    bB.m_linearVelocity.y += this.m_invMassB * PY;
    bB.m_angularVelocity += this.m_invIB * L2;
  } else {
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.SetZero();
    this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse = 0.0;
  }
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.SolveVelocityConstraints = function(step) {
  var /** @type {number} */ L1 = NaN;
  var /** @type {number} */ L2 = NaN;
  var /** @type {number} */ f2r = NaN;
  var /** @type {number} */ PX = NaN;
  var /** @type {number} */ PY = NaN;
  var /** @type {number} */ df2 = NaN;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  var /** @type {Box2D.Common.Math.b2Vec2} */ v1 = bA.m_linearVelocity;
  var /** @type {number} */ w1 = bA.m_angularVelocity;
  var /** @type {Box2D.Common.Math.b2Vec2} */ v2 = bB.m_linearVelocity;
  var /** @type {number} */ w2 = bB.m_angularVelocity;
  //var /** @type {number} */ PX = NaN;
  //var /** @type {number} */ PY = NaN;
  //var /** @type {number} */ L1 = NaN;
  //var /** @type {number} */ L2 = NaN;
  if (this.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor && this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState != Box2D.Dynamics.Joints.b2Joint.e_equalLimits) {
    var /** @type {number} */ Cdot = this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x * (v2.x - v1.x) + this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y * (v2.y - v1.y) + this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 * w2 - this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 * w1;
    var /** @type {number} */ impulse = this.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass * (this.Box2D_Dynamics_Joints_b2LineJoint_m_motorSpeed - Cdot);
    var /** @type {number} */ oldImpulse = this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse;
    var /** @type {number} */ maxImpulse = step.dt * this.Box2D_Dynamics_Joints_b2LineJoint_m_maxMotorForce;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse = Box2D.Common.Math.b2Math.Clamp(this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse + impulse, -maxImpulse, maxImpulse);
    impulse = this.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse - oldImpulse;
    PX = impulse * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
    PY = impulse * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y;
    L1 = impulse * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1;
    L2 = impulse * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
    v1.x -= this.m_invMassA * PX;
    v1.y -= this.m_invMassA * PY;
    w1 -= this.m_invIA * L1;
    v2.x += this.m_invMassB * PX;
    v2.y += this.m_invMassB * PY;
    w2 += this.m_invIB * L2;
  }
  var /** @type {number} */ Cdot1 = this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x * (v2.x - v1.x) + this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y * (v2.y - v1.y) + this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * w2 - this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * w1;
  if (this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit && this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState != Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit) {
    var /** @type {number} */ Cdot2 = this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x * (v2.x - v1.x) + this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y * (v2.y - v1.y) + this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 * w2 - this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 * w1;
    var /** @type {Box2D.Common.Math.b2Vec2} */ f1 = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.Copy();
    var /** @type {Box2D.Common.Math.b2Vec2} */ df = this.Box2D_Dynamics_Joints_b2LineJoint_m_K.Solve(new Box2D.Common.Math.b2Vec2(), -Cdot1, -Cdot2);
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.Add(df);
    if (this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState == Box2D.Dynamics.Joints.b2Joint.e_atLowerLimit) {
      this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y = Box2D.Common.Math.b2Math.Max(this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y, 0.0);
    } else if (this.Box2D_Dynamics_Joints_b2LineJoint_m_limitState == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
      this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y = Box2D.Common.Math.b2Math.Min(this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y, 0.0);
    }
    var /** @type {number} */ b = -Cdot1 - (this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y - f1.y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col2.x;
    //var /** @type {number} */ f2r = NaN;
    if (this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x != 0.0) {
      f2r = b / this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x + f1.x;
    } else {
      f2r = f1.x;
    }
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x = f2r;
    df.x = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x - f1.x;
    df.y = this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.y - f1.y;
    PX = df.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x + df.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
    PY = df.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y + df.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y;
    L1 = df.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + df.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1;
    L2 = df.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 + df.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
    v1.x -= this.m_invMassA * PX;
    v1.y -= this.m_invMassA * PY;
    w1 -= this.m_invIA * L1;
    v2.x += this.m_invMassB * PX;
    v2.y += this.m_invMassB * PY;
    w2 += this.m_invIB * L2;
  } else {
    //var /** @type {number} */ df2 = NaN;
    if (this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x != 0.0) {
      df2 = (-Cdot1) / this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x;
    } else {
      df2 = 0.0;
    }
    this.Box2D_Dynamics_Joints_b2LineJoint_m_impulse.x += df2;
    PX = df2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x;
    PY = df2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y;
    L1 = df2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1;
    L2 = df2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2;
    v1.x -= this.m_invMassA * PX;
    v1.y -= this.m_invMassA * PY;
    w1 -= this.m_invIA * L1;
    v2.x += this.m_invMassB * PX;
    v2.y += this.m_invMassB * PY;
    w2 += this.m_invIB * L2;
  }
  bA.m_linearVelocity.SetV(v1);
  bA.m_angularVelocity = w1;
  bB.m_linearVelocity.SetV(v2);
  bB.m_angularVelocity = w2;
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.SolvePositionConstraints = function(baumgarte) {
  var /** @type {number} */ oldLimitImpulse = NaN;
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ m1 = NaN;
  var /** @type {number} */ m2 = NaN;
  var /** @type {number} */ i1 = NaN;
  var /** @type {number} */ i2 = NaN;
  var /** @type {number} */ limitC = NaN;
  var /** @type {number} */ impulse1 = NaN;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ limitC = NaN;
  //var /** @type {number} */ oldLimitImpulse = NaN;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  var /** @type {Box2D.Common.Math.b2Vec2} */ c1 = bA.m_sweep.c;
  var /** @type {number} */ a1 = bA.m_sweep.a;
  var /** @type {Box2D.Common.Math.b2Vec2} */ c2 = bB.m_sweep.c;
  var /** @type {number} */ a2 = bB.m_sweep.a;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ tX = NaN;
  //var /** @type {number} */ m1 = NaN;
  //var /** @type {number} */ m2 = NaN;
  //var /** @type {number} */ i1 = NaN;
  //var /** @type {number} */ i2 = NaN;
  var /** @type {number} */ linearError = 0.0;
  var /** @type {number} */ angularError = 0.0;
  var /** @type {boolean} */ active = false;
  var /** @type {number} */ C2 = 0.0;
  var /** @type {Box2D.Common.Math.b2Mat22} */ R1 = Box2D.Common.Math.b2Mat22.FromAngle(a1);
  var /** @type {Box2D.Common.Math.b2Mat22} */ R2 = Box2D.Common.Math.b2Mat22.FromAngle(a2);
  tMat = R1;
  var /** @type {number} */ r1X = this.m_localAnchor1.x - this.m_localCenterA.x;
  var /** @type {number} */ r1Y = this.m_localAnchor1.y - this.m_localCenterA.y;
  tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
  r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
  r1X = tX;
  tMat = R2;
  var /** @type {number} */ r2X = this.m_localAnchor2.x - this.m_localCenterB.x;
  var /** @type {number} */ r2Y = this.m_localAnchor2.y - this.m_localCenterB.y;
  tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
  r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
  r2X = tX;
  var /** @type {number} */ dX = c2.x + r2X - c1.x - r1X;
  var /** @type {number} */ dY = c2.y + r2Y - c1.y - r1Y;
  if (this.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit) {
    this.Box2D_Dynamics_Joints_b2LineJoint_m_axis = Box2D.Common.Math.b2Math.MulMV(R1, this.m_localXAxis1);
    this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 = (dX + r1X) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y - (dY + r1Y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 = r2X * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y - r2Y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
    var /** @type {number} */ translation = this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x * dX + this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y * dY;
    if (Box2D.Common.Math.b2Math.Abs(this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation - this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation) < 2.0 * Box2D.Common.b2Settings.b2_linearSlop) {
      C2 = Box2D.Common.Math.b2Math.Clamp(translation, -Box2D.Common.b2Settings.b2_maxLinearCorrection, Box2D.Common.b2Settings.b2_maxLinearCorrection);
      linearError = Box2D.Common.Math.b2Math.Abs(translation);
      active = true;
    } else if (translation <= this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation) {
      C2 = Box2D.Common.Math.b2Math.Clamp(translation - this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation + Box2D.Common.b2Settings.b2_linearSlop, -Box2D.Common.b2Settings.b2_maxLinearCorrection, 0.0);
      linearError = this.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation - translation;
      active = true;
    } else if (translation >= this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation) {
      C2 = Box2D.Common.Math.b2Math.Clamp(translation - this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation + Box2D.Common.b2Settings.b2_linearSlop, 0.0, Box2D.Common.b2Settings.b2_maxLinearCorrection);
      linearError = translation - this.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation;
      active = true;
    }
  }
  this.Box2D_Dynamics_Joints_b2LineJoint_m_perp = Box2D.Common.Math.b2Math.MulMV(R1, this.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1);
  this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 = (dX + r1X) * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y - (dY + r1Y) * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x;
  this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 = r2X * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y - r2Y * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x;
  var /** @type {Box2D.Common.Math.b2Vec2} */ impulse = new Box2D.Common.Math.b2Vec2();
  var /** @type {number} */ C1 = this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x * dX + this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y * dY;
  linearError = Box2D.Common.Math.b2Math.Max(linearError, Box2D.Common.Math.b2Math.Abs(C1));
  angularError = 0.0;
  if (active) {
    m1 = this.m_invMassA;
    m2 = this.m_invMassB;
    i1 = this.m_invIA;
    i2 = this.m_invIB;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.x = m1 + m2 + i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.y = i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col2.x = this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col1.y;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_K.col2.y = m1 + m2 + i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
    this.Box2D_Dynamics_Joints_b2LineJoint_m_K.Solve(impulse, -C1, -C2);
  } else {
    m1 = this.m_invMassA;
    m2 = this.m_invMassB;
    i1 = this.m_invIA;
    i2 = this.m_invIB;
    var /** @type {number} */ k11 = m1 + m2 + i1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + i2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2;
    //var /** @type {number} */ impulse1 = NaN;
    if (k11 != 0.0) {
      impulse1 = (-C1) / k11;
    } else {
      impulse1 = 0.0;
    }
    impulse.x = impulse1;
    impulse.y = 0.0;
  }
  var /** @type {number} */ PX = impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.x + impulse.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.x;
  var /** @type {number} */ PY = impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_perp.y + impulse.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_axis.y;
  var /** @type {number} */ L1 = impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s1 + impulse.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_a1;
  var /** @type {number} */ L2 = impulse.x * this.Box2D_Dynamics_Joints_b2LineJoint_m_s2 + impulse.y * this.Box2D_Dynamics_Joints_b2LineJoint_m_a2;
  c1.x -= this.m_invMassA * PX;
  c1.y -= this.m_invMassA * PY;
  a1 -= this.m_invIA * L1;
  c2.x += this.m_invMassB * PX;
  c2.y += this.m_invMassB * PY;
  a2 += this.m_invIB * L2;
  bA.m_sweep.a = a1;
  bB.m_sweep.a = a2;
  bA.SynchronizeTransform();
  bB.SynchronizeTransform();
  return linearError <= Box2D.Common.b2Settings.b2_linearSlop && angularError <= Box2D.Common.b2Settings.b2_angularSlop;
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.m_localAnchor1 = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.m_localAnchor2 = null;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.m_localXAxis1 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_localYAxis1 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_axis = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_perp = null;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_s1 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_s2 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_a1 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_a2 = NaN;


/**
 * @private
 * @type {Box2D.Common.Math.b2Mat22}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_K = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_impulse = null;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_motorMass = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_motorImpulse = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_lowerTranslation = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_upperTranslation = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_maxMotorForce = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_motorSpeed = NaN;


/**
 * @private
 * @type {boolean}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_enableLimit = false;


/**
 * @private
 * @type {boolean}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_enableMotor = false;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.Box2D_Dynamics_Joints_b2LineJoint_m_limitState = 0;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2LineJoint', qName: 'Box2D.Dynamics.Joints.b2LineJoint', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_localAnchor1': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2LineJoint */ inst, /** * */ v) {return v !== undefined ? inst.m_localAnchor1 = v : inst.m_localAnchor1;}},
        'm_localAnchor2': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2LineJoint */ inst, /** * */ v) {return v !== undefined ? inst.m_localAnchor2 = v : inst.m_localAnchor2;}},
        'm_localXAxis1': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.Joints.b2LineJoint */ inst, /** * */ v) {return v !== undefined ? inst.m_localXAxis1 = v : inst.m_localXAxis1;}}
      };
    },
    methods: function () {
      return {
        'GetAnchorA': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'GetAnchorB': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'GetReactionForce': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetReactionTorque': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetJointTranslation': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'GetJointSpeed': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'IsLimitEnabled': { type: 'Boolean', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'EnableLimit': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Boolean', false ]; }},
        'GetLowerLimit': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'GetUpperLimit': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'SetLimits': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'IsMotorEnabled': { type: 'Boolean', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'EnableMotor': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Boolean', false ]; }},
        'SetMotorSpeed': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetMotorSpeed': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'SetMaxMotorForce': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetMaxMotorForce': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'GetMotorForce': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint'},
        'b2LineJoint': { type: '', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Box2D.Dynamics.Joints.b2LineJointDef', false ]; }},
        'InitVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'SolveVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'SolvePositionConstraints': { type: 'Boolean', declaredBy: 'Box2D.Dynamics.Joints.b2LineJoint', parameters: function () { return [ 'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2LineJoint.prototype.ROYALE_COMPILE_FLAGS = 9;