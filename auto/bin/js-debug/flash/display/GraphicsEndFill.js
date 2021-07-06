/**
 * Generated by Apache Royale Compiler from flash/display/GraphicsEndFill.as
 * flash.display.GraphicsEndFill
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.display.GraphicsEndFill');
/* Royale Dependency List: flash.__native.GLCanvasRenderingContext2D,flash.display.GraphicsBitmapFill,flash.geom.ColorTransform,flash.geom.Matrix,org.apache.royale.utils.Language*/

goog.require('flash.display.IGraphicsFill');
goog.require('flash.display.IGraphicsData');



/**
 * @constructor
 * @implements {flash.display.IGraphicsFill}
 * @implements {flash.display.IGraphicsData}
 */
flash.display.GraphicsEndFill = function() {
  
  this._worldMatrix = new flash.geom.Matrix();
  ;
};


/**
 * @type {flash.display.IGraphicsFill}
 */
flash.display.GraphicsEndFill.prototype.fill = null;


/**
 * @type {flash.geom.Matrix}
 */
flash.display.GraphicsEndFill.prototype._worldMatrix = null;


/**
 * @param {CanvasRenderingContext2D} ctx
 * @param {flash.geom.ColorTransform} colorTransform
 */
flash.display.GraphicsEndFill.prototype.draw = function(ctx, colorTransform) {
  if (this.fill) {
    if (org.apache.royale.utils.Language.is(this.fill, flash.display.GraphicsBitmapFill)) {
      var /** @type {flash.display.GraphicsBitmapFill} */ bfill = this.fill;
      if (bfill.matrix) {
        var /** @type {flash.geom.Matrix} */ m = bfill.matrix;
      }
      ctx.globalAlpha = colorTransform.alphaMultiplier;
    } else {
      ctx.globalAlpha = 1;
    }
    if (m) {
      ctx.save();
      ctx.transform(m.a, m.b, m.c, m.d, m.tx, m.ty);
    }
    ctx.fill();
    if (m) {
      ctx.restore();
    }
  }
};


/**
 * @royaleignorecoercion flash.display.GraphicsBitmapFill
 * @param {flash.__native.GLCanvasRenderingContext2D} ctx
 * @param {flash.geom.ColorTransform} colorTransform
 */
flash.display.GraphicsEndFill.prototype.gldraw = function(ctx, colorTransform) {
  if (this.fill && this.fill["matrix"]) {
    var /** @type {flash.geom.Matrix} */ m = /* implicit cast */ org.apache.royale.utils.Language.as(this.fill["matrix"], flash.geom.Matrix, true);
  }
  if (m) {
    this._worldMatrix.copyFrom(m);
  } else {
    this._worldMatrix.identity();
  }
  var /** @type {flash.geom.Matrix} */ temp = ctx.matr;
  ctx.transform2(this._worldMatrix);
  ctx.fill();
  ctx.matr = temp;
};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.display.GraphicsEndFill.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'GraphicsEndFill', qName: 'flash.display.GraphicsEndFill', kind: 'class' }], interfaces: [flash.display.IGraphicsFill, flash.display.IGraphicsData] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.display.GraphicsEndFill.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'fill': { type: 'flash.display.IGraphicsFill', get_set: function (/** flash.display.GraphicsEndFill */ inst, /** * */ v) {return v !== undefined ? inst.fill = v : inst.fill;}},
        '_worldMatrix': { type: 'flash.geom.Matrix', get_set: function (/** flash.display.GraphicsEndFill */ inst, /** * */ v) {return v !== undefined ? inst._worldMatrix = v : inst._worldMatrix;}}
      };
    },
    methods: function () {
      return {
        'GraphicsEndFill': { type: '', declaredBy: 'flash.display.GraphicsEndFill'},
        'draw': { type: 'void', declaredBy: 'flash.display.GraphicsEndFill', parameters: function () { return [ 'CanvasRenderingContext2D', false ,'flash.geom.ColorTransform', false ]; }},
        'gldraw': { type: 'void', declaredBy: 'flash.display.GraphicsEndFill', parameters: function () { return [ 'flash.__native.GLCanvasRenderingContext2D', false ,'flash.geom.ColorTransform', false ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.display.GraphicsEndFill.prototype.ROYALE_COMPILE_FLAGS = 9;