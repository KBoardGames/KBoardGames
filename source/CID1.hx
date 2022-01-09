/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * Configuration Identifiers 1 for game button.
 * all button, text and variable for all configuration class are here.
 * @author kboardgames.com
 */
class CID1 extends FlxGroup
{
	public static var _ticks_for_button_offset:Int = 0;
	
	public static var _offset_x:Int = -50;
	public static var _offset_y:Int = 50;
	public static var _offset:Int = 30;	
	
	/******************************
	 * space between rows.
	 */
	public static var _offset_rows_y:Int = 30;
	
	public static var _button_games:ButtonToggleFlxState;	

	/******************************
	 * this holds the avatars. value starts at 0. access members here.
	 */
	public static var _group_sprite:Array<FlxSprite> = [];
	
	public static var _sprite_chess_future_capturing_units:FlxSprite;
	public static var _sprite_chess_future_capturing_units_bg:FlxSprite;
	
	public static var _sprite_chess_path_to_king:FlxSprite;
	public static var _sprite_chess_path_to_king_bg:FlxSprite;
	
	/******************************
	 * display the pawn of the selected game board chess set.
	 */
	public static var _sprite_display_pawn_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_pawn_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the bishop of the selected game board chess set.
	 */
	public static var _sprite_display_bishop_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_bishop_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the horse of the selected game board chess set.
	 */
	public static var _sprite_display_horse_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_horse_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the rook of the selected game board chess set.
	 */
	public static var _sprite_display_rook_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_rook_from_p2_chess_set:FlxSprite;
	
	/******************************
	 * display the queen of the selected game board chess set.
	 */
	public static var _sprite_display_queen_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_queen_from_p2_chess_set:FlxSprite;
	 
	/******************************
	 * display the king of the selected game board chess set.
	 */
	public static var _sprite_display_king_from_p1_chess_set:FlxSprite;
	public static var _sprite_display_king_from_p2_chess_set:FlxSprite;
	
	/******************************
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public static var _group:FlxSpriteGroup;
	
	/******************************
	 * value starts at 0. access members here.
	 */
	public static var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	/******************************
	 * when increasing/decreasing the game minutes for checkers, this text changes in that game minutes total value.
	 */
	public static var _checkers_game_minutes:FlxText;
	
	public static var _game_minutes:FlxText;
	
	/******************************
	 * when increasing/decreasing the game minutes for chess, this text changes in that game minutes total value.
	 */
	public static var _chess_game_minutes:FlxText;
	public static var _reversi_game_minutes:FlxText;
	public static var _snakes_ladders_game_minutes:FlxText;
	public static var _signature_game_minutes:FlxText;
	public static var _button_game_skill_level_chess:ButtonGeneralNetworkNo;
	public static var _text_game_skill_level_chess:FlxText;
	public static var _description_game_minutes:FlxText;
	// chess title.
	public static var _chess:FlxText;
	
	
	public static var _title_checkers_game_minutes:TextGeneral;
	public static var _title_chess_game_minutes:TextGeneral;
	public static var _title_reversi_game_minutes:TextGeneral;
	public static var _title_snakes_ladders_game_minutes:TextGeneral;
	public static var _title_signature_game_minutes:TextGeneral;
	
	/******************************
	 * total time allowed for each game. when time reaches zero, the game will end in a loss for the player.
	 */
	public static var _question_gameIds_time_allowed:Array<Int> = [];
		
	public static var _question_chess_show_last_piece_moved:TextGeneral;
	public static var _question_chess_future_capturing_units_enabled:TextGeneral;
	public static var _question_chess_path_to_king_enabled:TextGeneral;
	public static var _question_chess_set_for_player1:TextGeneral;
	public static var _question_chess_set_for_player1_color:TextGeneral;
	public static var _question_chess_set_for_player2:TextGeneral;
	public static var _question_chess_set_for_player2_color:TextGeneral;
	public static var _question_chess_opening_moves_enabled:TextGeneral;
	
	public static var _button_chess_opening_moves_enabled:ButtonGeneralNetworkNo;
	public static var _button_chess_show_last_piece_moved:ButtonGeneralNetworkNo;
	public static var _button_chess_future_capturing_units_enabled:ButtonGeneralNetworkNo;
	public static var _button_chess_future_capturing_units_minus:ButtonGeneralNetworkNo;
	public static var	_button_chess_future_capturing_units_plus:ButtonGeneralNetworkNo;
	public static var _button_chess_future_capturing_units_number:ButtonGeneralNetworkNo;
	public static var _button_chess_path_to_king_enabled:ButtonGeneralNetworkNo;
	public static var	_button_chess_path_to_king_minus:ButtonGeneralNetworkNo;
	public static var	_button_chess_path_to_king_plus:ButtonGeneralNetworkNo;
	public static var _button_chess_path_to_king_number:ButtonGeneralNetworkNo;	
	public static var _button_chess_set_for_player1_minus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player1_plus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player1_color_minus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player1_color_plus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player2_minus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player2_plus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player2_color_minus:ButtonGeneralNetworkNo;
	public static var _button_chess_set_for_player2_color_plus:ButtonGeneralNetworkNo;
	public static var _checkers_minus_minutes:ButtonGeneralNetworkNo;
	public static var _checkers_plus_minutes:ButtonGeneralNetworkNo;
	public static var _chess_minus_minutes:ButtonGeneralNetworkNo;
	public static var _chess_plus_minutes:ButtonGeneralNetworkNo;
	public static var _reversi_minus_minutes:ButtonGeneralNetworkNo;
	public static var _reversi_plus_minutes:ButtonGeneralNetworkNo;
	public static var _snakes_ladders_minus_minutes:ButtonGeneralNetworkNo;
	public static var _snakes_ladders_plus_minutes:ButtonGeneralNetworkNo;
	public static var _signature_minus_minutes:ButtonGeneralNetworkNo;
	public static var _signature_plus_minutes:ButtonGeneralNetworkNo;
	public static var _button_end_of_group_y_padding:ButtonGeneralNetworkNo;
	/******************************
	 * moves the button down,
	 */
	public static var _offset_button_y:Int = 15;
	
}