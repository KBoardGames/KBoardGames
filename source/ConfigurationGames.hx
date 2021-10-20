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

package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class ConfigurationGames extends FlxGroup
{
	private var __configurations_output:ConfigurationOutput;
	
	override public function new(menu_configurations_output:ConfigurationOutput):Void
	{
		super();
		__configurations_output = menu_configurations_output;
		
		sceneGames();
	}
	
	public function sceneGames():Void
	{
		CID1._group = cast add(new FlxSpriteGroup());		
		CID1._group_button.splice(0, CID1._group_button.length);
				
		CID1._game_minutes = new FlxText(0, 100, 0, "Minutes");
		CID1._game_minutes.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		CID1._game_minutes.screenCenter(X);
		CID1._game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._game_minutes);
		
		CID1._description_game_minutes = new FlxText(15, 150, 0, "Select the total allowed minutes for a game.");
		CID1._description_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._description_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._description_game_minutes);
		
		//############################# checkers time remaining,
		CID1._title_checkers_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 75, 400, "Checkers");
		CID1._title_checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._title_checkers_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._title_checkers_game_minutes);
		
		CID1._checkers_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_checkers_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._checkers_minus_minutes.label.font = Reg._fontDefault;
		CID1._checkers_minus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._checkers_minus_minutes);
		CID1._group.add(CID1._group_button[0]);
		
		CID1._checkers_game_minutes = new FlxText(CID1._checkers_minus_minutes.x + 48, CID1._title_checkers_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][0]));
		CID1._checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._checkers_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._checkers_game_minutes);
		
		CID1._checkers_plus_minutes = new ButtonGeneralNetworkNo(CID1._checkers_minus_minutes.x + 90, CID1._title_checkers_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);		
		CID1._checkers_plus_minutes.label.font = Reg._fontDefault;	
		CID1._checkers_plus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._checkers_plus_minutes);
		CID1._group.add(CID1._group_button[1]);
		
		//############################# chess time remaining,
		CID1._title_chess_game_minutes = new TextGeneral(15, CID1._checkers_plus_minutes.y + 75, 450, "chess");
		CID1._title_chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._title_chess_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._title_chess_game_minutes);
		
		CID1._chess_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_chess_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._chess_minus_minutes.label.font = Reg._fontDefault;
		CID1._chess_minus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._chess_minus_minutes);
		CID1._group.add(CID1._group_button[2]);
				
		CID1._chess_game_minutes = new FlxText(CID1._chess_minus_minutes.x + 48, CID1._title_chess_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][1]));
		CID1._chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._chess_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._chess_game_minutes);
		
		CID1._chess_plus_minutes = new ButtonGeneralNetworkNo(CID1._chess_minus_minutes.x + 90, CID1._title_chess_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._chess_plus_minutes.label.font = Reg._fontDefault;	
		CID1._chess_plus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._chess_plus_minutes);
		CID1._group.add(CID1._group_button[3]);
		
		//############################# Reversi time remaining,
		CID1._title_reversi_game_minutes = new TextGeneral(15, CID1._chess_plus_minutes.y + 75, 450, "reversi");
		CID1._title_reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._title_reversi_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._title_reversi_game_minutes);
		
		CID1._reversi_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_reversi_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._reversi_minus_minutes.label.font = Reg._fontDefault;
		CID1._reversi_minus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._reversi_minus_minutes);
		CID1._group.add(CID1._group_button[4]);
				
		CID1._reversi_game_minutes = new FlxText(CID1._reversi_minus_minutes.x + 48, CID1._title_reversi_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][2]));
		CID1._reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._reversi_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._reversi_game_minutes);
		
		CID1._reversi_plus_minutes = new ButtonGeneralNetworkNo(CID1._reversi_minus_minutes.x + 90, CID1._title_reversi_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._reversi_plus_minutes.label.font = Reg._fontDefault;	
		CID1._reversi_plus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._reversi_plus_minutes);
		CID1._group.add(CID1._group_button[5]);
		
		//############################# snakes and ladders time remaining,
		CID1._title_snakes_ladders_game_minutes = new TextGeneral(15, CID1._reversi_plus_minutes.y + 75, 450, "snakes and ladders");
		CID1._title_snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._title_snakes_ladders_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._title_snakes_ladders_game_minutes);
		
		CID1._snakes_ladders_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_snakes_ladders_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._snakes_ladders_minus_minutes.label.font = Reg._fontDefault;
		CID1._snakes_ladders_minus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._snakes_ladders_minus_minutes);
		CID1._group.add(CID1._group_button[6]);
				
		CID1._snakes_ladders_game_minutes = new FlxText(CID1._snakes_ladders_minus_minutes.x + 48, CID1._title_snakes_ladders_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][3]));
		CID1._snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._snakes_ladders_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._snakes_ladders_game_minutes);
		
		CID1._snakes_ladders_plus_minutes = new ButtonGeneralNetworkNo(CID1._snakes_ladders_minus_minutes.x + 90, CID1._title_snakes_ladders_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._snakes_ladders_plus_minutes.label.font = Reg._fontDefault;	
		CID1._snakes_ladders_plus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._snakes_ladders_plus_minutes);
		CID1._group.add(CID1._group_button[7]);
		
		//############################# signature time remaining,
		CID1._title_signature_game_minutes = new TextGeneral(15, CID1._snakes_ladders_plus_minutes.y + 75, 0, "wheel estate");
		CID1._title_signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._title_signature_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._title_signature_game_minutes);
		
		CID1._signature_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_signature_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._signature_minus_minutes.label.font = Reg._fontDefault;
		CID1._signature_minus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._signature_minus_minutes);
		CID1._group.add(CID1._group_button[8]);
		
		CID1._signature_game_minutes = new FlxText(CID1._signature_minus_minutes.x + 48, CID1._title_signature_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][4]));
		CID1._signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._signature_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._signature_game_minutes);
		
		CID1._signature_plus_minutes = new ButtonGeneralNetworkNo(CID1._signature_minus_minutes.x + 90, CID1._title_signature_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);		
		CID1._signature_plus_minutes.label.font = Reg._fontDefault;	
		CID1._signature_plus_minutes.label.bold = true;
		
		CID1._group_button.push(CID1._signature_plus_minutes);
		CID1._group.add(CID1._group_button[9]);
		
		// chess title.
		CID1._chess = new FlxText(15, CID1._signature_plus_minutes.y + 100, 0, "Chess.");
		CID1._chess.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		CID1._chess.screenCenter(X);
		CID1._chess.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._chess);
	
		CID1._question_chess_opening_moves_enabled = new TextGeneral(15, CID1._chess.y + 90, 800, "Display the chess opening move text?");
		CID1._question_chess_opening_moves_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_opening_moves_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_opening_moves_enabled);
		
		CID1._button_chess_opening_moves_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_opening_moves_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_opening_moves_enabled.label.font = Reg._fontDefault;
		CID1._button_chess_opening_moves_enabled.label.text = Std.string(RegCustom._chess_opening_moves_enabled[Reg._tn]);
		
		CID1._group_button.push(CID1._button_chess_opening_moves_enabled);
		CID1._group.add(CID1._group_button[10]);
		
		CID1._question_chess_show_last_piece_moved = new TextGeneral(15, CID1._button_chess_opening_moves_enabled.height + CID1._button_chess_opening_moves_enabled.y + CID1._offset_rows_y, 800, "Show last piece moved?");
		CID1._question_chess_show_last_piece_moved.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_show_last_piece_moved.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_show_last_piece_moved);
		
		CID1._button_chess_show_last_piece_moved = new ButtonGeneralNetworkNo(850, CID1._question_chess_show_last_piece_moved.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_show_last_piece_moved.label.font = Reg._fontDefault;
		CID1._button_chess_show_last_piece_moved.label.text = Std.string(RegCustom._chess_show_last_piece_moved[Reg._tn]);
		
		CID1._group_button.push(CID1._button_chess_show_last_piece_moved);
		CID1._group.add(CID1._group_button[11]);
		
		CID1._question_chess_computer_thinking_enabled = new TextGeneral(15, CID1._button_chess_show_last_piece_moved.height + CID1._button_chess_show_last_piece_moved.y + CID1._offset_rows_y, 800, "Show computer spinner image when thinking?");
		CID1._question_chess_computer_thinking_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_computer_thinking_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_computer_thinking_enabled);
		
		CID1._button_chess_computer_thinking_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_computer_thinking_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_computer_thinking_enabled.label.font = Reg._fontDefault;
		CID1._button_chess_computer_thinking_enabled.label.text = Std.string(RegCustom._chess_computer_thinking_enabled[Reg._tn]);
		
		CID1._group_button.push(CID1._button_chess_computer_thinking_enabled);
		CID1._group.add(CID1._group_button[12]);
		
		CID1._question_chess_future_capturing_units_enabled = new TextGeneral(15, CID1._button_chess_computer_thinking_enabled.height +  CID1._button_chess_computer_thinking_enabled.y + CID1._offset_rows_y, 800, "The future capturing units feature show upcoming attacks to the king and is only available while playing against the computer with a chess skill level of beginner. Enabled the futute capturing units feature?", 8, true, true);
		CID1._question_chess_future_capturing_units_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_future_capturing_units_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_future_capturing_units_enabled);
		
		CID1._button_chess_future_capturing_units_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_future_capturing_units_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_future_capturing_units_enabled.label.font = Reg._fontDefault;
		CID1._button_chess_future_capturing_units_enabled.label.text = Std.string(RegCustom._chess_future_capturing_units_enabled[Reg._tn]);
		
		CID1._group_button.push(CID1._button_chess_future_capturing_units_enabled);
		CID1._group.add(CID1._group_button[13]);
		
		//############################## plus and minus future capturing unit buttons.
		CID1._button_chess_future_capturing_units_minus = new ButtonGeneralNetworkNo(CID1._button_chess_future_capturing_units_enabled.x + CID1._button_chess_future_capturing_units_enabled.width + 15, CID1._button_chess_future_capturing_units_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_future_capturing_units_minus.label.font = Reg._fontDefault;
		
		CID1._group_button.push(CID1._button_chess_future_capturing_units_minus);
		CID1._group.add(CID1._group_button[14]);		
		
		CID1._button_chess_future_capturing_units_plus = new ButtonGeneralNetworkNo(CID1._button_chess_future_capturing_units_minus.x + CID1._button_chess_future_capturing_units_minus.width + 15, CID1._button_chess_future_capturing_units_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_future_capturing_units_plus.label.font = Reg._fontDefault;
		
		CID1._group_button.push(CID1._button_chess_future_capturing_units_plus);
		CID1._group.add(CID1._group_button[15]);
		
		CID1._sprite_chess_future_capturing_units_bg = new FlxSprite(CID1._button_chess_future_capturing_units_plus.x + CID1._button_chess_future_capturing_units_plus.width + 45, CID1._button_chess_future_capturing_units_plus.y - 10, "assets/images/blackBackground.jpg");
		CID1._group.add(CID1._sprite_chess_future_capturing_units_bg);
		
		CID1._sprite_chess_future_capturing_units = new FlxSprite(CID1._button_chess_future_capturing_units_plus.x + CID1._button_chess_future_capturing_units_plus.width + 45, CID1._button_chess_future_capturing_units_plus.y - 10);
		CID1._sprite_chess_future_capturing_units.loadGraphic("assets/images/futureCapturingUnits.png", true, 75, 75);
		CID1._sprite_chess_future_capturing_units.animation.add("path empty unit", [2], 1, false);
		CID1._sprite_chess_future_capturing_units.animation.play("path empty unit");
		CID1._sprite_chess_future_capturing_units.color = RegCustomColors.color_future_capturing_units();
		CID1._group.add(CID1._sprite_chess_future_capturing_units);
		
		//##############################
		
		CID1._question_chess_path_to_king_enabled = new TextGeneral(15, CID1._question_chess_future_capturing_units_enabled.height + CID1._question_chess_future_capturing_units_enabled.y + (CID1._offset_rows_y * 4) + 5, 800, "the path to king are units in a straight line showing where an attack on the king is coming from. Enable the path to king feature?", 8, true, true);
		CID1._question_chess_path_to_king_enabled.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_path_to_king_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_path_to_king_enabled);
		
		CID1._button_chess_path_to_king_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_path_to_king_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_path_to_king_enabled.label.font = Reg._fontDefault;
		CID1._button_chess_path_to_king_enabled.label.text = Std.string(RegCustom._chess_path_to_king_enabled[Reg._tn]);
		
		CID1._group_button.push(CID1._button_chess_path_to_king_enabled);
		CID1._group.add(CID1._group_button[16]);

		//############################## plus and minus path to king buttons.
		CID1._button_chess_path_to_king_minus = new ButtonGeneralNetworkNo(CID1._button_chess_path_to_king_enabled.x + CID1._button_chess_path_to_king_enabled.width + 15, CID1._button_chess_path_to_king_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_path_to_king_minus.label.font = Reg._fontDefault;
		
		CID1._group_button.push(CID1._button_chess_path_to_king_minus);
		CID1._group.add(CID1._group_button[17]);		
		
		CID1._button_chess_path_to_king_plus = new ButtonGeneralNetworkNo(CID1._button_chess_path_to_king_minus.x + CID1._button_chess_path_to_king_minus.width + 15, CID1._button_chess_path_to_king_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_path_to_king_plus.label.font = Reg._fontDefault;
		
		CID1._group_button.push(CID1._button_chess_path_to_king_plus);
		CID1._group.add(CID1._group_button[18]);
				
		CID1._sprite_chess_path_to_king = new FlxSprite(CID1._button_chess_path_to_king_plus.x + CID1._button_chess_path_to_king_plus.width + 45, CID1._button_chess_path_to_king_plus.y - 10);
		CID1._sprite_chess_path_to_king.loadGraphic("assets/images/pathToKing.png", false, 75, 75);
		CID1._sprite_chess_path_to_king.color = RegCustomColors.color_path_to_king();
		CID1._group.add(CID1._sprite_chess_path_to_king);
		
		CID1._sprite_chess_path_to_king_bg = new FlxSprite(CID1._button_chess_path_to_king_plus.x + CID1._button_chess_path_to_king_plus.width + 45, CID1._button_chess_path_to_king_plus.y - 10, "assets/images/dailyQuestsBorder1.png");
		CID1._group.add(CID1._sprite_chess_path_to_king_bg);
		
		//##############################
		
		CID1._question_chess_set_for_player1 = new TextGeneral(15, CID1._question_chess_path_to_king_enabled.height + CID1._question_chess_path_to_king_enabled.y + (CID1._offset_rows_y * 3) + 5, 600, "Player 1 chess piece set.");
		CID1._question_chess_set_for_player1.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_set_for_player1.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_set_for_player1);
		
		CID1._button_chess_set_for_player1_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player1.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player1_minus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player1_minus.label.text = "-";
		
		CID1._group_button.push(CID1._button_chess_set_for_player1_minus);
		CID1._group.add(CID1._group_button[19]);
		
		CID1._button_chess_set_for_player1_plus = new ButtonGeneralNetworkNo(CID1._button_chess_set_for_player1_minus.x + 50, CID1._question_chess_set_for_player1.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player1_plus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player1_plus.label.text = "+";
		
		CID1._group_button.push(CID1._button_chess_set_for_player1_plus);
		CID1._group.add(CID1._group_button[20]);
		
		CID1._sprite_display_pawn_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y, CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_pawn_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_pawn_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_pawn_from_p1_chess_set);
		
		CID1._sprite_display_bishop_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + 90, CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_bishop_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_bishop_from_p1_chess_set);
		
		CID1._sprite_display_horse_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (2 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_horse_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_horse_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_horse_from_p1_chess_set);
		
		CID1._sprite_display_rook_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (3 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_rook_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_rook_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_rook_from_p1_chess_set);
		
		CID1._sprite_display_queen_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (4 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_queen_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_queen_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_queen_from_p1_chess_set);
		
		CID1._sprite_display_king_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (5 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
		CID1._sprite_display_king_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/6.png", false, 75, 75);
		CID1._sprite_display_king_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
		CID1._group.add(CID1._sprite_display_king_from_p1_chess_set);
		
		CID1._question_chess_set_for_player1_color = new TextGeneral(15, CID1._question_chess_set_for_player1.height + CID1._question_chess_set_for_player1.y + 65, 0, "chess piece set color 1.");
		CID1._question_chess_set_for_player1_color.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_set_for_player1_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_set_for_player1_color);
		
		CID1._button_chess_set_for_player1_color_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player1_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player1_color_minus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player1_color_minus.label.text = "-";
		
		CID1._group_button.push(CID1._button_chess_set_for_player1_color_minus);
		CID1._group.add(CID1._group_button[21]);
		
		CID1._button_chess_set_for_player1_color_plus = new ButtonGeneralNetworkNo(CID1._button_chess_set_for_player1_color_minus.x + 50, CID1._question_chess_set_for_player1_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player1_color_plus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player1_color_plus.label.text = "+";
		
		CID1._group_button.push(CID1._button_chess_set_for_player1_color_plus);
		CID1._group.add(CID1._group_button[22]);
		
		//#############################
		
		CID1._question_chess_set_for_player2 = new TextGeneral(15, CID1._button_chess_set_for_player1_color_plus.height + CID1._button_chess_set_for_player1_color_plus.y + CID1._offset_rows_y, 0, "Player 2 chess piece set.");
		CID1._question_chess_set_for_player2.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_set_for_player2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_set_for_player2);
		
		CID1._button_chess_set_for_player2_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player2.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player2_minus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player2_minus.label.text = "-";
		
		CID1._group_button.push(CID1._button_chess_set_for_player2_minus);
		CID1._group.add(CID1._group_button[23]);
		
		CID1._button_chess_set_for_player2_plus = new ButtonGeneralNetworkNo(650 + 50, CID1._question_chess_set_for_player2.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player2_plus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player2_plus.label.text = "+";
		
		CID1._group_button.push(CID1._button_chess_set_for_player2_plus);
		CID1._group.add(CID1._group_button[24]);
		
		CID1._sprite_display_pawn_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y, CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_pawn_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_pawn_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_pawn_from_p2_chess_set);
		
		CID1._sprite_display_bishop_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + 90, CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_bishop_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_bishop_from_p2_chess_set);
		
		CID1._sprite_display_horse_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (2 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_horse_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_horse_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_horse_from_p2_chess_set);
		
		CID1._sprite_display_rook_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (3 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_rook_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_rook_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_rook_from_p2_chess_set);
		
		CID1._sprite_display_queen_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (4 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_queen_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_queen_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_queen_from_p2_chess_set);
		
		CID1._sprite_display_king_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (5 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
		CID1._sprite_display_king_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/6.png", false, 75, 75);
		CID1._sprite_display_king_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
		CID1._group.add(CID1._sprite_display_king_from_p2_chess_set);
		
		
		CID1._question_chess_set_for_player2_color = new TextGeneral(15, CID1._question_chess_set_for_player2.height + CID1._question_chess_set_for_player2.y + 65, 0, "chess piece set color 2.");
		CID1._question_chess_set_for_player2_color.setFormat(Reg._fontDefault, Reg._font_size);
		CID1._question_chess_set_for_player2_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._question_chess_set_for_player2_color);
		
		CID1._button_chess_set_for_player2_color_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player2_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player2_color_minus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player2_color_minus.label.text = "-";
		
		CID1._group_button.push(CID1._button_chess_set_for_player2_color_minus);
		CID1._group.add(CID1._group_button[25]);
		
		CID1._button_chess_set_for_player2_color_plus = new ButtonGeneralNetworkNo(650 + 50, CID1._question_chess_set_for_player2_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._button_chess_set_for_player2_color_plus.label.font = Reg._fontDefault;
		CID1._button_chess_set_for_player2_color_plus.label.text = "+";
		
		CID1._group_button.push(CID1._button_chess_set_for_player2_color_plus);
		CID1._group.add(CID1._group_button[26]);
		
		CID1._button_end_of_group_y_padding = new ButtonGeneralNetworkNo(0, (CID1._button_chess_set_for_player2_color_plus).y + 200, "", 240, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		CID1._group.add(CID1._button_end_of_group_y_padding);

	}
		
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_num:Int):Void
	{
		if (Reg._tn == 0) return;
		
		switch (_num)
		{
			case 0: minusMinutes(0);
			case 1: plusMinutes(0);
			case 2: minusMinutes(1);
			case 3: plusMinutes(1);
			case 4: minusMinutes(2);
			case 5: plusMinutes(2);
			case 6: minusMinutes(3);
			case 7: plusMinutes(3);
			case 8: minusMinutes(4);
			case 9: plusMinutes(4);
			case 10: save_chess_opening_moves_enabled();
			case 11: save_chess_show_last_piece_moved();
			case 12: save_chess_computer_thinking_enabled();
			case 13: save_chess_future_capturing_units();
			case 14: save_chess_future_capturing_units_minus();
			case 15: save_chess_future_capturing_units_plus();
			case 16: save_chess_path_to_king();
			case 17: save_chess_path_to_king_minus();
			case 18: save_chess_path_to_king_plus();
			case 19: save_chess_piece_p1_set_current_minus();
			case 20: save_chess_piece_p1_set_current_plus();
			case 21: save_chess_piece_p1_set_color_current_minus();
			case 22: save_chess_piece_p1_set_color_current_plus();
			case 23: save_chess_piece_p2_set_current_minus();
			case 24: save_chess_piece_p2_set_current_plus();
			case 25: save_chess_piece_p2_set_color_current_minus();
			case 26: save_chess_piece_p2_set_color_current_plus();
		}
	}
	
	/******************************
	 * minus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function minusMinutes(_id:Int):Void
	{
		// minus 5 from the total time for the game selected.
		if (RegCustom._time_remaining_for_game[Reg._tn][_id]
		!=  RegCustom._timer_minimum_permitted_for_game[_id])
			RegCustom._time_remaining_for_game[Reg._tn][_id] -= 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * plus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function plusMinutes(_id:Int):Void
	{
		// plus 5 from the total time for the game selected.
		if (RegCustom._time_remaining_for_game[Reg._tn][_id]
		!=  RegCustom._timer_maximum_permitted_for_game[_id])
			RegCustom._time_remaining_for_game[Reg._tn][_id] += 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * game minutes text for a game of _id is updated when a plus button or minus button (buttons that changes the minutes for a game) is clicked.
	 */
	private function updateGameMinutes(_id:Int):Void
	{
		switch (_id)
		{
			// checkers
			case 0: CID1._checkers_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][0]);
			case 1: CID1._chess_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][1]);
			case 2: CID1._reversi_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][2]);
			case 3: CID1._snakes_ladders_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][3]);
			case 4: CID1._signature_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][4]);
		}
	}
	
	private function save_chess_opening_moves_enabled():Void
	{
		if (RegCustom._chess_opening_moves_enabled[Reg._tn] == false)
			RegCustom._chess_opening_moves_enabled[Reg._tn] = true;
		else
			RegCustom._chess_opening_moves_enabled[Reg._tn] = false;
			
		CID1._button_chess_opening_moves_enabled.label.text = Std.string(RegCustom._chess_opening_moves_enabled[Reg._tn]);
	}
	
	private function save_chess_show_last_piece_moved():Void
	{
		if (RegCustom._chess_show_last_piece_moved[Reg._tn] == false)
			RegCustom._chess_show_last_piece_moved[Reg._tn] = true;
		else
			RegCustom._chess_show_last_piece_moved[Reg._tn] = false;
			
		CID1._button_chess_show_last_piece_moved.label.text = Std.string(RegCustom._chess_show_last_piece_moved[Reg._tn]);
	}
	
	private function save_chess_computer_thinking_enabled():Void
	{
		if (RegCustom._chess_computer_thinking_enabled[Reg._tn] == false)
			RegCustom._chess_computer_thinking_enabled[Reg._tn] = true;
		else
			RegCustom._chess_computer_thinking_enabled[Reg._tn] = false;
			
		CID1._button_chess_computer_thinking_enabled.label.text = Std.string(RegCustom._chess_computer_thinking_enabled[Reg._tn]);
	}
	
	private function save_chess_future_capturing_units():Void
	{
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == false)
		{
			RegCustom._chess_future_capturing_units_enabled[Reg._tn] = true;
		
			CID1._sprite_chess_future_capturing_units.visible = true;
			CID1._sprite_chess_future_capturing_units_bg.visible = true;
		}
		else
		{
			RegCustom._chess_future_capturing_units_enabled[Reg._tn] = false;
		
			CID1._sprite_chess_future_capturing_units.visible = false;
			CID1._sprite_chess_future_capturing_units_bg.visible = false;
		}
			
		CID1._button_chess_future_capturing_units_enabled.label.text = Std.string(RegCustom._chess_future_capturing_units_enabled[Reg._tn]);
	}
	
	private function save_chess_future_capturing_units_minus():Void
	{
		RegCustom._chess_future_capturing_units_number[Reg._tn] -= 1;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 0) RegCustom._chess_future_capturing_units_number[Reg._tn] = 13;
		
		CID1._sprite_chess_future_capturing_units.color = RegCustomColors.color_future_capturing_units();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function save_chess_future_capturing_units_plus():Void
	{
		RegCustom._chess_future_capturing_units_number[Reg._tn] += 1;
		if (RegCustom._chess_future_capturing_units_number[Reg._tn] == 14) RegCustom._chess_future_capturing_units_number[Reg._tn] = 1;
		
		CID1._sprite_chess_future_capturing_units.color = RegCustomColors.color_future_capturing_units();
		
	}
	
	private function save_chess_path_to_king():Void
	{
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == false)
		{
			RegCustom._chess_path_to_king_enabled[Reg._tn] = true;
		
			CID1._sprite_chess_path_to_king.visible = true;
			CID1._sprite_chess_path_to_king_bg.visible = true;
		}
		else
		{
			RegCustom._chess_path_to_king_enabled[Reg._tn] = false;
		
			CID1._sprite_chess_path_to_king.visible = false;
			CID1._sprite_chess_path_to_king_bg.visible = false;
		}
			
		CID1._button_chess_path_to_king_enabled.label.text = Std.string(RegCustom._chess_path_to_king_enabled[Reg._tn]);
	}
	
	private function save_chess_path_to_king_minus():Void
	{
		RegCustom._chess_path_to_king_number[Reg._tn] -= 1;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 0) RegCustom._chess_path_to_king_number[Reg._tn] = 13;
		
		CID1._sprite_chess_path_to_king.color = RegCustomColors.color_path_to_king();
	}
	
	// plus 1 to display a greater of a shade for these units.
	private function save_chess_path_to_king_plus():Void
	{
		RegCustom._chess_path_to_king_number[Reg._tn] += 1;
		if (RegCustom._chess_path_to_king_number[Reg._tn] == 14) RegCustom._chess_path_to_king_number[Reg._tn] = 1;
		
		CID1._sprite_chess_path_to_king.color = RegCustomColors.color_path_to_king();
		
	}
	
	private function save_chess_piece_p1_set_current_minus():Void
	{
		RegCustom._chess_set_for_player1[Reg._tn] -= 1;
		if (RegCustom._chess_set_for_player1[Reg._tn] == 0) RegCustom._chess_set_for_player1[Reg._tn] = 8;
		
		draw_update_p1_board_set();
	}
	
	private function save_chess_piece_p1_set_current_plus():Void
	{
		RegCustom._chess_set_for_player1[Reg._tn] += 1;
		if (RegCustom._chess_set_for_player1[Reg._tn] == 9) RegCustom._chess_set_for_player1[Reg._tn] = 1;
		
		draw_update_p1_board_set();
	}
	
	private function save_chess_piece_p1_set_color_current_minus():Void
	{
		RegCustom._chess_set_for_player1_color_number[Reg._tn] -= 1;
		if (RegCustom._chess_set_for_player1_color_number[Reg._tn] == 0) RegCustom._chess_set_for_player1_color_number[Reg._tn] = 25;
		
		var _color = RegCustomColors.draw_update_board_p1_set_color();
		
		CID1._sprite_display_pawn_from_p1_chess_set.color = _color;
		CID1._sprite_display_bishop_from_p1_chess_set.color = _color;
		CID1._sprite_display_horse_from_p1_chess_set.color = _color;
		CID1._sprite_display_rook_from_p1_chess_set.color = _color;
		CID1._sprite_display_queen_from_p1_chess_set.color = _color;
		CID1._sprite_display_king_from_p1_chess_set.color = _color;
	}
	
	
	private function save_chess_piece_p1_set_color_current_plus():Void
	{
		RegCustom._chess_set_for_player1_color_number[Reg._tn] += 1;
		if (RegCustom._chess_set_for_player1_color_number[Reg._tn] == 26) RegCustom._chess_set_for_player1_color_number[Reg._tn] = 1;
		
		var _color = RegCustomColors.draw_update_board_p1_set_color();
		
		CID1._sprite_display_pawn_from_p1_chess_set.color = _color;
		CID1._sprite_display_bishop_from_p1_chess_set.color = _color;
		CID1._sprite_display_horse_from_p1_chess_set.color = _color;
		CID1._sprite_display_rook_from_p1_chess_set.color = _color;
		CID1._sprite_display_queen_from_p1_chess_set.color = _color;
		CID1._sprite_display_king_from_p1_chess_set.color = _color;
	}
	
	private function draw_update_p1_board_set():Void
	{
		CID1._sprite_display_pawn_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_horse_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_rook_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_queen_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_king_from_p1_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/6.png", false, 75, 75);
	}
		
	private function save_chess_piece_p2_set_current_minus():Void
	{
		RegCustom._chess_set_for_player2[Reg._tn] -= 1;
		if (RegCustom._chess_set_for_player2[Reg._tn] == 0) RegCustom._chess_set_for_player2[Reg._tn] = 8;
		
		draw_update_p2_board_set();
	}
	
	private function save_chess_piece_p2_set_current_plus():Void
	{
		RegCustom._chess_set_for_player2[Reg._tn] += 1;
		if (RegCustom._chess_set_for_player2[Reg._tn] == 9) RegCustom._chess_set_for_player2[Reg._tn] = 1;
		
		draw_update_p2_board_set();
	}
		
	private function save_chess_piece_p2_set_color_current_minus():Void
	{
		RegCustom._chess_set_for_player2_color_number[Reg._tn] -= 1;
		if (RegCustom._chess_set_for_player2_color_number[Reg._tn] == 0) RegCustom._chess_set_for_player2_color_number[Reg._tn] = 25;
		
		var _color = RegCustomColors.draw_update_board_p2_set_color();
		
		CID1._sprite_display_pawn_from_p2_chess_set.color = _color;
		CID1._sprite_display_bishop_from_p2_chess_set.color = _color;
		CID1._sprite_display_horse_from_p2_chess_set.color = _color;
		CID1._sprite_display_rook_from_p2_chess_set.color = _color;
		CID1._sprite_display_queen_from_p2_chess_set.color = _color;
		CID1._sprite_display_king_from_p2_chess_set.color = _color;
	}
	
	private function save_chess_piece_p2_set_color_current_plus():Void
	{
		RegCustom._chess_set_for_player2_color_number[Reg._tn] += 1;
		if (RegCustom._chess_set_for_player2_color_number[Reg._tn] == 26) RegCustom._chess_set_for_player2_color_number[Reg._tn] = 1;
		
		var _color = RegCustomColors.draw_update_board_p2_set_color();
		
		CID1._sprite_display_pawn_from_p2_chess_set.color = _color;
		CID1._sprite_display_bishop_from_p2_chess_set.color = _color;
		CID1._sprite_display_horse_from_p2_chess_set.color = _color;
		CID1._sprite_display_rook_from_p2_chess_set.color = _color;
		CID1._sprite_display_queen_from_p2_chess_set.color = _color;
		CID1._sprite_display_king_from_p2_chess_set.color = _color;
	}
	
	private function draw_update_p2_board_set():Void
	{
		CID1._sprite_display_pawn_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_horse_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_rook_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_queen_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_king_from_p2_chess_set.loadGraphic("assets/images/chess/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/6.png", false, 75, 75);
	}
	
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == false)
			CID1._sprite_chess_future_capturing_units_bg.visible = false;
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == false)
			CID1._sprite_chess_future_capturing_units.visible = false;
		
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == false)
			CID1._sprite_chess_path_to_king.visible = false;
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == false)
			CID1._sprite_chess_path_to_king_bg.visible = false;
		
		// configuration menu. options saved.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			// do not remove. its needed at ConfigurationsOutput.hx
			FlxG.mouse.visible = false;
			Reg2._configuration_jump_to_scene = 0;
			
			FlxG.switchState(new Configuration());
		}
		
		for (i in 0... CID1._group_button.length)
		{
			// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= CID1._group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= CID1._group_button[i]._startY + CID1._group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= CID1._group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= CID1._group_button[i]._startX + CID1._group_button[i]._button_width && FlxG.mouse.justPressed == true )
			{
				if (Reg._tn > 0)
				{
					CID1._group_button[i].active = true;
					buttonNumber(i);
				}
			}		
			
			else 
			{
				
			}		
		}
		
		
	}
}