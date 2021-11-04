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

#if avatars
	import myLibs.avatars.Avatars;
#end

#if flags
	import myLibs.worldFlags.WorldFlags;
#end

#if username_suggestions
	import myLibs.usernameSuggestions.Usernames;
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
		username_input();
		
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
	}
		
	private function sceneProfile():Void
	{
		var _text_topic_title_player = new FlxText(0, 100, 0, "Player username and avatar");
		_text_topic_title_player.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_text_topic_title_player.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_topic_title_player.screenCenter(X);
		CID3._group.add(_text_topic_title_player);
		
		CID3._profile_general_instructions = new FlxText(15, 0, 0, "1: Select either player 1 or player 2 button below.\n2: Type in a username. If you want to play online then use the username you signed up with at the website forum.\n3: Select an avatar you would like to use while playing a game.");
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
	
	private function username_input():Void
	{
		CID3._text_username = new FlxText(15, 0, 0, "Username");
		CID3._text_username.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
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
	
	// next feature placed here should check if username suggestions, avatar or world flags lib is set. if exists then new feature y value must use CID3._text_username.y, CID3._text_username.y_question_username_suggestions_enabled.y or _group_sprite[299].y
	
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
		#if username_suggestions
			switch (_num)
			{
				case 0: CID3._usernameInput.text = Usernames._button_username_suggestions[0].label.text;
				case 1: CID3._usernameInput.text = Usernames._button_username_suggestions[1].label.text;
				case 2: CID3._usernameInput.text = Usernames._button_username_suggestions[2].label.text;
				case 3: CID3._usernameInput.text = Usernames._button_username_suggestions[3].label.text;
				case 4: CID3._usernameInput.text = Usernames._button_username_suggestions[4].label.text;
				case 5: CID3._usernameInput.text = Usernames._button_username_suggestions[5].label.text;
				case 6: CID3._usernameInput.text = Usernames._button_username_suggestions[6].label.text;
				case 7: CID3._usernameInput.text = Usernames._button_username_suggestions[7].label.text;
				case 8: CID3._usernameInput.text = Usernames._button_username_suggestions[8].label.text;
				case 9: CID3._usernameInput.text = Usernames._button_username_suggestions[9].label.text;
				case 10: CID3._usernameInput.text = Usernames._button_username_suggestions[10].label.text;
				case 11: CID3._usernameInput.text = Usernames._button_username_suggestions[11].label.text;
				case 12: CID3._usernameInput.text = Usernames._button_username_suggestions[12].label.text;
				case 13: CID3._usernameInput.text = Usernames._button_username_suggestions[13].label.text;
				case 14: CID3._usernameInput.text = Usernames._button_username_suggestions[14].label.text;
				case 15: CID3._usernameInput.text = Usernames._button_username_suggestions[15].label.text;
				case 16: CID3._usernameInput.text = Usernames._button_username_suggestions[16].label.text;
				case 17: CID3._usernameInput.text = Usernames._button_username_suggestions[17].label.text;
			}
			
			Usernames.repopulate_username_suggestions();
			CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
		#end
	}
	
	override public function destroy():Void
	{
		if (CID3._text_empty != null)
		{
			remove(CID3._text_empty);
			CID3._text_empty.destroy();
			CID3._text_empty = null; // null is needed here.
		}
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
		#if avatars
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
		#end
		
		#if flags
			if (CID3._group.visible == true
			&&  RegTriggers._keyboard_opened == false)
			{
				for (i in 0... WorldFlags._flags_abbv_name.length)
				{
					WorldFlags._group_flag_highlight_sprite[i].visible = false;
					
					if (FlxG.mouse.x > WorldFlags._group_flag_sprites[i].x
					&&  FlxG.mouse.x < WorldFlags._group_flag_sprites[i].x + WorldFlags._flags_width[i]
					&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y > WorldFlags._group_flag_sprites[i].y
					&&  FlxG.mouse.y + __configurations_output.__scrollable_area.scroll.y < WorldFlags._group_flag_sprites[i].y + 40
					&&  FlxG.mouse.y < FlxG.height - 50)
					{					
						// Avatars._image_avatar_highlighted.x = WorldFlags._group_flag_sprites[i].x;
						// Avatars._image_avatar_highlighted.y = WorldFlags._group_flag_sprites[i].y;
						
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
								
							WorldFlags._image_selected_world_flag.loadGraphic("myLibs/worldFlags/assets/images/" + WorldFlags._flags_abbv_name[RegCustom._world_flags_number[Reg._tn]].toLowerCase() + ".png");
						}
					} 
				}
			}
		
		_ticks += 1; if (_ticks >= 15) _ticks = 5;
		#end
		
		
		
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
				#if username_suggestions
					Usernames.repopulate_username_suggestions();
				#end
				
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
				#if username_suggestions
					Usernames.repopulate_username_suggestions();
				#end
			}
		}
	}
}//