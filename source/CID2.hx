/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * Configuration Identifiers 2 for general button.
 * all button, text and variable for all configuration class are here.
 * @author kboardgames.com
 */
class CID2 extends FlxGroup
{
	/******************************
	 * general button.
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public static var _group:FlxSpriteGroup;	
	
	/******************************
	 * general button.
	 * value starts at 0. access members here. for regular buttons.
	 */
	public static var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	/******************************
	 * general button.
	 * value starts at 0. access members here. for toggle buttons.
	 */
	public static var _group_button_toggle:Array<ButtonToggleFlxState> = [];
	
	/******************************
	 * positions some elements so much to the left.
	 */
	public static var _offset_x:Int = -80;
	
	/******************************
	 * positions some elements so much to the right.
	 */
	public static var _offset_y:Int = 30;
	
	/******************************
	 * space between rows.
	 */
	public static var _offset_rows_y:Int = 30;
		
	/******************************
	 * this is the "Configuration Menu: " for the title text that a scene can add to. when clicking a button at the SceneMenu, the scene name will append to this var. for example, "Configuration Menu: Avatars.".
	 */
	public static var _text_for_title:String = "Configuration Menu: ";
	
	/******************************
	 * clicking this button called checkers will display the gameboard as it appeared when the configuration was saved. It no save was made then the gameboard will display the default colors and shades.
	 */
	public static var _button_default_colors_checkers:ButtonToggleFlxState;
	
	/******************************
	 * clicking this button called chess will display the gameboard as it appeared when the configuration was saved. It no save was made then the gameboard will display the default colors and shades.
	 */
	public static var _button_default_colors_chess:ButtonToggleFlxState;
	
	/******************************
	 * just a subtitle text that says "Gameboard Border Colors".
	 */
	public static var  _gameboard_border_title:FlxText;
	
	/******************************
	 * just a text that says "odd units". buttons in this category are the shade and the color buttons used to change the appearance of the odd units on the gameboard.
	 */
	public static var _text_title_odd_units:FlxText;
	
	/******************************
	 * just a text that says "even units". buttons in this category are the shade and the color buttons used to change the appearance of the even units on the gameboard.
	 */
	public static var _text_title_even_units:FlxText;
	
	/******************************
	 * shades of grayscale that can be applied to all odd gameboard units. this is the text "Shade" displayed beside the shade button.
	 */
	public static var _text_odd_units_shade:FlxText;
	
	/******************************
	 * shades of grayscale that can be applied to all even gameboard units. this is the text "Shade" displayed beside the shade button.
	 */
	public static var _text_even_units_shade:FlxText;
	
	/******************************
	 * color applied to a unit. this is the text "color" displayed beside the color button. clicking the color button will change the appearance of the gameboard units.
	 */
	public static var _text_odd_units_color:FlxText;
	
	/******************************
	 * color applied to a unit. this is the text "color" displayed beside the color button. clicking the color button will change the appearance of the gameboard units.
	 */
	public static var _text_even_units_color:FlxText;
	public static var _text_client_background_brightness:FlxText;
	public static var _text_client_background_saturation:FlxText;
	public static var _text_table_body_background_brightness:FlxText;
	public static var _text_table_body_background_saturation:FlxText;
	/******************************
	 * minus button for shade images of odd units. clicking this button will change the image of all odd units on the gameboard, displaying a different shade of grayscale.
	 */
	public static var _button_shade_odd_units_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * plus button for shade images of odd units. clicking this button will change the image of all odd units on the gameboard, displaying a different shade of grayscale.
	 */
	public static var	_button_shade_odd_units_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * minus button for shade images of even units. clicking this button will change the image of all odd units on the gameboard, displaying a different shade of grayscale.
	 */
	public static var _button_shade_even_units_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * plus button for shade images of even units. clicking this button will change the image of all odd units on the gameboard, displaying a different shade of grayscale.
	 */
	public static var	_button_shade_even_units_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * minus button to set a color of image to odd units. clicking this button will change the image of all odd units on the gameboard, displaying a different color.
	 */
	public static var _button_color_odd_units_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * plus button to set a color of image to odd units. clicking this button will change the image of all odd units on the gameboard, displaying a different color.
	 */
	public static var _button_color_odd_units_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * minus button to set a color of image to even units. clicking this button will change the image of all odd units on the gameboard, displaying a different color.
	 */
	public static var _button_color_even_units_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * plus button to set a color of image to even units. clicking this button will change the image of all odd units on the gameboard, displaying a different color.
	 */
	public static var _button_color_even_units_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * this is the shade image. different shades of grayscale. Color can then be played to this sprite.
	 */
	public static var _sprite_board_game_unit_odd:FlxSprite;
	
	/******************************
	 * this is the shade image. different shades of grayscale. Color can then be played to this sprite.
	 */
	public static var _sprite_board_game_unit_even:FlxSprite;
	
	/******************************
	 * this is the image of the border that parameters the gameboard.
	 */
	public static var _sprite_gameboard_border:FlxSprite;
	
	/******************************
	 * this is the image of the coordinates, for the chess and checker notations, that parameters the gameboard.
	 */
	public static var _sprite_gameboard_coordinates:FlxSprite;
	
	/******************************
	 * this is the background image of the client room.
	 */
	public static var _sprite_client_background_image:FlxSprite;
	public static var _sprite_gradient_background_image:FlxSprite;
	public static var _sprite_texture_background_image:FlxSprite;
	public static var _sprite_table_body_background_image:FlxSprite;
	
	/******************************
	 * sprite color representing the gameboard notation background color.
	 */
	public static var _sprite_notation_panel_background_color:FlxSprite;
	
	/******************************
	 * sprite color representing the gameboard notation text color.
	 */
	public static var _sprite_notation_panel_text_color:FlxSprite;
	public static var _sprite_client_topic_title_text_color:FlxSprite;
	public static var _sprite_client_text_color:FlxSprite;
	public static var _sprite_title_bar_text_color:FlxSprite;
	
	/******************************
	 * this shows the selected background color of the scene header title and footer menu if saved.
	 */
	public static var _sprite_title_bar_background_color:FlxSprite;
	public static var _text_title_bar_background_brightness:FlxText;
	public static var _sprite_menu_bar_background_color:FlxSprite;
	public static var _text_menu_bar_background_brightness:FlxText;
	
	/******************************
	 * this changes the gradient background image of the game room.
	 */
	public static var _button_gradient_texture_background_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * this changes the gradient background image of the game room.
	 */
	public static var	_button_gradient_texture_background_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * this changes the background image of the game room.
	 */
	public static var _button_client_background_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * this changes the background image of the game room.
	 */
	public static var	_button_client_background_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * capturing units are all units highlighted that the piece can move to.
	 */
	public static var _sprite_capturing_units:FlxSprite;	
	public static var _sprite_chess_path_to_king_bg:FlxSprite; // border.
	
	/******************************
	 * color referring to a gameboard unit that can be captured. step 1 backwards in the color list.
	 */
	public static var _button_capturing_units_change_color_minus:ButtonGeneralNetworkNo;
	
	/******************************
	 * color referring to a gameboard unit that can be captured. step 1 forward in the color list.
	 */
	public static var	_button_capturing_units_change_color_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * display a question about enabling the leaderboard,
	 */
	public static var _question_leaderboard_enabled:FlxText;
	public static var _question_gameboard_coordinates_enabled:TextGeneral;
	public static var _question_notation_panel_enabled:TextGeneral;
	public static var _question_background_alpha_enabled:TextGeneral;
	public static var _question_gameboard_border_enabled:TextGeneral;
	public static var _question_notation_panel_40_percent_alpha_enabled:TextGeneral;
	public static var _question_notation_panel_same_background_color:TextGeneral;
	public static var _question_notation_panel_background_color:TextGeneral;
	public static var _question_notation_panel_text_color_number:TextGeneral;
	public static var _question_client_topic_title_text_color_number:TextGeneral;
	public static var _question_client_text_color_number:TextGeneral;
	public static var _question_title_bar_text_color_number:TextGeneral;
	public static var _question_gradient_background_enabled:TextGeneral;
	public static var _question_client_background_brightness:TextGeneral;
	public static var _question_client_background_saturation:TextGeneral;
	public static var _question_table_body_background:TextGeneral;
	public static var _question_table_body_background_brightness:TextGeneral;
	public static var _question_table_body_background_saturation:TextGeneral;
	public static var _question_goto_title:TextGeneral;
	public static var _question_start_game_request:TextGeneral;
	public static var _question_start_game_offline_confirmation:TextGeneral;
	public static var _question_accept_start_game_request:TextGeneral;
	public static var _question_to_lobby_waiting_room_confirmation:TextGeneral;
	public static var _question_to_game_room_from_waiting_room:TextGeneral;
	public static var _question_to_lobby_game_room_confirmation:TextGeneral;
	public static var _question_to_title_from_game_room:TextGeneral;
	public static var _question_chat_turn_off_for_lobby:TextGeneral;
	public static var _question_move_timer_enabled:TextGeneral;
	public static var _question_move_total_enabled:TextGeneral;
	public static var _question_capturing_units_enabled:TextGeneral;
	public static var _question_button_colors:TextGeneral;
	public static var _question_music_enabled:TextGeneral;
	public static var _question_title_bar_background_number:TextGeneral;
	public static var _question_title_bar_background_brightness:TextGeneral;
	public static var _question_menu_bar_background_number:TextGeneral;
	public static var _question_menu_bar_background_brightness:TextGeneral;
	public static var _question_sound_enabled:TextGeneral;
	
	public static var _text_empty:ButtonGeneralNetworkNo;
	public static var _question_pager_enabled:TextGeneral;
	
	/******************************
	 * button used to toggle on and off the display of the leaderboard.
	 */
	public static var _button_leaderboard_enabled:ButtonGeneralNetworkNo;
	
	/******************************
	 * this is the "Output" text displayed beside the button that shows the example, a sample of, the button's fill, border and text color.
	 */
	public static var _question_button_colors_output:FlxText;
	
	/******************************
	 * display the question "Enable the house side game?"
	 */
	public static var _house_feature_question:FlxText;
	
	public static var _button_house_feature_enabled:ButtonGeneralNetworkNo;
	public static var _button_goto_title_enabled:ButtonGeneralNetworkNo;
	public static var _button_gameboard_border_minus:ButtonGeneralNetworkNo;
	public static var _button_gameboard_border_plus:ButtonGeneralNetworkNo;
	public static var _button_gameboard_border_enabled:ButtonGeneralNetworkNo;
	public static var _button_gameboard_coordinates_enabled:ButtonGeneralNetworkNo;
	public static var _button_send_automatic_start_game_request:ButtonGeneralNetworkNo;
	public static var _button_start_game_offline_confirmation:ButtonGeneralNetworkNo;
	public static var _button_accept_automatic_start_game_request:ButtonGeneralNetworkNo;
	public static var _button_to_lobby_waiting_room_confirmation:ButtonGeneralNetworkNo;
	public static var _button_to_lobby_game_room_confirmation:ButtonGeneralNetworkNo;
	public static var _button_to_game_room_from_waiting_room:ButtonGeneralNetworkNo;
	public static var _button_to_title_from_game_room:ButtonGeneralNetworkNo;
	public static var _button_chat_turn_off_for_lobby:ButtonGeneralNetworkNo;
	public static var _button_chat_turn_off_when_in_room:ButtonGeneralNetworkNo;
	public static var _button_move_timer_enabled:ButtonGeneralNetworkNo;
	public static var _button_move_total_enabled:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_enabled:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_40_percent_alpha_enabled:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_same_background_color_enabled:ButtonGeneralNetworkNo;
	
	public static var _button_notation_panel_background_color_enabled:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_background_color_number_minus:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_background_color_number_plus:ButtonGeneralNetworkNo;	
	public static var _button_notation_panel_text_color_number_minus:ButtonGeneralNetworkNo;
	public static var _button_notation_panel_text_color_number_plus:ButtonGeneralNetworkNo;
	public static var _button_client_topic_title_text_color_number_minus:ButtonGeneralNetworkNo;
	public static var _button_client_topic_title_text_color_number_plus:ButtonGeneralNetworkNo;
	public static var _button_client_text_color_number_minus:ButtonGeneralNetworkNo;
	public static var _button_client_text_color_number_plus:ButtonGeneralNetworkNo;
	public static var _button_title_bar_text_color_number_minus:ButtonGeneralNetworkNo;
	public static var _button_title_bar_text_color_number_plus:ButtonGeneralNetworkNo;
	public static var _button_gameboard_even_units_show_enabled:ButtonGeneralNetworkNo;
	public static var _button_gradient_texture_background_enabled:ButtonGeneralNetworkNo;
	public static var _button_client_background_enabled:ButtonGeneralNetworkNo;	
	public static var _button_client_texture_background_enabled:ButtonGeneralNetworkNo;
	public static var _button_client_texture_background_plus:ButtonGeneralNetworkNo;
	public static var _button_client_texture_background_minus:ButtonGeneralNetworkNo;	
	public static var _button_background_alpha_enabled:ButtonGeneralNetworkNo;
	public static var _button_capturing_units:ButtonGeneralNetworkNo;
	public static var _button_client_background_saturation_minus:ButtonGeneralNetworkNo;
	public static var _button_client_background_saturation_plus:ButtonGeneralNetworkNo;
	public static var _button_client_background_brightness_minus:ButtonGeneralNetworkNo;
	public static var _button_client_background_brightness_plus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_number_minus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_number_plus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_brightness_number_minus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_brightness_number_plus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_saturation_number_minus:ButtonGeneralNetworkNo;
	public static var _button_table_body_background_saturation_number_plus:ButtonGeneralNetworkNo;
	public static var _button_color:ButtonGeneralNetworkNo;
	public static var _button_border_color:ButtonGeneralNetworkNo;
	public static var _button_text_color:ButtonGeneralNetworkNo;
	public static var _button_color_output:ButtonGeneralNetworkNo;
	public static var _button_music_enabled:ButtonGeneralNetworkNo;
	public static var _button_sound_enabled:ButtonGeneralNetworkNo;
	public static var _button_title_bar_background_number_minus:ButtonGeneralNetworkNo;
	public static var _button_title_bar_background_number_plus:ButtonGeneralNetworkNo;
	public static var _button_title_bar_background_brightness_minus:ButtonGeneralNetworkNo;
	public static var _button_title_bar_background_brightness_plus:ButtonGeneralNetworkNo;
	public static var _button_menu_bar_background_number_minus:ButtonGeneralNetworkNo;
	public static var _button_menu_bar_background_number_plus:ButtonGeneralNetworkNo;
	public static var _button_menu_bar_background_brightness_minus:ButtonGeneralNetworkNo;
	public static var _button_menu_bar_background_brightness_plus:ButtonGeneralNetworkNo;
	public static var _button_pager_enabled:ButtonGeneralNetworkNo;
	
	/******************************
	 * moves the button down,
	 */
	public static var _offset_button_y:Int = 15;
	
	override public function destroy():Void
	{
		super.destroy();		
	}
}