////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package mx.controls.dataGridClasses
{

	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.html.beads.controllers.ListSingleSelectionMouseController;
	import org.apache.royale.utils.sendEvent;
	/**
	 *  The TreeSingleSelectionMouseController class is a controller for 
	 *  org.apache.royale.html.Tree. This controller watches for selection
	 *  events on the tree item renderers and uses those events to open
	 *  or close nodes of the tree.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.0
	 */
	public class DataGridSingleSelectionMouseController extends ListSingleSelectionMouseController
	{
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function DataGridSingleSelectionMouseController()
		{
			super();
		}


		/**
		 * @private
		 */
		override protected function selectedHandler(event:ItemClickedEvent):void
		{
			//this class is really just to avoid the following two lines in the ancestor:
			//listModel.selectedIndex = event.index;
			//listModel.selectedItem = event.data;
			sendEvent(listView.host,"change");
		}
	}
}
