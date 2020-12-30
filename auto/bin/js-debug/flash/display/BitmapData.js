/**
 * Generated by Apache Royale Compiler from flash/display/BitmapData.as
 * flash.display.BitmapData
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('flash.display.BitmapData');
/* Royale Dependency List: SpriteFlexjs,flash.__native.BitmapTexture,flash.display.BitmapDataChannel,flash.geom.ColorTransform,flash.geom.Matrix,flash.geom.Point,flash.geom.Rectangle,flash.utils.ByteArray,org.apache.royale.utils.Language*/

goog.require('flash.display.IBitmapDrawable');



/**
 * @constructor
 * @implements {flash.display.IBitmapDrawable}
 * @param {number} width
 * @param {number} height
 * @param {boolean=} transparent
 * @param {number=} fillColor
 */
flash.display.BitmapData = function(width, height, transparent, fillColor) {
  transparent = typeof transparent !== 'undefined' ? transparent : true;
  fillColor = typeof fillColor !== 'undefined' ? fillColor : 0xffffffff;
  ;
  this.flash_display_BitmapData_ctor(width, height, transparent, fillColor);
};


/**
 * @type {Uint8ClampedArray}
 */
flash.display.BitmapData.prototype.__data = null;


/**
 * @private
 * @type {ImageData}
 */
flash.display.BitmapData.prototype.flash_display_BitmapData_imageData = null;


/**
 * @type {HTMLCanvasElement}
 */
flash.display.BitmapData.prototype.image = null;


/**
 * @private
 * @type {boolean}
 */
flash.display.BitmapData.prototype.flash_display_BitmapData__lock = false;


/**
 * @type {CanvasRenderingContext2D}
 */
flash.display.BitmapData.prototype.ctx = null;


/**
 * @private
 * @type {boolean}
 */
flash.display.BitmapData.prototype.flash_display_BitmapData__transparent = false;


/**
 * @private
 * @type {number}
 */
flash.display.BitmapData.prototype.flash_display_BitmapData__width = 0;


/**
 * @private
 * @type {number}
 */
flash.display.BitmapData.prototype.flash_display_BitmapData__height = 0;


/**
 * @private
 * @param {number} width
 * @param {number} height
 * @param {boolean=} transparent
 * @param {number=} fillColor
 */
flash.display.BitmapData.prototype.flash_display_BitmapData_ctor = function(width, height, transparent, fillColor) {
  transparent = typeof transparent !== 'undefined' ? transparent : true;
  fillColor = typeof fillColor !== 'undefined' ? fillColor : 0xffffffff;
  this.flash_display_BitmapData__transparent = transparent;
  this.image = document.createElement("canvas");
  this.image.width = this.flash_display_BitmapData__width = width;
  this.image.height = this.flash_display_BitmapData__height = height;
  this.ctx = this.image.getContext("2d");
  this.flash_display_BitmapData_imageData = this.ctx.getImageData(0, 0, width, height);
  this.__data = this.flash_display_BitmapData_imageData.data;
  this.fillRect(this.rect, fillColor);
};


/**
 * @param {Object} img
 * @param {number=} dx
 * @param {number=} dy
 * @param {number=} opt_dw
 * @param {number=} opt_dy
 */
flash.display.BitmapData.prototype.fromImage = function(img, dx, dy, opt_dw, opt_dy) {
  dx = typeof dx !== 'undefined' ? dx : 0;
  dy = typeof dy !== 'undefined' ? dy : 0;
  opt_dw = typeof opt_dw !== 'undefined' ? opt_dw : 0;
  opt_dy = typeof opt_dy !== 'undefined' ? opt_dy : 0;
  this.ctx.drawImage(img, dx, dy);
  SpriteFlexjs.dirtyGraphics = true;
  this.flash_display_BitmapData_clearTexture();
  this.flash_display_BitmapData_imageData = this.ctx.getImageData(0, 0, this.width, this.height);
  this.__data = this.flash_display_BitmapData_imageData.data;
};


/**
 * @return {flash.display.BitmapData}
 */
flash.display.BitmapData.prototype.clone = function() {
  return null;
};


/**
 * @param {number} x
 * @param {number} y
 * @return {number}
 */
flash.display.BitmapData.prototype.getPixel = function(x, y) {
  var /** @type {number} */ p = ((y * this.width + x) * 4) >> 0;
  return ((this.__data[p] << 16) | (this.__data[p + 1] << 8) | this.__data[p + 2]) >>> 0;
};


/**
 * @param {number} x
 * @param {number} y
 * @return {number}
 */
flash.display.BitmapData.prototype.getPixel32 = function(x, y) {
  var /** @type {number} */ p = ((y * this.width + x) * 4) >> 0;
  return ((this.__data[p + 3] << 24) | (this.__data[p] << 16) | (this.__data[p + 1] << 8) | this.__data[p + 2]) >>> 0;
};


/**
 * @param {number} x
 * @param {number} y
 * @param {number} color
 */
flash.display.BitmapData.prototype.setPixel = function(x, y, color) {
  var /** @type {number} */ p = ((y * this.width + x) * 4) >> 0;
  this.__data[p] = (color >> 16) & 0xff;
  this.__data[p + 1] = (color >> 8) & 0xff;
  this.__data[p + 2] = color & 0xff;
  if (!this.flash_display_BitmapData__lock) {
    this.ctx.putImageData(this.flash_display_BitmapData_imageData, 0, 0);
    SpriteFlexjs.dirtyGraphics = true;
    this.flash_display_BitmapData_clearTexture();
  }
};


/**
 * @param {number} x
 * @param {number} y
 * @param {number} color
 */
flash.display.BitmapData.prototype.setPixel32 = function(x, y, color) {
  var /** @type {number} */ p = ((y * this.width + x) * 4) >> 0;
  this.__data[p] = (color >> 16) & 0xff;
  this.__data[p + 1] = (color >> 8) & 0xff;
  this.__data[p + 2] = color & 0xff;
  this.__data[p + 3] = color >>> 24;
  if (!this.flash_display_BitmapData__lock) {
    this.ctx.putImageData(this.flash_display_BitmapData_imageData, 0, 0);
    SpriteFlexjs.dirtyGraphics = true;
    this.flash_display_BitmapData_clearTexture();
  }
};


/**
 * @param {flash.geom.Rectangle} rect
 * @param {flash.geom.ColorTransform} ct
 */
flash.display.BitmapData.prototype.colorTransform = function(rect, ct) {
};


/**
 * @param {flash.display.BitmapData} b
 * @return {Object}
 */
flash.display.BitmapData.prototype.compare = function(b) {
  return null;
};


/**
 * @param {flash.display.BitmapData} b
 * @param {flash.geom.Rectangle} r
 * @param {flash.geom.Point} p
 * @param {number} param4
 * @param {number} param5
 */
flash.display.BitmapData.prototype.copyChannel = function(b, r, p, param4, param5) {
};


/**
 * @param {flash.display.BitmapData} sourceBitmapData
 * @param {flash.geom.Rectangle} sourceRect
 * @param {flash.geom.Point} destPoint
 * @param {flash.display.BitmapData=} alphaBitmapData
 * @param {flash.geom.Point=} alphaPoint
 * @param {boolean=} mergeAlpha
 */
flash.display.BitmapData.prototype.copyPixels = function(sourceBitmapData, sourceRect, destPoint, alphaBitmapData, alphaPoint, mergeAlpha) {
  alphaBitmapData = typeof alphaBitmapData !== 'undefined' ? alphaBitmapData : null;
  alphaPoint = typeof alphaPoint !== 'undefined' ? alphaPoint : null;
  mergeAlpha = typeof mergeAlpha !== 'undefined' ? mergeAlpha : false;
  this.lock();
  for (var /** @type {number} */ x = 0; x < sourceRect.width; x++) {
    for (var /** @type {number} */ y = 0; y < sourceRect.height; y++) {
      this.setPixel32((x + destPoint.x) >> 0, (y + destPoint.y) >> 0, sourceBitmapData.getPixel32((x + sourceRect.x) >> 0, (y + sourceRect.y) >> 0));
    }
  }
  this.unlock();
};


/**
 */
flash.display.BitmapData.prototype.dispose = function() {
};


/**
 * @param {flash.display.IBitmapDrawable} source
 * @param {flash.geom.Matrix=} matrix
 * @param {flash.geom.ColorTransform=} colorTransform
 * @param {string=} blendMode
 * @param {flash.geom.Rectangle=} clipRect
 * @param {boolean=} smoothing
 */
flash.display.BitmapData.prototype.draw = function(source, matrix, colorTransform, blendMode, clipRect, smoothing) {
  matrix = typeof matrix !== 'undefined' ? matrix : null;
  colorTransform = typeof colorTransform !== 'undefined' ? colorTransform : null;
  blendMode = typeof blendMode !== 'undefined' ? blendMode : null;
  clipRect = typeof clipRect !== 'undefined' ? clipRect : null;
  smoothing = typeof smoothing !== 'undefined' ? smoothing : false;
  this.drawWithQuality(source, matrix, colorTransform, blendMode, clipRect, smoothing);
};


/**
 * @param {flash.display.IBitmapDrawable} source
 * @param {flash.geom.Matrix=} matrix
 * @param {flash.geom.ColorTransform=} colorTransform
 * @param {string=} blendMode
 * @param {flash.geom.Rectangle=} clipRect
 * @param {boolean=} smoothing
 * @param {string=} quality
 */
flash.display.BitmapData.prototype.drawWithQuality = function(source, matrix, colorTransform, blendMode, clipRect, smoothing, quality) {
  matrix = typeof matrix !== 'undefined' ? matrix : null;
  colorTransform = typeof colorTransform !== 'undefined' ? colorTransform : null;
  blendMode = typeof blendMode !== 'undefined' ? blendMode : null;
  clipRect = typeof clipRect !== 'undefined' ? clipRect : null;
  smoothing = typeof smoothing !== 'undefined' ? smoothing : false;
  quality = typeof quality !== 'undefined' ? quality : null;
  if (org.apache.royale.utils.Language.is(source, flash.display.BitmapData)) {
    var /** @type {flash.display.BitmapData} */ bmd = source;
    this.fromImage(bmd.ctx);
  }
};


/**
 * @param {flash.geom.Rectangle} rect
 * @param {number} fillColor
 */
flash.display.BitmapData.prototype.fillRect = function(rect, fillColor) {
  this.lock();
  for (var /** @type {number} */ y = 0; y < this.height; ++y) {
    for (var /** @type {number} */ x = 0; x < this.width; ++x) {
      this.setPixel32(x, y, (this.transparent ? fillColor : (0xff000000 | fillColor)) >>> 0);
    }
  }
  this.unlock();
};


/**
 * @param {number} param1
 * @param {number} param2
 * @param {number} param3
 */
flash.display.BitmapData.prototype.floodFill = function(param1, param2, param3) {
};


/**
 * @param {number} param1
 * @param {number} param2
 * @param {boolean=} param3
 * @return {flash.geom.Rectangle}
 */
flash.display.BitmapData.prototype.getColorBoundsRect = function(param1, param2, param3) {
  param3 = typeof param3 !== 'undefined' ? param3 : true;
  return null;
};


/**
 * @param {flash.geom.Rectangle} param1
 * @return {flash.utils.ByteArray}
 */
flash.display.BitmapData.prototype.getPixels = function(param1) {
  return null;
};


/**
 * @param {flash.geom.Rectangle} param1
 * @param {flash.utils.ByteArray} param2
 */
flash.display.BitmapData.prototype.copyPixelsToByteArray = function(param1, param2) {
};


/**
 * @param {flash.geom.Rectangle} param1
 * @return {Array.<number>}
 */
flash.display.BitmapData.prototype.getVector = function(param1) {
  return null;
};


/**
 * @param {flash.geom.Point} param1
 * @param {number} param2
 * @param {Object} param3
 * @param {flash.geom.Point=} param4
 * @param {number=} param5
 * @return {boolean}
 */
flash.display.BitmapData.prototype.hitTest = function(param1, param2, param3, param4, param5) {
  param4 = typeof param4 !== 'undefined' ? param4 : null;
  param5 = typeof param5 !== 'undefined' ? param5 : 1;
  return false;
};


/**
 * @param {flash.display.BitmapData} param1
 * @param {flash.geom.Rectangle} param2
 * @param {flash.geom.Point} param3
 * @param {number} param4
 * @param {number} param5
 * @param {number} param6
 * @param {number} param7
 */
flash.display.BitmapData.prototype.merge = function(param1, param2, param3, param4, param5, param6, param7) {
};


/**
 * @param {number} randomSeed
 * @param {number=} low
 * @param {number=} high
 * @param {number=} channelOptions
 * @param {boolean=} grayScale
 */
flash.display.BitmapData.prototype.noise = function(randomSeed, low, high, channelOptions, grayScale) {
  low = typeof low !== 'undefined' ? low : 0;
  high = typeof high !== 'undefined' ? high : 255;
  channelOptions = typeof channelOptions !== 'undefined' ? channelOptions : 7;
  grayScale = typeof grayScale !== 'undefined' ? grayScale : false;
  this.lock();
  for (var /** @type {number} */ y = 0; y < this.height; ++y) {
    for (var /** @type {number} */ x = 0; x < this.width; ++x) {
      this.setPixel32(x, y, (0xff000000 | 0xffffff * Math.random()) >>> 0);
    }
  }
  this.unlock();
};


/**
 * @param {flash.display.BitmapData} param1
 * @param {flash.geom.Rectangle} param2
 * @param {flash.geom.Point} param3
 * @param {Array=} param4
 * @param {Array=} param5
 * @param {Array=} param6
 * @param {Array=} param7
 */
flash.display.BitmapData.prototype.paletteMap = function(param1, param2, param3, param4, param5, param6, param7) {
  param4 = typeof param4 !== 'undefined' ? param4 : null;
  param5 = typeof param5 !== 'undefined' ? param5 : null;
  param6 = typeof param6 !== 'undefined' ? param6 : null;
  param7 = typeof param7 !== 'undefined' ? param7 : null;
};


/**
 * @private
 * @type {Array}
 */
flash.display.BitmapData.perm = [151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23, 190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33, 88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166, 77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244, 102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196, 135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123, 5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42, 223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9, 129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228, 251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107, 49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254, 138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180];


/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {number} numOctaves
 * @param {number} randomSeed
 * @param {boolean} stitch
 * @param {boolean} fractalNoise
 * @param {number=} channelOptions
 * @param {boolean=} grayScale
 * @param {Array=} offsets
 */
flash.display.BitmapData.prototype.perlinNoise = function(baseX, baseY, numOctaves, randomSeed, stitch, fractalNoise, channelOptions, grayScale, offsets) {
  channelOptions = typeof channelOptions !== 'undefined' ? channelOptions : 7;
  grayScale = typeof grayScale !== 'undefined' ? grayScale : false;
  offsets = typeof offsets !== 'undefined' ? offsets : null;
  var /** @type {number} */ bw = this.width;
  var /** @type {number} */ bh = this.height;
  if (!this.flash_display_BitmapData__lock) {
    var /** @type {boolean} */ nowlock = this.flash_display_BitmapData__lock;
    this.lock();
  }
  this.fillRect(this.rect, 0xff000000);
  var /** @type {Array} */ chs = [];
  if (channelOptions & flash.display.BitmapDataChannel.RED) {
    chs.push([0, randomSeed]);
  }
  if (channelOptions & flash.display.BitmapDataChannel.GREEN) {
    chs.push([1, randomSeed + (grayScale ? 0 : 5)]);
  }
  if (channelOptions & flash.display.BitmapDataChannel.BLUE) {
    chs.push([2, randomSeed + (grayScale ? 0 : 10)]);
  }
  var /** @type {number} */ chlen = (chs.length) >> 0;
  var /** @type {number} */ octaves = (numOctaves) >> 0;
  var /** @type {number} */ totalAmplitude = 0;
  var /** @type {number} */ amplitude = 1;
  var /** @type {number} */ baseXB = baseX;
  var /** @type {number} */ baseYB = baseY;
  var /** @type {number} */ persistance = 0.6;
  while (true) {
    totalAmplitude += amplitude;
    baseX = org.apache.royale.utils.Language._int(baseX);
    baseY = org.apache.royale.utils.Language._int(baseY);
    if (octaves <= 0 || baseX <= 1 || baseY <= 1) {
      break;
    }
    amplitude *= persistance;
    octaves--;
    baseX /= 2;
    baseY /= 2;
  }
  baseX = baseXB;
  baseY = baseYB;
  amplitude = 1;
  octaves = (numOctaves) >> 0;
  while (true) {
    baseX = org.apache.royale.utils.Language._int(baseX);
    baseY = org.apache.royale.utils.Language._int(baseY);
    if (octaves <= 0 || baseX <= 1 || baseY <= 1) {
      break;
    }
    var /** @type {number} */ offsetX = 0;
    var /** @type {number} */ offsetY = 0;
    if (offsets) {
      var /** @type {flash.geom.Point} */ offset = offsets[numOctaves - octaves];
      if (offset) {
        offsetX = org.apache.royale.utils.Language._int(offset.x / 16);
        offsetY = org.apache.royale.utils.Language._int(offset.y / 16);
      }
    }
    var /** @type {number} */ nx = (Math.ceil(bw / baseX)) >> 0;
    var /** @type {number} */ ny = (Math.ceil(bh / baseY)) >> 0;
    for (var /** @type {number} */ y = 0; y <= ny; y++) {
      for (var /** @type {number} */ x = 0; x <= nx; x++) {
        if (x != 0 && y != 0) {
          for (var /** @type {number} */ i = 0; i < chlen; i++) {
            var /** @type {number} */ chci = (chs[i][0]) >> 0;
            var /** @type {number} */ chpi = (chs[i][1]) >> 0;
            var /** @type {number} */ r00 = Number(flash.display.BitmapData.perm[((x - 1 + chpi + offsetX) % 16) + ((y - 1 + chpi + offsetY) % 16) * 16]);
            var /** @type {number} */ r10 = Number(flash.display.BitmapData.perm[((x + chpi + offsetX) % 16) + ((y - 1 + chpi + offsetY) % 16) * 16]);
            var /** @type {number} */ r01 = Number(flash.display.BitmapData.perm[((x - 1 + chpi + offsetX) % 16) + ((y + chpi + offsetY) % 16) * 16]);
            var /** @type {number} */ r11 = Number(flash.display.BitmapData.perm[((x + chpi + offsetX) % 16) + ((y + chpi + offsetY) % 16) * 16]);
            var /** @type {number} */ w = x * baseX;
            if (w > bw) {
              w = bw;
            }
            var /** @type {number} */ h = y * baseY;
            if (h > bh) {
              h = bh;
            }
            var /** @type {number} */ sx = ((x - 1) * baseX) >> 0;
            var /** @type {number} */ sy = ((y - 1) * baseY) >> 0;
            for (var /** @type {number} */ bx = sx; bx < w; bx++) {
              var /** @type {number} */ tx = (bx - sx) / baseX;
              tx = tx * tx * (3 - 2 * tx);
              for (var /** @type {number} */ by = sy; by < h; by++) {
                var /** @type {number} */ ty = (by - sy) / baseY;
                ty = ty * ty * (3 - 2 * ty);
                var /** @type {number} */ cx0 = r10 * tx + r00 * (1 - tx);
                var /** @type {number} */ cx1 = r11 * tx + r01 * (1 - tx);
                var /** @type {number} */ c = cx1 * ty + cx0 * (1 - ty);
                this.__data[(bx + by * bw) * 4 + chci] += c * amplitude / totalAmplitude;
              }
            }
          }
        }
      }
    }
    octaves--;
    baseX /= 2;
    baseY /= 2;
    amplitude *= persistance;
  }
  this.flash_display_BitmapData__lock = nowlock;
  if (!this.flash_display_BitmapData__lock) {
    this.ctx.putImageData(this.flash_display_BitmapData_imageData, 0, 0);
    SpriteFlexjs.dirtyGraphics = true;
    this.flash_display_BitmapData_clearTexture();
  }
};


/**
 * @param {flash.display.BitmapData} param1
 * @param {flash.geom.Rectangle} param2
 * @param {flash.geom.Point} param3
 * @param {number=} param4
 * @param {number=} param5
 * @param {number=} param6
 * @return {number}
 */
flash.display.BitmapData.prototype.pixelDissolve = function(param1, param2, param3, param4, param5, param6) {
  param4 = typeof param4 !== 'undefined' ? param4 : 0;
  param5 = typeof param5 !== 'undefined' ? param5 : 0;
  param6 = typeof param6 !== 'undefined' ? param6 : 0;
  return 0;
};


/**
 * @param {number} param1
 * @param {number} param2
 */
flash.display.BitmapData.prototype.scroll = function(param1, param2) {
};


/**
 * @param {flash.geom.Rectangle} param1
 * @param {flash.utils.ByteArray} param2
 */
flash.display.BitmapData.prototype.setPixels = function(param1, param2) {
};


/**
 * @param {flash.geom.Rectangle} param1
 * @param {Array.<number>} param2
 */
flash.display.BitmapData.prototype.setVector = function(param1, param2) {
  this.lock();
  for (var /** @type {number} */ x = 0; x < this.width; x++) {
    for (var /** @type {number} */ y = 0; y < this.height; y++) {
      this.setPixel(x, y, param2[x + y * this.width]);
    }
  }
  this.unlock();
};


/**
 * @param {flash.display.BitmapData} param1
 * @param {flash.geom.Rectangle} param2
 * @param {flash.geom.Point} param3
 * @param {string} param4
 * @param {number} param5
 * @param {number=} param6
 * @param {number=} param7
 * @param {boolean=} param8
 * @return {number}
 */
flash.display.BitmapData.prototype.threshold = function(param1, param2, param3, param4, param5, param6, param7, param8) {
  param6 = typeof param6 !== 'undefined' ? param6 : 0;
  param7 = typeof param7 !== 'undefined' ? param7 : 4.294967295E9;
  param8 = typeof param8 !== 'undefined' ? param8 : false;
  return 0;
};


/**
 */
flash.display.BitmapData.prototype.lock = function() {
  this.flash_display_BitmapData__lock = true;
};


/**
 * @param {flash.geom.Rectangle=} param1
 */
flash.display.BitmapData.prototype.unlock = function(param1) {
  param1 = typeof param1 !== 'undefined' ? param1 : null;
  this.flash_display_BitmapData__lock = false;
  this.ctx.putImageData(this.flash_display_BitmapData_imageData, 0, 0);
  SpriteFlexjs.dirtyGraphics = true;
  this.flash_display_BitmapData_clearTexture();
};


/**
 * @private
 */
flash.display.BitmapData.prototype.flash_display_BitmapData_clearTexture = function() {
  if (this.image && this.image["_texture"]) {
    var /** @type {flash.__native.BitmapTexture} */ t = this.image["_texture"];
    t.dirty = true;
  }
};


/**
 * @param {flash.geom.Rectangle=} param1
 * @return {Array.<Array.<number>>}
 */
flash.display.BitmapData.prototype.histogram = function(param1) {
  param1 = typeof param1 !== 'undefined' ? param1 : null;
  return null;
};


/**
 * @param {flash.geom.Rectangle} param1
 * @param {Object} param2
 * @param {flash.utils.ByteArray=} param3
 * @return {flash.utils.ByteArray}
 */
flash.display.BitmapData.prototype.encode = function(param1, param2, param3) {
  param3 = typeof param3 !== 'undefined' ? param3 : null;
  return null;
};


flash.display.BitmapData.prototype.get__width = function() {
  return this.flash_display_BitmapData__width;
};


flash.display.BitmapData.prototype.get__height = function() {
  return this.flash_display_BitmapData__height;
};


flash.display.BitmapData.prototype.get__transparent = function() {
  return this.flash_display_BitmapData__transparent;
};


flash.display.BitmapData.prototype.get__rect = function() {
  return new flash.geom.Rectangle(0, 0, this.width, this.height);
};


Object.defineProperties(flash.display.BitmapData.prototype, /** @lends {flash.display.BitmapData.prototype} */ {
/**
 * @type {number}
 */
width: {
get: flash.display.BitmapData.prototype.get__width},
/**
 * @type {number}
 */
height: {
get: flash.display.BitmapData.prototype.get__height},
/**
 * @type {boolean}
 */
transparent: {
get: flash.display.BitmapData.prototype.get__transparent},
/**
 * @type {flash.geom.Rectangle}
 */
rect: {
get: flash.display.BitmapData.prototype.get__rect}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
flash.display.BitmapData.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'BitmapData', qName: 'flash.display.BitmapData', kind: 'class' }], interfaces: [flash.display.IBitmapDrawable] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
flash.display.BitmapData.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    variables: function () {
      return {
        '__data': { type: 'Uint8ClampedArray', get_set: function (/** flash.display.BitmapData */ inst, /** * */ v) {return v !== undefined ? inst.__data = v : inst.__data;}},
        'image': { type: 'HTMLCanvasElement', get_set: function (/** flash.display.BitmapData */ inst, /** * */ v) {return v !== undefined ? inst.image = v : inst.image;}},
        'ctx': { type: 'CanvasRenderingContext2D', get_set: function (/** flash.display.BitmapData */ inst, /** * */ v) {return v !== undefined ? inst.ctx = v : inst.ctx;}}
      };
    },
    accessors: function () {
      return {
        'width': { type: 'int', access: 'readonly', declaredBy: 'flash.display.BitmapData'},
        'height': { type: 'int', access: 'readonly', declaredBy: 'flash.display.BitmapData'},
        'transparent': { type: 'Boolean', access: 'readonly', declaredBy: 'flash.display.BitmapData'},
        'rect': { type: 'flash.geom.Rectangle', access: 'readonly', declaredBy: 'flash.display.BitmapData'}
      };
    },
    methods: function () {
      return {
        'BitmapData': { type: '', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ,'Boolean', true ,'uint', true ]; }},
        'fromImage': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'Object', false ,'Number', true ,'Number', true ,'Number', true ,'Number', true ]; }},
        'clone': { type: 'flash.display.BitmapData', declaredBy: 'flash.display.BitmapData'},
        'getPixel': { type: 'uint', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ]; }},
        'getPixel32': { type: 'uint', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ]; }},
        'setPixel': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ,'uint', false ]; }},
        'setPixel32': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ,'uint', false ]; }},
        'colorTransform': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'flash.geom.ColorTransform', false ]; }},
        'compare': { type: 'Object', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ]; }},
        'copyChannel': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'uint', false ,'uint', false ]; }},
        'copyPixels': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'flash.display.BitmapData', true ,'flash.geom.Point', true ,'Boolean', true ]; }},
        'dispose': { type: 'void', declaredBy: 'flash.display.BitmapData'},
        'draw': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.IBitmapDrawable', false ,'flash.geom.Matrix', true ,'flash.geom.ColorTransform', true ,'String', true ,'flash.geom.Rectangle', true ,'Boolean', true ]; }},
        'drawWithQuality': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.IBitmapDrawable', false ,'flash.geom.Matrix', true ,'flash.geom.ColorTransform', true ,'String', true ,'flash.geom.Rectangle', true ,'Boolean', true ,'String', true ]; }},
        'fillRect': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'uint', false ]; }},
        'floodFill': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ,'uint', false ]; }},
        'getColorBoundsRect': { type: 'flash.geom.Rectangle', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'uint', false ,'uint', false ,'Boolean', true ]; }},
        'getPixels': { type: 'flash.utils.ByteArray', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'copyPixelsToByteArray': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'flash.utils.ByteArray', false ]; }},
        'getVector': { type: 'Vector.<uint>', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ]; }},
        'hitTest': { type: 'Boolean', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Point', false ,'uint', false ,'Object', false ,'flash.geom.Point', true ,'uint', true ]; }},
        'merge': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'uint', false ,'uint', false ,'uint', false ,'uint', false ]; }},
        'noise': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'uint', true ,'uint', true ,'uint', true ,'Boolean', true ]; }},
        'paletteMap': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'Array', true ,'Array', true ,'Array', true ,'Array', true ]; }},
        'perlinNoise': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'Number', false ,'Number', false ,'uint', false ,'int', false ,'Boolean', false ,'Boolean', false ,'uint', true ,'Boolean', true ,'Array', true ]; }},
        'pixelDissolve': { type: 'int', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'int', true ,'int', true ,'uint', true ]; }},
        'scroll': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'int', false ,'int', false ]; }},
        'setPixels': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'flash.utils.ByteArray', false ]; }},
        'setVector': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'Vector.<uint>', false ]; }},
        'threshold': { type: 'uint', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.display.BitmapData', false ,'flash.geom.Rectangle', false ,'flash.geom.Point', false ,'String', false ,'uint', false ,'uint', true ,'uint', true ,'Boolean', true ]; }},
        'lock': { type: 'void', declaredBy: 'flash.display.BitmapData'},
        'unlock': { type: 'void', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', true ]; }},
        'histogram': { type: 'Vector.<Vector.<Number>>', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', true ]; }},
        'encode': { type: 'flash.utils.ByteArray', declaredBy: 'flash.display.BitmapData', parameters: function () { return [ 'flash.geom.Rectangle', false ,'Object', false ,'flash.utils.ByteArray', true ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
flash.display.BitmapData.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
flash.display.BitmapData.prototype.ROYALE_INITIAL_STATICS = Object.keys(flash.display.BitmapData);
