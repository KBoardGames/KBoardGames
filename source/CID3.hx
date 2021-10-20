/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General public License for more details.

    You should have received a copy of the GNU General public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * Configuration Identifiers 3 for profile button.
 * all button, text and variable for all configuration class are here.
 * @author kboardgames.com
 */
class CID3 extends FlxGroup
{
	
	public static var _offset_x:Int = -50;
	public static var _offset_y:Int = 50;
	public static var _offset:Int = 30;	
	
	/******************************
	 * space between rows.
	 */
	public static var _offset_button_y:Int = 30;
	
	/******************************
	 * when this button is pressed, at the avatar scene, name field and profile avatar changes to display player 1's data.
	 */
	public static var _button_p1:ButtonToggleFlxState;
	public static var _button_p2:ButtonToggleFlxState;
	
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
		
	/******************************
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public static var _group:FlxSpriteGroup;
	
	/******************************
	 * profile button.
	 * value starts at 0. access members here. for regular buttons.
	 */
	public static var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	/******************************
	 * profile button.
	 * value starts at 0. access members here. for toggle buttons.
	 */
	public static var _group_button_toggle:Array<ButtonToggleFlxState> = [];
	
	/******************************
	 * profile instructions at top of scene.
	 */
	public static var _profile_general_instructions:FlxText;
	
	/******************************
	 * type in the login username.
	 */
	public static var _usernameInput:FlxInputText;
	
	public static var _profile_avatar_notice:FlxText; // the text for this ui is from the _text_current_avatar_for_player var.
	
	public static var _text_username:FlxText;
	public static var _text_username_suggestions:FlxText;
	public static var _text_title_avatar:FlxText;
	public static var _avatar_notice:FlxText;
	
	public static var _question_username_suggestions_enabled:TextGeneral;
	public static var _button_username_suggestions_enabled:ButtonGeneralNetworkNo;
	
	/******************************
	 * this var changed as the player 1 and player 2 buttons are toggled.
	 */
	public static var _text_current_avatar_for_player:String = "This is the current avatar for player ";
	
	public static var __configurations_output:ConfigurationOutput;
	
	/******************************
	 * needed to move the cursor of the inputText because a var can get the value of a caret but cannot for some reason set the value to the caret index.
	 */
	public static var _caretIndex:Int = 0;
	
	/******************************
	 * text displaying suggested usernames for the username input object.
	 */
	public static var _button_username_suggestions:Array<ButtonToggleFlxState> = []; 
}