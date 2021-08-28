package;

/**
 * these are all the Reg for saving/loading user configurations at the gear icon accessed from the title scene.
 * @author kboardgames.com
 */
class RegCustom
{
	/******************************
	 * this var refers to part of the spite name in use when changing the look of the game board. At MenuConfigurations when a button is clicked all odd units are changed to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _units_odd_spr_num:Array<Int> = [1, 1];
	
	/******************************
	 * this var refers to part of the spite name in use when changing the look of the game board. At MenuConfigurations when a button is clicked all even units are changed to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _units_even_spr_num:Array<Int> = [1, 1];
	
	/******************************
	 * this var refers to the color of the game board odd numbered units. At MenuConfigurations every time a button is pressed, this var increases in value to change the odd units to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _units_odd_color_num:Array<Int> = [0, 0];
	
	/******************************
	 * this var refers to the color of the game board even numbered units. At MenuConfigurations every time a button is pressed, this var increases in value to change the even units to a different color. This var is loaded at SceneGameRoom to display the game board.
	 */
	public static var _units_even_color_num:Array<Int> = [0, 0];
	
	/******************************
	 * call this function only from MenuState. these vars must not be reset when doing a restart game. using resetRegVars() with this function will reset everything back to default.
	 */
	
	/******************************
	 * at MenuConfigurations this value is used to change the border image of the gameboard.
	 */
	public static var _gameboardBorder_num:Int = 1;
	
	/******************************
	 * this is an image of a border that surrounds the gameboard.
	 */
	public static var _gameboard_border_enabled:Bool;
	
	/******************************
	 * this is an image of numbers and letters on the gameboard used together in a notation to tell where a player moved to.
	 */
	public static var _gameboard_coordinates_enabled:Bool;
	
	/******************************
	 * use this var if you want to know if the leaderboard is enabled.
	 */
	public static var _config_leaderboard_enabled:Bool = false;
	
	/******************************
	 * toggle the house feature. a value of false will hide the house side game,
	 */
	public static var _config_house_feature_enabled:Bool = true;
	
	/******************************
	 * Go back to the title scene after the options are saved at the configuration menu.
	 */
	public static var _config_save_goto_lobby_enabled:Bool = true;
	
	/******************************
	 * this is the offline mode profile avatar number that refers to an avatar image.
	 */
	public static var _profile_avatar_number1:String = "0.png";
	public static var _profile_avatar_number2:String = "0.png"; // player 2 or BOT 1.
	public static var _profile_avatar_number3:String = "0.png";
	public static var _profile_avatar_number4:String = "0.png";
	
	/******************************
	 * offline username for player 1.
	 */
	public static var _profile_username_p1:String = "";
	public static var _profile_username_p2:String = "";
		 
	/******************************
	 * Should host of the room automatically send a start game request to other player(s) after entering the game room?
	 *
	 */
	public static var _send_automatic_start_game_request:Bool = false;
	
	/******************************
	 * if host of the room automatically send a start game request and this var is true then this player will accept this request.
	 *
	 */
	public static var _accept_automatic_start_game_request:Bool = false;
	
	/******************************
	 * this is the maximum time permitted while playing a game. game is over when time reaches zero.
	 */
	public static var _move_time_remaining_maximum:Array<Int> = []; 
	
	/******************************
	 * this is the minimum time permitted while playing a game. game is over when time reaches zero.
	 */
	public static var _move_time_remaining_minimum:Array<Int> = []; 
	
	/******************************
	 * this is the current selected time permitted while playing a game. game is over when time reaches zero.
	 */
	public static var _move_time_remaining_current:Array<Int> = []; 
	
	/******************************
	 * choose your chess skill level of either intermediate or advanced.
	 * 0:beginner, 1:intermediate or 2:advanced.
	 */
	public static var _game_skill_level_chess:Int = 0;
	
	/******************************
	 * choose your chess skill level of either intermediate or advanced.
	 * this var is used in offline play. when returning to the menuState, the var above, _game_skill_level_chess, is given this value because online play can change _game_skill_level_chess var. hence, online play can set the above var to a value of 2 and when returning to menuState, playing an offline game would be in advanced mode ignoring the _game_skill_level_chess setting at menuState.
	 * this var is not saved.
	 */
	public static var _game_skill_level_chess_temp:Int = 0;
	
	/******************************
	 * at waiting room show message box asking for confirmation to return to lobby.
	 */
	public static var _to_lobby_waiting_room_confirmation:Bool = true;
		
	/******************************
	 * at game room show message box asking for confirmation to return to lobby.
	 */
	public static var _to_lobby_game_room_confirmation:Bool = true;
	
	/******************************
	 * message box asking for confirmation to return to lobby.
	 */
	public static var _to_game_room_confirmation:Bool = true;
	
	/******************************
	 * message box asking for confirmation to return to title.
	 */
	public static var _to_title_confirmation:Bool = true;
		
	/******************************
	 * do you want to turn off the chat feature for lobby?
	 */
	public static var _chat_turn_off_for_lobby:Bool = false; 
	 
	/******************************
	 * do you want to turn off the chat feature when in a room?
	 */
	public static var _chat_turn_off_when_in_room:Bool = false; 
	
	/******************************
	 * Enable the player's piece move timer. Note: tournament play ignores this feature.
	 */
	public static var _move_timer_enable:Bool = true; 
	
	/******************************
	 * Display the player's piece move total text.
	 */
	public static var _move_total_enable:Bool = true; 
	
	/******************************
	 * Display the notation panel?
	 */
	public static var _notation_panel_enabled:Bool = true; 
	
	/******************************
	 * Display the notation panel?
	 */
	public static var _start_game_offline_confirmation:Bool = false; 
	
	/******************************
	 * chess opening moves text displayed at the top of the screen. See ChessEco.hx.
	 */
	public static var _chess_opening_moves_enabled:Bool = true;
	
	/******************************
	 * show legal chess moves. display capturing units.
	 */
	public static var _game_show_capturing_units:Bool = true; 
	
	/******************************
	 * used to change colors.
	 */
	public static var _game_show_capturing_units_number:Int = 1;
	
	public static var _chess_show_last_piece_moved:Bool = true;
	
	/******************************
	 * when playing against the computer and the computer is busy searching for a move, if this is enabled then a "Thinking..." message will display at the top of the screen.
	 */
	public static var _chess_computer_thinking_enabled:Bool = true;
	
	/******************************
	 * The future capturing units feature show upcoming attacks to the king and is only available while playing against the computer with a chess skill level of beginner.
	 */
	public static var _chess_future_capturing_units_enabled:Bool = true;
	
	/******************************
	 * this number refers to the future capturing units image color.
	 */
	public static var _chess_future_capturing_units_number:Int = 1;
		
	/******************************
	 * the path to king are units in a straight line showing where an attack on the king is coming from.
	 */
	public static var _chess_path_to_king_enabled:Bool = true;
	
	/******************************
	 * this number refers to the path to king image color.
	 */
	public static var _chess_path_to_king_number:Int = 1;
	
	/******************************
	 * apply a 10% alpha to the notation panel.
	 */
	public static var _notation_panel_alpha_apply:Bool = false;
	
	/******************************
	 * show even gameboard units at game room.
	 */
	public static var _units_even_gameboard_show:Bool = true;
	
	/******************************
	 * display background image for game room. this button.
	 */
	public static var _game_room_background_image_number:Int = 1;
	public static var _game_room_background_enabled:Bool = false;
	public static var _game_room_background_alpha_enabled:Bool = true;
	
	public static var _enable_music:Bool = true;
	public static var _enable_sound:Bool = true;
	
	/******************************
	 * the current chess piece set.
	 */
	public static var _chess_current_piece_p1_set:Int = 1;
	public static var _chess_current_piece_p2_set:Int = 1;
	public static var _chess_current_piece_p1_set_color:Int = 1;
	public static var _chess_current_piece_p2_set_color:Int = 1;
	
	/******************************
	 * 
	 */
	//public static var
	
	// these vars are reset at the start of each game.
	public static function resetRegVars():Void
	{
		_send_automatic_start_game_request = false;
		
		_move_time_remaining_maximum = [55, 55, 55, 55, 55];
		_move_time_remaining_minimum = [5, 5, 5, 5, 5];
		_move_time_remaining_current = [15, 15, 15, 15, 30];
		
		//_game_skill_level_chess = 0;		
	}
	
	/******************************
	 * these vars are reset here when returning to the mainMenu. These vars are not reset at menuState.
	 */
	public static function resetConfigurationVars():Void
	{
		// game board.
		_units_odd_spr_num = [1, 3];
		_units_even_spr_num = [9, 4];
		_units_odd_color_num = [3, 10];
		_units_even_color_num = [26, 12];		
		
		_gameboardBorder_num = 1;	// gameboard border image.
		_gameboard_border_enabled = true;	
		_gameboard_coordinates_enabled = true;				
		_config_leaderboard_enabled = false;
		_config_house_feature_enabled = true;
		_config_save_goto_lobby_enabled = false;
		
		_profile_avatar_number1 = "0.png";
		_profile_avatar_number2 = "0.png";
		_profile_avatar_number3 = "0.png";
		_profile_avatar_number4 = "0.png";
		
		_profile_username_p1 = "";
		_profile_username_p2 = "";
		
		_to_lobby_waiting_room_confirmation = true;
		_to_lobby_game_room_confirmation = true;
		_to_game_room_confirmation = true;
		_to_title_confirmation = true;
		_accept_automatic_start_game_request = false;		
		//_move_timer_enable = true;
		_move_total_enable = true;		
		_notation_panel_enabled = true;
		_start_game_offline_confirmation = false;
		_chess_opening_moves_enabled = true;
		_game_show_capturing_units = true;
		_game_show_capturing_units_number = 1;
		_chess_show_last_piece_moved = true;
		_chess_computer_thinking_enabled = true;
		_chess_future_capturing_units_enabled = true;
		_chess_future_capturing_units_number = 2;
		_chess_path_to_king_enabled = true;
		_chess_path_to_king_number = 1;
		_gameboard_border_enabled = true;
		_notation_panel_alpha_apply = false;
		_units_even_gameboard_show = true;
		_game_room_background_image_number = 1;
		_game_room_background_enabled = false;
		_game_room_background_alpha_enabled = true;
		_chess_current_piece_p1_set = 1;
		_chess_current_piece_p2_set = 1;
		_chess_current_piece_p1_set_color = 25;
		_chess_current_piece_p2_set_color = 26;
	}
}