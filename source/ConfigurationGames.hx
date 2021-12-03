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
		CID1._group.members.splice(0, CID1._group.members.length);
		CID1._group_button.splice(0, CID1._group_button.length);
		CID1._question_gameIds_time_allowed.splice(0, CID1._question_gameIds_time_allowed.length);
		
		#if checkers
			CID1._question_gameIds_time_allowed.push(0);
		#end

		#if chess
			CID1._question_gameIds_time_allowed.push(1);
		#end

		#if reversi
			CID1._question_gameIds_time_allowed.push(2);
		#end

		#if snakesAndLadders
			CID1._question_gameIds_time_allowed.push(3);
		#end

		#if wheelEstate
			CID1._question_gameIds_time_allowed.push(4);
		#end
		
		if (CID1._question_gameIds_time_allowed.length > 0) 
			CID1._game_minutes = new FlxText(15, 100, 0, "Minutes");
		else 
			CID1._game_minutes = new FlxText(15, 100, 0, "All games have been turned off at project.xml. There are no configuration options to display.");
		
		CID1._game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		
		if (CID1._question_gameIds_time_allowed.length > 0)
			CID1._game_minutes.screenCenter(X);
		
		CID1._game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._game_minutes);
		
		if (CID1._question_gameIds_time_allowed.length == 0)
			return;
		
		CID1._description_game_minutes = new FlxText(15, 150, 0, "Select the total allowed minutes for a game.");
		CID1._description_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		CID1._description_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		CID1._group.add(CID1._description_game_minutes);
		
		//-----------------------------
		
		var _count:Int = 0;
		
		for (i in 0... Reg._total_games_in_release + 1)
		{
			if (CID1._question_gameIds_time_allowed[i] == 0)
			{
				//############################# checkers time remaining,
				CID1._title_checkers_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 85 + (i * 85), 400, "Checkers");
				CID1._title_checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._title_checkers_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._title_checkers_game_minutes);
				
				CID1._checkers_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_checkers_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._checkers_minus_minutes.label.font = Reg._fontDefault;
				CID1._checkers_minus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._checkers_minus_minutes);
				CID1._group.add(CID1._group_button[_count]);
				
				CID1._checkers_game_minutes = new FlxText(CID1._checkers_minus_minutes.x + 48, CID1._title_checkers_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][0]));
				CID1._checkers_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._checkers_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._checkers_game_minutes);
				
				CID1._checkers_plus_minutes = new ButtonGeneralNetworkNo(CID1._checkers_minus_minutes.x + 90, CID1._title_checkers_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);		
				CID1._checkers_plus_minutes.label.font = Reg._fontDefault;	
				CID1._checkers_plus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._checkers_plus_minutes);
				CID1._group.add(CID1._group_button[(_count + 1)]);
				
				_count += 2;
			}
			
			if (CID1._question_gameIds_time_allowed[i] == 1)
			{
				//############################# chess time remaining,
				CID1._title_chess_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 85 + (i * 85), 450, "chess");
				CID1._title_chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._title_chess_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._title_chess_game_minutes);
				
				CID1._chess_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_chess_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._chess_minus_minutes.label.font = Reg._fontDefault;
				CID1._chess_minus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._chess_minus_minutes);
				CID1._group.add(CID1._group_button[_count]);
						
				CID1._chess_game_minutes = new FlxText(CID1._chess_minus_minutes.x + 48, CID1._title_chess_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][1]));
				CID1._chess_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._chess_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._chess_game_minutes);
				
				CID1._chess_plus_minutes = new ButtonGeneralNetworkNo(CID1._chess_minus_minutes.x + 90, CID1._title_chess_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._chess_plus_minutes.label.font = Reg._fontDefault;	
				CID1._chess_plus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._chess_plus_minutes);
				CID1._group.add(CID1._group_button[(_count + 1)]);
				
				_count += 2;
			}
			
			if (CID1._question_gameIds_time_allowed[i] == 2)
			{
				//############################# Reversi time remaining,
				CID1._title_reversi_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 85 + (i * 85), 450, "reversi");
				CID1._title_reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._title_reversi_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._title_reversi_game_minutes);
				
				CID1._reversi_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_reversi_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._reversi_minus_minutes.label.font = Reg._fontDefault;
				CID1._reversi_minus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._reversi_minus_minutes);
				CID1._group.add(CID1._group_button[_count]);
						
				CID1._reversi_game_minutes = new FlxText(CID1._reversi_minus_minutes.x + 48, CID1._title_reversi_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][2]));
				CID1._reversi_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._reversi_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._reversi_game_minutes);
				
				CID1._reversi_plus_minutes = new ButtonGeneralNetworkNo(CID1._reversi_minus_minutes.x + 90, CID1._title_reversi_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._reversi_plus_minutes.label.font = Reg._fontDefault;	
				CID1._reversi_plus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._reversi_plus_minutes);
				CID1._group.add(CID1._group_button[(_count + 1)]);
				
				_count += 2;
			}
			
			if (CID1._question_gameIds_time_allowed[i] == 3)
			{
				//############################# snakes and ladders time remaining,
				CID1._title_snakes_ladders_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 85 + (i * 85), 450, "snakes and ladders");
				CID1._title_snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._title_snakes_ladders_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._title_snakes_ladders_game_minutes);
				
				CID1._snakes_ladders_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_snakes_ladders_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._snakes_ladders_minus_minutes.label.font = Reg._fontDefault;
				CID1._snakes_ladders_minus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._snakes_ladders_minus_minutes);
				CID1._group.add(CID1._group_button[_count]);
						
				CID1._snakes_ladders_game_minutes = new FlxText(CID1._snakes_ladders_minus_minutes.x + 48, CID1._title_snakes_ladders_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][3]));
				CID1._snakes_ladders_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._snakes_ladders_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._snakes_ladders_game_minutes);
				
				CID1._snakes_ladders_plus_minutes = new ButtonGeneralNetworkNo(CID1._snakes_ladders_minus_minutes.x + 90, CID1._title_snakes_ladders_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._snakes_ladders_plus_minutes.label.font = Reg._fontDefault;	
				CID1._snakes_ladders_plus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._snakes_ladders_plus_minutes);
				CID1._group.add(CID1._group_button[(_count + 1)]);
				
				_count += 2;
			}
			
			if (CID1._question_gameIds_time_allowed[i] == 4)
			{
				//############################# signature time remaining,
				CID1._title_signature_game_minutes = new TextGeneral(15, CID1._description_game_minutes.y + 85 + (i * 85), 0, "wheel estate");
				CID1._title_signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._title_signature_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._title_signature_game_minutes);
				
				CID1._signature_minus_minutes = new ButtonGeneralNetworkNo(850, CID1._title_signature_game_minutes.y + CID1._offset_button_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
				CID1._signature_minus_minutes.label.font = Reg._fontDefault;
				CID1._signature_minus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._signature_minus_minutes);
				CID1._group.add(CID1._group_button[_count]);
				
				CID1._signature_game_minutes = new FlxText(CID1._signature_minus_minutes.x + 48, CID1._title_signature_game_minutes.y, 0, Std.string(RegCustom._time_remaining_for_game[Reg._tn][4]));
				CID1._signature_game_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
				CID1._signature_game_minutes.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				CID1._group.add(CID1._signature_game_minutes);
				
				CID1._signature_plus_minutes = new ButtonGeneralNetworkNo(CID1._signature_minus_minutes.x + 90, CID1._title_signature_game_minutes.y + CID1._offset_button_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);		
				CID1._signature_plus_minutes.label.font = Reg._fontDefault;	
				CID1._signature_plus_minutes.label.bold = true;
				
				CID1._group_button.push(CID1._signature_plus_minutes);
				CID1._group.add(CID1._group_button[(_count + 1)]);
				
				_count += 2;
			}
		}
		
		_count -= 1;
		
		#if chess
			// chess title.
			CID1._chess = new FlxText(15, CID1._description_game_minutes.y + 85 + ((CID1._question_gameIds_time_allowed.length + 1) * 85), 0, "Chess.");
			CID1._chess.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			CID1._chess.screenCenter(X);
			CID1._chess.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._chess);
		
			CID1._question_chess_opening_moves_enabled = new TextGeneral(15, CID1._chess.y + 75, 800, "Display the chess opening move text?");
			CID1._question_chess_opening_moves_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_opening_moves_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_opening_moves_enabled);
			
			CID1._button_chess_opening_moves_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_opening_moves_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_opening_moves_enabled.label.font = Reg._fontDefault;
			CID1._button_chess_opening_moves_enabled.label.text = Std.string(RegCustom._chess_opening_moves_enabled[Reg._tn]);
			
			CID1._group_button.push(CID1._button_chess_opening_moves_enabled);
			CID1._group.add(CID1._group_button[(_count + 1)]);
			
			CID1._question_chess_show_last_piece_moved = new TextGeneral(15, CID1._button_chess_opening_moves_enabled.height + CID1._button_chess_opening_moves_enabled.y + CID1._offset_rows_y, 800, "Show last piece moved?");
			CID1._question_chess_show_last_piece_moved.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_show_last_piece_moved.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_show_last_piece_moved);
			
			CID1._button_chess_show_last_piece_moved = new ButtonGeneralNetworkNo(850, CID1._question_chess_show_last_piece_moved.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_show_last_piece_moved.label.font = Reg._fontDefault;
			CID1._button_chess_show_last_piece_moved.label.text = Std.string(RegCustom._chess_show_last_piece_moved[Reg._tn]);
			
			CID1._group_button.push(CID1._button_chess_show_last_piece_moved);
			CID1._group.add(CID1._group_button[(_count + 2)]);
			
			CID1._question_chess_future_capturing_units_enabled = new TextGeneral(15, CID1._button_chess_show_last_piece_moved.height +  CID1._button_chess_show_last_piece_moved.y + CID1._offset_rows_y, 800, "The future capturing units feature show upcoming attacks to the king. A chess skill level of beginner is needed for this feature to work. Enabled the future capturing units feature?", 8, true, true);
			CID1._question_chess_future_capturing_units_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_future_capturing_units_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_future_capturing_units_enabled);
			
			CID1._button_chess_future_capturing_units_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_future_capturing_units_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_future_capturing_units_enabled.label.font = Reg._fontDefault;
			CID1._button_chess_future_capturing_units_enabled.label.text = Std.string(RegCustom._chess_future_capturing_units_enabled[Reg._tn]);
			
			CID1._group_button.push(CID1._button_chess_future_capturing_units_enabled);
			CID1._group.add(CID1._group_button[(_count + 3)]);
			
			//############################## plus and minus future capturing unit buttons.
			CID1._button_chess_future_capturing_units_minus = new ButtonGeneralNetworkNo(CID1._button_chess_future_capturing_units_enabled.x + CID1._button_chess_future_capturing_units_enabled.width + 15, CID1._button_chess_future_capturing_units_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_future_capturing_units_minus.label.font = Reg._fontDefault;
			
			CID1._group_button.push(CID1._button_chess_future_capturing_units_minus);
			CID1._group.add(CID1._group_button[(_count + 4)]);		
			
			CID1._button_chess_future_capturing_units_plus = new ButtonGeneralNetworkNo(CID1._button_chess_future_capturing_units_minus.x + CID1._button_chess_future_capturing_units_minus.width + 15, CID1._button_chess_future_capturing_units_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_future_capturing_units_plus.label.font = Reg._fontDefault;
			
			CID1._group_button.push(CID1._button_chess_future_capturing_units_plus);
			CID1._group.add(CID1._group_button[(_count + 5)]);
			
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
			CID1._question_chess_path_to_king_enabled.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_path_to_king_enabled.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_path_to_king_enabled);
			
			CID1._button_chess_path_to_king_enabled = new ButtonGeneralNetworkNo(850, CID1._question_chess_path_to_king_enabled.y + CID1._offset_button_y, "", 100, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_path_to_king_enabled.label.font = Reg._fontDefault;
			CID1._button_chess_path_to_king_enabled.label.text = Std.string(RegCustom._chess_path_to_king_enabled[Reg._tn]);
			
			CID1._group_button.push(CID1._button_chess_path_to_king_enabled);
			CID1._group.add(CID1._group_button[(_count + 6)]);

			//############################## plus and minus path to king buttons.
			CID1._button_chess_path_to_king_minus = new ButtonGeneralNetworkNo(CID1._button_chess_path_to_king_enabled.x + CID1._button_chess_path_to_king_enabled.width + 15, CID1._button_chess_path_to_king_enabled.y + 7, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_path_to_king_minus.label.font = Reg._fontDefault;
			
			CID1._group_button.push(CID1._button_chess_path_to_king_minus);
			CID1._group.add(CID1._group_button[(_count + 7)]);		
			
			CID1._button_chess_path_to_king_plus = new ButtonGeneralNetworkNo(CID1._button_chess_path_to_king_minus.x + CID1._button_chess_path_to_king_minus.width + 15, CID1._button_chess_path_to_king_minus.y + 7, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_path_to_king_plus.label.font = Reg._fontDefault;
			
			CID1._group_button.push(CID1._button_chess_path_to_king_plus);
			CID1._group.add(CID1._group_button[(_count + 8)]);
					
			CID1._sprite_chess_path_to_king = new FlxSprite(CID1._button_chess_path_to_king_plus.x + CID1._button_chess_path_to_king_plus.width + 45, CID1._button_chess_path_to_king_plus.y - 10);
			CID1._sprite_chess_path_to_king.loadGraphic("assets/images/pathToKing.png", false, 75, 75);
			CID1._sprite_chess_path_to_king.color = RegCustomColors.color_path_to_king();
			CID1._group.add(CID1._sprite_chess_path_to_king);
			
			CID1._sprite_chess_path_to_king_bg = new FlxSprite(CID1._button_chess_path_to_king_plus.x + CID1._button_chess_path_to_king_plus.width + 45, CID1._button_chess_path_to_king_plus.y - 10, "assets/images/border1.png");
			CID1._group.add(CID1._sprite_chess_path_to_king_bg);
			
			//##############################
			
			CID1._question_chess_set_for_player1 = new TextGeneral(15, CID1._question_chess_path_to_king_enabled.height + CID1._question_chess_path_to_king_enabled.y + (CID1._offset_rows_y * 3) + 5, 600, "Player 1 chess piece set.");
			CID1._question_chess_set_for_player1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_set_for_player1.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_set_for_player1);
			
			CID1._button_chess_set_for_player1_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player1.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player1_minus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player1_minus.label.text = "-";
			
			CID1._group_button.push(CID1._button_chess_set_for_player1_minus);
			CID1._group.add(CID1._group_button[(_count + 9)]);
			
			CID1._button_chess_set_for_player1_plus = new ButtonGeneralNetworkNo(CID1._button_chess_set_for_player1_minus.x + 50, CID1._question_chess_set_for_player1.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player1_plus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player1_plus.label.text = "+";
			
			CID1._group_button.push(CID1._button_chess_set_for_player1_plus);
			CID1._group.add(CID1._group_button[(_count + 10)]);
			
			CID1._sprite_display_pawn_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y, CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_pawn_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/1.png", false, 75, 75);
			CID1._sprite_display_pawn_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_pawn_from_p1_chess_set);
			
			CID1._sprite_display_bishop_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + 90, CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_bishop_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/2.png", false, 75, 75);
			CID1._sprite_display_bishop_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_bishop_from_p1_chess_set);
			
			CID1._sprite_display_horse_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (2 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_horse_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/3.png", false, 75, 75);
			CID1._sprite_display_horse_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_horse_from_p1_chess_set);
			
			CID1._sprite_display_rook_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (3 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_rook_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/4.png", false, 75, 75);
			CID1._sprite_display_rook_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_rook_from_p1_chess_set);
			
			CID1._sprite_display_queen_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (4 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_queen_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/5.png", false, 75, 75);
			CID1._sprite_display_queen_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_queen_from_p1_chess_set);
			
			CID1._sprite_display_king_from_p1_chess_set = new FlxSprite(CID1._button_chess_set_for_player1_plus.x + CID1._button_chess_set_for_player1_plus.width + CID1._offset_rows_y + (5 * 90), CID1._button_chess_set_for_player1_plus.y + 30);
			CID1._sprite_display_king_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/6.png", false, 75, 75);
			CID1._sprite_display_king_from_p1_chess_set.color = RegCustomColors.draw_update_board_p1_set_color();
			CID1._group.add(CID1._sprite_display_king_from_p1_chess_set);
			
			CID1._question_chess_set_for_player1_color = new TextGeneral(15, CID1._question_chess_set_for_player1.height + CID1._question_chess_set_for_player1.y + 65, 0, "chess piece set color 1.");
			CID1._question_chess_set_for_player1_color.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_set_for_player1_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_set_for_player1_color);
			
			CID1._button_chess_set_for_player1_color_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player1_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player1_color_minus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player1_color_minus.label.text = "-";
			
			CID1._group_button.push(CID1._button_chess_set_for_player1_color_minus);
			CID1._group.add(CID1._group_button[(_count + 11)]);
			
			CID1._button_chess_set_for_player1_color_plus = new ButtonGeneralNetworkNo(CID1._button_chess_set_for_player1_color_minus.x + 50, CID1._question_chess_set_for_player1_color.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player1_color_plus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player1_color_plus.label.text = "+";
			
			CID1._group_button.push(CID1._button_chess_set_for_player1_color_plus);
			CID1._group.add(CID1._group_button[(_count + 12)]);
			
			//#############################
			
			CID1._question_chess_set_for_player2 = new TextGeneral(15, CID1._button_chess_set_for_player1_color_plus.height + CID1._button_chess_set_for_player1_color_plus.y + CID1._offset_rows_y, 0, "Player 2 chess piece set.");
			CID1._question_chess_set_for_player2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_set_for_player2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_set_for_player2);
			
			CID1._button_chess_set_for_player2_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player2.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player2_minus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player2_minus.label.text = "-";
			
			CID1._group_button.push(CID1._button_chess_set_for_player2_minus);
			CID1._group.add(CID1._group_button[(_count + 13)]);
			
			CID1._button_chess_set_for_player2_plus = new ButtonGeneralNetworkNo(650 + 50, CID1._question_chess_set_for_player2.y + CID1._offset_button_y, "", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player2_plus.label.font = Reg._fontDefault;
			CID1._button_chess_set_for_player2_plus.label.text = "+";
			
			CID1._group_button.push(CID1._button_chess_set_for_player2_plus);
			CID1._group.add(CID1._group_button[(_count + 14)]);
			
			CID1._sprite_display_pawn_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y, CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_pawn_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/1.png", false, 75, 75);
			CID1._sprite_display_pawn_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_pawn_from_p2_chess_set);
			
			CID1._sprite_display_bishop_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + 90, CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_bishop_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/2.png", false, 75, 75);
			CID1._sprite_display_bishop_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_bishop_from_p2_chess_set);
			
			CID1._sprite_display_horse_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (2 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_horse_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/3.png", false, 75, 75);
			CID1._sprite_display_horse_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_horse_from_p2_chess_set);
			
			CID1._sprite_display_rook_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (3 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_rook_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/4.png", false, 75, 75);
			CID1._sprite_display_rook_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_rook_from_p2_chess_set);
			
			CID1._sprite_display_queen_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (4 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_queen_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/5.png", false, 75, 75);
			CID1._sprite_display_queen_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_queen_from_p2_chess_set);
			
			CID1._sprite_display_king_from_p2_chess_set = new FlxSprite(CID1._button_chess_set_for_player2_plus.x + CID1._button_chess_set_for_player2_plus.width + CID1._offset_rows_y + (5 * 90), CID1._button_chess_set_for_player2_plus.y + 30);
			CID1._sprite_display_king_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/6.png", false, 75, 75);
			CID1._sprite_display_king_from_p2_chess_set.color = RegCustomColors.draw_update_board_p2_set_color();
			CID1._group.add(CID1._sprite_display_king_from_p2_chess_set);
			
			
			CID1._question_chess_set_for_player2_color = new TextGeneral(15, CID1._question_chess_set_for_player2.height + CID1._question_chess_set_for_player2.y + 65, 0, "chess piece set color 2.");
			CID1._question_chess_set_for_player2_color.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			CID1._question_chess_set_for_player2_color.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			CID1._group.add(CID1._question_chess_set_for_player2_color);
			
			CID1._button_chess_set_for_player2_color_minus = new ButtonGeneralNetworkNo(650, CID1._question_chess_set_for_player2_color.y + CID1._offset_button_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player2_color_minus.label.font = Reg._fontDefault;
			
			CID1._group_button.push(CID1._button_chess_set_for_player2_color_minus);
			CID1._group.add(CID1._group_button[(_count + 15)]);
			
			CID1._button_chess_set_for_player2_color_plus = new ButtonGeneralNetworkNo(700, CID1._question_chess_set_for_player2_color.y + CID1._offset_button_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._button_chess_set_for_player2_color_plus.label.font = Reg._fontDefault;
			CID1._group_button.push(CID1._button_chess_set_for_player2_color_plus);
			CID1._group.add(CID1._group_button[(_count + 16)]);
			
			CID1._button_end_of_group_y_padding = new ButtonGeneralNetworkNo(0, CID1._button_chess_set_for_player2_color_plus.y + 200, "", 240, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._group.add(CID1._button_end_of_group_y_padding);
			
		#else
			CID1._button_end_of_group_y_padding = new ButtonGeneralNetworkNo(0, 780, "", 240, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
			CID1._group.add(CID1._button_end_of_group_y_padding);
			
		#end
	}
		
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_num:Int):Void
	{
		if (Reg._tn == 0) return;
		
		// times 2 because there are timer plus button and timer minus button for each game.
		if (_num < (CID1._question_gameIds_time_allowed.length) * 2)
		{
			// the game plus button needs to be taken away so that we can get the correct value of the gameID.
			if (FlxMath.isOdd(_num)) _num -= 1;
			
			// to get the correct gameId, if there are two games available then divide the value by 2. for example, two games would display 4 buttons. 2 plus buttons and 2 minus buttons. if we have 2 game then divide those buttons by 2 to get 2 buttons. since we had already a minus by 1 value, the value now for the second game will be 1.
			if (FlxMath.isEven(_num) && _num > 1) _num = Std.int(_num / 2);
			
			if (FlxG.mouse.x > 912) // TODO remember to change this value if changing the layout of the plus / minus buttons.
				plusMinutes(_num);
			
			else 
				minusMinutes(_num);
			
		}
		
		else
		{
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2)) save_chess_opening_moves_enabled();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 1) save_chess_show_last_piece_moved();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 2) save_chess_future_capturing_units();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 3) save_chess_future_capturing_units_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 4) save_chess_future_capturing_units_plus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 5) save_chess_path_to_king();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 6) save_chess_path_to_king_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 7) save_chess_path_to_king_plus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 8) save_chess_piece_p1_set_current_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 9) save_chess_piece_p1_set_current_plus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 10) save_chess_piece_p1_set_color_current_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 11) save_chess_piece_p1_set_color_current_plus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 12) save_chess_piece_p2_set_current_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 13) save_chess_piece_p2_set_current_plus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 14) save_chess_piece_p2_set_color_current_minus();
			
			if (_num == ((CID1._question_gameIds_time_allowed.length) * 2) + 15) save_chess_piece_p2_set_color_current_plus();
			
		}
	}
	
	/******************************
	 * minus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function minusMinutes(_id:Int):Void
	{
		var _id2 = CID1._question_gameIds_time_allowed[_id];
		
		// minus 5 from the total time for the game selected.
		if (RegCustom._time_remaining_for_game[Reg._tn][_id2]
		!=  RegCustom._timer_minimum_permitted_for_game[_id2])
			RegCustom._time_remaining_for_game[Reg._tn][_id2] -= 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * plus 5 from total of the minutes allowed for the game.
	 * @param	_id		Game id
	 */
	private function plusMinutes(_id:Int):Void
	{
		var _id2 = CID1._question_gameIds_time_allowed[_id];
		
		// plus 5 from the total time for the game selected.
		if (RegCustom._time_remaining_for_game[Reg._tn][_id2]
		!=  RegCustom._timer_maximum_permitted_for_game[_id2])
			RegCustom._time_remaining_for_game[Reg._tn][_id2] += 5;	
		
		updateGameMinutes(_id);
	}
	
	/******************************
	 * game minutes text for a game of _id is updated when a plus button or minus button (buttons that changes the minutes for a game) is clicked.
	 */
	private function updateGameMinutes(_id:Int):Void
	{
		var _id2 = CID1._question_gameIds_time_allowed[_id];
		
		if (_id2 == 0)
			CID1._checkers_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][0]);
		
		if (_id2 == 1)
			CID1._chess_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][1]);
		
		if (_id2 == 2)
			CID1._reversi_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][2]);
		
		if (_id2 == 3)
			CID1._snakes_ladders_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][3]);
		
		if (_id2 == 4)
			CID1._signature_game_minutes.text = Std.string(RegCustom._time_remaining_for_game[Reg._tn][4]);
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
		if (RegCustom._chess_set_for_player1_color_number[Reg._tn] == 0) RegCustom._chess_set_for_player1_color_number[Reg._tn] = 13;
		
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
		if (RegCustom._chess_set_for_player1_color_number[Reg._tn] >= 14) RegCustom._chess_set_for_player1_color_number[Reg._tn] = 1;
		
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
		CID1._sprite_display_pawn_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_horse_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_rook_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_queen_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_king_from_p1_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player1[Reg._tn] + "/6.png", false, 75, 75);
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
		if (RegCustom._chess_set_for_player2_color_number[Reg._tn] == 0) RegCustom._chess_set_for_player2_color_number[Reg._tn] = 13;
		
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
		if (RegCustom._chess_set_for_player2_color_number[Reg._tn] >= 14) RegCustom._chess_set_for_player2_color_number[Reg._tn] = 1;
		
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
		CID1._sprite_display_pawn_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/1.png", false, 75, 75);
		CID1._sprite_display_bishop_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/2.png", false, 75, 75);
		CID1._sprite_display_horse_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/3.png", false, 75, 75);
		CID1._sprite_display_rook_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/4.png", false, 75, 75);
		CID1._sprite_display_queen_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/5.png", false, 75, 75);
		CID1._sprite_display_king_from_p2_chess_set.loadGraphic("modules/games/chess/assets/images/set" + RegCustom._chess_set_for_player2[Reg._tn] + "/6.png", false, 75, 75);
	}
		
	override public function update(elapsed:Float):Void
	{
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == false && CID1._sprite_chess_future_capturing_units_bg.visible == true)
		{
			CID1._sprite_chess_future_capturing_units_bg.visible = false;
		}
		
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == false && CID1._sprite_chess_future_capturing_units.visible == true)
		{
			CID1._sprite_chess_future_capturing_units.visible = false;
		}
		
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == false
		&&	CID1._sprite_chess_path_to_king.visible == true)
		{
			CID1._sprite_chess_path_to_king.visible = false;
		}
		
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == false
		&&	CID1._sprite_chess_path_to_king_bg.visible == true)
		{
			CID1._sprite_chess_path_to_king_bg.visible = false;
		}
		
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
		
		if (Reg._buttonCodeValues == "")
		{
			for (i in 0... CID1._group_button.length)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= CID1._group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= CID1._group_button[i]._startY + CID1._group_button[i]._button_height 
				&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= CID1._group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= CID1._group_button[i]._startX + CID1._group_button[i]._button_width && FlxG.mouse.justPressed == true )
				{
					if (Reg._tn > 0)
					{
						buttonNumber(i);
					}
				}
				
			}
		}
		
		super.update(elapsed);
	}
}