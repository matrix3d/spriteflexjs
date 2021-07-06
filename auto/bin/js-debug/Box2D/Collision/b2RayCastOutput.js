/**
 * Generated by Apache Royale Compiler from Box2D/Collision/b2RayCastOutput.as
 * Box2D.Collision.b2RayCastOutput
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Collision.b2RayCastOutput');
/* Royale Dependency List: Box2D.Common.Math.b2Vec2*/




/**
 * @constructor
 */
Box2D.Collision.b2RayCastOutput = function() {

this.normal = new Box2D.Common.Math.b2Vec2();
};


/**
 * @type {Box2D.Common.Math.b2Vec2}
 */
Box2D.Collision.b2RayCastOutput.prototype.normal = null;


/**
 * @type {number}
 */
Box2D.Collision.b2RayCastOutput.prototype.fraction = NaN;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Collision.b2RayCastOutput.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2RayCastOutput', qName: 'Box2D.Collision.b2RayCastOutput', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Collision.b2RayCastOutput.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'normal': { type: 'Box2D.Common.Math.b2Vec2', get_set: function (/** Box2D.Collision.b2RayCastOutput */ inst, /** * */ v) {return v !== undefined ? inst.normal = v : inst.normal;}},
        'fraction': { type: 'Number', get_set: function (/** Box2D.Collision.b2RayCastOutput */ inst, /** * */ v) {return v !== undefined ? inst.fraction = v : inst.fraction;}}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Collision.b2RayCastOutput.prototype.ROYALE_COMPILE_FLAGS = 9;