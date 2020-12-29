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


// webkit_notifications
/**
 * @constructor
 */
function ExtendableEvent() {}

// chrome.js
/**
 * @constructor
 */
function HTMLEmbedElement() {};

/**
 * @type {!Window}
 * @const
 */
var window;

/**
 * @type {!HTMLDocument}
 */
Window.prototype.document;

/**
 * @type {!SpeechSynthesis}
 */
Window.prototype.speechSynthesis;

/**
 * resolveLocalFileSystemURI has been deprecated; this is the replacement.
 * @see http://www.w3.org/TR/file-system-api/#widl-LocalFileSystem-resolveLocalFileSystemURL
 * @param {string} url
 * @param {function(!Entry)} successCallback
 * @param {function(!FileError)=} errorCallback
 */
Window.prototype.resolveLocalFileSystemURL = function(url, successCallback,
    errorCallback) {}


/**
* @constructor
*/
function performance() {};

/**
* @return {number} time to return
*/
performance.now = function() {};

/**
 * @constructor
 */
function Navigator() {}


/**
 * @constructor
 */
function Screen() {}

/**
 * @constructor
 */
function uint() {}

/**
 * @param {number=} opt_radix Optional radix.
 * @return {string} The result.
 */
uint.prototype.toString = function(opt_radix) {}

/**
 * @constructor
 */
function int() {}

/**
 * @param {number=} opt_radix Optional radix.
 * @return {string} The result.
 */
int.prototype.toString = function(opt_radix) {}


/**
 * @type {Object}
 */
Object.prototype;

/**
 * @type {Object}
 */
Object.prototype.prototype;

/**
 * @constructor
 * @extends {Function}
 */
function Class() {}

/**
 * @constructor
 */
function JSON() {}

/**
 * @param {string} s The input.
 * @param {(function(string, *) : *)=} opt_reviver
 * @return {Object} The result.
 */
JSON.parse = function(s, opt_reviver) {}

/**
 * @param {Object} obj The input.
 * @param {(Array<string>|(function(string, *) : *)|null)=} opt_replacer
 * @param {string|number=} opt_space Optional space.
 * @return {string} The result.
 */
JSON.stringify = function(obj, opt_replacer, opt_space) {}

// gecko

/**
 * @constructor
 */
function History() {}

/**
 * @constructor
 */
function Location() {}

/**
 * @type {number}
 */
XMLHttpRequest.prototype.timeout;


/**
 * @export
 * This gets mapped to org.apache.royale.utils.Language.trace() by the compiler
 * @param {...} rest
 */
function trace(rest) {}

/**
 * @type {!Console}
 * @const
 */
var console;


/**
 * @type {number}
 * @const
 */
Array.CASEINSENSITIVE;

/**
 * @type {number}
 * @const
 */
Array.DESCENDING;

/**
 * @type {number}
 * @const
 */
Array.UNIQUESORT;

/**
 * @type {number}
 * @const
 */
Array.RETURNINDEXEDARRAY;

/**
 * @type {number}
 * @const
 */
Array.NUMERIC;


/**
 * @param {number} index The index.
 * @param {Object} element The Object.
 */
Array.prototype.insertAt = function(index, element) {};

/**
 * @param {number} index The index.
 */
Array.prototype.removeAt = function(index) {};

/**
 * @param {Object} fieldName The field name or array of field names.
 * @param {Object=} opt_options The bitmask of options.
 * @return {Array} The sorted Array.
 */
Array.prototype.sortOn = function(fieldName, opt_options) {};

/**
 * @const {int}
 */
int.MAX_VALUE;


/**
 * @const {int}
 */
int.MIN_VALUE;


/**
 * @const {uint}
 */
uint.MAX_VALUE;


/**
 * @const {uint}
 */
uint.MIN_VALUE;

// additions to the Date prototype to allow AS code to use these properties

/**
 * @type {number}
 */
Date.prototype.date;

/**
 * @type {number}
 */
Date.prototype.dateUTC;

/**
 * @type {number}
 */
Date.prototype.day;

/**
 * @type {number}
 */
Date.prototype.dayUTC;

/**
 * @type {number}
 */
Date.prototype.fullYear;

/**
 * @type {number}
 */
Date.prototype.fullYearUTC;

/**
 * @type {number}
 */
Date.prototype.hours;

/**
 * @type {number}
 */
Date.prototype.hoursUTC;

/**
 * @type {number}
 */
Date.prototype.milliseconds;

/**
 * @type {number}
 */
Date.prototype.millisecondsUTC;

/**
 * @type {number}
 */
Date.prototype.minutes;

/**
 * @type {number}
 */
Date.prototype.minutesUTC;

/**
 * @type {number}
 */
Date.prototype.month;

/**
 * @type {number}
 */
Date.prototype.monthUTC;

/**
 * @type {number}
 */
Date.prototype.seconds;

/**
 * @type {number}
 */
Date.prototype.secondsUTC;

/**
 * @type {number}
 */
Date.prototype.time;

/**
 * @type {number}
 */
Date.prototype.timezoneOffset;

/**
 * @param {string} type
 * @param {EventListener|function(!Event):*} listener
 * @param {(boolean|!AddEventListenerOptions)=} opt_options
 * @return {undefined}
 * @see https://dom.spec.whatwg.org/#dom-eventtarget-addeventlistener
 */
BaseAudioContext.prototype.addEventListener = function(type, listener, opt_options) {
};

/**
 * @param {string} type
 * @param {EventListener|function(!Event):*} listener
 * @param {(boolean|!EventListenerOptions)=} opt_options
 * @return {undefined}
 * @see https://dom.spec.whatwg.org/#dom-eventtarget-removeeventlistener
 */
BaseAudioContext.prototype.removeEventListener = function(
    type, listener, opt_options) {};
	
/**
 * @param {!Event} evt
 * @return {boolean}
 * @see https://dom.spec.whatwg.org/#dom-eventtarget-dispatchevent
 */
BaseAudioContext.prototype.dispatchEvent = function(evt) {};


// WEB-ANIMATIONS-API

/**
 * @fileoverview Basic externs for the Web Animations API. This is not
 * nessecarily exhaustive. For more information, see the spec-
 *   https://drafts.csswg.org/web-animations/
 * @externs
 */


/**
 * @param {!Array<!Object>} frames
 * @param {(number|AnimationEffectTimingProperties)=} opt_options
 * @return {!Animation}
 */
Element.prototype.animate = function(frames, opt_options) {};


/**
 * @interface
 * @extends {EventTarget}
 */
var Animation = function() {};

/**
 * @return {undefined}
 */
Animation.prototype.cancel = function() {};

/**
 * @return {undefined}
 */
Animation.prototype.finish = function() {};

/**
 * @return {undefined}
 */
Animation.prototype.reverse = function() {};

/**
 * @return {undefined}
 */
Animation.prototype.pause = function() {};

/**
 * @return {undefined}
 */
Animation.prototype.play = function() {};

/** @type {number} */
Animation.prototype.startTime;

/** @type {number} */
Animation.prototype.currentTime;

/** @type {number} */
Animation.prototype.playbackRate;

/** @type {string} */
Animation.prototype.playState;

/** @type {?function(!Event)} */
Animation.prototype.oncancel;

/** @type {?function(!Event)} */
Animation.prototype.onfinish;


/**
 * @typedef {{
 *   delay: (number|undefined),
 *   endDelay: (number|undefined),
 *   fillMode: (string|undefined),
 *   iterationStart: (number|undefined),
 *   iterations: (number|undefined),
 *   duration: (number|string|undefined),
 *   direction: (string|undefined),
 *   easing: (string|undefined)
 * }}
 */
var AnimationEffectTimingProperties;


/**
 * @interface
 */
var AnimationEffectTiming = function() {};

/** @type {number} */
AnimationEffectTiming.prototype.delay;

/** @type {number} */
AnimationEffectTiming.prototype.endDelay;

/** @type {string} */
AnimationEffectTiming.prototype.fillMode;

/** @type {number} */
AnimationEffectTiming.prototype.iterationStart;

/** @type {number} */
AnimationEffectTiming.prototype.iterations;

/** @type {number|string} */
AnimationEffectTiming.prototype.duration;

/** @type {string} */
AnimationEffectTiming.prototype.direction;

/** @type {string} */
AnimationEffectTiming.prototype.easing;

/**
 * @fileoverview Definitions for URL and URLSearchParams from the spec at
 * https://url.spec.whatwg.org.
 *
 * @externs
 * @author rdcronin@google.com (Devlin Cronin)
 */

/**
 * @constructor
 * @implements {Iterable<!Array<string>>}
 * @param {(string|!URLSearchParams)=} init
 */
function URLSearchParams(init) {}

/**
 * @param {string} name
 * @param {string} value
 * @return {undefined}
 */
URLSearchParams.prototype.append = function(name, value) {};

/**
 * @param {string} name
 * @return {undefined}
 */
URLSearchParams.prototype.delete = function(name) {};

/**
 * @param {string} name
 * @return {?string}
 */
URLSearchParams.prototype.get = function(name) {};

/**
 * @param {string} name
 * @return {!Array<string>}
 */
URLSearchParams.prototype.getAll = function(name) {};

/**
 * @param {string} name
 * @return {boolean}
 */
URLSearchParams.prototype.has = function(name) {};

/**
 * @param {string} name
 * @param {string} value
 * @return {undefined}
 */
URLSearchParams.prototype.set = function(name, value) {};

/**
 * @see https://url.spec.whatwg.org
 * @constructor
 * @param {string} url
 * @param {(string|!URL)=} base
 */
function URL(url, base) {}

/** @type {string} */
URL.prototype.href;

/**
 * @const
 * @type {string}
 */
URL.prototype.origin;

/** @type {string} */
URL.prototype.protocol;

/** @type {string} */
URL.prototype.username;

/** @type {string} */
URL.prototype.password;

/** @type {string} */
URL.prototype.host;

/** @type {string} */
URL.prototype.hostname;

/** @type {string} */
URL.prototype.port;

/** @type {string} */
URL.prototype.pathname;

/** @type {string} */
URL.prototype.search;

/**
 * @const
 * @type {!URLSearchParams}
 */
URL.prototype.searchParams;

/** @type {string} */
URL.prototype.hash;

/**
 * @param {string} domain
 * @return {string}
 */
URL.domainToASCII = function(domain) {};

/**
 * @param {string} domain
 * @return {string}
 */
URL.domainToUnicode = function(domain) {};

/**
 * @see http://www.w3.org/TR/FileAPI/#dfn-createObjectURL
 * @param {!File|!Blob|!MediaSource|!MediaStream} obj
 * @return {string}
 */
URL.createObjectURL = function(obj) {};

/**
 * @see http://www.w3.org/TR/FileAPI/#dfn-revokeObjectURL
 * @param {string} url
 * @return {undefined}
 */
URL.revokeObjectURL = function(url) {};
