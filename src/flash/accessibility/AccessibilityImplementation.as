package flash.accessibility
{
	import flash.geom.Rectangle;

	/**
	 * The AccessibilityImplementation class is the base class in Flash Player
	 * that allows for the implementation of accessibility in components. 
	 * This class enables communication between a component and a screen reader. 
	 * Screen readers are used to translate screen content into synthesized speech 
	 * or braille for visually impaired users.
	 * 
	 *   <p class="- topic/p ">The AccessibilityImplementation class provides a set of methods that allow a component
	 * developer to make information about system roles, object based events, and states available
	 * to assistive technology.</p><p class="- topic/p ">Adobe Flash Player uses Microsoft Active Accessibility (MSAA), which provides a descriptive
	 * and standardized way for applications and screen readers to communicate. For more information
	 * on how the Flash Player works with MSAA, see the accessibility chapter in <i class="+ topic/ph hi-d/i ">Using Flex SDK</i>.</p><p class="- topic/p ">The methods of the AccessibilityImplementation class are a subset of the 
	 * <xref href="http://msdn.microsoft.com/en-us/library/ms696097(VS.85).aspx" class="- topic/xref ">IAccessible</xref> interface
	 * for a component instance.</p><p class="- topic/p ">The way that an AccessibilityImplementation implements the IAccessible interface, 
	 * and the events that it sends, depend on the kind of component being implemented.</p><p class="- topic/p ">Do not directly instantiate AccessibilityImplementation by calling its constructor.
	 * Instead, create new accessibility implementations by extending the 
	 * AccImpl class for each new component.
	 * In Flash, see the fl.accessibility package. 
	 * In Flex, see the mx.accessibility package and 
	 * the accessibility chapter in <i class="+ topic/ph hi-d/i ">Using Flex SDK</i>.</p><p class="- topic/p "><b class="+ topic/ph hi-d/b ">Note:</b> The AccessibilityImplementation class is not supported in AIR runtime versions before AIR 2. The class is
	 * available for compilation in AIR versions before AIR 2, but is not supported in the runtime until AIR 2.</p>
	 * @playerversion	Flash 9
	 * @playerversion	AIR 2
	 */
	public class AccessibilityImplementation extends Object
	{
		/**
		 * Indicates an error code. Errors are indicated out-of-band, rather than in return values. 
		 * To indicate an error, set the errno property to one of the error codes
		 * documented in the AccessibilityImplementation Constants appendix. 
		 * This causes your return value to be ignored. The errno property
		 * of your AccessibilityImplementation is always cleared (set to zero) by the player
		 * before any AccessibilityImplementation method is called.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public var errno:uint;

		/**
		 * Used to create a component accessibility stub.
		 * If a component is released without an ActionScript accessibility implementation,
		 * Adobe recommends that you add a component accessibility stub. 
		 * This stub causes Flash Player, for accessibility purposes, to treat the component
		 * as a simple graphic rather than exposing the internal structure of buttons,
		 * textfields, and so on, within the component.
		 * 
		 *   To create a component accessibility stub,
		 * subclass the relevant AccImpl class, overriding the property stub
		 * with a value of true.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public var stub:Boolean;

		/**
		 * An IAccessible method that performs the default action associated with the component
		 * that this AccessibilityImplementation represents or of one of its child elements.
		 * 
		 *   Implement this method only if the AccessibilityImplementation represents a UI element
		 * that has a default action in the MSAA model.If you are implementing accDoDefaultAction() only for the AccessibilityImplementation
		 * itself, or only for its child elements, you will need in some cases to indicate that there
		 * is no default action for the particular childID that was passed. 
		 * Do this by setting the errno property to E_MEMBERNOTFOUND.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements,
		 *   as defined by getChildIDArray().
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function accDoDefaultAction (childID:uint):void
		{
			
		}

		/**
		 * Static constructor. Do not directly instantiate AccessibilityImplementation by calling its constructor.
		 * Instead, create new accessibility implementations by extending the mx.accessibility.AccImpl
		 * class for each new component.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function AccessibilityImplementation()
		{
			
		}

		/**
		 * MSAA method for returning a DisplayObject or Rectangle
		 * specifying the bounding box of a child element in the AccessibilityImplementation.
		 * 
		 *   This method is never called with a childID of zero. 
		 * If your AccessibilityImplementation will never contain child elements, you should not implement 
		 * this method. If your AccessibilityImplementation can contain child elements, 
		 * this method is mandatory.You can usually satisfy the requirements of this method by returning an 
		 * object that represents the child element itself. This works as long as the 
		 * child element is a DisplayObject. 
		 * In these cases, simply return the DisplayObject that corresponds to 
		 * the instance name associated with the relevant visual object in display list.If a child element does not qualify for the technique described above, 
		 * you may do the bounding-box math yourself and return a Rectangle with:
		 * x, y, width, and height properties. 
		 * The x and y members specify the upper-left corner of the bounding box, and 
		 * the width and height members specify its size. All four members 
		 * should be in units of Stage pixels, and relative to the origin of the component 
		 * that the AccessibilityImplementation represents. The x and y properties may have 
		 * negative values, since the origin of a DisplayObject is not necessarily in its 
		 * upper-left corner.If the child element specified by childID is not visible (that is, get_accState 
		 * for that child would return a value including STATE_SYSTEM_INVISIBLE), you 
		 * may return null from accLocation. You can also 
		 * return a Rectangle representing the coordinates where the child element would 
		 * appear if it were visible.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements
		 *   as defined by getChildIDArray().
		 * @return	DisplayObject or Rectangle specifying the bounding box
		 *   of the child element specified by childID parameter.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function accLocation (childID:uint):*
		{
			return null;
		}

		/**
		 * IAccessible method for altering the selection in the component 
		 * that this AccessibilityImplementation represents.
		 * 
		 *   The childID parameter will always be nonzero. This method 
		 * always applies to a child element rather than the overall component; 
		 * Flash Player manages the selection of the overall component itself.The selFlag parameter is a bitfield consisting of one or more selection flag constants
		 * that allows an MSAA client to indicate how the item referenced by the childID 
		 * should be selected or take focus. What follows are descriptions of the selection flag constants
		 * and what they communicate to the accessibility implementation.  
		 * As a practical matter, most implementations of this method in accessibility implementations
		 * that inherit from the Flex mx.accessibility.ListBaseAccImpl class 
		 * ignore the selFlag constant and instead rely on the component's keyboard selection behavior
		 * to handle multi-selection.The selFlag parameter may or may not contain the SELFLAG_TAKEFOCUS 
		 * flag. If it does, you should set the child focus to the specified childID, 
		 * and, unless SELFLAG_EXTENDSELECTION is also present, make that child element 
		 * the selection anchor. Otherwise, the child focus and selection anchor should 
		 * remain unmodified, despite the fact that additional flags described below 
		 * may modify the selection.The selFlag argument will always contain one of the following four 
		 * flags, which indicate what kind of selection modification is desired:SELFLAG_TAKESELECTION: Clear any existing selection, and set the selection 
		 * to the specified childID.SELFLAG_EXTENDSELECTION: Calculate the range of child elements between 
		 * and including the selection anchor and the specified childID. If 
		 * SELFLAG_ADDSELECTION is present, add all of these child elements to the 
		 * selection. If SELFLAG_REMOVESELECTION is present, remove all of these child 
		 * elements from the selection. If neither SELFLAG_ADDSELECTION nor SELFLAG_REMOVESELECTION 
		 * is present, all of these child elements should take on the selection anchor's 
		 * selection state: if the selection anchor is selected, add these child elements 
		 * to the selection; otherwise remove them from the selection.SELFLAG_ADDSELECTION (without SELFLAG_EXTENDSELECTION): Add the specified 
		 * childID to the selection.SELFLAG_REMOVESELECTION (without SELFLAG_EXTENDSELECTION): Remove the 
		 * specified childID from the selection.Note that for a non-multi-selectable component, the only valid selFlag 
		 * parameter values are SELFLAG_TAKEFOCUS and SELFLAG_TAKESELECTION.
		 * You could in theory 
		 * also choose to support SELFLAG_REMOVESELECTION for a non-multi-selectable 
		 * component that allowed the user to force a null selection, but in practice 
		 * most non-multi-selectable components do not work this way, and MSAA clients 
		 * may not attempt this type of operation.If you encounter flags that seem invalid, set errno to E_INVALIDARG.Finally, note that when accSelect is called, Flash Player 
		 * ensures that it has host focus (the window focus of its container 
		 * application), and that your component has focus within Flash Player.
		 * @param	operation	A bitfield consisting of one or more selection flag constants to indicate
		 *   how the item is selected or takes focus.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements
		 *   as defined by getChildIDArray().
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function accSelect (operation:uint, childID:uint):void 
		{
			
		}

		/**
		 * MSAA method for returning the default action of the component
		 * that this AccessibilityImplementation represents or of one of its child elements.
		 * 
		 *   Implement this method only if the AccessibilityImplementation represents a UI element
		 * that has a default action in the MSAA model; be sure to return the exact string 
		 * that the MSAA model specifies.  
		 * For example, the default action string for a Button component is "Press."If you are implementing get_accDefaultAction only for the 
		 * AccessibilityImplementation itself, or only for its child elements, 
		 * you will need in some cases to indicate that there is no default action 
		 * for the particular childID that was passed. 
		 * Do this by simply returning null.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements,
		 *   as defined by getChildIDArray().
		 * @return	The default action string specified in the MSAA model for the AccessibilityImplementation
		 *   or for one of its child elements.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function get_accDefaultAction (childID:uint):String
		{
			return null;
		}

		/**
		 * MSAA method for returning the unsigned integer ID of the child element, if any, 
		 * that has child focus within the component. If no child has child focus, the method returns zero.
		 * @return	The unsigned integer ID of the child element, if any, that has child focus within the component.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function get_accFocus ():uint
		{
			return null;
		}

		/**
		 * MSAA method for returning the name for the component
		 * that this AccessibilityImplementation represents or for one of its child elements.
		 * 
		 *   In the case of the AccessibilityImplementation itself (childID == 0), 
		 * if this method is not implemented, or does not return a value, Flash Player 
		 * uses the AccessibilityProperties.name property value, if it is present.For AccessibilityImplementations that can have child elements, this method must be implemented,
		 * and must return a string value when childID is nonzero.Depending on the type of user interface element, names in MSAA mean one of two different 
		 * things: an author-assigned name, or the actual text content of the element. 
		 * Usually, an AccessibilityImplementation itself will fall into the former category. 
		 * Its name property is an author-assigned name. Child elements 
		 * always fall into the second category. Their names indicate their text content.When the name property of an AccessibilityImplementation has the meaning
		 * of an author-assigned name, there are two ways in which components can acquire names from authors.
		 * The first entails names present within the component itself; for example, a checkbox 
		 * component might include a text label that serves as its name. The second—a fallback from
		 * the first—entails names specified in the UI and ending 
		 * up in AccessibilityProperties.name. This fallback option allows users to specify 
		 * names just as they would for any other Sprite or MovieClip.This leaves three possibilities for the AccessibilityImplementation itself (childID == zero):Author-assigned name within component. The get_accName method 
		 * should be implemented and should return a string value that contains the 
		 * AccessibilityImplementation's name when childID is zero. If childID is zero but the 
		 * AccessibilityImplementation has no name, get_accName should return an empty string to prevent 
		 * the player from falling back to the AccessibilityProperties.name property.Author-assigned name from UI. If the AccessibilityImplementation can have child 
		 * elements, the get_accName method should be implemented but should not return a value when
		 * childID is zero. If the AccessibilityImplementation will never have child elements, 
		 * get_accName should not be implemented.Name signifying content. The get_accName method should be 
		 * implemented and should return an appropriate string value when childID 
		 * is zero. If childId is zero but the AccessibilityImplementation has no content, 
		 * get_accName should return an empty string to prevent the player from falling back to 
		 * the AccessibilityProperties.name property.Note that for child elements (if the AccessibilityImplementation can have them), the third case 
		 * always applies. The get_accName method should be implemented and should 
		 * return an appropriate string value when childID is nonzero.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements
		 *   as defined by getChildIDArray().
		 * @return	Name of the component or one of its child elements.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function get_accName (childID:uint):String
		{
			return null;
		}

		/**
		 * MSAA method for returning the system role for the component
		 * that this AccessibilityImplementation represents or for one of its child elements.
		 * System roles are predefined for all the components in MSAA.
		 * @param	childID	An unsigned integer corresponding to one of the component's
		 *   child elements as defined by getChildIDArray().
		 * @return	System role associated with the component.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 * @throws	Error Error code 2143, AccessibilityImplementation.get_accRole() must be overridden from its default.
		 */
		public function get_accRole (childID:uint):uint
		{
			return null;
		}

		/**
		 * MSAA method for returning an array containing the IDs of all child elements that are selected. 
		 * The returned array may contain zero, one, or more IDs, all unsigned integers.
		 * @return	An array of the IDs of all child elements that are selected.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function get_accSelection ():Array
		{
			return null;
		}

		/**
		 * IAccessible method for returning the current runtime state of the component that this 
		 * AccessibilityImplementation represents or of one of its child elements.
		 * 
		 *   This method must return a combination of zero, one, or more of the predefined
		 * object state constants for components in MSAA. 
		 * When more than one state applies, the state constants should be combined into a bitfield
		 * using |, the bitwise OR operator.To indicate that none of the state constants currently applies, this method should return zero.You should not need to track or report the STATE_SYSTEM_FOCUSABLE or STATE_SYSTEM_FOCUSED states. 
		 * Flash Player handles these states automatically.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements
		 *   as defined by getChildIDArray().
		 * @return	A combination of zero, one, or more of the system state constants. 
		 *   Multiple constants are assembled into a bitfield using |, the bitwise OR operator.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 * @throws	Error Error code 2144, AccessibilityImplementation.get_accState() must be overridden from its default.
		 */
		public function get_accState(childID:uint):uint
		{
			return null;
		}

		/**
		 * MSAA method for returning the runtime value of the component that this
		 * AccessibilityImplementation represents or of one of its child elements.
		 * 
		 *   Implement this method only if your AccessibilityImplementation represents a UI element
		 * that has a value in the MSAA model. Be aware that some UI elements that have an apparent 'value' 
		 * actually expose this value by different means, such as 
		 * get_accName (text, for example), 
		 * get_accState (check boxes, for example), or get_accSelection 
		 * (list boxes, for example).If you are implementing get_accValue only for the AccessibilityImplementation itself, or 
		 * only for its child elements, you will need in some cases to indicate that 
		 * there is no concept of value for the particular childID that was passed. 
		 * Do this by simply returning null.
		 * @param	childID	An unsigned integer corresponding to one of the component's child elements
		 *   as defined by getChildIDArray().
		 * @return	A string representing the runtime value of the component of of one of its child elements.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function get_accValue(childID:uint):String
		{
			return null;
		}

		public function get_selectionActiveIndex():*
		{
			return null;
		}

		public function get_selectionAnchorIndex():*
		{
			return null;
		}

		/**
		 * Returns an array containing the unsigned integer IDs of all child elements
		 * in the AccessibilityImplementation.
		 * 
		 *   The length of the array may be zero. The IDs in the array should 
		 * appear in the same logical order as the child elements they represent. If your 
		 * AccessibilityImplementation can contain child elements, this method is mandatory; otherwise, do
		 * not implement it.In assigning child IDs to your child elements, use any scheme that
		 * preserves uniqueness within each instance of your AccessibilityImplementation. Child IDs need not 
		 * be contiguous, and their ordering need not match the logical ordering of the 
		 * child elements. You should arrange so as to not reuse child IDs; if a child 
		 * element is deleted, its ID should never be used again for the lifetime of 
		 * that AccessibilityImplementation instance. Be aware that, due to implementation choices in the Flash 
		 * player code, undesirable behavior can result if you use child IDs that exceed 
		 * one million.
		 * @return	Array containing the unsigned integer IDs of all child elements in the AccessibilityImplementation.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function getChildIDArray():Array
		{
			return null;
		}

		/**
		 * Returns true or false to indicate whether a text object having 
		 * a bounding box specified by a x, y, width, and height 
		 * should be considered a label for the component that this AccessibilityImplementation represents.
		 * 
		 *   The x and y coordinates are relative to the upper-left corner 
		 * of the component to which the AccessibilityImplementation applies, and may be negative. All coordinates 
		 * are in units of Stage pixels.This method allows accessible components to fit into the Flash Player's search 
		 * for automatic labeling relationships, which allow text external to an object 
		 * to supply the object's name. This method is provided because it is expected 
		 * that the criteria for recognizing labels will differ from component to component. 
		 * If you implement this method, you should aim to use geometric criteria similar 
		 * to those in use inside the player code for buttons and textfields. Those criteria
		 * are as follows:For buttons, any text falling entirely inside the button is considered a label.For textfields, any text appearing nearby above and left-aligned, 
		 * or nearby to the left, is considered a label.If the component that the AccessibilityImplementation represents should never participate in automatic 
		 * labeling relationships, do not implement isLabeledBy. This is equivalent 
		 * to always returning false. One case in which isLabeledBy should 
		 * not be implemented is when the AccessibilityImplementation falls into the "author-assigned name 
		 * within component" case described under get_accName above.Note that this method is not based on any IAccessible method; it is 
		 * specific to Flash.
		 * @param	labelBounds	A Rectangle representing the bounding box of a text object.
		 * @return	true or false to indicate whether a text object having the given label bounds should be considered a label for the component that this AccessibilityImplementation represents.
		 * @playerversion	Flash 9
		 * @playerversion	AIR 2
		 */
		public function isLabeledBy (labelBounds:Rectangle):Boolean
		{
			return null;
		}
	}
}