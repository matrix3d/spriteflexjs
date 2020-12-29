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

/**
 * @fileoverview Externs for Node.js
 * @see https://nodejs.org/api/
 * @externs
 */

/**
 * @param {string} command
 * @param {child_process.Options} options
 * @return {Buffer|string}
 */
child_process.execSync;

/**
 * @param {string} file
 * @param {Array.<string>} args
 * @param {child_process.Options} options
 * @return {Buffer|string}
 */
child_process.execFileSync;

/**
 * @param {string} p
 * @return {boolean}
 * @nosideeffects
 */
path.isAbsolute;

/**
 * @type {string}
 */
path.delimiter;

/**
 * @return {void}
 * @see http://nodejs.org/api/process.html#process_process_abort
 */
Process.prototype.abort = function () {};

/**
 * @type {string}
 * @see http://nodejs.org/api/process.html#process_process_arch
 */
Process.prototype.arch;

/**
 * @type {Array<string>}
 * @see http://nodejs.org/api/process.html#process_process_argv
 */
Process.prototype.argv;

/**
 * @param {string} directory
 * @see http://nodejs.org/api/process.html#process_process_chdir_directory
 */
Process.prototype.chdir = function (directory) {};

/**
 * @type {*}
 * @see http://nodejs.org/api/process.html#process_process_config
 */
Process.prototype.config;

/**
 * @type {boolean}
 * @see http://nodejs.org/api/process.html#process_process_connected
 */
Process.prototype.connected;

/**
 * @return {string}
 * @see http://nodejs.org/api/process.html#process_process_cwd
 */
Process.prototype.cwd = function () {};

/**
 * @return {void}
 * @see http://nodejs.org/api/process.html#process_process_disconnect
 */
Process.prototype.disconnect = function () {};

/**
 * @type {*}
 * @see http://nodejs.org/api/process.html#process_process_env
 */
Process.prototype.env;

/**
 * @param {number=} code
 * @see http://nodejs.org/api/process.html#process_process_exit_code
 */
Process.prototype.exit = function (code) {};

/**
 * @param {number} pid
 * @param {string|number} signal
 * @see http://nodejs.org/api/process.html#process_process_kill_pid_signal
 */
Process.prototype.kill = function (pid, signal) {};

/**
 * @type {string}
 * @see http://nodejs.org/api/process.html#process_process_pid
 */
Process.prototype.pid;

/**
 * @type {string}
 * @see http://nodejs.org/api/process.html#process_process_platform
 */
Process.prototype.platform;

/**
 * @type {*}
 * @see http://nodejs.org/api/process.html#process_process_release
 */
Process.prototype.release;

/**
 * @return {number}
 * @see http://nodejs.org/api/process.html#process_process_uptime
 */
Process.prototype.uptime = function () {};

/**
 * @type {string}
 * @see http://nodejs.org/api/process.html#process_process_version
 */
Process.prototype.version;

/**
 * @type {*}
 * @see http://nodejs.org/api/process.html#process_process_versions
 */
Process.prototype.versions;