/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Controllers/b2Controller.as
 * Box2D.Dynamics.Controllers.b2Controller
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Controllers.b2Controller');
/* Royale Dependency List: Box2D.Dynamics.Controllers.b2ControllerEdge,Box2D.Dynamics.b2Body,Box2D.Dynamics.b2DebugDraw,Box2D.Dynamics.b2TimeStep,Box2D.Dynamics.b2World*/




/**
 * @constructor
 */
Box2D.Dynamics.Controllers.b2Controller = function() {
};


/**
 * @param {Box2D.Dynamics.b2TimeStep} step
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.Step = function(step) {
};


/**
 * @param {Box2D.Dynamics.b2DebugDraw} debugDraw
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.Draw = function(debugDraw) {
};


/**
 * @param {Box2D.Dynamics.b2Body} body
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.AddBody = function(body) {
  var /** @type {Box2D.Dynamics.Controllers.b2ControllerEdge} */ edge = new Box2D.Dynamics.Controllers.b2ControllerEdge();
  edge.controller = this;
  edge.body = body;
  edge.nextBody = this.m_bodyList;
  edge.prevBody = null;
  this.m_bodyList = edge;
  if (edge.nextBody)
    edge.nextBody.prevBody = edge;
  this.m_bodyCount++;
  edge.nextController = body.m_controllerList;
  edge.prevController = null;
  body.m_controllerList = edge;
  if (edge.nextController)
    edge.nextController.prevController = edge;
  body.m_controllerCount++;
};


/**
 * @param {Box2D.Dynamics.b2Body} body
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.RemoveBody = function(body) {
  var /** @type {Box2D.Dynamics.Controllers.b2ControllerEdge} */ edge = body.m_controllerList;
  while (edge && edge.controller != this)
    edge = edge.nextController;
  if (edge.prevBody)
    edge.prevBody.nextBody = edge.nextBody;
  if (edge.nextBody)
    edge.nextBody.prevBody = edge.prevBody;
  if (edge.nextController)
    edge.nextController.prevController = edge.prevController;
  if (edge.prevController)
    edge.prevController.nextController = edge.nextController;
  if (this.m_bodyList == edge)
    this.m_bodyList = edge.nextBody;
  if (body.m_controllerList == edge)
    body.m_controllerList = edge.nextController;
  body.m_controllerCount--;
  this.m_bodyCount--;
};


/**
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.Clear = function() {
  while (this.m_bodyList)
    this.RemoveBody(this.m_bodyList.body);
};


/**
 * @return {Box2D.Dynamics.Controllers.b2Controller}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.GetNext = function() {
  return this.m_next;
};


/**
 * @return {Box2D.Dynamics.b2World}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.GetWorld = function() {
  return this.m_world;
};


/**
 * @return {Box2D.Dynamics.Controllers.b2ControllerEdge}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.GetBodyList = function() {
  return this.m_bodyList;
};


/**
 * @type {Box2D.Dynamics.Controllers.b2Controller}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.m_next = null;


/**
 * @type {Box2D.Dynamics.Controllers.b2Controller}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.m_prev = null;


/**
 * @protected
 * @type {Box2D.Dynamics.Controllers.b2ControllerEdge}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.m_bodyList = null;


/**
 * @protected
 * @type {number}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.m_bodyCount = 0;


/**
 * @type {Box2D.Dynamics.b2World}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.m_world = null;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2Controller', qName: 'Box2D.Dynamics.Controllers.b2Controller', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'm_next': { type: 'Box2D.Dynamics.Controllers.b2Controller', get_set: function (/** Box2D.Dynamics.Controllers.b2Controller */ inst, /** * */ v) {return v !== undefined ? inst.m_next = v : inst.m_next;}},
        'm_prev': { type: 'Box2D.Dynamics.Controllers.b2Controller', get_set: function (/** Box2D.Dynamics.Controllers.b2Controller */ inst, /** * */ v) {return v !== undefined ? inst.m_prev = v : inst.m_prev;}},
        'm_world': { type: 'Box2D.Dynamics.b2World', get_set: function (/** Box2D.Dynamics.Controllers.b2Controller */ inst, /** * */ v) {return v !== undefined ? inst.m_world = v : inst.m_world;}}
      };
    },
    methods: function () {
      return {
        'Step': { type: 'void', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller', parameters: function () { return [ 'Box2D.Dynamics.b2TimeStep', false ]; }},
        'Draw': { type: 'void', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller', parameters: function () { return [ 'Box2D.Dynamics.b2DebugDraw', false ]; }},
        'AddBody': { type: 'void', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ]; }},
        'RemoveBody': { type: 'void', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller', parameters: function () { return [ 'Box2D.Dynamics.b2Body', false ]; }},
        'Clear': { type: 'void', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller'},
        'GetNext': { type: 'Box2D.Dynamics.Controllers.b2Controller', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller'},
        'GetWorld': { type: 'Box2D.Dynamics.b2World', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller'},
        'GetBodyList': { type: 'Box2D.Dynamics.Controllers.b2ControllerEdge', declaredBy: 'Box2D.Dynamics.Controllers.b2Controller'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Controllers.b2Controller.prototype.ROYALE_COMPILE_FLAGS = 9;