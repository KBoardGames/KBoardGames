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

package myLibs.avatars;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;

#if username_suggestions
	import myLibs.usernameSuggestions.Usernames;
#end

/**
 * @author kboardgames.com
 */
class Avatars
{
	/******************************
	 * this holds the avatars. value starts at 0. access members here.
	 */
	public static var _group_sprite:Array<FlxSprite> = [];
	
	/******************************
	 * this is the image of the avatar for profile.
	 */
	public static var _image_profile_avatar:FlxSprite;
	
	/******************************
	 * this image will highlight an avatar when a touch input (mouse, finger) is located at an avatar.
	 */
	public static var _image_avatar_highlighted:FlxSprite;
	
	public static var _profile_avatar_notice:FlxText; // the text for this ui is from the _text_current_avatar_for_player var.
	
	public static var _text_title_avatar:FlxText;
	public static var _avatar_notice:FlxText;
		
	/******************************
	 * this var changed as the player 1 and player 2 buttons are toggled.
	 */
	public static var _text_current_avatar_for_player:String = "This is the current avatar for player ";
	
	public static function avatars():Void
	{
		#if username_suggestions
			// place this text just underneath the username suggestions.
			_text_title_avatar = new FlxText(0, Usernames._question_username_suggestions_enabled.y + 100, 0, "Avatar");
		#else
			// place this text just underneath the username inputbox.
			_text_title_avatar = new FlxText(0, CID3._text_username.y + 75, 0, "Avatar");
		#end
		
		_text_title_avatar.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		
		#if username_suggestions
			if (RegCustom._username_suggestions_enabled[Reg._tn] == false)
			_text_title_avatar.y = Usernames._question_username_suggestions_enabled.y + 100;
		#end
		
		_text_title_avatar.screenCenter(X);
		_text_title_avatar.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_text_title_avatar);
		
		_profile_avatar_notice = new FlxText(15, 250, 0, _text_current_avatar_for_player + "1");
		_profile_avatar_notice.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_profile_avatar_notice.fieldWidth = FlxG.width - 90;
		_profile_avatar_notice.y = _text_title_avatar.y + 55;
		_profile_avatar_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_profile_avatar_notice);
		
		_image_profile_avatar = new FlxSprite(15, 300);
		_image_profile_avatar.loadGraphic("vendor/multiavatar/"+ RegCustom._profile_avatar_number1[Reg._tn]);
		_image_profile_avatar.y = _profile_avatar_notice.y + 50;
		CID3._group.add(_image_profile_avatar);		
		
		_avatar_notice = new FlxText(15, 0, 0, "Select an avatar that you would like to use while playing games in offline mode. That means you are not playing a game with players around the world. Select the avatar then click the save button to save that avatar to your offline profile. Selecting the first avatar will not hide that avatar when playing a game.");
		_avatar_notice.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_avatar_notice.fieldWidth = FlxG.width - 90;
		_avatar_notice.y = _image_profile_avatar.y + 100;
		_avatar_notice.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID3._group.add(_avatar_notice);
		
		// used to position the avatars on rows.
		var _y:Float = 0;
		var _x:Float = 0;
		
		for (i in 0... Reg._avatar_total)
		{			
			var _image_avatar = new FlxSprite(0, 0);
			_image_avatar.loadGraphic("vendor/multiavatar/"+ i +".png");
			_image_avatar.visible = false;
			CID3._group.add(_image_avatar);
			
			_group_sprite.push(_image_avatar);
			
			// this number refers to how many avatars on displayed on a row.
			if (_x > 10)
			{
				_y += 100; // when the amount of avatars on a row is reached then..
				_x = 0; // .. set x back to default and increase y so that the avatars will display on the next row.
			}
			
			_group_sprite[i].setPosition(150 + (102 * _x), _avatar_notice.y + _avatar_notice.height + 15 + _y + 2);
				
			_x += 1;	
			
			_group_sprite[i].visible = true;
			CID3._group.add(_group_sprite[i]);
		}
	}
	
	public static function avatar_highlight():Void
	{
		// when clicking on a game image, this image has a border that highlighted it.
		// all gameboards images are stored in frames.
		_image_avatar_highlighted = new FlxSprite(0, 0);
		_image_avatar_highlighted.setPosition(15, _avatar_notice.y + _avatar_notice.height + 15 + 2);
		_image_avatar_highlighted.loadGraphic("assets/images/avatarBorder.png", true, 75, 75); // height is the same value as width.
		_image_avatar_highlighted.animation.add("play", [0, 1], 10, true);
		_image_avatar_highlighted.animation.play("play");
		_image_avatar_highlighted.updateHitbox();
		CID3._group.add(_image_avatar_highlighted);
		
	}
}
