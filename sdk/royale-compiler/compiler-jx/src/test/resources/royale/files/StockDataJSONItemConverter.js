/**
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
goog.provide('StockDataJSONItemConverter');

goog.require('org.apache.royale.net.JSONItemConverter');

/**
 * @constructor
 * @extends {org.apache.royale.net.JSONItemConverter}
 */
StockDataJSONItemConverter = function() {
	goog.base(this);
}
goog.inherits(StockDataJSONItemConverter, org.apache.royale.net.JSONItemConverter);

/**
 * @export
 * @param {string} data
 * @return {Object}
 * @override
 */
StockDataJSONItemConverter.prototype.convertItem = function(data) {
	var /** @type {Object} */ obj = goog.base(this, 'convertItem', data);
	if (obj["query"]["count"] == 0)
		return "No Data";
	obj = obj["query"]["results"]["quote"];
	return obj;
};
