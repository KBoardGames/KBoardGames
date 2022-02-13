/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * special effects such as snow or rain.
 * @author kboardgames.com
 */
class SceneEffects extends FlxSprite
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var.
	 */
	public var _startX:Float = 0;

	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var.
	 */
	public var _startY:Float = 0;
	
	/******************************
	 * the smaller this var, the small the image and the farther away the effect seems to be.
	 * 1: very large. 10:very small.
	 */
	private var _level:Int = 0;
	
	/******************************
	 * 1: snow will fall. 2: rain.
	 */
	private var _effects_num:Int = 0;
	
	private var _initialized:Bool = false;
	
	/******************************
	 * use this ticks for anything.
	 */
	private var _ticks:Int = 0;
	
	
	public function new(x:Float, y:Float, level:Int = 0, effects_num:Int)
	{
		super(x, y);
	
		_startX = x;
		_startY = y;
	
		_level = level;
		_effects_num = effects_num;
		
		switch (_effects_num)
		{
			case 0: effects_snow();
			case 1: effects_rain();
		}
		
		_initialized = true;
	}

	private function effects_snow():Void
	{
		var _scales:Array<Float> = [0.55, 0.52, 0.48, 0.44, 0.40, 0.37, 0.33, 0.29, 0.23];
		var _scale = _scales[_level];
		
		var color = FlxColor.WHITE.getDarkened(.5 - (_level * .06));
		loadGraphic("assets/images/snowFlake.png", true, 64, 64);
		alpha = 0.7;
		
		var _ra = FlxG.random.int(0, 3);
		
		if (_ra == 0) animation.add("run", [0, 1, 2, 3, 4], 10, true, true);
		if (_ra == 1) animation.add("run", [0, 1, 2, 3, 4], 7, true, true);
		if (_ra == 2) animation.add("run", [0, 1, 2, 3, 4], 3, true, true);
		if (_ra == 3) animation.add("run", [0], 1);
		
		animation.play("run");
		
		scale.set(_scale, _scale);
		
	}
	
	private function effects_rain():Void
	{
		var size = Std.int(FlxMath.bound(_level / 2, 1.5, 3));
		var color = 0xFF0000AA;
		makeGraphic(size, size * 4, color);
		alpha = 1;
	}
	
	override public function reset(x:Float, y:Float):Void
	{
		var _ra = FlxG.random.int(-50, 50);
		super.reset((x + _ra), (y + _ra));
		
		// snow.
		if (_effects_num == 0) 
		{
			alpha = 0.6;
			animation.paused = false;
			
			if (_initialized)
			{
				x = FlxG.random.int(0, FlxG.width * 4 * _level);
				y = FlxG.random.int(-5, -10);
			}
			else
			{
				x = FlxG.random.int(0, FlxG.width * 4 * _level);
				y = FlxG.random.int(-10, FlxG.height);
			}
			
			// do this every 3/4 of total ticks.
			if (_ticks > 100)
			{
				// make the snow fall at normal speed,
				scrollFactor.set(.7 + (_level * .1), 0);
				velocity.y = FlxG.random.int(175, 325) + (_level * 15);
				
				var _ra = FlxG.random.int(1, 9);
				velocity.x = FlxG.random.int( -55, -75) + (_ra * 30);
			}
			
			else
			{
				// these flakes fall slower than normal but drift left-right more.
				scrollFactor.set(.7 + (_level * .1), 0);
				velocity.y = FlxG.random.int(111, 255) + (_level * 10);
				
				var _ra = FlxG.random.int(1, 9);			
				velocity.x = FlxG.random.int( -100, -200) + (_ra * 20);
			}
		}
		
		// rain.
		else if (_effects_num == 1)
		{
			alpha = 1;
			
			if (_initialized)
			{
				x = FlxG.random.int(0, FlxG.width * _level);
				y = FlxG.random.int( -5, -10);
			}
			else
			{
				x = FlxG.random.int(0, FlxG.width * _level);
				y = FlxG.random.int( -10, FlxG.height);
			}
			scrollFactor.set(.7 + (_level * .1), 0);
			velocity.y = FlxG.random.int(340, 480) * ((_level+5) * .4);
			velocity.x = FlxG.random.int( -50, -100) * ((_level+2) * .3);
		}		
	}

	public function update_snow(elapsed:Float):Void
	{
		if (velocity.y == 0) alpha -= elapsed * 3.5;
		if (alpha == 0) reset(_startX, _startY);
		
		else
		{
			// depending on this tick value the snow will either fall at normal or slow speed.
			_ticks += 1;
			if (_ticks > 400) _ticks = 0;
			
			if (x < -100 || x > FlxG.width + 100 || y > FlxG.height || alpha <= 0)
			{
				reset(_startX, _startY);
			}
			
			else if (y >= FlxG.height - 44)
			{
				scrollFactor.x = 1;
				velocity.set(0, 0);
				y = FlxG.height - 45;
				animation.paused = true;
			}
		}
	}	
	
	public function update_rain(elapsed:Float):Void
	{
		if (velocity.y == 0) reset(_startX, _startY);
		
		else
		{			
			if (x < 50 || x > FlxG.width + 50 || y > FlxG.height || alpha <= 0)
			{
				reset(_startX, _startY);
			}
			
			else if (y >= FlxG.height - 44)
			{
				scrollFactor.x = 1;
				velocity.set(0, 0);
				y = FlxG.height - 45;
				animation.paused = true;
			}
		}
		
	}
	
	override public function update(elapsed:Float):Void
	{
		switch (_effects_num)
		{
			case 0: update_snow(elapsed);
			case 1: update_rain(elapsed);
		}
		
		super.update(elapsed);
	}
	
	override public function destroy():Void
	{

		super.destroy();
	}
}
