////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//	  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.royale.html.beads.controllers
{
	import org.apache.royale.core.IBeadController;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.IIndexedItemRenderer;
	import org.apache.royale.core.IStrand;
	COMPILE::SWF {
		import org.apache.royale.events.Event;
		import org.apache.royale.events.MouseEvent;
	}
	COMPILE::JS {
		import org.apache.royale.core.UIBase;
		import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.events.BrowserEvent;
		import goog.events.Event;
		import goog.events.EventType;
		import goog.events;
	}
	import org.apache.royale.events.MultiSelectionItemClickedEvent;
	import org.apache.royale.utils.sendEvent;
	import org.apache.royale.utils.getSelectionRenderBead;

	/**
	 *  The MultiSelectionItemRendererMouseController class can mouse events in itemRenderers. This
	 *  includes roll-overs, mouse down, and mouse up. These platform-specific events are then
	 *  re-dispatched as Royale events.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9
	 *  @royaleignoreimport goog.events.Event
	 */

	public class MultiSelectionItemRendererMouseController implements IBeadController
	{
		/**
		 *  constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9
		 */
		public function MultiSelectionItemRendererMouseController()
		{
		}

		private var renderer:IIndexedItemRenderer;
		private var _strand:IStrand;

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9
		 *  @royaleignorecoercion org.apache.royale.core.IIndexedItemRenderer
		 *  @royaleignorecoercion org.apache.royale.core.UIBase
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			renderer = value as IIndexedItemRenderer;

			COMPILE::SWF {
				renderer.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				renderer.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				renderer.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				renderer.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}

			COMPILE::JS {
				var element:WrappedHTMLElement = (_strand as UIBase).element;

				goog.events.listen(element, goog.events.EventType.MOUSEOVER, this.handleMouseOver);
				goog.events.listen(element, goog.events.EventType.MOUSEOUT, this.handleMouseOut);
				goog.events.listen(element, goog.events.EventType.MOUSEDOWN, this.handleMouseDown);
				goog.events.listen(element, goog.events.EventType.CLICK, this.handleMouseClick);
				goog.events.listen(element, goog.events.EventType.MOUSEUP, this.handleMouseUp);
			}
		}

		/**
		 * @private
		 */
		COMPILE::SWF
		protected function rollOverHandler(event:MouseEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				sendEvent(target,new Event("itemRollOver",true));
			}
		}

		/**
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOver(event:BrowserEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target) {
				sendEvent(target,new Event("itemRollOver",true));
			}
		}

		/**
		 * @private
		 */
		COMPILE::SWF
		protected function rollOutHandler(event:MouseEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				sendEvent(target,new Event("itemRollOut",true));
			}
		}

		/**
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseOut(event:BrowserEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				sendEvent(target,new Event("itemRollOut",true));
			}
		}

		/**
		 * @private
		 */
		COMPILE::SWF
		protected function mouseDownHandler(event:MouseEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(renderer);
				if (selectionBead)
				{
					selectionBead.down = true;
				}			
				var newEvent:MultiSelectionItemClickedEvent = new MultiSelectionItemClickedEvent("itemMouseDown", true, true);
				newEvent.shiftKey = event.shiftKey;
				newEvent.ctrlKey = event.ctrlKey;
				newEvent.data = target.data;
				newEvent.index = target.index;

				sendEvent(target,newEvent);
				target.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
		}

		/**
		 * @private
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseDown(event:BrowserEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				var selectionBead:ISelectableItemRenderer = getSelectionRenderBead(renderer);
				if (selectionBead)
				{
					selectionBead.down = true;
					selectionBead.hovered = false;
				}			
				var newEvent:MultiSelectionItemClickedEvent = MultiSelectionItemClickedEvent.createMultiSelectionItemClickedEvent("itemMouseDown", event);
				newEvent.data = target.data;
				newEvent.index = target.index;

				sendEvent(target,newEvent);
			}
		}

		/**
		 * @private
		 */
		COMPILE::SWF
		protected function mouseUpHandler(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{				
				var newEvent:MultiSelectionItemClickedEvent = new MultiSelectionItemClickedEvent("itemClicked", true, true);
				newEvent.ctrlKey = event.ctrlKey;
				newEvent.shiftKey = event.shiftKey;
				newEvent.data = target.data;
				newEvent.index = target.index;
				target.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				sendEvent(target,newEvent);
			}			
		}

		/**
		 * @private
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseClick(event:BrowserEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				var newEvent:MultiSelectionItemClickedEvent = MultiSelectionItemClickedEvent.createMultiSelectionItemClickedEvent("itemClicked", event);
				newEvent.data = target.data;
				newEvent.index = target.index;

				sendEvent(target,newEvent);
			}
		}

		/**
		 * @private
		 * @royaleemitcoercion org.apache.royale.core.IIndexedItemRenderer
		 */
		COMPILE::JS
		protected function handleMouseUp(event:BrowserEvent):void
		{
			var target:IIndexedItemRenderer = event.currentTarget as IIndexedItemRenderer;
			if (target)
			{
				var newEvent:MultiSelectionItemClickedEvent = MultiSelectionItemClickedEvent.createMultiSelectionItemClickedEvent("itemMouseUp", event);
				newEvent.data = target.data;
				newEvent.index = target.index;

				sendEvent(target,newEvent);
			}
		}

	}
}
