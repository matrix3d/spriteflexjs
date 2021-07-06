/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/b2Island.as
 * Box2D.Dynamics.b2Island
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.b2Island');
/* Royale Dependency List: Box2D.Common.Math.b2Math,Box2D.Common.Math.b2Vec2,Box2D.Common.b2Settings,Box2D.Dynamics.Contacts.b2Contact,Box2D.Dynamics.Contacts.b2ContactConstraint,Box2D.Dynamics.Contacts.b2ContactSolver,Box2D.Dynamics.Joints.b2Joint,Box2D.Dynamics.b2Body,Box2D.Dynamics.b2ContactImpulse,Box2D.Dynamics.b2ContactListener,Box2D.Dynamics.b2TimeStep,org.apache.royale.utils.Language*/




/**
 * @constructor
 */
Box2D.Dynamics.b2Island = function() {
  this.m_bodies = new Array();
  this.m_contacts = new Array();
  this.m_joints = new Array();
};


/**
 * @param {number} bodyCapacity
 * @param {number} contactCapacity
 * @param {number} jointCapacity
 * @param {*} allocator
 * @param {Box2D.Dynamics.b2ContactListener} listener
 * @param {Box2D.Dynamics.Contacts.b2ContactSolver} contactSolver
 */
Box2D.Dynamics.b2Island.prototype.Initialize = function(bodyCapacity, contactCapacity, jointCapacity, allocator, listener, contactSolver) {
  var /** @type {number} */ i = 0;
  //var /** @type {number} */ i = 0;
  this.Box2D_Dynamics_b2Island_m_bodyCapacity = bodyCapacity;
  this.m_contactCapacity = contactCapacity;
  this.m_jointCapacity = jointCapacity;
  this.m_bodyCount = 0;
  this.m_contactCount = 0;
  this.m_jointCount = 0;
  this.Box2D_Dynamics_b2Island_m_allocator = allocator;
  this.Box2D_Dynamics_b2Island_m_listener = listener;
  this.Box2D_Dynamics_b2Island_m_contactSolver = contactSolver;
  for (i = (this.m_bodies.length) >> 0; i < bodyCapacity; i++)
    this.m_bodies[i] = null;
  for (i = (this.m_contacts.length) >> 0; i < contactCapacity; i++)
    this.m_contacts[i] = null;
  for (i = (this.m_joints.length) >> 0; i < jointCapacity; i++)
    this.m_joints[i] = null;
};


/**
 */
Box2D.Dynamics.b2Island.prototype.Clear = function() {
  this.m_bodyCount = 0;
  this.m_contactCount = 0;
  this.m_jointCount = 0;
};


/**
 * @param {Box2D.Dynamics.b2TimeStep} step
 * @param {Box2D.Common.Math.b2Vec2} gravity
 * @param {boolean} allowSleep
 */
Box2D.Dynamics.b2Island.prototype.Solve = function(step, gravity, allowSleep) {
  var /** @type {Box2D.Dynamics.b2Body} */ b = null;
  var /** @type {Box2D.Dynamics.Joints.b2Joint} */ joint = null;
  var /** @type {number} */ i = 0;
  var /** @type {number} */ j = 0;
  //var /** @type {number} */ i = 0;
  //var /** @type {number} */ j = 0;
  //var /** @type {Box2D.Dynamics.b2Body} */ b = null;
  //var /** @type {Box2D.Dynamics.Joints.b2Joint} */ joint = null;
  for (i = 0; i < this.m_bodyCount; ++i) {
    b = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_bodies[i], Box2D.Dynamics.b2Body, true);
    if (b.GetType() != Box2D.Dynamics.b2Body.b2_dynamicBody)
      continue;
    b.m_linearVelocity.x += step.dt * (gravity.x + b.m_invMass * b.m_force.x);
    b.m_linearVelocity.y += step.dt * (gravity.y + b.m_invMass * b.m_force.y);
    b.m_angularVelocity += step.dt * b.m_invI * b.m_torque;
    b.m_linearVelocity.Multiply(Box2D.Common.Math.b2Math.Clamp(1.0 - step.dt * b.m_linearDamping, 0.0, 1.0));
    b.m_angularVelocity *= Box2D.Common.Math.b2Math.Clamp(1.0 - step.dt * b.m_angularDamping, 0.0, 1.0);
  }
  this.Box2D_Dynamics_b2Island_m_contactSolver.Initialize(step, this.m_contacts, this.m_contactCount, this.Box2D_Dynamics_b2Island_m_allocator);
  var /** @type {Box2D.Dynamics.Contacts.b2ContactSolver} */ contactSolver = this.Box2D_Dynamics_b2Island_m_contactSolver;
  contactSolver.InitVelocityConstraints(step);
  for (i = 0; i < this.m_jointCount; ++i) {
    joint = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_joints[i], Box2D.Dynamics.Joints.b2Joint, true);
    joint.InitVelocityConstraints(step);
  }
  for (i = 0; i < step.velocityIterations; ++i) {
    for (j = 0; j < this.m_jointCount; ++j) {
      joint = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_joints[j], Box2D.Dynamics.Joints.b2Joint, true);
      joint.SolveVelocityConstraints(step);
    }
    contactSolver.SolveVelocityConstraints();
  }
  for (i = 0; i < this.m_jointCount; ++i) {
    joint = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_joints[i], Box2D.Dynamics.Joints.b2Joint, true);
    joint.FinalizeVelocityConstraints();
  }
  contactSolver.FinalizeVelocityConstraints();
  for (i = 0; i < this.m_bodyCount; ++i) {
    b = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_bodies[i], Box2D.Dynamics.b2Body, true);
    if (b.GetType() == Box2D.Dynamics.b2Body.b2_staticBody)
      continue;
    var /** @type {number} */ translationX = step.dt * b.m_linearVelocity.x;
    var /** @type {number} */ translationY = step.dt * b.m_linearVelocity.y;
    if ((translationX * translationX + translationY * translationY) > Box2D.Common.b2Settings.b2_maxTranslationSquared) {
      b.m_linearVelocity.Normalize();
      b.m_linearVelocity.x *= Box2D.Common.b2Settings.b2_maxTranslation * step.inv_dt;
      b.m_linearVelocity.y *= Box2D.Common.b2Settings.b2_maxTranslation * step.inv_dt;
    }
    var /** @type {number} */ rotation = step.dt * b.m_angularVelocity;
    if (rotation * rotation > Box2D.Common.b2Settings.b2_maxRotationSquared) {
      if (b.m_angularVelocity < 0.0) {
        b.m_angularVelocity = -Box2D.Common.b2Settings.b2_maxRotation * step.inv_dt;
      } else {
        b.m_angularVelocity = Box2D.Common.b2Settings.b2_maxRotation * step.inv_dt;
      }
    }
    b.m_sweep.c0.SetV(b.m_sweep.c);
    b.m_sweep.a0 = b.m_sweep.a;
    b.m_sweep.c.x += step.dt * b.m_linearVelocity.x;
    b.m_sweep.c.y += step.dt * b.m_linearVelocity.y;
    b.m_sweep.a += step.dt * b.m_angularVelocity;
    b.SynchronizeTransform();
  }
  for (i = 0; i < step.positionIterations; ++i) {
    var /** @type {boolean} */ contactsOkay = contactSolver.SolvePositionConstraints(Box2D.Common.b2Settings.b2_contactBaumgarte);
    var /** @type {boolean} */ jointsOkay = true;
    for (j = 0; j < this.m_jointCount; ++j) {
      joint = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_joints[j], Box2D.Dynamics.Joints.b2Joint, true);
      var /** @type {boolean} */ jointOkay = joint.SolvePositionConstraints(Box2D.Common.b2Settings.b2_contactBaumgarte);
      jointsOkay = jointsOkay && jointOkay;
    }
    if (contactsOkay && jointsOkay) {
      break;
    }
  }
  this.Report(contactSolver.m_constraints);
  if (allowSleep) {
    var /** @type {number} */ minSleepTime = Number.MAX_VALUE;
    var /** @type {number} */ linTolSqr = Box2D.Common.b2Settings.b2_linearSleepTolerance * Box2D.Common.b2Settings.b2_linearSleepTolerance;
    var /** @type {number} */ angTolSqr = Box2D.Common.b2Settings.b2_angularSleepTolerance * Box2D.Common.b2Settings.b2_angularSleepTolerance;
    for (i = 0; i < this.m_bodyCount; ++i) {
      b = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_bodies[i], Box2D.Dynamics.b2Body, true);
      if (b.GetType() == Box2D.Dynamics.b2Body.b2_staticBody) {
        continue;
      }
      if ((b.m_flags & Box2D.Dynamics.b2Body.e_allowSleepFlag) == 0) {
        b.m_sleepTime = 0.0;
        minSleepTime = 0.0;
      }
      if ((b.m_flags & Box2D.Dynamics.b2Body.e_allowSleepFlag) == 0 || b.m_angularVelocity * b.m_angularVelocity > angTolSqr || Box2D.Common.Math.b2Math.Dot(b.m_linearVelocity, b.m_linearVelocity) > linTolSqr) {
        b.m_sleepTime = 0.0;
        minSleepTime = 0.0;
      } else {
        b.m_sleepTime += step.dt;
        minSleepTime = Box2D.Common.Math.b2Math.Min(minSleepTime, b.m_sleepTime);
      }
    }
    if (minSleepTime >= Box2D.Common.b2Settings.b2_timeToSleep) {
      for (i = 0; i < this.m_bodyCount; ++i) {
        b = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_bodies[i], Box2D.Dynamics.b2Body, true);
        b.SetAwake(false);
      }
    }
  }
};


/**
 * @param {Box2D.Dynamics.b2TimeStep} subStep
 */
Box2D.Dynamics.b2Island.prototype.SolveTOI = function(subStep) {
  var /** @type {number} */ i = 0;
  var /** @type {number} */ j = 0;
  //var /** @type {number} */ i = 0;
  //var /** @type {number} */ j = 0;
  this.Box2D_Dynamics_b2Island_m_contactSolver.Initialize(subStep, this.m_contacts, this.m_contactCount, this.Box2D_Dynamics_b2Island_m_allocator);
  var /** @type {Box2D.Dynamics.Contacts.b2ContactSolver} */ contactSolver = this.Box2D_Dynamics_b2Island_m_contactSolver;
  for (i = 0; i < this.m_jointCount; ++i) {
    this.m_joints[i].InitVelocityConstraints(subStep);
  }
  for (i = 0; i < subStep.velocityIterations; ++i) {
    contactSolver.SolveVelocityConstraints();
    for (j = 0; j < this.m_jointCount; ++j) {
      this.m_joints[j].SolveVelocityConstraints(subStep);
    }
  }
  for (i = 0; i < this.m_bodyCount; ++i) {
    var /** @type {Box2D.Dynamics.b2Body} */ b = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_bodies[i], Box2D.Dynamics.b2Body, true);
    if (b.GetType() == Box2D.Dynamics.b2Body.b2_staticBody)
      continue;
    var /** @type {number} */ translationX = subStep.dt * b.m_linearVelocity.x;
    var /** @type {number} */ translationY = subStep.dt * b.m_linearVelocity.y;
    if ((translationX * translationX + translationY * translationY) > Box2D.Common.b2Settings.b2_maxTranslationSquared) {
      b.m_linearVelocity.Normalize();
      b.m_linearVelocity.x *= Box2D.Common.b2Settings.b2_maxTranslation * subStep.inv_dt;
      b.m_linearVelocity.y *= Box2D.Common.b2Settings.b2_maxTranslation * subStep.inv_dt;
    }
    var /** @type {number} */ rotation = subStep.dt * b.m_angularVelocity;
    if (rotation * rotation > Box2D.Common.b2Settings.b2_maxRotationSquared) {
      if (b.m_angularVelocity < 0.0) {
        b.m_angularVelocity = -Box2D.Common.b2Settings.b2_maxRotation * subStep.inv_dt;
      } else {
        b.m_angularVelocity = Box2D.Common.b2Settings.b2_maxRotation * subStep.inv_dt;
      }
    }
    b.m_sweep.c0.SetV(b.m_sweep.c);
    b.m_sweep.a0 = b.m_sweep.a;
    b.m_sweep.c.x += subStep.dt * b.m_linearVelocity.x;
    b.m_sweep.c.y += subStep.dt * b.m_linearVelocity.y;
    b.m_sweep.a += subStep.dt * b.m_angularVelocity;
    b.SynchronizeTransform();
  }
  var /** @type {number} */ k_toiBaumgarte = 0.75;
  for (i = 0; i < subStep.positionIterations; ++i) {
    var /** @type {boolean} */ contactsOkay = contactSolver.SolvePositionConstraints(k_toiBaumgarte);
    var /** @type {boolean} */ jointsOkay = true;
    for (j = 0; j < this.m_jointCount; ++j) {
      var /** @type {boolean} */ jointOkay = !!(this.m_joints[j].SolvePositionConstraints(Box2D.Common.b2Settings.b2_contactBaumgarte));
      jointsOkay = jointsOkay && jointOkay;
    }
    if (contactsOkay && jointsOkay) {
      break;
    }
  }
  this.Report(contactSolver.m_constraints);
};


Box2D.Dynamics.b2Island.get__s_impulse = function() {
  var value = new Box2D.Dynamics.b2ContactImpulse();
  Object.defineProperties(Box2D.Dynamics.b2Island, { s_impulse: { value: value, writable: true }});
  return value;
};
Box2D.Dynamics.b2Island.set__s_impulse = function(value) {
  Object.defineProperties(Box2D.Dynamics.b2Island, { s_impulse: { value: value, writable: true }});
};
/**
 * @private
 * @type {Box2D.Dynamics.b2ContactImpulse}
 */
Box2D.Dynamics.b2Island.s_impulse;

Object.defineProperties(Box2D.Dynamics.b2Island, /** @lends {Box2D.Dynamics.b2Island} */ {
/**
 * @private
 * @type {Box2D.Dynamics.b2ContactImpulse}
 */
s_impulse: {
  get: Box2D.Dynamics.b2Island.get__s_impulse,
  set: Box2D.Dynamics.b2Island.set__s_impulse,
  configurable: true}});


/**
 * @param {Array} constraints
 */
Box2D.Dynamics.b2Island.prototype.Report = function(constraints) {
  if (this.Box2D_Dynamics_b2Island_m_listener == null) {
    return;
  }
  for (var /** @type {number} */ i = 0; i < this.m_contactCount; ++i) {
    var /** @type {Box2D.Dynamics.Contacts.b2Contact} */ c = /* implicit cast */ org.apache.royale.utils.Language.as(this.m_contacts[i], Box2D.Dynamics.Contacts.b2Contact, true);
    var /** @type {Box2D.Dynamics.Contacts.b2ContactConstraint} */ cc = /* implicit cast */ org.apache.royale.utils.Language.as(constraints[i], Box2D.Dynamics.Contacts.b2ContactConstraint, true);
    for (var /** @type {number} */ j = 0; j < cc.pointCount; ++j) {
      Box2D.Dynamics.b2Island.s_impulse.normalImpulses[j] = cc.points[j].normalImpulse;
      Box2D.Dynamics.b2Island.s_impulse.tangentImpulses[j] = cc.points[j].tangentImpulse;
    }
    this.Box2D_Dynamics_b2Island_m_listener.PostSolve(c, Box2D.Dynamics.b2Island.s_impulse);
  }
};


/**
 * @param {Box2D.Dynamics.b2Body} body
 */
Box2D.Dynamics.b2Island.prototype.AddBody = function(body) {
  body.m_islandIndex = this.m_bodyCount;
  this.m_bodies[this.m_bodyCount++] = body;
};


/**
 * @param {Box2D.Dynamics.Contacts.b2Contact} contact
 */
Box2D.Dynamics.b2Island.prototype.AddContact = function(contact) {
  this.m_contacts[this.m_contactCount++] = contact;
};


/**
 * @param {Box2D.Dynamics.Joints.b2Joint} joint
 */
Box2D.Dynamics.b2Island.prototype.AddJoint = function(joint) {
  this.m_joints[this.m_jointCount++] = joint;
};


/**
 * @private
 * @type {*}
 */
Box2D.Dynamics.b2Island.prototype.Box2D_Dynamics_b2Island_m_allocator = undefined;


/**
 * @private
 * @type {Box2D.Dynamics.b2ContactListener}
 */
Box2D.Dynamics.b2Island.prototype.Box2D_Dynamics_b2Island_m_listener = null;


/**
 * @private
 * @type {Box2D.Dynamics.Contacts.b2ContactSolver}
 */
Box2D.Dynamics.b2Island.prototype.Box2D_Dynamics_b2Island_m_contactSolver = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.b2Island.prototype.m_bodies = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.b2Island.prototype.m_contacts = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.b2Island.prototype.m_joints = null;


/**
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.m_bodyCount = 0;


/**
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.m_jointCount = 0;


/**
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.m_contactCount = 0;


/**
 * @private
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.Box2D_Dynamics_b2Island_m_bodyCapacity = 0;


/**
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.m_contactCapacity = 0;


/**
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.m_jointCapacity = 0;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.b2Island.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2Island', qName: 'Box2D.Dynamics.b2Island', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.b2Island.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_bodies': { type: 'Array', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_bodies = v : inst.m_bodies;}},
        'm_contacts': { type: 'Array', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_contacts = v : inst.m_contacts;}},
        'm_joints': { type: 'Array', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_joints = v : inst.m_joints;}},
        'm_bodyCount': { type: 'int', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_bodyCount = v : inst.m_bodyCount;}},
        'm_jointCount': { type: 'int', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_jointCount = v : inst.m_jointCount;}},
        'm_contactCount': { type: 'int', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_contactCount = v : inst.m_contactCount;}},
        'm_contactCapacity': { type: 'int', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_contactCapacity = v : inst.m_contactCapacity;}},
        'm_jointCapacity': { type: 'int', get_set: function (/** Box2D.Dynamics.b2Island */ inst, /** * */ v) {return v !== undefined ? inst.m_jointCapacity = v : inst.m_jointCapacity;}}
      };
    },
    methods: function () {
      return {
        'b2Island': { type: '', declaredBy: 'Box2D.Dynamics.b2Island'},
        'Initialize': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'int', false ,'int', false ,'int', false ,'*', false ,'Box2D.Dynamics.b2ContactListener', false ,'Box2D.Dynamics.Contacts.b2ContactSolver', false ]; }},
        'Clear': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island'},
        'Solve': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ,'Box2D.Common.Math.b2Vec2', false ,'Boolean', false ]; }},
        'SolveTOI': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'Report': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Array', false ]; }},
        'AddBody': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ]; }},
        'AddContact': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Box2D.Dynamics.Contacts.b2Contact', false ]; }},
        'AddJoint': { type: 'void', declaredBy: 'Box2D.Dynamics.b2Island', parameters: function () { return [ 'Box2D.Dynamics.Joints.b2Joint', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.b2Island.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
Box2D.Dynamics.b2Island.prototype.ROYALE_INITIAL_STATICS = Object.keys(Box2D.Dynamics.b2Island);