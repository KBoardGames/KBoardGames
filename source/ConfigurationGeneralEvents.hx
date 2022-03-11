/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * these functions are called after a user clicks a button.
 * @author kboardgames.com
 */
class ConfigurationGeneralEvents extends CID2
{
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
	}
	
	// minus 1 to display a lesser of a shade for these units.
	public function shadeUnitsOddMinus():Void
	{
		RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] -= 1;
		if (RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] == 0) RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] = 9;
		
		shadeToggleUnitsOdd();
	}
	
	// plus 1 to display a greater of a shade for these units.
	public function shadeUnitsOddPlus():Void
	{
		RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] += 1;
		if (RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] == 10) RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] = 1;
		
		shadeToggleUnitsOdd();
	}
	
	/******************************
	 * this toggles the colors of odd board game units.
	 */
	public function shadeToggleUnitsOdd():Void
	{
		CID2._sprite_board_game_unit_odd.loadGraphic("assets/images/scenes/tiles/odd/" + RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId] + ".png");
	}
	
	// minus 1 to display a lesser of a shade for these units.
	public function shadeUnitsEvenMinus()
	{
		RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] -= 1;
		if (RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] == 0) RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] = 9;
		
		shadeToggleUnitsEven();
	}
	
	// plus 1 to display a greater of a shade for these units.
	public function shadeUnitsEvenPlus()
	{
		RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] += 1;
		if (RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] == 10) RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] = 1;
		
		shadeToggleUnitsEven();
	}
	
	/******************************
	 * this toggles the colors of odd board game units.
	 */
	public function shadeToggleUnitsEven():Void
	{
		CID2._sprite_board_game_unit_even.loadGraphic("assets/images/scenes/tiles/even/" + RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId] +".png");
	}	
	
	// minus 1 to display a lesser of a color for these units.
	public function colorUnitsOddMinus()
	{
		RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] -= 1;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] == 0) RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] = 13;
		
		CID2._sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);
	}
	
	// plus 1 to display a greater of a color for these units.
	public function colorUnitsOddPlus()
	{
		RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] += 1;
		if (RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] >= 14) RegCustom._gameboard_units_odd_color_number[Reg._tn][Reg._gameId] = 1;
		
		CID2._sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);
	}	
		
	// minus 1 to display a lesser of a color for these units.
	public function colorUnitsEvenMinus()
	{
		RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] -= 1;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] == 0) RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] = 13;
		
		CID2._sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
	}
	
	// plus 1 to display a greater of a color for these units.
	public function colorUnitsEvenPlus()
	{
		RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] += 1;
		if (RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] >= 14) RegCustom._gameboard_units_even_color_number[Reg._tn][Reg._gameId] = 1;
		
		CID2._sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
	}	
	
	public function gameboard_even_units_show_enabled():Void
	{
		if (RegCustom._gameboard_even_units_show_enabled[Reg._tn] == false)
		{
			RegCustom._gameboard_even_units_show_enabled[Reg._tn] = true;
			CID2._sprite_board_game_unit_even.alpha = 1;
		}
		else
		{
			RegCustom._gameboard_even_units_show_enabled[Reg._tn] = false;
			CID2._sprite_board_game_unit_even.alpha = 0;
		}
			
		CID2._button_gameboard_even_units_show_enabled.label.text = Std.string(RegCustom._gameboard_even_units_show_enabled[Reg._tn]);
	}
	
	public function gameboard_border_enabled():Void
	{
		if (RegCustom._gameboard_border_enabled[Reg._tn] == false)
		{
			RegCustom._gameboard_border_enabled[Reg._tn] = true;
			CID2._sprite_gameboard_border.alpha = 1;
		}
		else
		{
			RegCustom._gameboard_border_enabled[Reg._tn] = false;
			CID2._sprite_gameboard_border.alpha = 0;
		}
			
		CID2._button_gameboard_border_enabled.label.text = Std.string(RegCustom._gameboard_border_enabled[Reg._tn]);
	}
	
	// minus 1 to display a lesser of a shade for these units.
	public function gameboard_border_minus()
	{
		RegCustom._gameboard_border_number[Reg._tn] -= 1;
		if (RegCustom._gameboard_border_number[Reg._tn] == 0) RegCustom._gameboard_border_number[Reg._tn] = 5;
		
		CID2._sprite_gameboard_border.loadGraphic("assets/images/gameboardBorder"+ RegCustom._gameboard_border_number[Reg._tn] +".png");
	}
	
	// plus 1 to display a greater of a shade for these units.
	public function gameboard_border_plus()
	{
		RegCustom._gameboard_border_number[Reg._tn] += 1;
		if (RegCustom._gameboard_border_number[Reg._tn] == 6) RegCustom._gameboard_border_number[Reg._tn] = 1;
		
		CID2._sprite_gameboard_border.loadGraphic("assets/images/gameboardBorder"+ RegCustom._gameboard_border_number[Reg._tn] +".png");
	}
	
	public function gameboard_coordinates_enabled():Void
	{
		if (RegCustom._gameboard_coordinates_enabled[Reg._tn] == false)
		{
			RegCustom._gameboard_coordinates_enabled[Reg._tn] = true;
			CID2._sprite_gameboard_coordinates.alpha = 1;
		}
		else
		{
			RegCustom._gameboard_coordinates_enabled[Reg._tn] = false;
			CID2._sprite_gameboard_coordinates.alpha = 0;
		}
			
		CID2._button_gameboard_coordinates_enabled.label.text = Std.string(RegCustom._gameboard_coordinates_enabled[Reg._tn]);
	}
		
	public function notation_panel_enabled():Void
	{
		if (RegCustom._notation_panel_enabled[Reg._tn] == false)
			RegCustom._notation_panel_enabled[Reg._tn] = true;
		else
			RegCustom._notation_panel_enabled[Reg._tn] = false;
			
		CID2._button_notation_panel_enabled.label.text = Std.string(RegCustom._notation_panel_enabled[Reg._tn]);
	}
			
	public function client_gradient_background_enabled():Void
	{
		if (RegCustom._gradient_background_enabled[Reg._tn] == false)
		{
			RegCustom._gradient_background_enabled[Reg._tn] = true;
			CID2._sprite_gradient_background_image.alpha = 1;
		}
		else
		{
			RegCustom._gradient_background_enabled[Reg._tn] = false;
			CID2._sprite_gradient_background_image.alpha = 0;
		}
			
		CID2._button_gradient_texture_background_enabled.label.text = Std.string(RegCustom._gradient_background_enabled[Reg._tn]);
	}
	
	public function client_gradient_background_number_minus():Void
	{
		RegCustom._gradient_background_image_number[Reg._tn] -= 1;
		if (RegCustom._gradient_background_image_number[Reg._tn] <= 0) RegCustom._gradient_background_image_number[Reg._tn] = 13;
		
		// don't use black.
		if (RegCustom._gradient_background_image_number[Reg._tn] == 12) RegCustom._gradient_background_image_number[Reg._tn] = 11;
		
		CID2._sprite_gradient_background_image.color = RegCustomColors.gradient_color();
	}
	
	public function client_gradient_background_number_plus():Void
	{
		RegCustom._gradient_background_image_number[Reg._tn] += 1;
		if (RegCustom._gradient_background_image_number[Reg._tn] >= 14) RegCustom._gradient_background_image_number[Reg._tn] = 1;
		
		// don't use black.
		if (RegCustom._gradient_background_image_number[Reg._tn] == 12) RegCustom._gradient_background_image_number[Reg._tn] = 13;
		
		CID2._sprite_gradient_background_image.color = RegCustomColors.gradient_color();
	}
	
	public function client_texture_background_enabled():Void
	{
		if (RegCustom._texture_background_enabled[Reg._tn] == false)
		{
			RegCustom._texture_background_enabled[Reg._tn] = true;
			CID2._sprite_texture_background_image.alpha = 1;
		}
		else
		{
			RegCustom._texture_background_enabled[Reg._tn] = false;
			CID2._sprite_texture_background_image.alpha = 0;
		}
			
		CID2._button_client_texture_background_enabled.label.text = Std.string(RegCustom._texture_background_enabled[Reg._tn]);
	}
	
	public function client_texture_background_number_minus():Void
	{
		RegCustom._texture_background_image_number[Reg._tn] -= 1;
		if (RegCustom._texture_background_image_number[Reg._tn] <= 0) RegCustom._texture_background_image_number[Reg._tn] = 8;
		
		CID2._sprite_texture_background_image.loadGraphic("assets/images/scenes/textures/" + Std.string(RegCustom._texture_background_image_number[Reg._tn]) + "b.jpg");
	}
	
	public function client_texture_background_number_plus():Void
	{
		RegCustom._texture_background_image_number[Reg._tn] += 1;
		if (RegCustom._texture_background_image_number[Reg._tn] >= 9) RegCustom._texture_background_image_number[Reg._tn] = 1;
		
		CID2._sprite_texture_background_image.loadGraphic("assets/images/scenes/textures/" + Std.string(RegCustom._texture_background_image_number[Reg._tn]) + "b.jpg");
	}
	
	public function client_background_enabled():Void
	{
		if (RegCustom._client_background_enabled[Reg._tn] == false)
		{
			RegCustom._client_background_enabled[Reg._tn] = true;
			CID2._sprite_client_background_image.alpha = 1;
		}
		else
		{
			RegCustom._client_background_enabled[Reg._tn] = false;
			CID2._sprite_client_background_image.alpha = 0;
		}
			
		CID2._button_client_background_enabled.label.text = Std.string(RegCustom._client_background_enabled[Reg._tn]);
	}
	
	public function client_background_number_minus():Void
	{
		RegCustom._client_background_image_number[Reg._tn] -= 1;
		if (RegCustom._client_background_image_number[Reg._tn] <= 0) RegCustom._client_background_image_number[Reg._tn] = 13;
		
		CID2._sprite_client_background_image.color = RegCustomColors.color_client_background();
	}
	
	public function client_background_number_plus():Void
	{
		RegCustom._client_background_image_number[Reg._tn] += 1;
		if (RegCustom._client_background_image_number[Reg._tn] >= 14) RegCustom._client_background_image_number[Reg._tn] = 1;
		
		CID2._sprite_client_background_image.color = RegCustomColors.color_client_background();
	}
	
	/******************************
	 * when the checkers button is pressed this changes the board game colors for the game to the default colors that seems to be the colors used by a fair amount of websites.
	 */
	public function defaultColorsCheckers():Void
	{
		CID2._group_button_toggle[1].has_toggle = false;
		CID2._group_button_toggle[1].set_toggled(false);
		CID2._group_button_toggle[1].active = true;
			
		CID2._group_button_toggle[0].has_toggle = true;
		CID2._group_button_toggle[0].set_toggled(true);
		CID2._group_button_toggle[0].active = false;
		
		shadeToggleUnitsOdd();
		shadeToggleUnitsEven();
		
		CID2._sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);
		CID2._sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
		
		if (RegCustom._gameboard_even_units_show_enabled[Reg._tn] == false)
			CID2._sprite_board_game_unit_even.alpha = 0;
		else
			CID2._sprite_board_game_unit_even.alpha = 1;
		
	}
	
	/******************************
	 * when the chess button is pressed this changes the board game colors for the game to the colors used by a few popular websites.
	 */
	public function defaultColorsChess():Void
	{
		CID2._group_button_toggle[0].has_toggle = false;
		CID2._group_button_toggle[0].set_toggled(false);
		CID2._group_button_toggle[0].active = true;
		
		CID2._group_button_toggle[1].has_toggle = true;
		CID2._group_button_toggle[1].set_toggled(true);	
		CID2._group_button_toggle[1].active = false;
		
		shadeToggleUnitsOdd();
		shadeToggleUnitsEven();
		
		CID2._sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);
		CID2._sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
		
		if (RegCustom._gameboard_even_units_show_enabled[Reg._tn] == false)
			CID2._sprite_board_game_unit_even.alpha = 0;
		else
			CID2._sprite_board_game_unit_even.alpha = 1;
	}
		
	public function client_background_alpha():Void
	{
		if (RegCustom._background_alpha_enabled[Reg._tn] == false)
			RegCustom._background_alpha_enabled[Reg._tn] = true;
		else
			RegCustom._background_alpha_enabled[Reg._tn] = false;
			
		CID2._button_background_alpha_enabled.label.text = Std.string(RegCustom._background_alpha_enabled[Reg._tn]);
	}
	
	public function leaderboards_enabled():Void
	{
		if (RegCustom._leaderboard_enabled[Reg._tn] == false)
			RegCustom._leaderboard_enabled[Reg._tn] = true;
		else
			RegCustom._leaderboard_enabled[Reg._tn] = false;
			
		CID2._button_leaderboard_enabled.label.text = Std.string(RegCustom._leaderboard_enabled[Reg._tn]);
	}
	
	public function house_feature_enabled():Void
	{
		if (RegCustom._house_feature_enabled[Reg._tn] == false)
			RegCustom._house_feature_enabled[Reg._tn] = true;
		else
			RegCustom._house_feature_enabled[Reg._tn] = false;
			
		CID2._button_house_feature_enabled.label.text = Std.string(RegCustom._house_feature_enabled[Reg._tn]);
	}
	
	public function go_back_to_title_after_save():Void
	{
		if (RegCustom._go_back_to_title_after_save[Reg._tn] == false)
			RegCustom._go_back_to_title_after_save[Reg._tn] = true;
		else
			RegCustom._go_back_to_title_after_save[Reg._tn] = false;
			
		CID2._button_goto_title_enabled.label.text = Std.string(RegCustom._go_back_to_title_after_save[Reg._tn]);
	}
	
	public function automatic_game_request():Void
	{
		if (RegCustom._send_automatic_start_game_request[Reg._tn] == false)
			RegCustom._send_automatic_start_game_request[Reg._tn] = true;
		else
			RegCustom._send_automatic_start_game_request[Reg._tn] = false;
			
		CID2._button_send_automatic_start_game_request.label.text = Std.string(RegCustom._send_automatic_start_game_request[Reg._tn]);
	}
	
	public function start_game_offline_confirmation():Void
	{
		if (RegCustom._start_game_offline_confirmation[Reg._tn] == false)
			RegCustom._start_game_offline_confirmation[Reg._tn] = true;
		else
			RegCustom._start_game_offline_confirmation[Reg._tn] = false;
			
		CID2._button_start_game_offline_confirmation.label.text = Std.string(RegCustom._start_game_offline_confirmation[Reg._tn]);
	}
	
	public function accept_automatic_game_request():Void
	{
		if (RegCustom._accept_automatic_start_game_request[Reg._tn] == false)
			RegCustom._accept_automatic_start_game_request[Reg._tn] = true;
		else
			RegCustom._accept_automatic_start_game_request[Reg._tn] = false;
			
		CID2._button_accept_automatic_start_game_request.label.text = Std.string(RegCustom._accept_automatic_start_game_request[Reg._tn]);
	}
	
	public function to_lobby_waiting_room_confirmation():Void
	{
		if (RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] == false)
			RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] = true;
		else
			RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] = false;
			
		CID2._button_to_lobby_waiting_room_confirmation.label.text = Std.string(RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn]);
	}
	
	public function to_lobby_game_room_confirmation():Void
	{
		if (RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] == false)
			RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = true;
		else
			RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] = false;
			
		CID2._button_to_lobby_game_room_confirmation.label.text = Std.string(RegCustom._to_lobby_from_game_room_confirmation[Reg._tn]);
	}
	
	public function to_game_room_confirmation():Void
	{
		if (RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] == false)
			RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] = true;
		else
			RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] = false;
			
		CID2._button_to_game_room_from_waiting_room.label.text = Std.string(RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn]);
	}
	
	public function to_title_confirmation():Void
	{
		if (RegCustom._to_title_from_game_room_confirmation[Reg._tn] == false)
			RegCustom._to_title_from_game_room_confirmation[Reg._tn] = true;
		else
			RegCustom._to_title_from_game_room_confirmation[Reg._tn] = false;
			
		CID2._button_to_title_from_game_room.label.text = Std.string(RegCustom._to_title_from_game_room_confirmation[Reg._tn]);
	}
	
	public function chat_turn_off_lobby():Void
	{
		if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
			RegCustom._chat_when_at_lobby_enabled[Reg._tn] = false;
		else
			RegCustom._chat_when_at_lobby_enabled[Reg._tn] = true;
			
		CID2._button_chat_turn_off_for_lobby.label.text = Std.string(RegCustom._chat_when_at_lobby_enabled[Reg._tn]);
	}
	
	public function chat_turn_off_room():Void
	{
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
			RegCustom._chat_when_at_room_enabled[Reg._tn] = false;
		else
			RegCustom._chat_when_at_room_enabled[Reg._tn] = true;
			
		CID2._button_chat_turn_off_when_in_room.label.text = Std.string(RegCustom._chat_when_at_room_enabled[Reg._tn]);
	}
	
	public function move_timer_enabled():Void
	{
		if (RegCustom._timer_enabled[Reg._tn] == false)
			RegCustom._timer_enabled[Reg._tn] = true;
		else
			RegCustom._timer_enabled[Reg._tn] = false;
			
		CID2._button_move_timer_enabled.label.text = Std.string(RegCustom._timer_enabled[Reg._tn]);
	}
	
	public function move_total_enabled():Void
	{
		if (RegCustom._move_total_enabled[Reg._tn] == false)
			RegCustom._move_total_enabled[Reg._tn] = true;
		else
			RegCustom._move_total_enabled[Reg._tn] = false;
			
		CID2._button_move_total_enabled.label.text = Std.string(RegCustom._move_total_enabled[Reg._tn]);
	}
	
	public function notation_panel_alpha():Void
	{
		if (RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] == false)
			RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] = true;
		else
			RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn] = false;
			
		CID2._button_notation_panel_40_percent_alpha_enabled.label.text = Std.string(RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn]);
	}
	
	public function notation_panel_same_background_color():Void
	{
		if (RegCustom._notation_panel_same_background_color_enabled[Reg._tn] == false)
			RegCustom._notation_panel_same_background_color_enabled[Reg._tn] = true;
		else
			RegCustom._notation_panel_same_background_color_enabled[Reg._tn] = false;
			
		CID2._button_notation_panel_same_background_color_enabled.label.text = Std.string(RegCustom._notation_panel_same_background_color_enabled[Reg._tn]);
	}
	
	public function notation_background_color():Void
	{
		if (RegCustom._notation_panel_background_color_enabled[Reg._tn] == false)
		{
			RegCustom._notation_panel_background_color_enabled[Reg._tn] = true;
			CID2._sprite_notation_panel_background_color.visible = true;
		}
		else
		{
			RegCustom._notation_panel_background_color_enabled[Reg._tn] = false;
			CID2._sprite_notation_panel_background_color.visible = false;
		}
			
		CID2._button_notation_panel_background_color_enabled.label.text = Std.string(RegCustom._notation_panel_background_color_enabled[Reg._tn]);
	}
	
	public function notation_panel_background_color_minus()
	{
		RegCustom._notation_panel_background_color_number[Reg._tn] -= 1;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] == 0) RegCustom._notation_panel_background_color_number[Reg._tn] = 13;
		
		CID2._sprite_notation_panel_background_color.color = RegCustomColors.notation_panel_background_color();
	}

	public function notation_panel_background_color_plus()
	{
		RegCustom._notation_panel_background_color_number[Reg._tn] += 1;
		if (RegCustom._notation_panel_background_color_number[Reg._tn] >= 14) RegCustom._notation_panel_background_color_number[Reg._tn] = 1;
		
		CID2._sprite_notation_panel_background_color.color = RegCustomColors.notation_panel_background_color();
	}	
	
	// change the text color at the notation panel.
	public function notation_panel_text_color_minus()
	{
		RegCustom._notation_panel_text_color_number[Reg._tn] -= 1;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] == 0) RegCustom._notation_panel_text_color_number[Reg._tn] = 13;
		
		CID2._sprite_notation_panel_text_color.color = RegCustomColors.notation_panel_text_color();
	}
	
	// change the text color at the notation panel.
	public function notation_panel_text_color_plus()
	{
		RegCustom._notation_panel_text_color_number[Reg._tn] += 1;
		if (RegCustom._notation_panel_text_color_number[Reg._tn] >= 14) RegCustom._notation_panel_text_color_number[Reg._tn] = 1;
		
		CID2._sprite_notation_panel_text_color.color = RegCustomColors.notation_panel_text_color();
	}	
	
	// change the topic title text color at the main client text.
	public function client_topic_title_text_color_minus()
	{
		RegCustom._client_topic_title_text_color_number[Reg._tn] -= 1;
		if (RegCustom._client_topic_title_text_color_number[Reg._tn] == 0) RegCustom._client_topic_title_text_color_number[Reg._tn] = 13;
		
		CID2._sprite_client_topic_title_text_color.color = RegCustomColors.client_topic_title_text_color();
	}
	
	// change the topic title text color at the main client text.
	public function client_topic_title_text_color_plus()
	{
		RegCustom._client_topic_title_text_color_number[Reg._tn] += 1;
		if (RegCustom._client_topic_title_text_color_number[Reg._tn] >= 14) RegCustom._client_topic_title_text_color_number[Reg._tn] = 1;
		
		CID2._sprite_client_topic_title_text_color.color = RegCustomColors.client_topic_title_text_color();
	}
		
	// change the text color at the main client text.
	public function client_text_color_minus()
	{
		RegCustom._client_text_color_number[Reg._tn] -= 1;
		if (RegCustom._client_text_color_number[Reg._tn] == 0) RegCustom._client_text_color_number[Reg._tn] = 13;
		
		CID2._sprite_client_text_color.color = RegCustomColors.client_text_color();
	}
	
	// change the text color at the main client text.
	public function client_text_color_plus()
	{
		RegCustom._client_text_color_number[Reg._tn] += 1;
		if (RegCustom._client_text_color_number[Reg._tn] >= 14) RegCustom._client_text_color_number[Reg._tn] = 1;
		
		CID2._sprite_client_text_color.color = RegCustomColors.client_text_color();
	}
	
	// change the text color at the title bar.
	public function title_bar_text_color_minus()
	{
		RegCustom._title_bar_text_color_number[Reg._tn] -= 1;
		if (RegCustom._title_bar_text_color_number[Reg._tn] == 0) RegCustom._title_bar_text_color_number[Reg._tn] = 13;
		
		CID2._sprite_title_bar_text_color.color = RegCustomColors.title_bar_text_color();
	}
	
	// change the text color at the title.
	public function title_bar_text_color_plus()
	{
		RegCustom._title_bar_text_color_number[Reg._tn] += 1;
		if (RegCustom._title_bar_text_color_number[Reg._tn] >= 14) RegCustom._title_bar_text_color_number[Reg._tn] = 1;
		
		CID2._sprite_title_bar_text_color.color = RegCustomColors.title_bar_text_color();
	}	
	
	public function capturing_units_enabled():Void
	{
		if (RegCustom._capturing_units[Reg._tn] == false)
		{
			RegCustom._capturing_units[Reg._tn] = true;
			CID2._sprite_capturing_units.visible = true;
			CID2._sprite_chess_path_to_king_bg.visible = true; // border
		}
		else
		{
			RegCustom._capturing_units[Reg._tn] = false;
			CID2._sprite_capturing_units.visible = false;
			CID2._sprite_chess_path_to_king_bg.visible = false;
		}
		
		CID2._button_capturing_units.label.text = Std.string(RegCustom._capturing_units[Reg._tn]);
	}
	
	public function capturing_units_minus():Void
	{
		RegCustom._capturing_units_number[Reg._tn] -= 1;
		if (RegCustom._capturing_units_number[Reg._tn] == 0) RegCustom._capturing_units_number[Reg._tn] = 13;
		
		CID2._sprite_capturing_units.color = RegCustomColors.color_capturing_units();
	}
	
	// plus 1 to display a greater of a shade for these units.
	public function capturing_units_plus():Void
	{
		RegCustom._capturing_units_number[Reg._tn] += 1;
		if (RegCustom._capturing_units_number[Reg._tn] == 14) RegCustom._capturing_units_number[Reg._tn] = 1;
		
		CID2._sprite_capturing_units.color = RegCustomColors.color_capturing_units();
		
	}
	
	public function client_background_brightness_minus():Void
	{
		if (CID2._text_client_background_brightness.text == "0.15")
			RegCustom._client_background_brightness[Reg._tn] = 0.95;
			
		else if (RegCustom._client_background_brightness[Reg._tn] > 0.15)
			RegCustom._client_background_brightness[Reg._tn] -= 0.05;
		
		CID2._text_client_background_brightness.text = Std.string(RegCustom._client_background_brightness[Reg._tn]);	
	}
	
	
	public function client_background_brightness_plus():Void
	{		
		if (CID2._text_client_background_brightness.text == "0.95")
			RegCustom._client_background_brightness[Reg._tn] = 0.15;
		
		else if (RegCustom._client_background_brightness[Reg._tn] < 0.95) RegCustom._client_background_brightness[Reg._tn] += 0.05;

		CID2._text_client_background_brightness.text = Std.string(RegCustom._client_background_brightness[Reg._tn]);
	}
	
	public function client_background_saturation_minus():Void
	{
		if (CID2._text_client_background_saturation.text == "0.15")
			RegCustom._client_background_saturation[Reg._tn] = 1;
			
		else if (RegCustom._client_background_saturation[Reg._tn] > 0.15)
			RegCustom._client_background_saturation[Reg._tn] -= 0.05;
		
		CID2._text_client_background_saturation.text = Std.string(RegCustom._client_background_saturation[Reg._tn]);	
	}


	public function client_background_saturation_plus():Void
	{		
		if (CID2._text_client_background_saturation.text == "1")
			RegCustom._client_background_saturation[Reg._tn] = 0.15;
		
		else if (RegCustom._client_background_saturation[Reg._tn] < 1) RegCustom._client_background_saturation[Reg._tn] += 0.05;

		CID2._text_client_background_saturation.text = Std.string(RegCustom._client_background_saturation[Reg._tn]);
	}
	
	public function table_body_background_minus():Void
	{
		RegCustom._table_body_background_image_number[Reg._tn] -= 1;
		if (RegCustom._table_body_background_image_number[Reg._tn] <= 0) RegCustom._table_body_background_image_number[Reg._tn] = 13;
		
		CID2._sprite_table_body_background_image.color = RegCustomColors.color_table_body_background();
	}
	
	public function table_body_background_plus():Void
	{
		RegCustom._table_body_background_image_number[Reg._tn] += 1;
		if (RegCustom._table_body_background_image_number[Reg._tn] >= 14) RegCustom._table_body_background_image_number[Reg._tn] = 1;
		
		CID2._sprite_table_body_background_image.color = RegCustomColors.color_table_body_background();
	}
	
	
	public function table_body_background_brightness_minus():Void
	{
		if (CID2._text_table_body_background_brightness.text == "0.15")
			RegCustom._table_body_background_brightness[Reg._tn] = 1;
			
		else if (RegCustom._table_body_background_brightness[Reg._tn] > 0.15)
			RegCustom._table_body_background_brightness[Reg._tn] -= 0.05;
		
		CID2._text_table_body_background_brightness.text = Std.string(RegCustom._table_body_background_brightness[Reg._tn]);	
	}


	public function table_body_background_brightness_plus():Void
	{		
		if (CID2._text_table_body_background_brightness.text == "1")
			RegCustom._table_body_background_brightness[Reg._tn] = 0.15;
		
		else if (RegCustom._table_body_background_brightness[Reg._tn] < 1) RegCustom._table_body_background_brightness[Reg._tn] += 0.05;

		CID2._text_table_body_background_brightness.text = Std.string(RegCustom._table_body_background_brightness[Reg._tn]);
	}
	
	public function table_body_background_saturation_minus():Void
	{
		if (CID2._text_table_body_background_saturation.text == "0.15")
			RegCustom._table_body_background_saturation[Reg._tn] = 1;
			
		else if (RegCustom._table_body_background_saturation[Reg._tn] > 0.15)
			RegCustom._table_body_background_saturation[Reg._tn] -= 0.05;
		
		CID2._text_table_body_background_saturation.text = Std.string(RegCustom._table_body_background_saturation[Reg._tn]);	
	}


	public function table_body_background_saturation_plus():Void
	{		
		if (CID2._text_table_body_background_saturation.text == "1")
			RegCustom._table_body_background_saturation[Reg._tn] = 0.15;
		
		else if (RegCustom._table_body_background_saturation[Reg._tn] < 1) RegCustom._table_body_background_saturation[Reg._tn] += 0.05;

		CID2._text_table_body_background_saturation.text = Std.string(RegCustom._table_body_background_saturation[Reg._tn]);
	}
	
	/******************************
	 * apply a fill color to the example buttom. that button is used to show the changes of the fill color, border color and text color.
	 */
	public function button_background_color()
	{
		RegCustom._button_color_number[Reg._tn] += 1;
		if (RegCustom._button_color_number[Reg._tn] >= 14) RegCustom._button_color_number[Reg._tn] = 1;
		
		// new button color.
		RegCustom._button_color[Reg._tn] = RegCustomColors.button_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		var _offset = 0;
		
		if (CID2._button_color_output != null)
		{			
			CID2._group.remove(CID2._button_color_output);
			remove(CID2._button_color_output);
			CID2._button_color_output.destroy();
			
			// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
			// this is needed to display the new button at the correct coordinates.
			_offset = -770;
		}
		
		CID2._button_color_output = new ButtonGeneralNetworkNo(CID2._question_button_colors_output.x + CID2._question_button_colors_output.fieldWidth + 15, CID2._button_color.y + 7 + _offset, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_output.label.font = Reg._fontDefault;
		CID2._button_color_output.scrollFactor.set(0, 0);
		CID2._group.add(CID2._button_color_output);
		add(CID2._button_color_output);
	}
		
	public function button_border_color()
	{
		RegCustom._button_border_color_number[Reg._tn] += 1;
		if (RegCustom._button_border_color_number[Reg._tn] >= 14) RegCustom._button_border_color_number[Reg._tn] = 1;
		
		// new button color.
		RegCustom._button_border_color[Reg._tn] = RegCustomColors.button_border_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		var _offset = 0;
		
		if (CID2._button_color_output != null)
		{			
			CID2._group.remove(CID2._button_color_output);
			remove(CID2._button_color_output);
			CID2._button_color_output.destroy();
			
			// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
			// this is needed to display the new button at the correct coordinates.
			_offset = -770;
		}
		
		CID2._button_color_output = new ButtonGeneralNetworkNo(CID2._question_button_colors_output.x + CID2._question_button_colors_output.fieldWidth + 15, CID2._button_color.y + 7 + _offset, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_output.label.font = Reg._fontDefault;
		CID2._button_color_output.scrollFactor.set(0, 0);
		CID2._group.add(CID2._button_color_output);
		add(CID2._button_color_output);
	}
	
	public function button_text_color()
	{
		RegCustom._button_text_color_number[Reg._tn] += 1;
		if (RegCustom._button_text_color_number[Reg._tn] >= 14) RegCustom._button_text_color_number[Reg._tn] = 1;
		
		// new button color.
		RegCustom._button_text_color[Reg._tn] = RegCustomColors.button_text_colors();
		
		// the below code will remove the example buttonfrom the scene.  
		// the button will be redisplay to show the new button's fill color.
		var _offset = 0;
		
		if (CID2._button_color_output != null)
		{			
			CID2._group.remove(CID2._button_color_output);
			remove(CID2._button_color_output);
			CID2._button_color_output.destroy();
			
			// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
			// this is needed to display the new button at the correct coordinates.
			_offset = -770;
		}
		
		CID2._button_color_output = new ButtonGeneralNetworkNo(CID2._question_button_colors_output.x + CID2._question_button_colors_output.fieldWidth + 15, CID2._button_border_color.y + 7 + _offset, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_output.label.font = Reg._fontDefault;
		CID2._button_color_output.scrollFactor.set(0, 0);
		CID2._group.add(CID2._button_color_output);
		add(CID2._button_color_output);
	}
	
	public function music_enabled():Void
	{
		if (RegCustom._music_enabled[Reg._tn] == false)
			RegCustom._music_enabled[Reg._tn] = true;
		else
			RegCustom._music_enabled[Reg._tn] = false;
			
		CID2._button_music_enabled.label.text = Std.string(RegCustom._music_enabled[Reg._tn]);
	}
	
	public function sound_enabled():Void
	{
		if (RegCustom._sound_enabled[Reg._tn] == false)
			RegCustom._sound_enabled[Reg._tn] = true;
		else
			RegCustom._sound_enabled[Reg._tn] = false;
			
		CID2._button_sound_enabled.label.text = Std.string(RegCustom._sound_enabled[Reg._tn]);
	}
	
	public function title_bar_background_number_minus()
	{
		RegCustom._title_bar_background_number[Reg._tn] -= 1;
		if (RegCustom._title_bar_background_number[Reg._tn] == 0) RegCustom._title_bar_background_number[Reg._tn] = 13;
		
		CID2._sprite_title_bar_background_color.color = RegCustomColors.title_bar_background_color();
	}
	
	public function title_bar_background_number_plus()
	{
		RegCustom._title_bar_background_number[Reg._tn] += 1;
		if (RegCustom._title_bar_background_number[Reg._tn] >= 14) RegCustom._title_bar_background_number[Reg._tn] = 1;
		
		CID2._sprite_title_bar_background_color.color = RegCustomColors.title_bar_background_color();
	}
	
	public function title_bar_background_brightness_minus():Void
	{
		if (CID2._text_title_bar_background_brightness.text == "0.15")
			RegCustom._title_bar_background_brightness[Reg._tn] = 1;
			
		else if (RegCustom._title_bar_background_brightness[Reg._tn] > 0.15)
			RegCustom._title_bar_background_brightness[Reg._tn] -= 0.05;
		
		CID2._text_title_bar_background_brightness.text = Std.string(RegCustom._title_bar_background_brightness[Reg._tn]);	
	}

	public function title_bar_background_brightness_plus():Void
	{		
		if (CID2._text_title_bar_background_brightness.text == "1")
			RegCustom._title_bar_background_brightness[Reg._tn] = 0.15;
		
		else if (RegCustom._title_bar_background_brightness[Reg._tn] < 1) RegCustom._title_bar_background_brightness[Reg._tn] += 0.05;

		CID2._text_title_bar_background_brightness.text = Std.string(RegCustom._title_bar_background_brightness[Reg._tn]);
	}
	
	public function menu_bar_background_brightness_minus():Void
	{
		if (CID2._text_menu_bar_background_brightness.text == "0.15")
			RegCustom._menu_bar_background_brightness[Reg._tn] = 1;
			
		else if (RegCustom._menu_bar_background_brightness[Reg._tn] > 0.15)
			RegCustom._menu_bar_background_brightness[Reg._tn] -= 0.05;
		
		CID2._text_menu_bar_background_brightness.text = Std.string(RegCustom._menu_bar_background_brightness[Reg._tn]);	
	}

	public function menu_bar_background_brightness_plus():Void
	{		
		if (CID2._text_menu_bar_background_brightness.text == "1")
			RegCustom._menu_bar_background_brightness[Reg._tn] = 0.15;
		
		else if (RegCustom._menu_bar_background_brightness[Reg._tn] < 1) RegCustom._menu_bar_background_brightness[Reg._tn] += 0.05;

		CID2._text_menu_bar_background_brightness.text = Std.string(RegCustom._menu_bar_background_brightness[Reg._tn]);
	}
	
	public function menu_bar_background_number_minus()
	{
		RegCustom._menu_bar_background_number[Reg._tn] -= 1;
		if (RegCustom._menu_bar_background_number[Reg._tn] == 0) RegCustom._menu_bar_background_number[Reg._tn] = 13;
		
		CID2._sprite_menu_bar_background_color.color = RegCustomColors.menu_bar_background_color();
	}
	
	public function menu_bar_background_number_plus()
	{
		RegCustom._menu_bar_background_number[Reg._tn] += 1;
		if (RegCustom._menu_bar_background_number[Reg._tn] >= 14) RegCustom._menu_bar_background_number[Reg._tn] = 1;
		
		CID2._sprite_menu_bar_background_color.color = RegCustomColors.menu_bar_background_color();
	}	
	
	public function pager_enabled():Void
	{
		if (RegCustom._pager_enabled[Reg._tn] == false)
			RegCustom._pager_enabled[Reg._tn] = true;
		else
			RegCustom._pager_enabled[Reg._tn] = false;
			
		CID2._button_pager_enabled.label.text = Std.string(RegCustom._pager_enabled[Reg._tn]);
	}
	
	public function scene_transition_number_minus()
	{
		RegCustom._scene_transition_number[Reg._tn] -= 1;
		if (RegCustom._scene_transition_number[Reg._tn] == -1) RegCustom._scene_transition_number[Reg._tn] = 5;
		
		CID2._text_scene_transition_number.text = Std.string(RegCustom._scene_transition_number[Reg._tn]);
	}
	
	public function scene_transition_number_plus()
	{
		RegCustom._scene_transition_number[Reg._tn] += 1;
		if (RegCustom._scene_transition_number[Reg._tn] >= 6) RegCustom._scene_transition_number[Reg._tn] = 0;
		
		CID2._text_scene_transition_number.text = Std.string(RegCustom._scene_transition_number[Reg._tn]);
	}
	
	
	
	
	
	
	
	
	
	public function title_icon_number_minus()
	{
		RegCustom._title_icon_number[Reg._tn] -= 1;
		if (RegCustom._title_icon_number[Reg._tn] == 0) RegCustom._title_icon_number[Reg._tn] = 13;
		
		CID2._sprite_title_icon_color.color = RegCustomColors.title_icon_color();
	}
	
	public function title_icon_number_plus()
	{
		RegCustom._title_icon_number[Reg._tn] += 1;
		if (RegCustom._title_icon_number[Reg._tn] >= 14) RegCustom._title_icon_number[Reg._tn] = 1;
		
		CID2._sprite_title_icon_color.color = RegCustomColors.title_icon_color();
	}

}//