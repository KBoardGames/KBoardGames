package vendor.ibwwg;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

#if house
	import modules.house.*;
#end

/**
 * Simple scrollbar.  Draws itself and also handles dragging.  (It's up to you to use the provided data to update whatever you're scrolling.)
 * @author kboardgames.com
 */
class FlxScrollbarHorizontal extends FlxSpriteGroup
{	/**************************************************************************
	 * this is all the content, rather you see it or not, its width inside of the FlxScrollableArea.
	 */
	public var _content_width:Float = 0;

	/**************************************************************************
	 * this is all the content, its height inside of the FlxScrollableArea.
	 */
	public var _content_height:Float = 0;

	/**************************************************************************
	 * this value is added or minused to the _content_height. Sometimes this extra value is needed so that when clicking the FlxScrollableArea until that content does not scroll down anymore, it stops at the same location as when clicking the bottom of the _track or moving the _bar to the bottom.
	 */
	private var _content_height_extra:Float = 0;
	
	private var tryToScrollPage:Bool = false;
	
	/**************************************************************************
	 * ticks will only increase when input is pressed. when input is released the ticks will then be reset back to zero. when ticks is a certain value, the scrollable area will move.
	 */
	private var _ticks:Float = 0;
	
	/**************************************************************************
	 * this var is passed to functions. used to set color to the bars and tracks.
	 */
	private var _bar_color:FlxColor; 
	
	/**************************************************************************
	 * smallest barProportion of the track that the bar can be sized.
	 */
	private var _minProportion:Float = 0.1;
	
	/**************************************************************************
	 * Sits under the bar and takes up the whole side.
	 */
	public var _track:FlxSprite;
	
	/**************************************************************************
	 * small area of the _horizontalScrollbar or _verticalcrollbar that can be moved. also, in reference to the scrollarea. For example, if this bar is centered to the track then the top part of the scrollable area is displaying the half area of the content. 
	 */
	public var _bar:FlxSprite;
	
	/**************************************************************************
	 * used to calculate then draw the bar to the scene when this value is true then this var is set to false.
	 */
	public var _stale:Bool = true;
	
	/**************************************************************************
	 * if a scrollableArea class, its FlxRect, starts at the half area of the scene then this var x will start at the half of FLxG.height not at 0.
	 */
	private var _viewPort:FlxRect;
	
	/**************************************************************************
	 * scene camera.
	 */
	private var _camera:FlxScrollableArea;
	
	/**************************************************************************
	 * null signifying that we are not currently input dragging.
	 */
	private var _dragStartedAt:FlxPoint = null; 
	
	private var _dragStartedWhenBarWasAt:Float; 
	
	/*************************************************************************
	 * the x mouse location at the camera/scene for whole page or part of page movements).
	 */
	private var _InputStartedAt:Float; 
	
	/*************************************************************************
	 * the x touch or mouse location when that imput was released at the camera/scene for whole page or part of page movements.
	 */
	private var _InputEndedAt:Float = 0; 
	
	/*************************************************************************
	 * timer until you start getting repeated whole-page-movements when holding down the mouse button.
	 */
	private var _trackClickCountdown = 0.0; 
	
	/*************************************************************************
	 * if the bottom of the scrollable area is not at the bottom of the scene, the top of the vertical scrollbar will be offset. this is used to move the scrollbar down to fix the area bug.
	 */
	public var _doOnce:Int = 0;
	private var _track_color:FlxColor;	
	private var _id:Int = 0;
	private var _vertical_bar_bring_up:Bool = false;
	private var _vertical_bar_bring_down:Bool = false;
	
	/*************************************************************************
	 * if true then when the scrollable area has new content and the scrollable area acts like a chat window where new content is added to the end of the scrollable area and the content moves up one line. the vertical bar should be sent to the bottom of the scrollable area.
	 * this stops a bug when used at lobby or other scrollable area where the content scrolls normally. scrolling vertically hides the horizontal bar but leaves an artifit behind and visa versa.
	 */
	private var _auto_update_track:Bool = false;
	
	/*************************************************************************
	 * this is the space between the left side of the scrollarea and where the left/right scrolling ends. the ending of the scroll is defined by this var. its a region of space that once clicked on, the scrollarea will scroll left or right. scrollbars without an id of zero will have this value set to zero so that the left and right scrolling cannot be done.
	 */
	private var _scrollarea_horizontal_width: Int = 100;
	private var _mouseWheelMultiplier:Int;
	
	/*************************************************************************
	 * Create a new scrollbar graphic.  You'll have to hide it yourself when needed.
	 * 
	 * @param	X						As with any sprite.
	 * @param	Y						"
	 * @param	Width					Width of the bar/track.
	 * @param	Height					"
	 * @param	content_height_extra	How much in pixels should the scrollbar be moved down.
	 * @param	Color					The color of the draggable part of the scrollbar.  The rest of it will be the same color added to _track_color.
	 * @param	Camera					The parent scrollable area to control with this scrollbar.
	 * @param	InitiallyVisible		Bool to set .visible to.
 	 * @param	State					Which state to add the scrollbar(s) to.  If you're in a FlxSubState with its parent paused, pass it in here.
	 * @param	MouseWheelMultiplier	How much to multiply mouse wheel deltas by.  Set to 0 to disable mouse wheeling.  Default 100.
	 */
	public function new( x:Float, y:Float, Width:Float, Height:Float, content_height_extra:Int = 0, Color:FlxColor, Camera:FlxScrollableArea, ?InitiallyVisible:Bool=false, ?viewPort:FlxRect, ?MouseWheelMultiplier:Int = 0, content_width:Float, content_height:Float, id:Int = 0, vertical_bar_bring_up:Bool = false, vertical_bar_bring_down:Bool = false) 
	{
		super( x, y);
		
		_track_color = 0xff111111; // dark gray;
		
		// MouseWheelMultiplier disabled because sometimes client uses two scrollable area and a wheel would scroll both at the same time.
		_id = ID = id;
		_viewPort = viewPort;
		_content_height_extra = content_height_extra;
		_bar_color = Color;
		_camera = Camera;
		_vertical_bar_bring_up = vertical_bar_bring_up;
		_vertical_bar_bring_down = vertical_bar_bring_down;
		_mouseWheelMultiplier = MouseWheelMultiplier;
		
		if (id > 0) _scrollarea_horizontal_width = 0;
		
		// used to create-a black bar underneath chatter.
		var _bg = new FlxSprite(0, 0);
		_bg.makeGraphic(Std.int(viewPort.width) + 20, 20, FlxColor.BLACK);
		_bg.scrollFactor.set(0, 0);
		add( _bg );
				
		// if scrollarea is the one to the right, such as chatter, and height is small, so it is a horizontal scrollbar, then make the scrollbar black so it cannot be seen.
		// this addresses a bug where two scrollbar areas shares the same scene, and then doing so, the first scrollbar area has a mirror horizontal scrollbar when the second scrollbar area is created.
		if (viewPort.x > 0 && Height < 40) 
		{
			_bar_color = FlxColor.BLACK;
			_track_color = FlxColor.BLACK;		
		}
		
		// Sits under the bar and takes up the whole side.
		_track = new FlxSprite(x, 0);
		_track.makeGraphic( Std.int( Width ), Std.int( Height), _track_color, true );
		_track.scrollFactor.set(0, 0);
		add( _track );
		
		// small area of the _horizontalScrollbar or _verticalcrollbar. if this bar is centered to the track then the scrollable area is showing its halfway point. 
		_bar = new FlxSprite(x, 0);
		_bar.makeGraphic( Std.int( Width ), Std.int( Height ), _bar_color, true );
		_bar.scrollFactor.set(0, 0);
		_bar.updateHitbox();
		add( _bar );
		
		_content_width = content_width;
		_content_height = content_height;
		
		visible = InitiallyVisible;
		
		
	}
	
	/************************************************************************
	 * all display stuff should be placed here. this avoids sprite flickers.
	 */	
	override public function draw() 
	{
		if (_vertical_bar_bring_down == true && _id == ID) return;
		
		if (_id != ID) return;
		
		if (_stale == true || _auto_update_track == true)
		{
			var barProportion:Float;
			var scrolledProportion:Float;
		
		barProportion = FlxMath.bound( _track.width / _camera.content.width, _minProportion );
			
			_bar.makeGraphic( Std.int( _track.width * barProportion ), Std.int( _track.height ), _bar_color, true );
		
			if (_camera.content.width == _track.width)
				scrolledProportion = 0;
			else
				scrolledProportion = FlxMath.bound( ( _camera.scroll.x - _camera.content.x ) / ( _camera.content.width - _track.width ), 0, 1 );
			_bar.x = x + scrolledProportion * (_track.width * (1 - barProportion));

			_stale = false;
		}
		
		// sometimes the scrollbar does not align to the track. this is the fix.
		if (_bar.x != _track.x && _track.width <= 40) _bar.x = _track.x;
		if (_bar.y != _track.y && _track.height <= 40) _bar.y = _track.y; // horizontal.
		
		super.draw();
	}
	
	override public function destroy():Void
	{
		if (_track != null)
		{
			remove(_track);
			_track.destroy();
			_track = null;
		}
		
		if (_bar != null)
		{
			remove(_bar);
			_bar.destroy();
			_bar = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float)
	{
		if (Reg._messageId > 0)
		{
			_dragStartedAt = null;	
			return;
		}
		
		// update the class if MessageBox is not displayed.
		if (_id != ID) return;
		
		if (visible == false)
		{
			_doOnce = 0;
			return;
		}
		
		var mousePosition = FlxG.mouse.getScreenPosition();
		
		// if clicking on the scrollable area. _dragStartedWhenBarWasAt is where the click first started.
		if (_doOnce == 0 || !_bar.overlapsPoint( mousePosition ) 
		&&  !_track.overlapsPoint( mousePosition ) 
		#if house 
			&&  FlxG.mouse.x - HouseScrollMap._map_offset_x > Math.abs(_viewPort.x) 
			&&  FlxG.mouse.x - HouseScrollMap._map_offset_x < Math.abs(_viewPort.x) + _viewPort.width 
			&&  FlxG.mouse.y - HouseScrollMap._map_offset_y < _viewPort.height
		#else
			&&  FlxG.mouse.x > Math.abs(_viewPort.x) 
			&&  FlxG.mouse.x < Math.abs(_viewPort.x) + _viewPort.width 
			&&  FlxG.mouse.y < _viewPort.height
		#end
		)
		{
			// remember the scroll location of the scrollbox when returning to the scene at this second condition.
			if (FlxG.mouse.justPressed
			&&	Reg2._scrollable_area_is_scrolling == false
			&&	Reg._messageId == 0
			&&	Reg2._lobby_button_alpha == 1
			|| _doOnce == 0
			&&	Reg2._scrollable_area_is_scrolling == false
			&&	Reg._messageId == 0
			&&	Reg2._lobby_button_alpha == 1
			&& _id == 0
			&& _id == ID)
			{
				// get the location of the mouse when input click was made and pass that data to the drga/input start vars.
				_dragStartedAt = mousePosition;
				
				_dragStartedWhenBarWasAt = _bar.x;
			} 
			
			else if (_track.overlapsPoint( mousePosition )) 
			{
				_trackClickCountdown = 0.5;
				_dragStartedWhenBarWasAt = _bar.x;
								
				tryToScrollPage = true;
			}
		}
		
		else if (FlxG.mouse.pressed || _doOnce == 0)
		{
			_trackClickCountdown -= elapsed;
			
			if (_trackClickCountdown < 0 && !_bar.overlapsPoint(mousePosition) && _track.overlapsPoint(mousePosition))
				tryToScrollPage = true;
		}
		
		if (_dragStartedAt != null) 
		{
			_bar.x = FlxMath.bound( _dragStartedWhenBarWasAt + (mousePosition.x - _dragStartedAt.x), _track.x, _track.x + _track.width - _bar.width );
			
			updateViewScroll();
		} 
		
		else if (tryToScrollPage == true && _id == ID) 
		{
			/**
			* Tries to scroll a whole viewport width/height toward wherever the mousedown on the track is.
			* 
			* "Tries" because (to emulate standard scrollbar behaviour) you only scroll in one direction while holding the mouse button down.
			* 
			* E.g. on a vertical scrollbar, if you click & hold below the bar, it scrolls down, but if, while still holding, you move to above the bar, nothing happens.
			*/
			var whichWayToScroll:Int = 0;
			
			if (_bar.x > _dragStartedWhenBarWasAt) 
			{
				// scrolling right
				if (mousePosition.x > _bar.x + _bar.width) // and far enough right to scroll more
					whichWayToScroll = 1;
				
				// scrolling left
				if (mousePosition.x < _bar.x) // and far enough left to scroll more
					whichWayToScroll = -1;
			} 
			
			else 
			{
				// first scroll...which way?
				if (mousePosition.x < _bar.x) // left of bar
					whichWayToScroll = -1;
				
				else // either right of bar, or on the bar; but if on the bar, execution shouldn't reach here in the first place
					whichWayToScroll = 1; // start scrolling right
			}
			
			if (whichWayToScroll == 1)
				_bar.x = FlxMath.bound(_bar.x + _bar.width, null, _track.x + _track.width - _bar.width);
			
			else if (whichWayToScroll == -1)
				_bar.x = FlxMath.bound(_bar.x - _bar.width, _track.x);
		 
			
			
			if (whichWayToScroll != 0)
				updateViewScroll();
		}
		
		// if mouse is within a region of a scrollbox then scroll up or down the page.
		else if (FlxG.mouse.wheel != 0 
		&&	_id == ID 
		&&	_id == 0
		&&	FlxG.mouse.x >= 0 
		&&	FlxG.mouse.x < _viewPort.width
		||	FlxG.mouse.wheel != 0 
		&&	_id == ID
		&& 	_id > 0
		&&	FlxG.mouse.x >= _viewPort.x 
		&&	FlxG.mouse.x <= Reg._client_width)
		{
			_bar.y = FlxMath.bound(_bar.y - FlxG.mouse.wheel * _mouseWheelMultiplier, _track.y, _track.y + _track.height - _bar.height);
						
			updateViewScroll();
		}
		
		if (FlxG.mouse.justReleased)
			_dragStartedAt = null;
		
		if (Reg._at_house == false) updateScrollbar();		
	
		if (_doOnce == 0) _dragStartedAt = null;

		if (FlxG.mouse.pressed == false
		&&	Reg._messageId == 0)
		{
			_ticks = 0;
			_InputStartedAt = 0;
			_dragStartedAt = null;			
		}
		
		tryToScrollPage = false;
		_doOnce = 1;
		
		super.update(elapsed);
	}
		/**************************************************************************
	 * this bring the scrollable area and vertical bar to the botton of scene if the condition is true.
	 */
	private function updateScrollbar():Void
	{
		if (_id != ID) return;
		
		if (_id == ID && _vertical_bar_bring_down == true && _bar.y < _track.height - _bar.height)
		{		
			_bar.y = _track.height;
			tryToScrollPage = true;
			_vertical_bar_bring_down = false;
			_auto_update_track = true;
			updateViewScroll();

		}
	}
	
	/**
	 * Updates the view's scroll.  Should be done from the outside if there's a resize.
	 */
	public function updateViewScroll()
	{
		var scrolledProportion:Float;
		
		if (_track.width == _bar.width)
			scrolledProportion = 0;
			
		else
			scrolledProportion = FlxMath.bound( (_bar.x - x) / (_track.width - _bar.width), 0, 1 );
			
		_camera.scroll.x = _camera.content.x + (_camera.content.width - _track.width) * scrolledProportion;
	
	}
	
	override private function set_width(Value:Float):Float 
	{
		if (_track != null && _track.width != Value)
		{
			_track.makeGraphic( Std.int( Value ), Std.int( height ), FlxColor.add( _track_color, _track_color ), true );
			
			_stale = true;
		}
		
		return super.set_width(Value);
	}
	
	override private function set_height(Value:Float):Float 
	{
		if (_track != null && _track.height != Value)
		{
			_track.makeGraphic( Std.int( width ), Std.int( Value ), FlxColor.add( _track_color, _track_color ), true );
		
			_stale = true;
		}
		
		return super.set_height(Value);
	}
	
	override private function set_x(Value:Float):Float 
	{
		if (_track != null && x != Value)
		{
			_stale = true;
		}
		
		return super.set_x(Value);
	}
	
	override private function set_y(Value:Float):Float 
	{
		if (_track != null && y != Value)
		{
			_stale = true;
		}
		
		return super.set_y(Value);
	}
	
	override private function set_visible(value:Bool):Bool 
	{
		if (visible != value) 
		{
			if (visible == false) 
			{
				// becoming visible: make sure we're on top
				for ( piece in [_track, _bar] ) 
				{
					FlxG.state.remove( piece );
					FlxG.state.add( piece );
				}
			}
			return super.set_visible( value );
		}
		
		else return value;
	}
	
	public function forceRedraw()
	{
		if (visible) _stale = true;
	}
}