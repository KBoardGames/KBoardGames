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
 * these are all the Reg for saving/loading user configurations at the gear icon accessed from the title scene.
 * call this function only from MenuState. these vars must not be reset when doing a restart game. using resetRegVars() with this function will reset everything back to default.
 * @author kboardgames.com
 */
class RegCustom
{
	//#############################
	// THEME VARS ARE BELOW THIS LINE.
	//#############################	
	/******************************
	 * name of the theme on hard drive. excluding file extension.
	 */
	public static var _theme_name:Array<String> = [];
	
	/******************************
	 * the current theme name is use. the theme with this name will be used when client loads.
	 */
	public static var _theme_name_current:String = "default.yaml";	
	
	/******************************
	 * 9 shades. this var refers to part of the spite name in use when changing the look of the game board. At MenuConfigurations when a button is clicked all odd units are changed to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _gameboard_units_odd_shade_number:Array<Array<Int>> = [[]];
	
	/******************************
	 * 9 shades. this var refers to part of the spite name in use when changing the look of the game board. At MenuConfigurations when a button is clicked all even units are changed to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _gameboard_units_even_shade_number:Array<Array<Int>> = [[]];
	
	/******************************
	 * 40 colors. this var refers to the color of the game board odd numbered units. At MenuConfigurations every time a button is pressed, this var increases in value to change the odd units to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _gameboard_units_odd_color_number:Array<Array<Int>> = [[]];
	
	/******************************
	 * 40 colors. this var refers to the color of the game board even numbered units. At MenuConfigurations every time a button is pressed, this var increases in value to change the even units to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _gameboard_units_even_color_number:Array<Array<Int>> = [[]];
		
	/******************************
	 * at MenuConfigurations this value is used to change the border image of the gameboard.
	 */
	public static var _gameboard_border_number:Array<Int> = [];
	
	/******************************
	 * this is an image of a border that surrounds the gameboard.
	 */
	public static var _gameboard_border_enabled:Array<Bool> = [];
	
	/******************************
	 * this is an image of numbers and letters on the gameboard used together in a notation to tell where a player moved to.
	 */
	public static var _gameboard_coordinates_enabled:Array<Bool> = [];
	
	/******************************
	 * apply a 10% alpha to the notation panel.
	 */
	public static var _notation_panel_10_percent_alpha_enabled:Array<Bool> = [];
	
	/******************************
	 * same background color as the game room?
	 */
	public static var _notation_panel_same_background_color_enabled:Array<Bool> = [];
	
	/******************************
	 * gameboard notation background color.
	 */
	public static var _notation_panel_background_color_number:Array<Int> = [];
	public static var _notation_panel_background_color_enabled:Array<Bool> = [];
	
	/******************************
	 * gameboard notation text color.
	 */
	public static var _notation_panel_text_color_number:Array<Int> = [];
		
	/******************************
	 * display gradient background image for game room.
	 */
	public static var _game_room_gradient_background_enabled:Array<Bool> = [];
	
	/******************************
	 * image number used to display the gradient background image for game room.
	 */
	public static var _game_room_gradient_background_image_number:Array<Int> = [];
	
	/******************************
	 * display static background image for game room.
	 */
	public static var _client_background_enabled:Array<Bool> = [];
	
	/******************************
	 * image number used to display the static background image for game room.
	 */
	public static var _client_background_image_number:Array<Int> = [];
	
	/******************************
	 * display an alpha to the gameboard gradient background if the background is enabled.
	 */
	public static var _game_room_gradient_background_alpha_enabled:Array<Bool> = [];
	
	/******************************
	 * show legal chess moves. display capturing units.
	 */
	public static var _show_capturing_units:Array<Bool> = [];
	
	/******************************
	 * used to change colors.
	 */
	public static var _show_capturing_units_number:Array<Int> = [];
	
	/******************************
	 * highlights the to and from units of the piece that was last moved.
	 */
	public static var _chess_show_last_piece_moved:Array<Bool> = [];
	
	/******************************
	 * The future capturing units feature show upcoming attacks to the king and is only available while playing against the computer with a chess skill level of beginner.
	 */
	public static var _chess_future_capturing_units_enabled:Array<Bool> = [];
	
	/******************************
	 * this number refers to the future capturing units image color.
	 */
	public static var _chess_future_capturing_units_number:Array<Int> = [];
		
	/******************************
	 * the path to king are units in a straight line showing where an attack on the king is coming from.
	 */
	public static var _chess_path_to_king_enabled:Array<Bool> = [];
	
	/******************************
	 * this number refers to the path to king image color.
	 */
	public static var _chess_path_to_king_number:Array<Int> = [];
	
	/******************************
	 * show even gameboard units at game room.
	 */
	public static var _gameboard_even_units_show_enabled:Array<Bool> = [];
	
	/******************************
	 * the current chess piece set for player 1.
	 */
	public static var _chess_set_for_player1:Array<Int> = [];
	
	/******************************
	 * the current chess piece set for player 2.
	 */
	public static var _chess_set_for_player2:Array<Int> = [];
	
	/******************************
	 * the color of the selected chess set for player 1.
	 */
	public static var _chess_set_for_player1_color_number:Array<Int> = [];
	
	/******************************
	 * the color of the selected chess set for player 2.
	 */
	public static var _chess_set_for_player2_color_number:Array<Int> = [];
	
	/******************************
	 * the brightness of the random background color of a scene when random background colors are used.
	 */
	public static var _background_brightness:Array<Float> = [];
	
	/******************************
	 * this is the color of the button, excluding the button's mouse over color and excluding the button's border.
	 */
	public static var _button_color:Array<FlxColor> = [];
	
	/******************************
	 * value used to change the button's image.
	 */
	public static var _button_color_number:Array<Int> = [];
	
	/******************************
	 * this is the color of the border that parameters the button graphic.
	 */
	public static var _button_border_color:Array<FlxColor> = [];
	
	/******************************
	 * value used to change the button's border image
	 */
	public static var _button_border_color_number:Array<Int> = [];
	
	/******************************
	 * static font color of the button.
	 */
	public static var _button_text_color:Array<FlxColor> = [];
	
	/******************************
	 * value used to change the button's text color.
	 */
	public static var _button_text_color_number:Array<Int> = [];
	
	/******************************
	 * use this var if you want to know if the leaderboard is enabled.
	 */
	public static var _leaderboard_enabled:Array<Bool> = [];
	
	/******************************
	 * toggle the house feature. a value of false will hide the house side game,
	 */
	public static var _house_feature_enabled:Array<Bool> = [];
	
	/******************************
	 * Go back to the title scene after the options are saved at the configuration menu.
	 */
	public static var _go_back_to_title_after_save:Array<Bool> = [];
	
	/******************************
	 * this is the offline mode profile avatar number that refers to an avatar image. player 1.
	 */
	public static var _profile_avatar_number1:Array<String> = [];
	
	/******************************
	 * this is the offline mode profile avatar number that refers to an avatar image. player 2 or BOT 1.
	 */
	public static var _profile_avatar_number2:Array<String> = [];
	
	/******************************
	 * Should host of the room automatically send a start game request to other player(s) after entering the game room?
	 *
	 */
	public static var _send_automatic_start_game_request:Array<Bool> = [];
	
	/******************************
	 * if host of the room automatically send a start game request and this var is true then this player will accept this request.
	 *
	 */
	public static var _accept_automatic_start_game_request:Array<Bool> = [];
	
	/******************************
	 * at waiting room show message box asking for confirmation to return to lobby.
	 */
	public static var _to_lobby_from_waiting_room_confirmation:Array<Bool> = [];
		
	/******************************
	 * at game room show message box asking for confirmation to return to lobby.
	 */
	public static var _to_lobby_from_game_room_confirmation:Array<Bool> = [];
	
	/******************************
	 * message box asking for confirmation to return to lobby.
	 */
	public static var _to_game_room_from_waiting_room_confirmation:Array<Bool> = [];
	
	/******************************
	 * message box asking for confirmation to return to title.
	 */
	public static var _to_title_from_game_room_confirmation:Array<Bool> = [];
		
	/******************************
	 * do you want to turn off the chat feature for lobby?
	 */
	public static var _chat_when_at_lobby_enabled:Array<Bool> = [];
	 
	/******************************
	 * do you want to turn off the chat feature when in a room?
	 */
	public static var _chat_when_at_room_enabled:Array<Bool> = [];
	
	/******************************
	 * Enable the player's piece move timer. Note: tournament play ignores this feature.
	 */
	public static var _timer_enabled:Array<Bool> = [];
	
	/******************************
	 * Display the player's piece move total text.
	 */
	public static var _move_total_enabled:Array<Bool> = [];
	
	/******************************
	 * Display the notation panel?
	 */
	public static var _notation_panel_enabled:Array<Bool> = [];
	
	/******************************
	 * Display the notation panel?
	 */
	public static var _start_game_offline_confirmation:Array<Bool> = [];
	
	/******************************
	 * chess opening moves text displayed at the top of the screen. See ChessEco.hx.
	 */
	public static var _chess_opening_moves_enabled:Array<Bool> = [];
	
	/******************************
	 * when playing against the computer and the computer is busy searching for a move, if this is enabled then a "Thinking..." message will display at the top of the screen.
	 */
	public static var _chess_computer_thinking_enabled:Array<Bool> = [];
	
	/******************************
	 * if true then all music will be enabled.
	 */
	public static var _music_enabled:Array<Bool> = [];
	
	/******************************
	 * if true then all sound will be enabled.
	 */
	public static var _sound_enabled:Array<Bool> = [];
	
	//#############################
	// NONE THEME VARS ARE BELOW THIS LINE.
	//#############################	
	
	public static var _profile_avatar_number3:Array<String> = [];
	public static var _profile_avatar_number4:Array<String> = [];
	
	/******************************
	 * offline username for player 1.
	 */
	public static var _profile_username_p1:Array<String> = [];
	public static var _profile_username_p2:Array<String> = [];
		 
	/******************************
	 * this is the maximum time permitted when assigning time for a game at the configuration scene. this var is used only at MenuConfigurationsGames.hx to change the timer values.
	 */
	public static var _timer_maximum_permitted_for_game:Array<Int> = []; 
	
	/******************************
	 * this is the minimum time permitted when assigning time for a game at the configuration scene. this var is used only at MenuConfigurationsGames.hx to change the timer values.
	 */
	public static var _timer_minimum_permitted_for_game:Array<Int> = []; 
	
	/******************************
	 * this is the current selected time permitted while playing a game. game is over when time reaches zero. this var is used at MenuConfigurationsGames.hx and at SceneGameRoom.hx as the current time remaining.
	 */
	public static var _time_remaining_for_game:Array<Array<Int>> = [[]]; 
	
	/******************************
	 * choose your chess skill level of either intermediate or advanced.
	 * 0:beginner, 1:intermediate or 2:advanced.
	 */
	public static var _chess_skill_level_online:Int = 0;
	
	/******************************
	 * choose your chess skill level of either intermediate or advanced.
	 * this var is used in offline play. when returning to the menuState, the var above, _chess_skill_level_online, is given this value because online play can change _chess_skill_level_online var. hence, online play can set the above var to a value of 2 and when returning to menuState, playing an offline game would be in advanced mode ignoring the _chess_skill_level_online setting at menuState.
	 * this var is not saved.
	 */
	public static var _chess_skill_level_offline:Int = 0;
	
	
	/******************************
	 * colored background displayed behind both the title and menu at most scenes.
	 */
	public static var _background_header_title_number:Array<Int> = [];
	public static var _background_footer_menu_number:Array<Int> = [];
	
	// these vars are reset at the start of each game.
	public static function resetRegVars():Void
	{
		_timer_enabled.push(true);
		_send_automatic_start_game_request.push(false);
		
		_timer_maximum_permitted_for_game = [55, 55, 55, 55, 55];
		_timer_minimum_permitted_for_game = [5, 5, 5, 5, 5];
	}
	
	/******************************
	 * these vars are reset here when returning to the mainMenu. These vars are not reset at menuState.
	 */
	public static function resetConfigurationVars():Void
	{
		_profile_username_p1.splice(0, _profile_username_p1.length);
		_profile_username_p1.push("Guest 1");
		_profile_username_p2.splice(0, _profile_username_p2.length);
		_profile_username_p2.push("Guest 2");

		resetConfigurationVars2();
	}
	
	/******************************
	 * these vars are reset here when returning to the mainMenu. These vars are not reset at menuState.
	 */
	public static function resetConfigurationVars2():Void
	{
		_theme_name.splice(0, _theme_name.length);
		
		_gameboard_units_odd_shade_number.splice(0, _gameboard_units_odd_shade_number.length);
		_gameboard_units_odd_shade_number.push([0]);
		_gameboard_units_odd_shade_number[0] = [7, 3];		
		
		_gameboard_units_even_shade_number.splice(0, _gameboard_units_even_shade_number.length);
		_gameboard_units_even_shade_number.push([0]);
		_gameboard_units_even_shade_number[0] = [9, 1];
		
		_gameboard_units_odd_color_number.splice(0, _gameboard_units_odd_color_number.length);
		_gameboard_units_odd_color_number.push([0]);
		_gameboard_units_odd_color_number[0] = [3, 13];		
		
		_gameboard_units_even_color_number.splice(0, _gameboard_units_even_color_number.length);
		_gameboard_units_even_color_number.push([0]);
		_gameboard_units_even_color_number[0] = [21, 8];		
		
		_gameboard_border_number.splice(0, _gameboard_border_number.length);
		_gameboard_border_number.push(5);		
		
		_gameboard_border_enabled.splice(0, _gameboard_border_enabled.length);
		_gameboard_border_enabled.push(true);		
		
		_gameboard_coordinates_enabled.splice(0, _gameboard_coordinates_enabled.length);
		_gameboard_coordinates_enabled.push(true);		
		
		_gameboard_even_units_show_enabled.splice(0, _gameboard_even_units_show_enabled.length);
		_gameboard_even_units_show_enabled.push(true);
		
		_game_room_gradient_background_enabled.splice(0, _game_room_gradient_background_enabled.length);
		_game_room_gradient_background_enabled.push(true);
		
		_game_room_gradient_background_image_number.splice(0, _game_room_gradient_background_image_number.length);
		_game_room_gradient_background_image_number.push(4);
		
		_client_background_enabled.splice(0, _client_background_enabled.length);
		_client_background_enabled.push(false);
		
		_client_background_image_number.splice(0, _client_background_image_number.length);
		_client_background_image_number.push(4);
		
		_game_room_gradient_background_alpha_enabled.splice(0, _game_room_gradient_background_alpha_enabled.length);
		_game_room_gradient_background_alpha_enabled.push(false);
		
		_show_capturing_units.splice(0, _show_capturing_units.length);
		_show_capturing_units.push(true);
		
		_show_capturing_units_number.splice(0, _show_capturing_units_number.length);
		_show_capturing_units_number.push(1);
		
		_chess_show_last_piece_moved.splice(0, _chess_show_last_piece_moved.length);
		_chess_show_last_piece_moved.push(true);
		
		_chess_future_capturing_units_enabled.splice(0, _chess_future_capturing_units_enabled.length);
		_chess_future_capturing_units_enabled.push(true);
		
		_chess_future_capturing_units_number.splice(0, _chess_future_capturing_units_number.length);
		_chess_future_capturing_units_number.push(2);
		
		_chess_path_to_king_enabled.splice(0, _chess_path_to_king_enabled.length);
		_chess_path_to_king_enabled.push(true);
		
		_chess_path_to_king_number.splice(0, _chess_path_to_king_number.length);
		_chess_path_to_king_number.push(1);
		
		_chess_set_for_player1.splice(0, _chess_set_for_player1.length);
		_chess_set_for_player1.push(2);
		
		_chess_set_for_player2.splice(0, _chess_set_for_player2.length);
		_chess_set_for_player2.push(2);
		
		_chess_set_for_player1_color_number.splice(0, _chess_set_for_player1_color_number.length);
		_chess_set_for_player1_color_number.push(1);
		
		_chess_set_for_player2_color_number.splice(0, _chess_set_for_player2_color_number.length);
		_chess_set_for_player2_color_number.push(25);
		
		_chess_opening_moves_enabled.splice(0, _chess_opening_moves_enabled.length);
		_chess_opening_moves_enabled.push(true);	
		
		_chess_computer_thinking_enabled.splice(0, _chess_computer_thinking_enabled.length);
		_chess_computer_thinking_enabled.push(true);
		
		_background_brightness.splice(0, _background_brightness.length);
		_background_brightness.push(0.45);
		
		_button_color_number.splice(0, _button_color_number.length);
		_button_color_number.push(16);
		
		_button_border_color_number.splice(0, _button_border_color_number.length);
		_button_border_color_number.push(1);
		
		_button_text_color_number.splice(0, _button_text_color_number.length);
		_button_text_color_number.push(1);
		
		RegCustom._button_color[0] = MenuConfigurationsGeneral.button_colors();
					
		RegCustom._button_border_color[0] = MenuConfigurationsGeneral.button_border_colors();
		
		RegCustom._button_text_color[0] = MenuConfigurationsGeneral.button_text_colors();
		
		_leaderboard_enabled.splice(0, _leaderboard_enabled.length);
		_leaderboard_enabled.push(false);
		
		_house_feature_enabled.splice(0, _house_feature_enabled.length);
		_house_feature_enabled.push(false);
		
		_go_back_to_title_after_save.splice(0, _go_back_to_title_after_save.length);
		_go_back_to_title_after_save.push(false);
		
		_notation_panel_10_percent_alpha_enabled.splice(0, _notation_panel_10_percent_alpha_enabled.length);
		_notation_panel_10_percent_alpha_enabled.push(true);
		
		_notation_panel_same_background_color_enabled.splice(0, _notation_panel_same_background_color_enabled.length);
		_notation_panel_same_background_color_enabled.push(false);
		
		_notation_panel_background_color_enabled.splice(0, _notation_panel_background_color_enabled.length);
		_notation_panel_background_color_enabled.push(false);
		
		_notation_panel_background_color_number.splice(0, _notation_panel_background_color_number.length);
		_notation_panel_background_color_number.push(1);
		
		_notation_panel_text_color_number.splice(0, _notation_panel_text_color_number.length);
		_notation_panel_text_color_number.push(1);
				
		_profile_avatar_number1.splice(0, _profile_avatar_number1.length);
		_profile_avatar_number1.push("0.png");
		
		_profile_avatar_number2.splice(0, _profile_avatar_number2.length);
		_profile_avatar_number2.push("0.png");
		
		_profile_avatar_number3.splice(0, _profile_avatar_number3.length);
		_profile_avatar_number3.push("0.png");
		
		_profile_avatar_number4.splice(0, _profile_avatar_number4.length);
		_profile_avatar_number4.push("0.png");
		
		_accept_automatic_start_game_request.splice(0, _accept_automatic_start_game_request.length);
		_accept_automatic_start_game_request.push(false);	
		
		_to_lobby_from_waiting_room_confirmation.splice(0, _to_lobby_from_waiting_room_confirmation.length);
		_to_lobby_from_waiting_room_confirmation.push(true);
		
		_to_lobby_from_game_room_confirmation.splice(0, _to_lobby_from_game_room_confirmation.length);
		_to_lobby_from_game_room_confirmation.push(true);
		
		_to_game_room_from_waiting_room_confirmation.splice(0, _to_game_room_from_waiting_room_confirmation.length);
		_to_game_room_from_waiting_room_confirmation.push(true);
		
		_to_title_from_game_room_confirmation.splice(0, _to_title_from_game_room_confirmation.length);
		_to_title_from_game_room_confirmation.push(true);
		
		_chat_when_at_lobby_enabled.splice(0, _chat_when_at_lobby_enabled.length);
		_chat_when_at_lobby_enabled.push(true);
		
		_chat_when_at_room_enabled.splice(0, _chat_when_at_room_enabled.length);
		_chat_when_at_room_enabled.push(true);
		
		_move_total_enabled.splice(0, _move_total_enabled.length);
		_move_total_enabled.push(true);
		
		_notation_panel_enabled.splice(0, _notation_panel_enabled.length);
		_notation_panel_enabled.push(true);
		
		_start_game_offline_confirmation.splice(0, _start_game_offline_confirmation.length);
		_start_game_offline_confirmation.push(false);
		
		_music_enabled.splice(0, _music_enabled.length);
		_music_enabled.push(true);
		
		_sound_enabled.splice(0, _sound_enabled.length);
		_sound_enabled.push(true);		
		
		_time_remaining_for_game.splice(0, _time_remaining_for_game.length);
		_time_remaining_for_game.push([0]);
		_time_remaining_for_game[0] = [15, 15, 15, 15, 30];
		
		_background_header_title_number.splice(0, _background_header_title_number.length);
		_background_header_title_number.push(1);
		
		_background_footer_menu_number.splice(0, _background_footer_menu_number.length);
		_background_footer_menu_number.push(1);

		#if html5
			return;
			
		#else
			var _directory = StringTools.replace(Path.directory(Sys.programPath()), "\\", "/") + "/themes/";
			
			// create the default theme in because there might be another theme already in the themes folder and without a default theme the client will crash because the Reg._tn of the default theme will not be zero.
			if (RegCustom._theme_name[0] == null)
			{
				if (sys.FileSystem.exists(_directory) == false) 
					sys.FileSystem.createDirectory(_directory);
								
				RegCustom._theme_name.push("default.yaml");
				
			}
			
			
		#end
		
	}
	
	/******************************
	 * after loading the theme, some elements need to be assigned a color from a number value. the reason is color value would not save to a file. instead a theme file would save 0xffffffff as a value. so, saving a number value was used instead of a color. this is the fix.
	 */
	public static function assign_colors():Void
	{
		RegCustom._button_color[Reg._tn] = MenuConfigurationsGeneral.button_colors();
					
		RegCustom._button_border_color[Reg._tn] = MenuConfigurationsGeneral.button_border_colors();
		
		RegCustom._button_text_color[Reg._tn] = MenuConfigurationsGeneral.button_text_colors();
	}
}