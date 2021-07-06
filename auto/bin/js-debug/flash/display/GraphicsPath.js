/**
 * Generated by Apache Royale Compiler from flash/display/GraphicsPath.as
 * flash.display.GraphicsPath
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.display.GraphicsPath');
/* Royale Dependency List: flash.__native.GLCanvasRenderingContext2D,flash.display.GraphicsPathCommand,flash.geom.ColorTransform,org.apache.royale.utils.Language*/

goog.require('flash.display.IGraphicsData');
goog.require('flash.display.IGraphicsPath');



/**
 * @constructor
 * @implements {flash.display.IGraphicsPath}
 * @implements {flash.display.IGraphicsData}
 * @param {Array.<number>=} commands
 * @param {Array.<number>=} data
 * @param {string=} winding
 */
flash.display.GraphicsPath = function(commands, data, winding) {
  commands = typeof commands !== 'undefined' ? commands : null;
  data = typeof data !== 'undefined' ? data : null;
  winding = typeof winding !== 'undefined' ? winding : "evenOdd";
  
  this.commands = new (org.apache.royale.utils.Language.synthVector('int'))();
  this.data = new (org.apache.royale.utils.Language.synthVector('Number'))();
  this.tris = [];
  ;
  this.commands = commands;
  this.data = data;
  if (this.commands == null) {
    this.commands = new (org.apache.royale.utils.Language.synthVector('int'))();
  }
  if (this.data == null) {
    this.data = new (org.apache.royale.utils.Language.synthVector('Number'))();
  }
  this.flash_display_GraphicsPath__winding = winding;
};


/**
 * @type {boolean}
 */
flash.display.GraphicsPath.prototype.gpuPath2DDirty = true;


/**
 * @type {Array.<number>}
 */
flash.display.GraphicsPath.prototype.commands = null;


/**
 * @type {Array.<number>}
 */
flash.display.GraphicsPath.prototype.data = null;


/**
 * @type {Array}
 */
flash.display.GraphicsPath.prototype.tris = null;


/**
 * @private
 * @type {string}
 */
flash.display.GraphicsPath.prototype.flash_display_GraphicsPath__winding = null;


/**
 */
flash.display.GraphicsPath.prototype.clear = function() {
  this.commands[org.apache.royale.utils.Language.SYNTH_TAG_FIELD].length = 0;
  this.data[org.apache.royale.utils.Language.SYNTH_TAG_FIELD].length = 0;
  this.tris.length = 0;
};


/**
 * @param {number} x
 * @param {number} y
 */
flash.display.GraphicsPath.prototype.moveTo = function(x, y) {
  this.commands.push(flash.display.GraphicsPathCommand.MOVE_TO);
  this.data.push(x, y);
};


/**
 * @param {number} x
 * @param {number} y
 */
flash.display.GraphicsPath.prototype.lineTo = function(x, y) {
  this.commands.push(flash.display.GraphicsPathCommand.LINE_TO);
  this.data.push(x, y);
};


/**
 * @param {number} controlX
 * @param {number} controlY
 * @param {number} anchorX
 * @param {number} anchorY
 */
flash.display.GraphicsPath.prototype.curveTo = function(controlX, controlY, anchorX, anchorY) {
  this.commands.push(flash.display.GraphicsPathCommand.CURVE_TO);
  this.data.push(controlX, controlY, anchorX, anchorY);
};


/**
 * @param {number} controlX1
 * @param {number} controlY1
 * @param {number} controlX2
 * @param {number} controlY2
 * @param {number} anchorX
 * @param {number} anchorY
 */
flash.display.GraphicsPath.prototype.cubicCurveTo = function(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY) {
  this.commands.push(flash.display.GraphicsPathCommand.CUBIC_CURVE_TO);
  this.data.push(controlX1, controlY1, controlX2, controlY2, anchorX, anchorY);
};


/**
 * @param {number} x
 * @param {number} y
 */
flash.display.GraphicsPath.prototype.wideLineTo = function(x, y) {
  this.commands.push(flash.display.GraphicsPathCommand.WIDE_LINE_TO);
  this.data.push(0.0, 0.0, x, y);
};


/**
 * @param {number} x
 * @param {number} y
 */
flash.display.GraphicsPath.prototype.wideMoveTo = function(x, y) {
  this.commands.push(flash.display.GraphicsPathCommand.WIDE_MOVE_TO);
  this.data.push(0.0, 0.0, x, y);
};


/**
 * @param {number} x
 * @param {number} y
 * @param {number} r
 * @param {number} a0
 * @param {number} a1
 */
flash.display.GraphicsPath.prototype.arc = function(x, y, r, a0, a1) {
  this.commands.push(flash.display.GraphicsPathCommand.ARC);
  this.data.push(x, y, r, a0, a1);
};


/**
 * @param {CanvasRenderingContext2D} ctx
 * @param {flash.geom.ColorTransform} colorTransform
 */
flash.display.GraphicsPath.prototype.draw = function(ctx, colorTransform) {
  if (this.commands.length) {
    ctx.beginPath();
    var /** @type {number} */ p = 0;
    var /** @type {number} */ trip = 0;
    var /** @type {number} */ len = (this.commands.length) >> 0;
    for (var /** @type {number} */ i = 0; i < len; i++) {
      var /** @type {number} */ cmd = (this.commands[i]) >> 0;
      switch (cmd) {
        case flash.display.GraphicsPathCommand.MOVE_TO:
          ctx.moveTo(this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.LINE_TO:
          ctx.lineTo(this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.CURVE_TO:
          ctx.quadraticCurveTo(this.data[p++], this.data[p++], this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.CUBIC_CURVE_TO:
          ctx.bezierCurveTo(this.data[p++], this.data[p++], this.data[p++], this.data[p++], this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.WIDE_MOVE_TO:
          p += 2;
          ctx.moveTo(this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.WIDE_LINE_TO:
          p += 2;
          ctx.lineTo(this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.ARC:
          ctx.arc(this.data[p++], this.data[p++], this.data[p++], this.data[p++], this.data[p++]);
          break;
        case flash.display.GraphicsPathCommand.DRAW_TRIANGLES:
          this.flash_display_GraphicsPath_doDrawTriangles(/* implicit cast */ org.apache.royale.utils.Language.as(this.tris[trip++], Array, true), ctx);
          break;
        case flash.display.GraphicsPathCommand.CLOSE_PATH:
          ctx.closePath();
          break;
      }
    }
  }
};


/**
 * @royaleignorecoercion flash.__native.GLCanvasRenderingContext2D
 * @param {Object} ctx
 * @param {flash.geom.ColorTransform} colorTransform
 */
flash.display.GraphicsPath.prototype.gldraw = function(ctx, colorTransform) {
  ctx.drawPath(this, colorTransform);
};


/**
 */
flash.display.GraphicsPath.prototype.closePath = function() {
  this.commands.push(flash.display.GraphicsPathCommand.CLOSE_PATH);
};


/**
 * @param {Array.<number>} vertices
 * @param {Array.<number>} indices
 * @param {Array.<number>} uvtData
 */
flash.display.GraphicsPath.prototype.drawTriangles = function(vertices, indices, uvtData) {
  this.tris.push([vertices, indices, uvtData]);
  this.commands.push(flash.display.GraphicsPathCommand.DRAW_TRIANGLES);
};


/**
 * @private
 * @param {Array} tri
 * @param {CanvasRenderingContext2D} ctx
 */
flash.display.GraphicsPath.prototype.flash_display_GraphicsPath_doDrawTriangles = function(tri, ctx) {
  var /** @type {Array.<number>} */ vertices = /* implicit cast */ org.apache.royale.utils.Language.as(tri[0], org.apache.royale.utils.Language.synthVector('Number'), true);
  var /** @type {Array.<number>} */ indices = /* implicit cast */ org.apache.royale.utils.Language.as(tri[1], org.apache.royale.utils.Language.synthVector('int'), true);
  var /** @type {number} */ len = (indices.length) >> 0;
  for (var /** @type {number} */ i = 0; i < len;) {
    var /** @type {number} */ i0 = (indices[i++]) >> 0;
    var /** @type {number} */ i1 = (indices[i++]) >> 0;
    var /** @type {number} */ i2 = (indices[i++]) >> 0;
    var /** @type {number} */ x0 = vertices[2 * i0];
    var /** @type {number} */ y0 = vertices[2 * i0 + 1];
    var /** @type {number} */ x1 = vertices[2 * i1];
    var /** @type {number} */ y1 = vertices[2 * i1 + 1];
    var /** @type {number} */ x2 = vertices[2 * i2];
    var /** @type {number} */ y2 = vertices[2 * i2 + 1];
    ctx.moveTo(x0, y0);
    ctx.lineTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.lineTo(x0, y0);
  }
};


flash.display.GraphicsPath.prototype.get__winding = function() {
  return this.flash_display_GraphicsPath__winding;
};


flash.display.GraphicsPath.prototype.set__winding = function(value) {
  this.flash_display_GraphicsPath__winding = value;
};


Object.defineProperties(flash.display.GraphicsPath.prototype, /** @lends {flash.display.GraphicsPath.prototype} */ {
/**
 * @type {string}
 */
winding: {
get: flash.display.GraphicsPath.prototype.get__winding,
set: flash.display.GraphicsPath.prototype.set__winding}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.display.GraphicsPath.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'GraphicsPath', qName: 'flash.display.GraphicsPath', kind: 'class' }], interfaces: [flash.display.IGraphicsPath, flash.display.IGraphicsData] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.display.GraphicsPath.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'gpuPath2DDirty': { type: 'Boolean', get_set: function (/** flash.display.GraphicsPath */ inst, /** * */ v) {return v !== undefined ? inst.gpuPath2DDirty = v : inst.gpuPath2DDirty;}},
        'commands': { type: 'Vector.<int>', get_set: function (/** flash.display.GraphicsPath */ inst, /** * */ v) {return v !== undefined ? inst.commands = v : inst.commands;}},
        'data': { type: 'Vector.<Number>', get_set: function (/** flash.display.GraphicsPath */ inst, /** * */ v) {return v !== undefined ? inst.data = v : inst.data;}},
        'tris': { type: 'Array', get_set: function (/** flash.display.GraphicsPath */ inst, /** * */ v) {return v !== undefined ? inst.tris = v : inst.tris;}}
      };
    },
    accessors: function () {
      return {
        'winding': { type: 'String', access: 'readwrite', declaredBy: 'flash.display.GraphicsPath'}
      };
    },
    methods: function () {
      return {
        'GraphicsPath': { type: '', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Vector.<int>', true ,'Vector.<Number>', true ,'String', true ]; }},
        'clear': { type: 'void', declaredBy: 'flash.display.GraphicsPath'},
        'moveTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'lineTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'curveTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ,'Number', false ,'Number', false ]; }},
        'cubicCurveTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ,'Number', false ,'Number', false ,'Number', false ,'Number', false ]; }},
        'wideLineTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'wideMoveTo': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ]; }},
        'arc': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Number', false ,'Number', false ,'Number', false ,'Number', false ,'Number', false ]; }},
        'draw': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'CanvasRenderingContext2D', false ,'flash.geom.ColorTransform', false ]; }},
        'gldraw': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'flash.__native.GLCanvasRenderingContext2D', false ,'flash.geom.ColorTransform', false ]; }},
        'closePath': { type: 'void', declaredBy: 'flash.display.GraphicsPath'},
        'drawTriangles': { type: 'void', declaredBy: 'flash.display.GraphicsPath', parameters: function () { return [ 'Vector.<Number>', false ,'Vector.<int>', false ,'Vector.<Number>', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.display.GraphicsPath.prototype.ROYALE_COMPILE_FLAGS = 9;