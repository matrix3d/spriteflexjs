/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @fileoverview Definitions for objects in the Apache Cordova project:
 * https://cordova.apache.org
 *
 * @externs
 */


/**
 * @type {!Object}
 * @const
 */
var cordova;


/* from Google Externs fileapi.js */

/**
 * @record
 * @see https://dev.w3.org/2009/dap/file-system/file-dir-sys.html#the-flags-dictionary
 */
function FileSystemFlags() {};

/** @type {(undefined|boolean)} */
FileSystemFlags.prototype.create;

/** @type {(undefined|boolean)} */
FileSystemFlags.prototype.exclusive;


/**
 * @see http://www.w3.org/TR/file-system-api/#the-directoryentry-interface
 * @constructor
 * @extends {Entry}
 */
function DirectoryEntry() {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-DirectoryEntry-createReader
 * @return {!DirectoryReader}
 */
DirectoryEntry.prototype.createReader = function() {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-DirectoryEntry-getFile
 * @param {string} path
 * @param {!FileSystemFlags=} options
 * @param {function(!FileEntry)=} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
DirectoryEntry.prototype.getFile = function(path, options, successCallback,
    errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-DirectoryEntry-getDirectory
 * @param {string} path
 * @param {!FileSystemFlags=} options
 * @param {function(!DirectoryEntry)=} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
DirectoryEntry.prototype.getDirectory = function(path, options, successCallback,
    errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-DirectoryEntry-removeRecursively
 * @param {function()} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
DirectoryEntry.prototype.removeRecursively = function(successCallback,
    errorCallback) {};
	
/**
 * @see http://www.w3.org/TR/file-system-api/#the-directoryreader-interface
 * @constructor
 */
function DirectoryReader() {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-DirectoryReader-readEntries
 * @param {function(!Array<!Entry>)} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
DirectoryReader.prototype.readEntries = function(successCallback,
    errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-writer-api/#idl-def-FileSaver
 * @constructor
 */
function FileSaver() {};

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-abort
 * @return {undefined}
 */
FileSaver.prototype.abort = function() {};

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-INIT
 * @type {number}
 */
FileSaver.prototype.INIT = 0;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-WRITING
 * @type {number}
 */
FileSaver.prototype.WRITING = 1;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-DONE
 * @type {number}
 */
FileSaver.prototype.DONE = 2;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-readyState
 * @type {number}
 */
FileSaver.prototype.readyState;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-error
 * @type {FileError}
 */
FileSaver.prototype.error;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onwritestart
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onwritestart;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onprogress
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onprogress;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onwrite
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onwrite;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onabort
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onabort;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onerror
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onerror;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileSaver-onwriteend
 * @type {?function(!ProgressEvent)}
 */
FileSaver.prototype.onwriteend;

/**
 * @see http://www.w3.org/TR/file-system-api/#the-filesystem-interface
 * @constructor
 */
function FileSystem() {}

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-FileSystem-name
 * @type {string}
 */
FileSystem.prototype.name;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-FileSystem-root
 * @type {!DirectoryEntry}
 */
FileSystem.prototype.root;

/**
 * @see http://www.w3.org/TR/file-writer-api/#idl-def-FileWriter
 * @constructor
 * @extends {FileSaver}
 */
function FileWriter() {}

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileWriter-position
 * @type {number}
 */
FileWriter.prototype.position;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileWriter-length
 * @type {number}
 */
FileWriter.prototype.length;

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileWriter-write
 * @param {!Blob} blob
 * @return {undefined}
 */
FileWriter.prototype.write = function(blob) {};

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileWriter-seek
 * @param {number} offset
 * @return {undefined}
 */
FileWriter.prototype.seek = function(offset) {};

/**
 * @see http://www.w3.org/TR/file-writer-api/#widl-FileWriter-truncate
 * @param {number} size
 * @return {undefined}
 */
FileWriter.prototype.truncate = function(size) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#the-fileentry-interface
 * @constructor
 * @extends {Entry}
 */
function FileEntry() {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-FileEntry-createWriter
 * @param {function(!FileWriter)} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
FileEntry.prototype.createWriter = function(successCallback, errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-FileEntry-file
 * @param {function(!File)} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
FileEntry.prototype.file = function(successCallback, errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#the-entry-interface
 * @constructor
 */
function Entry() {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-isFile
 * @type {boolean}
 */
Entry.prototype.isFile;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-isDirectory
 * @type {boolean}
 */
Entry.prototype.isDirectory;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-name
 * @type {string}
 */
Entry.prototype.name;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-fullPath
 * @type {string}
 */
Entry.prototype.fullPath;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-filesystem
 * @type {!FileSystem}
 */
Entry.prototype.filesystem;

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-moveTo
 * @param {!DirectoryEntry} parent
 * @param {string=} newName
 * @param {function(!Entry)=} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
Entry.prototype.moveTo = function(parent, newName, successCallback,
    errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-copyTo
 * @param {!DirectoryEntry} parent
 * @param {string=} newName
 * @param {function(!Entry)=} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
Entry.prototype.copyTo = function(parent, newName, successCallback,
    errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-toURL
 * @param {string=} mimeType
 * @return {string}
 */
Entry.prototype.toURL = function(mimeType) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-remove
 * @param {function()} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
Entry.prototype.remove = function(successCallback, errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-getMetadata
 * @param {function(!Metadata)} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
Entry.prototype.getMetadata = function(successCallback, errorCallback) {};

/**
 * @see http://www.w3.org/TR/file-system-api/#widl-Entry-getParent
 * @param {function(!Entry)} successCallback
 * @param {function(!FileError)=} errorCallback
 * @return {undefined}
 */
Entry.prototype.getParent = function(successCallback, errorCallback) {};

