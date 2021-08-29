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
 * these are common functions that two or more classes share.
 * @author kboardgames.com
 */
class RegFunctions
{
	public static var _gameMenu:FlxSave;
	
	/******************************
	* framerate ticks.
	* @param ticks	the current value of a tick.
	* @param _inc	by how much a tick increments. 
	* framerate 60 = 1, rate 120 = 0.5, 180 = 0.33, 240 = 0.25
	* */
	public static function incrementTicks(ticks:Float, _inc:Float):Float
	{
		// Round ticks to the second decimal place.
		ticks = FlxMath.roundDecimal(_inc, 2) + FlxMath.roundDecimal(ticks, 2);
		ticks = Math.round(ticks * 100) / 100;

		// When framerate equals 180 then this "code block" will get called every time. When the value is 0.33 then the code will make the ticks plus one its value but the _inc var at next loop will still be a value of 0.33,
		if (FlxMath.roundDecimal(_inc,2) == 0.33)
		{			
			var temp:String = Std.string(ticks);
			
			// temp2[0] refers to a value at the left side of the decimal while tamp2[1] refers to the value at the right side of the decimal.
			var temp2:Array<String> = temp.split(".");				

			if (temp2[1] != null)
			{
				// If framerate equals 180 then 60 divided by framerate will equal 0.33. The problem is that ticks need to be in increments of 1. When a tick has a value of .99 then the tick will be rounded up to the next whole value. Then at a class we can do if (ticks == 1).
				if (StringTools.startsWith(temp2[1], "99"))
				{
					// convert a string to a float/
					var temp3:Float = Std.parseFloat(temp2[0]);
					temp3++;  ticks = FlxMath.roundDecimal(temp3, 2);	
				}
			}
		}
		
		return ticks;
	}
	
	/******************************
	* _p value is a unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	*/
	public static function getP(yy:Int, xx:Int):Int
	{
		var p:Int = -1;
		var _stop:Bool = false;
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{		
				if (_stop == false) p += 1;
				
				if (cy == yy && cx == xx) 
				{
					_stop = true;
				}
			}
		}
		
		if (p == 63 && _stop == false) p = -1;
		return p;
		
	}
	
	/******************************
	* this gets the yy coordinates for a _p value.
	* _p value is a unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	* signature game uses this function.
	*/
	public static function getPfindYY(_p:Int):Int
	{
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] - 1 == _p)
				return yy;
			}
			
		}
		
		return - 1;
	}	
	
	/******************************
	* this gets the xx coordinates for a _p value.
	* _p value is a unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	* signature game uses this function.
	*/
	public static function getPfindXX(_p:Int):Int
	{
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] - 1 == _p)
				return xx;
			}
			
		}
		
		return - 1;
	}	
	
	public static function getPfindYY2(_p:Int):Int
	{
		var _pp = -1;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_pp += 1;
				
				if (_pp == _p - 1)
				return yy;
			}
			
		}
		
		return - 1;
	}	
	
	public static function getPfindXX2(_p:Int):Int
	{
		var _pp = -1;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_pp += 1;
				
				if (_pp == _p - 1)
				return xx;
			}
			
		}
		
		return - 1;
	}	
	
	// instead of doing a yy xx loop which is linear, this function will pick a random number from 0 to 63, which is all units on a game board, from the Reg._p_all_static1 var and then remove that value from the Reg._p_all_dynamic1 so that it cannot be picked again. when all values have been selected the loop will end. see this end of this function for the example. in the example, to start the loop, use that while loop outside of this function.
	public static function pAll1():String
	{
		var _str:String = "";
		
		// pick a random value from the Reg._p_all_dynamic1 var.
		var ra_get = FlxG.random.int(0, Reg._p_all_dynamic1.length-1);
		var ra = Reg._p_all_dynamic1[ra_get];
		
		// now that the random value was selected, remove the value from the array so that it cannot be selected the second time.
		Reg._p_all_dynamic1.splice(ra_get, 1);
		
		var _p = -1;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_p += 1;
				// gets the xx and yy values from the ra value.
				if (_p == ra) 
				{
					_str = Std.string(yy + "," + xx);
				}
			}
		}
		
		// outside this function then var is used within a while loop. that loop will continue until Reg._p_all_dynamic1 has no more elements.
		return _str;
		
	}
		
	public static function pAll2():String
	{
		var _str:String = "";
		
		// pick a random value from the Reg._p_all_dynamic2 var.
		var ra_get = FlxG.random.int(0, Reg._p_all_dynamic2.length-1);
		var ra = Reg._p_all_dynamic2[ra_get];
		
		// now that the random value was selected, remove the value from the array so that it cannot be selected the second time.
		Reg._p_all_dynamic2.splice(ra_get, 1);
		
		var _p = -1;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_p += 1;
				// gets the xx and yy values from the ra value.
				if (_p == ra) 
				{
					_str = Std.string(yy + "," + xx);
				}
			}
		}
		
		// outside this function then var is used within a while loop. that loop will continue until Reg._p_all_dynamic2 has no more elements.
		return _str;
		
	}
	
	public static function pAll3():String
	{
		var _str:String = "";
		
		// pick a random value from the Reg._p_all_dynamic3 var.
		var ra_get = FlxG.random.int(0, Reg._p_all_dynamic3.length-1);
		var ra = Reg._p_all_dynamic3[ra_get];
		
		// now that the random value was selected, remove the value from the array so that it cannot be selected the second time.
		Reg._p_all_dynamic3.splice(ra_get, 1);
		
		var _p = -1;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				_p += 1;
				// gets the xx and yy values from the ra value.
				if (_p == ra) 
				{
					_str = Std.string(yy + "," + xx);
				}
			}
		}
		
		// outside this function then var is used within a while loop. that loop will continue until Reg._p_all_dynamic3 has no more elements.
		return _str;
		
	}

	/******************************
	 * if a value is between 1 and 3 then the Reg2._random_num has a value of 3. this function is called in a loop. each time the loop continues, an array element of the Reg2._random_num will be pop until there is no elements left. we pop it so that the same number cannot be called. this function works when there is a list of items to call but you do not want them called in order.
	 * see ChessMoveCPUsPiece.getMovePieceAnywhere() for how this function is called.
	 */
	public static function randomNumberFromArrayElements():Int
	{
		// these vars are cleared here because this function is called at each move piece function at ChessMoveCPUsPiece.hx and since some of those function use these vars, these vars must be reset so that another piece can use them.
		for (p in 0...6)
		{
			for (vy in 0...8)
			{
				for (vx in 0...8)
				{
					for (i in 0...10)
					{
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][vy][vx] = 0; // next time around do not include the old future var values.
						Reg._futureCapturesFromPieceLocation[Reg._playerMoving][p][i][vy][vx] = 0;
					}
				}
			}
		}
		
		// pick a random value from the Reg._p_all_dynamic1 var.
		var ra_get = FlxG.random.int(0, Reg2._random_num.length-1);
		var ra = Reg2._random_num[ra_get];
		
		// now that the random value was selected, remove the value from the array so that it cannot be selected the second time.
		Reg2._random_num.splice(ra_get, 1);
	
		return ra;
	}
		
	public static function gameName(i:Int):String
	{
		var _str = " ";
		
		switch(i)
		{
			case  0: { _str = "Checkers."; }
			case  1: { _str = "Chess."; }
			case  2: { _str = "Reversi."; }
			case  3: { _str = "Snackes and ladders."; }
			case  4: { _str = "Signature game."; }
		}	
		
		return _str;
	}
	
	public static function fontsSharpen():Void
	{
		// sharpen the fonts.
		FlxG.stage.quality = StageQuality.MEDIUM;		
		FlxG.camera.antialiasing = true;
		FlxG.camera.pixelPerfectRender = false;
	}
	
		
	/******************************
	* should this array be used as a defender piece or an attacker piece. for example, _chessRook[p][v][y][x]: p can be Reg._playerMoving or Reg._playerNotMoving. the _playerNotMoving is always the other player. v is rook piece number 0 and 1 in this element referring to piece 1 or 2 on game board. y and x are unit coordinates, squares on a game board.
	*/ 
	public static function is_player_attacker(_reverse:Bool = false):Void
	{
		if (Reg._gameId == 2) // reverse vars if Reversi because black piece needs to move first.
		{
			if (_reverse == true)
			{
				Reg._playerMoving = 0;
				if (Reg._gameHost == false) Reg._playerMoving = 1;
				
				Reg._playerNotMoving = 1;
				if (Reg._gameHost == false) Reg._playerNotMoving = 0;
				
				Reg._pieceNumber = 0;
				if (Reg._gameHost == false) Reg._pieceNumber = 10;
			}
			
			else
			{
				Reg._playerMoving = 1;
				if (Reg._gameHost == false) Reg._playerMoving = 0;
				
				Reg._playerNotMoving = 0;
				if (Reg._gameHost == false) Reg._playerNotMoving = 1;	
				
				Reg._pieceNumber = 10;
				if (Reg._gameHost == false) Reg._pieceNumber = 0;
			}
		
		}
		else
		{		
			if (_reverse == true)
			{
				Reg._playerMoving = 1;
				if (Reg._gameHost == false) Reg._playerMoving = 0;
				
				Reg._playerNotMoving = 0;
				if (Reg._gameHost == false) Reg._playerNotMoving = 1;
				
				Reg._pieceNumber = 10;
				if (Reg._gameHost == false) Reg._pieceNumber = 0;
			}
			
			else
			{
				Reg._playerMoving = 0;
				if (Reg._gameHost == false) Reg._playerMoving = 1;
				
				Reg._playerNotMoving = 1;
				if (Reg._gameHost == false) Reg._playerNotMoving = 0;	
				
				Reg._pieceNumber = 0;
				if (Reg._gameHost == false) Reg._pieceNumber = 10;
			}
		}	
		
			
	}
	
	public static function playerAllStop():Void
	{
		if (Reg._playerAll != null)
		{
			Reg._playerAll.stop();		
			//Reg._playerAll = null;
		}
		
	}
	
	/******************************
	 * at the MenuConfigurations.hx the configurations are loaded from here.
	 * see Reg2.resetConfigurationVars().
	 */
	public static function loadConfig(_load_item = false):Void
	{
		RegCustom.resetConfigurationVars();

		#if !html5
			if (_gameMenu.data._gameboardBorder_num != null)
			{
				for (i in 0...2)
				{
					RegCustom._units_odd_spr_num[i] = _gameMenu.data._units_odd_spr_num[i];		
					RegCustom._units_even_spr_num[i] = _gameMenu.data._units_even_spr_num[i];
					RegCustom._units_odd_color_num[i] = _gameMenu.data._units_odd_color_num[i];
					RegCustom._units_even_color_num[i] = _gameMenu.data._units_even_color_num[i];
				}
				
			
				RegCustom._gameboardBorder_num = _gameMenu.data._gameboardBorder_num;
			}
			
			if (_gameMenu.data._gameboard_border_enabled != null)
				RegCustom._gameboard_border_enabled = _gameMenu.data._gameboard_border_enabled;
		
			if (_gameMenu.data._gameboard_coordinates_enabled != null)
				RegCustom._gameboard_coordinates_enabled = _gameMenu.data._gameboard_coordinates_enabled;
				
			if (_gameMenu.data._leaderboard_enabled != null)
				RegCustom._config_leaderboard_enabled = _gameMenu.data._leaderboard_enabled;
				
			if (_gameMenu.data._profile_avatar_number1 != null)
				RegCustom._profile_avatar_number1 = _gameMenu.data._profile_avatar_number1;
			if (_gameMenu.data._profile_avatar_number2 != null)
				RegCustom._profile_avatar_number2 = _gameMenu.data._profile_avatar_number2;
			
			if (_gameMenu.data._profile_username_p1 != null)
				RegCustom._profile_username_p1 = _gameMenu.data._profile_username_p1;
			if (_gameMenu.data._profile_username_p2 != null)
				RegCustom._profile_username_p2 = _gameMenu.data._profile_username_p2;
			
			if (_gameMenu.data._config_house_feature_enabled != null)
				RegCustom._config_house_feature_enabled = _gameMenu.data._config_house_feature_enabled;
			
			if (_gameMenu.data._config_save_goto_lobby_enabled != null)
				RegCustom._config_save_goto_lobby_enabled = _gameMenu.data._config_save_goto_lobby_enabled;
				
			if (RegCustom._profile_username_p1 == "") RegCustom._profile_username_p1 = "Guest 1";
			if (RegCustom._profile_username_p2 == "") RegCustom._profile_username_p2 = "Guest 2";
			
			if (_gameMenu.data._move_time_remaining_current != null)
			{
				RegCustom._move_time_remaining_current[0] = _gameMenu.data._move_time_remaining_current[0];
				RegCustom._move_time_remaining_current[1] = _gameMenu.data._move_time_remaining_current[1];
				RegCustom._move_time_remaining_current[2] = _gameMenu.data._move_time_remaining_current[2];
				RegCustom._move_time_remaining_current[3] = _gameMenu.data._move_time_remaining_current[3];
				RegCustom._move_time_remaining_current[4] = _gameMenu.data._move_time_remaining_current[4];
			}
			
			if (_gameMenu.data._game_skill_level_chess != null
			&&  Reg._game_offline_vs_player == false
			&&  Reg._game_offline_vs_cpu == false
			&&	Reg._loggedIn == true
			||  _load_item == true)
			{
				RegCustom._game_skill_level_chess = _gameMenu.data._game_skill_level_chess;
			}
			
			if (_gameMenu.data._send_automatic_start_game_request != null)
				RegCustom._send_automatic_start_game_request = _gameMenu.data._send_automatic_start_game_request;
			if (_gameMenu.data._accept_automatic_start_game_request != null)
				RegCustom._accept_automatic_start_game_request = _gameMenu.data._accept_automatic_start_game_request;	
			if (_gameMenu.data._start_game_offline_confirmation != null)
				RegCustom._start_game_offline_confirmation = _gameMenu.data._start_game_offline_confirmation;
				
			// user is at waiting room.
			if (_gameMenu.data._to_lobby_waiting_room_confirmation != null)
				RegCustom._to_lobby_waiting_room_confirmation = _gameMenu.data._to_lobby_waiting_room_confirmation;
			if (_gameMenu.data._to_lobby_game_room_confirmation != null)
				RegCustom._to_lobby_game_room_confirmation = _gameMenu.data._to_lobby_game_room_confirmation;	
			if (_gameMenu.data._to_game_room_confirmation != null)
				RegCustom._to_game_room_confirmation = _gameMenu.data._to_game_room_confirmation;
			if (_gameMenu.data._to_title_confirmation != null)
				RegCustom._to_title_confirmation = _gameMenu.data._to_title_confirmation;
				
			if (_gameMenu.data._chat_turn_off_for_lobby != null)
				RegCustom._chat_turn_off_for_lobby = _gameMenu.data._chat_turn_off_for_lobby;
			
			if (_gameMenu.data._chat_turn_off_when_in_room != null)
				RegCustom._chat_turn_off_when_in_room = _gameMenu.data._chat_turn_off_when_in_room;
			
			if (_gameMenu.data._move_timer_enable != null)
				RegCustom._move_timer_enable = _gameMenu.data._move_timer_enable;
			if (_gameMenu.data._move_total_enable != null)
				RegCustom._move_total_enable = _gameMenu.data._move_total_enable;
			
			if (_gameMenu.data._notation_panel_enabled != null)
				RegCustom._notation_panel_enabled = _gameMenu.data._notation_panel_enabled;
			
			if (_gameMenu.data._chess_opening_moves_enabled != null)
				RegCustom._chess_opening_moves_enabled = _gameMenu.data._chess_opening_moves_enabled;
			
			if (_gameMenu.data._game_show_capturing_units != null)
				RegCustom._game_show_capturing_units = _gameMenu.data._game_show_capturing_units;	
				
			if (_gameMenu.data._game_show_capturing_units_number != null)
				RegCustom._game_show_capturing_units_number = _gameMenu.data._game_show_capturing_units_number;	
			
			if (_gameMenu.data._chess_show_last_piece_moved != null)
				RegCustom._chess_show_last_piece_moved = _gameMenu.data._chess_show_last_piece_moved;
			
			if (_gameMenu.data._chess_computer_thinking_enabled != null)
				RegCustom._chess_computer_thinking_enabled = _gameMenu.data._chess_computer_thinking_enabled;
			
			if (_gameMenu.data._chess_future_capturing_units_enabled != null)
				RegCustom._chess_future_capturing_units_enabled = _gameMenu.data._chess_future_capturing_units_enabled;
							
			if (_gameMenu.data._chess_future_capturing_units_number != null)
				RegCustom._chess_future_capturing_units_number = _gameMenu.data._chess_future_capturing_units_number;
			
			if (_gameMenu.data._chess_path_to_king_enabled != null)
				RegCustom._chess_path_to_king_enabled = _gameMenu.data._chess_path_to_king_enabled;			
			
			if (_gameMenu.data._chess_path_to_king_number != null)
				RegCustom._chess_path_to_king_number = _gameMenu.data._chess_path_to_king_number;	
			
			if (_gameMenu.data._notation_panel_alpha_apply != null)
				RegCustom._notation_panel_alpha_apply = _gameMenu.data._notation_panel_alpha_apply;		
			
			if (_gameMenu.data._units_even_gameboard_show != null)
				RegCustom._units_even_gameboard_show = _gameMenu.data._units_even_gameboard_show;
			
			if (_gameMenu.data._game_room_background_image_number != null)
				RegCustom._game_room_background_image_number = _gameMenu.data._game_room_background_image_number;
				
			if (_gameMenu.data._game_room_background_enabled != null)
				RegCustom._game_room_background_enabled = _gameMenu.data._game_room_background_enabled;
			
			if (_gameMenu.data._game_room_background_alpha_enabled != null)
				RegCustom._game_room_background_alpha_enabled = _gameMenu.data._game_room_background_alpha_enabled;
			
			if (_gameMenu.data._chess_current_piece_p1_set != null)
				RegCustom._chess_current_piece_p1_set = _gameMenu.data._chess_current_piece_p1_set;
			
			if (_gameMenu.data._chess_current_piece_p2_set != null)
				RegCustom._chess_current_piece_p2_set = _gameMenu.data._chess_current_piece_p2_set;
			
			if (_gameMenu.data._chess_current_piece_p1_set_color != null)
				RegCustom._chess_current_piece_p1_set_color = _gameMenu.data._chess_current_piece_p1_set_color;
				
			if (_gameMenu.data._chess_current_piece_p2_set_color != null)
				RegCustom._chess_current_piece_p2_set_color = _gameMenu.data._chess_current_piece_p2_set_color;
			
			
			
			_gameMenu.close;
		#end
	}
	
	/******************************
	 * at the MenuConfigurations.hx the save button was pressed.
	 * see RegCustom.resetConfigurationVars().
	 */
	public static function saveConfig():Void
	{
		#if !html5
			// save data
			_gameMenu.data._units_odd_spr_num = new Array<Int>();		
			_gameMenu.data._units_even_spr_num = new Array<Int>();
			
			_gameMenu.data._units_odd_color_num = new Array<Int>();		
			_gameMenu.data._units_even_color_num = new Array<Int>();
			
			
			for (i in 0... 2)
			{
				_gameMenu.data._units_odd_spr_num[i] = RegCustom._units_odd_spr_num[i];	
				_gameMenu.data._units_even_spr_num[i] = RegCustom._units_even_spr_num[i];
				
				_gameMenu.data._units_odd_color_num[i] = RegCustom._units_odd_color_num[i];
				_gameMenu.data._units_even_color_num[i] = RegCustom._units_even_color_num[i];
			}
			
			_gameMenu.data._gameboardBorder_num = RegCustom._gameboardBorder_num;
			_gameMenu.data._gameboard_border_enabled = RegCustom._gameboard_border_enabled;
			_gameMenu.data._gameboard_coordinates_enabled = RegCustom._gameboard_coordinates_enabled;
			_gameMenu.data._leaderboard_enabled = RegCustom._config_leaderboard_enabled;
			
			_gameMenu.data._profile_avatar_number1 = RegCustom._profile_avatar_number1;
			_gameMenu.data._profile_avatar_number2 = RegCustom._profile_avatar_number2;
			
			_gameMenu.data._profile_username_p1 = RegCustom._profile_username_p1;
			_gameMenu.data._profile_username_p2 = RegCustom._profile_username_p2;
			
			// these need to be clear or else the old username will be used at next login.
			RegCustom._profile_username_p1 = "";
			RegCustom._profile_username_p2 = "";
			RegTypedef._dataAccount._username = "";
			
			_gameMenu.data._config_house_feature_enabled = RegCustom._config_house_feature_enabled;
			
			_gameMenu.data._config_save_goto_lobby_enabled = RegCustom._config_save_goto_lobby_enabled;
			
			// when saving arrays, the array first needs to be created.
			_gameMenu.data._move_time_remaining_current = new Array<Int>();
			_gameMenu.data._move_time_remaining_current[0] = RegCustom._move_time_remaining_current[0];
			_gameMenu.data._move_time_remaining_current[1] = RegCustom._move_time_remaining_current[1];
			_gameMenu.data._move_time_remaining_current[2] = RegCustom._move_time_remaining_current[2];
			_gameMenu.data._move_time_remaining_current[3] = RegCustom._move_time_remaining_current[3];
			_gameMenu.data._move_time_remaining_current[4] = RegCustom._move_time_remaining_current[4];
			
			_gameMenu.data._game_skill_level_chess = RegCustom._game_skill_level_chess;
			
			_gameMenu.data._send_automatic_start_game_request = RegCustom._send_automatic_start_game_request;
			_gameMenu.data._accept_automatic_start_game_request = RegCustom._accept_automatic_start_game_request;
			
			_gameMenu.data._start_game_offline_confirmation = RegCustom._start_game_offline_confirmation;
			
			// user is at waiting room.
			_gameMenu.data._to_lobby_waiting_room_confirmation = RegCustom._to_lobby_waiting_room_confirmation;
			_gameMenu.data._to_lobby_game_room_confirmation = RegCustom._to_lobby_game_room_confirmation;
			_gameMenu.data._to_game_room_confirmation = RegCustom._to_game_room_confirmation;
			_gameMenu.data._to_title_confirmation = RegCustom._to_title_confirmation;
			
			_gameMenu.data._chat_turn_off_for_lobby = RegCustom._chat_turn_off_for_lobby;
			_gameMenu.data._chat_turn_off_when_in_room = RegCustom._chat_turn_off_when_in_room;
			
			_gameMenu.data._move_timer_enable = RegCustom._move_timer_enable;
			_gameMenu.data._move_total_enable = RegCustom._move_total_enable;
			
			_gameMenu.data._notation_panel_enabled = RegCustom._notation_panel_enabled;
			_gameMenu.data._chess_opening_moves_enabled = RegCustom._chess_opening_moves_enabled;
			
			_gameMenu.data._game_show_capturing_units = RegCustom._game_show_capturing_units;
			
			_gameMenu.data._game_show_capturing_units_number = RegCustom._game_show_capturing_units_number;
			
			_gameMenu.data._chess_show_last_piece_moved = RegCustom._chess_show_last_piece_moved;
			
			_gameMenu.data._chess_computer_thinking_enabled = RegCustom._chess_computer_thinking_enabled;
			
			_gameMenu.data._chess_future_capturing_units_enabled = RegCustom._chess_future_capturing_units_enabled;
			
			_gameMenu.data._chess_future_capturing_units_number = RegCustom._chess_future_capturing_units_number;
			
			_gameMenu.data._chess_path_to_king_enabled = RegCustom._chess_path_to_king_enabled;
			
			_gameMenu.data._chess_path_to_king_number = RegCustom._chess_path_to_king_number;
			
			_gameMenu.data._notation_panel_alpha_apply = RegCustom._notation_panel_alpha_apply;
			
			_gameMenu.data._units_even_gameboard_show = RegCustom._units_even_gameboard_show;
			
			_gameMenu.data._game_room_background_image_number = RegCustom._game_room_background_image_number;
			
			_gameMenu.data._game_room_background_enabled = RegCustom._game_room_background_enabled;
			
			_gameMenu.data._game_room_background_alpha_enabled = RegCustom._game_room_background_alpha_enabled;
		
			_gameMenu.data._chess_current_piece_p1_set = RegCustom._chess_current_piece_p1_set;
			
			_gameMenu.data._chess_current_piece_p2_set = RegCustom._chess_current_piece_p2_set;
			
			_gameMenu.data._chess_current_piece_p1_set_color = RegCustom._chess_current_piece_p1_set_color;
			
			_gameMenu.data._chess_current_piece_p2_set_color = RegCustom._chess_current_piece_p2_set_color;
			
			
		
			_gameMenu.flush();
			_gameMenu.close;
		#end
		
		// notice after save is clicked from MenuConfigurationsOutput.saveConfig().
		if (RegCustom._config_save_goto_lobby_enabled == false)
			RegTriggers._config_menu_save_notice = true;
		else
			FlxG.switchState(new MenuState());
		
		/*
		trace (RegCustom._units_odd_spr_num + " RegCustom._units_odd_spr_num");
		trace (RegCustom._units_even_spr_num + " RegCustom._units_even_spr_num");
		trace (RegCustom._units_odd_color_num + " RegCustom._units_odd_color_num");
		trace (RegCustom._units_even_color_num + " RegCustom._units_even_color_num");
		*/
	}
	
	/******************************
	 * generate the computer names and computer avatar numbers to be used for computer games. if playing a one player game against computer computer, use the name and avatar created at this function for that BOT player.	 * 
	 */
	public static function offlineCpuUserNames():Void
	{
		// create the computer host names for room a and b.
		while (Reg2._offline_cpu_host_name2 == "" && Reg2._offline_cpu_host_name3 == "")
		{
			var _int = Std.random(5);
			
			// assign the computer host name that will be used when playing a 2 player offline game
			if (Reg2._offline_cpu_host_name2 == "")
			{
				if (_int == 0)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[0];
					RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[0];
				}
				
				if (_int == 1)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[1];
					RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[1];					
				}
				
				if (_int == 2) 
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[2];
					RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[2];
				}
				
				if (_int == 3)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[3];
					RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[3];
				}
				
				if (_int == 4)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[4];
					RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[4];
				}
			}
			
			var _int = Std.random(4);
			
			// assign the computer host name that will be used when playing a 3 player offline game.
			if (Reg2._offline_cpu_host_name3 == "")
			{
				if (_int == 0) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[0];
					RegCustom._profile_avatar_number3 = Reg2._offline_cpu_avatar_number[0];
				}
				
				if (_int == 1) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[1];
					RegCustom._profile_avatar_number3 = Reg2._offline_cpu_avatar_number[1];
				}
				
				if (_int == 2)
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[2];
					RegCustom._profile_avatar_number3 = Reg2._offline_cpu_avatar_number[2];
				}
				
				if (_int == 3)
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[3];
					RegCustom._profile_avatar_number3 = Reg2._offline_cpu_avatar_number[3];
				}
				
				if (_int == 4) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[4];
					RegCustom._profile_avatar_number3 = Reg2._offline_cpu_avatar_number[4];
				}
			}

			// Reg._cpu_host_name1 and Reg._cpu_host_name2 are now with a host name but if they have the same host name then clear these var data so that the loop can continue.
			// note that this will always be true for the first loop because random values are not truly random if the seed is not set.
			if (Reg2._offline_cpu_host_name2 == Reg2._offline_cpu_host_name3)
			{
				Reg2._offline_cpu_host_name2 = "";
				Reg2._offline_cpu_host_name3 = "";
				
				RegCustom._profile_avatar_number2 = "0.png";
				RegCustom._profile_avatar_number3 = "0.png";
			}			
		}
	}
	
	public static function color_future_capturing_units():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._chess_future_capturing_units_number == 1) _color = FlxColor.BLUE;
		if (RegCustom._chess_future_capturing_units_number == 2) _color = FlxColor.BROWN;
		if (RegCustom._chess_future_capturing_units_number == 3) _color = FlxColor.CYAN;
		if (RegCustom._chess_future_capturing_units_number == 4) _color = FlxColor.GRAY;
		if (RegCustom._chess_future_capturing_units_number == 5) _color = FlxColor.GREEN;
		if (RegCustom._chess_future_capturing_units_number == 6) _color = FlxColor.LIME;
		if (RegCustom._chess_future_capturing_units_number == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._chess_future_capturing_units_number == 8) _color = FlxColor.ORANGE;
		if (RegCustom._chess_future_capturing_units_number == 9) _color = FlxColor.PINK;	 
		if (RegCustom._chess_future_capturing_units_number == 10) _color = FlxColor.PURPLE;
		if (RegCustom._chess_future_capturing_units_number == 11) _color = FlxColor.RED;
		if (RegCustom._chess_future_capturing_units_number == 12) _color = FlxColor.YELLOW;
		if (RegCustom._chess_future_capturing_units_number == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	public static function color_path_to_king():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._chess_path_to_king_number == 1) _color = FlxColor.BLUE;
		if (RegCustom._chess_path_to_king_number == 2) _color = FlxColor.BROWN;
		if (RegCustom._chess_path_to_king_number == 3) _color = FlxColor.CYAN;
		if (RegCustom._chess_path_to_king_number == 4) _color = FlxColor.GRAY;
		if (RegCustom._chess_path_to_king_number == 5) _color = FlxColor.GREEN;
		if (RegCustom._chess_path_to_king_number == 6) _color = FlxColor.LIME;
		if (RegCustom._chess_path_to_king_number == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._chess_path_to_king_number == 8) _color = FlxColor.ORANGE;
		if (RegCustom._chess_path_to_king_number == 9) _color = FlxColor.PINK;	 
		if (RegCustom._chess_path_to_king_number == 10) _color = FlxColor.PURPLE;
		if (RegCustom._chess_path_to_king_number == 11) _color = FlxColor.RED;
		if (RegCustom._chess_path_to_king_number == 12) _color = FlxColor.YELLOW;
		if (RegCustom._chess_path_to_king_number == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	public static function color_game_show_capturing_units():FlxColor
	{
		
		var _color:FlxColor = 0xFFFFFFFF;
		
		if (RegCustom._game_show_capturing_units_number == 1) _color = FlxColor.BLUE;
		if (RegCustom._game_show_capturing_units_number == 2) _color = FlxColor.BROWN;
		if (RegCustom._game_show_capturing_units_number == 3) _color = FlxColor.CYAN;
		if (RegCustom._game_show_capturing_units_number == 4) _color = FlxColor.GRAY;
		if (RegCustom._game_show_capturing_units_number == 5) _color = FlxColor.GREEN;
		if (RegCustom._game_show_capturing_units_number == 6) _color = FlxColor.LIME;
		if (RegCustom._game_show_capturing_units_number == 7) _color = FlxColor.MAGENTA;
		if (RegCustom._game_show_capturing_units_number == 8) _color = FlxColor.ORANGE;
		if (RegCustom._game_show_capturing_units_number == 9) _color = FlxColor.PINK;	 
		if (RegCustom._game_show_capturing_units_number == 10) _color = FlxColor.PURPLE;
		if (RegCustom._game_show_capturing_units_number == 11) _color = FlxColor.RED;
		if (RegCustom._game_show_capturing_units_number == 12) _color = FlxColor.YELLOW;
		if (RegCustom._game_show_capturing_units_number == 13) _color = FlxColor.WHITE;
		return _color;
	}
	
	public static function background_scene_color():FlxColor
	{
		var _color:FlxColor = 0xFF000000;
		var _num = FlxG.random.int(1, 10);
		
		switch(_num)
		{
			case 1: _color = 0xFF40160d; // brown.
			case 2: _color = 0xFF1c400d; // dark green.
			case 3: _color = 0xFF374008; // greenish yellow. 
			case 4: _color = 0xFF0c0d42; // dark blue.
			case 5: _color = 0xFF888820; // yellow.
			case 6: _color = 0xFF208820; // green.
			case 7: _color = 0xFF202088; // blue.
			case 8: _color = 0xFF882020; // red.
			case 9: _color = 0xFF220022; // purple.
			case 10: _color = 0xffff00ff; // pink.
		}
		
		return _color;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p1_set_color():FlxColor
	{
		var _color:FlxColor = 0xFFFFFFFF;
		
		switch(RegCustom._chess_current_piece_p1_set_color)
		{
			 case 1: _color = 0xFFb18d8d; // red 1
			 case 2: _color = 0xFFaf5252; // red 2
			 case 3: _color = 0xFFaa2222; // red 3
			 case 4: _color = 0xFFb18dc0; // purple 1
			 case 5: _color = 0xFFaf529b; // purple 2
			 case 6: _color = 0xFFaa2283; // purple 3
			 case 7: _color = 0xFF908de1; // purple 4
			 case 8: _color = 0xFF9352af; // purple 5
			 case 9: _color = 0xFF732298; // purple 6
			case 10: _color = 0xFF5db3e1; // blue 1	 
			case 11: _color = 0xFF5252af; // blue 2
			case 12: _color = 0xFF2222aa; // blue 3
			case 13: _color = 0xFF5fe1cd; // blue 4	
			case 14: _color = 0xFF529eaf; // blue 5
			case 15: _color = 0xFF229999; // blue 6
			case 16: _color = 0xFF5de197; // green 1
			case 17: _color = 0xFF52af60; // green 2
			case 18: _color = 0xFF22aa22; // green 3
			case 19: _color = 0xFFd2e16d; // yellow 1
			case 20: _color = 0xFFa4af52; // yellow 2
			case 21: _color = 0xFFaaaa22; // yellow 3
			case 22: _color = 0xFFb1b68d; // orange 1	
			case 23: _color = 0xFFaf7f52; // orange 2
			case 24: _color = 0xFFaa4522; // orange 3
			case 25: _color = 0xFFFFFFFF;
			case 26: _color = 0xFF555555;
		}
		
		return _color;
	}
	
	/******************************
	 * chess game board piece set color.
	 */
	public static function draw_update_board_p2_set_color():FlxColor
	{
		var _color:FlxColor = 0xFFFFFFFF;
		
		switch(RegCustom._chess_current_piece_p2_set_color)
		{
			 case 1: _color = 0xFFb18d8d; // red 1
			 case 2: _color = 0xFFaf5252; // red 2
			 case 3: _color = 0xFFaa2222; // red 3
			 case 4: _color = 0xFFb18dc0; // purple 1
			 case 5: _color = 0xFFaf529b; // purple 2
			 case 6: _color = 0xFFaa2283; // purple 3
			 case 7: _color = 0xFF908de1; // purple 4
			 case 8: _color = 0xFF9352af; // purple 5
			 case 9: _color = 0xFF732298; // purple 6
			case 10: _color = 0xFF5db3e1; // blue 1	 
			case 11: _color = 0xFF5252af; // blue 2
			case 12: _color = 0xFF2222aa; // blue 3
			case 13: _color = 0xFF5fe1cd; // blue 4	
			case 14: _color = 0xFF529eaf; // blue 5
			case 15: _color = 0xFF229999; // blue 6
			case 16: _color = 0xFF5de197; // green 1
			case 17: _color = 0xFF52af60; // green 2
			case 18: _color = 0xFF22aa22; // green 3
			case 19: _color = 0xFFd2e16d; // yellow 1
			case 20: _color = 0xFFa4af52; // yellow 2
			case 21: _color = 0xFFaaaa22; // yellow 3
			case 22: _color = 0xFFb1b68d; // orange 1	
			case 23: _color = 0xFFaf7f52; // orange 2
			case 24: _color = 0xFFaa4522; // orange 3
			case 25: _color = 0xFFFFFFFF;
			case 26: _color = 0xFF555555;
		}
		
		return _color;
	}
}