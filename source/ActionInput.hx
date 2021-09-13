/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
			
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _bool;
	}
	
	/******************************
	 * used for boxScroller
	 */
	static public function pressed():Bool
	{
		var _bool:Bool = false;
		
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _bool;
	}
	
	static public function justPressed():Bool
	{
		var _bool:Bool = false;
		
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _bool;
	}
	
	static public function justReleased():Bool
	{
		var _bool:Bool = false;
		
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _bool;
	}
	
	/******************************
	 * returns the x location of either the mouse or mobile touch.
	 */
	static public function coordinateX():Int
	{
		var _int:Int = 0;
		
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _int;
	}
	
	/******************************
	 * returns the y location of either the mouse or mobile touch.
	 */
	static public function coordinateY():Int
	{
		var _int:Int = 0;
		
		if (RegTriggers._buttons_set_not_active == false)
		{
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
		}
		
		return _int;
	}
	
	
}


