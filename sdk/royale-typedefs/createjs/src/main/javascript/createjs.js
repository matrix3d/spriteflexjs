/*
 *
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */
// This file is in Google Closure Compiler Externs format which is a 
// non-copyrightable subset of EaselJS and TweenJS from https://github.com/CreateJS 
/**
 * @fileoverview
 * @externs
 */

/**
 * @param {(HTMLCanvasElement|Image|null)} alphaMap
 * @constructor
 * @extends createjs.Filter
 */
createjs.AlphaMapFilter = function (alphaMap) {}

/**
 */
createjs.AlphaMapFilter.prototype._prepAlphaMap = function () {  }

/**
 * @param {(Image|null)} mask 
 * @constructor
 * @extends createjs.Filter
 */
createjs.AlphaMaskFilter = function (mask) {}

/**
 * @param {(HTMLCanvasElement|HTMLVideoElement|Image|string|null)} imageOrUri
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.Bitmap = function (imageOrUri) {}

/**
 * @param {string=} opt_text
 * @param {createjs.SpriteSheet=} opt_spriteSheet
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.BitmapText = function (opt_text, opt_spriteSheet) {}

/**
 * @param {string} character 
 * @param {(createjs.SpriteSheet|null)} spriteSheet 
 * @see [BitmapText]
 * @returns {(Object|null)} 
 */
createjs.BitmapText.prototype._getFrame = function (character, spriteSheet) {  return null; }

/**
 * @param {string} character 
 * @param {(createjs.SpriteSheet|null)} spriteSheet 
 * @returns {(number|null)} 
 */
createjs.BitmapText.prototype._getFrameIndex = function (character, spriteSheet) { return 0; }

/**
 * @param {(createjs.SpriteSheet|null)} ss 
 * @returns {(number|null)} 
 */
createjs.BitmapText.prototype._getLineHeight = function (ss) { return 0; }

/**
 * @param {(createjs.SpriteSheet|null)} ss 
 * @returns {(number|null)} 
 */
createjs.BitmapText.prototype._getSpaceWidth = function (ss) { return 0; }

/**
 * @see [BitmapText]
 */
createjs.BitmapText.prototype._updateText = function () {  }

/** 
 * @param {number=} opt_blurX
 * @param {number=} opt_blurY
 * @param {number=} opt_quality
 * @constructor
 * @extends createjs.Filter
 */
createjs.BlurFilter = function (opt_blurX, opt_blurY, opt_quality) {}

/**
 * @param {(Sprite|createjs.MovieClip|null)} target
 * @param {string=} opt_outLabel
 * @param {string=} opt_overLabel
 * @param {string=} opt_downLabel
 * @param {boolean=} opt_play
 * @param {createjs.DisplayObject=} opt_hitArea
 * @param {string=} opt_hitLabel
 * @constructor
 */
createjs.ButtonHelper = function (target, opt_outLabel, opt_overLabel, opt_downLabel, opt_play, opt_hitArea, opt_hitLabel) {}

/**
 * @type {(boolean|null)} 
 */
createjs.ButtonHelper.prototype.enabled;

/**
 * @returns {(boolean|null)} 
 */
createjs.ButtonHelper.prototype.getEnabled = function () {  return null; }

/**
 * @param {(Object|null)} evt
 */
createjs.ButtonHelper.prototype.handleEvent = function (evt) {  }

/**
 * @param {(boolean|null)} value 
 */
createjs.ButtonHelper.prototype.setEnabled = function (value) {  }

/**
 * @returns {string}
 */
createjs.ButtonHelper.prototype.toString = function () { return ''; }

/**
 * @param {number=} opt_redMultiplier
 * @param {number=} opt_greenMultiplier
 * @param {number=} opt_blueMultiplier
 * @param {number=} opt_alphaMultiplier
 * @param {number=} opt_redOffset
 * @param {number=} opt_greenOffset
 * @param {number=} opt_blueOffset
 * @param {number=} opt_alphaOffset
 * @constructor
 * @extends createjs.Filter
 */
createjs.ColorFilter = function (opt_redMultiplier, opt_greenMultiplier, opt_blueMultiplier, opt_alphaMultiplier, opt_redOffset, opt_greenOffset, opt_blueOffset, opt_alphaOffset) {}

/**
 * @param {(number|null)} brightness 
 * @param {(number|null)} contrast 
 * @param {(number|null)} saturation 
 * @param {(number|null)} hue 
 * @constructor
 */
createjs.ColorMatrix = function (brightness, contrast, saturation, hue) {}

/**
 * @param {(number|null)} value
 * @param {(number|null)} limit
 */
createjs.ColorMatrix.prototype._cleanValue = function (value, limit) {  }

/**
 * @param {(Array|null)} matrix 
 */
createjs.ColorMatrix.prototype._fixMatrix = function (matrix) {  }

/**
 * @param {(Array|null)} matrix 
 */
createjs.ColorMatrix.prototype._multiplyMatrix = function (matrix) {  }

/**
 * @param {(number|null)} value
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.adjustBrightness = function (value) {  return null; }

/**
 * @param {(number|null)} brightness 
 * @param {(number|null)} contrast 
 * @param {(number|null)} saturation 
 * @param {(number|null)} hue 
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.adjustColor = function (brightness, contrast, saturation, hue) {  return null; }

/**
 * @param {(number|null)}
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.adjustContrast = function (value) {  return null; }

/**
 * @param {(number|null)} value
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.adjustHue = function (value) {  return null; }

/**
 * @param {(number|null)} value
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.adjustSaturation = function (value) {  return null; }

/**
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.clone = function () {  return null; }

/**
 * @param {(Array|null)} matrix
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.concat = function (matrix) {  return null; }

/**
 * @param {(Array|null)} matrix
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.copy = function (matrix) {  return null; }

/**
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.reset = function () {  return null; }

/**
 * @param {(number|null)} brightness 
 * @param {(number|null)} contrast 
 * @param {(number|null)} saturation 
 * @param {(number|null)} hue 
 * @returns {(createjs.ColorMatrix|null)}
 */
createjs.ColorMatrix.prototype.setColor = function (brightness, contrast, saturation, hue) {  return null; }

/**
 * @returns {(Array|null)} An array holding this matrix's values.
 */
createjs.ColorMatrix.prototype.toArray = function () {  return null; }

/**
 * @returns {string}
 */
createjs.ColorMatrix.prototype.toString = function () { return ''; }

/**
 * @param {(Array|createjs.ColorMatrix|null)} matrix
 * @constructor
 * @extends createjs.Filter
 */
createjs.ColorMatrixFilter = function (matrix) {}

/**
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.Container = function () {}

/**
 * @type {(number|null)} 
 */
createjs.Container.prototype.numChildren;

/**
 * @type {(Function|null)} 
 */
createjs.Container.prototype.onClick;

/**
 * @param {(createjs.Container|null)} o
 */
createjs.Container.prototype._cloneChildren = function (o) {  }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(Array|null)} arr 
 * @param {(boolean|null)} mouse
 * @param {(boolean|null)} activeListener
 * @param {(number|null)} currentDepth
 * @returns {(createjs.DisplayObject|null)} 
 */
createjs.Container.prototype._getObjectsUnderPoint = function (x, y, arr, mouse, activeListener, currentDepth) {  return null; }

/**
 * @param {(createjs.DisplayObject|null)} target 
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @returns {(boolean|null)}
 */
createjs.Container.prototype._testMask = function (target, x, y) {  return null; }

/**
 * @param {(createjs.DisplayObject|null)} child 
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.Container.prototype.addChild = function (child) {  return null; }


/**
 * @param {(createjs.DisplayObject|null)} child
 * @param {(number|null)} index
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.Container.prototype.addChildAt = function (child, index) {  return null; }

/**
 * @param {(createjs.DisplayObject|null)} child
 * @returns {(boolean|null)}
 */
createjs.Container.prototype.contains = function (child) {  return null; }

/**
 * @param {(number|null)} index
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.Container.prototype.getChildAt = function (index) {  return null; }

/**
 * @param {string} name
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.Container.prototype.getChildByName = function (name) {  return null; }

/**
 * @param {(createjs.DisplayObject|null)} child
 * @returns {(number|null)}
 */
createjs.Container.prototype.getChildIndex = function (child) { return 0; }


/**
 * @returns {(number|null)} 
 */
createjs.Container.prototype.getNumChildren = function () { return 0; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} mode
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.Container.prototype.getObjectUnderPoint = function (x, y, mode) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {number=} opt_mode
 * @returns {(Array|null)}
 */
createjs.Container.prototype.getObjectsUnderPoint = function (x, y, opt_mode) {  return null; }

/**
 */
createjs.Container.prototype.removeAllChildren = function () {  }

/**
 * @param {(createjs.DisplayObject|null)} child
 * @returns {(boolean|null)}
 */
createjs.Container.prototype.removeChild = function (child) {  return null; }

/**
 * @param {(number|null)} index
 * @returns {(boolean|null)}
 */
createjs.Container.prototype.removeChildAt = function (index) {  return null; }

/**
 * @param {(createjs.DisplayObject|null)} child 
 * @param {(number|null)} index 
 */
createjs.Container.prototype.setChildIndex = function (child, index) {  }

/**
 * @param {(Function|null)} sortFunction
 */
createjs.Container.prototype.sortChildren = function (sortFunction) {  }

/**
 * @param {(createjs.DisplayObject|null)} child1 
 * @param {(createjs.DisplayObject|null)} child2 
 */
createjs.Container.prototype.swapChildren = function (child1, child2) {  }

/**
 * @param {(number|null)} index1 
 * @param {(number|null)} index2 
 */
createjs.Container.prototype.swapChildrenAt = function (index1, index2) {  }

/**
 * @param {(HTMLElement|null)} htmlElement
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.DOMElement = function (htmlElement) {}

/**
 * @param {(Event|null)} evt 
 */
createjs.DOMElement.prototype._handleDrawEnd = function (evt) {  }

/**
 * @constructor
 * @extends createjs.EventDispatcher
 */
createjs.DisplayObject = function () {}

/**
 * @type {number} 
 */
createjs.DisplayObject.prototype.alpha;

/**
 * @type {(createjs.Graphics|null)} 
 */
createjs.DisplayObject.prototype.graphics;

/**
 * @type {number} 
 */
createjs.DisplayObject.prototype.height;

/**
 * @type {string} 
 */
createjs.DisplayObject.prototype.name;

/**
 * @type {(createjs.Stage|null)} 
 */
createjs.DisplayObject.prototype.stage;

/**
 * @type {boolean} 
 */
createjs.DisplayObject.prototype.visible;

/**
 * @type {number} 
 */
createjs.DisplayObject.prototype.width;

/**
 * @type {number} 
 */
createjs.DisplayObject.prototype.x;

/**
 * @type {number} 
 */
createjs.DisplayObject.prototype.y;

/**
 */
createjs.DisplayObject.prototype._applyFilters = function () {  }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx 
 * @param {(createjs.Shadow|null)} shadow 
 */
createjs.DisplayObject.prototype._applyShadow = function (ctx, shadow) {  }

/**
 * @param {(createjs.DisplayObject|null)} o
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.DisplayObject.prototype._cloneProps = function (o) {  return null; }

/**
 * @returns {(boolean|null)} 
 */
createjs.DisplayObject.prototype._hasMouseEventListener = function () {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix 
 * @param {(boolean|null)} ignoreTransform
 * @returns {(createjs.Rectangle|null)} 
 */
createjs.DisplayObject.prototype._getBounds = function (matrix, ignoreTransform) {  return null; }

/**
 * @returns {(createjs.Rectangle|null)} 
 */
createjs.DisplayObject.prototype._getFilterBounds = function (rect) {  return null; }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx 
 * @returns {(boolean|null)} 
 */
createjs.DisplayObject.prototype._testHit = function (ctx) {  return null; }

/**
 * @param {(Object|null)} evtObj
 */
createjs.DisplayObject.prototype._tick = function (evtObj) {  }

/**
 * @param {(createjs.Rectangle|null)} bounds 
 * @param {(createjs.Matrix2D|null)} matrix 
 * @param {(boolean|null)} ignoreTransform 
 * @returns {(createjs.Rectangle|null)} 
 */
createjs.DisplayObject.prototype._transformBounds = function (bounds, matrix, ignoreTransform) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} width
 * @param {(number|null)} height
 * @param {number=} opt_scale
 */
createjs.DisplayObject.prototype.cache = function (x, y, width, height, opt_scale) {  }

/**
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.DisplayObject.prototype.clone = function () {  return null; }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx
 * @param {boolean=} opt_ignoreCache
 * @returns {(boolean|null)} 
 */
createjs.DisplayObject.prototype.draw = function (ctx, opt_ignoreCache) {  return null; }

/**
 * @returns {(createjs.Rectangle|null)}
 */
createjs.DisplayObject.prototype.getBounds = function () {  return null; }

/**
 * @returns {string} The image data url for the cache.
 */
createjs.DisplayObject.prototype.getCacheDataURL = function () { return ''; }

/**
 * @param {createjs.DisplayProps=} opt_props
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayObject.prototype.getConcatenatedDisplayProps = function (opt_props) {  return null; }

/**
 * @param {createjs.Matrix2D=} opt_matrix
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.DisplayObject.prototype.getConcatenatedMatrix = function (opt_matrix) {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.DisplayObject.prototype.getMatrix = function (matrix) {  return null; }

/**
 * @returns {(createjs.Stage|null)} 
 */
createjs.DisplayObject.prototype.getStage = function () {  return null; }

/**
 * @returns {(createjs.Rectangle|null)}
 */
createjs.DisplayObject.prototype.getTransformedBounds = function () {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(Object|createjs.Point)=} opt_pt
 * @returns {(createjs.Point|null)}
 */
createjs.DisplayObject.prototype.globalToLocal = function (x, y, opt_pt) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @returns {(boolean|null)}
 */
createjs.DisplayObject.prototype.hitTest = function (x, y) {  return null; }

/**
 * @returns {(boolean|null)} Boolean
 */
createjs.DisplayObject.prototype.isVisible = function () {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(Object|createjs.Point)=} opt_pt 
 * @returns {(createjs.Point|null)} 
 */
createjs.DisplayObject.prototype.localToGlobal = function (x, y, opt_pt) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(createjs.DisplayObject|null)} target
 * @param {(Object|createjs.Point)=} opt_pt
 * @returns {(createjs.Point|null)}
 */
createjs.DisplayObject.prototype.localToLocal = function (x, y, target, opt_pt) {  return null; }

/**
 * @param {(Object|null)} props
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.DisplayObject.prototype.set = function (props) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} width
 * @param {(number|null)} height
 */
createjs.DisplayObject.prototype.setBounds = function (x, y, width, height) {  }

/**
 * @param {number=} opt_x
 * @param {number=} opt_y
 * @param {number=} opt_scaleX
 * @param {number=} opt_scaleY
 * @param {number=} opt_rotation
 * @param {number=} opt_skewX
 * @param {number=} opt_skewY
 * @param {number=} opt_regX
 * @param {number=} opt_regY
 * @returns {(createjs.DisplayObject|null)}
 */
createjs.DisplayObject.prototype.setTransform = function (opt_x, opt_y, opt_scaleX, opt_scaleY, opt_rotation, opt_skewX, opt_skewY, opt_regX, opt_regY) {  return null; }

/**
 */
createjs.DisplayObject.prototype.uncache = function () {  }

/**
 * @param {string} compositeOperation
 */
createjs.DisplayObject.prototype.updateCache = function (compositeOperation) {  }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx
 */
createjs.DisplayObject.prototype.updateContext = function (ctx) {  }

/**
 * @param {number=} opt_visible
 * @param {number=} opt_alpha
 * @param {number=} opt_shadow
 * @param {number=} opt_compositeOperation
 * @param {number=} opt_matrix
 * @constructor
 */
createjs.DisplayProps = function (opt_visible, opt_alpha, opt_shadow, opt_compositeOperation, opt_matrix) {}

/**
 * @param {(boolean|null)} visible
 * @param {(number|null)} alpha
 * @param {(createjs.Shadow|null)} shadow
 * @param {string} compositeOperation
 * @param {createjs.Matrix2D=} opt_matrix
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayProps.prototype.append = function (visible, alpha, shadow, compositeOperation, opt_matrix) {  return null; }

/**
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayProps.prototype.clone = function () {  return null; }

/**
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayProps.prototype.identity = function () {  return null; }

/**
 * @param {(boolean|null)} visible
 * @param {(number|null)} alpha
 * @param {(createjs.Shadow|null)} shadow
 * @param {string} compositeOperation
 * @param {createjs.Matrix2D=} opt_matrix
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayProps.prototype.prepend = function (visible, alpha, shadow, compositeOperation, opt_matrix) {  return null; }

/**
 * @param {number=} opt_visible
 * @param {number=} opt_alpha
 * @param {number=} opt_shadow
 * @param {number=} opt_compositeOperation
 * @param {number=} opt_matrix
 * @returns {(createjs.DisplayProps|null)}
 */
createjs.DisplayProps.prototype.setValues = function (opt_visible, opt_alpha, opt_shadow, opt_compositeOperation, opt_matrix) {  return null; }

/**
 * @constructor
 */
createjs.Ease = function () {}

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.bounceIn = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.bounceInOut = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.bounceOut = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.circIn = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.circInOut = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.circOut = function (t) { return 0; }

/**
 * @param {(number|null)} amount
 * @returns {(Function|null)} 
 */
createjs.Ease.get = function (amount) {  return null; }

/**
 * @param {(number|null)} amount
 * @returns {(Function|null)} 
 */
createjs.Ease.getBackIn = function (amount) {  return null; }

/**
 * @param {(number|null)} amount
 * @returns {(Function|null)} 
 */
createjs.Ease.getBackInOut = function (amount) {  return null; }

/**
 * @param {(number|null)} amount
 * @returns {(Function|null)} 
 */
createjs.Ease.getBackOut = function (amount) {  return null; }

/**
 * @param {(number|null)} amplitude 
 * @param {(number|null)} period 
 * @returns {(Function|null)} 
 */
createjs.Ease.getElasticIn = function (amplitude, period) {  return null; }

/**
 * @param {(number|null)} amplitude 
 * @param {(number|null)} period 
 * @returns {(Function|null)} 
 */
createjs.Ease.getElasticInOut = function (amplitude, period) {  return null; }

/**
 * @param {(number|null)} amplitude 
 * @param {(number|null)} period 
 * @returns {(Function|null)} 
 */
createjs.Ease.getElasticOut = function (amplitude, period) {  return null; }

/**
 * @param {(number|null)} pow
 * @returns {(Function|null)} 
 */
createjs.Ease.getPowIn = function (pow) {  return null; }

/**
 * @param {(number|null)} pow
 * @returns {(Function|null)} 
 */
createjs.Ease.getPowInOut = function (pow) {  return null; }

/**
 * @param {(number|null)} pow
 * @returns {(Function|null)} 
 */
createjs.Ease.getPowOut = function (pow) {  return null; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.linear = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.sineIn = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.sineInOut = function (t) { return 0; }

/**
 * @param {(number|null)} t 
 * @returns {(number|null)} 
 */
createjs.Ease.sineOut = function (t) { return 0; }

/**
 * @param {string} type
 * @param {(boolean|null)} bubbles
 * @param {(boolean|null)} cancelable
 * @constructor
 */
createjs.Event = function (type, bubbles, cancelable) {}

/**
 * @returns {(Event|null)}
 */
createjs.Event.prototype.clone = function () {  return null; }

/**
 */
createjs.Event.prototype.preventDefault = function () {  }

/**
 */
createjs.Event.prototype.remove = function () {  }

/**
 * @param {(Object|null)} props
 * @returns {(Event|null)} Returns
 */
createjs.Event.prototype.set = function (props) {  return null; }

/**
 */
createjs.Event.prototype.stopImmediatePropagation = function () {  }

/**
 */
createjs.Event.prototype.stopPropagation = function () {  }

/**
 * @returns {string}
 */
createjs.Event.prototype.toString = function () { return ''; }

/**
 * @constructor
 */
createjs.EventDispatcher = function () {}

/**
 * @param {(Event|Object|null)} eventObj 
 * @param {(Object|null)} eventPhase 
 */
createjs.EventDispatcher.prototype._dispatchEvent = function (eventObj, eventPhase) {  }

/**
 * @param {string} type
 * @param {(Object|null)} listener
 * @param {boolean=} opt_useCapture
 * @returns {(Object|null)}
 */
createjs.EventDispatcher.prototype.addEventListener = function (type, listener, opt_useCapture) {  return null; }

/**
 * @param {(Event|Object|null)} eventObj
 * @returns {(boolean|null)}
 */
createjs.EventDispatcher.prototype.dispatchEvent = function (eventObj) {  return null; }

/**
 * @param {string} type
 * @returns {(boolean|null)}
 */
createjs.EventDispatcher.prototype.hasEventListener = function (type) {  return null; }

/**
 * @param {(Object|null)} target The target object to inject EventDispatcher methods into. This can be an instance or a prototype.
 */
createjs.EventDispatcher.initialize = function (target) {  }

/**
 * @param {string} type
 * @param {(Object|null)} listener
 * @param {Object=} opt_scope
 * @param {boolean=} opt_once
 * @param {*=} opt_data
 * @param {boolean=} opt_useCapture
 * @returns {(Function|null)}
 */
createjs.EventDispatcher.prototype.on = function (type, listener, opt_scope, opt_once, opt_data, opt_useCapture) {  return null; }

/**
 * @param {string} type
 * @param {(Object|null)} listener
 * @param {boolean=} opt_useCapture
 */
createjs.EventDispatcher.prototype.removeEventListener = function (type, listener, opt_useCapture) {  }

/**
 * @param {string=} opt_type
 */
createjs.EventDispatcher.prototype.removeAllEventListeners = function (opt_type) {  }

/**
 * @returns {string}
 */
createjs.EventDispatcher.prototype.toString = function () { return ''; }

/**
 * @param {string} type
 * @returns {(boolean|null)}
 */
createjs.EventDispatcher.prototype.willTrigger = function (type) {  return null; }

/**
 * @constructor
 */
createjs.Filter = function () {}

/**
 * @param {(ImageData|null)} imageData
 * @returns {(boolean|null)} 
 */
createjs.Filter.prototype._applyFilter = function (imageData) {  return null; }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} width
 * @param {(number|null)} height
 * @param {CanvasRenderingContext2D=} opt_targetCtx
 * @param {number=} opt_targetX
 * @param {number=} opt_targetY
 * @returns {(boolean|null)}
 */
createjs.Filter.prototype.applyFilter = function (ctx, x, y, width, height, opt_targetCtx, opt_targetX, opt_targetY) {  return null; }

/**
 * @returns {(createjs.Filter|null)}
 */
createjs.Filter.prototype.clone = function () {  return null; }

/**
 * @param {createjs.Rectangle=} opt_rect
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Filter.prototype.getBounds = function (opt_rect) {  return null; }

/**
 * @returns {string}
 */
createjs.Filter.prototype.toString = function () { return ''; }

/**
 * @const
 * @suppress {duplicate|const} */
var createjs = {};


/**
 * @constructor
 */
createjs.Graphics = function () {}

/**
 * @type {(Array|null)} 
 */
createjs.Graphics.prototype.instructions;

/**
 * @param fill 
 */
createjs.Graphics.prototype._setFill = function (fill) {  }

/**
 * @param stroke 
 */
createjs.Graphics.prototype._setStroke = function (stroke) {  }

/**
 * @param commit 
 */
createjs.Graphics.prototype._updateInstructions = function (commit) {  }

/**
 * @param {(Object|null)} command
 * @param {boolean} clean
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.append = function (command, clean) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(number|null)} radius 
 * @param {(number|null)} startAngle
 * @param {(number|null)} endAngle
 * @param {(boolean|null)} anticlockwise 
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.arc = function (x, y, radius, startAngle, endAngle, anticlockwise) {  return null; }

/**
 * @param {(number|null)} x1 
 * @param {(number|null)} y1 
 * @param {(number|null)} x2 
 * @param {(number|null)} y2 
 * @param {(number|null)} radius 
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.arcTo = function (x1, y1, x2, y2, radius) {  return null; }

/**
 * @param {(HTMLCanvasElement|HTMLImageElement|HTMLVideoElement|null)} image
 * @param {string} repetition 
 * @param {(createjs.Matrix2D|null)} matrix
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginBitmapFill = function (image, repetition, matrix) {  return null; }

/**
 * @param {(HTMLCanvasElement|HTMLImageElement|HTMLVideoElement|null)} image
 * @param {string=} opt_repetition
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginBitmapStroke = function (image, opt_repetition) {  return null; }

/**
 * @param {string} color
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginFill = function (color) {  return null; }

/**
 * @param {(Array|null)} colors
 * @param {(Array|null)} ratios
 * @param {(number|null)} x0
 * @param {(number|null)} y0
 * @param {(number|null)} x1
 * @param {(number|null)} y1
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginLinearGradientFill = function (colors, ratios, x0, y0, x1, y1) {  return null; }

/**
 * @param {(Array|null)} colors
 * @param {(Array|null)} ratios
 * @param {(number|null)} x0
 * @param {(number|null)} y0
 * @param {(number|null)} x1
 * @param {(number|null)} y1
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginLinearGradientStroke = function (colors, ratios, x0, y0, x1, y1) {  return null; }

/**
 * @param {(Array|null)} colors
 * @param {(Array|null)} ratios
 * @param {(number|null)} x0
 * @param {(number|null)} y0
 * @param {(number|null)} r0
 * @param {(number|null)} x1
 * @param {(number|null)} y1
 * @param {(number|null)} r1
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginRadialGradientFill = function (colors, ratios, x0, y0, r0, x1, y1, r1) {  return null; }

/**
 * @param {(Array|null)} colors
 * @param {(Array|null)} ratios
 * @param {(number|null)} x0
 * @param {(number|null)} y0
 * @param {(number|null)} r0
 * @param {(number|null)} x1
 * @param {(number|null)} y1
 * @param {(number|null)} r1
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginRadialGradientStroke = function (colors, ratios, x0, y0, r0, x1, y1, r1) {  return null; }

/**
 * @param {string} color
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.beginStroke = function (color) {  return null; }

/**
 * @param {(number|null)} cp1x 
 * @param {(number|null)} cp1y 
 * @param {(number|null)} cp2x 
 * @param {(number|null)} cp2y 
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.bezierCurveTo = function (cp1x, cp1y, cp2x, cp2y, x, y) {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.clear = function () {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.clone = function () {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.closePath = function () {  return null; }

/**
 * @param {string} str
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.decodePath = function (str) {  return null; }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx
 * @param {(Object|null)} data
 */
createjs.Graphics.prototype.draw = function (ctx, data) {  }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx
 */
createjs.Graphics.prototype.drawAsPath = function (ctx) {  }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} radius
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.drawCircle = function (x, y, radius) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} w
 * @param {(number|null)} h
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.drawEllipse = function (x, y, w, h) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} radius
 * @param {(number|null)} sides
 * @param {(number|null)} pointSize
 * @param {(number|null)} angle
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.drawPolyStar = function (x, y, radius, sides, pointSize, angle) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(number|null)} w 
 * @param {(number|null)} h 
 * @param {(number|null)} radius
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.drawRoundRect = function (x, y, w, h, radius) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(number|null)} w
 * @param {(number|null)} h
 * @param {(number|null)} radiusTL
 * @param {(number|null)} radiusTR
 * @param {(number|null)} radiusBR
 * @param {(number|null)} radiusBL
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.drawRoundRectComplex = function (x, y, w, h, radiusTL, radiusTR, radiusBR, radiusBL) {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.endFill = function () {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.endStroke = function () {  return null; }

/**
 * @param {(number|null)} hue
 * @param {(number|null)} saturation
 * @param {(number|null)} lightness
 * @param {number=} opt_alpha
 * @returns {string}
 */
createjs.Graphics.getHSL = function (hue, saturation, lightness, opt_alpha) { return ''; }

/**
 * @returns {(Array|null)} 
 */
createjs.Graphics.prototype.getInstructions = function () {  return null; }

/**
 * @param {(number|null)} r
 * @param {(number|null)} g
 * @param {(number|null)} b
 * @param {number=} opt_alpha
 * @returns {string}
 */
createjs.Graphics.getRGB = function (r, g, b, opt_alpha) { return ''; }

/**
 * @returns {(boolean|null)}
 */
createjs.Graphics.prototype.isEmpty = function () {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.lineTo = function (x, y) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.moveTo = function (x, y) {  return null; }

/**
 * @param {(number|null)} cpx 
 * @param {(number|null)} cpy 
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.quadraticCurveTo = function (cpx, cpy, x, y) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(number|null)} w
 * @param {(number|null)} h
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.rect = function (x, y, w, h) {  return null; }

/**
 * @param {(number|null)} thickness
 * @param {(number|string)=} opt_caps 
 * @param {(number|string)=} opt_joints 
 * @param {number=} opt_miterLimit
 * @param {boolean=} opt_ignoreScale
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.setStrokeStyle = function (thickness, opt_caps, opt_joints, opt_miterLimit, opt_ignoreScale) {  return null; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.store = function () {  return null; }

/**
 * @returns {string}
 */
createjs.Graphics.prototype.toString = function () { return ''; }

/**
 * @returns {(createjs.Graphics|null)}
 */
createjs.Graphics.prototype.unstore = function () {  return null; }

/**
 * @param {number=} opt_a
 * @param {number=} opt_b
 * @param {number=} opt_c
 * @param {number=} opt_d
 * @param {number=} opt_tx
 * @param {number=} opt_ty
 * @constructor
 */
createjs.Matrix2D = function (opt_a, opt_b, opt_c, opt_d, opt_tx, opt_ty) {}

/**
 * @param {(number|null)} a 
 * @param {(number|null)} b 
 * @param {(number|null)} c 
 * @param {(number|null)} d 
 * @param {(number|null)} tx 
 * @param {(number|null)} ty 
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.append = function (a, b, c, d, tx, ty) {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix 
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.appendMatrix = function (matrix) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(number|null)} scaleX 
 * @param {(number|null)} scaleY 
 * @param {(number|null)} rotation 
 * @param {(number|null)} skewX 
 * @param {(number|null)} skewY 
 * @param {(number|null)} regX Optional.
 * @param {(number|null)} regY Optional.
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.appendTransform = function (x, y, scaleX, scaleY, rotation, skewX, skewY, regX, regY) {  return null; }

/**
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.clone = function () {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.copy = function (matrix) {  return null; }

/**
 * @param {(Object|null)} target
 * @returns {(Object|null)}
 */
createjs.Matrix2D.prototype.decompose = function (target) {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix
 * @returns {(boolean|null)} 
 */
createjs.Matrix2D.prototype.equals = function (matrix) {  return null; }

/**
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.identity = function () {  return null; }

/**
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.invert = function () {  return null; }

/**
 * @returns {(boolean|null)} 
 */
createjs.Matrix2D.prototype.isIdentity = function () {  return null; }

/**
 * @param {(number|null)} a 
 * @param {(number|null)} b 
 * @param {(number|null)} c 
 * @param {(number|null)} d 
 * @param {(number|null)} tx 
 * @param {(number|null)} ty 
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.prepend = function (a, b, c, d, tx, ty) {  return null; }

/**
 * @param {(createjs.Matrix2D|null)} matrix 
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.prependMatrix = function (matrix) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @param {(number|null)} scaleX 
 * @param {(number|null)} scaleY 
 * @param {(number|null)} rotation 
 * @param {(number|null)} skewX 
 * @param {(number|null)} skewY 
 * @param {(number|null)} regX
 * @param {(number|null)} regY
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.prependTransform = function (x, y, scaleX, scaleY, rotation, skewX, skewY, regX, regY) {  return null; }

/**
 * @param {(number|null)} angle
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.rotate = function (angle) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.scale = function (x, y) {  return null; }

/**
 * @param {number=} opt_a
 * @param {number=} opt_b
 * @param {number=} opt_c
 * @param {number=} opt_d
 * @param {number=} opt_tx
 * @param {number=} opt_ty
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.setValues = function (opt_a, opt_b, opt_c, opt_d, opt_tx, opt_ty) {  return null; }

/**
 * @param {(number|null)} skewX
 * @param {(number|null)} skewY
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.skew = function (skewX, skewY) {  return null; }

/**
 * @returns {string}
 */
createjs.Matrix2D.prototype.toString = function () { return ''; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {(Object|createjs.Point)=} opt_pt
 * @returns {(createjs.Point|null)}
 */
createjs.Matrix2D.prototype.transformPoint = function (x, y, opt_pt) {  return null; }

/**
 * @param {(number|null)} x 
 * @param {(number|null)} y 
 * @returns {(createjs.Matrix2D|null)}
 */
createjs.Matrix2D.prototype.translate = function (x, y) {  return null; }

/**
 * @param {string} type
 * @param {(boolean|null)} bubbles
 * @param {(boolean|null)} cancelable
 * @param {(number|null)} stageX
 * @param {(number|null)} stageY
 * @param {(MouseEvent|null)} nativeEvent
 * @param {(number|null)} pointerID
 * @param {(boolean|null)} primary
 * @param {(number|null)} rawX
 * @param {(number|null)} rawY
 * @constructor
 * @extends createjs.Event
 */
createjs.MouseEvent = function (type, bubbles, cancelable, stageX, stageY, nativeEvent, pointerID, primary, rawX, rawY) {}

/**
 */
createjs.MouseEvent.prototype._get_isTouch = function () {  }

/**
 */
createjs.MouseEvent.prototype._get_localX = function () {  }

/**
 */
createjs.MouseEvent.prototype._get_localY = function () {  }

/**
 * @param {string=} opt_mode
 * @param {number=} opt_startPosition
 * @param {boolean=} opt_loop
 * @param {Object=} opt_labels
 * @constructor
 * @extends createjs.Container
 */
createjs.MovieClip = function (opt_mode, opt_startPosition, opt_loop, opt_labels) {}

/**
 * @param {(createjs.MovieClip|null)} child
 * @param {(number|null)} offset 
 */
createjs.MovieClip.prototype._addManagedChild = function (child, offset) {  }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.MovieClip.prototype._goto = function (positionOrLabel) {  }

/**
 */
createjs.MovieClip.prototype._reset = function () {  }

/**
 * @param {(Array|null)} state 
 * @param {(number|null)} offset 
 */
createjs.MovieClip.prototype._setState = function (state, offset) {  }

/**
 */
createjs.MovieClip.prototype._updateTimeline = function () {  }

/**
 * @param {(number|null)} time
 */
createjs.MovieClip.prototype.advance = function (time) {  }

/**
 * @returns {string} 
 */
createjs.MovieClip.prototype.getCurrentLabel = function () { return ''; }

/**
 * @returns {(Array|null)} 
 */
createjs.MovieClip.prototype.getLabels = function () {  return null; }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.MovieClip.prototype.gotoAndPlay = function (positionOrLabel) {  }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.MovieClip.prototype.gotoAndStop = function (positionOrLabel) {  }

/**
 */
createjs.MovieClip.prototype.play = function () {  }

/**
 */
createjs.MovieClip.prototype.stop = function () {  }

/**
 * @param {number=} opt_x X
 * @param {number=} opt_y Y
 * @constructor
 */
createjs.Point = function (opt_x, opt_y) {}

/**
 * @returns {(createjs.Point|null)}
 */
createjs.Point.prototype.clone = function () {  return null; }

/**
 * @param {(createjs.Point|null)} point
 * @returns {(createjs.Point|null)}
 */
createjs.Point.prototype.copy = function (point) {  return null; }

/**
 * @param {number=} opt_x
 * @param {number=} opt_y
 * @returns {(createjs.Point|null)}
 */
createjs.Point.prototype.setValues = function (opt_x, opt_y) {  return null; }

/**
 * @returns {string}
 */
createjs.Point.prototype.toString = function () { return ''; }

/**
 * @param {number=} opt_x
 * @param {number=} opt_y
 * @param {number=} opt_width
 * @param {number=} opt_height
 * @constructor
 */
createjs.Rectangle = function (opt_x, opt_y, opt_width, opt_height) {}

/**
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.clone = function () {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {number=} opt_width
 * @param {number=} opt_height
 * @returns {(boolean|null)}
 */
createjs.Rectangle.prototype.contains = function (x, y, opt_width, opt_height) {  return null; }

/**
 * @param {(createjs.Rectangle|null)} rectangle
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.copy = function (rectangle) {  return null; }

/**
 * @param {(number|null)} x
 * @param {(number|null)} y
 * @param {number=} opt_width
 * @param {number=} opt_height
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.extend = function (x, y, opt_width, opt_height) {  return null; }

/**
 * @param {(createjs.Rectangle|null)} rect
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.intersection = function (rect) {  return null; }

/**
 * @param {(createjs.Rectangle|null)} rect
 * @returns {(boolean|null)}
 */
createjs.Rectangle.prototype.intersects = function (rect) {  return null; }

/**
 * @returns {(boolean|null)}
 */
createjs.Rectangle.prototype.isEmpty = function () {  return null; }

/**
 * @param {number=} opt_top 
 * @param {number=} opt_left 
 * @param {number=} opt_right 
 * @param {number=} opt_bottom 
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.pad = function (opt_top, opt_left, opt_right, opt_bottom) {  return null; }

/**
 * @param {number=} opt_x
 * @param {number=} opt_y
 * @param {number=} opt_width
 * @param {number=} opt_height
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.setValues = function (opt_x, opt_y, opt_width, opt_height) {  return null; }

/**
 * @returns {string}
 */
createjs.Rectangle.prototype.toString = function () { return ''; }

/**
 * @param {(createjs.Rectangle|null)} rect
 * @returns {(createjs.Rectangle|null)}
 */
createjs.Rectangle.prototype.union = function (rect) {  return null; }

/**
 * @param {string} color
 * @param {(number|null)} offsetX
 * @param {(number|null)} offsetY
 * @param {(number|null)} blur
 * @constructor
 */
createjs.Shadow = function (color, offsetX, offsetY, blur) {}

/**
 * @returns {(createjs.Shadow|null)}
 */
createjs.Shadow.prototype.clone = function () {  return null; }

/**
 * @returns {string}
 */
createjs.Shadow.prototype.toString = function () { return ''; }

/**
 * @param {(createjs.Graphics|null)} graphics
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.Shape = function (graphics) {}

/**
 * @param {(createjs.SpriteSheet|null)} spriteSheet
 * @param {(number|string)=} opt_frameOrAnimation
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.Sprite = function (spriteSheet, opt_frameOrAnimation) {}

/**
 */
createjs.Sprite.prototype._dispatchAnimationEnd = function (animation, frame, paused, next, end) {  }

/**
 * @param {(number|string|null)} frameOrAnimation
 * @param {boolean=} opt_frame
 */
createjs.Sprite.prototype._goto = function (frameOrAnimation, opt_frame) {  }

/**
 */
createjs.Sprite.prototype._normalizeFrame = function (frameDelta) {  }

/**
 * @param {(number|null)} time
 */
createjs.Sprite.prototype.advance = function (time) {  }

/**
 * @param {(number|string|null)} frameOrAnimation
 */
createjs.Sprite.prototype.gotoAndPlay = function (frameOrAnimation) {  }

/**
 * @param {(number|string|null)} frameOrAnimation
 */
createjs.Sprite.prototype.gotoAndStop = function (frameOrAnimation) {  }

/**
 */
createjs.Sprite.prototype.play = function () {  }

/**
 */
createjs.Sprite.prototype.stop = function () {  }

/**
 * @param {createjs.SpriteSheet=} opt_spriteSheet
 * @constructor
 * @extends createjs.Container
 */
createjs.SpriteContainer = function (opt_spriteSheet) {}

/**
 * @param {(Object|null)} data
 * @constructor
 * @extends createjs.EventDispatcher
 */
createjs.SpriteSheet = function (data) {}

/**
 * @type {(Array|null)} 
 */
createjs.SpriteSheet.prototype.animations;

/**
 */
createjs.SpriteSheet.prototype._calculateFrames = function () {  }

/**
 */
createjs.SpriteSheet.prototype._handleImageLoad = function () {  }

/**
 * @param {(Object|null)} data
 */
createjs.SpriteSheet.prototype._parseData = function (data) {  }

/**
 */
createjs.SpriteSheet.prototype.clone = function () {  }

/**
 * @param {string} name
 * @returns {(Object|null)}
 */
createjs.SpriteSheet.prototype.getAnimation = function (name) {  return null; }

/**
 * @returns {(Array|null)} 
 */
createjs.SpriteSheet.prototype.getAnimations = function () {  return null; }

/**
 * @param {(number|null)} frameIndex
 * @returns {(Object|null)}
 */
createjs.SpriteSheet.prototype.getFrame = function (frameIndex) {  return null; }

/**
 * @param {(number|null)} frameIndex
 * @param {createjs.Rectangle=} opt_rectangle
 * @returns {(createjs.Rectangle|null)}
 */
createjs.SpriteSheet.prototype.getFrameBounds = function (frameIndex, opt_rectangle) {  return null; }

/**
 * @param {string} animation
 * @returns {(number|null)}
 */
createjs.SpriteSheet.prototype.getNumFrames = function (animation) { return 0; }

/**
 * @constructor
 * @extends createjs.EventDispatcher
 */
createjs.SpriteSheetBuilder = function () {}

/**
 * @returns {?}
 */
createjs.SpriteSheetBuilder.prototype._drawNext = function () {  return null; }

/**
 */
createjs.SpriteSheetBuilder.prototype._endBuild = function () {  }

/**
 * @param {(Array|null)} frames 
 * @param {(number|null)} y 
 * @param {(Image|null)} img 
 * @param {(Object|null)} dataFrames 
 * @param {(number|null)} pad 
 * @returns {(number|null)}
 */
createjs.SpriteSheetBuilder.prototype._fillRow = function (frames, y, img, dataFrames, pad) { return 0; }

/**
 * @returns {(number|null)}
 */
createjs.SpriteSheetBuilder.prototype._getSize = function (size, max) { return 0; }

/**
 */
createjs.SpriteSheetBuilder.prototype._run = function () {  }

/**
 * @returns {(number|null)}
 */
createjs.SpriteSheetBuilder.prototype._setupMovieClipFrame = function (source, data) { return 0; }

/**
 */
createjs.SpriteSheetBuilder.prototype._startBuild = function () {  }

/**
 * @param {string} name
 * @param {(Array|null)} frames
 * @param {string=} opt_next
 * @param {number=} opt_frequency
 */
createjs.SpriteSheetBuilder.prototype.addAnimation = function (name, frames, opt_next, opt_frequency) {  }


/**
 * @param {(createjs.DisplayObject|null)} source
 * @param {createjs.Rectangle=} opt_sourceRect
 * @param {number=} opt_scale
 * @param {Function=} opt_setupFunction
 * @param {Object=} opt_setupData
 * @returns {(number|null)}
 */
createjs.SpriteSheetBuilder.prototype.addFrame = function (source, opt_sourceRect, opt_scale, opt_setupFunction, opt_setupData) { return 0; }

/**
 * @param {(createjs.MovieClip|null)} source
 * @param {createjs.Rectangle=} opt_sourceRect
 * @param {number=} opt_scale
 * @param {Function=} opt_setupFunction
 * @param {Object=} opt_setupData
 * @param {Function=} opt_labelFunction
 */
createjs.SpriteSheetBuilder.prototype.addMovieClip = function (source, opt_sourceRect, opt_scale, opt_setupFunction, opt_setupData, opt_labelFunction) {  }

/**
 * @returns {(createjs.SpriteSheet|null)}
 */
createjs.SpriteSheetBuilder.prototype.build = function () {  return null; }

/**
 * @param {number=} opt_timeSlice
 */
createjs.SpriteSheetBuilder.prototype.buildAsync = function (opt_timeSlice) {  }

/**
 */
createjs.SpriteSheetBuilder.prototype.clone = function () {  }

/**
 */
createjs.SpriteSheetBuilder.prototype.stopAsync = function () {  }

/**
 * @param {(HTMLCanvasElement|Object|null)} canvas
 * @param {(boolean|null)} preserveDrawingBuffer
 * @param {(boolean|null)} antialias
 * @constructor
 * @extends createjs.Stage
 */
createjs.SpriteStage = function (canvas, preserveDrawingBuffer, antialias) {}

/**
 */
createjs.SpriteStage.prototype.isWebGL;

/**
 * @param {(WebGLRenderingContext|null)} ctx 
 */
createjs.SpriteStage.prototype._createBuffers = function (ctx) {  }

/**
 * @param {(WebGLRenderingContext|null)} ctx 
 * @param {(number|null)} type
 * @param {string} str
 * @returns {(WebGLShader|null)} 
 */
createjs.SpriteStage.prototype._createShader = function (ctx, type, str) {  return null; }

/**
 * @param {(WebGLRenderingContext|null)} ctx 
 */
createjs.SpriteStage.prototype._createShaderProgram = function (ctx) {  }

/**
 * @param {(WebGLRenderingContext|null)} ctx
 */
createjs.SpriteStage.prototype._drawToGPU = function (ctx) {  }

/**
 * @param {(Array|null)} kids
 * @param {(WebGLRenderingContext|null)} ctx
 * @param {(createjs.Matrix2D|null)} parentMVMatrix
 */
createjs.SpriteStage.prototype._drawWebGLKids = function (kids, ctx, parentMVMatrix) {  }

/**
 */
createjs.SpriteStage.prototype._get_isWebGL = function () {  }

/**
 */
createjs.SpriteStage.prototype._initializeWebGL = function () {  }

/**
 */
createjs.SpriteStage.prototype._initializeWebGLContext = function () {  }

/**
 * @param {(number|null)} r
 * @param {(number|null)} g
 * @param {(number|null)} b
 * @param {(number|null)} a
 */
createjs.SpriteStage.prototype._setClearColor = function (r, g, b, a) {  }

/**
 * @param {(WebGLRenderingContext|null)} ctx
 * @param {(Object|null)} kid
 * @returns {(WebGLTexture|null)} 
 */
createjs.SpriteStage.prototype._setUpKidTexture = function (ctx, kid) {  return null; }

/**
 * @param {(WebGLRenderingContext|null)} ctx 
 * @param {(number|null)} value
 */
createjs.SpriteStage.prototype._setMaxBoxesPoints = function (ctx, value) {  }

/**
 * @returns {(WebGLRenderingContext|null)}
 */
createjs.SpriteStage.prototype._setWebGLContext = function () {  return null; }

/**
 * @param {(Image|null)} image 
 */
createjs.SpriteStage.prototype.clearImageTexture = function (image) {  }

/**
 * @param {(number|null)} width 
 * @param {(number|null)} height 
 */
createjs.SpriteStage.prototype.updateViewport = function (width, height) {  }

/**
 * @param {(HTMLCanvasElement|Object|null)} canvas
 * @constructor
 * @extends createjs.Container
 */
createjs.Stage = function (canvas) {}

/**
 */
createjs.Stage.prototype.nextStage;

/**
 * @param {(createjs.DisplayObject|null)} target 
 * @param {string} type 
 * @param {(boolean|null)} bubbles 
 * @param {(number|null)} pointerId 
 * @param {(Object|null)} o 
 * @param {MouseEvent=} opt_nativeEvent 
 */
createjs.Stage.prototype._dispatchMouseEvent = function (target, type, bubbles, pointerId, o, opt_nativeEvent) {  }

/**
 * @param {(HTMLElement|null)} e 
 */
createjs.Stage.prototype._getElementRect = function (e) {  }

/**
 */
createjs.Stage.prototype._get_nextStage = function () {  }

/**
 * @param {(MouseEvent|null)} e 
 * @param {(createjs.Stage|null)} owner
 */
createjs.Stage.prototype._handleDoubleClick = function (e, owner) {  }

/**
 * @param {(MouseEvent|null)} e 
 */
createjs.Stage.prototype._handleMouseDown = function (e) {  }

/**
 * @param {(MouseEvent|null)} e 
 */
createjs.Stage.prototype._handleMouseMove = function (e) {  }

/**
 * @param {(MouseEvent|null)} e 
 */
createjs.Stage.prototype._handleMouseUp = function (e) {  }

/**
 * @param {(number|null)} id 
 * @param {(Event|null)} e 
 * @param {(number|null)} pageX 
 * @param {(number|null)} pageY 
 * @param {(createjs.Stage|null)} owner
 */
createjs.Stage.prototype._handlePointerDown = function (id, e, pageX, pageY, owner) {  }

/**
 * @param {(number|null)} id 
 * @param {(Event|null)} e 
 * @param {(number|null)} pageX 
 * @param {(number|null)} pageY 
 * @param {(createjs.Stage|null)} owner
 */
createjs.Stage.prototype._handlePointerMove = function (id, e, pageX, pageY, owner) {  }

/**
 * @param {(number|null)} id 
 * @param {(Event|null)} e 
 * @param {(boolean|null)} clear 
 * @param {(createjs.Stage|null)} owner
 */
createjs.Stage.prototype._handlePointerUp = function (id, e, clear, owner) {  }


/**
 * @param {(number|null)} id 
 */
createjs.Stage.prototype._getPointerData = function (id) {  }

/**
 */
createjs.Stage.prototype._set_nextStage = function (value) {  }

/**
 * @param {(boolean|null)} clear
 * @param {(createjs.Stage|null)} owner
 * @param {(createjs.Stage|null)} eventTarget
 */
createjs.Stage.prototype._testMouseOver = function (clear, owner, eventTarget) {  }

/**
 * @param {(number|null)} id 
 * @param {(Event|null)} e 
 * @param {(number|null)} pageX 
 * @param {(number|null)} pageY 
 */
createjs.Stage.prototype._updatePointerPosition = function (id, e, pageX, pageY) {  }

/**
 */
createjs.Stage.prototype.clear = function () {  }

/**
 * @param {boolean=} opt_enable
 */
createjs.Stage.prototype.enableDOMEvents = function (opt_enable) {  }

/**
 * @param {number=} opt_frequency
 */
createjs.Stage.prototype.enableMouseOver = function (opt_frequency) {  }

/**
 */
createjs.Stage.prototype.handleEvent = function (evt) {  }

/**
 * @param {Object=} opt_props
 */
createjs.Stage.prototype.tick = function (opt_props) {  }

/**
 * @param {string=} opt_backgroundColor
 * @param {string=} opt_mimeType
 * @returns {string}
 */
createjs.Stage.prototype.toDataURL = function (opt_backgroundColor, opt_mimeType) { return ''; }

/**
 * @param {Object=} opt_props
 */
createjs.Stage.prototype.update = function (opt_props) {  }

/**
 * @param {string=} opt_text
 * @param {string=} opt_font
 * @param {string=} opt_color
 * @constructor
 * @extends createjs.DisplayObject
 */
createjs.Text = function (opt_text, opt_font, opt_color) {}

/**
 * @type {string} 
 */
createjs.Text.prototype.text;

/**
 * @type {string} 
 */
createjs.Text.prototype.textAlign;

/**
 * @type {string} 
 */
createjs.Text.prototype.textBaseline;

/**
 * @param {(CanvasRenderingContext2D|null)} ctx 
 * @param {(Object|null)} o 
 * @param {(Array|null)} lines 
 * @returns {(Object|null)} 
 */
createjs.Text.prototype._drawText = function (ctx, o, lines) {  return null; }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx 
 * @param {string} text 
 * @param {(number|null)} y 
 */
createjs.Text.prototype._drawTextLine = function (ctx, text, y) {  }

/**
 * @param {string} text 
 */
createjs.Text.prototype._getMeasuredWidth = function (text) {  }

/**
 * @param {(CanvasRenderingContext2D|null)} ctx 
 * @returns {(CanvasRenderingContext2D|null)} 
 */
createjs.Text.prototype._prepContext = function (ctx) {  return null; }

/**
 * @returns {(number|null)}
 */
createjs.Text.prototype.getMeasuredHeight = function () { return 0; }

/**
 * @returns {(number|null)}
 */
createjs.Text.prototype.getMeasuredLineHeight = function () { return 0; }

/**
 * @returns {(number|null)}
 */
createjs.Text.prototype.getMeasuredWidth = function () { return 0; }

/**
 * @returns {(Object|null)}
 */
createjs.Text.prototype.getMetrics = function () {  return null; }


/**
 * @constructor
 */
createjs.Ticker = function () {}

/**
 */
createjs.Ticker._getTime = function () {  }

/**
 */
createjs.Ticker._handleRAF = function () {  }

/**
 */
createjs.Ticker._handleTimeout = function () {  }

/**
 */
createjs.Ticker._handleSynch = function () {  }

/**
 */
createjs.Ticker._setupTick = function () {  }

/**
 */
createjs.Ticker._tick = function () {  }

/**
 */
createjs.Ticker.addEventListener = function (type, handler) {  }

/**
 * @param {Boolean} runTime
 * @returns {number}
 */
createjs.Ticker.getEventTime = function (runTime) { return 0; }

/**
 * @returns {(number|null)} 
 */
createjs.Ticker.getFPS = function () { return 0; }

/**
 * @returns {(number|null)} 
 */
createjs.Ticker.getInterval = function () { return 0; }

/**
 * @param {number=} opt_ticks
 * @returns {(number|null)}
 */
createjs.Ticker.getMeasuredFPS = function (opt_ticks) { return 0; }

/**
 * @param {number=} opt_ticks
 * @returns {(number|null)}
 */
createjs.Ticker.getMeasuredTickTime = function (opt_ticks) { return 0; }

/**
 * @returns {(boolean|null)} 
 */
createjs.Ticker.getPaused = function () {  return null; }

/**
 * @param {(boolean|null)} pauseable
 * @returns {(number|null)}
 */
createjs.Ticker.getTicks = function (pauseable) { return 0; }

/**
 * @param {boolean=} opt_runTime
 * @returns {(number|null)}
 */
createjs.Ticker.getTime = function (opt_runTime) { return 0; }

/**
 */
createjs.Ticker.init = function () {  }

/**
 */
createjs.Ticker.reset = function () {  }

/**
 * @param {(number|null)} value 
 */
createjs.Ticker.setFPS = function (value) {  }

/**
 * @param {(number|null)} interval 
 */
createjs.Ticker.setInterval = function (interval) {  }

/**
 * @param {(boolean|null)} value 
 */
createjs.Ticker.setPaused = function (value) {  }

/**
 * @param {(Array|null)} tweens
 * @param {(Object|null)} labels
 * @param {(Object|null)} props
 * @constructor
 * @extends createjs.EventDispatcher
 */
createjs.Timeline = function (tweens, labels, props) {}

/**
 * @param {(number|null)} value 
 * @returns {(number|null)} 
 */
createjs.Timeline.prototype._calcPosition = function (value) { return 0; }

/**
 * @param {(number|string|null)} positionOrLabel 
 */
createjs.Timeline.prototype._goto = function (positionOrLabel) {  }

/**
 * @param {(string|null)} label
 * @param {(number|null)} position
 */
createjs.Timeline.prototype.addLabel = function (label, position) {  }

/**
 * @returns {(Tween|null)}
 */
createjs.Timeline.prototype.addTween = function (tween) {  return null; }


/**
 */
createjs.Timeline.prototype.clone = function () {  }

/**
 * @returns {(string|null)}
 */
createjs.Timeline.prototype.getCurrentLabel = function () { return ''; }

/**
 * @returns {(Array|null)} Object]}
 */
createjs.Timeline.prototype.getLabels = function () {  return null; }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.Timeline.prototype.gotoAndPlay = function (positionOrLabel) {  }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.Timeline.prototype.gotoAndStop = function (positionOrLabel) {  }

/**
 * @returns {?}
 */
createjs.Timeline.prototype.removeTween = function (tween) {  return null; }

/**
 * @param {(number|string|null)} positionOrLabel
 */
createjs.Timeline.prototype.resolve = function (positionOrLabel) {  }

/**
 * @param {(Object|null)} o
 */
createjs.Timeline.prototype.setLabels = function (o) {  }

/**
 * @param {(boolean|null)} value
 */
createjs.Timeline.prototype.setPaused = function (value) {  }

/**
 * @param {(number|null)} value
 * @param {number=} opt_actionsMode
 * @returns {(boolean|null)}
 */
createjs.Timeline.prototype.setPosition = function (value, opt_actionsMode) {  return null; }

/**
 * @param {(number|null)} delta
 */
createjs.Timeline.prototype.tick = function (delta) {  }

/**
 */
createjs.Timeline.prototype.updateDuration = function () {  }

/**
 * @param {(Object|null)} target
 * @param {Object=} opt_props
 * @param {Object=} opt_pluginData
 * @constructor
 * @extends createjs.EventDispatcher
 */
createjs.Tween = function (target, opt_props, opt_pluginData) {}

/**
 * @param {(Object|null)} o 
 */
createjs.Tween.prototype._addAction = function (o) {  }

/**
 * @param {(Object|null)} o 
 */
createjs.Tween.prototype._addStep = function (o) {  }

/**
 * @param {(Object|null)} o 
 */
createjs.Tween.prototype._appendQueueProps = function (o) {  }

/**
 * @param {(Object|null)} props 
 */
createjs.Tween.prototype._cloneProps = function (props) {  }

/**
 * @param {(Tween|null)} tween
 * @param {(boolean|null)} value
 */
createjs.Tween._register = function (tween, value) {  }

/**
 * @param {(number|null)} startPos 
 * @param {(number|null)} endPos 
 * @param {(boolean|null)} includeStart 
 */
createjs.Tween.prototype._runActions = function (startPos, endPos, includeStart) {  }

/**
 * @param {(Object|null)} props 
 * @param {(Object|null)} o 
 */
createjs.Tween.prototype._set = function (props, o) {  }

/**
 * @param {(Object|null)} step 
 * @param {(number|null)} ratio 
 */
createjs.Tween.prototype._updateTargetProps = function (step, ratio) {  }

/**
 * @param {(Function|null)} callback
 * @param {Array=} opt_params
 * @param {Object=} opt_scope
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.call = function (callback, opt_params, opt_scope) {  return null; }

/**
 */
createjs.Tween.prototype.clone = function () {  }

/**
 * @param {(Object|null)} target
 * @param {Object=} opt_props
 * @param {Object=} opt_pluginData
 * @param {boolean=} opt_override
 * @returns {(Tween|null)}
 */
createjs.Tween.get = function (target, opt_props, opt_pluginData, opt_override) {  return null; }

/**
 * @param {(Object|null)} event
 */
createjs.Tween.handleEvent = function (event) {  }

/**
 * @param {Object=} opt_target
 * @returns {(boolean|null)}
 */
createjs.Tween.hasActiveTweens = function (opt_target) {  return null; }

/**
 * @param {(Object|null)} plugin
 * @param {(Array|null)} properties
 */
createjs.Tween.installPlugin = function (plugin, properties) {  }

/**
 * @param {(Tween|null)} tween
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.pause = function (tween) {  return null; }

/**
 * @param {(Tween|null)} tween
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.play = function (tween) {  return null; }

/**
 */
createjs.Tween.removeAllTweens = function () {  }

/**
 * @param {(Object|null)} target
 */
createjs.Tween.removeTweens = function (target) {  }

/**
 * @param {(Object|null)} props
 * @param {Object=} opt_target
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.set = function (props, opt_target) {  return null; }

/**
 * @param {boolean=} opt_value
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.setPaused = function (opt_value) {  return null; }

/**
 * @param {(number|null)} value
 * @param {number=} opt_actionsMode
 * @returns {(boolean|null)}
 */
createjs.Tween.prototype.setPosition = function (value, opt_actionsMode) {  return null; }

/**
 * @param {(number|null)} delta
 * @param {(boolean|null)} paused 
 */
createjs.Tween.tick = function (delta, paused) {  }

/**
 * @param {(number|null)} delta
 */
createjs.Tween.prototype.tick = function (delta) {  }

/**
 * @param {(Object|null)} props
 * @param {number=} opt_duration
 * @param {Function=} opt_ease
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.to = function (props, opt_duration, opt_ease) {  return null; }

/**
 * @param {(number|null)} duration
 * @param {boolean=} opt_passive
 * @returns {(Tween|null)}
 */
createjs.Tween.prototype.wait = function (duration, opt_passive) {  return null; }

/**
 * @constructor
 * @static
 **/
createjs.UID = function() {
}


/**
 * @return {number}
 **/
createjs.UID.get = function() {
};
