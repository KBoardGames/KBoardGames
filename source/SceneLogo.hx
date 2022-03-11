/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */

class SceneLogo extends FlxState  
{
	private var _logo:FlxSprite;
	private var _title:FlxSprite;
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		FlxG.sound.playMusic("logo", 1, false);
		
		_logo = new FlxSprite(0, 250, "assets/logo.png");
		_logo.screenCenter(X);
		add(_logo);
		
		_title = new FlxSprite(0, 500);
		_title.loadGraphic("assets/title.png", true, 383, 58); 
		_title.animation.add("play", [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 , 0], 11, false);
		_title.screenCenter(X);
		_title.animation.play("play");
		add(_title);
	}
	
	override public function destroy():Void
	{
		if (_logo != null)
		{
			remove(_logo);
			_logo.destroy();
			_logo = null;
		}
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
			_title = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		if (_title.animation.finished == true)
		{
			if (_title.alpha > 0)
			{
				_logo.alpha -= 0.008;
				_title.alpha -= 0.008;
			}
		}
		
		if (_title.alpha <= 0)
			FlxG.switchState(new MenuState());
			
		super.update(elapsed);
	}
	
}