/**
 * Generated by Apache Royale Compiler from org/villekoskela/utils/RectanglePacker.as
 * org.villekoskela.utils.RectanglePacker
 *
 * @fileoverview
 *
 * @suppress {missingRequire|checkTypes|accessControls}
 */

goog.provide('org.villekoskela.utils.RectanglePacker');
/* Royale Dependency List: flash.geom.Rectangle,org.villekoskela.utils.IntegerRectangle,org.villekoskela.utils.SortableSize,org.apache.royale.utils.Language*/




/**
 * Constructs new rectangle packer
 * @asparam width the width of the main rectangle
 * @asparam height the height of the main rectangle
 * @constructor
 * @param {number} width
 * @param {number} height
 * @param {number=} padding
 */
org.villekoskela.utils.RectanglePacker = function(width, height, padding) {
  padding = typeof padding !== 'undefined' ? padding : 0;
  
  this.org_villekoskela_utils_RectanglePacker_mInsertList = [];
  this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles = new (org.apache.royale.utils.Language.synthVector('org.villekoskela.utils.IntegerRectangle'))();
  this.org_villekoskela_utils_RectanglePacker_mFreeAreas = new (org.apache.royale.utils.Language.synthVector('org.villekoskela.utils.IntegerRectangle'))();
  this.org_villekoskela_utils_RectanglePacker_mNewFreeAreas = new (org.apache.royale.utils.Language.synthVector('org.villekoskela.utils.IntegerRectangle'))();
  this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack = new (org.apache.royale.utils.Language.synthVector('org.villekoskela.utils.SortableSize'))();
  this.org_villekoskela_utils_RectanglePacker_mRectangleStack = new (org.apache.royale.utils.Language.synthVector('org.villekoskela.utils.IntegerRectangle'))();
  this.org_villekoskela_utils_RectanglePacker_mOutsideRectangle = new org.villekoskela.utils.IntegerRectangle(width + 1, height + 1, 0, 0);
  this.reset(width, height, padding);
};


/**
 * @nocollapse
 * @const
 * @type {string}
 */
org.villekoskela.utils.RectanglePacker.VERSION = "1.3.0";


/**
 * @private
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mWidth = 0;


/**
 * @private
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mHeight = 0;


/**
 * @private
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mPadding = 8;


/**
 * @private
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mPackedWidth = 0;


/**
 * @private
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mPackedHeight = 0;


/**
 * @private
 * @type {Array}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mInsertList = null;


/**
 * @private
 * @type {Array.<org.villekoskela.utils.IntegerRectangle>}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mInsertedRectangles = null;


/**
 * @private
 * @type {Array.<org.villekoskela.utils.IntegerRectangle>}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mFreeAreas = null;


/**
 * @private
 * @type {Array.<org.villekoskela.utils.IntegerRectangle>}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mNewFreeAreas = null;


/**
 * @private
 * @type {org.villekoskela.utils.IntegerRectangle}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mOutsideRectangle = null;


/**
 * @private
 * @type {Array.<org.villekoskela.utils.SortableSize>}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mSortableSizeStack = null;


/**
 * @private
 * @type {Array.<org.villekoskela.utils.IntegerRectangle>}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_mRectangleStack = null;


/**
 * Resets the rectangle packer with given dimensions
 * @asparam width
 * @asparam height
 * @param {number} width
 * @param {number} height
 * @param {number=} padding
 */
org.villekoskela.utils.RectanglePacker.prototype.reset = function(width, height, padding) {
  padding = typeof padding !== 'undefined' ? padding : 0;
  while (this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles.length) {
    this.org_villekoskela_utils_RectanglePacker_freeRectangle(this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles.pop());
  }
  while (this.org_villekoskela_utils_RectanglePacker_mFreeAreas.length) {
    this.org_villekoskela_utils_RectanglePacker_freeRectangle(this.org_villekoskela_utils_RectanglePacker_mFreeAreas.pop());
  }
  this.org_villekoskela_utils_RectanglePacker_mWidth = width;
  this.org_villekoskela_utils_RectanglePacker_mHeight = height;
  this.org_villekoskela_utils_RectanglePacker_mPackedWidth = 0;
  this.org_villekoskela_utils_RectanglePacker_mPackedHeight = 0;
  this.org_villekoskela_utils_RectanglePacker_mFreeAreas[this.org_villekoskela_utils_RectanglePacker_mFreeAreas[org.apache.royale.utils.Language.CHECK_INDEX](0)] = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(0, 0, this.org_villekoskela_utils_RectanglePacker_mWidth, this.org_villekoskela_utils_RectanglePacker_mHeight);
  while (this.org_villekoskela_utils_RectanglePacker_mInsertList.length) {
    this.org_villekoskela_utils_RectanglePacker_freeSize(/* implicit cast */ org.apache.royale.utils.Language.as(this.org_villekoskela_utils_RectanglePacker_mInsertList.pop(), org.villekoskela.utils.SortableSize, true));
  }
  this.org_villekoskela_utils_RectanglePacker_mPadding = padding;
};


/**
 * Gets the position of the rectangle in given index in the main rectangle
 * @asparam index the index of the rectangle
 * @asparam rectangle an instance where to set the rectangle's values
 * @asreturn
 * @param {number} index
 * @param {flash.geom.Rectangle} rectangle
 * @return {flash.geom.Rectangle}
 */
org.villekoskela.utils.RectanglePacker.prototype.getRectangle = function(index, rectangle) {
  var /** @type {org.villekoskela.utils.IntegerRectangle} */ inserted = this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles[index];
  if (rectangle) {
    rectangle.x = inserted.x;
    rectangle.y = inserted.y;
    rectangle.width = inserted.width;
    rectangle.height = inserted.height;
    return rectangle;
  }
  return new flash.geom.Rectangle(inserted.x, inserted.y, inserted.width, inserted.height);
};


/**
 * Gets the original id for the inserted rectangle in given index
 * @asparam index
 * @asreturn
 * @param {number} index
 * @return {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.getRectangleId = function(index) {
  var /** @type {org.villekoskela.utils.IntegerRectangle} */ inserted = this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles[index];
  return inserted.id;
};


/**
 * Add a rectangle to be packed into the packer
 * @width the width of inserted rectangle
 * @height the height of inserted rectangle
 * @id the identifier for this rectangle
 * @asreturn true if inserted successfully
 * @param {number} width
 * @param {number} height
 * @param {number} id
 */
org.villekoskela.utils.RectanglePacker.prototype.insertRectangle = function(width, height, id) {
  var /** @type {org.villekoskela.utils.SortableSize} */ sortableSize = this.org_villekoskela_utils_RectanglePacker_allocateSize(width, height, id);
  this.org_villekoskela_utils_RectanglePacker_mInsertList.push(sortableSize);
};


/**
 * Packs the rectangles inserted
 * @asparam sort boolean defining whether to sort the inserted rectangles before packing
 * @asreturn the number of the packed rectangles
 * @param {boolean=} sort
 * @return {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.packRectangles = function(sort) {
  sort = typeof sort !== 'undefined' ? sort : true;
  if (sort) {
    org.apache.royale.utils.Language.sortOn(this.org_villekoskela_utils_RectanglePacker_mInsertList, "width", 16);
  }
  while (this.org_villekoskela_utils_RectanglePacker_mInsertList.length > 0) {
    var /** @type {org.villekoskela.utils.SortableSize} */ sortableSize = this.org_villekoskela_utils_RectanglePacker_mInsertList.pop();
    var /** @type {number} */ width = sortableSize.width;
    var /** @type {number} */ height = sortableSize.height;
    var /** @type {number} */ index = this.org_villekoskela_utils_RectanglePacker_getFreeAreaIndex(width, height);
    if (index >= 0) {
      var /** @type {org.villekoskela.utils.IntegerRectangle} */ freeArea = this.org_villekoskela_utils_RectanglePacker_mFreeAreas[index];
      var /** @type {org.villekoskela.utils.IntegerRectangle} */ target = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(freeArea.x, freeArea.y, width, height);
      target.id = sortableSize.id;
      this.org_villekoskela_utils_RectanglePacker_generateNewFreeAreas(target, this.org_villekoskela_utils_RectanglePacker_mFreeAreas, this.org_villekoskela_utils_RectanglePacker_mNewFreeAreas);
      while (this.org_villekoskela_utils_RectanglePacker_mNewFreeAreas.length > 0) {
        this.org_villekoskela_utils_RectanglePacker_mFreeAreas[this.org_villekoskela_utils_RectanglePacker_mFreeAreas[org.apache.royale.utils.Language.CHECK_INDEX](this.org_villekoskela_utils_RectanglePacker_mFreeAreas.length)] = this.org_villekoskela_utils_RectanglePacker_mNewFreeAreas.pop();
      }
      this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles[this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles[org.apache.royale.utils.Language.CHECK_INDEX](this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles.length)] = target;
      if (target.right > this.org_villekoskela_utils_RectanglePacker_mPackedWidth) {
        this.org_villekoskela_utils_RectanglePacker_mPackedWidth = target.right;
      }
      if (target.bottom > this.org_villekoskela_utils_RectanglePacker_mPackedHeight) {
        this.org_villekoskela_utils_RectanglePacker_mPackedHeight = target.bottom;
      }
    }
    this.org_villekoskela_utils_RectanglePacker_freeSize(sortableSize);
  }
  return this.rectangleCount;
};


/**
 * Removes rectangles from the filteredAreas that are sub rectangles of any rectangle in areas.
 * @asparam areas rectangles from which the filtering is performed
 * @private
 * @param {Array.<IntegerRectangle>} areas
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_filterSelfSubAreas = function(areas) {
  for (var /** @type {number} */ i = (areas.length - 1) >> 0; i >= 0; i--) {
    var /** @type {org.villekoskela.utils.IntegerRectangle} */ filtered = areas[i];
    for (var /** @type {number} */ j = (areas.length - 1) >> 0; j >= 0; j--) {
      if (i != j) {
        var /** @type {org.villekoskela.utils.IntegerRectangle} */ area = areas[j];
        if (filtered.x >= area.x && filtered.y >= area.y && filtered.right <= area.right && filtered.bottom <= area.bottom) {
          this.org_villekoskela_utils_RectanglePacker_freeRectangle(filtered);
          var /** @type {org.villekoskela.utils.IntegerRectangle} */ topOfStack = areas.pop();
          if (i < areas.length) {
            areas[areas[org.apache.royale.utils.Language.CHECK_INDEX](i)] = topOfStack;
          }
          break;
        }
      }
    }
  }
};


/**
 * Checks what areas the given rectangle intersects, removes those areas and
 * returns the list of new areas those areas are divided into
 * @asparam target the new rectangle that is dividing the areas
 * @asparam areas the areas to be divided
 * @asreturn list of new areas
 * @private
 * @param {org.villekoskela.utils.IntegerRectangle} target
 * @param {Array.<IntegerRectangle>} areas
 * @param {Array.<IntegerRectangle>} results
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_generateNewFreeAreas = function(target, areas, results) {
  
/**
 * @const
 * @type {number}
 */
var x = target.x;
  
/**
 * @const
 * @type {number}
 */
var y = target.y;
  
/**
 * @const
 * @type {number}
 */
var right = (target.right + 1 + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0;
  
/**
 * @const
 * @type {number}
 */
var bottom = (target.bottom + 1 + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0;
  var /** @type {org.villekoskela.utils.IntegerRectangle} */ targetWithPadding = null;
  if (this.org_villekoskela_utils_RectanglePacker_mPadding == 0) {
    targetWithPadding = target;
  }
  for (var /** @type {number} */ i = (areas.length - 1) >> 0; i >= 0; i--) {
    
/**
 * @const
 * @type {org.villekoskela.utils.IntegerRectangle}
 */
var area = areas[i];
    if (!(x >= area.right || right <= area.x || y >= area.bottom || bottom <= area.y)) {
      if (!targetWithPadding) {
        targetWithPadding = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(target.x, target.y, (target.width + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0, (target.height + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0);
      }
      this.org_villekoskela_utils_RectanglePacker_generateDividedAreas(targetWithPadding, area, results);
      var /** @type {org.villekoskela.utils.IntegerRectangle} */ topOfStack = areas.pop();
      if (i < areas.length) {
        areas[areas[org.apache.royale.utils.Language.CHECK_INDEX](i)] = topOfStack;
      }
    }
  }
  if (targetWithPadding && targetWithPadding != target) {
    this.org_villekoskela_utils_RectanglePacker_freeRectangle(targetWithPadding);
  }
  this.org_villekoskela_utils_RectanglePacker_filterSelfSubAreas(results);
};


/**
 * Divides the area into new sub areas around the divider.
 * @asparam divider rectangle that intersects the area
 * @asparam area rectangle to be divided into sub areas around the divider
 * @asparam results vector for the new sub areas around the divider
 * @private
 * @param {org.villekoskela.utils.IntegerRectangle} divider
 * @param {org.villekoskela.utils.IntegerRectangle} area
 * @param {Array.<IntegerRectangle>} results
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_generateDividedAreas = function(divider, area, results) {
  var /** @type {number} */ count = 0;
  
/**
 * @const
 * @type {number}
 */
var rightDelta = (area.right - divider.right) >> 0;
  if (rightDelta > 0) {
    results[results[org.apache.royale.utils.Language.CHECK_INDEX](results.length)] = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(divider.right, area.y, rightDelta, area.height);
    count++;
  }
  
/**
 * @const
 * @type {number}
 */
var leftDelta = (divider.x - area.x) >> 0;
  if (leftDelta > 0) {
    results[results[org.apache.royale.utils.Language.CHECK_INDEX](results.length)] = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(area.x, area.y, leftDelta, area.height);
    count++;
  }
  
/**
 * @const
 * @type {number}
 */
var bottomDelta = (area.bottom - divider.bottom) >> 0;
  if (bottomDelta > 0) {
    results[results[org.apache.royale.utils.Language.CHECK_INDEX](results.length)] = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(area.x, divider.bottom, area.width, bottomDelta);
    count++;
  }
  
/**
 * @const
 * @type {number}
 */
var topDelta = (divider.y - area.y) >> 0;
  if (topDelta > 0) {
    results[results[org.apache.royale.utils.Language.CHECK_INDEX](results.length)] = this.org_villekoskela_utils_RectanglePacker_allocateRectangle(area.x, area.y, area.width, topDelta);
    count++;
  }
  if (count == 0 && (divider.width < area.width || divider.height < area.height)) {
    results[results[org.apache.royale.utils.Language.CHECK_INDEX](results.length)] = area;
  } else {
    this.org_villekoskela_utils_RectanglePacker_freeRectangle(area);
  }
};


/**
 * Gets the index of the best free area for the given rectangle
 * @width the width of inserted rectangle
 * @height the height of inserted rectangle
 * @asreturn index of the best free area or -1 if no suitable free area available
 * @private
 * @param {number} width
 * @param {number} height
 * @return {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_getFreeAreaIndex = function(width, height) {
  var /** @type {org.villekoskela.utils.IntegerRectangle} */ best = this.org_villekoskela_utils_RectanglePacker_mOutsideRectangle;
  var /** @type {number} */ index = -1;
  
/**
 * @const
 * @type {number}
 */
var paddedWidth = (width + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0;
  
/**
 * @const
 * @type {number}
 */
var paddedHeight = (height + this.org_villekoskela_utils_RectanglePacker_mPadding) >> 0;
  
/**
 * @const
 * @type {number}
 */
var count = (this.org_villekoskela_utils_RectanglePacker_mFreeAreas.length) >> 0;
  for (var /** @type {number} */ i = (count - 1) >> 0; i >= 0; i--) {
    
/**
 * @const
 * @type {org.villekoskela.utils.IntegerRectangle}
 */
var free = this.org_villekoskela_utils_RectanglePacker_mFreeAreas[i];
    if (free.x < this.org_villekoskela_utils_RectanglePacker_mPackedWidth || free.y < this.org_villekoskela_utils_RectanglePacker_mPackedHeight) {
      if (free.x < best.x && paddedWidth <= free.width && paddedHeight <= free.height) {
        index = i;
        if ((paddedWidth == free.width && free.width <= free.height && free.right < this.org_villekoskela_utils_RectanglePacker_mWidth) || (paddedHeight == free.height && free.height <= free.width)) {
          break;
        }
        best = free;
      }
    } else {
      if (free.x < best.x && width <= free.width && height <= free.height) {
        index = i;
        if ((width == free.width && free.width <= free.height && free.right < this.org_villekoskela_utils_RectanglePacker_mWidth) || (height == free.height && free.height <= free.width)) {
          break;
        }
        best = free;
      }
    }
  }
  return index;
};


/**
 * Allocates new rectangle. If one available in stack uses that, otherwise new.
 * @asparam x
 * @asparam y
 * @asparam width
 * @asparam height
 * @asreturn
 * @private
 * @param {number} x
 * @param {number} y
 * @param {number} width
 * @param {number} height
 * @return {org.villekoskela.utils.IntegerRectangle}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_allocateRectangle = function(x, y, width, height) {
  if (this.org_villekoskela_utils_RectanglePacker_mRectangleStack.length > 0) {
    var /** @type {org.villekoskela.utils.IntegerRectangle} */ rectangle = this.org_villekoskela_utils_RectanglePacker_mRectangleStack.pop();
    rectangle.x = x;
    rectangle.y = y;
    rectangle.width = width;
    rectangle.height = height;
    rectangle.right = (x + width) >> 0;
    rectangle.bottom = (y + height) >> 0;
    return rectangle;
  }
  return new org.villekoskela.utils.IntegerRectangle(x, y, width, height);
};


/**
 * Pushes the freed rectangle to rectangle stack. Make sure not to push same rectangle twice!
 * @asparam rectangle
 * @private
 * @param {org.villekoskela.utils.IntegerRectangle} rectangle
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_freeRectangle = function(rectangle) {
  this.org_villekoskela_utils_RectanglePacker_mRectangleStack[this.org_villekoskela_utils_RectanglePacker_mRectangleStack[org.apache.royale.utils.Language.CHECK_INDEX](this.org_villekoskela_utils_RectanglePacker_mRectangleStack.length)] = rectangle;
};


/**
 * Allocates new sortable size instance. If one available in stack uses that, otherwise new.
 * @asparam width
 * @asparam height
 * @asparam id
 * @asreturn
 * @private
 * @param {number} width
 * @param {number} height
 * @param {number} id
 * @return {org.villekoskela.utils.SortableSize}
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_allocateSize = function(width, height, id) {
  if (this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack.length > 0) {
    var /** @type {org.villekoskela.utils.SortableSize} */ size = this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack.pop();
    size.width = width;
    size.height = height;
    size.id = id;
    return size;
  }
  return new org.villekoskela.utils.SortableSize(width, height, id);
};


/**
 * Pushes the freed sortable size to size stack. Make sure not to push same size twice!
 * @asparam size
 * @private
 * @param {org.villekoskela.utils.SortableSize} size
 */
org.villekoskela.utils.RectanglePacker.prototype.org_villekoskela_utils_RectanglePacker_freeSize = function(size) {
  this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack[this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack[org.apache.royale.utils.Language.CHECK_INDEX](this.org_villekoskela_utils_RectanglePacker_mSortableSizeStack.length)] = size;
};


org.villekoskela.utils.RectanglePacker.prototype.get__rectangleCount = function() {
  return (this.org_villekoskela_utils_RectanglePacker_mInsertedRectangles.length) >> 0;
};


org.villekoskela.utils.RectanglePacker.prototype.get__packedWidth = function() {
  return this.org_villekoskela_utils_RectanglePacker_mPackedWidth;
};


org.villekoskela.utils.RectanglePacker.prototype.get__packedHeight = function() {
  return this.org_villekoskela_utils_RectanglePacker_mPackedHeight;
};


org.villekoskela.utils.RectanglePacker.prototype.get__padding = function() {
  return this.org_villekoskela_utils_RectanglePacker_mPadding;
};


Object.defineProperties(org.villekoskela.utils.RectanglePacker.prototype, /** @lends {org.villekoskela.utils.RectanglePacker.prototype} */ {
/**
 * @type {number}
 */
rectangleCount: {
get: org.villekoskela.utils.RectanglePacker.prototype.get__rectangleCount},
/**
 * @type {number}
 */
packedWidth: {
get: org.villekoskela.utils.RectanglePacker.prototype.get__packedWidth},
/**
 * @type {number}
 */
packedHeight: {
get: org.villekoskela.utils.RectanglePacker.prototype.get__packedHeight},
/**
 * @type {number}
 */
padding: {
get: org.villekoskela.utils.RectanglePacker.prototype.get__padding}}
);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.villekoskela.utils.RectanglePacker.prototype.ROYALE_CLASS_INFO = { names: [{ name: 'RectanglePacker', qName: 'org.villekoskela.utils.RectanglePacker', kind: 'class' }] };



/**
 * Reflection
 *
 * @return {Object.<string, Function>}
 */
org.villekoskela.utils.RectanglePacker.prototype.ROYALE_REFLECTION_INFO = function () {
  return {
    accessors: function () {
      return {
        'rectangleCount': { type: 'int', access: 'readonly', declaredBy: 'org.villekoskela.utils.RectanglePacker'},
        'packedWidth': { type: 'int', access: 'readonly', declaredBy: 'org.villekoskela.utils.RectanglePacker'},
        'packedHeight': { type: 'int', access: 'readonly', declaredBy: 'org.villekoskela.utils.RectanglePacker'},
        'padding': { type: 'int', access: 'readonly', declaredBy: 'org.villekoskela.utils.RectanglePacker'}
      };
    },
    methods: function () {
      return {
        'RectanglePacker': { type: '', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'int', false ,'int', false ,'int', true ]; }},
        'reset': { type: 'void', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'int', false ,'int', false ,'int', true ]; }},
        'getRectangle': { type: 'flash.geom.Rectangle', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'int', false ,'flash.geom.Rectangle', false ]; }},
        'getRectangleId': { type: 'int', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'int', false ]; }},
        'insertRectangle': { type: 'void', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'int', false ,'int', false ,'int', false ]; }},
        'packRectangles': { type: 'int', declaredBy: 'org.villekoskela.utils.RectanglePacker', parameters: function () { return [ 'Boolean', true ]; }}
      };
    }
  };
};
/**
 * @const
 * @type {number}
 */
org.villekoskela.utils.RectanglePacker.prototype.ROYALE_COMPILE_FLAGS = 9;
/**
 * Provide reflection support for distinguishing dynamic fields on class object (static)
 * @const
 * @type {Array<string>}
 */
org.villekoskela.utils.RectanglePacker.prototype.ROYALE_INITIAL_STATICS = Object.keys(org.villekoskela.utils.RectanglePacker);
