/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Joints/b2PulleyJoint.as
 * Box2D.Dynamics.Joints.b2PulleyJoint
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Joints.b2PulleyJoint');
/* Royale Dependency List: Box2D.Common.Math.b2Mat22,Box2D.Common.Math.b2Math,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,Box2D.Dynamics.Joints.b2PulleyJointDef,Box2D.Dynamics.b2Body,Box2D.Dynamics.b2TimeStep*/

goog.require('Box2D.Dynamics.Joints.b2Joint');



/** @asprivate 
 * @constructor
 * @extends {Box2D.Dynamics.Joints.b2Joint}
 * @param {Box2D.Dynamics.Joints.b2PulleyJointDef} def
 */
Box2D.Dynamics.Joints.b2PulleyJoint = function(def) {
  
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1 = new Box2D.Common.Math.b2Vec2();
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2 = new Box2D.Common.Math.b2Vec2();
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ tY = NaN;
  Box2D.Dynamics.Joints.b2PulleyJoint.base(this, 'constructor', def);
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ tX = NaN;
  //var /** @type {number} */ tY = NaN;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground = this.m_bodyA.m_world.m_groundBody;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.x = def.groundAnchorA.x - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.y = def.groundAnchorA.y - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.x = def.groundAnchorB.x - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.y = def.groundAnchorB.y - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.SetV(def.localAnchorA);
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.SetV(def.localAnchorB);
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio = def.ratio;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant = def.lengthA + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * def.lengthB;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength1 = Box2D.Common.Math.b2Math.Min(def.maxLengthA, this.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength);
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength2 = Box2D.Common.Math.b2Math.Min(def.maxLengthB, (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant - Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength) / this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio);
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse = 0.0;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 = 0.0;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 = 0.0;
};
goog.inherits(Box2D.Dynamics.Joints.b2PulleyJoint, Box2D.Dynamics.Joints.b2Joint);


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetAnchorA = function() {
  return this.m_bodyA.GetWorldPoint(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1);
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetAnchorB = function() {
  return this.m_bodyB.GetWorldPoint(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2);
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetReactionForce = function(inv_dt) {
  return new Box2D.Common.Math.b2Vec2(inv_dt * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x, inv_dt * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y);
};


/** @inheritDoc 
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetReactionTorque = function(inv_dt) {
  return 0.0;
};


/**
 * Get the first ground anchor.
 * @return {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetGroundAnchorA = function() {
  var /** @type {Box2D.Common.Math.b2Vec2} */ a = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.Copy();
  a.Add(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1);
  return a;
};


/**
 * Get the second ground anchor.
 * @return {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetGroundAnchorB = function() {
  var /** @type {Box2D.Common.Math.b2Vec2} */ a = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.Copy();
  a.Add(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2);
  return a;
};


/**
 * Get the current length of the segment attached to body1.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetLength1 = function() {
  var /** @type {Box2D.Common.Math.b2Vec2} */ p = this.m_bodyA.GetWorldPoint(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1);
  var /** @type {number} */ sX = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.x;
  var /** @type {number} */ sY = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.y;
  var /** @type {number} */ dX = p.x - sX;
  var /** @type {number} */ dY = p.y - sY;
  return Math.sqrt(dX * dX + dY * dY);
};


/**
 * Get the current length of the segment attached to body2.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetLength2 = function() {
  var /** @type {Box2D.Common.Math.b2Vec2} */ p = this.m_bodyB.GetWorldPoint(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2);
  var /** @type {number} */ sX = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.x;
  var /** @type {number} */ sY = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.y;
  var /** @type {number} */ dX = p.x - sX;
  var /** @type {number} */ dY = p.y - sY;
  return Math.sqrt(dX * dX + dY * dY);
};


/**
 * Get the pulley ratio.
 * @return {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.GetRatio = function() {
  return this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio;
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.InitVelocityConstraints = function(step) {
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  tMat = bA.m_xf.R;
  var /** @type {number} */ r1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.x - bA.m_sweep.localCenter.x;
  var /** @type {number} */ r1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.y - bA.m_sweep.localCenter.y;
  var /** @type {number} */ tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
  r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
  r1X = tX;
  tMat = bB.m_xf.R;
  var /** @type {number} */ r2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.x - bB.m_sweep.localCenter.x;
  var /** @type {number} */ r2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.y - bB.m_sweep.localCenter.y;
  tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
  r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
  r2X = tX;
  var /** @type {number} */ p1X = bA.m_sweep.c.x + r1X;
  var /** @type {number} */ p1Y = bA.m_sweep.c.y + r1Y;
  var /** @type {number} */ p2X = bB.m_sweep.c.x + r2X;
  var /** @type {number} */ p2Y = bB.m_sweep.c.y + r2Y;
  var /** @type {number} */ s1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.x;
  var /** @type {number} */ s1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.y;
  var /** @type {number} */ s2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.x;
  var /** @type {number} */ s2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.y;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Set(p1X - s1X, p1Y - s1Y);
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Set(p2X - s2X, p2Y - s2Y);
  var /** @type {number} */ length1 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Length();
  var /** @type {number} */ length2 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Length();
  if (length1 > Box2D.Common.b2Settings.b2_linearSlop) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Multiply(1.0 / length1);
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.SetZero();
  }
  if (length2 > Box2D.Common.b2Settings.b2_linearSlop) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Multiply(1.0 / length2);
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.SetZero();
  }
  var /** @type {number} */ C = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant - length1 - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * length2;
  if (C > 0.0) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_state = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse = 0.0;
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_state = Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit;
  }
  if (length1 < this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength1) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState1 = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 = 0.0;
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState1 = Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit;
  }
  if (length2 < this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength2) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState2 = Box2D.Dynamics.Joints.b2Joint.e_inactiveLimit;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 = 0.0;
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState2 = Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit;
  }
  var /** @type {number} */ cr1u1 = r1X * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y - r1Y * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
  var /** @type {number} */ cr2u2 = r2X * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y - r2Y * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 = bA.m_invMass + bA.m_invI * cr1u1 * cr1u1;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2 = bB.m_invMass + bB.m_invI * cr2u2 * cr2u2;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 = 1.0 / this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2 = 1.0 / this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2;
  this.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass = 1.0 / this.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass;
  if (step.warmStarting) {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse *= step.dtRatio;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 *= step.dtRatio;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 *= step.dtRatio;
    var /** @type {number} */ P1X = (-this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1) * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
    var /** @type {number} */ P1Y = (-this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1) * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y;
    var /** @type {number} */ P2X = (-this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2) * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
    var /** @type {number} */ P2Y = (-this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2) * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y;
    bA.m_linearVelocity.x += bA.m_invMass * P1X;
    bA.m_linearVelocity.y += bA.m_invMass * P1Y;
    bA.m_angularVelocity += bA.m_invI * (r1X * P1Y - r1Y * P1X);
    bB.m_linearVelocity.x += bB.m_invMass * P2X;
    bB.m_linearVelocity.y += bB.m_invMass * P2Y;
    bB.m_angularVelocity += bB.m_invI * (r2X * P2Y - r2Y * P2X);
  } else {
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse = 0.0;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 = 0.0;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 = 0.0;
  }
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.SolveVelocityConstraints = function(step) {
  var /** @type {number} */ P1X = NaN;
  var /** @type {number} */ P2Y = NaN;
  var /** @type {number} */ P2X = NaN;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ P1Y = NaN;
  var /** @type {number} */ Cdot = NaN;
  var /** @type {number} */ impulse = NaN;
  var /** @type {number} */ oldImpulse = NaN;
  var /** @type {number} */ v1X = NaN;
  var /** @type {number} */ v2Y = NaN;
  var /** @type {number} */ v2X = NaN;
  var /** @type {number} */ v1Y = NaN;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  tMat = bA.m_xf.R;
  var /** @type {number} */ r1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.x - bA.m_sweep.localCenter.x;
  var /** @type {number} */ r1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.y - bA.m_sweep.localCenter.y;
  var /** @type {number} */ tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
  r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
  r1X = tX;
  tMat = bB.m_xf.R;
  var /** @type {number} */ r2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.x - bB.m_sweep.localCenter.x;
  var /** @type {number} */ r2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.y - bB.m_sweep.localCenter.y;
  tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
  r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
  r2X = tX;
  //var /** @type {number} */ v1X = NaN;
  //var /** @type {number} */ v1Y = NaN;
  //var /** @type {number} */ v2X = NaN;
  //var /** @type {number} */ v2Y = NaN;
  //var /** @type {number} */ P1X = NaN;
  //var /** @type {number} */ P1Y = NaN;
  //var /** @type {number} */ P2X = NaN;
  //var /** @type {number} */ P2Y = NaN;
  //var /** @type {number} */ Cdot = NaN;
  //var /** @type {number} */ impulse = NaN;
  //var /** @type {number} */ oldImpulse = NaN;
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_state == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    v1X = bA.m_linearVelocity.x + (-bA.m_angularVelocity * r1Y);
    v1Y = bA.m_linearVelocity.y + (bA.m_angularVelocity * r1X);
    v2X = bB.m_linearVelocity.x + (-bB.m_angularVelocity * r2Y);
    v2Y = bB.m_linearVelocity.y + (bB.m_angularVelocity * r2X);
    Cdot = -(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x * v1X + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y * v1Y) - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x * v2X + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y * v2Y);
    impulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass * (-Cdot);
    oldImpulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse = Box2D.Common.Math.b2Math.Max(0.0, this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse + impulse);
    impulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse - oldImpulse;
    P1X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
    P1Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y;
    P2X = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
    P2Y = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y;
    bA.m_linearVelocity.x += bA.m_invMass * P1X;
    bA.m_linearVelocity.y += bA.m_invMass * P1Y;
    bA.m_angularVelocity += bA.m_invI * (r1X * P1Y - r1Y * P1X);
    bB.m_linearVelocity.x += bB.m_invMass * P2X;
    bB.m_linearVelocity.y += bB.m_invMass * P2Y;
    bB.m_angularVelocity += bB.m_invI * (r2X * P2Y - r2Y * P2X);
  }
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState1 == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    v1X = bA.m_linearVelocity.x + (-bA.m_angularVelocity * r1Y);
    v1Y = bA.m_linearVelocity.y + (bA.m_angularVelocity * r1X);
    Cdot = -(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x * v1X + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y * v1Y);
    impulse = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 * Cdot;
    oldImpulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 = Box2D.Common.Math.b2Math.Max(0.0, this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 + impulse);
    impulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 - oldImpulse;
    P1X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
    P1Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y;
    bA.m_linearVelocity.x += bA.m_invMass * P1X;
    bA.m_linearVelocity.y += bA.m_invMass * P1Y;
    bA.m_angularVelocity += bA.m_invI * (r1X * P1Y - r1Y * P1X);
  }
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState2 == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    v2X = bB.m_linearVelocity.x + (-bB.m_angularVelocity * r2Y);
    v2Y = bB.m_linearVelocity.y + (bB.m_angularVelocity * r2X);
    Cdot = -(this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x * v2X + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y * v2Y);
    impulse = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2 * Cdot;
    oldImpulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 = Box2D.Common.Math.b2Math.Max(0.0, this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 + impulse);
    impulse = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 - oldImpulse;
    P2X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
    P2Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y;
    bB.m_linearVelocity.x += bB.m_invMass * P2X;
    bB.m_linearVelocity.y += bB.m_invMass * P2Y;
    bB.m_angularVelocity += bB.m_invI * (r2X * P2Y - r2Y * P2X);
  }
};


/**
 * @override
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.SolvePositionConstraints = function(baumgarte) {
  var /** @type {number} */ C = NaN;
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ length1 = NaN;
  var /** @type {number} */ length2 = NaN;
  var /** @type {number} */ p1X = NaN;
  var /** @type {number} */ p2Y = NaN;
  var /** @type {number} */ p2X = NaN;
  var /** @type {number} */ r1X = NaN;
  var /** @type {number} */ r2Y = NaN;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ r2X = NaN;
  var /** @type {number} */ p1Y = NaN;
  var /** @type {number} */ impulse = NaN;
  var /** @type {number} */ oldImpulse = NaN;
  var /** @type {number} */ r1Y = NaN;
  var /** @type {number} */ oldLimitPositionImpulse = NaN;
  var /** @type {Box2D.Dynamics.b2Body} */ bA = this.m_bodyA;
  var /** @type {Box2D.Dynamics.b2Body} */ bB = this.m_bodyB;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  var /** @type {number} */ s1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.x;
  var /** @type {number} */ s1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1.y;
  var /** @type {number} */ s2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.x + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.x;
  var /** @type {number} */ s2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground.m_xf.position.y + this.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2.y;
  //var /** @type {number} */ r1X = NaN;
  //var /** @type {number} */ r1Y = NaN;
  //var /** @type {number} */ r2X = NaN;
  //var /** @type {number} */ r2Y = NaN;
  //var /** @type {number} */ p1X = NaN;
  //var /** @type {number} */ p1Y = NaN;
  //var /** @type {number} */ p2X = NaN;
  //var /** @type {number} */ p2Y = NaN;
  //var /** @type {number} */ length1 = NaN;
  //var /** @type {number} */ length2 = NaN;
  //var /** @type {number} */ C = NaN;
  //var /** @type {number} */ impulse = NaN;
  //var /** @type {number} */ oldImpulse = NaN;
  //var /** @type {number} */ oldLimitPositionImpulse = NaN;
  //var /** @type {number} */ tX = NaN;
  var /** @type {number} */ linearError = 0.0;
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_state == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    tMat = bA.m_xf.R;
    r1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.x - bA.m_sweep.localCenter.x;
    r1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.y - bA.m_sweep.localCenter.y;
    tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
    r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
    r1X = tX;
    tMat = bB.m_xf.R;
    r2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.x - bB.m_sweep.localCenter.x;
    r2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.y - bB.m_sweep.localCenter.y;
    tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
    r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
    r2X = tX;
    p1X = bA.m_sweep.c.x + r1X;
    p1Y = bA.m_sweep.c.y + r1Y;
    p2X = bB.m_sweep.c.x + r2X;
    p2Y = bB.m_sweep.c.y + r2Y;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Set(p1X - s1X, p1Y - s1Y);
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Set(p2X - s2X, p2Y - s2Y);
    length1 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Length();
    length2 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Length();
    if (length1 > Box2D.Common.b2Settings.b2_linearSlop) {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Multiply(1.0 / length1);
    } else {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.SetZero();
    }
    if (length2 > Box2D.Common.b2Settings.b2_linearSlop) {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Multiply(1.0 / length2);
    } else {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.SetZero();
    }
    C = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant - length1 - this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * length2;
    linearError = Box2D.Common.Math.b2Math.Max(linearError, -C);
    C = Box2D.Common.Math.b2Math.Clamp(C + Box2D.Common.b2Settings.b2_linearSlop, -Box2D.Common.b2Settings.b2_maxLinearCorrection, 0.0);
    impulse = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass * C;
    p1X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
    p1Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y;
    p2X = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
    p2Y = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio * impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y;
    bA.m_sweep.c.x += bA.m_invMass * p1X;
    bA.m_sweep.c.y += bA.m_invMass * p1Y;
    bA.m_sweep.a += bA.m_invI * (r1X * p1Y - r1Y * p1X);
    bB.m_sweep.c.x += bB.m_invMass * p2X;
    bB.m_sweep.c.y += bB.m_invMass * p2Y;
    bB.m_sweep.a += bB.m_invI * (r2X * p2Y - r2Y * p2X);
    bA.SynchronizeTransform();
    bB.SynchronizeTransform();
  }
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState1 == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    tMat = bA.m_xf.R;
    r1X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.x - bA.m_sweep.localCenter.x;
    r1Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1.y - bA.m_sweep.localCenter.y;
    tX = (tMat.col1.x * r1X + tMat.col2.x * r1Y);
    r1Y = (tMat.col1.y * r1X + tMat.col2.y * r1Y);
    r1X = tX;
    p1X = bA.m_sweep.c.x + r1X;
    p1Y = bA.m_sweep.c.y + r1Y;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Set(p1X - s1X, p1Y - s1Y);
    length1 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.Length();
    if (length1 > Box2D.Common.b2Settings.b2_linearSlop) {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x *= 1.0 / length1;
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y *= 1.0 / length1;
    } else {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.SetZero();
    }
    C = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength1 - length1;
    linearError = Box2D.Common.Math.b2Math.Max(linearError, -C);
    C = Box2D.Common.Math.b2Math.Clamp(C + Box2D.Common.b2Settings.b2_linearSlop, -Box2D.Common.b2Settings.b2_maxLinearCorrection, 0.0);
    impulse = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 * C;
    p1X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.x;
    p1Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1.y;
    bA.m_sweep.c.x += bA.m_invMass * p1X;
    bA.m_sweep.c.y += bA.m_invMass * p1Y;
    bA.m_sweep.a += bA.m_invI * (r1X * p1Y - r1Y * p1X);
    bA.SynchronizeTransform();
  }
  if (this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState2 == Box2D.Dynamics.Joints.b2Joint.e_atUpperLimit) {
    tMat = bB.m_xf.R;
    r2X = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.x - bB.m_sweep.localCenter.x;
    r2Y = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2.y - bB.m_sweep.localCenter.y;
    tX = (tMat.col1.x * r2X + tMat.col2.x * r2Y);
    r2Y = (tMat.col1.y * r2X + tMat.col2.y * r2Y);
    r2X = tX;
    p2X = bB.m_sweep.c.x + r2X;
    p2Y = bB.m_sweep.c.y + r2Y;
    this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Set(p2X - s2X, p2Y - s2Y);
    length2 = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.Length();
    if (length2 > Box2D.Common.b2Settings.b2_linearSlop) {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x *= 1.0 / length2;
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y *= 1.0 / length2;
    } else {
      this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.SetZero();
    }
    C = this.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength2 - length2;
    linearError = Box2D.Common.Math.b2Math.Max(linearError, -C);
    C = Box2D.Common.Math.b2Math.Clamp(C + Box2D.Common.b2Settings.b2_linearSlop, -Box2D.Common.b2Settings.b2_maxLinearCorrection, 0.0);
    impulse = -this.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2 * C;
    p2X = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.x;
    p2Y = -impulse * this.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2.y;
    bB.m_sweep.c.x += bB.m_invMass * p2X;
    bB.m_sweep.c.y += bB.m_invMass * p2Y;
    bB.m_sweep.a += bB.m_invI * (r2X * p2Y - r2Y * p2X);
    bB.SynchronizeTransform();
  }
  return linearError < Box2D.Common.b2Settings.b2_linearSlop;
};


/**
 * @private
 * @type {Box2D.Dynamics.b2Body}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_ground = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor1 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_groundAnchor2 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor1 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_localAnchor2 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_u1 = null;


/**
 * @private
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_u2 = null;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_constant = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_ratio = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength1 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_maxLength2 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_pulleyMass = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass1 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitMass2 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_impulse = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse1 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitImpulse2 = NaN;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_state = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState1 = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.Box2D_Dynamics_Joints_b2PulleyJoint_m_limitState2 = 0;


/**
 * @nocollapse
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.b2_minPulleyLength = 2.0;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2PulleyJoint', qName: 'Box2D.Dynamics.Joints.b2PulleyJoint', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    methods: function () {
      return {
        'GetAnchorA': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetAnchorB': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetReactionForce': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetReactionTorque': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Number', false ]; }},
        'GetGroundAnchorA': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetGroundAnchorB': { type: 'Box2D.Common.Math.b2Vec2', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetLength1': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetLength2': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'GetRatio': { type: 'Number', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint'},
        'b2PulleyJoint': { type: '', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Box2D.Dynamics.Joints.b2PulleyJointDef', false ]; }},
        'InitVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'SolveVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'SolvePositionConstraints': { type: 'Boolean', declaredBy: 'Box2D.Dynamics.Joints.b2PulleyJoint', parameters: function () { return [ 'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Dynamics.Joints.b2PulleyJoint.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Dynamics.Joints.b2PulleyJoint);
