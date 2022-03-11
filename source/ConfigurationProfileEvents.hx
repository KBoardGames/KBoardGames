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

#if username_suggestions
	import modules.usernameSuggestions.Usernames;
#end

/**
 * these functions are called after a user clicks a button.
 * @author kboardgames.com
 */
class ConfigurationProfileEvents extends CID2
{
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
	}
	
	/*****************************
	 *  button used to change username and profile image to player 1.
	 */
	public function buttonP1():Void
	{
		if (Reg._at_input_keyboard == true) return;
		
		if (RegCustom._sound_enabled[Reg._tn] == true
		&&  Reg2._scrollable_area_is_scrolling == false)
			FlxG.sound.playMusic("click", 1, false);
		
		CID3._user_account_row = 5;
		CID3._sprite_user_account.visible = true;
		
		CID3._text_username.active = true;
		CID3._text_password.active = true;
		CID3._text_email_address.active = true;
		
		for (i in 0... CID3._user_account_row)
		{
			for (ii in 0... 3)
			{
				CID3._group_input_text_field[ii][i].active = true;
			}
		}
		
		CID3._text_username.visible = true;		
		CID3._text_password.visible = true;		
		CID3._text_email_address.visible = true;		
		
		for (i in 0... CID3._user_account_row)
		{
			for (ii in 0... 3)
			{
				CID3._group_input_text_field[ii][i].visible = true;
				
				// remove the red border from any input fields.
				CID3._group_input_text_field[ii][i].fieldBorderColor = FlxColor.BLACK;
				CID3._group_input_text_field[ii][i].fieldBorderThickness = 1;
				
				CID3._group_input_text_field[ii][i].hasFocus = false;
			}
			
			if (RegCustom._profile_username_p1[i] == "") RegCustom._profile_username_p1[i] = "Guest1";
			
			CID3._group_input_text_field[0][i].text = RegCustom._profile_username_p1[i];
			
		}
		
		#if avatars
			Avatars._profile_avatar_notice.text = Avatars._text_current_avatar_for_player + "1";

			Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1[Reg._tn]);
		#end
		
		CID3._button_p1.set_toggled(true);
		CID3._button_p1.has_toggle = true;
		
		CID3._button_p2.set_toggled(false);
		CID3._button_p2.has_toggle = false;
		
		#if username_suggestions 
			Usernames.repopulate_username_suggestions();
		#end
		
		CID3._username_input.caretIndex = CID3._username_input.text.length;
		
		CID3._group_input_text_field[0][CID3._CRN].text = RegCustom._profile_username_p1[CID3._CRN];
		
	}
	
	/*****************************
	 *  button used to change username and profile image to player 2.
	 */
	public function buttonP2():Void
	{
		if (Reg._at_input_keyboard == true) return;
		// remove the red border from any input fields.
		CID3._group_input_text_field[0][0].fieldBorderColor = FlxColor.BLACK;
		CID3._group_input_text_field[0][0].fieldBorderThickness = 1;
		CID3._group_input_text_field[0][0].hasFocus = false;
		
		CID3._group_input_text_field[1][0].fieldBorderColor = FlxColor.BLACK;
		CID3._group_input_text_field[2][0].fieldBorderColor = FlxColor.BLACK;
		CID3._text_password.visible = false;
		CID3._text_email_address.visible = false;
		
		CID3._group_input_text_field[1][0].visible = false;
		CID3._group_input_text_field[2][0].visible = false;
		
		CID3._group_input_text_field[1][0].active = false;
		CID3._group_input_text_field[2][0].active = false;		
		
		CID3._sprite_user_account.visible = false;		
		
		for (i in 1... CID3._user_account_row)
		{
			for (ii in 0... 3)
			{
				CID3._group_input_text_field[ii][i].visible = false;
			}
		}
		
		CID3._text_password.active = false;
		CID3._text_email_address.active = false;
		
		for (i in 1... CID3._user_account_row)
		{
			for (ii in 0... 3)
			{
				CID3._group_input_text_field[ii][i].active = false;
			}
		}
		
		CID3._user_account_row = 1; // keep this here.
		
		#if avatars
			Avatars._profile_avatar_notice.text = Avatars._text_current_avatar_for_player + "2";
		#end
		
		if (RegCustom._profile_username_p2 == "") RegCustom._profile_username_p2 = "Guest2";
		
		if (CID3._button_p2.has_toggle == false)
			CID3._group_input_text_field[0][0].text = RegCustom._profile_username_p2;
				
		#if avatars
			Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number2[Reg._tn]);
		#end
		
		CID3._button_p2.set_toggled(true);
		CID3._button_p2.has_toggle = true;
		
		CID3._button_p1.set_toggled(false);
		CID3._button_p1.has_toggle = false;
		
		#if username_suggestions
			Usernames.repopulate_username_suggestions();
		#end
		
		CID3._username_input.caretIndex = CID3._username_input.text.length;
		
		CID3._group_input_text_field[0][0].text = RegCustom._profile_username_p2;
		
	}
	
	public function send_email_address_validation_code_enabled():Void
	{
		if (Reg._at_input_keyboard == true) return;
		
		#if username_suggestions
			if (RegCustom._send_email_address_validation_code == false)
			{
				RegCustom._send_email_address_validation_code = true;
				CID3._button_email_address_validation_code_enabled.label.text = "true";
			}
			else
			{
				RegCustom._send_email_address_validation_code = false;
				CID3._button_email_address_validation_code_enabled.label.text = "false";
			}
		#end
	}
	
	public function username_suggestions_enabled():Void
	{
		if (Reg._at_input_keyboard == true) return;
		
		#if username_suggestions
			if (RegCustom._username_suggestions_enabled[Reg._tn] == false)
			{
				RegCustom._username_suggestions_enabled[Reg._tn] = true;
				Usernames._button_username_suggestions_enabled.label.text = "true";
			}
			else
			{
				RegCustom._username_suggestions_enabled[Reg._tn] = false;
				Usernames._button_username_suggestions_enabled.label.text = "false";
			}
		#end
	}
}