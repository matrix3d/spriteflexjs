/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Contacts/b2ContactEdge.as
 * Box2D.Dynamics.Contacts.b2ContactEdge
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Contacts.b2ContactEdge');
/* Royale Dependency List: Box2D.Dynamics.Contacts.b2Contact,Box2D.Dynamics.b2Body*/




/**
 * @constructor
 */
Box2D.Dynamics.Contacts.b2ContactEdge = function() {
};


/**
 * @type {Box2D.Dynamics.b2Body}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.other = null;


/**
 * @type {Box2D.Dynamics.Contacts.b2Contact}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.contact = null;


/**
 * @type {Box2D.Dynamics.Contacts.b2ContactEdge}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.prev = null;


/**
 * @type {Box2D.Dynamics.Contacts.b2ContactEdge}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.next = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2ContactEdge', qName: 'Box2D.Dynamics.Contacts.b2ContactEdge', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'other': { type: 'Box2D.Dynamics.b2Body', get_set: function (/** Box2D.Dynamics.Contacts.b2ContactEdge */ inst, /** * */ v) {return v !== undefined ? inst.other = v : inst.other;}},
        'contact': { type: 'Box2D.Dynamics.Contacts.b2Contact', get_set: function (/** Box2D.Dynamics.Contacts.b2ContactEdge */ inst, /** * */ v) {return v !== undefined ? inst.contact = v : inst.contact;}},
        'prev': { type: 'Box2D.Dynamics.Contacts.b2ContactEdge', get_set: function (/** Box2D.Dynamics.Contacts.b2ContactEdge */ inst, /** * */ v) {return v !== undefined ? inst.prev = v : inst.prev;}},
        'next': { type: 'Box2D.Dynamics.Contacts.b2ContactEdge', get_set: function (/** Box2D.Dynamics.Contacts.b2ContactEdge */ inst, /** * */ v) {return v !== undefined ? inst.next = v : inst.next;}}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Contacts.b2ContactEdge.prototype.ROYALE_COMPILE_FLAGS = 9;
