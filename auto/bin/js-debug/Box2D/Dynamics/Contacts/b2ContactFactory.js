/**
 * Generated by Apache Royale Compiler from Box2D/Dynamics/Contacts/b2ContactFactory.as
 * Box2D.Dynamics.Contacts.b2ContactFactory
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('Box2D.Dynamics.Contacts.b2ContactFactory');
/* Royale Dependency List: Box2D.Collision.Shapes.b2Shape,Box2D.Dynamics.Contacts.b2CircleContact,Box2D.Dynamics.Contacts.b2Contact,Box2D.Dynamics.Contacts.b2ContactRegister,Box2D.Dynamics.Contacts.b2EdgeAndCircleContact,Box2D.Dynamics.Contacts.b2PolyAndCircleContact,Box2D.Dynamics.Contacts.b2PolyAndEdgeContact,Box2D.Dynamics.Contacts.b2PolygonContact,Box2D.Dynamics.b2Fixture,org.apache.royale.utils.Language*/




/**
 * @constructor
 * @param {*} allocator
 */
Box2D.Dynamics.Contacts.b2ContactFactory = function(allocator) {
  this.Box2D_Dynamics_Contacts_b2ContactFactory_m_allocator = allocator;
  this.InitializeRegisters();
};


/**
 * @param {Function} createFcn
 * @param {Function} destroyFcn
 * @param {number} type1
 * @param {number} type2
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.AddType = function(createFcn, destroyFcn, type1, type2) {
  this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type1][type2].createFcn = createFcn;
  this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type1][type2].destroyFcn = destroyFcn;
  this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type1][type2].primary = true;
  if (type1 != type2) {
    this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type2][type1].createFcn = createFcn;
    this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type2][type1].destroyFcn = destroyFcn;
    this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type2][type1].primary = false;
  }
};


/**
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.InitializeRegisters = function() {
  this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers = new Array(Box2D.Collision.Shapes.b2Shape.e_shapeTypeCount);
  for (var /** @type {number} */ i = 0; i < Box2D.Collision.Shapes.b2Shape.e_shapeTypeCount; i++) {
    this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[i] = new Array(Box2D.Collision.Shapes.b2Shape.e_shapeTypeCount);
    for (var /** @type {number} */ j = 0; j < Box2D.Collision.Shapes.b2Shape.e_shapeTypeCount; j++) {
      this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[i][j] = new Box2D.Dynamics.Contacts.b2ContactRegister();
    }
  }
  this.AddType(Box2D.Dynamics.Contacts.b2CircleContact.Create, Box2D.Dynamics.Contacts.b2CircleContact.Destroy, Box2D.Collision.Shapes.b2Shape.e_circleShape, Box2D.Collision.Shapes.b2Shape.e_circleShape);
  this.AddType(Box2D.Dynamics.Contacts.b2PolyAndCircleContact.Create, Box2D.Dynamics.Contacts.b2PolyAndCircleContact.Destroy, Box2D.Collision.Shapes.b2Shape.e_polygonShape, Box2D.Collision.Shapes.b2Shape.e_circleShape);
  this.AddType(Box2D.Dynamics.Contacts.b2PolygonContact.Create, Box2D.Dynamics.Contacts.b2PolygonContact.Destroy, Box2D.Collision.Shapes.b2Shape.e_polygonShape, Box2D.Collision.Shapes.b2Shape.e_polygonShape);
  this.AddType(Box2D.Dynamics.Contacts.b2EdgeAndCircleContact.Create, Box2D.Dynamics.Contacts.b2EdgeAndCircleContact.Destroy, Box2D.Collision.Shapes.b2Shape.e_edgeShape, Box2D.Collision.Shapes.b2Shape.e_circleShape);
  this.AddType(Box2D.Dynamics.Contacts.b2PolyAndEdgeContact.Create, Box2D.Dynamics.Contacts.b2PolyAndEdgeContact.Destroy, Box2D.Collision.Shapes.b2Shape.e_polygonShape, Box2D.Collision.Shapes.b2Shape.e_edgeShape);
};


/**
 * @param {Box2D.Dynamics.b2Fixture} fixtureA
 * @param {Box2D.Dynamics.b2Fixture} fixtureB
 * @return {Box2D.Dynamics.Contacts.b2Contact}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.Create = function(fixtureA, fixtureB) {
  var /** @type {Box2D.Dynamics.Contacts.b2Contact} */ c = null;
  var /** @type {number} */ type1 = fixtureA.GetType();
  var /** @type {number} */ type2 = fixtureB.GetType();
  var /** @type {Box2D.Dynamics.Contacts.b2ContactRegister} */ reg = /* implicit cast */ org.apache.royale.utils.Language.as(this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type1][type2], Box2D.Dynamics.Contacts.b2ContactRegister, true);
  //var /** @type {Box2D.Dynamics.Contacts.b2Contact} */ c = null;
  if (reg.pool) {
    c = reg.pool;
    reg.pool = c.m_next;
    reg.poolCount--;
    c.Reset(fixtureA, fixtureB);
    return c;
  }
  var /** @type {Function} */ createFcn = reg.createFcn;
  if (createFcn != null) {
    if (reg.primary) {
      c = /* implicit cast */ org.apache.royale.utils.Language.as(createFcn(this.Box2D_Dynamics_Contacts_b2ContactFactory_m_allocator), Box2D.Dynamics.Contacts.b2Contact, true);
      c.Reset(fixtureA, fixtureB);
      return c;
    } else {
      c = /* implicit cast */ org.apache.royale.utils.Language.as(createFcn(this.Box2D_Dynamics_Contacts_b2ContactFactory_m_allocator), Box2D.Dynamics.Contacts.b2Contact, true);
      c.Reset(fixtureB, fixtureA);
      return c;
    }
  } else {
    return null;
  }
};


/**
 * @param {Box2D.Dynamics.Contacts.b2Contact} contact
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.Destroy = function(contact) {
  if (contact.m_manifold.m_pointCount > 0) {
    contact.m_fixtureA.m_body.SetAwake(true);
    contact.m_fixtureB.m_body.SetAwake(true);
  }
  var /** @type {number} */ type1 = contact.m_fixtureA.GetType();
  var /** @type {number} */ type2 = contact.m_fixtureB.GetType();
  var /** @type {Box2D.Dynamics.Contacts.b2ContactRegister} */ reg = /* implicit cast */ org.apache.royale.utils.Language.as(this.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers[type1][type2], Box2D.Dynamics.Contacts.b2ContactRegister, true);
  if (true) {
    reg.poolCount++;
    contact.m_next = reg.pool;
    reg.pool = contact;
  }
  var /** @type {Function} */ destroyFcn = reg.destroyFcn;
  destroyFcn(contact, this.Box2D_Dynamics_Contacts_b2ContactFactory_m_allocator);
};


/**
 * @private
 * @type {Array}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.Box2D_Dynamics_Contacts_b2ContactFactory_m_registers = null;


/**
 * @private
 * @type {*}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.Box2D_Dynamics_Contacts_b2ContactFactory_m_allocator = undefined;


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'b2ContactFactory', qName: 'Box2D.Dynamics.Contacts.b2ContactFactory', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    methods: function () {
      return {
        'b2ContactFactory': { type: '', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactFactory', parameters: function () { return [ '*', false ]; }},
        'AddType': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactFactory', parameters: function () { return [ 'Function', false ,'Function', false ,'int', false ,'int', false ]; }},
        'InitializeRegisters': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactFactory'},
        'Create': { type: 'Box2D.Dynamics.Contacts.b2Contact', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactFactory', parameters: function () { return [ 'Box2D.Dynamics.b2Fixture', false ,'Box2D.Dynamics.b2Fixture', false ]; }},
        'Destroy': { type: 'void', declaredBy: 'Box2D.Dynamics.Contacts.b2ContactFactory', parameters: function () { return [ 'Box2D.Dynamics.Contacts.b2Contact', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
Box2D.Dynamics.Contacts.b2ContactFactory.prototype.ROYALE_COMPILE_FLAGS = 9;