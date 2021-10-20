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

package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class ConfigurationProfile extends FlxGroup
{
	/******************************
	 * used to draw the UI to scene.
	 */
	private var _num = 0;
	
	private var __action_keyboard:ActionKeyboard;	
	private var __configurations_output:ConfigurationOutput;
	private var __e:ConfigurationProfileEvents;
	
	public static var _arr:Array<String> = RegUsernameSuggestions._list.split("\r\n");
	
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
		__configurations_output = menu_configurations_output;
		__e = new ConfigurationProfileEvents(menu_configurations_output);
		add(__e);
		
		sceneProfile();		
		
		player1_or_player2();
		username_input();
		
		if (RegCustom._username_suggestions_enabled[Reg._tn] == true)
		{
			username_suggestions();
			populate_username_suggestions();
		}		
		
		show_username_suggestions();
		avatars();
		avatar_highlight();
	}
		
	private function sceneProfile():Void
	{
		CID3._group = cast add(new FlxSpriteGroup());
		CID3._group_button.splice(0, CID3._group_button.length);
		CID3._group_button_toggle.splice(0, CID3._group_button_toggle.length);
		
		var _text_title_player = new FlxText(0, 100, 0, "Player username and avatar");
		_text_title_player.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_text_title_player.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_title_player.screenCenter(X);
		CID3._group.add(_text_title_player);
		
		CID3._profile_general_instructions = new FlxText(15, 0, 0, "1: Select either player 1 or player 2 button below.\n2: Type in a username. If you want to play online then use the username you signed up with at the website forum.\n3: Select an avatar you would like to use while playing a game.");
		CID3._profile_general_instructions.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._profile_general_instructions.fieldWidth = FlxG.width - 90;
		CID3._profile_general_instructions.y = _text_title_player.y + 50;
		CID3._profile_general_instructions.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._profile_general_instructions);
		
	}
	
	private function player1_or_player2():Void
	{
		CID3._button_p1 = new ButtonToggleFlxState(0, 0, 1, "Player 1", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, __e.buttonP1);
		CID3._button_p1.screenCenter(X);
		CID3._button_p1.x -= 97;
		// set_toggled must be before has_toggle or the save will not work when click event has not fired somewhere other than this input object.
		CID3._button_p1.set_toggled(true);
		CID3._button_p1.has_toggle = true;
		CID3._button_p1.y = CID3._profile_general_instructions.y + CID3._profile_general_instructions.height + 15;
		CID3._group.add(CID3._button_p1);
		
		CID3._button_p2 = new ButtonToggleFlxState(CID3._button_p1.x + 180 + 15, 200, 1, "Player 2", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, __e.buttonP2);
		CID3._button_p2.set_toggled(false);
		CID3._button_p2.has_toggle = false;
		CID3._button_p2.y = CID3._button_p1.y;
		CID3._group.add(CID3._button_p2);
	}
	
	private function username_input():Void
	{
		CID3._text_username = new FlxText(15, 0, 0, "Username");
		CID3._text_username.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._text_username.y = CID3._button_p1.y + 65;
		CID3._text_username.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_username);	
		
		// type username here.
		CID3._usernameInput = new FlxInputText(15, 0, 152, "", 22);
		CID3._usernameInput.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
		CID3._usernameInput.x += CID3._text_username.textField.width + 15;
		CID3._usernameInput.y = CID3._button_p1.y + 65;
		CID3._usernameInput.text = RegCustom._profile_username_p1[Reg._tn];
		CID3._usernameInput.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._usernameInput);
		
		// fix a bug where typing in the username input field puts the second character before the first character.
		CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
	}
	
	/******************************
	 * when typing in a username at configuration profile, 18 buttons, each display a 1 suggested username from a list at RegUsernameSuggestions.hx
	 */
	private function username_suggestions():Void
	{
		CID3._text_username_suggestions = new FlxText(15, CID3._text_username.y + CID3._offset_y + 30, 0, "Suggested Usernames");
		CID3._text_username_suggestions.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._text_username_suggestions.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_username_suggestions);
	}
	
	private function populate_username_suggestions():Void
	{
		var _count = - 1;
		
		for (i in 0...3)
		{
			for (ii in 0...6)
			{
				_count += 1;				
				
				var _ra = FlxG.random.int(0, _arr.length-1);
				var _str = _arr[_ra];
		
				CID3._button_username_suggestions[_count] = new ButtonToggleFlxState((215 * ii) + 57, CID3._text_username_suggestions.y + 50+ (60 * i), 0, _str, 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID3._button_username_suggestions[_count].scrollFactor.set(0, 0);
				CID3._group_button_toggle.push(CID3._button_username_suggestions[_count]);
				CID3._group.add(CID3._button_username_suggestions[_count]);
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
			CID3._button_username_suggestions[i].label.text = _arr2[i];
		}
	}
	
	private function show_username_suggestions():Void
	{
		if (RegCustom._username_suggestions_enabled[Reg._tn] == true)
			CID3._question_username_suggestions_enabled = new TextGeneral(15, CID3._button_username_suggestions[15].height + CID3._button_username_suggestions[15].y + CID3._offset_button_y + CID3._offset_button_y / 2, 800, "Show username suggestions?\r\n", 8, true, true);
		else
			CID3._question_username_suggestions_enabled = new TextGeneral(15, CID3._usernameInput.y + 75, 800, "Show username suggestions?\r\n", 8, true, true);
		
		CID3._question_username_suggestions_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._question_username_suggestions_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._question_username_suggestions_enabled);
		
		CID3._button_username_suggestions_enabled = new ButtonGeneralNetworkNo(850, CID3._question_username_suggestions_enabled.y + 15, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID3._button_username_suggestions_enabled.label.font = Reg._fontDefault;
		CID3._button_username_suggestions_enabled.label.text = Std.string(RegCustom._username_suggestions_enabled[Reg._tn]);
		
		CID3._group_button.push(CID3._button_username_suggestions_enabled);
		CID3._group.add(CID3._group_button[0]);
	}
	
	private function avatars():Void
	{
		CID3._text_title_avatar = new FlxText(0, CID3._question_username_suggestions_enabled.y + 100, 0, "Avatar");
		CID3._text_title_avatar.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		
		if (RegCustom._username_suggestions_enabled[Reg._tn] == false)
			CID3._text_title_avatar.y = CID3._question_username_suggestions_enabled.y + 100;
			
		CID3._text_title_avatar.screenCenter(X);
		CID3._text_title_avatar.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_title_avatar);
		
		CID3._profile_avatar_notice = new FlxText(15, 250, 0, CID3._text_current_avatar_for_player + "1");
		CID3._profile_avatar_notice.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._profile_avatar_notice.fieldWidth = FlxG.width - 90;
		CID3._profile_avatar_notice.y = CID3._text_title_avatar.y + 55;
		CID3._profile_avatar_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._profile_avatar_notice);
		
		CID3._image_profile_avatar = new FlxSprite(15, 300);
		CID3._image_profile_avatar.loadGraphic("vendor/multiavatar/"+ RegCustom._profile_avatar_number1[Reg._tn]);
		CID3._image_profile_avatar.y = CID3._profile_avatar_notice.y + 50;
		CID3._group.add(CID3._image_profile_avatar);		
		
		CID3._avatar_notice = new FlxText(15, 0, 0, "Select an avatar that you would like to use while playing games in offline mode. That means you are not playing a game with players around the world. Select the avatar then click the save button to save that avatar to your offline profile. Selecting the first avatar will not hide that avatar when playing a game.");
		CID3._avatar_notice.setFormat(Reg._fontDefault, Reg._font_size);
		CID3._avatar_notice.fieldWidth = FlxG.width - 90;
		CID3._avatar_notice.y = CID3._image_profile_avatar.y + 100;
		CID3._avatar_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._avatar_notice);
		
		CID3._group_sprite.splice(0, CID3._group_sprite.length);
		
		// used to position the avatars on rows.
		var _y:Float = 0;
		var _x:Float = 0;
		
		for (i in 0... Reg._avatar_total)
		{			
			var _image_avatar = new FlxSprite(0, 0);
			_image_avatar.loadGraphic("vendor/multiavatar/"+ i +".png");
			_image_avatar.visible = false;
			CID3._group.add(_image_avatar);
			
			CID3._group_sprite.push(_image_avatar);
			
			// this number refers to how many avatars on displayed on a row.
			if (_x > 10)
			{
				_y += 100; // when the amount of avatars on a row is reached then..
				_x = 0; // .. set x back to default and increase y so that the avatars will display on the next row.
			}
			
			CID3._group_sprite[i].setPosition(15 + (102 * _x), CID3._avatar_notice.y + CID3._avatar_notice.height + 15 + _y + 2);
				
			_x += 1;	
			
			CID3._group_sprite[i].visible = true;
			CID3._group.add(CID3._group_sprite[i]);
		}
	}
	
	private function avatar_highlight():Void
	{
		// when clicking on a game image, this image has a border that highlighted it.
		// all gameboards images are stored in frames.
		CID3._image_avatar_highlighted = new FlxSprite(0, 0);
		CID3._image_avatar_highlighted.setPosition(15, CID3._avatar_notice.y + CID3._avatar_notice.height + 15 + 2);
		CID3._image_avatar_highlighted.loadGraphic("assets/images/avatarBorder.png", true, 75, 75); // height is the same value as width.
		CID3._image_avatar_highlighted.animation.add("play", [0, 1], 10, true);
		CID3._image_avatar_highlighted.animation.play("play");
		CID3._image_avatar_highlighted.updateHitbox();
		CID3._group.add(CID3._image_avatar_highlighted);
		
		var _text_empty = new ButtonGeneralNetworkNo(0, CID3._group_sprite[Reg._avatar_total-1].y + 300, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		_text_empty.visible = false;
		CID3._group.add(_text_empty);
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function button_number(_num:Int):Void
	{
		if (Reg._tn == 0) return;
		
		switch (_num)
		{
			case 0: __e.username_suggestions_enabled();
		}
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function button_toggle_number(_num:Int):Void
	{
		switch (_num)
		{
			case 0: CID3._usernameInput.text = CID3._button_username_suggestions[0].label.text;
			case 1: CID3._usernameInput.text = CID3._button_username_suggestions[1].label.text;
			case 2: CID3._usernameInput.text = CID3._button_username_suggestions[2].label.text;
			case 3: CID3._usernameInput.text = CID3._button_username_suggestions[3].label.text;
			case 4: CID3._usernameInput.text = CID3._button_username_suggestions[4].label.text;
			case 5: CID3._usernameInput.text = CID3._button_username_suggestions[5].label.text;
			case 6: CID3._usernameInput.text = CID3._button_username_suggestions[6].label.text;
			case 7: CID3._usernameInput.text = CID3._button_username_suggestions[7].label.text;
			case 8: CID3._usernameInput.text = CID3._button_username_suggestions[8].label.text;
			case 9: CID3._usernameInput.text = CID3._button_username_suggestions[9].label.text;
			case 10: CID3._usernameInput.text = CID3._button_username_suggestions[10].label.text;
			case 11: CID3._usernameInput.text = CID3._button_username_suggestions[11].label.text;
			case 12: CID3._usernameInput.text = CID3._button_username_suggestions[12].label.text;
			case 13: CID3._usernameInput.text = CID3._button_username_suggestions[13].label.text;
			case 14: CID3._usernameInput.text = CID3._button_username_suggestions[14].label.text;
			case 15: CID3._usernameInput.text = CID3._button_username_suggestions[15].label.text;
			case 16: CID3._usernameInput.text = CID3._button_username_suggestions[16].label.text;
			case 17: CID3._usernameInput.text = CID3._button_username_suggestions[17].label.text;
		}
		
		repopulate_username_suggestions();
		CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
	}
	
	override public function update(elapsed:Float):Void
	{
		CID3._usernameInput.hasFocus = true;
		
		// if keyboard is open then set some stuff as not active.
		if (RegTriggers._keyboard_opened == true)
		{
			CID3._group.active = false;
			
			// username field was clicked.
			if (Reg2._input_field_number == 1)
			{
				CID3._usernameInput.active = true;
			}
			
		}
		
		else
		{
			CID3._group.active = true;
		}
		
		// configuration menu. options saved.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			// do not remove. its needed at ConfigurationsOutput.hx
			FlxG.mouse.visible = false;
			Reg2._configuration_jump_to_scene = 2;
			
			FlxG.switchState(new Configuration());
		}
		
		//----------------------------
		if (CID3._group.visible == true
		&&  RegTriggers._keyboard_opened == false)
		{
			CID3._image_avatar_highlighted.visible = false;
			
			for (i in 0... Reg._avatar_total)
			{
				// __scrollable_area.scroll.y is needed so that when the scrollable area has been scrolled that var is used to offset the mouse.y value. it is needed to highlight avatars that are outside of the normal scene y coordinates
				if (FlxG.mouse.x > CID3._group_sprite[i].x
				&&  FlxG.mouse.x < CID3._group_sprite[i].x + 75
				&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > CID3._group_sprite[i].y
				&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < CID3._group_sprite[i].y + 75
				&&  FlxG.mouse.y < FlxG.height - 50)
				{					
					CID3._image_avatar_highlighted.x = 
						CID3._group_sprite[i].x;
					CID3._image_avatar_highlighted.y = 
						CID3._group_sprite[i].y;
					
					CID3._image_avatar_highlighted.visible = true;
					
					if (ActionInput.justPressed() == true)
					{
						if (RegCustom._sound_enabled[Reg._tn] == true
						&&  Reg2._scrollable_area_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
						
						if (CID3._button_p1.has_toggle == true)
							RegCustom._profile_avatar_number1[Reg._tn] = Std.string(i) + ".png";
						else 
							RegCustom._profile_avatar_number2[Reg._tn] = Std.string(i) + ".png";
							
						CID3._image_profile_avatar.loadGraphic("vendor/multiavatar/" + i +".png");
					}
				} 
			}
		}
		
		//#############################
		// username input field.
		// if mouse click then the object will have focus.
		if (CID3._usernameInput.hasFocus == true) 
		{
			if (CID3._usernameInput.text == "") CID3._usernameInput.caretIndex = 0;
			
			// these are needed so that the input field can be set back to focused after a keyboard button press.
			Reg2._input_field_caret_location = CID3._usernameInput.caretIndex;
			Reg2._input_field_number = 1;
		}
				
		// if input field was in focus and a keyboard key was pressed...
		if (Reg2._input_field_number == 1
		&& Reg2._key_output != "")
		{
			CID3._usernameInput.hasFocus = true; // set the field back to focus.
			
			if (Reg2._key_output == "FORWARDS")
			{
				Reg2._key_output = "";
				
				if (CID3._caretIndex > 0) 
				{
					CID3._caretIndex -= 1;
					CID3._usernameInput.caretIndex = CID3._caretIndex;
				}
				
				else CID3._usernameInput.caretIndex = 0;
			}
			
			else if (Reg2._key_output == "BACKWARDS")
			{
				Reg2._key_output = "";
				
				if (CID3._caretIndex < CID3._usernameInput.text.length) 
				{
					CID3._caretIndex += 1;
					CID3._usernameInput.caretIndex = CID3._caretIndex;
				}
				
				else CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
			}
			
			else if (Reg2._key_output == "DELETE")
			{
				CID3._usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
				
				// get from start of text to cursor.
				var _str_start = CID3._usernameInput.text.substr(0, CID3._usernameInput.caretIndex);
				
				// and the end.
				var _str_end = CID3._usernameInput.text.substr(_str_start.length, CID3._usernameInput.text.length);
				
				// then delete one character at the cursor.
				CID3._usernameInput.text = _str_start.substr(0, _str_start.length - 1) + _str_end;
				
				// this is needed because we are removing a character therefore the position of the caret should change.
				if (CID3._usernameInput.caretIndex > 0) 
				{
					CID3._usernameInput.caretIndex -= 1;
					CID3._caretIndex -= 1;
				}
				
				Reg2._key_output = "";
			}
			
			else // add a letter.
			{
				repopulate_username_suggestions();
				
				// if cursor is at the end of the line.
				if (CID3._usernameInput.text.length-1 == CID3._usernameInput.caretIndex)
				{
					CID3._usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					
					if (Reg2._key_output == "SPACE") CID3._usernameInput.text += " ";
					else CID3._usernameInput.text += Reg2._key_output;
					
					Reg2._key_output = "";
				}
				
				else
				{
					CID3._usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					// get from start of text to cursor.
					var _str_start = CID3._usernameInput.text.substr(0, CID3._usernameInput.caretIndex);
					// and the end.
					var _str_end = CID3._usernameInput.text.substr(CID3._usernameInput.caretIndex, CID3._usernameInput.text.length);
					
					// output the text of the input field from the value set with the keyboard.
					if (Reg2._key_output == "SPACE")
					{
						CID3._usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						CID3._usernameInput.text = _str_start + " " + _str_end;
					
						// this is needed because we are removing a character therefore the position of the caret should change.
						CID3._usernameInput.caretIndex += 1;
					}
									
					else 
					{
						CID3._usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						// at one character at cursor.
						CID3._usernameInput.text = _str_start + Reg2._key_output + _str_end;
						// this is needed because we are removing a character therefore the position of the caret should change.
						CID3._usernameInput.caretIndex += 1;
						CID3._caretIndex += 1;
					}
					
					Reg2._key_output = "";
				}				
				
			}
			
		}
		
				
		if (RegTriggers._keyboard_open == true)
		{
			RegTriggers._keyboard_open = false;
			RegTriggers._keyboard_opened = true;

			#if mobile
				if (__action_keyboard != null)
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
				
				if (__action_keyboard == null)
				{
					__action_keyboard = new ActionKeyboard();
					add(__action_keyboard);
				}
				
				__action_keyboard.drawButtons();
			#end
		}
		
		if (RegTriggers._keyboard_close == true)
		{
			RegTriggers._keyboard_close = false;

			#if mobile
				if (__action_keyboard != null) 
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
			#end
		}
		
		if (CID3._usernameInput.hasFocus == true)
		{
			CID3._usernameInput.fieldBorderColor = FlxColor.RED;			
			CID3._usernameInput.fieldBorderThickness = 3;
		}
		else
		{
			CID3._usernameInput.fieldBorderColor = FlxColor.BLACK;			
			CID3._usernameInput.fieldBorderThickness = 1;
				
		}
		
		//------------------------------
		if (CID3._button_p1.has_toggle == true) 
			RegCustom._profile_username_p1[Reg._tn] = CID3._usernameInput.text;
		
		if (CID3._button_p2.has_toggle == true) 
			RegCustom._profile_username_p2[Reg._tn] = CID3._usernameInput.text;
				
		//-------------------------------
		
		for (i in 0... CID3._group_button_toggle.length)
		{
			// if mouse is on the text plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= CID3._group_button_toggle[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= CID3._group_button_toggle[i]._startY + CID3._group_button_toggle[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= CID3._group_button_toggle[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= CID3._group_button_toggle[i]._startX + CID3._group_button_toggle[i]._button_width && FlxG.mouse.justPressed == true )
			{
				button_toggle_number(i);
				
				break;
			}
			
		}
		
		for (i in 0... CID3._group_button.length)
		{
			// if mouse is on the text plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= CID3._group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= CID3._group_button[i]._startY + CID3._group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= CID3._group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= CID3._group_button[i]._startX + CID3._group_button[i]._button_width && FlxG.mouse.justPressed == true )
			{
				button_number(i);
				
				break;
			}
			
		}
		
		super.update(elapsed);		
		
		if (ActionInput.justPressed() == true
		&&  FlxG.mouse.x > CID3._usernameInput.x
		&&  FlxG.mouse.x < CID3._usernameInput.x + CID3._usernameInput.width
		&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > CID3._usernameInput.y
		&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < CID3._usernameInput.y + CID3._usernameInput.height
		&&  FlxG.mouse.y < FlxG.height - 50)
		{
			CID3._usernameInput.hasFocus = true;
			
			if (RegCustom._sound_enabled[Reg._tn] == true
			&&  Reg2._scrollable_area_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
							
			#if mobile
				RegTriggers._keyboard_open = true;
			#end
		}
	
		// update get 18 more username suggestions everytime a key at username input object is pressed.
		CID3._usernameInput.callback = function (text, action)
		{
			if (text != "") 
			{
				repopulate_username_suggestions();
			}
		}
	}
}//