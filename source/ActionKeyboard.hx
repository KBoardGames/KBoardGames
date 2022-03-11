/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * if mobile then this subState is called when user keyboard input is needed.
 * @author kboardgames.com
 */
class ActionKeyboard extends FlxGroup
{
	private var _background_scene:FlxSprite;
	private var _background_behind_keyboard:FlxSprite;
	
	/******************************
	 * access keyboard members here such as the letter a or the spacebar.
	 */	
	private static var _group_button:Array<ButtonGeneralNetworkYes> = [];
	
	/******************************
	 * used to change the display of the keys. 1=lowercase char. 2:upper and 3:special keys.
	 */
	private var _toggle_keys:Int = 0;
	
	/******************************
	 * keyboard keys that can be toggles such as letters and numbers.
	 */
	private var _button_rows:ButtonGeneralNetworkYes;
		
	/******************************
	 * cursor forwards
	 */
	private var _button1:ButtonGeneralNetworkYes;
	
	/******************************
	 * cursor backwards
	 */
	private var _button2:ButtonGeneralNetworkYes;
	
	/******************************
	 * space button
	 */
	private var _button3:ButtonGeneralNetworkYes;
	
	/******************************
	 * lower/upper char and special char toggle button
	 */
	private var _button4:ButtonGeneralNetworkYes;
	
	/******************************
	 * delete button
	 */
	private var _button5:ButtonGeneralNetworkYes;
	
	/******************************
	 * close button
	 */
	private var _button6:ButtonGeneralNetworkYes;

	// keyboard buttons
	public var _keys:Array<String> =
	[
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ",
	
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ",

	"`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "=", "_", "+", "[", "]", "{", "}", "|", "\\", "/", ";", "'", ":", "\"", ",", ".", "<", ">", "?", " ", " ", " ", " ", " ",
	];

	public function new():Void
	{
		super();
		
		Reg._at_input_keyboard = true;
		
		_background_scene = new FlxSprite();
		_background_scene.makeGraphic(FlxG.width, FlxG.height, 0x33222222);
		_background_scene.scrollFactor.set(0, 0);
		add(_background_scene);
		
		_background_behind_keyboard = new FlxSprite(394, 109);
		_background_behind_keyboard.makeGraphic(606, 456, 0xff000099);
		_background_behind_keyboard.scrollFactor.set(0, 0);
		_background_behind_keyboard.screenCenter(X);
		_background_behind_keyboard.x -= 4;
		add(_background_behind_keyboard);
		
		_button1 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[4] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "FWD", 72, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(36), RegCustomColors.button_colors(), false, 10000);
		_button1.label.font = Reg._fontDefault;
		add(_button1);
		_group_button.push(_button1);
		
		_button2 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[5] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "BWD", 72, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(37), RegCustomColors.button_colors(), false, 10000);
		_button2.label.font = Reg._fontDefault;
		add(_button2);
		_group_button.push(_button2);
		
		// space button.
		_button3 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[0] + 2, Reg._unitXgameBoardLocation[3] + 4 - 140 + 7, "SPACE", 298, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(38), RegCustomColors.button_colors(), false, 10000);
		_button3.label.font = Reg._fontDefault;
		add(_button3);
		_group_button.push(_button3);
		
		// a A ! button.
		_button4 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[6] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "aA!", 72, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(39), RegCustomColors.button_colors(), false, 10000);
		_button4.label.font = Reg._fontDefault;
		add(_button4);
		_group_button.push(_button4);
		
		// delete button.
		_button5 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[7] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "DEL", 72, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(40), RegCustomColors.button_colors(), false, 10000);
		_button5.label.font = Reg._fontDefault;
		add(_button5);
		_group_button.push(_button5);
		
		// close button.
		_button6 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[4] + 2, Reg._unitXgameBoardLocation[3] + 4 - 140 + 7, "CLOSE", 298, 62, 32, RegCustomColors.button_text_colors(), 0, buttonClicked.bind(41), RegCustomColors.button_colors(), false, 10000);
		_button6.label.font = Reg._fontDefault;
		add(_button6);
		_group_button.push(_button6);
		
		drawButtons();
	}
		
	public function close():Void
	{
		RegTriggers._keyboard_opened = false;
		Reg._at_input_keyboard = false;
		
		visible = false;
		active = false;
	}

	public function drawButtons():Void
	{
		active = true;
		visible = true;
		
		var i = -1;
		
		for (yy in 0... 8)
		{
			for (xx in 0...8)
			{
				i += 1;
				
				if (i <= 35)
				{
					// keyboard togglable keys such as letters, numbers and special characters.
					//use onDownClick false because setting it to true that will break the focus of the input fields such as the username field. if setting the onDownClick to true the cursor will then be set back to the beginning at every keyboard press, so don't set it back to true.
					_button_rows = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[xx]+2, Reg._unitXgameBoardLocation[yy] + 4 - 290 + 7, _keys[(i + _toggle_keys)], 72, 62, 22, 0xFFFFFFFF, 0, buttonClicked.bind(i), RegCustom._button_color[Reg._tn], false, 10000);
					_button_rows.label.font = Reg._fontDefault;
					_button_rows.label.size = 36;
					_button_rows.label.offset.y = 9;
					add(_button_rows);
					// add this member to _group_sprite.
					_group_button.push(_button_rows);
				}
			}
		}

	}

	public function buttonClicked(_num:Int):Void
	{		
		// toggle lower/upper/special button was pressed.
		if (_num == 39) 
		{
			_toggle_keys += 37;
			if (_toggle_keys == 111)  _toggle_keys = 0;
			if (_button_rows != null) remove(_button_rows);
			
			drawButtons();
		}
		
		else
		{
			// if space key or delete key
			if (_num == 36) Reg2._key_output = "FORWARDS";
			else if (_num == 37) Reg2._key_output = "BACKWARDS";
			else if (_num == 38) Reg2._key_output = "SPACE";
			else if (_num == 40) Reg2._key_output = "DELETE";
			else if (_num == 41) close();
			
			// else send the key that was clicked to the input field.
			else Reg2._key_output = _keys[(_num + _toggle_keys)];
		}
	}
	
	override public function destroy():Void
	{
		if (_background_scene != null)
		{
			remove(_background_scene);
			_background_scene.destroy();
		}
		
		if (_background_behind_keyboard != null)
		{
			remove(_background_behind_keyboard);
			_background_behind_keyboard.destroy();
		}
		
		_group_button.splice(0, _group_button.length);
		
		if (_button_rows != null)
		{
			remove(_button_rows);
			_button_rows.destroy();
			_button_rows = null;
		}
		
		if (_button1 != null)
		{
			remove(_button1);
			_button1.destroy();
			_button1 = null;
		}
		
		if (_button2 != null)
		{
			remove(_button2);
			_button2.destroy();
			_button2 = null;
		}
		
		if (_button3 != null)
		{
			remove(_button3);
			_button3.destroy();
			_button3 = null;
		}
		
		if (_button4 != null)
		{
			remove(_button4);
			_button4.destroy();
			_button4 = null;
		}
		
		if (_button5 != null)
		{
			remove(_button5);
			_button5.destroy();
			_button5 = null;
		}
		
		if (_button6 != null)
		{
			remove(_button6);
			_button6.destroy();
			_button6 = null;
		}
		
		super.destroy();
	}
}