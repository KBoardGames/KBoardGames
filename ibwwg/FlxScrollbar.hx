package ibwwg;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;


/**
 * Simple scrollbar.  Draws itself and also handles dragging.  (It's up to you to use the provided data to update whatever you're scrolling.)
 * @author kboardgames.com
 */
class FlxScrollbar extends FlxSpriteGroup
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
	 * if clicking the horizontal scrollbar you if click the left or right area and holding click how a lenght of time then the _orientation will be HORIZONTAL.
	 * if click the scrollbar area to scoll it up a=or down or if clicking the vertical scrollbar then the _orientation will be VERTICAL.
	 */
	private var _orientation:FlxScrollbarOrientation;
	
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
	
	/**************************************************************************
	 * the x or y (depending on orientation) of the bar at drag start (also for whole page movements)
	 */
	private var _dragStartedWhenBarWasAt:Float; 
	
	/*************************************************************************
	 * the x or y touch or mouse location (depending on orientation) at the camera/scene for whole page or part of page movements).
	 */
	private var _InputStartedAt:Float; 
	
	/*************************************************************************
	 * the x or y touch or mouse location when that imput was released (depending on orientation) at the camera/scene for whole page or part of page movements.
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
	 * if true then when the boxscroller has new content and the boxscroller acts like a chat window where new content is added to the end of the boxscroller and the content moves up one line. the vertical bar should be sent to the bottom of the boxscroller.
	 * this stops a bug when used at lobby or other boxscroller where the content scrolls normally. scrolling vertically hides the horizontal bar but leaves an artifit behind and visa versa.
	 */
	private var _auto_update_track:Bool = false;
	
	/*************************************************************************
	 * this is the space between the left side of the scrollarea and where the left/right scrolling ends. the ending of the scroll is defined by this var. its a region of space that once clicked on, the scrollarea will scroll left or right. scrollbars without an id of zero will have this value set to zero so that the left and right scrolling cannot be done.
	 */
	private var _scrollarea_horizontal_width: Int = 100;
	
	/*************************************************************************
	 * Create a new scrollbar graphic.  You'll have to hide it yourself when needed.
	 * 
	 * @param	X						As with any sprite.
	 * @param	Y						"
	 * @param	Width					Width of the bar/track.
	 * @param	Height					"
	 * @param	Orientation				Whether it's meant to operate vertically or horizontally.  (This is not assumed from the width/height.)
	 * @param	content_height_extra	How much in pixels should the scrollbar be moved down.
	 * @param	Color					The color of the draggable part of the scrollbar.  The rest of it will be the same color added to _track_color.
	 * @param	Camera					The parent scrollable area to control with this scrollbar.
	 * @param	InitiallyVisible		Bool to set .visible to.
 	 * @param	State					Which state to add the scrollbar(s) to.  If you're in a FlxSubState with its parent paused, pass it in here.
	 * @param	MouseWheelMultiplier	How much to multiply mouse wheel deltas by.  Set to 0 to disable mouse wheeling.  Default 100.
	 */
	public function new( x:Float, y:Float, Width:Float, Height:Float, Orientation:FlxScrollbarOrientation, content_height_extra:Int = 0, Color:FlxColor, Camera:FlxScrollableArea, ?InitiallyVisible:Bool=false, ?viewPort:FlxRect, ?MouseWheelMultiplier:Int = 0, content_width:Float, content_height:Float, id:Int = 0, vertical_bar_bring_up:Bool = false, vertical_bar_bring_down:Bool = false) 
	{
		super( x, y);
		
		// MouseWheelMultiplier disabled because sometimes client uses two boxscroller and a wheel would scroll both at the same time.
		_id = ID = id;
		_viewPort = viewPort;	
		_orientation = Orientation;
		_content_height_extra = content_height_extra;
		_bar_color = Color;
		_camera = Camera;
		_vertical_bar_bring_up = vertical_bar_bring_up;
		_vertical_bar_bring_down = vertical_bar_bring_down;
		
		if (id > 0) _scrollarea_horizontal_width = 0;
		
		// used to create-a black bar underneath chatter.
		if (_id == 0 && _orientation == HORIZONTAL)
		{
			var _bg = new FlxSprite(0, 0);
			_bg.makeGraphic(Std.int(viewPort.width) + 20, 20, FlxColor.BLACK);
			_bg.scrollFactor.set(0, 0);
			add( _bg );
		}
		
		_track_color = FlxColor.GRAY;
		
		// if scrollarea is the one to the right, such as chatter, and height is small, so it is a horizontal scrollbar, then make the scrollbar black so it cannot be seen.
		// this addresses a bug where two scrollbar areas shares the same scene, and then doing so, the first scrollbar area has a mirror horizontal scrollbar when the second scrollbar area is created.
		if (viewPort.x > 0 && Height < 40 && _orientation == HORIZONTAL) 
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
		
		if (_stale || _auto_update_track == true)
		{
			var barProportion:Float;
			var scrolledProportion:Float;
		
			if (_orientation == HORIZONTAL)
			{
				barProportion = FlxMath.bound( _track.width / _camera.content.width, _minProportion );
				_bar.makeGraphic( Std.int( _track.width * barProportion ), Std.int( _track.height ), _bar_color, true );
			
				if (_camera.content.width == _track.width)
					scrolledProportion = 0;
				else
					scrolledProportion = FlxMath.bound( ( _camera.scroll.x - _camera.content.x ) / ( _camera.content.width - _track.width ), 0, 1 );
				_bar.x = x + scrolledProportion * (_track.width * (1 - barProportion));
			} 
			
			else
			{
				barProportion = FlxMath.bound( _track.height / _camera.content.height, _minProportion );
				_bar.makeGraphic( Std.int( _track.width ), Std.int( _track.height * barProportion ), _bar_color, true );
			
				if (_camera.content.height == _track.height)
					scrolledProportion = 0;
				else
					scrolledProportion = FlxMath.bound( ( _camera.scroll.y - _camera.content.y ) / ( _camera.content.height - _track.height ), 0, 1 );
				_bar.y = y + scrolledProportion * (_track.height * (1 - barProportion));
			}
			_stale = false;
		}
		
		// sometimes the scrollbar does not align to the track. this is the fix.
		if (_bar.x != _track.x && _track.width <= 40) _bar.x = _track.x;
		if (_bar.y != _track.y && _track.height <= 40) _bar.y = _track.y; // horizontal.
		
		super.draw();
	}
	
	override public function update(elapsed:Float)
	{
		if (_id != ID) return;
		
		if (visible == false)
		{
			_doOnce = 0;
			return;
		}
		
				
		updateScrollbar();
		
		var mousePosition = FlxG.mouse.getScreenPosition();
		
		// if clicking on the boxscroller area. _dragStartedWhenBarWasAt is where the click first started.
		if (!_bar.overlapsPoint( mousePosition ) 
		&&  !_track.overlapsPoint( mousePosition ) 
		&&  FlxG.mouse.x - HouseScrollMap._map_offset_x > Math.abs(_viewPort.x) 
		&&  FlxG.mouse.x - HouseScrollMap._map_offset_x < Math.abs(_viewPort.x) + _viewPort.width 
		&&  FlxG.mouse.y - HouseScrollMap._map_offset_y < _viewPort.height || _doOnce == 0 )
		{
			if (FlxG.mouse.justPressed
			&&	Reg2._boxScroller_is_scrolling == false
			&&	Reg2._lobby_button_alpha == 0.3)
			{
				// if _auto_update_track is false then chat and notation or something where content is added to the bottom of the boxscroller is used. since chat and notation has no horizontal bar we don't need this. besides, it stops an artifact bug.
				if (_auto_update_track == false) 
						_orientation = HORIZONTAL; // defualt to this.

				// moving up / down.
				if (FlxG.mouse.x - HouseScrollMap._map_offset_x > _viewPort.x + _scrollarea_horizontal_width
				&&  FlxG.mouse.x - HouseScrollMap._map_offset_x < _viewPort.x + _viewPort.width - _scrollarea_horizontal_width
				&&  FlxG.mouse.y - HouseScrollMap._map_offset_y > 0
				&&  FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height)
					_orientation = VERTICAL;
				
				// get the location of the mouse when input click was made and pass that data to the drga/input start vars.
				_dragStartedAt = mousePosition;
				if (_orientation == HORIZONTAL)
				{
					_dragStartedWhenBarWasAt = _bar.x;
					_InputStartedAt = ActionInput.coordinateX();
				} 
		
				else
				{
					_dragStartedWhenBarWasAt = _bar.y;
					_InputStartedAt = ActionInput.coordinateY();
				}
				
				
			}			
			
		}
		
		/*if (_bar.overlapsPoint( mousePosition ) || _track.overlapsPoint( mousePosition ))
		{
			if (FlxG.mouse.y >= _viewPort.height - 20) // 20 is width of scrollbar
				_orientation = HORIZONTAL;
			else
				_orientation = VERTICAL;
		}
		*/
		/*
		if (_doOnce == 0) 
		{			
			// mouse is located at the track
			if (!_bar.overlapsPoint( mousePosition ) && _track.overlapsPoint( mousePosition ))
			{
				_trackClickCountdown = 0.5;
			
				// sometimes when clicking the bar, the bar gets sticking and does not move. this is the fix.
				if (_orientation == HORIZONTAL)	_dragStartedWhenBarWasAt = _bar.x;
				else _dragStartedWhenBarWasAt = _bar.y;
							
				tryToScrollPage = true;
			}
		}*/
		
		if (FlxG.mouse.pressed || _doOnce == 0)
		{
			if (_ticks < 50) _ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);		
		
			_trackClickCountdown -= elapsed;
		
			// if clicked on the track
			//if (_trackClickCountdown < 0 && !_bar.overlapsPoint(mousePosition) && _track.overlapsPoint(mousePosition)
			//)
			//tryToScrollPage = true;
		}
		
		if (_dragStartedAt != null) 
		{
			/*if (_orientation == HORIZONTAL) 
			{
				if (mousePosition.y < _camera.y)
					mousePosition.x = _dragStartedAt.x;
			}*/
			
			// call this function because an input was clicked on either the scrollable area, track or bar and now we need to move it.
			updateViewScroll();
		}
		
		else if (tryToScrollPage)
		{
			/**
			* Tries to scroll a whole viewport width/height toward wherever the mousedown on the track is.
			* 
			* "Tries" because (to emulate standard scrollbar behaviour) you only scroll in one direction while holding the mouse button down.
			* 
			* E.g. on a vertical scrollbar, if you click & hold below the bar, it scrolls down, but if, while still holding, you move to above the bar, nothing happens.
			*/
			var whichWayToScroll:Int = 0; // 0: don't; 1: positive along axis; 2: negative along axis
			if (_orientation == HORIZONTAL) 
			{
				if (_bar.x > _dragStartedWhenBarWasAt) { // scrolling right
					if (mousePosition.x > _bar.x + _bar.width) // and far enough right to scroll more
						whichWayToScroll = 1;
				}
				
				else if (_bar.x > _dragStartedWhenBarWasAt) 
				{ // scrolling left
					if (mousePosition.x < _bar.x) // and far enough left to scroll more
						whichWayToScroll = -1;
				} 
				
				else { // first scroll...which way?
					if (mousePosition.x < _bar.x) // left of bar
						whichWayToScroll = -1;
					else // either right of bar, or on the bar; but if on the bar, execution shouldn't reach here in the first place
						whichWayToScroll = 1; // start scrolling right
				}
				
				if (whichWayToScroll == 1)
					_bar.x = FlxMath.bound(_bar.x + _bar.width, null, _track.x + _track.width - _bar.width);
					
				else if (whichWayToScroll == -1)
					_bar.x = FlxMath.bound(_bar.x - _bar.width, _track.x);
					
			} 
			
			else
			{
				// VERTICAL
				if (_bar.y > _dragStartedWhenBarWasAt)
				{
					// scrolling down and far enough down to scroll more
					if (mousePosition.y > _bar.y + _bar.height) 
						whichWayToScroll = 1;
				}
				
				else if (_bar.y > _dragStartedWhenBarWasAt) { // scrolling up
					if (mousePosition.y < _bar.y) // and far enough up to scroll more
						whichWayToScroll = -1;
				}
				
				else 
				{
					// first scroll...which way?
					if (mousePosition.y < _bar.y) // up of bar
						whichWayToScroll = -1;
					
						else // either down of bar, or on the bar; but if on the bar, execution shouldn't reach here in the first place
						whichWayToScroll = 1; // start scrolling down
				}
				
				if (whichWayToScroll == 1)
					_bar.y = FlxMath.bound(_bar.y + _bar.height, null, _track.y + _track.height - _bar.height);
				
				else if (whichWayToScroll == -1)
					_bar.y = FlxMath.bound(_bar.y - _bar.height, _track.y);
			}
			
			if (whichWayToScroll != 0)
				updateViewScroll();
		} 		
				
		if (RegHouse._at_House == false) updateScrollbar();		
	
		if (_doOnce == 0) _dragStartedAt = null;

		if (FlxG.mouse.pressed == false)
		{
			_ticks = 0;
			_InputStartedAt = 0;
			_dragStartedAt = null;			
		}
		
		// FlxG.mouse.pressed code above does not work for this var.
		if (FlxG.mouse.enabled == true
		&&	FlxG.mouse.pressed == false)
			Reg2._boxScroller_is_scrolling = false;
				
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
		if (_id != ID) return;
		
		var scrolledProportion:Float;
	
		if (_orientation == HORIZONTAL) 
		{
			// if input clicked the second time and the area was already updated then do nothing.
			if (_track.width == _bar.width)
				scrolledProportion = 0;
			else // how much the scrollable area should be scrolled.
				scrolledProportion = FlxMath.bound( (_bar.x - x) / (_track.width - _bar.width), 0, 1 );
						
			// used to scroll the area after the input was clicked.
			if (_doOnce == 0)
			{
				_camera.scroll.x = _camera.content.x + (_camera.content.width - _track.width) * scrolledProportion;
			}
			
			// if at scrollarea and tring to scroll left or right and not at the vertical scroll bar...
			else if (!FlxG.mouse.overlaps(_track) && !FlxG.mouse.overlaps(_bar) 
			&& 		 FlxG.mouse.pressed == true 
			&&		 Reg2._lobby_button_alpha == 0.3
			&&		 _ticks >= 40
			&& 		 FlxG.mouse.x - HouseScrollMap._map_offset_x < _viewPort.x + _viewPort.width - 20 
			&& 		 _track.height == 20 
			&&		 _track.visible == true
			)
			{
				Reg2._boxScroller_is_scrolling = true;
				
				if (FlxG.mouse.x - HouseScrollMap._map_offset_x > _viewPort.x
				&&  FlxG.mouse.x - HouseScrollMap._map_offset_x < _viewPort.x + _scrollarea_horizontal_width && _camera.scroll.x + 10 >= 10)
				_camera.scroll.x -= 10; // scroll left.
				 
				// bring scrollbar bar to left.	
				else if (_camera.scroll.x > 0 && _camera.scroll.x < 10)
					_camera.scroll.x = 0;
			
				else if (FlxG.mouse.x - HouseScrollMap._map_offset_x >= _viewPort.width - _scrollarea_horizontal_width 
				&& 		 FlxG.mouse.x - HouseScrollMap._map_offset_x <= FlxG.width && _camera.scroll.x < _content_width - width - 10)
					_camera.scroll.x += 10; // scroll right.
				
				else if (FlxG.mouse.x - HouseScrollMap._map_offset_x >= _viewPort.width - _scrollarea_horizontal_width) _camera.scroll.x = _content_width - width + _content_height_extra; // bring scrollbar bar to far right.
						
				// the bar needs to be updated when the boxscroller area is clicked. so if the center area of the boxscroller content is displayed, the bar need to be at the center area of the track. so we need to get the ratio between the boxscroller content and the track.
				var _ratio:Float = _viewPort.width + _content_height_extra / _track.width;
				var mousePosition2 = FlxG.mouse.getScreenPosition();
				
				// also, the bar positioned at the center of the track needs to be centered at that location, where as the bar at the top of the track needs its top part at that location. this ratio between then camera and the bar is the fix.
				if (!_bar.overlapsPoint( mousePosition2 ) && !_track.overlapsPoint( mousePosition2 ))
				{
					_bar.x = FlxMath.bound((_camera.scroll.x / _ratio) * _track.width, _track.x, _track.x + _track.width - _bar.width - (_ratio / 50)) + _camera.scroll.x / (_ratio / 60) ; // not perfect but works for horizontal bar. maybe make another code line and base it on viewport.x
				}
				
			}
			
			if (_camera.scroll.x < 0 ) _camera.scroll.x = 0;
		} 
		
		else 
		{
			// if input clicked the second time and the area was already updated then do nothing.
			if (_track.height == _bar.height)
				scrolledProportion = 0;				
			else // how much the scrollable area should be scrolled.
				scrolledProportion = FlxMath.bound( (_bar.y - y) / (_track.height - _bar.height), 0, 1 );
						
			// used to scroll the area after the input was clicked.
			if (_doOnce == 0)
			{
				_camera.scroll.y = _camera.content.y + (_camera.content.height - _track.height) * scrolledProportion;
			}
			
			
			// move scrollbar up and down.
			// _scrollarea_horizontal_width is used for moving the scrollbar left and right. so we do use it here.
			else if (!FlxG.mouse.overlaps(_track) 
			&& !FlxG.mouse.overlaps(_bar)
			&& FlxG.mouse.x - HouseScrollMap._map_offset_x > _viewPort.x + _scrollarea_horizontal_width 
			&& FlxG.mouse.x - HouseScrollMap._map_offset_x < _track.x - _scrollarea_horizontal_width
			)
			{				
				// 0.75 seconds for ticks.  ticks will only increase when input is pressed. when input is released the ticks will then be reset back to zero. so the scrolling of the scrollbar will only occur when input is pressed for 0.75 seconds or longer. 
				if (FlxG.mouse.pressed == true && _ticks >= 40)
				{
					Reg2._boxScroller_is_scrolling = true;
					
					// if user clicked on the boxscroller area not the bar and that the click was located from the top of the boxscroller area to the top 16.6666% of boxscroller's height.
					if (FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height / 6 && _camera.scroll.y > 40)
						_camera.scroll.y -= 40;
						
					// if user clicked on the boxscroller area not the bar and that the click was located from the top 16.6666% of boxscroller height to the boxscroller 33.3333% area.
					else if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= FlxG.height / 6 
					&& 		 FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height / 3 && _camera.scroll.y > 25)
						_camera.scroll.y -= 25;
						
					// if user clicked on the boxscroller area not the bar and that the click was located from the top 33.3333% of boxscroller height to the boxscroller center area.
					else if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= FlxG.height / 3 
					&& 		 FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height / 2 && _camera.scroll.y > 10)
						_camera.scroll.y -= 10;
						
					//---------------------------
					// here is the botton half of the boxscroller.
					// if user clicked on the boxscroller area not the bar and that the click was located from the 50% from top of boxscroller to the 66.66666% location of the boxscroller's height.	
					else if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= FlxG.height / 2
					&& 		 FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height / 1.5 && _camera.scroll.y < _content_height - height - 10 + _content_height_extra)
						_camera.scroll.y += 10;
						
					// if user clicked on the boxscroller area not the bar and that the click was located from the 66.6666% from top of boxscroller to the 83.3333% location of the boxscroller's height.	
					else if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= FlxG.height / 1.5 
					&& 		 FlxG.mouse.y - HouseScrollMap._map_offset_y < FlxG.height / 1.2 && _camera.scroll.y < _content_height - height - 25 + _content_height_extra)
						_camera.scroll.y += 25;
						
					// if user clicked on the boxscroller area not the bar and that the click was located from the 83.3333% from top of boxscroller to the very button of the boxscroller.	
					else if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= FlxG.height / 1.2 
					&&		 FlxG.mouse.y - HouseScrollMap._map_offset_y <= FlxG.height && _camera.scroll.y < _content_height - height - 40 + _content_height_extra)
						_camera.scroll.y += 40;		
				}
			
				
					
				// the bar needs to be updated when the boxscroller area is clicked. so if the center area of the boxscroller content is displayed, the bar need to be at the center area of the track. so we need to get the ratio between the boxscroller content and the track.
				var _ratio:Float = _content_height + _content_height_extra / _track.height;
				var mousePosition2 = FlxG.mouse.getScreenPosition();
						
				// also, when viewing the boxscroller at the house, an additional value of _content_height_extra needs to be added to it so that the bottom of the boxscroller displays the last furniture item.
				//for some reason, when that value is greater than _content_height_extra we need a slightly different calulation here so that the bar is updated and displayed at the track correctly when the boxscroller is clicked. without this extra value, when viewing the boxscroller, the bar would be displayed at the end of the track before the end of the boxscroller content is reached.
				// also, the bar positioned at the center of the track needs to be centered at that location, where as the bar at the top of the track needs its top part at that location. this ratio between then camera and the bar is the fix.
				if (!_bar.overlapsPoint( mousePosition2 ) && !_track.overlapsPoint( mousePosition2 ))
				{
					if (_content_height_extra > 0)
						_bar.y = FlxMath.bound((_camera.scroll.y / _ratio) * _track.height - (_camera.scroll.y / _ratio) * _bar.height, _track.y, _track.y + _track.height - _bar.height );
					else
						_bar.y = FlxMath.bound((_camera.scroll.y / _ratio) * _track.height, _track.y, _track.y + _track.height - _bar.height );
				}
				
				// snap the scrollbar track to the top or button of the scrollarea but only if bar is close to the end of the top or bottom of the scrollarea.
				if (FlxG.mouse.y - HouseScrollMap._map_offset_y >= 0 && FlxG.mouse.y - HouseScrollMap._map_offset_y <= FlxG.height / 2)
				{
					if (_camera.scroll.y < 0 ) _camera.scroll.y = 0;
					
					// bring scrollbar bar to top.	
					if (_camera.scroll.y < 40) _camera.scroll.y = 0;
				}
				
				else
				{
					// bring scrollbar bar to the bottom/.	
					if (_camera.scroll.y + 40 > _content_height - height + _content_height_extra) 
						_camera.scroll.y = _content_height - height + _content_height_extra; 
				}				
			}
		}
	}
	
	override private function set_width(Value:Float):Float 
	{
		if (_track != null && _track.width != Value) 
		{
			_track.makeGraphic( Std.int( Value ), Std.int( height ), _track_color, true );
			_stale = true;
		}
		
		return super.set_width(Value);
	}
	
	override private function set_height(Value:Float):Float 
	{
		if (_track != null && _track.height != Value) 
		{
			_track.makeGraphic( Std.int( width ), Std.int( Value ), _track_color, true );
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
		if (_id != ID) return;
		
		if (visible) _stale = true;
	}
}

enum FlxScrollbarOrientation 
{
	VERTICAL;
	HORIZONTAL;
}
