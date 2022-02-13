/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

import yaml.Yaml;
import yaml.Parser;
import yaml.Renderer;
import yaml.util.ObjectMap;

/**
 * these are common functions that two or more classes share.
 * @author kboardgames.com
 */
class RegFunctions
{
	public static var _gameMenu:FlxSave;
	
	public static var _theme_string:Array<String> = [""];
	public static var _theme_int:Array<Int> = [0];
	public static var _theme_float:Array<Float> = [0];
	public static var _theme_bool:Array<Bool> = [false];
	public static var _theme_array_float:Array<Array<Float>> = [[0, 0]];
	
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
	
	
	// here we use the ip address to find the username of the user logged into the website. if found, the user will be sent to the lobby.
	public static function front_door_queue(_ip:String):String
	{
		_ip = "&ip=" + _ip;
		
		// DO NOT USE SPECIAL CHARACTERS IN THIS TOKEN IT MAY BREAK LOGINS.
		var _token = "token=J39BsrUDd94mWd4Jd341";
		var _str = Reg._websiteHomeUrl + "server/frontDoorQueue.php?" + _token + _ip;		
		var _http = new haxe.Http(_str);		
		var _data:String = "";
		
		_http.onData = function (data:String) 
		{
			if (data.substr(0, 1) == "<") 
			{
				// display error message.
			}
			
			else 
			{
				// we found the file if we are here.
				if (data == "")
				{
					_data = "";
				}
				
				else _data = data;
			}
		}

		_http.onError = function (_error)
		{			
		}
		
		_http.request();
		return _data;
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
		FlxG.stage.quality = StageQuality.BEST;		
		FlxG.camera.antialiasing = true;
		FlxG.camera.pixelPerfectRender = true;
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
	 * save theme when when user saves preferences at the configuration menu.
	 */
	static public function save_theme():Void
	{
		#if html5
			return;
		
		#else		
			var _directory = StringTools.replace(Path.directory(Sys.programPath()), "\\", "/") + "/themes/";
			var saveFile = sys.io.File.write(_directory + RegCustom._theme_name[Reg._tn]);
			
			saveFile.writeString("_gameboard_units_odd_shade_number: " + RegCustom._gameboard_units_odd_shade_number[Reg._tn][0] + ", " + RegCustom._gameboard_units_odd_shade_number[Reg._tn][1] + "\r\n");
			saveFile.writeString("_gameboard_units_even_shade_number: " + RegCustom._gameboard_units_even_shade_number[Reg._tn][0] + ", " + RegCustom._gameboard_units_even_shade_number[Reg._tn][1] + "\r\n");
			
			saveFile.writeString("_gameboard_units_odd_color_number: " + RegCustom._gameboard_units_odd_color_number[Reg._tn][0] + ", " + RegCustom._gameboard_units_odd_color_number[Reg._tn][1] + "\r\n");
			
			saveFile.writeString("_gameboard_units_even_color_number: " + RegCustom._gameboard_units_even_color_number[Reg._tn][0] + ", " + RegCustom._gameboard_units_even_color_number[Reg._tn][1] + "\r\n");
			
			saveFile.writeString("_username_suggestions_enabled: " + RegCustom._username_suggestions_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_gameboard_border_enabled: " + RegCustom._gameboard_border_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_gameboard_border_number: " + RegCustom._gameboard_border_number[Reg._tn] + "\r\n");
		
			saveFile.writeString("_gameboard_coordinates_enabled: " + RegCustom._gameboard_coordinates_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_gameboard_even_units_show_enabled: " + RegCustom._gameboard_even_units_show_enabled[Reg._tn] + "\r\n");			
		
			saveFile.writeString("_gradient_background_enabled: " + RegCustom._gradient_background_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_gradient_background_image_number: " + RegCustom._gradient_background_image_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_texture_background_enabled: " + RegCustom._texture_background_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_texture_background_image_number: " + RegCustom._texture_background_image_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_client_background_enabled: " + RegCustom._client_background_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_client_background_image_number: " + RegCustom._client_background_image_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_client_background_brightness: " + RegCustom._client_background_brightness[Reg._tn] + "\r\n");
			
			saveFile.writeString("_client_background_saturation: " + RegCustom._client_background_saturation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_background_alpha_enabled: " + RegCustom._background_alpha_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_table_body_background_image_number: " + RegCustom._table_body_background_image_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_table_body_background_brightness: " + RegCustom._table_body_background_brightness[Reg._tn] + "\r\n");
			
			saveFile.writeString("_table_body_background_saturation: " + RegCustom._table_body_background_saturation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_capturing_units: " + RegCustom._capturing_units[Reg._tn] + "\r\n");
			
			saveFile.writeString("_capturing_units_number: " + RegCustom._capturing_units_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_show_last_piece_moved: " + RegCustom._chess_show_last_piece_moved[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_future_capturing_units_enabled: " + RegCustom._chess_future_capturing_units_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_future_capturing_units_number: " + RegCustom._chess_future_capturing_units_number[Reg._tn] + "\r\n");

			saveFile.writeString("_chess_path_to_king_enabled: " + RegCustom._chess_path_to_king_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_path_to_king_number: " + RegCustom._chess_path_to_king_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_set_for_player1: " + RegCustom._chess_set_for_player1[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_set_for_player2: " + RegCustom._chess_set_for_player2[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_set_for_player1_color_number: " + RegCustom._chess_set_for_player1_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_set_for_player2_color_number: " + RegCustom._chess_set_for_player2_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chess_opening_moves_enabled: " + RegCustom._chess_opening_moves_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_button_color_number: " + RegCustom._button_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_button_border_color_number: " + RegCustom._button_border_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_button_text_color_number: " + RegCustom._button_text_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_leaderboard_enabled: " + RegCustom._leaderboard_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_house_feature_enabled: " + RegCustom._house_feature_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_go_back_to_title_after_save: " + RegCustom._go_back_to_title_after_save[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_40_percent_alpha_enabled: " + RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_same_background_color_enabled: " + RegCustom._notation_panel_same_background_color_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_background_color_enabled: " + RegCustom._notation_panel_background_color_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_background_color_number: " + RegCustom._notation_panel_background_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_text_color_number: " + RegCustom._notation_panel_text_color_number[Reg._tn] + "\r\n");

			saveFile.writeString("_client_topic_title_text_color_number: " + RegCustom._client_topic_title_text_color_number[Reg._tn] + "\r\n");
						
			saveFile.writeString("_client_text_color_number: " + RegCustom._client_text_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_title_bar_text_color_number: " + RegCustom._title_bar_text_color_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_profile_avatar_number1: " + RegCustom._profile_avatar_number1[Reg._tn] + "\r\n");
			
			saveFile.writeString("_profile_avatar_number2: " + RegCustom._profile_avatar_number2[Reg._tn] + "\r\n");
			
			saveFile.writeString("_profile_avatar_number3: " + RegCustom._profile_avatar_number3[Reg._tn] + "\r\n");
			
			saveFile.writeString("_profile_avatar_number4: " + RegCustom._profile_avatar_number4[Reg._tn] + "\r\n");
			
			saveFile.writeString("_send_automatic_start_game_request: " + RegCustom._send_automatic_start_game_request[Reg._tn] + "\r\n");
			
			saveFile.writeString("_accept_automatic_start_game_request: " + RegCustom._accept_automatic_start_game_request[Reg._tn] + "\r\n");
			
			saveFile.writeString("_to_lobby_from_waiting_room_confirmation: " + RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_to_lobby_from_game_room_confirmation: " + RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_to_game_room_from_waiting_room_confirmation: " + RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] + "\r\n");
			saveFile.writeString("_to_title_from_game_room_confirmation: " + RegCustom._to_title_from_game_room_confirmation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chat_when_at_lobby_enabled: " + RegCustom._chat_when_at_lobby_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_timer_enabled: " + RegCustom._timer_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_chat_when_at_room_enabled: " + RegCustom._chat_when_at_room_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_move_total_enabled: " + RegCustom._move_total_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_notation_panel_enabled: " + RegCustom._notation_panel_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_start_game_offline_confirmation: " + RegCustom._start_game_offline_confirmation[Reg._tn] + "\r\n");
			
			saveFile.writeString("_music_enabled: " + RegCustom._music_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_sound_enabled: " + RegCustom._sound_enabled[Reg._tn] + "\r\n");
			
			saveFile.writeString("_time_remaining_for_game: " + RegCustom._time_remaining_for_game[Reg._tn][0] + ", " + 
			RegCustom._time_remaining_for_game[Reg._tn][1] + ", " + 
			RegCustom._time_remaining_for_game[Reg._tn][2] + ", " + 
			RegCustom._time_remaining_for_game[Reg._tn][3] + ", " + 
			RegCustom._time_remaining_for_game[Reg._tn][4] + "\r\n");
				
			saveFile.writeString("_title_bar_background_number: " + RegCustom._title_bar_background_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_menu_bar_background_number: " + RegCustom._menu_bar_background_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_title_bar_background_brightness: " + RegCustom._title_bar_background_brightness[Reg._tn] + "\r\n");
			
			saveFile.writeString("_menu_bar_background_brightness: " + RegCustom._menu_bar_background_brightness[Reg._tn] + "\r\n");
			
			saveFile.writeString("_world_flags_number: " + RegCustom._world_flags_number[Reg._tn] + "\r\n");
			
			saveFile.writeString("_pager_enabled: " + RegCustom._pager_enabled[Reg._tn] + "\r\n");
			
			saveFile.close();
		#end
	}
	
	/******************************
	 * get all themes files in the theme folder and then store their data in arrays.
	 * when loading floats with the yaml lib the command to use is Std.parseFloat(Std.string(data.get("example"))). the Std.parseFloat(data.get("example")) command will crash the client,
	 */
	static public function themes_recursive_file_loop() 
	{
		#if html5
			return;
			
		#else
			var _tn_temp = Reg._tn;
			Reg._tn = 0;
			
			var _directory = StringTools.replace(Path.directory(Sys.programPath()), "\\", "/") + "/themes/";
			
			if (sys.FileSystem.exists(_directory)) 
			{
				for (_file in sys.FileSystem.readDirectory(_directory)) 
				{
					var _path = haxe.io.Path.join([_directory, _file]);
					
					if (!sys.FileSystem.isDirectory(_path) 
					&& _file != "default.yaml")
					{
						Reg._tn += 1;
						push_next_theme();
						
						RegCustom._theme_name.push("");
						RegCustom._theme_name[Reg._tn] = _file;
						
					}
					
					if (!sys.FileSystem.isDirectory(_path) 
					&& _file != "default.yaml"
					&& 	sys.io.File.getContent(_path) != "")
					{
						var data:Dynamic = null;
						
						try 
						{
							// do something with file
							data = Yaml.read(_path); 
						}
						catch (e:Dynamic){}
							
						try
						{
							var _array_tmp = Std.string(data.get("_gameboard_units_odd_shade_number"));
							var _array = _array_tmp.split(",");
							
							if (Std.parseInt(_array[0]) != null) RegCustom._gameboard_units_odd_shade_number[Reg._tn][0] = Std.parseInt(_array[0]);
							if (Std.parseInt(_array[1]) != null) RegCustom._gameboard_units_odd_shade_number[Reg._tn][1] = Std.parseInt(_array[1]);
						}
						catch (e:Dynamic){}
						
						try
						{
							var _array_tmp = Std.string(data.get("_gameboard_units_even_shade_number"));
							var _array = _array_tmp.split(",");
							if (Std.parseInt(_array[0]) != null) RegCustom._gameboard_units_even_shade_number[Reg._tn][0] = Std.parseInt(_array[0]);
							if (Std.parseInt(_array[1]) != null) RegCustom._gameboard_units_even_shade_number[Reg._tn][1] = Std.parseInt(_array[1]);
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _array_tmp = Std.string(data.get("_gameboard_units_odd_color_number"));
							var _array = _array_tmp.split(",");
							if (Std.parseInt(_array[0]) != null) RegCustom._gameboard_units_odd_color_number[Reg._tn][0] = Std.parseInt(_array[0]);
							if (Std.parseInt(_array[1]) != null) RegCustom._gameboard_units_odd_color_number[Reg._tn][1] = Std.parseInt(_array[1]);
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _array_tmp = Std.string(data.get("_gameboard_units_even_color_number"));
							var _array = _array_tmp.split(",");
							if (Std.parseInt(_array[0]) != null) RegCustom._gameboard_units_even_color_number[Reg._tn][0] = Std.parseInt(_array[0]);
							if (Std.parseInt(_array[1]) != null) RegCustom._gameboard_units_even_color_number[Reg._tn][1] = Std.parseInt(_array[1]);
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_username_suggestions_enabled"));
							RegCustom._username_suggestions_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._username_suggestions_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}		
						
						try
						{	
							var _tmp = Std.string(data.get("_gameboard_border_enabled"));
							RegCustom._gameboard_border_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._gameboard_border_enabled[Reg._tn] = true;
							RegCustom._gameboard_border_number[Reg._tn] = Std.parseInt(data.get("_gameboard_border_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_gameboard_coordinates_enabled"));
							RegCustom._gameboard_coordinates_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._gameboard_coordinates_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_gameboard_even_units_show_enabled"));
							RegCustom._gameboard_even_units_show_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._gameboard_even_units_show_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_gradient_background_enabled"));
							RegCustom._gradient_background_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._gradient_background_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._gradient_background_image_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_gradient_background_image_number")) != null) RegCustom._gradient_background_image_number[Reg._tn] = Std.parseInt(data.get("_gradient_background_image_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_texture_background_enabled"));
							RegCustom._texture_background_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._texture_background_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._texture_background_image_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_texture_background_image_number")) != null) RegCustom._texture_background_image_number[Reg._tn] = Std.parseInt(data.get("_texture_background_image_number"));
						}
						catch (e:Dynamic){}						
						
						try
						{
							var _tmp = Std.string(data.get("_client_background_enabled"));
							RegCustom._client_background_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._client_background_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._client_background_image_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_client_background_image_number")) != null) RegCustom._client_background_image_number[Reg._tn] = Std.parseInt(data.get("_client_background_image_number"));
						}
						catch (e:Dynamic){}							
						
						try
						{
							RegCustom._client_background_brightness[Reg._tn] = 1; 
							if (Std.string(data.get("_client_background_brightness")) != ""
							&&	Std.string(data.get("_client_background_brightness")) != "null") RegCustom._client_background_brightness[Reg._tn] = Std.parseFloat(Std.string(data.get("_client_background_brightness")));
						}
						catch (e:Dynamic){}		
						
						try
						{
							RegCustom._client_background_saturation[Reg._tn] = 1;
							if (Std.string(data.get("_client_background_saturation")) != ""
							&&	Std.string(data.get("_client_background_saturation")) != "null") RegCustom._client_background_saturation[Reg._tn] = Std.parseFloat(Std.string(data.get("_client_background_saturation")));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_background_alpha_enabled"));
							RegCustom._background_alpha_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._background_alpha_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._table_body_background_image_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_table_body_background_image_number")) != null) RegCustom._table_body_background_image_number[Reg._tn] = Std.parseInt(data.get("_table_body_background_image_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._table_body_background_brightness[Reg._tn] = 1; 
							if (Std.string(data.get("_table_body_background_brightness")) != ""
							&&	Std.string(data.get("_table_body_background_brightness")) != "null") RegCustom._table_body_background_brightness[Reg._tn] = Std.parseFloat(Std.string(data.get("_table_body_background_brightness")));
						}
						catch (e:Dynamic){}		
						
						try
						{
							RegCustom._table_body_background_saturation[Reg._tn] = 1;
							if (Std.string(data.get("_table_body_background_saturation")) != ""
							&&	Std.string(data.get("_table_body_background_saturation")) != "null") RegCustom._table_body_background_saturation[Reg._tn] = Std.parseFloat(Std.string(data.get("_table_body_background_saturation")));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_capturing_units"));
							RegCustom._capturing_units[Reg._tn] = false;
							if (_tmp == "true") RegCustom._capturing_units[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._capturing_units_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_capturing_units_number")) != null) RegCustom._capturing_units_number[Reg._tn] = Std.parseInt(data.get("_capturing_units_number"));
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_chess_show_last_piece_moved"));
							RegCustom._chess_show_last_piece_moved[Reg._tn] = false;
							if (_tmp == "true") RegCustom._chess_show_last_piece_moved[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							var _tmp = Std.string(data.get("_chess_future_capturing_units_enabled"));
							RegCustom._chess_future_capturing_units_enabled[Reg._tn] = false;						
							if (_tmp == "true") RegCustom._chess_future_capturing_units_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._chess_future_capturing_units_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_future_capturing_units_number")) != null) RegCustom._chess_future_capturing_units_number[Reg._tn] = Std.parseInt(data.get("_chess_future_capturing_units_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_chess_path_to_king_enabled"));
							RegCustom._chess_path_to_king_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._chess_path_to_king_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._chess_path_to_king_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_path_to_king_number")) != null) RegCustom._chess_path_to_king_number[Reg._tn] = Std.parseInt(data.get("_chess_path_to_king_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._chess_set_for_player1[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_set_for_player1")) != null) RegCustom._chess_set_for_player1[Reg._tn] = Std.parseInt(data.get("_chess_set_for_player1"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._chess_set_for_player2[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_set_for_player2")) != null) RegCustom._chess_set_for_player2[Reg._tn] = Std.parseInt(data.get("_chess_set_for_player2"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._chess_set_for_player1_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_set_for_player1_color_number")) != null) RegCustom._chess_set_for_player1_color_number[Reg._tn] = Std.parseInt(data.get("_chess_set_for_player1_color_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							RegCustom._chess_set_for_player2_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_chess_set_for_player2_color_number")) != null) RegCustom._chess_set_for_player2_color_number[Reg._tn] = Std.parseInt(data.get("_chess_set_for_player2_color_number"));
						}
						catch (e:Dynamic){}	
						
						try
						{
							var _tmp = Std.string(data.get("_chess_opening_moves_enabled"));
							RegCustom._chess_opening_moves_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._chess_opening_moves_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._button_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_button_color_number")) != null) RegCustom._button_color_number[Reg._tn] = Std.parseInt(data.get("_button_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._button_border_color_number[Reg._tn] = 1;
							if (Std.parseInt(data.get("_button_border_color_number")) != null) RegCustom._button_border_color_number[Reg._tn] = Std.parseInt(data.get("_button_border_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._button_text_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_button_text_color_number")) != null) RegCustom._button_text_color_number[Reg._tn] = Std.parseInt(data.get("_button_text_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{							
							var _tmp = Std.string(data.get("_leaderboard_enabled"));
							RegCustom._leaderboard_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._leaderboard_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_house_feature_enabled"));
							RegCustom._house_feature_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._house_feature_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_go_back_to_title_after_save"));
							RegCustom._go_back_to_title_after_save[Reg._tn] = false;
							if (_tmp == "true") RegCustom._go_back_to_title_after_save[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_notation_panel_40_percent_alpha_enabled"));
							RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_notation_panel_same_background_color_enabled"));
							RegCustom._notation_panel_same_background_color_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._notation_panel_same_background_color_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_notation_panel_background_color_enabled"));
							RegCustom._notation_panel_background_color_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._notation_panel_background_color_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._notation_panel_background_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_notation_panel_background_color_number")) != null) RegCustom._notation_panel_background_color_number[Reg._tn] = Std.parseInt(data.get("_notation_panel_background_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._notation_panel_text_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_notation_panel_text_color_number")) != null) RegCustom._notation_panel_text_color_number[Reg._tn] = Std.parseInt(data.get("_notation_panel_text_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._client_topic_title_text_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_client_topic_title_text_color_number")) != null) RegCustom._client_topic_title_text_color_number[Reg._tn] = Std.parseInt(data.get("_client_topic_title_text_color_number"));
						}
						catch (e:Dynamic){}						
						
						try
						{
							RegCustom._client_text_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_client_text_color_number")) != null) RegCustom._client_text_color_number[Reg._tn] = Std.parseInt(data.get("_client_text_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._title_bar_text_color_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_title_bar_text_color_number")) != null) RegCustom._title_bar_text_color_number[Reg._tn] = Std.parseInt(data.get("_title_bar_text_color_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._profile_avatar_number1[Reg._tn] = "0.png";
							
							if (Std.string(data.get("_profile_avatar_number1")) != ""
							&&	Std.string(data.get("_profile_avatar_number1")) != "null") RegCustom._profile_avatar_number1[Reg._tn] = Std.string(data.get("_profile_avatar_number1"));
						}
						catch (e:Dynamic){}
						
						try
						{	
							RegCustom._profile_avatar_number2[Reg._tn] = "0.png";
							
							if (Std.string(data.get("_profile_avatar_number2")) != ""
							&&	Std.string(data.get("_profile_avatar_number2")) != "null") RegCustom._profile_avatar_number2[Reg._tn] = Std.string(data.get("_profile_avatar_number2"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._profile_avatar_number3[Reg._tn] = "0.png";
							
							if (Std.string(data.get("_profile_avatar_number3")) != ""
							&&	Std.string(data.get("_profile_avatar_number3")) != "null") RegCustom._profile_avatar_number3[Reg._tn] = Std.string(data.get("_profile_avatar_number3"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._profile_avatar_number4[Reg._tn] = "0.png";
							
							if (Std.string(data.get("_profile_avatar_number4")) != ""
							&&	Std.string(data.get("_profile_avatar_number4")) != "null") RegCustom._profile_avatar_number4[Reg._tn] = Std.string(data.get("_profile_avatar_number4"));
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_send_automatic_start_game_request"));
							RegCustom._send_automatic_start_game_request[Reg._tn] = false;
							if (_tmp == "true") RegCustom._send_automatic_start_game_request[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_accept_automatic_start_game_request"));
							RegCustom._accept_automatic_start_game_request[Reg._tn] = false;
							if (_tmp == "true") RegCustom._accept_automatic_start_game_request[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_to_lobby_from_waiting_room_confirmation"));
							RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_to_lobby_from_game_room_confirmation"));
							RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_to_lobby_from_game_room_confirmation"));
							RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_to_game_room_from_waiting_room_confirmation"));
							RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_to_title_from_game_room_confirmation"));
							RegCustom._to_title_from_game_room_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._to_title_from_game_room_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_chat_when_at_lobby_enabled"));
							RegCustom._chat_when_at_lobby_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._chat_when_at_lobby_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_timer_enabled"));
							RegCustom._timer_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._timer_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_chat_when_at_room_enabled"));
							RegCustom._chat_when_at_room_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._chat_when_at_room_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_move_total_enabled"));
							RegCustom._move_total_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._move_total_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_notation_panel_enabled"));
							RegCustom._notation_panel_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._notation_panel_enabled[Reg._tn] = true;					
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_start_game_offline_confirmation"));
							RegCustom._start_game_offline_confirmation[Reg._tn] = false;
							if (_tmp == "true") RegCustom._start_game_offline_confirmation[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{	
							var _tmp = Std.string(data.get("_music_enabled"));
							RegCustom._music_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._music_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							var _tmp = Std.string(data.get("_sound_enabled"));
							RegCustom._sound_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._sound_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						try
						{
							var _array_tmp = Std.string(data.get("_time_remaining_for_game"));
							var _array = _array_tmp.split(",");
							
							if (Std.parseInt(_array[0]) != null) RegCustom._time_remaining_for_game[Reg._tn][0] = Std.parseInt(_array[0]);
							if (Std.parseInt(_array[1]) != null) RegCustom._time_remaining_for_game[Reg._tn][1] = Std.parseInt(_array[1]);
							if (Std.parseInt(_array[2]) != null) RegCustom._time_remaining_for_game[Reg._tn][2] = Std.parseInt(_array[2]);
							if (Std.parseInt(_array[3]) != null) RegCustom._time_remaining_for_game[Reg._tn][3] = Std.parseInt(_array[3]);
							if (Std.parseInt(_array[4]) != null) RegCustom._time_remaining_for_game[Reg._tn][4] = Std.parseInt(_array[4]);
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._title_bar_background_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_title_bar_background_number")) != null) RegCustom._title_bar_background_number[Reg._tn] = Std.parseInt(data.get("_title_bar_background_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._menu_bar_background_number[Reg._tn] = 1;
							
							if (Std.parseInt(data.get("_menu_bar_background_number")) != null) RegCustom._menu_bar_background_number[Reg._tn] = Std.parseInt(data.get("_menu_bar_background_number"));
						}
						catch (e:Dynamic){}
						
						try
						{	
							RegCustom._title_bar_background_brightness[Reg._tn] = 1;
							
							if (Std.string(data.get("_title_bar_background_brightness")) != ""
							&&	Std.string(data.get("_title_bar_background_brightness")) != "null") RegCustom._title_bar_background_brightness[Reg._tn] = Std.parseFloat(Std.string(data.get("_title_bar_background_brightness")));
						}
						catch (e:Dynamic){}
						
						try
						{	
							RegCustom._menu_bar_background_brightness[Reg._tn] = 1; 
							
							if (Std.string(data.get("_menu_bar_background_brightness")) != ""
							&&	Std.string(data.get("_menu_bar_background_brightness")) != "null") RegCustom._menu_bar_background_brightness[Reg._tn] = Std.parseFloat(Std.string(data.get("_menu_bar_background_brightness")));
						}
						catch (e:Dynamic){}
						
						try
						{
							RegCustom._world_flags_number[Reg._tn] = 0;
							
							if (Std.parseInt(data.get("_world_flags_number")) != null) RegCustom._world_flags_number[Reg._tn] = Std.parseInt(data.get("_world_flags_number"));
						}
						catch (e:Dynamic){}
						
						try
						{
							var _tmp = Std.string(data.get("_pager_enabled"));
							RegCustom._pager_enabled[Reg._tn] = false;
							if (_tmp == "true") RegCustom._pager_enabled[Reg._tn] = true;
						}
						catch (e:Dynamic){}
						
						
					}
					
				}			
			} 
			
			else 
			{
				trace('"$_directory" does not exists');
				Reg._tn = 0;
			}
			
			Reg._tn_total = Reg._tn; // gets the total themes in the theme folder.
			Reg._tn = _tn_temp; // _tn_temp was used at the top of this function to remember that last selected theme.
			
			// this sets the theme number that is in use. getting the value from the theme name seen at the top right corner of the configuration menu.
			for (i in 0... RegCustom._theme_name.length)
			{
				if (RegCustom._theme_name[i] == RegCustom._theme_name_current)
					Reg._tn = i;
			}
			
			if (Reg._tn + 1 > RegCustom._theme_name.length)
				Reg._tn = 0;
		#end
		
	}
  	
	// the values of this function will be changed when after the next theme is read from the themes folder. this function only pushes the array so that the theme can populate these vars.
	static public function push_next_theme():Void
	{
		RegCustom._gameboard_units_odd_shade_number.push([1, 3]);
		RegCustom._gameboard_units_even_shade_number.push([9, 1]);
		RegCustom._gameboard_units_odd_color_number.push([3, 1]);
		RegCustom._gameboard_units_even_color_number.push([12, 10]);
		RegCustom._username_suggestions_enabled.push(true);
		RegCustom._gameboard_border_enabled.push(true);
		RegCustom._gameboard_border_number.push(1);		
		RegCustom._gameboard_coordinates_enabled.push(true);		
		RegCustom._gameboard_even_units_show_enabled.push(true);
		RegCustom._gradient_background_enabled.push(false);
		RegCustom._gradient_background_image_number.push(1);
		RegCustom._texture_background_enabled.push(false);
		RegCustom._texture_background_image_number.push(1);
		RegCustom._client_background_enabled.push(true);
		RegCustom._client_background_image_number.push(10);
		RegCustom._client_background_brightness.push(0.65);
		RegCustom._client_background_saturation.push(0.7);
		RegCustom._background_alpha_enabled.push(false);
		RegCustom._table_body_background_image_number.push(10);
		RegCustom._table_body_background_brightness.push(0.3);
		RegCustom._table_body_background_saturation.push(0.7);		
		RegCustom._capturing_units.push(true);
		RegCustom._capturing_units_number.push(11);
		RegCustom._chess_show_last_piece_moved.push(true);
		RegCustom._chess_future_capturing_units_enabled.push(true);
		RegCustom._chess_future_capturing_units_number.push(10);
		RegCustom._chess_path_to_king_enabled.push(true);
		RegCustom._chess_path_to_king_number.push(9);
		RegCustom._chess_set_for_player1.push(6);
		RegCustom._chess_set_for_player2.push(6);
		RegCustom._chess_set_for_player1_color_number.push(1);
		RegCustom._chess_set_for_player2_color_number.push(13);
		RegCustom._chess_opening_moves_enabled.push(true);		
		RegCustom._button_color_number.push(10);
		RegCustom._button_border_color_number.push(13);
		RegCustom._button_text_color_number.push(1);
		RegCustom._leaderboard_enabled.push(true);
		RegCustom._house_feature_enabled.push(false);
		RegCustom._go_back_to_title_after_save.push(false);
		RegCustom._notation_panel_40_percent_alpha_enabled.push(true);
		RegCustom._notation_panel_same_background_color_enabled.push(true);
		RegCustom._notation_panel_background_color_enabled.push(true);
		RegCustom._notation_panel_background_color_number.push(10);
		RegCustom._notation_panel_text_color_number.push(1);
		RegCustom._client_topic_title_text_color_number.push(1);		
		RegCustom._client_text_color_number.push(1);
		RegCustom._title_bar_text_color_number.push(11);		
		RegCustom._profile_avatar_number1.push("0.png");
		RegCustom._profile_avatar_number2.push("0.png");
		RegCustom._profile_avatar_number3.push("0.png");
		RegCustom._profile_avatar_number4.push("0.png");
		RegCustom._send_automatic_start_game_request.push(false);
		RegCustom._accept_automatic_start_game_request.push(false);	
		RegCustom._to_lobby_from_waiting_room_confirmation.push(true);
		RegCustom._to_lobby_from_game_room_confirmation.push(true);
		RegCustom._to_game_room_from_waiting_room_confirmation.push(true);
		RegCustom._to_title_from_game_room_confirmation.push(true);
		RegCustom._chat_when_at_lobby_enabled.push(true);
		RegCustom._timer_enabled.push(true);		
		RegCustom._chat_when_at_room_enabled.push(true);
		RegCustom._move_total_enabled.push(true);
		RegCustom._notation_panel_enabled.push(true);
		RegCustom._start_game_offline_confirmation.push(false);
		RegCustom._music_enabled.push(true);
		RegCustom._sound_enabled.push(true);
		RegCustom._time_remaining_for_game.push([15, 15, 15, 15, 30]);
		RegCustom._title_bar_background_number.push(10);
		RegCustom._menu_bar_background_number.push(10);
		RegCustom._title_bar_background_brightness.push(0.5);
		RegCustom._menu_bar_background_brightness.push(0.5);
		RegCustom._world_flags_number.push(0);
		RegCustom._pager_enabled.push(true);
		
	}
	
	/******************************
	 * at the Configurations.hx the configurations are loaded from here.
	 * see Reg2.resetConfigurationVars().
	 */
	public static function loadConfig(_load_item = false):Void
	{
		//RegCustom.resetConfigurationVars();
		
		#if !html5
			if (_gameMenu.data._tn != null && Reg._tn == -1)
				Reg._tn = _gameMenu.data._tn;
			
			// load configurations up to the current theme selected. this will avoid a client crash. The reason is theme 1 can be the selected theme when entering the configuration menu but theme 0 would not have been loaded. therefore, theme 0 would not have its created array that Reg._tn would make. the result is a crash. Since array element 1 cannot exist without the element of 0.
			// this code will always display the selected theme when user enters the configuration menu.
			for (i in 0... Reg._tn + 1)
			{
				if (_gameMenu.data._theme_name_current != null)
					RegCustom._theme_name_current = _gameMenu.data._theme_name_current;

				if (_gameMenu.data._chess_skill_level_online != null
				&&  Reg._game_offline_vs_player == false
				&&  Reg._game_offline_vs_cpu == false
				&&	Reg._loggedIn == true
				||  _load_item == true)
				{
					RegCustom._chess_skill_level_online = _gameMenu.data._chess_skill_level_online;
				}
				
			}
				
			for (i in 0...5)
			{
				if (_gameMenu.data._profile_username_p1 != null)
				{
					RegCustom._profile_username_p1[i] = _gameMenu.data._profile_username_p1[i];
					
					if (RegCustom._profile_username_p1[i] == null)
						RegCustom._profile_username_p1[i] = "";
				}	

				if (RegCustom._profile_username_p1[i] == ""
				||	RegCustom._profile_username_p1[i].toLowerCase() == "Guest") RegCustom._profile_username_p1[i] = "Guest1";
						
				if (RegCustom._profile_username_p2 == "") RegCustom._profile_username_p2 = "Guest2";
				
				if (_gameMenu.data._profile_password_p1 != null)
				{
					RegCustom._profile_password_p1[i] = _gameMenu.data._profile_password_p1[i];
					
					if (RegCustom._profile_password_p1[i] == null)
						RegCustom._profile_password_p1[i] = "";
				}
					
				if (_gameMenu.data._profile_email_address_p1 != null)
				{
					RegCustom._profile_email_address_p1[i] = _gameMenu.data._profile_email_address_p1[i];
					
					if (RegCustom._profile_email_address_p1[i] == null)
						RegCustom._profile_email_address_p1[i] = "";
				}
			}
			
			// send email validation code only once pre client session because this Reg var never gets reset.
			if (_gameMenu.data._send_email_address_validation_code != null
			&&	Reg._doOnce_email_address_validate == true)
				RegTypedef._dataAccount._send_email_address_validation_code = RegCustom._send_email_address_validation_code = _gameMenu.data._send_email_address_validation_code;
			
			if (_gameMenu.data._profile_username_p2 != null)
				RegCustom._profile_username_p2 = _gameMenu.data._profile_username_p2;
				
			if (_gameMenu.data._CRN != null)
				CID3._CRN = _gameMenu.data._CRN;
				
			if (_gameMenu.data._profile_avatar_number1 != null)
				RegCustom._profile_avatar_number1[Reg._tn] = _gameMenu.data._profile_avatar_number1;
			
			if (_gameMenu.data._profile_avatar_number2 != null)
				RegCustom._profile_avatar_number2[Reg._tn] = _gameMenu.data._profile_avatar_number2;
			
			if (_gameMenu.data._world_flags_number != null)
				RegCustom._world_flags_number[Reg._tn] = _gameMenu.data._world_flags_number;
				
			_gameMenu.close;			
			
			// this codde is needed twice. the second line is two lines down. this code is used to change the appearence of the scene.
			RegCustom._theme_name_current = RegCustom._theme_name[Reg._tn];
			
			themes_recursive_file_loop();
			
			// this is needed again to update the theme name at the top right corner of the configuration menu.
			RegCustom._theme_name_current = RegCustom._theme_name[Reg._tn];		
			
		#end		
	}
	
	/******************************
	 * at the Configurations.hx the save button was pressed.
	 * see RegCustom.resetConfigurationVars().
	 */
	public static function saveConfig():Void
	{
		RegCustom._theme_name_current = RegCustom._theme_name[Reg._tn];
		
		#if !html5
		
			gameMenu_arrays();
			
			// save data
			_gameMenu.data._tn = Reg._tn;
			
			_gameMenu.data._theme_name_current = RegCustom._theme_name_current;
			
			if (RegCustom._profile_username_p1[CID3._CRN] == ""
			||	RegCustom._profile_username_p1[CID3._CRN].toLowerCase() == "Guest") RegCustom._profile_username_p1[CID3._CRN] = "Guest1";
			
			if (RegCustom._profile_username_p2 == "") RegCustom._profile_username_p2 = "Guest2";
		
			for (i in 0...5)
			{
				_gameMenu.data._profile_username_p1[i] = CID3._group_username_input[i].text;
				
				_gameMenu.data._profile_password_p1[i] = CID3._group_password_input[i].text;	
					
				_gameMenu.data._profile_email_address_p1[i] = CID3._group_email_address_input[i].text;
			}
			
			_gameMenu.data._profile_username_p2 = RegCustom._profile_username_p2;
			
			// this need to be clear or else the old username will be used at next login.
			RegTypedef._dataAccount._username = "";
			
			_gameMenu.data._CRN = CID3._CRN;
			
			_gameMenu.data._send_email_address_validation_code = RegCustom._send_email_address_validation_code;
			
			_gameMenu.data._profile_avatar_number1 = RegCustom._profile_avatar_number1[Reg._tn];
			
			_gameMenu.data._profile_avatar_number2 = RegCustom._profile_avatar_number2[Reg._tn];

			_gameMenu.data._world_flags_number = RegCustom._world_flags_number[Reg._tn];
			
			_gameMenu.data._chess_skill_level_online = RegCustom._chess_skill_level_online;
			
			_gameMenu.flush();
			_gameMenu.close;

			if (Reg._tn > 0) save_theme();
			
		#end
		
		// at every configuration save an email address can be validated. so set this value back to true.
		Reg._doOnce_email_address_validate = true;
		
		// notice after save is clicked from ConfigurationsOutput.saveConfig().
		if (RegCustom._go_back_to_title_after_save[Reg._tn] == false)
			RegTriggers._saveConfig_notice = true;
		else
			FlxG.switchState(new MenuState());
		
		
	}
	
	/******************************
	 * 	Returns `true` if `s` contains `value` and  `false` otherwise.
		When `value` is `null`, the result is unspecified.
	 */
	public static inline function contains(s:String, value:String):Bool {
		#if (js && js_es >= 6)
		return (cast s).includes(value);
		#else 
		return s.indexOf(value) != -1;
		#end
	}
	
	// arrays for the save/load functions.
	private static function gameMenu_arrays():Void
	{
		_gameMenu.data._theme_name_current = RegCustom._theme_name_current;

		_gameMenu.data._gameboard_units_odd_shade_number = new Array<Array<Int>>();
		
		_gameMenu.data._gameboard_units_even_shade_number = new Array<Array<Int>>();
		
		_gameMenu.data._gameboard_units_odd_color_number = new Array<Array<Int>>();
		
		_gameMenu.data._gameboard_units_even_color_number = new Array<Array<Int>>();
		
		_gameMenu.data._time_remaining_for_game = new Array<Array<Int>>();
		
		_gameMenu.data._profile_username_p1 = new Array<String>();
		_gameMenu.data._profile_password_p1 = new Array<String>();
		_gameMenu.data._profile_email_address_p1 = new Array<String>();
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
					RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[0];
				}
				
				if (_int == 1)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[1];
					RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[1];					
				}
				
				if (_int == 2) 
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[2];
					RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[2];
				}
				
				if (_int == 3)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[3];
					RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[3];
				}
				
				if (_int == 4)
				{
					Reg2._offline_cpu_host_name2 = Reg2._offline_cpu_host_names[4];
					RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[4];
				}
			}
			
			var _int = Std.random(4);
			
			// assign the computer host name that will be used when playing a 3 player offline game.
			if (Reg2._offline_cpu_host_name3 == "")
			{
				if (_int == 0) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[0];
					RegCustom._profile_avatar_number3[Reg._tn] = Reg2._offline_cpu_avatar_number[0];
				}
				
				if (_int == 1) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[1];
					RegCustom._profile_avatar_number3[Reg._tn] = Reg2._offline_cpu_avatar_number[1];
				}
				
				if (_int == 2)
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[2];
					RegCustom._profile_avatar_number3[Reg._tn] = Reg2._offline_cpu_avatar_number[2];
				}
				
				if (_int == 3)
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[3];
					RegCustom._profile_avatar_number3[Reg._tn] = Reg2._offline_cpu_avatar_number[3];
				}
				
				if (_int == 4) 
				{
					Reg2._offline_cpu_host_name3 = Reg2._offline_cpu_host_names[4];
					RegCustom._profile_avatar_number3[Reg._tn] = Reg2._offline_cpu_avatar_number[4];
				}
				
			}

			// Reg._cpu_host_name1 and Reg._cpu_host_name2 are now with a host name but if they have the same host name then clear these var data so that the loop can continue.
			// note that this will always be true for the first loop because random values are not truly random if the seed is not set.
			if (Reg2._offline_cpu_host_name2 == Reg2._offline_cpu_host_name3)
			{
				Reg2._offline_cpu_host_name2 = "";
				Reg2._offline_cpu_host_name3 = "";
				
				RegCustom._profile_avatar_number2[Reg._tn] = "0.png";
				RegCustom._profile_avatar_number3[Reg._tn] = "0.png";
			}			
		}
	}
	
	/******************************
	 * this creates a list of all games that can be selected to play.
	 */
	public static function gameIds_create(exclude:Bool = false):Void
	{
		if (exclude == false) Reg._total_games_excluded_from_list = 0;
		
		Reg2._gameIds_that_can_be_selected.slice(0, Reg2._gameIds_that_can_be_selected.length);
		
		#if checkers
			Reg2._gameIds_that_can_be_selected.push(0);
		#end

		#if chess
			Reg2._gameIds_that_can_be_selected.push(1);
		#end

		#if reversi
			Reg2._gameIds_that_can_be_selected.push(2);
		#end

		#if snakesAndLadders
			Reg2._gameIds_that_can_be_selected.push(3);
		#end

		#if wheelEstate
			if (Reg._total_games_excluded_from_list == 0)
				Reg2._gameIds_that_can_be_selected.push(4);
		#end
		
	}
	
	/******************************
	 * this creates the FlxSprite of each available game that can be selected to play.
	 */
	public static function gameIds_draw_sprite(_this:FlxState):Void
	{	
		// everytime enetering this function, clear this array because it will now be populated.
		Reg2._gameId_sprite.splice(0, Reg2._gameId_sprite.length);
		
		for (i in 0... Reg._total_games_in_release - Reg._total_games_excluded_from_list)
		{
			Reg2._gameId_sprite[i] = new FlxSprite(75 + ( i * 255), 120, "assets/images/gameId" + Reg2._gameIds_that_can_be_selected[i] + ".png");
			Reg2._gameId_sprite[i].scrollFactor.set(0, 0);
			_this.add(Reg2._gameId_sprite[i]);
		}
		
		Reg2._gameId_sprite_highlight = new FlxSprite(75, 120);
		Reg2._gameId_sprite_highlight.loadGraphic("assets/images/gamesBorder.png", true, 240, 240); // height is the same value as width.
		Reg2._gameId_sprite_highlight.scrollFactor.set(0, 0);
		Reg2._gameId_sprite_highlight.animation.add("anim", [0, 1], 2);
		Reg2._gameId_sprite_highlight.animation.play("anim");
		Reg2._gameId_sprite_highlight.updateHitbox();
		_this.add(Reg2._gameId_sprite_highlight);
		
		if (Reg._total_games_in_release == 0) 
			Reg2._gameId_sprite_highlight.visible = false;
		
	}
	
	public static function no_game_modules_installed_notice(_this:FlxState):Void
	{
		var _text = new FlxText(15, 100, 0, "No game modules installed.");
		_text.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_text.scrollFactor.set(0, 0);
		_this.add(_text);
	}
	
}//