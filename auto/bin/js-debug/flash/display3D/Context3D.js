/**
 * Generated by Apache Royale Compiler from flash/display3D/Context3D.as
 * flash.display3D.Context3D
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.display3D.Context3D');
/* Royale Dependency List: SpriteFlexjs,flash.display.BitmapData,flash.display3D.Context3DBlendFactor,flash.display3D.Context3DCompareMode,flash.display3D.Context3DProgramType,flash.display3D.Context3DTriangleFace,flash.display3D.Context3DVertexBufferFormat,flash.display3D.IndexBuffer3D,flash.display3D.Program3D,flash.display3D.VertexBuffer3D,flash.display3D.textures.CubeTexture,flash.display3D.textures.RectangleTexture,flash.display3D.textures.Texture,flash.display3D.textures.TextureBase,flash.display3D.textures.VideoTexture,flash.geom.Matrix3D,flash.geom.Rectangle,flash.utils.ByteArray,org.apache.royale.utils.Language*/

goog.require('flash.events.EventDispatcher');



/**
 * @constructor
 * @extends {flash.events.EventDispatcher}
 */
flash.display3D.Context3D = function() {
  
  this.flash_display3D_Context3D_currentTextures = {};
  this.flash_display3D_Context3D_currentVBufs = {};
  flash.display3D.Context3D.base(this, 'constructor');
};
goog.inherits(flash.display3D.Context3D, flash.events.EventDispatcher);


/**
 * @type {HTMLCanvasElement}
 */
flash.display3D.Context3D.prototype.canvas = null;


/**
 * @type {WebGLRenderingContext}
 */
flash.display3D.Context3D.prototype.gl = null;


/**
 * @private
 * @type {flash.display3D.Program3D}
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_currentProgram = null;


/**
 * @private
 * @type {Object}
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_currentTextures = null;


/**
 * @private
 * @type {Object}
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_currentVBufs = null;


/**
 * @param {boolean=} recreate
 */
flash.display3D.Context3D.prototype.dispose = function(recreate) {
  recreate = typeof recreate !== 'undefined' ? recreate : true;
};


/**
 * @param {number} width
 * @param {number} height
 * @param {number} antiAlias
 * @param {boolean=} enableDepthAndStencil
 * @param {boolean=} wantsBestResolution
 */
flash.display3D.Context3D.prototype.configureBackBuffer = function(width, height, antiAlias, enableDepthAndStencil, wantsBestResolution) {
  enableDepthAndStencil = typeof enableDepthAndStencil !== 'undefined' ? enableDepthAndStencil : true;
  wantsBestResolution = typeof wantsBestResolution !== 'undefined' ? wantsBestResolution : false;
  this.canvas.width = width;
  this.canvas.height = height;
  this.canvas.style.width = width + "px";
  this.canvas.style.height = height + "px";
  this.gl.viewport(0, 0, width, height);
  if (enableDepthAndStencil) {
    this.gl.enable(this.gl.DEPTH_TEST);
    this.gl.enable(this.gl.STENCIL_TEST);
  } else {
    this.gl.disable(this.gl.DEPTH_TEST);
    this.gl.disable(this.gl.STENCIL_TEST);
  }
};


/**
 * @param {number=} red
 * @param {number=} green
 * @param {number=} blue
 * @param {number=} alpha
 * @param {number=} depth
 * @param {number=} stencil
 * @param {number=} mask
 */
flash.display3D.Context3D.prototype.clear = function(red, green, blue, alpha, depth, stencil, mask) {
  red = typeof red !== 'undefined' ? red : 0;
  green = typeof green !== 'undefined' ? green : 0;
  blue = typeof blue !== 'undefined' ? blue : 0;
  alpha = typeof alpha !== 'undefined' ? alpha : 1;
  depth = typeof depth !== 'undefined' ? depth : 1;
  stencil = typeof stencil !== 'undefined' ? stencil : 0;
  mask = typeof mask !== 'undefined' ? mask : 4294967295;
  SpriteFlexjs.dirtyGraphics = true;
  this.gl.clearColor(red, green, blue, alpha);
  this.gl.clearDepth(depth);
  this.gl.clearStencil(stencil);
  this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);
};


/**
 * @param {flash.display3D.IndexBuffer3D} indexBuffer
 * @param {number=} firstIndex
 * @param {number=} numTriangles
 */
flash.display3D.Context3D.prototype.drawTriangles = function(indexBuffer, firstIndex, numTriangles) {
  firstIndex = typeof firstIndex !== 'undefined' ? firstIndex : 0;
  numTriangles = typeof numTriangles !== 'undefined' ? numTriangles : -1;
  this.gl.bindBuffer(this.gl.ELEMENT_ARRAY_BUFFER, indexBuffer.buff);
  this.gl.drawElements(this.gl.TRIANGLES, Number(numTriangles < 0 ? indexBuffer.count : numTriangles * 3), this.gl.UNSIGNED_SHORT, firstIndex * 2);
};


/**
 */
flash.display3D.Context3D.prototype.present = function() {
  SpriteFlexjs.dirtyGraphics = true;
};


/**
 * @param {flash.display3D.Program3D} program
 */
flash.display3D.Context3D.prototype.setProgram = function(program) {
  if (this.flash_display3D_Context3D_currentProgram != program) {
    this.flash_display3D_Context3D_currentProgram = program;
    this.gl.useProgram(program.program);
  }
};


/**
 * @param {string} programType
 * @param {number} firstRegister
 * @param {Array.<number>} data
 * @param {number=} numRegisters
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromVector = function(programType, firstRegister, data, numRegisters) {
  numRegisters = typeof numRegisters !== 'undefined' ? numRegisters : -1;
  this.setProgramConstantsFromVectorGL(this.flash_display3D_Context3D_getUniformLocationName(programType, firstRegister), data, numRegisters);
};


/**
 * @param {string} programType
 * @param {number} firstRegister
 * @param {flash.geom.Matrix3D} matrix
 * @param {boolean=} transposedMatrix
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromMatrix = function(programType, firstRegister, matrix, transposedMatrix) {
  transposedMatrix = typeof transposedMatrix !== 'undefined' ? transposedMatrix : false;
  this.setProgramConstantsFromMatrixGL(this.flash_display3D_Context3D_getUniformLocationName(programType, firstRegister), matrix, transposedMatrix);
};


/**
 * @param {string} programType
 * @param {number} firstRegister
 * @param {number} numRegisters
 * @param {flash.utils.ByteArray} data
 * @param {number} byteArrayOffset
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromByteArray = function(programType, firstRegister, numRegisters, data, byteArrayOffset) {
};


/**
 * @param {string} name
 * @param {Array.<number>} data
 * @param {number=} numRegisters
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromVectorGL = function(name, data, numRegisters) {
  numRegisters = typeof numRegisters !== 'undefined' ? numRegisters : -1;
  this.gl.uniform4fv(this.flash_display3D_Context3D_getUniformLocation(name), data);
};


/**
 * @royaleignorecoercion Object
 * @param {string} name
 * @param {flash.geom.Matrix3D} matrix
 * @param {boolean=} transposedMatrix
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromMatrixGL = function(name, matrix, transposedMatrix) {
  transposedMatrix = typeof transposedMatrix !== 'undefined' ? transposedMatrix : false;
  if (transposedMatrix) {
    matrix.transpose();
  }
  this.gl.uniformMatrix4fv(this.flash_display3D_Context3D_getUniformLocation(name), false, matrix.rawData);
  if (transposedMatrix) {
    matrix.transpose();
  }
};


/**
 * @param {string} name
 * @param {number} numRegisters
 * @param {flash.utils.ByteArray} data
 * @param {number} byteArrayOffset
 */
flash.display3D.Context3D.prototype.setProgramConstantsFromByteArrayGL = function(name, numRegisters, data, byteArrayOffset) {
};


/**
 * @private
 * @param {string} programType
 * @param {number} register
 * @return {string}
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_getUniformLocationName = function(programType, register) {
  return (flash.display3D.Context3DProgramType.VERTEX === programType) ? ("vc" + register) : ("fc" + register);
};


/**
 * @private
 * @param {string} name
 * @return {WebGLUniformLocation}
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_getUniformLocation = function(name) {
  return this.flash_display3D_Context3D_currentProgram.getUniformLocation(name);
};


/**
 * @param {number} index
 * @param {flash.display3D.VertexBuffer3D} buffer
 * @param {number=} bufferOffset
 * @param {string=} format
 */
flash.display3D.Context3D.prototype.setVertexBufferAt = function(index, buffer, bufferOffset, format) {
  bufferOffset = typeof bufferOffset !== 'undefined' ? bufferOffset : 0;
  format = typeof format !== 'undefined' ? format : "float4";
  this.setVertexBufferAtGL("va" + index, buffer, bufferOffset, format);
};


/**
 * @param {string} name
 * @param {flash.display3D.VertexBuffer3D} buffer
 * @param {number=} bufferOffset
 * @param {string=} format
 */
flash.display3D.Context3D.prototype.setVertexBufferAtGL = function(name, buffer, bufferOffset, format) {
  bufferOffset = typeof bufferOffset !== 'undefined' ? bufferOffset : 0;
  format = typeof format !== 'undefined' ? format : "float4";
  if (buffer.dirty || this.flash_display3D_Context3D_currentVBufs[name] != buffer) {
    buffer.dirty = false;
    this.flash_display3D_Context3D_currentVBufs[name] = buffer;
    var /** @type {number} */ loc = this.flash_display3D_Context3D_currentProgram.getAttribLocation(name);
    this.gl.bindBuffer(this.gl.ARRAY_BUFFER, buffer.buff);
    var /** @type {number} */ type = (this.gl.FLOAT) >> 0;
    var /** @type {number} */ size = 0;
    var /** @type {number} */ mul = 4;
    var /** @type {boolean} */ normalized = false;
    switch (format) {
      case flash.display3D.Context3DVertexBufferFormat.FLOAT_1:
        size = 1;
        break;
      case flash.display3D.Context3DVertexBufferFormat.FLOAT_2:
        size = 2;
        break;
      case flash.display3D.Context3DVertexBufferFormat.FLOAT_3:
        size = 3;
        break;
      case flash.display3D.Context3DVertexBufferFormat.FLOAT_4:
        size = 4;
        break;
      case flash.display3D.Context3DVertexBufferFormat.BYTES_4:
        size = 4;
        type = (this.gl.UNSIGNED_BYTE) >> 0;
        normalized = true;
        mul = 1;
        break;
    }
    this.gl.vertexAttribPointer(loc, size, type, normalized, buffer.data32PerVertex * mul, bufferOffset * mul);
  }
};


/**
 * @param {string} sourceFactor
 * @param {string} destinationFactor
 */
flash.display3D.Context3D.prototype.setBlendFactors = function(sourceFactor, destinationFactor) {
  this.gl.enable(this.gl.BLEND);
  this.gl.blendEquation(this.gl.FUNC_ADD);
  this.gl.blendFunc(flash.display3D.Context3DBlendFactor.getGLVal(this.gl, sourceFactor), flash.display3D.Context3DBlendFactor.getGLVal(this.gl, destinationFactor));
};


/**
 * @param {boolean} red
 * @param {boolean} green
 * @param {boolean} blue
 * @param {boolean} alpha
 */
flash.display3D.Context3D.prototype.setColorMask = function(red, green, blue, alpha) {
  this.gl.colorMask(red, green, blue, alpha);
};


/**
 * @param {boolean} depthMask
 * @param {string} passCompareMode
 */
flash.display3D.Context3D.prototype.setDepthTest = function(depthMask, passCompareMode) {
  this.gl.depthFunc(flash.display3D.Context3DCompareMode.getGLVal(this.gl, passCompareMode));
  this.gl.depthMask(depthMask);
};


/**
 * @param {number} sampler
 * @param {flash.display3D.textures.TextureBase} texture
 */
flash.display3D.Context3D.prototype.setTextureAt = function(sampler, texture) {
  if (texture == null) {
    this.flash_display3D_Context3D_setTextureInternal(sampler, null);
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.Texture)) {
    this.flash_display3D_Context3D_setTextureInternal(sampler, texture);
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.CubeTexture)) {
    this.flash_display3D_Context3D_setCubeTextureInternal(sampler, texture);
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.RectangleTexture)) {
    this.flash_display3D_Context3D_setRectangleTextureInternal(sampler, texture);
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.VideoTexture)) {
    this.flash_display3D_Context3D_setVideoTextureInternal(sampler, texture);
  }
};


/**
 * @param {flash.display3D.textures.TextureBase} texture
 * @param {boolean=} enableDepthAndStencil
 * @param {number=} antiAlias
 * @param {number=} surfaceSelector
 * @param {number=} colorOutputIndex
 */
flash.display3D.Context3D.prototype.setRenderToTexture = function(texture, enableDepthAndStencil, antiAlias, surfaceSelector, colorOutputIndex) {
  enableDepthAndStencil = typeof enableDepthAndStencil !== 'undefined' ? enableDepthAndStencil : false;
  antiAlias = typeof antiAlias !== 'undefined' ? antiAlias : 0;
  surfaceSelector = typeof surfaceSelector !== 'undefined' ? surfaceSelector : 0;
  colorOutputIndex = typeof colorOutputIndex !== 'undefined' ? colorOutputIndex : 0;
  var /** @type {number} */ targetType = 0;
  if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.Texture)) {
    targetType = 1;
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.CubeTexture)) {
    targetType = 2;
  } else if (org.apache.royale.utils.Language.is(texture, flash.display3D.textures.RectangleTexture)) {
    targetType = 3;
  } else if (texture != null) {
    throw "texture argument not derived from TextureBase (can be Texture, CubeTexture, or if supported, RectangleTexture)";
  }
  this.flash_display3D_Context3D_setRenderToTextureInternal(texture, (targetType) >> 0, enableDepthAndStencil, antiAlias, surfaceSelector, colorOutputIndex);
};


/**
 */
flash.display3D.Context3D.prototype.setRenderToBackBuffer = function() {
};


/**
 * @private
 * @param {flash.display3D.textures.TextureBase} param1
 * @param {number} param2
 * @param {boolean} param3
 * @param {number} param4
 * @param {number} param5
 * @param {number} param6
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_setRenderToTextureInternal = function(param1, param2, param3, param4, param5, param6) {
};


/**
 * @param {string} triangleFaceToCull
 */
flash.display3D.Context3D.prototype.setCulling = function(triangleFaceToCull) {
  if (triangleFaceToCull === flash.display3D.Context3DTriangleFace.NONE) {
    this.gl.disable(this.gl.CULL_FACE);
  } else {
    this.gl.enable(this.gl.CULL_FACE);
    this.gl.cullFace(flash.display3D.Context3DTriangleFace.getGLVal(this.gl, triangleFaceToCull));
  }
};


/**
 * @param {string=} triangleFace
 * @param {string=} compareMode
 * @param {string=} actionOnBothPass
 * @param {string=} actionOnDepthFail
 * @param {string=} actionOnDepthPassStencilFail
 */
flash.display3D.Context3D.prototype.setStencilActions = function(triangleFace, compareMode, actionOnBothPass, actionOnDepthFail, actionOnDepthPassStencilFail) {
  triangleFace = typeof triangleFace !== 'undefined' ? triangleFace : "frontAndBack";
  compareMode = typeof compareMode !== 'undefined' ? compareMode : "always";
  actionOnBothPass = typeof actionOnBothPass !== 'undefined' ? actionOnBothPass : "keep";
  actionOnDepthFail = typeof actionOnDepthFail !== 'undefined' ? actionOnDepthFail : "keep";
  actionOnDepthPassStencilFail = typeof actionOnDepthPassStencilFail !== 'undefined' ? actionOnDepthPassStencilFail : "keep";
};


/**
 * @param {number} referenceValue
 * @param {number=} readMask
 * @param {number=} writeMask
 */
flash.display3D.Context3D.prototype.setStencilReferenceValue = function(referenceValue, readMask, writeMask) {
  readMask = typeof readMask !== 'undefined' ? readMask : 255;
  writeMask = typeof writeMask !== 'undefined' ? writeMask : 255;
};


/**
 * @param {flash.geom.Rectangle} rectangle
 */
flash.display3D.Context3D.prototype.setScissorRectangle = function(rectangle) {
  if (rectangle == null) {
    this.gl.disable(this.gl.SCISSOR_TEST);
  } else {
    this.gl.enable(this.gl.SCISSOR_TEST);
    this.gl.scissor(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
  }
};


/**
 * @param {number} numVertices
 * @param {number} data32PerVertex
 * @param {string=} bufferUsage
 * @return {flash.display3D.VertexBuffer3D}
 */
flash.display3D.Context3D.prototype.createVertexBuffer = function(numVertices, data32PerVertex, bufferUsage) {
  bufferUsage = typeof bufferUsage !== 'undefined' ? bufferUsage : "staticDraw";
  var /** @type {flash.display3D.VertexBuffer3D} */ buffer = new flash.display3D.VertexBuffer3D();
  buffer.buff = this.gl.createBuffer();
  buffer.data32PerVertex = data32PerVertex;
  buffer.gl = this.gl;
  return buffer;
};


/**
 * @param {number} numIndices
 * @param {string=} bufferUsage
 * @return {flash.display3D.IndexBuffer3D}
 */
flash.display3D.Context3D.prototype.createIndexBuffer = function(numIndices, bufferUsage) {
  bufferUsage = typeof bufferUsage !== 'undefined' ? bufferUsage : "staticDraw";
  var /** @type {flash.display3D.IndexBuffer3D} */ buffer = new flash.display3D.IndexBuffer3D();
  buffer.buff = this.gl.createBuffer();
  buffer.gl = this.gl;
  buffer.count = numIndices;
  return buffer;
};


/**
 * @param {number} width
 * @param {number} height
 * @param {string} format
 * @param {boolean} optimizeForRenderToTexture
 * @param {number=} streamingLevels
 * @return {flash.display3D.textures.Texture}
 */
flash.display3D.Context3D.prototype.createTexture = function(width, height, format, optimizeForRenderToTexture, streamingLevels) {
  streamingLevels = typeof streamingLevels !== 'undefined' ? streamingLevels : 0;
  var /** @type {flash.display3D.textures.Texture} */ t = new flash.display3D.textures.Texture();
  t.gl = this.gl;
  t.texture = this.gl.createTexture();
  return t;
};


/**
 * @param {number} size
 * @param {string} format
 * @param {boolean} optimizeForRenderToTexture
 * @param {number=} streamingLevels
 * @return {flash.display3D.textures.CubeTexture}
 */
flash.display3D.Context3D.prototype.createCubeTexture = function(size, format, optimizeForRenderToTexture, streamingLevels) {
  streamingLevels = typeof streamingLevels !== 'undefined' ? streamingLevels : 0;
  return null;
};


/**
 * @param {number} width
 * @param {number} height
 * @param {string} format
 * @param {boolean} optimizeForRenderToTexture
 * @return {flash.display3D.textures.RectangleTexture}
 */
flash.display3D.Context3D.prototype.createRectangleTexture = function(width, height, format, optimizeForRenderToTexture) {
  return null;
};


/**
 * @return {flash.display3D.Program3D}
 */
flash.display3D.Context3D.prototype.createProgram = function() {
  var /** @type {flash.display3D.Program3D} */ p = new flash.display3D.Program3D();
  p.gl = this.gl;
  p.program = this.gl.createProgram();
  return p;
};


/**
 * @param {flash.display.BitmapData} destination
 */
flash.display3D.Context3D.prototype.drawToBitmapData = function(destination) {
};


/**
 * @param {number} sampler
 * @param {string} wrap
 * @param {string} filter
 * @param {string} mipfilter
 */
flash.display3D.Context3D.prototype.setSamplerStateAt = function(sampler, wrap, filter, mipfilter) {
};


/**
 * @private
 * @param {number} sampler
 * @param {flash.display3D.textures.Texture} texture
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_setTextureInternal = function(sampler, texture) {
  this.setTextureAtGL("fs" + sampler, sampler, texture);
};


/**
 * @param {string} name
 * @param {number} sampler
 * @param {flash.display3D.textures.Texture} texture
 */
flash.display3D.Context3D.prototype.setTextureAtGL = function(name, sampler, texture) {
  if (this.flash_display3D_Context3D_currentTextures[name] != texture || (texture && texture.up)) {
    this.flash_display3D_Context3D_currentTextures[name] = texture;
    if (texture) {
      texture.up = false;
      this.gl.activeTexture(Number(this.gl["TEXTURE" + sampler]));
      this.gl.bindTexture(this.gl.TEXTURE_2D, texture.texture);
      this.gl.uniform1i(this.flash_display3D_Context3D_currentProgram.getUniformLocation(name), sampler);
    }
  }
};


/**
 * @private
 * @param {number} param1
 * @param {flash.display3D.textures.CubeTexture} param2
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_setCubeTextureInternal = function(param1, param2) {
};


/**
 * @private
 * @param {number} param1
 * @param {flash.display3D.textures.RectangleTexture} param2
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_setRectangleTextureInternal = function(param1, param2) {
};


/**
 * @private
 * @param {number} param1
 * @param {flash.display3D.textures.VideoTexture} param2
 */
flash.display3D.Context3D.prototype.flash_display3D_Context3D_setVideoTextureInternal = function(param1, param2) {
};


/**
 * @return {flash.display3D.textures.VideoTexture}
 */
flash.display3D.Context3D.prototype.createVideoTexture = function() {
  return null;
};


flash.display3D.Context3D.prototype.get__driverInfo = function() {
  return null;
};


flash.display3D.Context3D.prototype.get__enableErrorChecking = function() {
  return false;
};


flash.display3D.Context3D.prototype.set__enableErrorChecking = function(toggle) {
};


flash.display3D.Context3D.prototype.get__profile = function() {
  return null;
};


flash.display3D.Context3D.prototype.get__backBufferWidth = function() {
  return 0;
};


flash.display3D.Context3D.prototype.get__backBufferHeight = function() {
  return 0;
};


flash.display3D.Context3D.prototype.get__maxBackBufferWidth = function() {
  return 0;
};


flash.display3D.Context3D.prototype.set__maxBackBufferWidth = function(width) {
};


flash.display3D.Context3D.prototype.get__maxBackBufferHeight = function() {
  return 0;
};


flash.display3D.Context3D.prototype.set__maxBackBufferHeight = function(height) {
};


Object.defineProperties(flash.display3D.Context3D.prototype, /** @lends {flash.display3D.Context3D.prototype} */ {
/**
 * @type {string}
 */
driverInfo: {
get: flash.display3D.Context3D.prototype.get__driverInfo},
/**
 * @type {boolean}
 */
enableErrorChecking: {
get: flash.display3D.Context3D.prototype.get__enableErrorChecking,
set: flash.display3D.Context3D.prototype.set__enableErrorChecking},
/**
 * @type {string}
 */
profile: {
get: flash.display3D.Context3D.prototype.get__profile},
/**
 * @type {number}
 */
backBufferWidth: {
get: flash.display3D.Context3D.prototype.get__backBufferWidth},
/**
 * @type {number}
 */
backBufferHeight: {
get: flash.display3D.Context3D.prototype.get__backBufferHeight},
/**
 * @type {number}
 */
maxBackBufferWidth: {
get: flash.display3D.Context3D.prototype.get__maxBackBufferWidth,
set: flash.display3D.Context3D.prototype.set__maxBackBufferWidth},
/**
 * @type {number}
 */
maxBackBufferHeight: {
get: flash.display3D.Context3D.prototype.get__maxBackBufferHeight,
set: flash.display3D.Context3D.prototype.set__maxBackBufferHeight}}
);


/**
 * @nocollapse
 * @export
 * @type {boolean}
 */
flash.display3D.Context3D.supportsVideoTexture;


flash.display3D.Context3D.get__supportsVideoTexture = function() {
  return false;
};


Object.defineProperties(flash.display3D.Context3D, /** @lends {flash.display3D.Context3D} */ {
/**
 * @type {boolean}
 */
supportsVideoTexture: {
get: flash.display3D.Context3D.get__supportsVideoTexture}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.display3D.Context3D.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'Context3D', qName: 'flash.display3D.Context3D', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.display3D.Context3D.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        'canvas': { type: 'HTMLCanvasElement', get_set: function (/** flash.display3D.Context3D */ inst, /** * */ v) {return v !== undefined ? inst.canvas = v : inst.canvas;}},
        'gl': { type: 'WebGLRenderingContext', get_set: function (/** flash.display3D.Context3D */ inst, /** * */ v) {return v !== undefined ? inst.gl = v : inst.gl;}}
      };
    },
    accessors: function () {
      return {
        '|supportsVideoTexture': { type: 'Boolean', access: 'readonly', declaredBy: 'flash.display3D.Context3D'},
        'driverInfo': { type: 'String', access: 'readonly', declaredBy: 'flash.display3D.Context3D'},
        'enableErrorChecking': { type: 'Boolean', access: 'readwrite', declaredBy: 'flash.display3D.Context3D'},
        'profile': { type: 'String', access: 'readonly', declaredBy: 'flash.display3D.Context3D'},
        'backBufferWidth': { type: 'int', access: 'readonly', declaredBy: 'flash.display3D.Context3D'},
        'backBufferHeight': { type: 'int', access: 'readonly', declaredBy: 'flash.display3D.Context3D'},
        'maxBackBufferWidth': { type: 'int', access: 'readwrite', declaredBy: 'flash.display3D.Context3D'},
        'maxBackBufferHeight': { type: 'int', access: 'readwrite', declaredBy: 'flash.display3D.Context3D'}
      };
    },
    methods: function () {
      return {
        'Context3D': { type: '', declaredBy: 'flash.display3D.Context3D'},
        'dispose': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'Boolean', true ]; }},
        'configureBackBuffer': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'int', false ,'int', false ,'Boolean', true ,'Boolean', true ]; }},
        'clear': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'Number', true ,'Number', true ,'Number', true ,'Number', true ,'Number', true ,'uint', true ,'uint', true ]; }},
        'drawTriangles': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'flash.display3D.IndexBuffer3D', false ,'int', true ,'int', true ]; }},
        'present': { type: 'void', declaredBy: 'flash.display3D.Context3D'},
        'setProgram': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'flash.display3D.Program3D', false ]; }},
        'setProgramConstantsFromVector': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'int', false ,'Vector.<Number>', false ,'int', true ]; }},
        'setProgramConstantsFromMatrix': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'int', false ,'flash.geom.Matrix3D', false ,'Boolean', true ]; }},
        'setProgramConstantsFromByteArray': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'int', false ,'int', false ,'flash.utils.ByteArray', false ,'uint', false ]; }},
        'setProgramConstantsFromVectorGL': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'Vector.<Number>', false ,'int', true ]; }},
        'setProgramConstantsFromMatrixGL': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'flash.geom.Matrix3D', false ,'Boolean', true ]; }},
        'setProgramConstantsFromByteArrayGL': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'int', false ,'flash.utils.ByteArray', false ,'uint', false ]; }},
        'setVertexBufferAt': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'flash.display3D.VertexBuffer3D', false ,'int', true ,'String', true ]; }},
        'setVertexBufferAtGL': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'flash.display3D.VertexBuffer3D', false ,'int', true ,'String', true ]; }},
        'setBlendFactors': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'String', false ]; }},
        'setColorMask': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'Boolean', false ,'Boolean', false ,'Boolean', false ,'Boolean', false ]; }},
        'setDepthTest': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'Boolean', false ,'String', false ]; }},
        'setTextureAt': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'flash.display3D.textures.TextureBase', false ]; }},
        'setRenderToTexture': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'flash.display3D.textures.TextureBase', false ,'Boolean', true ,'int', true ,'int', true ,'int', true ]; }},
        'setRenderToBackBuffer': { type: 'void', declaredBy: 'flash.display3D.Context3D'},
        'setCulling': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ]; }},
        'setStencilActions': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', true ,'String', true ,'String', true ,'String', true ,'String', true ]; }},
        'setStencilReferenceValue': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'uint', false ,'uint', true ,'uint', true ]; }},
        'setScissorRectangle': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'createVertexBuffer': { type: 'flash.display3D.VertexBuffer3D', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'int', false ,'String', true ]; }},
        'createIndexBuffer': { type: 'flash.display3D.IndexBuffer3D', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'String', true ]; }},
        'createTexture': { type: 'flash.display3D.textures.Texture', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'int', false ,'String', false ,'Boolean', false ,'int', true ]; }},
        'createCubeTexture': { type: 'flash.display3D.textures.CubeTexture', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'String', false ,'Boolean', false ,'int', true ]; }},
        'createRectangleTexture': { type: 'flash.display3D.textures.RectangleTexture', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'int', false ,'String', false ,'Boolean', false ]; }},
        'createProgram': { type: 'flash.display3D.Program3D', declaredBy: 'flash.display3D.Context3D'},
        'drawToBitmapData': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'flash.display.BitmapData', false ]; }},
        'setSamplerStateAt': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'int', false ,'String', false ,'String', false ,'String', false ]; }},
        'setTextureAtGL': { type: 'void', declaredBy: 'flash.display3D.Context3D', parameters: function () { return [ 'String', false ,'int', false ,'flash.display3D.textures.Texture', false ]; }},
        'createVideoTexture': { type: 'flash.display3D.textures.VideoTexture', declaredBy: 'flash.display3D.Context3D'}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.display3D.Context3D.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.display3D.Context3D.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.display3D.Context3D);
