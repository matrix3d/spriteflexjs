/**
 * Generated by Apache Royale Compiler from flash/events/Event.as
 * flash.events.Event
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.events.Event');
/* Royale Dependency List: */



/**
 * @constructor
 * @param {string} type
 * @param {boolean=} bubbles
 * @param {boolean=} cancelable
 */
flash.events.Event = function(type, bubbles, cancelable) {
  bubbles = typeof bubbles !== 'undefined' ? bubbles : false;
  cancelable = typeof cancelable !== 'undefined' ? cancelable : false;
  ;
  this.flash_events_Event_ctor(type, bubbles, cancelable);
};


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.ACTIVATE = "activate";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.ADDED = "added";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.ADDED_TO_STAGE = "addedToStage";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.BROWSER_ZOOM_CHANGE = "browserZoomChange";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CANCEL = "cancel";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CHANGE = "change";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CLEAR = "clear";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CLOSE = "close";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.COMPLETE = "complete";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CONNECT = "connect";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.COPY = "copy";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CUT = "cut";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.DEACTIVATE = "deactivate";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.ENTER_FRAME = "enterFrame";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.FRAME_CONSTRUCTED = "frameConstructed";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.EXIT_FRAME = "exitFrame";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.FRAME_LABEL = "frameLabel";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.ID3 = "id3";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.INIT = "init";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.MOUSE_LEAVE = "mouseLeave";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.OPEN = "open";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.PASTE = "paste";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.REMOVED = "removed";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.REMOVED_FROM_STAGE = "removedFromStage";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.RENDER = "render";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.RESIZE = "resize";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.SCROLL = "scroll";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.TEXT_INTERACTION_MODE_CHANGE = "textInteractionModeChange";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.SELECT = "select";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.SELECT_ALL = "selectAll";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.SOUND_COMPLETE = "soundComplete";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.TAB_CHILDREN_CHANGE = "tabChildrenChange";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.TAB_ENABLED_CHANGE = "tabEnabledChange";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.TAB_INDEX_CHANGE = "tabIndexChange";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.UNLOAD = "unload";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.FULLSCREEN = "fullScreen";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CONTEXT3D_CREATE = "context3DCreate";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.TEXTURE_READY = "textureReady";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.VIDEO_FRAME = "videoFrame";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.SUSPEND = "suspend";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CHANNEL_MESSAGE = "channelMessage";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.CHANNEL_STATE = "channelState";


/**
 * @nocollapse
 * @const
 * @type {string}
 */
flash.events.Event.WORKER_STATE = "workerState";


/**
 * @private
 * @type {string}
 */
flash.events.Event.prototype.flash_events_Event__type = null;


/**
 * @private
 * @type {boolean}
 */
flash.events.Event.prototype.flash_events_Event__bubbles = false;


/**
 * @private
 * @type {boolean}
 */
flash.events.Event.prototype.flash_events_Event__cancelable = false;


/**
 * @private
 * @type {Object}
 */
flash.events.Event.prototype.flash_events_Event__target = null;


/**
 * @private
 * @type {Object}
 */
flash.events.Event.prototype.flash_events_Event__currentTarget = null;


/**
 * @param {string} className
 * @param {...} args
 * @return {string}
 */
flash.events.Event.prototype.formatToString = function(className, args) {
  args = Array.prototype.slice.call(arguments, 1);
  return null;
};


/**
 * @private
 * @param {string} type
 * @param {boolean} bubbles
 * @param {boolean} cancelable
 */
flash.events.Event.prototype.flash_events_Event_ctor = function(type, bubbles, cancelable) {
  this.flash_events_Event__type = type;
  this.flash_events_Event__bubbles = bubbles;
  this.flash_events_Event__cancelable = cancelable;
};


/**
 * @return {flash.events.Event}
 */
flash.events.Event.prototype.clone = function() {
  return new flash.events.Event(this.type, this.bubbles, this.cancelable);
};


/**
 * @return {string}
 */
flash.events.Event.prototype.toString = function() {
  return this.formatToString("Event", "type", "bubbles", "cancelable", "eventPhase");
};


/**
 */
flash.events.Event.prototype.stopPropagation = function() {
};


/**
 */
flash.events.Event.prototype.stopImmediatePropagation = function() {
};


/**
 */
flash.events.Event.prototype.preventDefault = function() {
};


/**
 * @return {boolean}
 */
flash.events.Event.prototype.isDefaultPrevented = function() {
  return false;
};


flash.events.Event.prototype.get__type = function() {
  return this.flash_events_Event__type;
};


flash.events.Event.prototype.get__bubbles = function() {
  return this.flash_events_Event__bubbles;
};


flash.events.Event.prototype.get__cancelable = function() {
  return this.flash_events_Event__cancelable;
};


flash.events.Event.prototype.get__target = function() {
  return this.flash_events_Event__target;
};


flash.events.Event.prototype.set__target = function(value) {
  this.flash_events_Event__target = value;
};


flash.events.Event.prototype.get__currentTarget = function() {
  return this.flash_events_Event__currentTarget;
};


flash.events.Event.prototype.set__currentTarget = function(value) {
  this.flash_events_Event__currentTarget = value;
};


flash.events.Event.prototype.get__eventPhase = function() {
  return 0;
};


Object.defineProperties(flash.events.Event.prototype, /** @lends {flash.events.Event.prototype} */ {
/**
 * @type {string}
 */
type: {
get: flash.events.Event.prototype.get__type},
/**
 * @type {boolean}
 */
bubbles: {
get: flash.events.Event.prototype.get__bubbles},
/**
 * @type {boolean}
 */
cancelable: {
get: flash.events.Event.prototype.get__cancelable},
/**
 * @type {Object}
 */
target: {
get: flash.events.Event.prototype.get__target,
set: flash.events.Event.prototype.set__target},
/**
 * @type {Object}
 */
currentTarget: {
get: flash.events.Event.prototype.get__currentTarget,
set: flash.events.Event.prototype.set__currentTarget},
/**
 * @type {number}
 */
eventPhase: {
get: flash.events.Event.prototype.get__eventPhase}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.events.Event.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'Event', qName: 'flash.events.Event', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.events.Event.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        'type': { type: 'String', access: 'readonly', declaredBy: 'flash.events.Event'},
        'bubbles': { type: 'Boolean', access: 'readonly', declaredBy: 'flash.events.Event'},
        'cancelable': { type: 'Boolean', access: 'readonly', declaredBy: 'flash.events.Event'},
        'target': { type: 'Object', access: 'readwrite', declaredBy: 'flash.events.Event'},
        'currentTarget': { type: 'Object', access: 'readwrite', declaredBy: 'flash.events.Event'},
        'eventPhase': { type: 'uint', access: 'readonly', declaredBy: 'flash.events.Event'}
      };
    },
    methods: function () {
      return {
        'Event': { type: '', declaredBy: 'flash.events.Event', parameters: function () { return [ 'String', false ,'Boolean', true ,'Boolean', true ]; }},
        'formatToString': { type: 'String', declaredBy: 'flash.events.Event', parameters: function () { return [ 'String', false ,'Array', false ]; }},
        'clone': { type: 'flash.events.Event', declaredBy: 'flash.events.Event'},
        'toString': { type: 'String', declaredBy: 'flash.events.Event'},
        'stopPropagation': { type: 'void', declaredBy: 'flash.events.Event'},
        'stopImmediatePropagation': { type: 'void', declaredBy: 'flash.events.Event'},
        'preventDefault': { type: 'void', declaredBy: 'flash.events.Event'},
        'isDefaultPrevented': { type: 'Boolean', declaredBy: 'flash.events.Event'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.events.Event.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.events.Event.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.events.Event);
