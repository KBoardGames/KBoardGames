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
 * if mobile then this subState is called when user keyboard input is needed.
 * @author kboardgames.com
 */
class ActionKeyboard extends FlxGroup
{
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
		
		var background = new FlxSprite(394, 40 + 69);
		background.makeGraphic(606, 600 - 75 - 69, 0xff000099);
		background.scrollFactor.set(0, 0);
		background.screenCenter(X);
		add(background);
		
		_button1 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[4] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "FWD", 72, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(36), 0xFF440044, false);
		_button1.label.font = Reg._fontDefault;
		add(_button1);
		_group_button.push(_button1);
		
		_button2 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[5] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "BWD", 72, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(37), 0xFF440044, false);
		_button2.label.font = Reg._fontDefault;
		add(_button2);
		_group_button.push(_button2);
		
		// space button.
		_button3 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[0] + 2, Reg._unitXgameBoardLocation[3] + 4 - 140 + 7, "SPACE", 298, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(38), 0xFF440044, false);
		_button3.label.font = Reg._fontDefault;
		add(_button3);
		_group_button.push(_button3);
		
		// a A ! button.
		_button4 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[6] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "aA!", 72, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(39), 0xFF440044, false);
		_button4.label.font = Reg._fontDefault;
		add(_button4);
		_group_button.push(_button4);
		
		// delete button.
		_button5 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[7] + 2, Reg._unitXgameBoardLocation[2] + 4 - 140 + 7, "DEL", 72, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(40), 0xFF440044, false);
		_button5.label.font = Reg._fontDefault;
		add(_button5);
		_group_button.push(_button5);
		
		// close button.
		_button6 = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[4] + 2, Reg._unitXgameBoardLocation[3] + 4 - 140 + 7, "CLOSE", 298, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(41), 0xFF333300, false);
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
					_button_rows = new ButtonGeneralNetworkYes(Reg._unitXgameBoardLocation[xx]+2, Reg._unitXgameBoardLocation[yy] + 4 - 290 + 7, _keys[(i + _toggle_keys)], 72, 62, 32, 0xFFFFFFFF, 0, buttonClicked.bind(i), RegCustom._button_color[Reg._tn], false);
					_button_rows.label.font = Reg._fontDefault;
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
		super.destroy();
	}
}