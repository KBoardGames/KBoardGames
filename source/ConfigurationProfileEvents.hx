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
		if (RegCustom._sound_enabled[Reg._tn] == true
		&&  Reg2._scrollable_area_is_scrolling == false)
			FlxG.sound.play("click", 1, false);
		
		#if avatars
			Avatars._profile_avatar_notice.text = Avatars._text_current_avatar_for_player + "1";
		#end
		
		if (RegCustom._profile_username_p1[Reg._tn] == "") RegCustom._profile_username_p1[Reg._tn] = "Guest1";
		
		if (CID3._button_p1.has_toggle == false)
			CID3._usernameInput.text = RegCustom._profile_username_p1[Reg._tn];
		
		#if avatars
			Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1[Reg._tn]);
		#end
		
		CID3._button_p1.set_toggled(true);
		CID3._button_p1.has_toggle = true;
		
		CID3._button_p2.set_toggled(false);
		CID3._button_p2.has_toggle = false;
		
		#if username_suggestions 
			Usernames.repopulate_username_suggestions();
		#end
		
		CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
	}
	
	/*****************************
	 *  button used to change username and profile image to player 2.
	 */
	public function buttonP2():Void
	{
		if (RegCustom._sound_enabled[Reg._tn] == true
		&&  Reg2._scrollable_area_is_scrolling == false)
			FlxG.sound.play("click", 1, false);
	
		#if avatars
			Avatars._profile_avatar_notice.text = Avatars._text_current_avatar_for_player + "2";
		#end
		
		if (RegCustom._profile_username_p2[Reg._tn] == "") RegCustom._profile_username_p2[Reg._tn] = "Guest2";
		
		if (CID3._button_p2.has_toggle == false)
			CID3._usernameInput.text = RegCustom._profile_username_p2[Reg._tn];
				
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
		
		CID3._usernameInput.caretIndex = CID3._usernameInput.text.length;
	}
	
	public function username_suggestions_enabled():Void
	{
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