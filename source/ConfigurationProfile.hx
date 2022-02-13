/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if avatars
	import modules.avatars.Avatars;
#end

#if flags
	import modules.worldFlags.WorldFlags;
#end

#if username_suggestions
	import modules.usernameSuggestions.Usernames;
#end

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class ConfigurationProfile extends FlxGroup
{
	/******************************
	 * used to draw the UI to scene.
	 */
	private var _num:Int = 0;
	
	/******************************
	 * used to change the world flag highlighter to a different color.
	 */
	private var _ticks:Int = 0;
	
	/******************************
	 * call update only once then call it after user input.
	 */
	private var _do_once:Bool = true;
	
	private var __action_keyboard:ActionKeyboard;	
	private var __configurations_output:ConfigurationOutput;
	private var __e:ConfigurationProfileEvents;
	
	
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
		
		__configurations_output = menu_configurations_output;
		__e = new ConfigurationProfileEvents(menu_configurations_output);
		add(__e);
		
		CID3._group = cast add(new FlxSpriteGroup());
		CID3._group.members.splice(0, CID3._group.members.length);
		CID3._group_username_input.splice(0, CID3._group_username_input.length);
		CID3._group_password_input.splice(0, CID3._group_password_input.length);
		CID3._group_email_address_input.splice(0, CID3._group_email_address_input.length);
		CID3._group_button.splice(0, CID3._group_button.length);
		CID3._group_button_toggle.splice(0, CID3._group_button_toggle.length);
		
		#if avatars
			Avatars._group_sprite.splice(0, Avatars._group_sprite.length);
		#end
		
		#if flags
			WorldFlags._group_flag_sprites.splice(0, WorldFlags._group_flag_sprites.length);
		
			WorldFlags._group_flag_highlight_sprite.splice(0, WorldFlags._group_flag_highlight_sprite.length);
		#end
		
		sceneProfile();		
		
		player1_or_player2();
		email_address_validation_code();
		username_input();
		password_input();
		email_address_input();
		
		#if username_suggestions	
			if (RegCustom._username_suggestions_enabled[Reg._tn] == true)
			{
				Usernames.username_suggestions();
				Usernames.populate_username_suggestions();
			}
			
			Usernames.show_username_suggestions();
		#end
		
		#if avatars
			Avatars.avatars();
			Avatars.avatar_highlight();
		#end
		
		#if flags 
			WorldFlags.world_flag_notice();
			WorldFlags.world_flag_highlight();
			WorldFlags.world_flags();
		#end
		
		// DO NOT FORGET TO UPDATE THE buttonNumber() FUNCTiON.
		#if flags
			CID3._text_empty = new ButtonGeneralNetworkNo(0, WorldFlags._group_flag_highlight_sprite[253].y + 250, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		#elseif avatars
			CID3._text_empty = new ButtonGeneralNetworkNo(0, Avatars._group_sprite[299].y + 250, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		#elseif username_suggestions
			CID3._text_empty = new ButtonGeneralNetworkNo(0, Usernames._question_username_suggestions_enabled.y + 250, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);		
		#end
		
		if (CID3._text_empty != null)
		{
			CID3._text_empty.visible = false;
			CID3._group.add(CID3._text_empty);
		}
		
		else
		{
			// vertical scrollbar is needed or else the general and game scenes will not have a scrollbar. remember that all configuration scenes share the same scrollable area.
			CID3._text_empty = new ButtonGeneralNetworkNo(0, FlxG.height + 15, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID3._text_empty.visible = false;
			CID3._group.add(CID3._text_empty);		
		}
		
		CID3._sprite_user_account = new FlxSprite(25, 0, "assets/images/arrow.png");
		CID3._sprite_user_account.scrollFactor.set(0, 0);
		CID3._group.add(CID3._sprite_user_account);
	}
		
	private function sceneProfile():Void
	{
		var _text_topic_title_player = new FlxText(0, 100, 0, "Player Account");
		_text_topic_title_player.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_text_topic_title_player.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_topic_title_player.screenCenter(X);
		CID3._group.add(_text_topic_title_player);
		
		CID3._profile_general_instructions = new FlxText(15, 0, 0, "1: Select either player 1 or player 2 button below.\n2: For player 1, if you do not want to play online as guest then type in a username and password. Minimum length for password is four characters. Email address is optional for tournament notices.\n3: Player 2 is used for offline play.");
		CID3._profile_general_instructions.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID3._profile_general_instructions.fieldWidth = FlxG.width - 90;
		CID3._profile_general_instructions.y = _text_topic_title_player.y + 50;
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
	
	public static function email_address_validation_code():Void
	{
		CID3._question_email_address_validation_code_enabled = new TextGeneral(15, CID3._button_p1.y + 100, 800, "Resend email address validaton code?\r\n", 8, true, true);		
		CID3._question_email_address_validation_code_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID3._question_email_address_validation_code_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._question_email_address_validation_code_enabled);
		
		CID3._button_email_address_validation_code_enabled = new ButtonGeneralNetworkNo(850, CID3._question_email_address_validation_code_enabled.y + 15, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID3._button_email_address_validation_code_enabled.label.font = Reg._fontDefault;
		CID3._button_email_address_validation_code_enabled.label.text = Std.string(RegCustom._send_email_address_validation_code);
		
		CID3._group_button.push(CID3._button_email_address_validation_code_enabled);
		CID3._group.add(CID3._group_button[0]);
	}	
	
	private function username_input():Void
	{
		CID3._text_username = new FlxText(60, 0, 0, "Username", Reg._font_size);
		CID3._text_username.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID3._text_username.y = CID3._question_email_address_validation_code_enabled.y + 100;
		CID3._text_username.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_username);
		
		for (i in 0... CID3._user_account_row)
		{
			// type username here.
			CID3._username_input = new FlxInputText(15, 0, 197, "", Reg._font_size - 2);
			CID3._username_input.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
			CID3._username_input.x = CID3._text_username.x + CID3._text_username.textField.width + 15;
			CID3._username_input.filterMode = FlxInputText.ONLY_ALPHA;
			
			CID3._group.add(CID3._username_input);
			
			// fix a bug where typing in the username input field puts the second character before the first character.
			CID3._username_input.caretIndex = CID3._username_input.text.length; 
			CID3._username_input.maxLength = 13;
			
			// add this member to _group_sprite.			
			CID3._group_username_input.push(CID3._username_input);
			CID3._group_username_input[i].setPosition(60, CID3._text_username.y + 50 + (45 * i));
			add(CID3._group_username_input[i]);
			
			CID3._group_username_input[i].text = RegCustom._profile_username_p1[i];
			
		}
	}
	
	private function password_input():Void
	{
		CID3._text_password = new FlxText(60 + 215, 0, 0, "Password", Reg._font_size);
		CID3._text_password.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID3._text_password.y = CID3._question_email_address_validation_code_enabled.y + 100;
		CID3._text_password.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_password);	
		
		for (i in 0... CID3._user_account_row)
		{
			// type password here.
			CID3._password_input = new FlxInputText(15, 0, (197 * 2) + 15 + 3, "", Reg._font_size - 2);
			CID3._password_input.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
			CID3._password_input.x = CID3._text_password.x + CID3._text_password.textField.width + 15;
			CID3._password_input.maxLength = 200;
			
			if (RegCustom._profile_password_p1[i] != "")
			{
				// hide password if there is one.
				CID3._password_input.passwordMode = true;
			}
			
			CID3._group.add(CID3._password_input);
			
			// fix a bug where typing in the password input field puts the second character before the first character.
			CID3._password_input.caretIndex = CID3._password_input.text.length;
			
			// add this member to _group_sprite.			
			CID3._group_password_input.push(CID3._password_input);
			CID3._group_password_input[i].setPosition(60 + 215, CID3._text_password.y + 50 + (45 * i));
			add(CID3._group_password_input[i]);
			
			CID3._group_password_input[i].text = RegCustom._profile_password_p1[i];
		}
	}
	
	
	private function email_address_input():Void
	{
		CID3._text_email_address = new FlxText(60 + (215 * 3), 0, 0, "Email Address", Reg._font_size);
		CID3._text_email_address.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID3._text_email_address.y = CID3._question_email_address_validation_code_enabled.y + 100;
		CID3._text_email_address.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(CID3._text_email_address);	
		
		for (i in 0... CID3._user_account_row)
		{
			// type email address here.
			CID3._email_address_input = new FlxInputText(15, 0, (197 * 3) + 30 + 6, "", Reg._font_size - 2);
			CID3._email_address_input.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
			CID3._email_address_input.x = CID3._text_email_address.x + CID3._text_email_address.textField.width + 15;
			CID3._email_address_input.maxLength = 100;
			
			CID3._group.add(CID3._email_address_input);
			
			// fix a bug where typing in the email address input field puts the second character before the first character.
			CID3._email_address_input.caretIndex = CID3._email_address_input.text.length;
			
			// add this member to _group_sprite.			
			CID3._group_email_address_input.push(CID3._email_address_input);
			CID3._group_email_address_input[i].setPosition(CID3._text_email_address.x, CID3._text_email_address.y + 50 + (45 * i));
			add(CID3._group_email_address_input[i]);
			
			CID3._group_email_address_input[i].text = RegCustom._profile_email_address_p1[i];
		}
	}
	
	// next feature placed here should check if username suggestions, avatar or world flags lib is set. if exists then new feature y value must use CID3._text_username.y, CID3._text_username.y_question_username_suggestions_enabled.y or _group_sprite[299].y
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function button_number(_num:Int):Void
	{
		if (Reg._tn == 0) return;
		
		switch (_num)
		{
			case 0: __e.send_email_address_validation_code_enabled();
			case 1: __e.username_suggestions_enabled();
		}
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function button_toggle_number(_num:Int):Void
	{
		#if username_suggestions
			switch (_num)
			{
				case 0: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[0].label.text;
				case 1: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[1].label.text;
				case 2: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[2].label.text;
				case 3: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[3].label.text;
				case 4: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[4].label.text;
				case 5: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[5].label.text;
				case 6: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[6].label.text;
				case 7: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[7].label.text;
				case 8: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[8].label.text;
				case 9: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[9].label.text;
				case 10: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[10].label.text;
				case 11: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[11].label.text;
				case 12: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[12].label.text;
				case 13: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[13].label.text;
				case 14: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[14].label.text;
				case 15: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[15].label.text;
				case 16: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[16].label.text;
				case 17: CID3._group_username_input[CID3._CRN].text = Usernames._button_username_suggestions[17].label.text;
			}
			
			Usernames.repopulate_username_suggestions();
			CID3._username_input.caretIndex = CID3._username_input.text.length;
		#end
	}
	
	private function keyboard_pressed():Void
	{
		// if input field was in focus and a keyboard key was pressed...
		if (Reg2._input_field_number == 1
		&& Reg2._key_output != "")
		{
			CID3._username_input.hasFocus = true; // set the field back to focus.
			
			if (Reg2._key_output == "FORWARDS")
			{
				if (CID3._caretIndex > 0) 
				{
					CID3._caretIndex -= 1;
					CID3._username_input.caretIndex = CID3._caretIndex;
				}
				
				else CID3._username_input.caretIndex = 0;
			}
			
			else if (Reg2._key_output == "BACKWARDS")
			{
				if (CID3._caretIndex < CID3._username_input.text.length) 
				{
					CID3._caretIndex += 1;
					CID3._username_input.caretIndex = CID3._caretIndex;
				}
				
				else CID3._username_input.caretIndex = CID3._username_input.text.length;
			}
			
			else if (Reg2._key_output == "DELETE")
			{
				CID3._username_input.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
				
				// get from start of text to cursor.
				var _str_start = CID3._username_input.text.substr(0, CID3._username_input.caretIndex);
				
				// and the end.
				var _str_end = CID3._username_input.text.substr(_str_start.length, CID3._username_input.text.length);
				
				// then delete one character at the cursor.
				CID3._username_input.text = _str_start.substr(0, _str_start.length - 1) + _str_end;
				
				// this is needed because we are removing a character therefore the position of the caret should change.
				if (CID3._username_input.caretIndex > 0) 
				{
					CID3._username_input.caretIndex -= 1;
					CID3._caretIndex -= 1;
				}
			}
			
			else // add a letter.
			{
				#if username_suggestions
					Usernames.repopulate_username_suggestions();
				#end
				
				// if cursor is at the end of the line.
				if (CID3._username_input.text.length-1 == CID3._username_input.caretIndex)
				{
					CID3._username_input.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					
					if (Reg2._key_output == "SPACE") CID3._username_input.text += " ";
					else CID3._username_input.text += Reg2._key_output;
				}
				
				else
				{
					CID3._username_input.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					// get from start of text to cursor.
					var _str_start = CID3._username_input.text.substr(0, CID3._username_input.caretIndex);
					// and the end.
					var _str_end = CID3._username_input.text.substr(CID3._username_input.caretIndex, CID3._username_input.text.length);
					
					// output the text of the input field from the value set with the keyboard.
					if (Reg2._key_output == "SPACE")
					{
						CID3._username_input.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						CID3._username_input.text = _str_start + " " + _str_end;
					
						// this is needed because we are removing a character therefore the position of the caret should change.
						CID3._username_input.caretIndex += 1;
					}
									
					else 
					{
						CID3._username_input.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						// at one character at cursor.
						CID3._username_input.text = _str_start + Reg2._key_output + _str_end;
						// this is needed because we are removing a character therefore the position of the caret should change.
						CID3._username_input.caretIndex += 1;
						CID3._caretIndex += 1;
					}					
				}				
				
			}
			
			Reg2._key_output = "";
		}
	}
	
	private function user_input():Void
	{
		for (i in 0... CID3._user_account_row)
		{
			if (CID3._CRN == i
			||	CID3._button_p2.has_toggle == true)
			{
				CID3._group_username_input[i].backgroundColor = FlxColor.WHITE;
				if (CID3._group_username_input[i].fieldBorderColor == FlxColor.BLUE)
					CID3._group_username_input[i].hasFocus = true;
				else if (CID3._group_username_input[i].hasFocus == true)
				{
					CID3._group_password_input[i].fieldBorderColor = FlxColor.BLACK;
					CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLACK;
				}
				
				CID3._sprite_user_account.y = CID3._group_username_input[i].y + 6;
			}
			
			else 
			{
				CID3._group_username_input[i].hasFocus = false;
				CID3._group_username_input[i].backgroundColor = FlxColor.GRAY;
				CID3._group_username_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_username_input[i].fieldBorderThickness = 1;	
			}
			
			if (CID3._CRN == i
			||	CID3._button_p2.has_toggle == true)
			{
				CID3._group_password_input[i].backgroundColor = FlxColor.WHITE;
				if (CID3._group_password_input[i].fieldBorderColor == FlxColor.BLUE)
					CID3._group_password_input[i].hasFocus = true;
				else if (CID3._group_password_input[i].hasFocus == true)
				{
					CID3._group_username_input[i].fieldBorderColor = FlxColor.BLACK;
					CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLACK;
				}
			}
			
			else 
			{
				CID3._group_password_input[i].hasFocus = false;
				CID3._group_password_input[i].backgroundColor = FlxColor.GRAY;
				CID3._group_password_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_password_input[i].fieldBorderThickness = 1;
			}
			
			if (CID3._CRN == i
			||	CID3._button_p2.has_toggle == true)
			{
				CID3._group_email_address_input[i].backgroundColor = FlxColor.WHITE;
				if (CID3._group_email_address_input[i].fieldBorderColor == FlxColor.BLUE)
					CID3._group_email_address_input[i].hasFocus = true;
				else if (CID3._group_email_address_input[i].hasFocus == true)
				{
					CID3._group_password_input[i].fieldBorderColor = FlxColor.BLACK;
					CID3._group_username_input[i].fieldBorderColor = FlxColor.BLACK;
				}
			}
			
			else 
			{
				CID3._group_email_address_input[i].hasFocus = false;
				CID3._group_email_address_input[i].backgroundColor = FlxColor.GRAY;
				CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_email_address_input[i].fieldBorderThickness = 1;	
			}
			
			// if keyboard is open then set some stuff as not active.
			if (RegTriggers._keyboard_opened == true
			&&	CID3._group.active == true
			||	RegTriggers._keyboard_opened == true
			&&	Reg2._input_field_number == 1
			&&	CID3._group_username_input[i].active == false)
			{
				CID3._group.active = false;
				
				// username field was clicked.
				if (Reg2._input_field_number == 1)
				{
					CID3._group_username_input[i].active = true;
				}			
			}
			
			else if (CID3._group.active == false)
			{
				CID3._group.active = true;
			}
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
		#if avatars
			if (Reg._buttonCodeValues == "")
			{
				if (CID3._group.visible == true
				&&  RegTriggers._keyboard_opened == false)
				{
					Avatars._image_avatar_highlighted.visible = false;
					
					for (i in 0... Reg._avatar_total)
					{
						// __scrollable_area.scroll.y is needed so that when the scrollable area has been scrolled that var is used to offset the mouse.y value. it is needed to highlight avatars that are outside of the normal scene y coordinates
						if (FlxG.mouse.x > Avatars._group_sprite[i].x
						&&  FlxG.mouse.x < Avatars._group_sprite[i].x + 75
						&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > Avatars._group_sprite[i].y
						&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < Avatars._group_sprite[i].y + 75
						&&  FlxG.mouse.y < FlxG.height - 50)
						{					
							Avatars._image_avatar_highlighted.x = 
								Avatars._group_sprite[i].x;
							Avatars._image_avatar_highlighted.y = 
								Avatars._group_sprite[i].y;
							
							Avatars._image_avatar_highlighted.visible = true;
							
							if (ActionInput.justPressed() == true)
							{
								if (RegCustom._sound_enabled[Reg._tn] == true
								&&  Reg2._scrollable_area_is_scrolling == false)
									FlxG.sound.play("click", 1, false);
								
								if (CID3._button_p1.has_toggle == true)
									RegCustom._profile_avatar_number1[Reg._tn] = Std.string(i) + ".png";
								else 
									RegCustom._profile_avatar_number2[Reg._tn] = Std.string(i) + ".png";
									
								Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + i +".png");
							}
						} 
					}
				}
			}
		#end
		
		#if flags
			if (Reg._buttonCodeValues == "")
			{
				if (CID3._group.visible == true
				&&  RegTriggers._keyboard_opened == false)
				{
					for (i in 0... WorldFlags._flags_abbv.length)
					{
						WorldFlags._group_flag_highlight_sprite[i].visible = false;
						
						if (FlxG.mouse.x > WorldFlags._group_flag_sprites[i].x
						&&  FlxG.mouse.x < WorldFlags._group_flag_sprites[i].x + WorldFlags._group_flag_sprites[i].width
						&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > WorldFlags._group_flag_sprites[i].y
						&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < WorldFlags._group_flag_sprites[i].y + 40
						&&  FlxG.mouse.y < FlxG.height - 50)
						{
							WorldFlags._group_flag_highlight_sprite[i].makeGraphic(Std.int(WorldFlags._group_flag_sprites[i].width) + 6, 40 + 6, FlxColor.WHITE);
							WorldFlags._group_flag_highlight_sprite[i].visible = true;
							// when the mouse is over a flag this will change the highlight image from white to a different color.
							if (_ticks <= 5) WorldFlags._group_flag_highlight_sprite[i].color = FlxColor.WHITE;
							if (_ticks >= 10)  WorldFlags._group_flag_highlight_sprite[i].color = FlxColor.PURPLE;
							
							if (ActionInput.justPressed() == true)
							{
								if (RegCustom._sound_enabled[Reg._tn] == true
								&&  Reg2._scrollable_area_is_scrolling == false)
									FlxG.sound.play("click", 1, false);
								
								RegCustom._world_flags_number[Reg._tn] = i;
									
								WorldFlags._image_selected_world_flag.loadGraphic("modules/worldFlags/assets/images/" + WorldFlags._flags_abbv[RegCustom._world_flags_number[Reg._tn]].toLowerCase() + ".png");
								// hide the default flag background if user selects any other flag.
								if (RegCustom._world_flags_number[Reg._tn] == 0)
									CID3._default_flag_background.visible = true;
								else
									CID3._default_flag_background.visible = false;
									
							}
						} 
					}
				}
			}
		#end	
		
		_ticks += 1; if (_ticks >= 15) _ticks = 5;
			
		//#############################
		// username input field.
		for (i in 0... CID3._user_account_row)
		{
			if (CID3._CRN == i)
			{
				if (CID3._group_username_input[i].hasFocus == true) 
				{
					if (CID3._group_username_input[i].text == "") CID3._group_username_input[i].caretIndex = 0;
					
					// these are needed so that the input field can be set back to focused after a keyboard button press.
					Reg2._input_field_caret_location = CID3._group_username_input[i].caretIndex;
					Reg2._input_field_number = 1;
				}
				
				// password input field.
				if (CID3._group_password_input[i].hasFocus == true) 
				{
					if (CID3._group_password_input[i].text == "") CID3._group_password_input[i].caretIndex = 0;
				}
				
				// email address input field.
				if (CID3._group_email_address_input[i].hasFocus == true) 
				{
					if (CID3._group_email_address_input[i].text == "") CID3._group_email_address_input[i].caretIndex = 0;
				}
			}
		}
		
		if (Reg2._key_output != "") keyboard_pressed();
		
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
		
		//------------------------------
		for (i in 0... CID3._user_account_row)
		{
			if (CID3._CRN == i)
			{
				if (CID3._button_p1.has_toggle == true
				&&	RegCustom._profile_username_p1[CID3._CRN] 
				!=	CID3._group_username_input[i].text) 
				{
					RegCustom._profile_username_p1[CID3._CRN] = CID3._group_username_input[i].text;			
				}
				
				if (CID3._button_p2.has_toggle == true
				&&	RegCustom._profile_username_p2 
				!=	CID3._group_username_input[i].text) 
				{
					RegCustom._profile_username_p2 = CID3._group_username_input[i].text;
				}
			}
		}
		
		if (Reg._buttonCodeValues == "")
		{
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
		}
		
		for (i in 0... CID3._user_account_row)
		{
			if (ActionInput.justPressed() == true
			&&  FlxG.mouse.x > CID3._group_username_input[i].x
			&&  FlxG.mouse.x < CID3._group_username_input[i].x + CID3._group_username_input[i].width
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > CID3._group_username_input[i].y
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < CID3._group_username_input[i].y + CID3._group_username_input[i].height
			&&  FlxG.mouse.y < FlxG.height - 50)
			{
				CID3._group_username_input[i].hasFocus = true;
				CID3._group_username_input[i].fieldBorderColor = FlxColor.BLUE;	
				CID3._group_username_input[i].fieldBorderThickness = 3;
				
				CID3._group_password_input[i].hasFocus = false;
				CID3._group_email_address_input[i].hasFocus = false;
				
				CID3._group_password_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLACK;
				
				CID3._group_password_input[i].fieldBorderThickness = 1;
				CID3._group_email_address_input[i].fieldBorderThickness = 1;
				
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&  Reg2._scrollable_area_is_scrolling == false)
					FlxG.sound.play("click", 1, false);
				
				#if mobile
					RegTriggers._keyboard_open = true;
				#end
				
				CID3._CRN = i;
			}
			
			if (ActionInput.justPressed() == true
			&&  FlxG.mouse.x > CID3._group_password_input[i].x
			&&  FlxG.mouse.x < CID3._group_password_input[i].x + CID3._group_password_input[i].width
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > CID3._group_password_input[i].y
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < CID3._group_password_input[i].y + CID3._group_password_input[i].height
			&&  FlxG.mouse.y < FlxG.height - 50)
			{
				CID3._group_password_input[i].hasFocus = true;
				CID3._group_password_input[i].fieldBorderColor = FlxColor.BLUE;	
				CID3._group_password_input[i].fieldBorderThickness = 3;
				
				CID3._group_username_input[i].hasFocus = false;
				CID3._group_email_address_input[i].hasFocus = false;
				
				CID3._group_username_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLACK;
				
				CID3._group_username_input[i].fieldBorderThickness = 1;
				CID3._group_email_address_input[i].fieldBorderThickness = 1;
				
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&  Reg2._scrollable_area_is_scrolling == false
				&&	CID3._password_input.active == true)
					FlxG.sound.play("click", 1, false);
								
				#if mobile
					RegTriggers._keyboard_open = true;
				#end
				
				CID3._CRN = i;
			}
			
			if (ActionInput.justPressed() == true
			&&  FlxG.mouse.x > CID3._group_email_address_input[i].x
			&&  FlxG.mouse.x < CID3._group_email_address_input[i].x + CID3._group_email_address_input[i].width
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > CID3._group_email_address_input[i].y
			&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < CID3._group_email_address_input[i].y + CID3._group_email_address_input[i].height
			&&  FlxG.mouse.y < FlxG.height - 50)
			{
				CID3._group_email_address_input[i].hasFocus = true;
				CID3._group_email_address_input[i].fieldBorderColor = FlxColor.BLUE;	
				CID3._group_email_address_input[i].fieldBorderThickness = 3;
				
				CID3._group_username_input[i].hasFocus = false;
				CID3._group_password_input[i].hasFocus = false;
				
				CID3._group_username_input[i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_password_input[i].fieldBorderColor = FlxColor.BLACK;
				
				CID3._group_username_input[i].fieldBorderThickness = 1;
				CID3._group_password_input[i].fieldBorderThickness = 1;
				
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&  Reg2._scrollable_area_is_scrolling == false
				&&	CID3._email_address_input.active == true)
					FlxG.sound.play("click", 1, false);
								
				#if mobile
					RegTriggers._keyboard_open = true;
				#end
				
				CID3._CRN = i;
			}
			
			// update get 18 more username suggestions everytime a key at username input object is pressed.
			CID3._group_username_input[i].callback = function (text, action)
			{
				if (text != "") 
				{
					#if username_suggestions
						Usernames.repopulate_username_suggestions();
					#end
				}
			}
		}		

	}	
	
	override public function destroy():Void
	{
		if (CID3._button_p1 != null)
		{
			CID3._group.remove(CID3._button_p1);
			CID3._button_p1.destroy();
			CID3._button_p1 = null;
		}
		
		if (CID3._button_p2 != null)
		{	
			CID3._group.remove(CID3._button_p2);
			CID3._button_p2.destroy();
			CID3._button_p2 = null;
		}
		
		if (CID3._profile_general_instructions != null)
		{	
			CID3._group.remove(CID3._profile_general_instructions);
			CID3._profile_general_instructions.destroy();
			CID3._profile_general_instructions = null;
		}
		
		if (CID3._text_username != null)
		{			
			CID3._group.remove(CID3._text_username);
			CID3._text_username.destroy();
			CID3._text_username = null;
		}
		
		if (CID3._username_input != null)
		{		
			CID3._group.remove(CID3._username_input);
			CID3._username_input.destroy();
			CID3._username_input = null;
		}
		
		if (CID3._text_password != null)
		{
			CID3._group.remove(CID3._text_password);
			CID3._text_password.destroy();
			CID3._text_password = null;
		}
		
		if (CID3._password_input != null)
		{
			CID3._group.remove(CID3._password_input);
			CID3._password_input.destroy();
			CID3._password_input = null;
		}
		
		if (CID3._text_email_address != null)
		{
			CID3._group.remove(CID3._text_email_address);
			CID3._text_email_address.destroy();
			CID3._text_email_address = null;
		}
		
		if (CID3._email_address_input != null)
		{
			CID3._group.remove(CID3._email_address_input);
			CID3._email_address_input.destroy();
			CID3._email_address_input = null;
		}
		
		if (CID3._text_empty != null)
		{
			CID3._group.remove(CID3._text_empty);
			CID3._text_empty.destroy();
			CID3._text_empty = null;
		}
		
		if (CID3._question_email_address_validation_code_enabled != null)
		{
			CID3._group.remove(CID3._question_email_address_validation_code_enabled);
			CID3._question_email_address_validation_code_enabled.destroy();
			CID3._question_email_address_validation_code_enabled = null;
		}
		
		if (CID3._button_email_address_validation_code_enabled != null)
		{
			CID3._group.remove(CID3._button_email_address_validation_code_enabled);
			CID3._button_email_address_validation_code_enabled.destroy();
			CID3._button_email_address_validation_code_enabled = null;
		}
		
		if (CID3._sprite_user_account != null)
		{
			CID3._group.remove(CID3._sprite_user_account);
			CID3._sprite_user_account.destroy();
			CID3._sprite_user_account = null;
		}
		
		if (CID3._default_flag_background != null)
		{
			CID3._group.remove(CID3._default_flag_background);
			CID3._default_flag_background.destroy();
			CID3._default_flag_background = null;
		}
		
		if (CID3._group != null)
		{	
			CID3._group.remove(CID3._group);
			CID3._group.destroy();
			CID3._group = null;
		}
		
	}	
	

	override public function update(elapsed:Float):Void
	{
		user_input();
		super.update(elapsed);		
	}
}//