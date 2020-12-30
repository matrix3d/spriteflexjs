/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Contacts/b2ContactSolver.as
 * Box2D.Dynamics.Contacts.b2ContactSolver
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Contacts.b2ContactSolver');
/* Royale Dependency List: Box2D.Collision.Shapes.b2Shape,Box2D.Collision.b2Manifold,Box2D.Collision.b2ManifoldPoint,Box2D.Collision.b2WorldManifold,Box2D.Common.Math.b2Mat22,Box2D.Common.Math.b2Math,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,Box2D.Dynamics.Contacts.b2Contact,Box2D.Dynamics.Contacts.b2ContactConstraint,Box2D.Dynamics.Contacts.b2ContactConstraintPoint,Box2D.Dynamics.Contacts.b2PositionSolverManifold,Box2D.Dynamics.b2Body,Box2D.Dynamics.b2Fixture,Box2D.Dynamics.b2TimeStep,org.apache.royale.utils.Language*/




/**
 * @constructor
 */
Box2D.Dynamics.Contacts.b2ContactSolver = function() {

this.Box2D_Dynamics_Contacts_b2ContactSolver_m_step = new Box2D.Dynamics.b2TimeStep();
this.m_constraints = new Array();
};


Box2D.Dynamics.Contacts.b2ContactSolver.get__s_worldManifold = function() {
  var value = new Box2D.Collision.b2WorldManifold();
  Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, { s_worldManifold: { value: value, writable: true }});
  return value;
};
Box2D.Dynamics.Contacts.b2ContactSolver.set__s_worldManifold = function(value) {
  Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, { s_worldManifold: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Collision.b2WorldManifold}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold;

Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, /** @lends {Box2D.Dynamics.Contacts.b2ContactSolver} */ {
/**
 * @private
 * @type {Box2D.Collision.b2WorldManifold}
 */
s_worldManifold: {
  get: Box2D.Dynamics.Contacts.b2ContactSolver.get__s_worldManifold,
  set: Box2D.Dynamics.Contacts.b2ContactSolver.set__s_worldManifold,
  configurable: true}});


/**
 * @param {Box2D.Dynamics.b2TimeStep} step
 * @param {Array} contacts
 * @param {number} contactCount
 * @param {*} allocator
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.Initialize = function(step, contacts, contactCount, allocator) {
  var /** @type {Box2D.Dynamics.Contacts.b2Contact} */ contact = null;
  var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  var /** @type {number} */ i = 0;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {Box2D.Dynamics.Contacts.b2Contact} */ contact = null;
  this.Box2D_Dynamics_Contacts_b2ContactSolver_m_step.Set(step);
  this.Box2D_Dynamics_Contacts_b2ContactSolver_m_allocator = allocator;
  //var /** @type {number} */ i = 0;
  //var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount = contactCount;
  while (this.m_constraints.length < this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount) {
    this.m_constraints[this.m_constraints.length] = new Box2D.Dynamics.Contacts.b2ContactConstraint();
  }
  for (i = 0; i < contactCount; ++i) {
    contact = /* implicit cast */ org.apache.royale.utils.Language.as(contacts[i], Box2D.Dynamics.Contacts.b2Contact, true);
    var /** @type {Box2D.Dynamics.b2Fixture} */ fixtureA = contact.m_fixtureA;
    var /** @type {Box2D.Dynamics.b2Fixture} */ fixtureB = contact.m_fixtureB;
    var /** @type {Box2D.Collision.Shapes.b2Shape} */ shapeA = fixtureA.m_shape;
    var /** @type {Box2D.Collision.Shapes.b2Shape} */ shapeB = fixtureB.m_shape;
    var /** @type {number} */ radiusA = shapeA.m_radius;
    var /** @type {number} */ radiusB = shapeB.m_radius;
    var /** @type {Box2D.Dynamics.b2Body} */ bodyA = fixtureA.m_body;
    var /** @type {Box2D.Dynamics.b2Body} */ bodyB = fixtureB.m_body;
    var /** @type {Box2D.Collision.b2Manifold} */ manifold = contact.GetManifold();
    var /** @type {number} */ friction = Box2D.Common.b2Settings.b2MixFriction(fixtureA.GetFriction(), fixtureB.GetFriction());
    var /** @type {number} */ restitution = Box2D.Common.b2Settings.b2MixRestitution(fixtureA.GetRestitution(), fixtureB.GetRestitution());
    var /** @type {number} */ vAX = bodyA.m_linearVelocity.x;
    var /** @type {number} */ vAY = bodyA.m_linearVelocity.y;
    var /** @type {number} */ vBX = bodyB.m_linearVelocity.x;
    var /** @type {number} */ vBY = bodyB.m_linearVelocity.y;
    var /** @type {number} */ wA = bodyA.m_angularVelocity;
    var /** @type {number} */ wB = bodyB.m_angularVelocity;
    Box2D.Common.b2Settings.b2Assert(manifold.m_pointCount > 0);
    Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.Initialize(manifold, bodyA.m_xf, radiusA, bodyB.m_xf, radiusB);
    var /** @type {number} */ normalX = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_normal.x;
    var /** @type {number} */ normalY = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_normal.y;
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ cc = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    cc.bodyA = bodyA;
    cc.bodyB = bodyB;
    cc.manifold = manifold;
    cc.normal.x = normalX;
    cc.normal.y = normalY;
    cc.pointCount = manifold.m_pointCount;
    cc.friction = friction;
    cc.restitution = restitution;
    cc.localPlaneNormal.x = manifold.m_localPlaneNormal.x;
    cc.localPlaneNormal.y = manifold.m_localPlaneNormal.y;
    cc.localPoint.x = manifold.m_localPoint.x;
    cc.localPoint.y = manifold.m_localPoint.y;
    cc.radius = radiusA + radiusB;
    cc.type = manifold.m_type;
    for (var /** @type {number} */ k = 0; k < cc.pointCount; ++k) {
      var /** @type {Box2D.Collision.b2ManifoldPoint} */ cp = /* implicit cast */ org.apache.royale.utils.Language.as(manifold.m_points[k], Box2D.Collision.b2ManifoldPoint, true);
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp = /* implicit cast */ org.apache.royale.utils.Language.as(cc.points[k], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      ccp.normalImpulse = cp.m_normalImpulse;
      ccp.tangentImpulse = cp.m_tangentImpulse;
      ccp.localPoint.SetV(cp.m_localPoint);
      var /** @type {number} */ rAX = ccp.rA.x = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_points[k].x - bodyA.m_sweep.c.x;
      var /** @type {number} */ rAY = ccp.rA.y = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_points[k].y - bodyA.m_sweep.c.y;
      var /** @type {number} */ rBX = ccp.rB.x = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_points[k].x - bodyB.m_sweep.c.x;
      var /** @type {number} */ rBY = ccp.rB.y = Box2D.Dynamics.Contacts.b2ContactSolver.s_worldManifold.m_points[k].y - bodyB.m_sweep.c.y;
      var /** @type {number} */ rnA = rAX * normalY - rAY * normalX;
      var /** @type {number} */ rnB = rBX * normalY - rBY * normalX;
      rnA *= rnA;
      rnB *= rnB;
      var /** @type {number} */ kNormal = bodyA.m_invMass + bodyB.m_invMass + bodyA.m_invI * rnA + bodyB.m_invI * rnB;
      ccp.normalMass = 1.0 / kNormal;
      var /** @type {number} */ kEqualized = bodyA.m_mass * bodyA.m_invMass + bodyB.m_mass * bodyB.m_invMass;
      kEqualized += bodyA.m_mass * bodyA.m_invI * rnA + bodyB.m_mass * bodyB.m_invI * rnB;
      ccp.equalizedMass = 1.0 / kEqualized;
      var /** @type {number} */ tangentX = normalY;
      var /** @type {number} */ tangentY = -normalX;
      var /** @type {number} */ rtA = rAX * tangentY - rAY * tangentX;
      var /** @type {number} */ rtB = rBX * tangentY - rBY * tangentX;
      rtA *= rtA;
      rtB *= rtB;
      var /** @type {number} */ kTangent = bodyA.m_invMass + bodyB.m_invMass + bodyA.m_invI * rtA + bodyB.m_invI * rtB;
      ccp.tangentMass = 1.0 / kTangent;
      ccp.velocityBias = 0.0;
      var /** @type {number} */ tX = vBX + (-wB * rBY) - vAX - (-wA * rAY);
      var /** @type {number} */ tY = vBY + (wB * rBX) - vAY - (wA * rAX);
      var /** @type {number} */ vRel = cc.normal.x * tX + cc.normal.y * tY;
      if (vRel < -Box2D.Common.b2Settings.b2_velocityThreshold) {
        ccp.velocityBias += -cc.restitution * vRel;
      }
    }
    if (cc.pointCount == 2) {
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp1 = /* implicit cast */ org.apache.royale.utils.Language.as(cc.points[0], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp2 = /* implicit cast */ org.apache.royale.utils.Language.as(cc.points[1], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      var /** @type {number} */ invMassA = bodyA.m_invMass;
      var /** @type {number} */ invIA = bodyA.m_invI;
      var /** @type {number} */ invMassB = bodyB.m_invMass;
      var /** @type {number} */ invIB = bodyB.m_invI;
      var /** @type {number} */ rn1A = ccp1.rA.x * normalY - ccp1.rA.y * normalX;
      var /** @type {number} */ rn1B = ccp1.rB.x * normalY - ccp1.rB.y * normalX;
      var /** @type {number} */ rn2A = ccp2.rA.x * normalY - ccp2.rA.y * normalX;
      var /** @type {number} */ rn2B = ccp2.rB.x * normalY - ccp2.rB.y * normalX;
      var /** @type {number} */ k11 = invMassA + invMassB + invIA * rn1A * rn1A + invIB * rn1B * rn1B;
      var /** @type {number} */ k22 = invMassA + invMassB + invIA * rn2A * rn2A + invIB * rn2B * rn2B;
      var /** @type {number} */ k12 = invMassA + invMassB + invIA * rn1A * rn2A + invIB * rn1B * rn2B;
      var /** @type {number} */ k_maxConditionNumber = 100.0;
      if (k11 * k11 < k_maxConditionNumber * (k11 * k22 - k12 * k12)) {
        cc.K.col1.Set(k11, k12);
        cc.K.col2.Set(k12, k22);
        cc.K.GetInverse(cc.normalMass);
      } else {
        cc.pointCount = 1;
      }
    }
  }
};


/**
 * @param {Box2D.Dynamics.b2TimeStep} step
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.InitVelocityConstraints = function(step) {
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ j = 0;
  var /** @type {number} */ tCount = 0;
  var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  var /** @type {Box2D.Common.Math.b2Vec2} */ tVec2 = null;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  //var /** @type {Box2D.Common.Math.b2Vec2} */ tVec2 = null;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  for (var /** @type {number} */ i = 0; i < this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount; ++i) {
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ c = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    var /** @type {Box2D.Dynamics.b2Body} */ bodyA = c.bodyA;
    var /** @type {Box2D.Dynamics.b2Body} */ bodyB = c.bodyB;
    var /** @type {number} */ invMassA = bodyA.m_invMass;
    var /** @type {number} */ invIA = bodyA.m_invI;
    var /** @type {number} */ invMassB = bodyB.m_invMass;
    var /** @type {number} */ invIB = bodyB.m_invI;
    var /** @type {number} */ normalX = c.normal.x;
    var /** @type {number} */ normalY = c.normal.y;
    var /** @type {number} */ tangentX = normalY;
    var /** @type {number} */ tangentY = -normalX;
    //var /** @type {number} */ tX = NaN;
    //var /** @type {number} */ j = 0;
    //var /** @type {number} */ tCount = 0;
    if (step.warmStarting) {
      tCount = c.pointCount;
      for (j = 0; j < tCount; ++j) {
        var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[j], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
        ccp.normalImpulse *= step.dtRatio;
        ccp.tangentImpulse *= step.dtRatio;
        var /** @type {number} */ PX = ccp.normalImpulse * normalX + ccp.tangentImpulse * tangentX;
        var /** @type {number} */ PY = ccp.normalImpulse * normalY + ccp.tangentImpulse * tangentY;
        bodyA.m_angularVelocity -= invIA * (ccp.rA.x * PY - ccp.rA.y * PX);
        bodyA.m_linearVelocity.x -= invMassA * PX;
        bodyA.m_linearVelocity.y -= invMassA * PY;
        bodyB.m_angularVelocity += invIB * (ccp.rB.x * PY - ccp.rB.y * PX);
        bodyB.m_linearVelocity.x += invMassB * PX;
        bodyB.m_linearVelocity.y += invMassB * PY;
      }
    } else {
      tCount = c.pointCount;
      for (j = 0; j < tCount; ++j) {
        var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp2 = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[j], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
        ccp2.normalImpulse = 0.0;
        ccp2.tangentImpulse = 0.0;
      }
    }
  }
};


/**
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.SolveVelocityConstraints = function() {
  var /** @type {number} */ dvY = NaN;
  var /** @type {number} */ dvX = NaN;
  var /** @type {number} */ PX = NaN;
  var /** @type {number} */ PY = NaN;
  var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp = null;
  var /** @type {number} */ lambda = NaN;
  var /** @type {number} */ P1X = NaN;
  var /** @type {number} */ P1Y = NaN;
  var /** @type {number} */ rAX = NaN;
  var /** @type {number} */ rAY = NaN;
  var /** @type {number} */ P2Y = NaN;
  var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  var /** @type {number} */ P2X = NaN;
  var /** @type {number} */ vn = NaN;
  var /** @type {number} */ vt = NaN;
  var /** @type {number} */ rBY = NaN;
  var /** @type {number} */ maxFriction = NaN;
  var /** @type {number} */ rBX = NaN;
  var /** @type {number} */ tX = NaN;
  var /** @type {number} */ j = 0;
  var /** @type {number} */ dX = NaN;
  var /** @type {number} */ dY = NaN;
  var /** @type {number} */ newImpulse = NaN;
  var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {number} */ j = 0;
  //var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp = null;
  //var /** @type {number} */ rAX = NaN;
  //var /** @type {number} */ rAY = NaN;
  //var /** @type {number} */ rBX = NaN;
  //var /** @type {number} */ rBY = NaN;
  //var /** @type {number} */ dvX = NaN;
  //var /** @type {number} */ dvY = NaN;
  //var /** @type {number} */ vn = NaN;
  //var /** @type {number} */ vt = NaN;
  //var /** @type {number} */ lambda = NaN;
  //var /** @type {number} */ maxFriction = NaN;
  //var /** @type {number} */ newImpulse = NaN;
  //var /** @type {number} */ PX = NaN;
  //var /** @type {number} */ PY = NaN;
  //var /** @type {number} */ dX = NaN;
  //var /** @type {number} */ dY = NaN;
  //var /** @type {number} */ P1X = NaN;
  //var /** @type {number} */ P1Y = NaN;
  //var /** @type {number} */ P2X = NaN;
  //var /** @type {number} */ P2Y = NaN;
  //var /** @type {Box2D.Common.Math.b2Mat22} */ tMat = null;
  //var /** @type {Box2D.Common.Math.b2Vec2} */ tVec = null;
  for (var /** @type {number} */ i = 0; i < this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount; ++i) {
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ c = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    var /** @type {Box2D.Dynamics.b2Body} */ bodyA = c.bodyA;
    var /** @type {Box2D.Dynamics.b2Body} */ bodyB = c.bodyB;
    var /** @type {number} */ wA = bodyA.m_angularVelocity;
    var /** @type {number} */ wB = bodyB.m_angularVelocity;
    var /** @type {Box2D.Common.Math.b2Vec2} */ vA = bodyA.m_linearVelocity;
    var /** @type {Box2D.Common.Math.b2Vec2} */ vB = bodyB.m_linearVelocity;
    var /** @type {number} */ invMassA = bodyA.m_invMass;
    var /** @type {number} */ invIA = bodyA.m_invI;
    var /** @type {number} */ invMassB = bodyB.m_invMass;
    var /** @type {number} */ invIB = bodyB.m_invI;
    var /** @type {number} */ normalX = c.normal.x;
    var /** @type {number} */ normalY = c.normal.y;
    var /** @type {number} */ tangentX = normalY;
    var /** @type {number} */ tangentY = -normalX;
    var /** @type {number} */ friction = c.friction;
    //var /** @type {number} */ tX = NaN;
    for (j = 0; j < c.pointCount; j++) {
      ccp = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[j], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      dvX = vB.x - wB * ccp.rB.y - vA.x + wA * ccp.rA.y;
      dvY = vB.y + wB * ccp.rB.x - vA.y - wA * ccp.rA.x;
      vt = dvX * tangentX + dvY * tangentY;
      lambda = ccp.tangentMass * -vt;
      maxFriction = friction * ccp.normalImpulse;
      newImpulse = Box2D.Common.Math.b2Math.Clamp(ccp.tangentImpulse + lambda, -maxFriction, maxFriction);
      lambda = newImpulse - ccp.tangentImpulse;
      PX = lambda * tangentX;
      PY = lambda * tangentY;
      vA.x -= invMassA * PX;
      vA.y -= invMassA * PY;
      wA -= invIA * (ccp.rA.x * PY - ccp.rA.y * PX);
      vB.x += invMassB * PX;
      vB.y += invMassB * PY;
      wB += invIB * (ccp.rB.x * PY - ccp.rB.y * PX);
      ccp.tangentImpulse = newImpulse;
    }
    var /** @type {number} */ tCount = c.pointCount;
    if (c.pointCount == 1) {
      ccp = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[0], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      dvX = vB.x + (-wB * ccp.rB.y) - vA.x - (-wA * ccp.rA.y);
      dvY = vB.y + (wB * ccp.rB.x) - vA.y - (wA * ccp.rA.x);
      vn = dvX * normalX + dvY * normalY;
      lambda = -ccp.normalMass * (vn - ccp.velocityBias);
      newImpulse = ccp.normalImpulse + lambda;
      newImpulse = newImpulse > 0 ? newImpulse : 0.0;
      lambda = newImpulse - ccp.normalImpulse;
      PX = lambda * normalX;
      PY = lambda * normalY;
      vA.x -= invMassA * PX;
      vA.y -= invMassA * PY;
      wA -= invIA * (ccp.rA.x * PY - ccp.rA.y * PX);
      vB.x += invMassB * PX;
      vB.y += invMassB * PY;
      wB += invIB * (ccp.rB.x * PY - ccp.rB.y * PX);
      ccp.normalImpulse = newImpulse;
    } else {
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ cp1 = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[0], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ cp2 = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[1], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      var /** @type {number} */ aX = cp1.normalImpulse;
      var /** @type {number} */ aY = cp2.normalImpulse;
      var /** @type {number} */ dv1X = vB.x - wB * cp1.rB.y - vA.x + wA * cp1.rA.y;
      var /** @type {number} */ dv1Y = vB.y + wB * cp1.rB.x - vA.y - wA * cp1.rA.x;
      var /** @type {number} */ dv2X = vB.x - wB * cp2.rB.y - vA.x + wA * cp2.rA.y;
      var /** @type {number} */ dv2Y = vB.y + wB * cp2.rB.x - vA.y - wA * cp2.rA.x;
      var /** @type {number} */ vn1 = dv1X * normalX + dv1Y * normalY;
      var /** @type {number} */ vn2 = dv2X * normalX + dv2Y * normalY;
      var /** @type {number} */ bX = vn1 - cp1.velocityBias;
      var /** @type {number} */ bY = vn2 - cp2.velocityBias;
      tMat = c.K;
      bX -= tMat.col1.x * aX + tMat.col2.x * aY;
      bY -= tMat.col1.y * aX + tMat.col2.y * aY;
      var /** @type {number} */ k_errorTol = 0.001;
      for (;;) {
        tMat = c.normalMass;
        var /** @type {number} */ xX = -(tMat.col1.x * bX + tMat.col2.x * bY);
        var /** @type {number} */ xY = -(tMat.col1.y * bX + tMat.col2.y * bY);
        if (xX >= 0.0 && xY >= 0.0) {
          dX = xX - aX;
          dY = xY - aY;
          P1X = dX * normalX;
          P1Y = dX * normalY;
          P2X = dY * normalX;
          P2Y = dY * normalY;
          vA.x -= invMassA * (P1X + P2X);
          vA.y -= invMassA * (P1Y + P2Y);
          wA -= invIA * (cp1.rA.x * P1Y - cp1.rA.y * P1X + cp2.rA.x * P2Y - cp2.rA.y * P2X);
          vB.x += invMassB * (P1X + P2X);
          vB.y += invMassB * (P1Y + P2Y);
          wB += invIB * (cp1.rB.x * P1Y - cp1.rB.y * P1X + cp2.rB.x * P2Y - cp2.rB.y * P2X);
          cp1.normalImpulse = xX;
          cp2.normalImpulse = xY;
          break;
        }
        xX = -cp1.normalMass * bX;
        xY = 0.0;
        vn1 = 0.0;
        vn2 = c.K.col1.y * xX + bY;
        if (xX >= 0.0 && vn2 >= 0.0) {
          dX = xX - aX;
          dY = xY - aY;
          P1X = dX * normalX;
          P1Y = dX * normalY;
          P2X = dY * normalX;
          P2Y = dY * normalY;
          vA.x -= invMassA * (P1X + P2X);
          vA.y -= invMassA * (P1Y + P2Y);
          wA -= invIA * (cp1.rA.x * P1Y - cp1.rA.y * P1X + cp2.rA.x * P2Y - cp2.rA.y * P2X);
          vB.x += invMassB * (P1X + P2X);
          vB.y += invMassB * (P1Y + P2Y);
          wB += invIB * (cp1.rB.x * P1Y - cp1.rB.y * P1X + cp2.rB.x * P2Y - cp2.rB.y * P2X);
          cp1.normalImpulse = xX;
          cp2.normalImpulse = xY;
          break;
        }
        xX = 0.0;
        xY = -cp2.normalMass * bY;
        vn1 = c.K.col2.x * xY + bX;
        vn2 = 0.0;
        if (xY >= 0.0 && vn1 >= 0.0) {
          dX = xX - aX;
          dY = xY - aY;
          P1X = dX * normalX;
          P1Y = dX * normalY;
          P2X = dY * normalX;
          P2Y = dY * normalY;
          vA.x -= invMassA * (P1X + P2X);
          vA.y -= invMassA * (P1Y + P2Y);
          wA -= invIA * (cp1.rA.x * P1Y - cp1.rA.y * P1X + cp2.rA.x * P2Y - cp2.rA.y * P2X);
          vB.x += invMassB * (P1X + P2X);
          vB.y += invMassB * (P1Y + P2Y);
          wB += invIB * (cp1.rB.x * P1Y - cp1.rB.y * P1X + cp2.rB.x * P2Y - cp2.rB.y * P2X);
          cp1.normalImpulse = xX;
          cp2.normalImpulse = xY;
          break;
        }
        xX = 0.0;
        xY = 0.0;
        vn1 = bX;
        vn2 = bY;
        if (vn1 >= 0.0 && vn2 >= 0.0) {
          dX = xX - aX;
          dY = xY - aY;
          P1X = dX * normalX;
          P1Y = dX * normalY;
          P2X = dY * normalX;
          P2Y = dY * normalY;
          vA.x -= invMassA * (P1X + P2X);
          vA.y -= invMassA * (P1Y + P2Y);
          wA -= invIA * (cp1.rA.x * P1Y - cp1.rA.y * P1X + cp2.rA.x * P2Y - cp2.rA.y * P2X);
          vB.x += invMassB * (P1X + P2X);
          vB.y += invMassB * (P1Y + P2Y);
          wB += invIB * (cp1.rB.x * P1Y - cp1.rB.y * P1X + cp2.rB.x * P2Y - cp2.rB.y * P2X);
          cp1.normalImpulse = xX;
          cp2.normalImpulse = xY;
          break;
        }
        break;
      }
    }
    bodyA.m_angularVelocity = wA;
    bodyB.m_angularVelocity = wB;
  }
};


/**
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.FinalizeVelocityConstraints = function() {
  for (var /** @type {number} */ i = 0; i < this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount; ++i) {
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ c = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    var /** @type {Box2D.Collision.b2Manifold} */ m = c.manifold;
    for (var /** @type {number} */ j = 0; j < c.pointCount; ++j) {
      var /** @type {Box2D.Collision.b2ManifoldPoint} */ point1 = /* implicit cast */ org.apache.royale.utils.Language.as(m.m_points[j], Box2D.Collision.b2ManifoldPoint, true);
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ point2 = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[j], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      point1.m_normalImpulse = point2.normalImpulse;
      point1.m_tangentImpulse = point2.tangentImpulse;
    }
  }
};


Box2D.Dynamics.Contacts.b2ContactSolver.get__s_psm = function() {
  var value = new Box2D.Dynamics.Contacts.b2PositionSolverManifold();
  Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, { s_psm: { value: value, writable: true }});
  return value;
};
Box2D.Dynamics.Contacts.b2ContactSolver.set__s_psm = function(value) {
  Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, { s_psm: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Dynamics.Contacts.b2PositionSolverManifold}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.s_psm;

Object.defineProperties(Box2D.Dynamics.Contacts.b2ContactSolver, /** @lends {Box2D.Dynamics.Contacts.b2ContactSolver} */ {
/**
 * @private
 * @type {Box2D.Dynamics.Contacts.b2PositionSolverManifold}
 */
s_psm: {
  get: Box2D.Dynamics.Contacts.b2ContactSolver.get__s_psm,
  set: Box2D.Dynamics.Contacts.b2ContactSolver.set__s_psm,
  configurable: true}});


/**
 * @param {number} baumgarte
 * @return {boolean}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.SolvePositionConstraints = function(baumgarte) {
  var /** @type {number} */ minSeparation = 0.0;
  for (var /** @type {number} */ i = 0; i < this.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount; i++) {
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ c = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    var /** @type {Box2D.Dynamics.b2Body} */ bodyA = c.bodyA;
    var /** @type {Box2D.Dynamics.b2Body} */ bodyB = c.bodyB;
    var /** @type {number} */ invMassA = bodyA.m_mass * bodyA.m_invMass;
    var /** @type {number} */ invIA = bodyA.m_mass * bodyA.m_invI;
    var /** @type {number} */ invMassB = bodyB.m_mass * bodyB.m_invMass;
    var /** @type {number} */ invIB = bodyB.m_mass * bodyB.m_invI;
    Box2D.Dynamics.Contacts.b2ContactSolver.s_psm.Initialize(c);
    var /** @type {Box2D.Common.Math.b2Vec2} */ normal = Box2D.Dynamics.Contacts.b2ContactSolver.s_psm.m_normal;
    for (var /** @type {number} */ j = 0; j < c.pointCount; j++) {
      var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraintPoint} */ ccp = /* implicit cast */ org.apache.royale.utils.Language.as(c.points[j], Box2D.Dynamics.Contacts.b2ContactConstraintPoint, true);
      var /** @type {Box2D.Common.Math.b2Vec2} */ point = /* implicit cast */ org.apache.royale.utils.Language.as(Box2D.Dynamics.Contacts.b2ContactSolver.s_psm.m_points[j], Box2D.Common.Math.b2Vec2, true);
      var /** @type {number} */ separation = Number(Box2D.Dynamics.Contacts.b2ContactSolver.s_psm.m_separations[j]);
      var /** @type {number} */ rAX = point.x - bodyA.m_sweep.c.x;
      var /** @type {number} */ rAY = point.y - bodyA.m_sweep.c.y;
      var /** @type {number} */ rBX = point.x - bodyB.m_sweep.c.x;
      var /** @type {number} */ rBY = point.y - bodyB.m_sweep.c.y;
      minSeparation = minSeparation < separation ? minSeparation : separation;
      var /** @type {number} */ C = Box2D.Common.Math.b2Math.Clamp(baumgarte * (separation + Box2D.Common.b2Settings.b2_linearSlop), -Box2D.Common.b2Settings.b2_maxLinearCorrection, 0.0);
      var /** @type {number} */ impulse = -ccp.equalizedMass * C;
      var /** @type {number} */ PX = impulse * normal.x;
      var /** @type {number} */ PY = impulse * normal.y;
      bodyA.m_sweep.c.x -= invMassA * PX;
      bodyA.m_sweep.c.y -= invMassA * PY;
      bodyA.m_sweep.a -= invIA * (rAX * PY - rAY * PX);
      bodyA.SynchronizeTransform();
      bodyB.m_sweep.c.x += invMassB * PX;
      bodyB.m_sweep.c.y += invMassB * PY;
      bodyB.m_sweep.a += invIB * (rBX * PY - rBY * PX);
      bodyB.SynchronizeTransform();
    }
  }
  return minSeparation > -1.5 * Box2D.Common.b2Settings.b2_linearSlop;
};


/**
 * @private
 * @type {Box2D.Dynamics.b2TimeStep}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.Box2D_Dynamics_Contacts_b2ContactSolver_m_step = null;


/**
 * @private
 * @type {*}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.Box2D_Dynamics_Contacts_b2ContactSolver_m_allocator = undefined;


/**
 * @type {Array}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.m_constraints = null;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.Box2D_Dynamics_Contacts_b2ContactSolver_m_constraintCount = 0;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2ContactSolver', qName: 'Box2D.Dynamics.Contacts.b2ContactSolver', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_constraints': { type: 'Array', get_set: function (/** Box2D.Dynamics.Contacts.b2ContactSolver */ inst, /** * */ v) {return v !== undefined ? inst.m_constraints = v : inst.m_constraints;}}
      };
    },
    methods: function () {
      return {
        'b2ContactSolver': { type: '', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ,'Array', false ,'int', false ,'*', false ]; }},
        'InitVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'SolveVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver'},
        'FinalizeVelocityConstraints': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver'},
        'SolvePositionConstraints': { type: 'Boolean', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactSolver', parameters: function () { return [ 'Number', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Dynamics.Contacts.b2ContactSolver.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Dynamics.Contacts.b2ContactSolver);
