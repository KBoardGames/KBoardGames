package vendor.ibwwg;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

/**
 * An area of the screen that has automatic scrollbars, if needed.
 * @author kboardgames.com
 */
class FlxScrollableArea extends FlxCamera
{
	private var _do_once:Bool = true;
	
	/**
	 * If your viewing area changes (perhaps in your state's onResize function) you need to update this to reflect it.
	 */
	public var viewPort(default, set):FlxRect;
	/**
	 * If your content's area changes (e.g. the content itself changes, or you override onResize), you need to update this to reflect it.
	 */
	public var content(default, set):FlxRect;
	/**
	 * Returns the best layout strategy you should use in your state's onResize function.  If you passed NONE in the constructor,
	 * this function just returns that.
	 * 
	 * Be sure to resize the viewport before calling this function, which will trigger a recalculation of this value and the scrollbar sizes.
	 * 
	 * For example, you may normally want to FIT_WIDTH, so you pass that into the constructor.  But, at a certain resize ratio with a
	 * certain content aspect ratio, there will be a conflict between this goal and whether there should be a scrollbar.  I.e., if your
	 * content is resized to fit the width of the viewport, it will be too long and require a scrollbar.  But, if you resize it to allow for
	 * a scrollbar, it will then be short enough not to need a scrollbar anymore.  In this case, .bestMode will tell you that you should
	 * instead FIT_HEIGHT, so that, gracefully, you have no scrollbar, but still make things as big as possible.  I.e., your content will
	 * take up part of what a scrollbar would have.
	 * 
	 * Remember to also take into account the scrollbar thickness using horizontalScrollbarHeight and/or verticalScrollbarWidth.
	 */
	public var bestMode(get, null):ResizeMode;
	
	public var horizontalScrollbarHeight(get, null):Int;
	public var verticalScrollbarWidth(get, null):Int;

	#if !FLX_NO_MOUSE
	public var scrollbarThickness:Int = 20;
	#else
	public var scrollbarThickness:Int = 4;
	#end
	private var _state:FlxState;
	public var _horizontalScrollbar:FlxScrollbarHorizontal;
	public var _verticalScrollbar:FlxScrollbarVertical;
	private var _scrollbarColour:FlxColor;
	private var _resizeModeGoal:ResizeMode;
	private var _id:Int = 0;
	
	/******************************
	 * when ticks is a set value then the scrollbar can be moved. a button press will not trigger a sound event without this var. the reason is that when a mouse is clicked, the Reg2._scrollable_area_is_scrolling is set to true. there is no way to know if either a button is pressed or a scrollable area is pressed because they both can share the same space. so this tick will only set Reg2._scrollable_area_is_scrolling to true when it is a set value. this gives the button click event time to trigger the sound event.
	 */
	private var _ticks_delay:Int = 0;
	
	/******************************
	 * haxe has a timing issue where the update function is read at b class before a class. this var is used to address the issue by only reading the content of that update function after the tick has a value of 2. 
	 */
	public static var _ticks_update:Int = 0;
	
	/******************************
	* background gradient, texture and plain color for a scene.
	*/
	public var __scene_background:SceneBackground;
	
	private var _hiddenPixelAllowance:Float = 1.0; // don't bother showing scrollbars if this many pixels would go out of view (float weirdness fix)
	/**
	 * Creates a specialized FlxCamera that can be added to FlxG.cameras.
	 *
	 * @param	ViewPort				The area on the screen, in absolute pixels, that will show content.
	 * @param	Content					The area (probably off-screen) to be viewed in ViewPort.  Must have a non-zero width and height.
	 * @param	Mode					State the goal of your own resizing code, so that the .bestMode property contains an accurate value.
	 * @param	content_height_extra	this value is added or minused to the _content_height. Sometimes this extra value is needed so that when clicking the FlxScrollableArea until that content does not scroll down anymore, it stops at the same location as when clicking the bottom of the _track or moving the _bar to the bottom.
	 * @param	ScrollbarThickness		Defaults to 20 for mice and 4 "otherwise" (touch is assumed.)
	 * @param	ScrollbarColour			Passed to FlxScrollbar.  ("They say geniuses pick LIME," so don't change the default unless you're the supergenius we all know you to be.)
	 * @param	State					Which state to add the scrollbar(s) to.  If you're in a FlxSubState with its parent paused, pass it in here.
	 * @param	MouseWheelMultiplier	How much to multiply mouse wheel deltas by.  Set to 0 to disable mouse wheeling.  Default 100.
	 * @param	_scrollbar_offset_y		moves the bar and track up or dowwn these many pixels at creation time.
	 */
	public function new(ViewPort:FlxRect, Content:FlxRect, Mode:ResizeMode, content_height_extra:Int = 0, ?MouseWheelMultiplier:Int=100, ?ScrollbarThickness:Int=-1, ?ScrollbarColour:FlxColor=0xff666666, ?State:FlxState, id:Int = 0, vertical_bar_bring_up:Bool = false, vertical_bar_bring_down:Bool = false) {
		super();
		
		if (_id == 0) bgColor = 0x11000000;// Reg._title_bar_background_enabled;
		
		_id = ID = id;
		
		_ticks_update = 0;
		ScrollbarColour = 0xff666666; // gray
		
		_state = State;
		if (_state == null)
			_state = FlxG.state;
		
		if (TitleBar._title_for_screenshot != "Game Room")
			_state.openSubState(new SceneTransition());
 
		// stops a bug at configuration menu, where the scene background is always the same color as the header.
		if (_id == 1000) bgColor = 0x00000000;
		
		content = Content;
		
		if (_id == 1000)
		{
			if (__scene_background != null)
			{
				_state.remove(__scene_background);
				__scene_background.destroy();
			}
			
			__scene_background = new SceneBackground();
			_state.add(__scene_background);
			
		}
		
		_resizeModeGoal = Mode; // must be before we set the viewport, because set_viewport uses it; likewise next line
		if (ScrollbarThickness > -1)
			scrollbarThickness = ScrollbarThickness;
			
		viewPort = ViewPort;
		
		_scrollbarColour = ScrollbarColour;

		scroll.x = content.x;
		scroll.y = content.y;
			
		_horizontalScrollbar = new FlxScrollbarHorizontal( viewPort.x, 0, 1, scrollbarThickness, content_height_extra, ScrollbarColour, this, false, viewPort, MouseWheelMultiplier, content.width, content.height, _id);
		if (viewPort.x == 0) _state.add( _horizontalScrollbar); // do not at this bar if scrollarea is to the right side. this is the only way to remove it because two scrollareas share the same scene.

		_verticalScrollbar = new FlxScrollbarVertical( -1, 0, scrollbarThickness, 1, content_height_extra, ScrollbarColour, this, false, viewPort, MouseWheelMultiplier, content.width, content.height, _id, vertical_bar_bring_up, vertical_bar_bring_down);
		_state.add( _verticalScrollbar);		
		
		_verticalScrollbar.scrollFactor.set(0, 0);
		_horizontalScrollbar.scrollFactor.set(0, 0);
		
		onResize();
		visible = false;
	}

	/******************************
	 * Based on the new viewPort, sets bestMode, horizontalScrollbarHeight, and verticalScrollbarWidth.
	 * 
	 * @param	value	The new viewPort.
	 * @return			The same as you passed in, for assignment chaining.
	 */
	function set_viewPort(value:FlxRect):FlxRect 
	{
		verticalScrollbarWidth = 0;
		horizontalScrollbarHeight = 0; // until otherwise calculated

		#if !FLX_NO_MOUSE
			if (_resizeModeGoal == NONE)
			{ // base it directly on content, since this is only used from onResize
				bestMode = NONE;
			
				if (content.width - value.width > _hiddenPixelAllowance) 
				{
					horizontalScrollbarHeight = scrollbarThickness;
				}
				
				if (content.height - (value.height - horizontalScrollbarHeight) > _hiddenPixelAllowance) 
				{
					verticalScrollbarWidth = scrollbarThickness;
					
					// now, with less width available, do we still fit?
					if (content.width - (value.width - verticalScrollbarWidth) > _hiddenPixelAllowance) 
					{
						horizontalScrollbarHeight = scrollbarThickness;
					}
				}
			} 
			
			else
			{
				// base it on the ratio only, because this will be used outside the class to determine new content size
				var contentRatio = content.width / content.height;
				var viewPortRatio = value.width / value.height;
				
				if (_resizeModeGoal == FIT_HEIGHT)
				{
					if (viewPortRatio >= contentRatio)
					{
						bestMode = FIT_HEIGHT;
						horizontalScrollbarHeight = 0;
					}
					
					else 
					{
						var scrollbarredContentRatio = content.width / (content.height + scrollbarThickness);
						
						if (viewPortRatio <= scrollbarredContentRatio)
						{
							bestMode = FIT_HEIGHT;
							horizontalScrollbarHeight = scrollbarThickness;
						} 
						
						else 
						{ // in the twilight zone
							bestMode = FIT_WIDTH;
							horizontalScrollbarHeight = 0;
						}
					}
				} 
				
				else
				{ // FIT_WIDTH
					if (viewPortRatio <= contentRatio) 
					{
						bestMode = FIT_WIDTH;
						verticalScrollbarWidth = 0;
					} 
					
					else 
					{
						var scrollbarredContentRatio = (content.width + scrollbarThickness) / content.height;
						
						if (viewPortRatio >= scrollbarredContentRatio) 
						{
							bestMode = FIT_WIDTH;
							verticalScrollbarWidth = scrollbarThickness;
						} 
						
						else 
						{ // in the twilight zone
							bestMode = FIT_HEIGHT;
							verticalScrollbarWidth = 0;
						}
					}				
				}
			}
		#end
		
		return viewPort = value;
	}
	/**
	 * Assumes that .viewPort has already been set in the parent state's onResize function.
	 * 
	 * This is automatically re-run the moment .visible is set to true, to make sure that the correct scrollbars are visible.
	 * 
	 * During resizing, this is skipped if .visible is false.
	 */
	override public function onResize() 
	{
		if (!visible) return;
		
		super.onResize();

		#if !FLX_NO_MOUSE
			if (verticalScrollbarWidth > 0)
			{
				_verticalScrollbar.visible = true;
				if (horizontalScrollbarHeight > 0) 
				{ // both
					_horizontalScrollbar.visible = true;
					_horizontalScrollbar.width = viewPort.width - verticalScrollbarWidth;
					_verticalScrollbar.height = viewPort.height - horizontalScrollbarHeight;
				} 
				
				else
				{ // just vert
					_horizontalScrollbar.visible = false;
					_verticalScrollbar.height = viewPort.height;
				}
			} 
			
			else
			{
				_verticalScrollbar.visible = false;
				if (horizontalScrollbarHeight > 0) 
				{ // just horiz
					_horizontalScrollbar.visible = true;
					_horizontalScrollbar.width = viewPort.width;
				}
				
				else
				{ // neither
					_horizontalScrollbar.visible = false;
				}
			}
			
			if (_verticalScrollbar.visible)
			{
				_verticalScrollbar.x = viewPort.right - scrollbarThickness;
				_verticalScrollbar.y = viewPort.y;
			}
			
			if (_horizontalScrollbar.visible) 
			{
				_horizontalScrollbar.x = viewPort.x;
				_horizontalScrollbar.y = viewPort.bottom - scrollbarThickness;
			}
			
			if (_verticalScrollbar.visible || _horizontalScrollbar.visible)
			{
				_verticalScrollbar.updateViewScroll();
				_horizontalScrollbar.updateViewScroll();
			}
			
			if (_verticalScrollbar.visible)
				_verticalScrollbar.draw();
			
			if (_horizontalScrollbar.visible)
				_horizontalScrollbar.draw();
		#end
		
		if (_id == ID)
		{
			x = Std.int( viewPort.x );
			if (x == 1047) content.x = Reg._client_width - 20; // client width - 10 for padding.
			
			y = Std.int( viewPort.y );
			
			width = Std.int( viewPort.width - verticalScrollbarWidth );
			height = Std.int( viewPort.height - horizontalScrollbarHeight );
		}
	}
	function get_bestMode():ResizeMode 
	{
		return bestMode;
	}
	
	function get_horizontalScrollbarHeight():Int 
	{
		return horizontalScrollbarHeight;
	}
	
	function get_verticalScrollbarWidth():Int 
	{
		return verticalScrollbarWidth;
	}
	
	override public function set_visible(value:Bool):Bool
	{
		super.set_visible(value); // so onResize doesn't return early
		
		if (value) // if visible
			onResize(); // show only if needed (recalc)
		
		else
			_horizontalScrollbar.visible = _verticalScrollbar.visible = false; // don't show
		
		return value;
	}
	
	function set_content(value:FlxRect):FlxRect 
	{
		content = value;
		
		if (viewPort != null) // not during the constructor, but normally...
			set_viewPort( viewPort ); // ...force update
		
		return content;
	}
	
	/******************************
	 * Force a redraw of any visible scrollbars.  Call this if you modify the scroll manually, e.g. to force something to be scrolled into view.
	 */
	public function redrawBars()
	{
		_horizontalScrollbar.forceRedraw();
		_verticalScrollbar.forceRedraw();
	}
	
	override public function destroy() 
	{
		for (_bar in [_horizontalScrollbar, _verticalScrollbar]) 
		{
			_state.remove(_bar);
			_bar.destroy();
			_bar = null;
		}		
		
		if (__scene_background != null)
		{
			_state.remove(__scene_background);
			__scene_background.destroy();
			__scene_background = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float)
	{
		// this is needed to stop a flicker.
		_ticks_update += 1;
		
		if (_ticks_update == 3) 
		{
			_ticks_update = 4;
			visible = true;
		}
		
		if (_ticks_update < 2) return;
		
		// currently used for chatter. this moves the scrollable area to the right. id with a value of 1 is used for the second scrollable area which is always at the right side of the screen. must not be used in a block of code when using a do_once var because the scrollable area will flicker then not be visable.
		if (_id == 4 || _id == 5 || _id == 6)
		{
			if (_do_once == true)
			{
				x = - viewPort.x;
				scroll.x = viewPort.x + viewPort.width;
				_verticalScrollbar.x = viewPort.x + viewPort.width - 20;
			
				redrawBars();
				_do_once = false;
			}
			
			// this is needed here because when another camera is used, such as chatter, the chatter scene is not affected by the hotkey background alpha when the ALT+SPACEBAR is used.
			if (Hotkeys._background.alpha == 0.9) alpha = 0.1;
			else alpha = 1;
		}
		
		// FlxG.mouse.pressed code above does not work for this var.
		if (FlxG.mouse.pressed == true)
		{
			_ticks_delay += 1;
			
			if (_ticks_delay > 12) 
				Reg2._scrollable_area_is_scrolling = true;
				
			else Reg2._scrollable_area_is_scrolling = false;
		}
		
		if (_ticks_delay > 12) _ticks_delay = 0;
		
		super.update(elapsed);
	}
}

enum ResizeMode 
{
	FIT_WIDTH;
	FIT_HEIGHT;
	NONE;
}