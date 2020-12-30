/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/b2BodyDef.as
 * Box2D.Dynamics.b2BodyDef
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.b2BodyDef');
/* Royale Dependency List: Box2D.Common.Math.b2Vec2,Box2D.Dynamics.b2Body*/




/**
 * This constructor sets the body definition default values.
 * @constructor
 */
Box2D.Dynamics.b2BodyDef = function() {
  
  this.position = new Box2D.Common.Math.b2Vec2();
  this.linearVelocity = new Box2D.Common.Math.b2Vec2();
  this.userData = null;
  this.position.Set(0.0, 0.0);
  this.angle = 0.0;
  this.linearVelocity.Set(0, 0);
  this.angularVelocity = 0.0;
  this.linearDamping = 0.0;
  this.angularDamping = 0.0;
  this.allowSleep = true;
  this.awake = true;
  this.fixedRotation = false;
  this.bullet = false;
  this.type = Box2D.Dynamics.b2Body.b2_staticBody;
  this.active = true;
  this.inertiaScale = 1.0;
};


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.type = 0;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.b2BodyDef.prototype.position = null;


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.angle = NaN;


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Dynamics.b2BodyDef.prototype.linearVelocity = null;


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.angularVelocity = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.linearDamping = NaN;


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.angularDamping = NaN;


/**
 * @type {boolean}
 */
Box2D.Dynamics.b2BodyDef.prototype.allowSleep = false;


/**
 * @type {boolean}
 */
Box2D.Dynamics.b2BodyDef.prototype.awake = false;


/**
 * @type {boolean}
 */
Box2D.Dynamics.b2BodyDef.prototype.fixedRotation = false;


/**
 * @type {boolean}
 */
Box2D.Dynamics.b2BodyDef.prototype.bullet = false;


/**
 * @type {boolean}
 */
Box2D.Dynamics.b2BodyDef.prototype.active = false;


/**
 * @type {*}
 */
Box2D.Dynamics.b2BodyDef.prototype.userData = undefined;


/**
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.inertiaScale = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.b2BodyDef.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2BodyDef', qName: 'Box2D.Dynamics.b2BodyDef', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.b2BodyDef.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'type': { type: 'uint', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.type = v : inst.type;}},
        'position': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.position = v : inst.position;}},
        'angle': { type: 'Number', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.angle = v : inst.angle;}},
        'linearVelocity': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.linearVelocity = v : inst.linearVelocity;}},
        'angularVelocity': { type: 'Number', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.angularVelocity = v : inst.angularVelocity;}},
        'linearDamping': { type: 'Number', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.linearDamping = v : inst.linearDamping;}},
        'angularDamping': { type: 'Number', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.angularDamping = v : inst.angularDamping;}},
        'allowSleep': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.allowSleep = v : inst.allowSleep;}},
        'awake': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.awake = v : inst.awake;}},
        'fixedRotation': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.fixedRotation = v : inst.fixedRotation;}},
        'bullet': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.bullet = v : inst.bullet;}},
        'active': { type: 'Boolean', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.active = v : inst.active;}},
        'userData': { type: '*', get_set: function f(/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== f ? inst.userData = v : inst.userData;}},
        'inertiaScale': { type: 'Number', get_set: function (/** Box2D.Dynamics.b2BodyDef */ inst, /** * */ v) {return v !== undefined ? inst.inertiaScale = v : inst.inertiaScale;}}
      };
    },
    methods: function () {
      return {
        'b2BodyDef': { type: '', declaredBy: 'Box2D.Dynamics.b2BodyDef'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.b2BodyDef.prototype.ROYALE_COMPILE_FLAGS = 9;
