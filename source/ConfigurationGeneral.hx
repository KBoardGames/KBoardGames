/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class ConfigurationGeneral extends CID2
{
	/******************************
	 * used to draw the UI to scene. The first ten user options do not change order. therefore, this value will always start at 10. it starts at 10 not 11 because the first line of a function that is used to draw the UI will increase this value by 1.
	 */
	private var _num = 10;
	
	// this class is created when clicking the gear button. It is used to display scrollbar configuration content of either games, general or profile category.
	private var __configurations_output:ConfigurationOutput;
	
	// if mobile then this subState is called when user keyboard input is needed.
	private var __action_keyboard:ActionKeyboard;
	
	/******************************
	 * an event is executed after a user clicks a button. these are the events for this class.
	 */
	private var __e:ConfigurationGeneralEvents;
	
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
		
		__configurations_output = menu_configurations_output;
		__e = new ConfigurationGeneralEvents(menu_configurations_output);
		add(__e);
		
		sceneGeneral();		
		
		if (RegCustom._gameboard_even_units_show_enabled[Reg._tn] == false)
			CID2._sprite_board_game_unit_even.alpha = 0;
		else
			CID2._sprite_board_game_unit_even.alpha = 1;
		
		// add configuration options here.
		initiate();
		
		// DO NOT FORGET TO UPDATE THE buttonNumber() FUNCTiON.
		CID2._text_empty = new ButtonGeneralNetworkNo(0, CID2._button_pager_enabled.y + 250, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._text_empty.visible = false;
		CID2._group.add(CID2._text_empty);
		
		__e.defaultColorsCheckers();
		__configurations_output.buttonToggle();
		
	}
	
	public function sceneGeneral():Void
	{
		// reset this var here because it is used before playing a game to set Reg._gameId value at this class so that the game board colors are set the the game selected.
		Reg._gameId = 0;
		
		CID2._group = cast add(new FlxSpriteGroup());
		CID2._group.members.splice(0, CID2._group.members.length);
		CID2._group_button.splice(0, CID2._group_button.length);
		CID2._group_button_toggle.splice(0, CID2._group_button_toggle.length);
		
		var _topic_title = new FlxText(0, 100, 0, "Gameboard");
		_topic_title.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		_topic_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_topic_title.screenCenter(X);
		CID2._group.add(_topic_title);
		
		
		//############################# checkers and chess default board colors.
		var _default_colors_title = new FlxText(0, 0, 0, "Gameboard Colors");
		_default_colors_title.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_default_colors_title.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (_default_colors_title.fieldWidth / 2) + CID2._offset_x, 100 + (CID2._offset_y * 2));
		_default_colors_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(_default_colors_title);
		
		CID2._button_default_colors_checkers = new ButtonToggleFlxState(_default_colors_title.x + (_default_colors_title.fieldWidth / 2) - 200 - 7, _default_colors_title.y + 50 - 3, 1, "Checkers", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_default_colors_checkers.label.font = Reg._fontDefault;
		CID2._button_default_colors_checkers.set_toggled(true);
		CID2._button_default_colors_checkers.has_toggle = true;
		CID2._group_button_toggle.push(CID2._button_default_colors_checkers);
		CID2._group.add(CID2._group_button_toggle[0]);
		
		CID2._button_default_colors_chess = new ButtonToggleFlxState(_default_colors_title.x + (_default_colors_title.fieldWidth / 2) + 7, _default_colors_title.y + 50 - 3, 2, "Chess", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_default_colors_chess.label.font = Reg._fontDefault;
		CID2._button_default_colors_chess.set_toggled(false);
		CID2._button_default_colors_chess.has_toggle = false;	
		CID2._group_button_toggle.push(CID2._button_default_colors_chess);
		CID2._group.add(CID2._group_button_toggle[1]);
		
		// title text for odd and even units.
		CID2._text_title_odd_units = new FlxText(0, 0, 0, "Odd Units");
		CID2._text_title_odd_units.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_title_odd_units.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (CID2._text_title_odd_units.fieldWidth / 2) + CID2._offset_x, CID2._button_default_colors_chess.y + 95);
		CID2._text_title_odd_units.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_title_odd_units);	
		
		//-----------------------------
		
		// color applied to a shaded unit.
		CID2._text_odd_units_shade = new TextGeneral((CID2._text_title_odd_units.x + CID2._text_title_odd_units.fieldWidth / 2) - 225, CID2._text_title_odd_units.y + 40, 0, "Shade\r\n", 8, true, true);
		CID2._text_odd_units_shade.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_odd_units_shade.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_odd_units_shade);	
		
		CID2._text_title_even_units = new FlxText(0, 0, 0, "Even Units");
		CID2._text_title_even_units.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_title_even_units.setPosition((FlxG.width / 2) + (FlxG.width / 4) - (CID2._text_title_even_units.fieldWidth / 2) + CID2._offset_x, CID2._text_odd_units_shade.y + 75);
		CID2._text_title_even_units.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_title_even_units);	
		
		CID2._text_even_units_shade = new TextGeneral((CID2._text_title_even_units.x + CID2._text_title_even_units.fieldWidth / 2) - 225, CID2._text_title_even_units.y + 40, 0, "Shade\r\n", 8, true, true);
		CID2._text_even_units_shade.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_even_units_shade.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_even_units_shade);	
		
		//############################# plus and minus buttons for shade images of odd units.	
		CID2._button_shade_odd_units_minus = new ButtonGeneralNetworkNo(CID2._text_odd_units_shade.x + CID2._text_odd_units_shade.fieldWidth + 15, CID2._text_odd_units_shade.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_shade_odd_units_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_shade_odd_units_minus);
		CID2._group.add(CID2._group_button[0]);		
		
		CID2._button_shade_odd_units_plus = new ButtonGeneralNetworkNo(CID2._button_shade_odd_units_minus.x + CID2._button_shade_odd_units_minus.label.fieldWidth + 15, CID2._text_odd_units_shade.y + CID2._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_shade_odd_units_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_shade_odd_units_plus);
		CID2._group.add(CID2._group_button[1]);
		
		//############################# even buttons for shade images
		CID2._button_shade_even_units_minus = new ButtonGeneralNetworkNo(CID2._text_even_units_shade.x + CID2._text_even_units_shade.fieldWidth + 15, CID2._text_even_units_shade.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_shade_even_units_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_shade_even_units_minus);
		CID2._group.add(CID2._group_button[2]);
		
		CID2._button_shade_even_units_plus = new ButtonGeneralNetworkNo(CID2._button_shade_even_units_minus.x + CID2._button_shade_even_units_minus.label.fieldWidth + 15, CID2._text_even_units_shade.y + CID2._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_shade_even_units_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_shade_even_units_plus);
		CID2._group.add(CID2._group_button[3]);
		
		//############################# color applied to a shaded units.
		CID2._text_odd_units_color = new FlxText(0, 0, 0, "Color");
		CID2._text_odd_units_color.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_odd_units_color.setPosition((CID2._text_title_odd_units.x + CID2._text_title_odd_units.fieldWidth / 2) + 40, CID2._text_odd_units_shade.y);
		CID2._text_odd_units_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_odd_units_color);	
		
		CID2._text_even_units_color = new FlxText(0, 0, 0, "Color");
		CID2._text_even_units_color.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_even_units_color.setPosition((CID2._text_title_even_units.x + CID2._text_title_even_units.fieldWidth / 2) + 40, CID2._text_even_units_shade.y);
		CID2._text_even_units_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_even_units_color);		
		
		//############################# plus and minus buttons for color of odd units.	
		CID2._button_color_odd_units_minus = new ButtonGeneralNetworkNo(CID2._text_odd_units_color.x + CID2._text_odd_units_color.fieldWidth + 15, CID2._text_odd_units_color.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_odd_units_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_color_odd_units_minus);
		CID2._group.add(CID2._group_button[4]);
		
		CID2._button_color_odd_units_plus = new ButtonGeneralNetworkNo(CID2._button_color_odd_units_minus.x + CID2._button_color_odd_units_minus.label.fieldWidth + 15, CID2._text_odd_units_color.y + CID2._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_odd_units_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_color_odd_units_plus);
		CID2._group.add(CID2._group_button[5]);
		
		CID2._button_color_even_units_minus = new ButtonGeneralNetworkNo(CID2._text_even_units_color.x + CID2._text_even_units_color.fieldWidth + 15, CID2._text_even_units_color.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_even_units_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_color_even_units_minus);
		CID2._group.add(CID2._group_button[6]);
		
		CID2._button_color_even_units_plus = new ButtonGeneralNetworkNo(CID2._button_color_even_units_minus.x + CID2._button_color_even_units_minus.label.fieldWidth + 15, CID2._text_even_units_color.y + CID2._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_even_units_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_color_even_units_plus);
		CID2._group.add(CID2._group_button[7]);
		
		//-----------------------
		CID2._gameboard_border_title = new TextGeneral(CID2._text_odd_units_shade.x, CID2._button_color_even_units_plus.y + 75, 0, "Gameboard Border Colors\r\n", 8, true, true);
		CID2._gameboard_border_title.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
	CID2._gameboard_border_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._gameboard_border_title);
		
		CID2._button_gameboard_border_minus = new ButtonGeneralNetworkNo(CID2._button_color_even_units_minus.x, CID2._gameboard_border_title.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gameboard_border_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_gameboard_border_minus);
		CID2._group.add(CID2._group_button[8]);
		
		CID2._button_gameboard_border_plus = new ButtonGeneralNetworkNo(CID2._button_color_even_units_plus.x, CID2._gameboard_border_title.y + CID2._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
	CID2._button_gameboard_border_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_gameboard_border_plus);
		CID2._group.add(CID2._group_button[9]);
		
		
		//-----------------------------
		draw_gameboard();
		
		CID2._question_gameboard_border_enabled = new TextGeneral(CID2._gameboard_border_title.x, CID2._button_gameboard_border_plus.height + CID2._button_gameboard_border_plus.y + CID2._offset_rows_y, 800, "Show border?\r\n", 8, true, true);
		CID2._question_gameboard_border_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_gameboard_border_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_gameboard_border_enabled);
		
		CID2._button_gameboard_border_enabled = new ButtonGeneralNetworkNo(CID2._button_color_even_units_minus.x, CID2._question_gameboard_border_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gameboard_border_enabled.label.font = Reg._fontDefault;
		CID2._button_gameboard_border_enabled.label.text = Std.string(RegCustom._gameboard_border_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_gameboard_border_enabled);
		CID2._group.add(CID2._group_button[10]);
	}
	
	private function initiate():Void
	{
		gameboard_coordinates();
		display_the_notation_panel();
		notation_panel_40_percent_alpha();
		notation_panel_same_background_color();
		notation_panel_background_color();
		notation_panel_text_color();
		client_topic_title_text_color();
		client_text_color();
		title_bar_text_color();
		gameboard_even_units_show();
		background_alpha();
		gradient_background();
		texture_background();
		client_single_color_background();
		client_background_brightness();
		client_background_saturation();
		table_body_background();
		table_body_background_brightness();
		table_body_background_saturation();
		leaderboard_enable();
		house_feature_enable();
		return_to_lobby_after_save();
		automatically_send_start_game_request();
		start_game_offline_without_confirmation();
		accept_start_game_request_entering_game_room();
		waiting_room_confirmation_return_to_lobby();
		game_room_confirmation_return_to_lobby();
		waiting_room_confirmation_entering_game_room();
		confirmation_before_returning_to_title();
		chat_turn_off_for_lobby();
		chat_turn_off_for_any_room();
		move_timer_enable();
		display_players_move_total_text();
		capturing_units_enable();
		button_colors();
		music_enable();
		sound_enable();
		title_bar_color();
		title_bar_brightness();
		menu_bar_color();
		menu_bar_brightness();
		pager_enable();
	}
	
	private function gameboard_coordinates():Void
	{
		_num += 1;
		
		CID2._question_gameboard_coordinates_enabled = new TextGeneral(15, CID2._button_gameboard_border_enabled.height + CID2._button_gameboard_border_enabled.y + CID2._offset_rows_y + CID2._offset_rows_y / 2, 800, "Show coordinates?\r\n", 8, true, true);
		CID2._question_gameboard_coordinates_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_gameboard_coordinates_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_gameboard_coordinates_enabled);
	
	CID2._button_gameboard_coordinates_enabled = new ButtonGeneralNetworkNo(850, CID2._question_gameboard_coordinates_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gameboard_coordinates_enabled.label.font = Reg._fontDefault;
		CID2._button_gameboard_coordinates_enabled.label.text = Std.string(RegCustom._gameboard_coordinates_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_gameboard_coordinates_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	
	private function display_the_notation_panel():Void
	{
		//-----------------------------
		CID2._question_notation_panel_enabled = new TextGeneral(15, CID2._question_gameboard_coordinates_enabled.height + CID2._question_gameboard_coordinates_enabled.y + (CID2._offset_rows_y * 2) + 10, 800, "Display the notation panel?");
		CID2._question_notation_panel_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_notation_panel_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_notation_panel_enabled);
		
		_num += 1;
		
		CID2._button_notation_panel_enabled = new ButtonGeneralNetworkNo(850, CID2._question_notation_panel_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_enabled.label.font = Reg._fontDefault;
		CID2._button_notation_panel_enabled.label.text = Std.string(RegCustom._notation_panel_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_notation_panel_enabled);
		CID2._group.add(CID2._group_button[_num]);
		
	}
	
	
	private function notation_panel_40_percent_alpha():Void
	{
		_num += 1;
		
		CID2._question_notation_panel_40_percent_alpha_enabled = new TextGeneral(15, CID2._button_notation_panel_enabled.height + CID2._button_notation_panel_enabled.y + CID2._offset_rows_y, 800, "Apply 40% transparency to the notation panel?");
		CID2._question_notation_panel_40_percent_alpha_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_notation_panel_40_percent_alpha_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_notation_panel_40_percent_alpha_enabled);
		
		CID2._button_notation_panel_40_percent_alpha_enabled = new ButtonGeneralNetworkNo(850, CID2._question_notation_panel_40_percent_alpha_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_40_percent_alpha_enabled.label.font = Reg._fontDefault;
		CID2._button_notation_panel_40_percent_alpha_enabled.label.text = Std.string(RegCustom._notation_panel_40_percent_alpha_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_notation_panel_40_percent_alpha_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function notation_panel_same_background_color():Void
	{
		_num += 1;
		
		CID2._question_notation_panel_same_background_color = new TextGeneral(15, CID2._button_notation_panel_40_percent_alpha_enabled.height + CID2._button_notation_panel_40_percent_alpha_enabled.y + CID2._offset_rows_y, 800, "Is notation panel same background color as game room?");
		CID2._question_notation_panel_same_background_color .setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_notation_panel_same_background_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_notation_panel_same_background_color);
		
		CID2._button_notation_panel_same_background_color_enabled = new ButtonGeneralNetworkNo(850, CID2._question_notation_panel_same_background_color.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_same_background_color_enabled.label.font = Reg._fontDefault;
		CID2._button_notation_panel_same_background_color_enabled.label.text = Std.string(RegCustom._notation_panel_same_background_color_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_notation_panel_same_background_color_enabled);
		CID2._group.add(CID2._group_button[_num]);
		//-----------------------------
	}
	
	private function notation_panel_background_color():Void
	{
		_num += 1;
		
		CID2._question_notation_panel_background_color = new TextGeneral(15, CID2._button_notation_panel_same_background_color_enabled.height + CID2._button_notation_panel_same_background_color_enabled.y + CID2._offset_rows_y, 800, "Notation panel background color. This overrides all notation background preferences.", 8, true, true);
		CID2._question_notation_panel_background_color.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_notation_panel_background_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_notation_panel_background_color);
		
		CID2._button_notation_panel_background_color_enabled = new ButtonGeneralNetworkNo(850, CID2._question_notation_panel_background_color.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_background_color_enabled.label.font = Reg._fontDefault;
		CID2._button_notation_panel_background_color_enabled.label.text = Std.string(RegCustom._notation_panel_background_color_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_notation_panel_background_color_enabled);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_notation_panel_background_color_number_minus = new ButtonGeneralNetworkNo(CID2._button_notation_panel_background_color_enabled.x + CID2._button_notation_panel_background_color_enabled.width + 15, CID2._button_notation_panel_background_color_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_background_color_number_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_notation_panel_background_color_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_notation_panel_background_color_number_plus = new ButtonGeneralNetworkNo(CID2._button_notation_panel_background_color_number_minus.x + CID2._button_notation_panel_background_color_number_minus.width + 15, CID2._button_notation_panel_background_color_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_background_color_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_notation_panel_background_color_number_plus);
		CID2._group.add(CID2._group_button[_num]);		
		
		CID2._sprite_notation_panel_background_color = new FlxSprite(CID2._button_notation_panel_background_color_number_plus.x + CID2._button_notation_panel_background_color_number_plus.width + 45, CID2._button_notation_panel_background_color_number_plus.y - 12);
		CID2._sprite_notation_panel_background_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_notation_panel_background_color.color = RegCustomColors.notation_panel_background_color();
		CID2._group.add(CID2._sprite_notation_panel_background_color);		
		
		if (CID2._button_notation_panel_background_color_enabled.label.text == "false") CID2._sprite_notation_panel_background_color.visible = false;
		//-----------------------------
	}
	
	private function notation_panel_text_color():Void
	{
		_num += 1;
		
		 CID2._question_notation_panel_text_color_number = new TextGeneral(15, CID2._button_notation_panel_background_color_enabled.height + CID2._button_notation_panel_background_color_enabled.y + CID2._offset_rows_y, 800, "Notation panel text color?");
		CID2._question_notation_panel_text_color_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_notation_panel_text_color_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_notation_panel_text_color_number);
		
		CID2._button_notation_panel_text_color_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_notation_panel_text_color_number.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_text_color_number_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_notation_panel_text_color_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_notation_panel_text_color_number_plus = new ButtonGeneralNetworkNo(CID2._button_notation_panel_text_color_number_minus.x + CID2._button_notation_panel_text_color_number_minus.label.fieldWidth + 15, CID2._button_notation_panel_text_color_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_notation_panel_text_color_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_notation_panel_text_color_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_notation_panel_text_color = new FlxSprite(CID2._button_notation_panel_text_color_number_plus.x + CID2._button_notation_panel_text_color_number_plus.width + 45, CID2._button_notation_panel_text_color_number_plus.y - 12);
		CID2._sprite_notation_panel_text_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_notation_panel_text_color.color = RegCustomColors.notation_panel_text_color();
		CID2._group.add(CID2._sprite_notation_panel_text_color);
		
	}
	
	private function client_topic_title_text_color():Void
	{
		_num += 1;
		
		 CID2._question_client_topic_title_text_color_number = new TextGeneral(15, CID2._button_notation_panel_text_color_number_minus.height + CID2._button_notation_panel_text_color_number_minus.y + CID2._offset_rows_y, 800, "Client topic title text color?");
		CID2._question_client_topic_title_text_color_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_client_topic_title_text_color_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_client_topic_title_text_color_number);
		
		CID2._button_client_topic_title_text_color_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_client_topic_title_text_color_number.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_topic_title_text_color_number_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_topic_title_text_color_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_client_topic_title_text_color_number_plus = new ButtonGeneralNetworkNo(CID2._button_client_topic_title_text_color_number_minus.x + CID2._button_client_topic_title_text_color_number_minus.label.fieldWidth + 15, CID2._button_client_topic_title_text_color_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_topic_title_text_color_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_client_topic_title_text_color_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_client_topic_title_text_color = new FlxSprite(CID2._button_client_topic_title_text_color_number_plus.x + CID2._button_client_topic_title_text_color_number_plus.width + 45, CID2._button_client_topic_title_text_color_number_plus.y - 12);
		CID2._sprite_client_topic_title_text_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_client_topic_title_text_color.color = RegCustomColors.client_topic_title_text_color();
		CID2._group.add(CID2._sprite_client_topic_title_text_color);
		
	}
	
	private function client_text_color():Void
	{
		_num += 1;
		
		 CID2._question_client_text_color_number = new TextGeneral(15, CID2._button_client_topic_title_text_color_number_minus.height + CID2._button_client_topic_title_text_color_number_minus.y + CID2._offset_rows_y, 800, "Client text color?");
		CID2._question_client_text_color_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_client_text_color_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_client_text_color_number);
		
		CID2._button_client_text_color_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_client_text_color_number.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_text_color_number_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_text_color_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_client_text_color_number_plus = new ButtonGeneralNetworkNo(CID2._button_client_text_color_number_minus.x + CID2._button_client_text_color_number_minus.label.fieldWidth + 15, CID2._button_client_text_color_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_text_color_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_client_text_color_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_client_text_color = new FlxSprite(CID2._button_client_text_color_number_plus.x + CID2._button_client_text_color_number_plus.width + 45, CID2._button_client_text_color_number_plus.y - 12);
		CID2._sprite_client_text_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_client_text_color.color = RegCustomColors.client_text_color();
		CID2._group.add(CID2._sprite_client_text_color);
		
	}
	
	private function title_bar_text_color():Void
	{
		_num += 1;
		
		 CID2._question_title_bar_text_color_number = new TextGeneral(15, CID2._button_client_text_color_number_minus.height + CID2._button_client_text_color_number_minus.y + CID2._offset_rows_y, 800, "Title bar text color?");
		CID2._question_title_bar_text_color_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_title_bar_text_color_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_title_bar_text_color_number);
		
		CID2._button_title_bar_text_color_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_title_bar_text_color_number.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_text_color_number_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_title_bar_text_color_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_title_bar_text_color_number_plus = new ButtonGeneralNetworkNo(CID2._button_title_bar_text_color_number_minus.x + CID2._button_title_bar_text_color_number_minus.label.fieldWidth + 15, CID2._button_title_bar_text_color_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_text_color_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_title_bar_text_color_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_title_bar_text_color = new FlxSprite(CID2._button_title_bar_text_color_number_plus.x + CID2._button_title_bar_text_color_number_plus.width + 45, CID2._button_title_bar_text_color_number_plus.y - 12);
		CID2._sprite_title_bar_text_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_title_bar_text_color.color = RegCustomColors.title_bar_text_color();
		CID2._group.add(CID2._sprite_title_bar_text_color);
		
	}
	
	private function gameboard_even_units_show():Void
	{
		_num += 1;
		
		var _question_gameboard_even_units_show_enabled = new TextGeneral(15, CID2._button_title_bar_text_color_number_minus.height + CID2._button_title_bar_text_color_number_minus.y + CID2._offset_rows_y, 800, "Show even gameboard units?");
		_question_gameboard_even_units_show_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_question_gameboard_even_units_show_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(_question_gameboard_even_units_show_enabled);
		
		CID2._button_gameboard_even_units_show_enabled = new ButtonGeneralNetworkNo(850, _question_gameboard_even_units_show_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gameboard_even_units_show_enabled.label.font = Reg._fontDefault;
		CID2._button_gameboard_even_units_show_enabled.label.text = Std.string(RegCustom._gameboard_even_units_show_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_gameboard_even_units_show_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function background_alpha():Void
	{
		_num += 1;
		
		CID2._question_background_alpha_enabled = new TextGeneral(15, CID2._button_gameboard_even_units_show_enabled.height + CID2._button_gameboard_even_units_show_enabled.y + CID2._offset_rows_y, 800, "Apply a 80% transparency to the gradient and texture backgrounds?", 8, true);
		CID2._question_background_alpha_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_background_alpha_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_background_alpha_enabled);
		
		CID2._button_background_alpha_enabled = new ButtonGeneralNetworkNo(850, CID2._question_background_alpha_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_background_alpha_enabled.label.font = Reg._fontDefault;
		CID2._button_background_alpha_enabled.label.text = Std.string(RegCustom._background_alpha_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_background_alpha_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function gradient_background():Void
	{
		_num += 1;
		//----------------------------
		CID2._question_gradient_background_enabled = new TextGeneral(15, CID2._button_background_alpha_enabled.height + CID2._button_background_alpha_enabled.y + (CID2._offset_rows_y * 2), 800, "Display a gradient background?\r\n\r\n");
		CID2._question_gradient_background_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_gradient_background_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_gradient_background_enabled);
		
		CID2._button_gradient_texture_background_enabled = new ButtonGeneralNetworkNo(850, CID2._question_gradient_background_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gradient_texture_background_enabled.label.font = Reg._fontDefault;
		CID2._button_gradient_texture_background_enabled.label.text = Std.string(RegCustom._gradient_background_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_gradient_texture_background_enabled);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_gradient_texture_background_minus = new ButtonGeneralNetworkNo(CID2._button_gradient_texture_background_enabled.x + CID2._button_gradient_texture_background_enabled.width + 15, CID2._button_gradient_texture_background_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gradient_texture_background_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_gradient_texture_background_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_gradient_texture_background_plus = new ButtonGeneralNetworkNo(CID2._button_gradient_texture_background_minus.x + CID2._button_gradient_texture_background_minus.label.fieldWidth + 15, CID2._button_gradient_texture_background_enabled.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_gradient_texture_background_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_gradient_texture_background_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_gradient_background_image = new FlxSprite(CID2._button_gradient_texture_background_plus.x + 50, CID2._button_gradient_texture_background_enabled.y, "assets/images/gameboardGradientBackgroundb.jpg");
		CID2._sprite_gradient_background_image.color = RegCustomColors.gradient_color();
		if (RegCustom._gradient_background_enabled[Reg._tn] == false)
			CID2._sprite_gradient_background_image.alpha = 0;
		CID2._group.add(CID2._sprite_gradient_background_image);
	}
	
	private function texture_background():Void
	{
		_num += 1;
		
		var _question_texture_background_enabled = new TextGeneral(15, CID2._button_gradient_texture_background_enabled.height + CID2._button_gradient_texture_background_enabled.y + (CID2._offset_rows_y * 4) - 5, 800, "Display a textured background?\r\r\n\r\n", 8, true, true);
		_question_texture_background_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_question_texture_background_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(_question_texture_background_enabled);
		
		CID2._button_client_texture_background_enabled = new ButtonGeneralNetworkNo(850, _question_texture_background_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_texture_background_enabled.label.font = Reg._fontDefault;
		CID2._button_client_texture_background_enabled.label.text = Std.string(RegCustom._texture_background_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_client_texture_background_enabled);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_client_texture_background_minus = new ButtonGeneralNetworkNo(CID2._button_client_texture_background_enabled.x + CID2._button_client_texture_background_enabled.width + 15, CID2._button_client_texture_background_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_texture_background_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_texture_background_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_client_texture_background_plus = new ButtonGeneralNetworkNo(CID2._button_client_texture_background_minus.x + CID2._button_client_texture_background_minus.label.fieldWidth + 15, CID2._button_client_texture_background_enabled.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_texture_background_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_client_texture_background_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_texture_background_image = new FlxSprite(CID2._button_client_texture_background_plus.x + 50, CID2._button_client_texture_background_enabled.y, "assets/images/scenes/textures/" + Std.string(RegCustom._texture_background_image_number[Reg._tn]) + "b.jpg");
		if (RegCustom._texture_background_enabled[Reg._tn] == false)
			CID2._sprite_texture_background_image.alpha = 0;
		CID2._group.add(CID2._sprite_texture_background_image);		
	}
	
	private function client_single_color_background():Void
	{
		_num += 1;
		
		var _question_client_background_enabled = new TextGeneral(15, CID2._button_client_texture_background_enabled.height + CID2._button_client_texture_background_enabled.y + (CID2._offset_rows_y * 4) - 5, 800, "Display a single colored background to all scenes? A scene may override this feature. Select false for a random color background. A gradient or texture background can still be seen if transparency is enabled.", 8, true, true);
		_question_client_background_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_question_client_background_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(_question_client_background_enabled);
		
		CID2._button_client_background_enabled = new ButtonGeneralNetworkNo(850, _question_client_background_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_enabled.label.font = Reg._fontDefault;
		CID2._button_client_background_enabled.label.text = Std.string(RegCustom._client_background_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_client_background_enabled);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_client_background_minus = new ButtonGeneralNetworkNo(CID2._button_client_background_enabled.x + CID2._button_client_background_enabled.width + 15, CID2._button_client_background_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_background_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_client_background_plus = new ButtonGeneralNetworkNo(CID2._button_client_background_minus.x + CID2._button_client_background_minus.label.fieldWidth + 15, CID2._button_client_background_enabled.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_client_background_plus);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function client_background_brightness():Void
	{
		_num += 1;
		
		CID2._question_client_background_brightness = new TextGeneral(15, CID2._button_client_background_enabled.height + CID2._button_client_background_enabled.y + (CID2._offset_rows_y * 3) - 3, 800, "Single color background brightness? 0 is black. 1 is full bright.", 8, true, true);
		CID2._question_client_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_client_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_client_background_brightness);
		
		CID2._button_client_background_brightness_minus = new ButtonGeneralNetworkNo(850, CID2._question_client_background_brightness.y  + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_brightness_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_client_background_brightness_minus);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_client_background_brightness_plus = new ButtonGeneralNetworkNo(CID2._button_client_background_brightness_minus.x + CID2._button_client_background_brightness_minus.width + 15, CID2._button_client_background_brightness_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_brightness_plus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_background_brightness_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_client_background_brightness = new FlxText(CID2._button_client_background_brightness_minus.x + 100, CID2._question_client_background_brightness.y, 0, Std.string(RegCustom._client_background_brightness[Reg._tn]));
		CID2._text_client_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());	
		CID2._text_client_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_client_background_brightness);
		
		// this needs to be placed here to display both this brightness text and the static background image above from the RegCustomColors.color_client_background because the RegCustomColors.color_client_background function updates both variables. 
		CID2._sprite_client_background_image = new FlxSprite(CID2._button_client_background_minus.x + 100, CID2._button_client_background_minus.y, "assets/images/capturingUnits.png");
		if (RegCustom._client_background_enabled[Reg._tn] == false)
			CID2._sprite_client_background_image.alpha = 0;
			
		CID2._sprite_client_background_image.color = RegCustomColors.color_client_background();		
		CID2._group.add(CID2._sprite_client_background_image);
		
	}
	
	private function client_background_saturation():Void
	{
		_num += 1;
		
		CID2._question_client_background_saturation = new TextGeneral(15, CID2._button_client_background_brightness_minus.height + CID2._button_client_background_brightness_minus.y + CID2._offset_rows_y, 800, "Single colored background saturation? 0 is pure gray. 1 is vibrant. Gray color ignores this value.", 8, true, true);
		CID2._question_client_background_saturation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_client_background_saturation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_client_background_saturation);

		CID2._button_client_background_saturation_minus = new ButtonGeneralNetworkNo(850, CID2._question_client_background_saturation.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_saturation_minus.label.font = Reg._fontDefault;
		CID2._group_button.push(CID2._button_client_background_saturation_minus);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_client_background_saturation_plus = new ButtonGeneralNetworkNo(CID2._button_client_background_saturation_minus.x + CID2._button_client_background_saturation_minus.width + 15, CID2._button_client_background_saturation_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_client_background_saturation_plus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_client_background_saturation_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_client_background_saturation = new FlxText(CID2._button_client_background_saturation_minus.x + 100, CID2._question_client_background_saturation.y, 0, Std.string(RegCustom._client_background_saturation[Reg._tn]));
		CID2._text_client_background_saturation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());	
		CID2._text_client_background_saturation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_client_background_saturation);
	}
	
	private function table_body_background():Void
	{
		_num += 1;
		
		CID2._question_table_body_background = new TextGeneral(15, CID2._button_client_background_saturation_minus.height + CID2._button_client_background_saturation_minus.y + CID2._offset_rows_y, 800, "Table background row color seen at the lobby, waiting room and at the leaderboards.", 8, true, true);
		CID2._question_table_body_background.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_table_body_background.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_table_body_background);

		CID2._button_table_body_background_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_table_body_background.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_number_minus.label.font = Reg._fontDefault;
		CID2._group_button.push(CID2._button_table_body_background_number_minus);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_table_body_background_number_plus = new ButtonGeneralNetworkNo(CID2._button_table_body_background_number_minus.x + CID2._button_table_body_background_number_minus.width + 15, CID2._button_table_body_background_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_number_plus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_table_body_background_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_table_body_background_image = new FlxSprite(CID2._button_table_body_background_number_minus.x + 100, CID2._button_table_body_background_number_minus.y, "assets/images/capturingUnits.png");
		CID2._sprite_table_body_background_image.color = RegCustomColors.color_table_body_background();		
		CID2._group.add(CID2._sprite_table_body_background_image);
	}
	
	private function table_body_background_brightness():Void
	{
		_num += 1;
		
		CID2._question_table_body_background_brightness = new TextGeneral(15, CID2._button_table_body_background_number_minus.height + CID2._button_table_body_background_number_minus.y + CID2._offset_rows_y, 800, "Table background body brightness.", 8, true, true);
		CID2._question_table_body_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_table_body_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_table_body_background_brightness);

		CID2._button_table_body_background_brightness_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_table_body_background_brightness.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_brightness_number_minus.label.font = Reg._fontDefault;
		CID2._group_button.push(CID2._button_table_body_background_brightness_number_minus);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_table_body_background_brightness_number_plus = new ButtonGeneralNetworkNo(CID2._button_table_body_background_brightness_number_minus.x + CID2._button_table_body_background_brightness_number_minus.width + 15, CID2._button_table_body_background_brightness_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_brightness_number_plus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_table_body_background_brightness_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_table_body_background_brightness = new FlxText(CID2._button_table_body_background_brightness_number_minus.x + 100, CID2._question_table_body_background_brightness.y, 0, Std.string(RegCustom._table_body_background_brightness[Reg._tn]));
		CID2._text_table_body_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());	
		CID2._text_table_body_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_table_body_background_brightness);
	}
	
	private function table_body_background_saturation():Void
	{
		_num += 1;
		
		CID2._question_table_body_background_saturation = new TextGeneral(15, CID2._button_table_body_background_brightness_number_minus.height + CID2._button_table_body_background_brightness_number_minus.y + CID2._offset_rows_y, 800, "Table background body saturation.", 8, true, true);
		CID2._question_table_body_background_saturation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_table_body_background_saturation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_table_body_background_saturation);

		CID2._button_table_body_background_saturation_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_table_body_background_saturation.y + CID2._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_saturation_number_minus.label.font = Reg._fontDefault;
		CID2._group_button.push(CID2._button_table_body_background_saturation_number_minus);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_table_body_background_saturation_number_plus = new ButtonGeneralNetworkNo(CID2._button_table_body_background_saturation_number_minus.x + CID2._button_table_body_background_saturation_number_minus.width + 15, CID2._button_table_body_background_saturation_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_table_body_background_saturation_number_plus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_table_body_background_saturation_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_table_body_background_saturation = new FlxText(CID2._button_table_body_background_saturation_number_minus.x + 100, CID2._question_table_body_background_saturation.y, 0, Std.string(RegCustom._table_body_background_saturation[Reg._tn]));
		CID2._text_table_body_background_saturation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());	
		CID2._text_table_body_background_saturation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_table_body_background_saturation);
	}
	
	private function leaderboard_enable():Void
	{
		_num += 1;
		
		//----------------------------
		CID2._question_leaderboard_enabled = new TextGeneral(15, CID2._button_table_body_background_saturation_number_minus.height + CID2._button_table_body_background_saturation_number_minus.y + CID2._offset_rows_y, 800, "Show leaderboards which is all ranking of the leaders in a competitive events?", 8, true, true);
		CID2._question_leaderboard_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_leaderboard_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_leaderboard_enabled);
		
		CID2._button_leaderboard_enabled = new ButtonGeneralNetworkNo(850, CID2._question_leaderboard_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_leaderboard_enabled.label.font = Reg._fontDefault;
		CID2._button_leaderboard_enabled.label.text = Std.string(RegCustom._leaderboard_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_leaderboard_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function house_feature_enable():Void
	{
		_num += 1;
		
		CID2._house_feature_question = new TextGeneral(15, CID2._button_leaderboard_enabled.height + CID2._button_leaderboard_enabled.y + CID2._offset_rows_y, 800, "Enable the house side game?");
		CID2._house_feature_question.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._house_feature_question.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._house_feature_question);
		
		CID2._button_house_feature_enabled = new ButtonGeneralNetworkNo(850, CID2._house_feature_question.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_house_feature_enabled.label.font = Reg._fontDefault;
		CID2._button_house_feature_enabled.label.text = Std.string(RegCustom._house_feature_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_house_feature_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function return_to_lobby_after_save():Void
	{
		_num += 1;
		
		CID2._question_goto_title = new TextGeneral(15, CID2._button_house_feature_enabled.height + CID2._button_house_feature_enabled.y + CID2._offset_rows_y, 800, "Go back to the title scene after these configuration options are saved?", 8, true, true);
		CID2._question_goto_title.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_goto_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_goto_title);
		
		CID2._button_goto_title_enabled = new ButtonGeneralNetworkNo(850, CID2._question_goto_title.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_goto_title_enabled.label.font = Reg._fontDefault;
		CID2._button_goto_title_enabled.label.text = Std.string(RegCustom._go_back_to_title_after_save[Reg._tn]);
		CID2._group_button.push(CID2._button_goto_title_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function automatically_send_start_game_request():Void
	{	
		_num += 1;
	
		//----------------------------- start game request when host enters room?
		
		CID2._question_start_game_request = new TextGeneral(15, CID2._button_goto_title_enabled.height + CID2._button_goto_title_enabled.y + CID2._offset_rows_y, 800, "Should host of the room automatically send a start game request to other player(s) after entering the game room?", 8, true, true);
		CID2._question_start_game_request.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_start_game_request.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_start_game_request);
		
		CID2._button_send_automatic_start_game_request = new ButtonGeneralNetworkNo(850, CID2._question_start_game_request.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_send_automatic_start_game_request.label.font = Reg._fontDefault;
		CID2._button_send_automatic_start_game_request.label.text = Std.string(RegCustom._send_automatic_start_game_request[Reg._tn]);
		
		CID2._group_button.push(CID2._button_send_automatic_start_game_request);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function start_game_offline_without_confirmation():Void
	{
		_num += 1;
		
		CID2._question_start_game_offline_confirmation = new TextGeneral(15, CID2._button_send_automatic_start_game_request.height + CID2._button_send_automatic_start_game_request.y + CID2._offset_rows_y, 800, "Start a game in offline mode without confirmation?");
		CID2._question_start_game_offline_confirmation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_start_game_offline_confirmation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_start_game_offline_confirmation);
		
		CID2._button_start_game_offline_confirmation = new ButtonGeneralNetworkNo(850, CID2._question_start_game_offline_confirmation.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_start_game_offline_confirmation.label.font = Reg._fontDefault;
		CID2._button_start_game_offline_confirmation.label.text = Std.string(RegCustom._start_game_offline_confirmation[Reg._tn]);
		
		CID2._group_button.push(CID2._button_start_game_offline_confirmation);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function accept_start_game_request_entering_game_room():Void
	{
		_num += 1;
		
		CID2._question_accept_start_game_request = new TextGeneral(15, CID2._button_start_game_offline_confirmation.height + CID2._button_start_game_offline_confirmation.y + CID2._offset_rows_y, 800, "Automatically accept a start game request after entering the game room?", 8, true, true);
		CID2._question_accept_start_game_request.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_accept_start_game_request.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_accept_start_game_request);
		
		CID2._button_accept_automatic_start_game_request = new ButtonGeneralNetworkNo(850, CID2._question_accept_start_game_request.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_accept_automatic_start_game_request.label.font = Reg._fontDefault;
		CID2._button_accept_automatic_start_game_request.label.text = Std.string(RegCustom._accept_automatic_start_game_request[Reg._tn]);
		
		CID2._group_button.push(CID2._button_accept_automatic_start_game_request);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function waiting_room_confirmation_return_to_lobby():Void
	{
		_num += 1;
		
		CID2._question_to_lobby_waiting_room_confirmation = new TextGeneral(15, CID2._button_accept_automatic_start_game_request.height + CID2._button_accept_automatic_start_game_request.y + CID2._offset_rows_y, 800, "At waiting room do you need confirmation before returning to lobby?", 8, true, true);
		CID2._question_to_lobby_waiting_room_confirmation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_to_lobby_waiting_room_confirmation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_to_lobby_waiting_room_confirmation);
		
		CID2._button_to_lobby_waiting_room_confirmation = new ButtonGeneralNetworkNo(850, CID2._question_to_lobby_waiting_room_confirmation.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_to_lobby_waiting_room_confirmation.label.font = Reg._fontDefault;
		CID2._button_to_lobby_waiting_room_confirmation.label.text = Std.string(RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn]);
		
		CID2._group_button.push(CID2._button_to_lobby_waiting_room_confirmation);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function game_room_confirmation_return_to_lobby():Void
	{
		_num += 1;
		
		CID2._question_to_lobby_game_room_confirmation = new TextGeneral(15, CID2._button_to_lobby_waiting_room_confirmation.height + CID2._button_to_lobby_waiting_room_confirmation.y + CID2._offset_rows_y, 800, "At game room do you need confirmation before returning to lobby?", 8, true, true);
		CID2._question_to_lobby_game_room_confirmation.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_to_lobby_game_room_confirmation.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_to_lobby_game_room_confirmation);
		
		CID2._button_to_lobby_game_room_confirmation = new ButtonGeneralNetworkNo(850, CID2._question_to_lobby_game_room_confirmation.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_to_lobby_game_room_confirmation.label.font = Reg._fontDefault;
		CID2._button_to_lobby_game_room_confirmation.label.text = Std.string(RegCustom._to_lobby_from_game_room_confirmation[Reg._tn]);
		
		CID2._group_button.push(CID2._button_to_lobby_game_room_confirmation);
		CID2._group.add(CID2._group_button[_num]);
	}	
	
	private function waiting_room_confirmation_entering_game_room():Void
	{
		_num += 1; 

		CID2._question_to_game_room_from_waiting_room = new TextGeneral(15, CID2._button_to_lobby_game_room_confirmation.height + CID2._button_to_lobby_game_room_confirmation.y + CID2._offset_rows_y, 800, "At waiting room do you need confirmation before entering game room?", 8, true, true);
		CID2._question_to_game_room_from_waiting_room.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_to_game_room_from_waiting_room.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_to_game_room_from_waiting_room);
		
		CID2._button_to_game_room_from_waiting_room = new ButtonGeneralNetworkNo(850, CID2._question_to_game_room_from_waiting_room.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_to_game_room_from_waiting_room.label.font = Reg._fontDefault;
		CID2._button_to_game_room_from_waiting_room.label.text = Std.string(RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn]);
		
		CID2._group_button.push(CID2._button_to_game_room_from_waiting_room);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function confirmation_before_returning_to_title():Void
	{
		_num += 1;
		
		CID2._question_to_title_from_game_room = new TextGeneral(15, CID2._button_to_game_room_from_waiting_room.height + CID2._button_to_game_room_from_waiting_room.y + CID2._offset_rows_y, 800, "Do you need confirmation before returning to title?");
		CID2._question_to_title_from_game_room.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_to_title_from_game_room.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_to_title_from_game_room);
		
		CID2._button_to_title_from_game_room = new ButtonGeneralNetworkNo(850, CID2._question_to_title_from_game_room.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_to_title_from_game_room.label.font = Reg._fontDefault;
		CID2._button_to_title_from_game_room.label.text = Std.string(RegCustom._to_title_from_game_room_confirmation[Reg._tn]);
		
		CID2._group_button.push(CID2._button_to_title_from_game_room);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function chat_turn_off_for_lobby():Void
	{
		_num += 1;
		
		CID2._question_chat_turn_off_for_lobby = new TextGeneral(15, CID2._button_to_title_from_game_room.height + CID2._button_to_title_from_game_room.y + CID2._offset_rows_y, 800, "Enable chat when at lobby?");
		CID2._question_chat_turn_off_for_lobby.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_chat_turn_off_for_lobby.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_chat_turn_off_for_lobby);
		
		CID2._button_chat_turn_off_for_lobby = new ButtonGeneralNetworkNo(850, CID2._question_chat_turn_off_for_lobby.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_chat_turn_off_for_lobby.label.font = Reg._fontDefault;
		CID2._button_chat_turn_off_for_lobby.label.text = Std.string(RegCustom._chat_when_at_lobby_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_chat_turn_off_for_lobby);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function chat_turn_off_for_any_room():Void
	{
		_num += 1;
		
		var _question_chat_turn_off_for_room = new TextGeneral(15, CID2._button_chat_turn_off_for_lobby.height + CID2._button_chat_turn_off_for_lobby.y + CID2._offset_rows_y, 800, "Enable chat when at any room?");
		_question_chat_turn_off_for_room.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_question_chat_turn_off_for_room.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(_question_chat_turn_off_for_room);
		
		CID2._button_chat_turn_off_when_in_room = new ButtonGeneralNetworkNo(850, _question_chat_turn_off_for_room.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_chat_turn_off_when_in_room.label.font = Reg._fontDefault;
		CID2._button_chat_turn_off_when_in_room.label.text = Std.string(RegCustom._chat_when_at_room_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_chat_turn_off_when_in_room);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function move_timer_enable():Void
	{
		_num += 1;
		
		CID2._question_move_timer_enabled = new TextGeneral(15, CID2._button_chat_turn_off_when_in_room.height + CID2._button_chat_turn_off_when_in_room.y + CID2._offset_rows_y, 800, "Enable the player's piece move timer? Note: tournament play ignores this feature.", 8, true, true);
		CID2._question_move_timer_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_move_timer_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_move_timer_enabled);
		
		CID2._button_move_timer_enabled = new ButtonGeneralNetworkNo(850, CID2._question_move_timer_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_move_timer_enabled.label.font = Reg._fontDefault;
		CID2._button_move_timer_enabled.label.text = Std.string(RegCustom._timer_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_move_timer_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function display_players_move_total_text():Void
	{
		_num += 1;
		
		CID2._question_move_total_enabled = new TextGeneral(15, CID2._button_move_timer_enabled.height + CID2._button_move_timer_enabled.y + CID2._offset_rows_y, 800, "Display the player's move total text?");
		CID2._question_move_total_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_move_total_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_move_total_enabled);
		
		CID2._button_move_total_enabled = new ButtonGeneralNetworkNo(850, CID2._question_move_total_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_move_total_enabled.label.font = Reg._fontDefault;
		CID2._button_move_total_enabled.label.text = Std.string(RegCustom._move_total_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_move_total_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function capturing_units_enable():Void
	{
		_num += 1;
		
		CID2._question_capturing_units_enabled = new TextGeneral(15, CID2._button_move_total_enabled.height + CID2._button_move_total_enabled.y + CID2._offset_rows_y, 800, "Display legal moves (capturing units)?");
		CID2._question_capturing_units_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_capturing_units_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_capturing_units_enabled);
		
		CID2._button_capturing_units = new ButtonGeneralNetworkNo(850, CID2._question_capturing_units_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_capturing_units.label.font = Reg._fontDefault;
		CID2._button_capturing_units.label.text = Std.string(RegCustom._capturing_units[Reg._tn]);
		
		CID2._group_button.push(CID2._button_capturing_units);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_capturing_units_change_color_minus = new ButtonGeneralNetworkNo(CID2._button_capturing_units.x + CID2._button_capturing_units.width + 13, CID2._button_capturing_units.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_capturing_units_change_color_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_capturing_units_change_color_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_capturing_units_change_color_plus = new ButtonGeneralNetworkNo(CID2._button_capturing_units_change_color_minus.x + CID2._button_capturing_units_change_color_minus.label.fieldWidth + 15, CID2._button_capturing_units_change_color_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_capturing_units_change_color_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_capturing_units_change_color_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_capturing_units = new FlxSprite(CID2._button_capturing_units_change_color_plus.x + CID2._button_capturing_units_change_color_plus.width + 45, CID2._button_capturing_units_change_color_plus.y - 13);
		CID2._sprite_capturing_units.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_capturing_units.color = RegCustomColors.color_capturing_units();
		CID2._group.add(CID2._sprite_capturing_units);
		
		CID2._sprite_chess_path_to_king_bg = new FlxSprite(CID2._button_capturing_units_change_color_plus.x + CID2._button_capturing_units_change_color_plus.width + 45, CID2._button_capturing_units_change_color_plus.y - 13, "assets/images/border1.png");
		CID2._group.add(CID2._sprite_chess_path_to_king_bg);
	}
	
	private function button_colors():Void
	{
		_num += 1;
		
		CID2._question_button_colors = new TextGeneral(15, CID2._button_capturing_units_change_color_minus.height + CID2._button_capturing_units_change_color_minus.y + CID2._offset_rows_y, 800, "Change the appearance of all client buttons?", 8, true, true);
		CID2._question_button_colors.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_button_colors.fieldWidth = 400;
		CID2._question_button_colors.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_button_colors);
		
		CID2._button_color = new ButtonGeneralNetworkNo(CID2._question_button_colors.x + CID2._question_button_colors.fieldWidth + CID2._offset_button_y, CID2._question_button_colors.y + 15, "Background", 190, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_color);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_border_color = new ButtonGeneralNetworkNo(CID2._button_color.x + CID2._button_color.label.fieldWidth + 15, CID2._button_color.y + 7, "Border", 170, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_border_color.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_border_color);
		CID2._group.add(CID2._group_button[_num]);
		
		_num += 1;
		
		CID2._button_text_color = new ButtonGeneralNetworkNo(CID2._button_border_color.x + CID2._button_border_color.label.fieldWidth + CID2._offset_button_y, CID2._button_border_color.y + 7, "Text", 170, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_text_color.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_text_color);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._question_button_colors_output = new FlxText(CID2._button_text_color.x + CID2._button_text_color.label.fieldWidth + 80, 0, 0, "Output:");
		CID2._question_button_colors_output.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_button_colors_output.y = CID2._button_color.y + 7;
		CID2._question_button_colors_output.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_button_colors_output);
		
		CID2._button_color_output = new ButtonGeneralNetworkNo(CID2._question_button_colors_output.x + CID2._question_button_colors_output.fieldWidth + 15, CID2._button_border_color.y + 7, "Example", 110, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_color_output.label.font = Reg._fontDefault;
		CID2._group.add(CID2._button_color_output);
	}
	
	private function music_enable():Void
	{
		_num += 1;
		
		CID2._question_music_enabled = new TextGeneral(15, CID2._button_color_output.height + CID2._button_color_output.y + CID2._offset_rows_y, 800, "Enable music?");
		CID2._question_music_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_music_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_music_enabled);
		
		CID2._button_music_enabled = new ButtonGeneralNetworkNo(850, CID2._question_music_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_music_enabled.label.font = Reg._fontDefault;
		CID2._button_music_enabled.label.text = Std.string(RegCustom._music_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_music_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function sound_enable():Void
	{
		_num += 1;
		
		CID2._question_sound_enabled = new TextGeneral(15, CID2._button_music_enabled.height + CID2._button_music_enabled.y + CID2._offset_rows_y, 800, "Enable sound?");
		CID2._question_sound_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_sound_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_sound_enabled);
		
		CID2._button_sound_enabled = new ButtonGeneralNetworkNo(850, CID2._question_sound_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_sound_enabled.label.font = Reg._fontDefault;
		CID2._button_sound_enabled.label.text = Std.string(RegCustom._sound_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_sound_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	private function title_bar_color():Void
	{
		_num += 1;
		
		CID2._question_title_bar_background_number = new TextGeneral(15, CID2._button_sound_enabled.height + CID2._button_sound_enabled.y + CID2._offset_rows_y, 800, "Background color of scene header title?");
		CID2._question_title_bar_background_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_title_bar_background_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_title_bar_background_number);
		
		CID2._button_title_bar_background_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_title_bar_background_number.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_background_number_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_title_bar_background_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_title_bar_background_number_plus = new ButtonGeneralNetworkNo(CID2._button_title_bar_background_number_minus.x + CID2._button_title_bar_background_number_minus.label.fieldWidth + 15, CID2._button_title_bar_background_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_background_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_title_bar_background_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_title_bar_background_color = new FlxSprite(CID2._button_title_bar_background_number_plus.x + CID2._button_title_bar_background_number_plus.width + 45, CID2._button_title_bar_background_number_plus.y - 12);
		CID2._sprite_title_bar_background_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_title_bar_background_color.color = RegCustomColors.title_bar_background_color();
		CID2._group.add(CID2._sprite_title_bar_background_color);
	}
	
	private function title_bar_brightness():Void
	{
		_num += 1;
		
		CID2._question_title_bar_background_brightness = new TextGeneral(15, CID2._question_title_bar_background_number.height + CID2._question_title_bar_background_number.y + (CID2._offset_rows_y * 2) + 10, 800, "Background brightness of scene header title?");
		CID2._question_title_bar_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_title_bar_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_title_bar_background_brightness);
		
		CID2._button_title_bar_background_brightness_minus = new ButtonGeneralNetworkNo(850, CID2._question_title_bar_background_brightness.y + 15, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_background_brightness_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_title_bar_background_brightness_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_title_bar_background_brightness_plus = new ButtonGeneralNetworkNo(CID2._button_title_bar_background_brightness_minus.x + CID2._button_title_bar_background_brightness_minus.label.fieldWidth + 15, CID2._button_title_bar_background_brightness_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_title_bar_background_brightness_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_title_bar_background_brightness_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_title_bar_background_brightness = new FlxText(CID2._button_title_bar_background_brightness_plus.x + CID2._button_title_bar_background_brightness_plus.width + 45, CID2._button_title_bar_background_brightness_plus.y - 12, 0, Std.string(RegCustom._title_bar_background_brightness[Reg._tn]), Reg._font_size);
		CID2._text_title_bar_background_brightness.scrollFactor.set(0, 0);
		CID2._text_title_bar_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_title_bar_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_title_bar_background_brightness);
	}
	
	private function menu_bar_color():Void
	{
		_num += 1;
		
		CID2._question_menu_bar_background_number = new TextGeneral(15, CID2._button_title_bar_background_brightness_minus.height + CID2._button_title_bar_background_brightness_minus.y + CID2._offset_rows_y, 800, "Background color of scene footer menu?");
		CID2._question_menu_bar_background_number.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_menu_bar_background_number.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_menu_bar_background_number);
		
		CID2._button_menu_bar_background_number_minus = new ButtonGeneralNetworkNo(850, CID2._question_menu_bar_background_number.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_menu_bar_background_number_minus.label.font = Reg._fontDefault;
	
		CID2._group_button.push(CID2._button_menu_bar_background_number_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_menu_bar_background_number_plus = new ButtonGeneralNetworkNo(CID2._button_menu_bar_background_number_minus.x + CID2._button_menu_bar_background_number_minus.label.fieldWidth + 15, CID2._button_menu_bar_background_number_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_menu_bar_background_number_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_menu_bar_background_number_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._sprite_menu_bar_background_color = new FlxSprite(CID2._button_menu_bar_background_number_plus.x + CID2._button_menu_bar_background_number_plus.width + 45, CID2._button_menu_bar_background_number_plus.y - 12);
		CID2._sprite_menu_bar_background_color.loadGraphic("assets/images/capturingUnits.png", false, 75, 75);
		CID2._sprite_menu_bar_background_color.color = RegCustomColors.menu_bar_background_color();
		CID2._group.add(CID2._sprite_menu_bar_background_color);
	}
	
	private function menu_bar_brightness():Void
	{
		_num += 1;
		
		CID2._question_menu_bar_background_brightness = new TextGeneral(15, CID2._question_menu_bar_background_number.height + CID2._question_menu_bar_background_number.y + (CID2._offset_rows_y * 2) + 10, 800, "Background brightness of scene footer menu?");
		CID2._question_menu_bar_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_menu_bar_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_menu_bar_background_brightness);
		
		CID2._button_menu_bar_background_brightness_minus = new ButtonGeneralNetworkNo(850, CID2._question_menu_bar_background_brightness.y + 15, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_menu_bar_background_brightness_minus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_menu_bar_background_brightness_minus);
		CID2._group.add(CID2._group_button[_num]);		
		
		_num += 1;
		
		CID2._button_menu_bar_background_brightness_plus = new ButtonGeneralNetworkNo(CID2._button_menu_bar_background_brightness_minus.x + CID2._button_menu_bar_background_brightness_minus.label.fieldWidth + 15, CID2._button_menu_bar_background_brightness_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_menu_bar_background_brightness_plus.label.font = Reg._fontDefault;
		
		CID2._group_button.push(CID2._button_menu_bar_background_brightness_plus);
		CID2._group.add(CID2._group_button[_num]);
		
		CID2._text_menu_bar_background_brightness = new FlxText(CID2._button_menu_bar_background_brightness_plus.x + CID2._button_menu_bar_background_brightness_plus.width + 45, CID2._button_menu_bar_background_brightness_plus.y - 12, 0, Std.string(RegCustom._menu_bar_background_brightness[Reg._tn]), Reg._font_size);
		CID2._text_menu_bar_background_brightness.scrollFactor.set(0, 0);
		CID2._text_menu_bar_background_brightness.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._text_menu_bar_background_brightness.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._text_menu_bar_background_brightness);
	}

	private function pager_enable():Void
	{
		_num += 1;
		
		CID2._question_pager_enabled = new TextGeneral(15, CID2._button_menu_bar_background_brightness_minus.height + CID2._button_menu_bar_background_brightness_minus.y + CID2._offset_rows_y, 800, "Enable pager?");
		CID2._question_pager_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID2._question_pager_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID2._group.add(CID2._question_pager_enabled);
		
		CID2._button_pager_enabled = new ButtonGeneralNetworkNo(850, CID2._question_pager_enabled.y + CID2._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID2._button_pager_enabled.label.font = Reg._fontDefault;
		CID2._button_pager_enabled.label.text = Std.string(RegCustom._pager_enabled[Reg._tn]);
		
		CID2._group_button.push(CID2._button_pager_enabled);
		CID2._group.add(CID2._group_button[_num]);
	}
	
	// OPTION FUNCTIONS STOP HERE.
	
	public function draw_gameboard():Void
	{
		CID2._sprite_board_game_unit_even = new FlxSprite(0, 0, "assets/images/scenes/tiles/even/"+ RegCustom._gameboard_units_even_shade_number[Reg._tn][0] +".png");
		CID2._sprite_board_game_unit_even.setPosition(80, 105 + CID2._offset_y);
		CID2._sprite_board_game_unit_even.scale.set(0.8, 0.8);
		CID2._group.add(CID2._sprite_board_game_unit_even);
		CID2._sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
		CID2._sprite_board_game_unit_even.alpha = 0;
		
		CID2._sprite_board_game_unit_odd = new FlxSprite(0, 0, "assets/images/scenes/tiles/odd/"+ RegCustom._gameboard_units_odd_shade_number[Reg._tn][0] +".png");
		CID2._sprite_board_game_unit_odd.setPosition(80, 105 + CID2._offset_y);
		CID2._sprite_board_game_unit_odd.scale.set(0.8, 0.8);
		CID2._group.add(CID2._sprite_board_game_unit_odd);
		CID2._sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);	
		
		CID2._sprite_gameboard_border = new FlxSprite(0, 0, "assets/images/gameboardBorder"+ RegCustom._gameboard_border_number[Reg._tn] +".png");
		CID2._sprite_gameboard_border.setPosition(50, 105);
		CID2._sprite_gameboard_border.scale.set(0.8, 0.8);
		if (RegCustom._gameboard_border_enabled[Reg._tn] == false)
			CID2._sprite_gameboard_border.alpha = 0;
		CID2._group.add(CID2._sprite_gameboard_border);
		
		CID2._sprite_gameboard_coordinates = new FlxSprite(0, 0, "assets/images/coordinates.png");
		CID2._sprite_gameboard_coordinates.setPosition(50, 105);
		CID2._sprite_gameboard_coordinates.scale.set(0.8, 0.8);
		if (RegCustom._gameboard_coordinates_enabled[Reg._tn] == false) CID2._sprite_gameboard_coordinates.alpha = 0;
		CID2._group.add(CID2._sprite_gameboard_coordinates);
		
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_val:Int = 0):Void
	{
		if (Reg._tn == 0) return;
		
		switch (_val)
		{
			case 0: __e.shadeUnitsOddMinus();
			case 1: __e.shadeUnitsOddPlus();
			case 2: __e.shadeUnitsEvenMinus();
			case 3: __e.shadeUnitsEvenPlus();			
			case 4: __e.colorUnitsOddMinus();
			case 5: __e.colorUnitsOddPlus();
			case 6: __e.colorUnitsEvenMinus();
			case 7: __e.colorUnitsEvenPlus();
			case 8: __e.gameboard_border_minus();
			case 9: __e.gameboard_border_plus();
			case 10: __e.gameboard_border_enabled();
			case 11: __e.gameboard_coordinates_enabled();
			case 12: __e.notation_panel_enabled();
			case 13: __e.notation_panel_alpha();
			case 14: __e.notation_panel_same_background_color();
			case 15: __e.notation_background_color();
			case 16: __e.notation_panel_background_color_minus();
			case 17: __e.notation_panel_background_color_plus();
			case 18: __e.notation_panel_text_color_minus();
			case 19: __e.notation_panel_text_color_plus();
			case 20: __e.client_topic_title_text_color_minus();
			case 21: __e.client_topic_title_text_color_plus();
			case 22: __e.client_text_color_minus();
			case 23: __e.client_text_color_plus();
			case 24: __e.title_bar_text_color_minus();
			case 25: __e.title_bar_text_color_plus();
			case 26: __e.gameboard_even_units_show_enabled();
			case 27: __e.client_background_alpha();
			case 28: __e.client_gradient_background_enabled();
			case 29: __e.client_gradient_background_number_minus();
			case 30: __e.client_gradient_background_number_plus();
			case 31: __e.client_texture_background_enabled();
			case 32: __e.client_texture_background_number_minus();
			case 33: __e.client_texture_background_number_plus();
			case 34: __e.client_background_enabled();
			case 35: __e.client_background_number_minus();
			case 36: __e.client_background_number_plus();
			case 37: __e.client_background_brightness_minus();
			case 38: __e.client_background_brightness_plus();		
			case 39: __e.client_background_saturation_minus();
			case 40: __e.client_background_saturation_plus();
			case 41: __e.table_body_background_minus();
			case 42: __e.table_body_background_plus();
			case 43: __e.table_body_background_brightness_minus();
			case 44: __e.table_body_background_brightness_plus();
			case 45: __e.table_body_background_saturation_minus();
			case 46: __e.table_body_background_saturation_plus();
			case 47: __e.leaderboards_enabled();
			case 48: __e.house_feature_enabled();
			case 49: __e.go_back_to_title_after_save();
			case 50: __e.automatic_game_request();
			case 51: __e.start_game_offline_confirmation();
			case 52: __e.accept_automatic_game_request();
			case 53: __e.to_lobby_waiting_room_confirmation();
			case 54: __e.to_lobby_game_room_confirmation();
			case 55: __e.to_game_room_confirmation();
			case 56: __e.to_title_confirmation();
			case 57: __e.chat_turn_off_lobby();
			case 58: __e.chat_turn_off_room();
			case 59: __e.move_timer_enabled();
			case 60: __e.move_total_enabled();			
			case 61: __e.capturing_units_enabled();
			case 62: __e.capturing_units_minus();
			case 63: __e.capturing_units_plus();
			case 64: __e.button_background_color();
			case 65: __e.button_border_color();
			case 66: __e.button_text_color();
			case 67: __e.music_enabled();
			case 68: __e.sound_enabled();
			case 69: __e.title_bar_background_number_minus();
			case 70: __e.title_bar_background_number_plus();
			case 71: __e.title_bar_background_brightness_minus();
			case 72: __e.title_bar_background_brightness_plus();
			case 73: __e.menu_bar_background_number_minus();
			case 74: __e.menu_bar_background_number_plus();
			case 75: __e.menu_bar_background_brightness_minus();
			case 76: __e.menu_bar_background_brightness_plus();
			case 77: __e.pager_enabled();
		}
	}
		
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumberToggle():Void
	{
		switch (Reg._gameId)
		{
			case 0: __e.defaultColorsCheckers();
			case 1:	__e.defaultColorsChess();
			
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		if (RegCustom._notation_panel_background_color_enabled[Reg._tn] == false &&	CID2._sprite_notation_panel_background_color.visible == true)
		{
			CID2._sprite_notation_panel_background_color.visible = false;
		}
		
		if (RegCustom._capturing_units[Reg._tn] == false
		&&	CID2._sprite_capturing_units.visible == true)
		{
			CID2._sprite_capturing_units.visible = false;
		}
		
		if (RegCustom._capturing_units[Reg._tn] == false
		&&	CID2._sprite_chess_path_to_king_bg.visible == true)
		{
			CID2._sprite_chess_path_to_king_bg.visible = false;
		}
		
		// configuration menu. options saved.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			// do not remove. its needed at ConfigurationsOutput.hx
			FlxG.mouse.visible = false;
			Reg2._configuration_jump_to_scene = 1;
			
			FlxG.switchState(new Configuration());
		}
		
		if (Reg._buttonCodeValues == "")
		{	
			for (i in 0... CID2._group_button.length)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= CID2._group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= CID2._group_button[i]._startY + CID2._group_button[i]._button_height 
				&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= CID2._group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= CID2._group_button[i]._startX + CID2._group_button[i]._button_width && FlxG.mouse.justPressed == true )
				{
					if (Reg._tn > 0)
					{
						buttonNumber(i);
						break;
					}
				}
				
			}
		
			//############################# code for toggle buttons. used along with __scrollable_area scroll offset.
			for (i in 0... CID2._group_button_toggle.length)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonToggleFlxState._scrollarea_offset_y >= CID2._group_button_toggle[i]._startY &&  FlxG.mouse.y + ButtonToggleFlxState._scrollarea_offset_y <= CID2._group_button_toggle[i]._startY + CID2._group_button_toggle[i]._button_height 
				&& FlxG.mouse.x + ButtonToggleFlxState._scrollarea_offset_x >= CID2._group_button_toggle[i]._startX &&  FlxG.mouse.x + ButtonToggleFlxState._scrollarea_offset_x <= CID2._group_button_toggle[i]._startX + CID2._group_button_toggle[i]._button_width && FlxG.mouse.justPressed == true )
				{
					Reg._gameId = i;
					buttonNumberToggle();
					
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._scrollable_area_is_scrolling == false)
						FlxG.sound.play("click", 1, false);
				}
				
			}
		}
		
		super.update(elapsed);		
	}
	
}//