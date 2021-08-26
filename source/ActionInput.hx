package;

/**
 * mobile touch and mouse events. This class is not needed because the mouse events can be used instead. therefore, one day, replace all code that call these function with mouse commands.
 * @author kboardgames.com.
 */
class ActionInput
{
	/******************************
	 * if true then the mobile touch or mouse is enabled.
	 */
	static private var _state_enabled:Bool = true;
	
	/******************************
	 * disable mobile touch or mouse click.
	 */
	static public function disabled():Void
	{
		_state_enabled = false;
		//enableDisableInput();
	}
	
	/******************************
	 * enable mobile touch or mouse click.
	 */
	static public function enable():Void
	{
		_state_enabled = true;
		//enableDisableInput();
	}
	
	/******************************
	 * touch or mouse overlaps a region of a scene.
	 */
	static public function overlaps(_bas:FlxBasic, ?_cam:FlxCamera):Bool
	{
		var _bool:Bool = false;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				if (touch.overlaps(_bas, _cam) == true) _bool = true;
			}
			return _bool;
			
		#elseif desktop
			if (FlxG.mouse.overlaps(_bas, _cam) == true) _bool = true;
		
		#elseif html5
			if (FlxG.mouse.overlaps(_bas, _cam) == true) _bool = true;
		
		#end
		
		if (_state_enabled == false) _bool = false;
		
		//enableDisableInput();
		
		return _bool;
	}
	
	/******************************
	 * used for boxScroller
	 */
	static public function pressed():Bool
	{
		var _bool:Bool = false;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				if (touch.pressed == true) _bool = true;
			}
			
		#elseif desktop
			if (FlxG.mouse.pressed == true) _bool = true;
			else if (FlxG.mouse.wheel != 0) _bool = true;
		
		#elseif html5
			if (FlxG.mouse.pressed == true) _bool = true;
			else if (FlxG.mouse.wheel != 0) _bool = true;
		
		#end
		
		if (_state_enabled == false) _bool = false;
		
		//enableDisableInput();
		
		return _bool;
	}
	
	static public function justPressed():Bool
	{
		var _bool:Bool = false;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				if (touch.justPressed == true) 
				{
					_bool = true;
				}
			}
					
		#else
			if (FlxG.mouse.justPressed == true) 
			{
				_bool = true;
			}
		
		#end
		
		if (_state_enabled == false) _bool = false;
		
		//enableDisableInput();
						
		return _bool;
	}
	
	static public function justReleased():Bool
	{
		var _bool:Bool = false;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				if (touch.justReleased == true) 
				{
					_bool = true;
				}
			}
					
		#else
			if (FlxG.mouse.justReleased == true)
			{
				_bool = true;
			}
		
		#end
		
		if (_state_enabled == false) _bool = false;
		
		//enableDisableInput();
		
		return _bool;
	}
	
	/******************************
	 * returns the x location of either the mouse or mobile touch.
	 */
	static public function coordinateX():Int
	{
		var _int:Int = 0;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				_int = touch.x;
			}
			
		#elseif desktop
			_int = FlxG.mouse.x;
		
		#elseif html5
			_int = FlxG.mouse.x;
			
		#end
		
		return _int;
	}
	
	/******************************
	 * returns the y location of either the mouse or mobile touch.
	 */
	static public function coordinateY():Int
	{
		var _int:Int = 0;
		
		#if mobile
			for (touch in FlxG.touches.list)
			{
				_int = touch.y;
			}
			
		#elseif desktop
			_int = FlxG.mouse.y;
		
		#elseif html5
			_int = FlxG.mouse.y;
			
		#end
		
		return _int;
	}
	
	/******************************
	 * you can safely comment this function if the compiler barks.
	 */
	/*static function enableDisableInput():Void
	{
		#if mobile
			FlxG.mouse.visible = false;
			
		#elseif desktop
			if (_state_enabled == false) 
			{
				FlxG.mouse.visible = false;
				FlxG.mouse.enabled = false;
			}
			
			else
			{
				FlxG.mouse.enabled = true;
				FlxG.mouse.visible = true;
			}
			
		#elseif html5
			if (_state_enabled == false) 
			{
				FlxG.mouse.visible = false;
				FlxG.mouse.enabled = false;
			}
			
			else
			{
				FlxG.mouse.enabled = true;
				FlxG.mouse.visible = true;
			}
		
		#end
	}*/
}


