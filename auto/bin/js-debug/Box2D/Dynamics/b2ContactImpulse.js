/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/b2ContactImpulse.as
 * Box2D.Dynamics.b2ContactImpulse
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.b2ContactImpulse');
/* Royale Dependency List: Box2D.Common.b2Settings*/




/**
 * @constructor
 */
Box2D.Dynamics.b2ContactImpulse = function() {

this.normalImpulses = new Array(Box2D.Common.b2Settings.b2_maxManifoldPoints);
this.tangentImpulses = new Array(Box2D.Common.b2Settings.b2_maxManifoldPoints);
};


/**
 * @type {Array}
 */
Box2D.Dynamics.b2ContactImpulse.prototype.normalImpulses = null;


/**
 * @type {Array}
 */
Box2D.Dynamics.b2ContactImpulse.prototype.tangentImpulses = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.b2ContactImpulse.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2ContactImpulse', qName: 'Box2D.Dynamics.b2ContactImpulse', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.b2ContactImpulse.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'normalImpulses': { type: 'Array', get_set: function (/** Box2D.Dynamics.b2ContactImpulse */ inst, /** * */ v) {return v !== undefined ? inst.normalImpulses = v : inst.normalImpulses;}},
        'tangentImpulses': { type: 'Array', get_set: function (/** Box2D.Dynamics.b2ContactImpulse */ inst, /** * */ v) {return v !== undefined ? inst.tangentImpulses = v : inst.tangentImpulses;}}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.b2ContactImpulse.prototype.ROYALE_COMPILE_FLAGS = 9;
