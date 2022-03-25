/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * special foreground effects used to show a scene. One effect could be similar to a curtain opening which would show the contents of the scene behind it. 
 * @author kboardgames.com
 */
class SceneTransition extends FlxSubState
{
	/******************************
	 * when this value is 0 then the backgrounds will be set in motion. this give time for the stage underneath it to draw all elements. without this ticks, some scenes will be shown as redrawing or resizing its elements as these backgrounds are opening to display them.
	 */	
	private var _ticks_delay:Int = 5;
	
	private var _half_background_horizontal_left:FlxSprite;
	private var _half_background_horizontal_right:FlxSprite;
	private var _half_background_vertical_left:FlxSprite;
	private var _half_background_vertical_right:FlxSprite;
	
	/******************************
	 * see constructor.
	 */
	private var _direction:Int = -1;
	
	/******************************
	 * the velocity of the object.
	 */
	private var _speed:Int = 2000;
	
	/******************************
	 * @param	direction		0: no effects, 1: horizontal, 2: vertical, 3: horizonal and vertical, 4: angle, 5: random.
	 */
	public function new():Void 
	{
		super();

		for (i in 0...3)
		{
			Reg._ticks_button_100_percent_opacity[i] = 0; // reset this so that buttons can be dsiplayed normally and sound will work when clicking the button. without this code the ButtonGeneralNetworkYes.hx buttons text at the next scene will be displayed at the top of the button for a second until the alpha is reset to a value of 1. 
		}
		
		Reg._buttonDown = false;
		Reg._button_clicked = false;
		
		_direction = RegCustom._scene_transition_number[Reg._tn];
		
		if (_direction == 5) _direction = FlxG.random.int(1, 4);
		
		// horizontal.
		if (_direction == 1 || _direction == 3)
		{
			_half_background_horizontal_left = new FlxSprite(0, 0);
			_half_background_horizontal_left.makeGraphic(Std.int(FlxG.width / 2), FlxG.height, FlxColor.BLACK);
			_half_background_horizontal_left.scrollFactor.set(0, 0);
			add(_half_background_horizontal_left);
			
			_half_background_horizontal_right = new FlxSprite(Std.int(FlxG.width / 2), 0);
			_half_background_horizontal_right.makeGraphic(Std.int(FlxG.width / 2), FlxG.height, FlxColor.BLACK);
			_half_background_horizontal_right.scrollFactor.set(0, 0);
			add(_half_background_horizontal_right);
		}
		
		// vertical.
		if (_direction == 2 || _direction == 3)
		{
			_half_background_vertical_left = new FlxSprite(0, 0	);
			_half_background_vertical_left.makeGraphic(FlxG.width, Std.int(FlxG.height / 2), FlxColor.BLACK);
			_half_background_vertical_left.scrollFactor.set(0, 0);
			add(_half_background_vertical_left);
			
			_half_background_vertical_right = new FlxSprite(0, Std.int(FlxG.height / 2));
			_half_background_vertical_right.makeGraphic(FlxG.width, Std.int(FlxG.height / 2), FlxColor.BLACK);
			_half_background_vertical_right.scrollFactor.set(0, 0);
			add(_half_background_vertical_right);
		}	
		
		// angle.
		if (_direction == 4)
		{
			_half_background_vertical_left = new FlxSprite(- Std.int(FlxG.width / 2), - Std.int(FlxG.height / 1.42));
			_half_background_vertical_left.makeGraphic(Std.int(FlxG.width * 2), FlxG.height, FlxColor.BLACK);
			_half_background_vertical_left.scrollFactor.set(0, 0);
			_half_background_vertical_left.angle = -45;
			add(_half_background_vertical_left);
			
			_half_background_vertical_right = new FlxSprite(- Std.int(FlxG.width / 2), Std.int(FlxG.height / 1.42));
			_half_background_vertical_right.makeGraphic(Std.int(FlxG.width * 2), FlxG.height, FlxColor.BLACK);
			_half_background_vertical_right.scrollFactor.set(0, 0);
			_half_background_vertical_right.angle = -45;
			add(_half_background_vertical_right);
		}	

	}
	
	override public function destroy():Void
	{
		if (_half_background_horizontal_left != null)
		{
			remove(_half_background_horizontal_left);
			_half_background_horizontal_left.destroy();
			_half_background_horizontal_left = null;
		}
		
		if (_half_background_horizontal_right != null)
		{
			remove(_half_background_horizontal_right);
			_half_background_horizontal_right.destroy();
			_half_background_horizontal_right = null;
		}
		
		if (_half_background_vertical_left != null)
		{
			remove(_half_background_vertical_left);
			_half_background_vertical_left.destroy();
			_half_background_vertical_left = null;
		}
		
		if (_half_background_vertical_right != null)
		{
			remove(_half_background_vertical_right);
			_half_background_vertical_right.destroy();
			_half_background_vertical_right = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		_ticks_delay -= 1;
		
		if (_ticks_delay == 0)
		{
			if (_direction == 1 || _direction == 3)
			{
				_half_background_horizontal_left.velocity.x = - _speed;
				_half_background_horizontal_right.velocity.x = _speed;
			}
			
			if (_direction == 2 || _direction == 3)
			{
				_half_background_vertical_left.velocity.y = - _speed;
				_half_background_vertical_right.velocity.y = _speed;
			}
			
			if (_direction == 4)
			{
				_half_background_vertical_left.velocity.x = - _speed;
				_half_background_vertical_right.velocity.x = _speed;
			}
		}
		
		if (_direction == 0) close();
		
		// horizontal or vertical.
		if (_direction == 1 || _direction == 3)
		{
			if (_half_background_horizontal_right.x > FlxG.width)
				close();			
		}
		
		// vertical. the reason why _direction == 3 is not used here is because the horizontal effect finishes after the veritical effect. At the constructor the _direction == 3 sets the vertical effect in motion. The _direction == 3 condition above at update() will close the scene. 
		if (_direction == 2)
		{
			if (_half_background_vertical_right.y > FlxG.height)
				close();		
		}
		
		// angle.
		if (_direction == 4)
		{
			if (_half_background_vertical_right.x > FlxG.height)
				close();		
		}
		
		super.update(elapsed);
		
	}
}