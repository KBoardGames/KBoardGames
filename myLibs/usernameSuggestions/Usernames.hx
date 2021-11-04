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
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package myLibs.usernameSuggestions;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * @author kboardgames.com
 */
class Usernames
{	
	public static var _text_username_suggestions:FlxText;
	
	public static var _question_username_suggestions_enabled:TextGeneral;
	
	public static var _button_username_suggestions_enabled:ButtonGeneralNetworkNo;
	
	/******************************
	 * text displaying suggested usernames for the username input object.
	 */
	public static var _button_username_suggestions:Array<ButtonToggleFlxState> = []; 
	
	public static var _arr:Array<String> = UsernameSuggestions._list.split("\r\n");
	
	/******************************
	 * when typing in a username at configuration profile, 18 buttons, each display a 1 suggested username from a list at UsernameSuggestions.hx
	 */
	public static function username_suggestions():Void
	{
		_text_username_suggestions = new FlxText(15, CID3._text_username.y + CID3._offset_y + 30, 0, "Suggested Usernames");
		_text_username_suggestions.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_text_username_suggestions.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_text_username_suggestions);
	}
	
	public static function populate_username_suggestions():Void
	{
		var _count = - 1;
		
		for (i in 0...3)
		{
			for (ii in 0...6)
			{
				_count += 1;				
				
				var _ra = FlxG.random.int(0, _arr.length-1);
				var _str = _arr[_ra];
		
				_button_username_suggestions[_count] = new ButtonToggleFlxState((215 * ii) + 57, _text_username_suggestions.y + 50+ (60 * i), 0, _str, 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				_button_username_suggestions[_count].scrollFactor.set(0, 0);
				CID3._group_button_toggle.push(_button_username_suggestions[_count]);
				CID3._group.add(_button_username_suggestions[_count]);
			}
		}
	}
	
	public static function repopulate_username_suggestions():Void
	{
		var _arr2:Array<String> = ["", "", "", "", "", "", "", "", "", "", "", ""];
		
		var _count = -1;
		
		for (i in 0... _arr.length-1)
		{
			// search every array in the username suggestion list and output the first 18 that match the currect text in the username input object.
			if (CID3._usernameInput.text.toLowerCase() 
			==	_arr[i].substr(0, CID3._usernameInput.text.length)
			&&	CID3._usernameInput.text
			!=	_arr[i])
			{
				_count += 1;
				_arr2[_count] = _arr[i]; 
			}
		}
		
		for (i in 0...18)
		{			
			_button_username_suggestions[i].label.text = _arr2[i];
		}
	}
	
	public static function show_username_suggestions():Void
	{
		if (RegCustom._username_suggestions_enabled[Reg._tn] == true)
			_question_username_suggestions_enabled = new TextGeneral(15, _button_username_suggestions[15].height + _button_username_suggestions[15].y + CID3._offset_button_y + CID3._offset_button_y / 2, 800, "Show username suggestions?\r\n", 8, true, true);
		else
			_question_username_suggestions_enabled = new TextGeneral(15, CID3._usernameInput.y + 75, 800, "Show username suggestions?\r\n", 8, true, true);
		
		_question_username_suggestions_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_question_username_suggestions_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_question_username_suggestions_enabled);
		
		_button_username_suggestions_enabled = new ButtonGeneralNetworkNo(850, _question_username_suggestions_enabled.y + 15, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		_button_username_suggestions_enabled.label.font = Reg._fontDefault;
		_button_username_suggestions_enabled.label.text = Std.string(RegCustom._username_suggestions_enabled[Reg._tn]);
		
		CID3._group_button.push(_button_username_suggestions_enabled);
		CID3._group.add(CID3._group_button[0]);
	}	
}
