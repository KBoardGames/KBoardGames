/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...
 * @author kboardgames.com
 */
class SceneCreateRoom extends FlxState
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar; 
	
	private var _t1:FlxText;
	private var _t2:FlxText;
	private var _t3:FlxText;
	private var _t4:FlxText;
	private var _t5:FlxText;
	
	/******************************
	* when creating a game, this will be the default number of total players permitted for the game.
	*/
	public static var _textMaximumPlayersForGame:FlxText;
	
	/******************************
	* minus 1 from the total permitted players that can play the game.
	*/
	public var _minusTotalPlayersForGame:ButtonGeneralNetworkNo;
	
	/******************************
	* plus 1 from the total permitted players that can play the game.
	*/
	public var _plusTotalPlayersForGame:ButtonGeneralNetworkNo;
	
	private var _textGame:FlxText;
	
	/******************************
	 * if the word is "Yes" then this room allows spectators.
	 */
	public static var _buttonAllowSpectatorsGame:ButtonGeneralNetworkNo;
	
	private var _textAllowSpectatorsGame:FlxText;
	private var _text_allow_minutes:FlxText;
		
	// if true then game stats will be updated after game is over for player.		
	public static var _button_game_rated:ButtonGeneralNetworkNo;
		
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offsetX:Int = 50;
	
	/******************************
	 * moves all row data, excluding the button row. to the left side.
	 */
	private var _offsetX2:Int = 13;
	private var _offset_y:Int = 250;
	
	private var _table_row:FlxSprite;
	private var _table_horizontal_cell_padding:FlxSprite;
	private var _table_horizontal_bottom_cell_padding:FlxSprite;
	private var _table_vertical_cell_padding1:FlxSprite;
	private var _table_vertical_cell_padding2:FlxSprite;
	private var _table_vertical_cell_padding3:FlxSprite;
	private var _table_vertical_cell_padding4:FlxSprite;
	
	public function new() 
	{
		super();
		RegFunctions.fontsSharpen();		

		if (Reg._total_games_in_release > 0)
		{
			RegTypedef._dataPlayers._gameName = RegFunctions.gameName(0);
			RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = 0;
			
			RegFunctions.gameIds_create();
			RegFunctions.gameIds_draw_sprite(this);
			
			//--------------------------------- Header columns for the data rows.
			if (_t1 != null)
			{
				remove(_t1);
				_t1.destroy();
			}
			
			_t1 = new FlxText(100 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Game");
			_t1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t1.scrollFactor.set();
			add(_t1);
			
			if (_t2 != null)
			{
				remove(_t2);
				_t2.destroy();
			}
			
			_t2 = new FlxText(420 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Players");
			_t2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t2.scrollFactor.set();
			add(_t2);
			
			if (_t3 != null)
			{
				remove(_t3);
				_t3.destroy();
			}
			
			_t3 = new FlxText(600 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Rated Game");
			_t3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t3.scrollFactor.set();
			add(_t3);
			
			if (_t4 != null)
			{
				remove(_t4);
				_t4.destroy();
			}
			
			_t4 = new FlxText(828 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Spectators");
			_t4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t4.scrollFactor.set();
			add(_t4);
			
			if (_t5 != null)
			{
				remove(_t5);
				_t5.destroy();
			}
			
			_t5 = new FlxText(1040 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Minutes");
			_t5.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t5.scrollFactor.set();
			add(_t5);
			
			// Create the table row.
			if (_table_row != null)
			{
				remove(_table_row);
				_table_row.destroy();
			}
			
			_table_row = new FlxSprite(0, 0);
			_table_row.makeGraphic(FlxG.width, 55, RegCustomColors.color_table_body_background());		
			_table_row.setPosition(20, 120 + 70 + _offset_y); 
			_table_row.scrollFactor.set(0, 0);
			add(_table_row);
			
			if (_table_horizontal_cell_padding != null)
			{
				remove(_table_horizontal_cell_padding);
				_table_horizontal_cell_padding.destroy();
			}
			
			_table_horizontal_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_cell_padding.makeGraphic(FlxG.width, 2, FlxColor.BLACK);		
			_table_horizontal_cell_padding.setPosition(20, 120 + 70 + _offset_y); 
			_table_horizontal_cell_padding.scrollFactor.set(0, 0);
			add(_table_horizontal_cell_padding);
			
			if (_table_horizontal_bottom_cell_padding != null)
			{
				remove(_table_horizontal_bottom_cell_padding);
				_table_horizontal_bottom_cell_padding.destroy();
			}
			
			_table_horizontal_bottom_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_bottom_cell_padding.makeGraphic(FlxG.width, 2, FlxColor.BLACK);		
			_table_horizontal_bottom_cell_padding.setPosition(20, 120 + 55 + 70 + _offset_y - 2); 
			_table_horizontal_bottom_cell_padding.scrollFactor.set(0, 0);
			add(_table_horizontal_bottom_cell_padding);
			
			//-----------------------------
			// a black bar between table rows.
			// first column border. columns are minus 30 from Header column text.
			if (_table_vertical_cell_padding1 != null)
			{
				remove(_table_vertical_cell_padding1);
				_table_vertical_cell_padding1.destroy();
			}
			
			_table_vertical_cell_padding1 = new FlxSprite(0, 0);
			_table_vertical_cell_padding1.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding1.setPosition(404 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding1.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding1);
			
			if (_table_vertical_cell_padding2 != null)
			{
				remove(_table_vertical_cell_padding2);
				_table_vertical_cell_padding2.destroy();
			}
			_table_vertical_cell_padding2 = new FlxSprite(0, 0);
			_table_vertical_cell_padding2.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding2.setPosition(584 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding2.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding2);
			
			if (_table_vertical_cell_padding3 != null)
			{
				remove(_table_vertical_cell_padding3);
				_table_vertical_cell_padding3.destroy();
			}
			
			_table_vertical_cell_padding3 = new FlxSprite(0, 0);
			_table_vertical_cell_padding3.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding3.setPosition(812 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding3.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding3);
			
			if (_table_vertical_cell_padding4 != null)
			{
				remove(_table_vertical_cell_padding4);
				_table_vertical_cell_padding4.destroy();
			}
			
			_table_vertical_cell_padding4 = new FlxSprite(0, 0);
			_table_vertical_cell_padding4.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding4.setPosition(1024 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding4.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding4);
			
			// game rated?
			if (_button_game_rated != null)
			{
				remove(_button_game_rated);
				_button_game_rated.destroy();
			}
			
			_button_game_rated = new ButtonGeneralNetworkNo(603 - _offsetX - _offsetX2, 132 + (1 * 70) + _offset_y, "True", 80, 35, 22, 0xFF000000, 0, toggle_game_rated, RegCustomColors.button_colors());
			_button_game_rated.label.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.button_text_colors());
			add(_button_game_rated);
			
			// the word checkers with empty spaces are needed to address a strange text alignment bug.
			if (_textGame != null)
			{
				remove(_textGame);
				_textGame.destroy();
			}
			
			_textGame = new FlxText(83 - _offsetX, 135 + (1 * 70) + _offset_y, 0, "Checkers", Reg._font_size);
			_textGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_textGame);
			
			if (_textMaximumPlayersForGame != null)
			{
				remove(_textMaximumPlayersForGame);
				_textMaximumPlayersForGame.destroy();
			}
			
			_textMaximumPlayersForGame = new FlxText(420 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
			_textMaximumPlayersForGame.text = "2";
			_textMaximumPlayersForGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_textMaximumPlayersForGame);
			
			if (_buttonAllowSpectatorsGame != null)
			{
				remove(_buttonAllowSpectatorsGame);
				_buttonAllowSpectatorsGame.destroy();
			}
			
			_buttonAllowSpectatorsGame = new ButtonGeneralNetworkNo(818 - _offsetX, 132 + (1 * 70) + _offset_y, "Yes", 65, 35, 22, 0xFF000000, 0, spectatorsGame, RegCustomColors.button_colors());		
			_buttonAllowSpectatorsGame.label.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.button_text_colors());
			_buttonAllowSpectatorsGame.label.bold = true;
			add(_buttonAllowSpectatorsGame);
			
			if (_textAllowSpectatorsGame != null)
			{
				remove(_textAllowSpectatorsGame);
				_textAllowSpectatorsGame.destroy();
			}
			
			_textAllowSpectatorsGame = new FlxText(828 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
			_textAllowSpectatorsGame.text = "No";
			_textAllowSpectatorsGame.fieldWidth = 300;
			_textAllowSpectatorsGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_textAllowSpectatorsGame.visible = false;
			add(_textAllowSpectatorsGame);
			
			if (_text_allow_minutes != null)
			{
				remove(_text_allow_minutes);
				_text_allow_minutes.destroy();
			}
			
			_text_allow_minutes = new FlxText(1040 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
			_text_allow_minutes.fieldWidth = 300;
			_text_allow_minutes.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_text_allow_minutes);
			
			//-----------------------------
					
			// toggle amount of players that can play the selected game.
			amountOfPlayersForGame();		
				
			Reg._keyOrButtonDown = false;
		}
		//#############################
		
		initialize();
		
	}
	
	public function initialize():Void
	{
		if (__title_bar != null)
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Creating Room " + Std.string(RegTypedef._dataMisc._room));
		add(__title_bar);
		
		if (__menu_bar != null) 
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar(false, false, null, null);
		add(__menu_bar);
		
		// might need to recreate the scrollbar to bring it back up.

		Reg._roomPlayerLimit = 0;
		Reg._gameId = 0;

		if (Reg._total_games_in_release > 0)
		{
			_textMaximumPlayersForGame.text = "2";		
				
			game(Reg2._gameIds_that_can_be_selected[0]); 
		}
		
		else RegFunctions.no_game_modules_installed_notice(this);
		
	}
	
	public function amountOfPlayersForGame():Void
	{
		if (_minusTotalPlayersForGame != null)
		{
			remove(_minusTotalPlayersForGame);
			_minusTotalPlayersForGame.destroy();
		}
		
		_minusTotalPlayersForGame = new ButtonGeneralNetworkNo(423 - _offsetX - _offsetX2, 130 + (1 * 70 + 1) + _offset_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, playersTotalToggleMinus);
		_minusTotalPlayersForGame.offset.y = 2;
		_minusTotalPlayersForGame.label.font = Reg._fontDefault;
		_minusTotalPlayersForGame.label.bold = true;
		add(_minusTotalPlayersForGame);
		
		if (_plusTotalPlayersForGame != null)
		{
			remove(_plusTotalPlayersForGame);
			_plusTotalPlayersForGame.destroy();
		}
		
		_plusTotalPlayersForGame = new ButtonGeneralNetworkNo(513 - _offsetX - _offsetX2, 130 + (1 * 70 + 1) + _offset_y, "+", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, playersTotalTogglePlus);		
		_plusTotalPlayersForGame.offset.y = 2;
		_plusTotalPlayersForGame.label.font = Reg._fontDefault;	
		_plusTotalPlayersForGame.label.bold = true;
		add(_plusTotalPlayersForGame);
		
		_textMaximumPlayersForGame.text = "2";

	}
	
	public function playersTotalToggleMinus():Void
	{
		var _temp:Int = 0;
		
		if (Std.parseInt(_textMaximumPlayersForGame.text) > 2) 
		{
			_temp = Std.parseInt(_textMaximumPlayersForGame.text) - 1;
			_textMaximumPlayersForGame.text = Std.string(_temp);
		}
	}
	
	
	private function playersTotalTogglePlus():Void
	{
		var _temp:Int = 0;
		
		if (Std.parseInt(_textMaximumPlayersForGame.text) < 4) 
		{
			_temp = Std.parseInt(_textMaximumPlayersForGame.text) + 1;
			_textMaximumPlayersForGame.text = Std.string(_temp);
		}
	}	
	
	public function game(_num:Int = 0):Void // checkers
	{
		if (Reg._total_games_in_release == 0) return;
		
		Reg._gameId = _num;
		Reg._roomPlayerLimit = 2;		
		
		if ( _num == 0 ) _textGame.text = "Checkers";
		if ( _num == 1 ) _textGame.text = "Chess";
		if ( _num == 2 ) _textGame.text = "Reversi";
		if ( _num == 3 ) _textGame.text = "Snakes and ladders";
		if ( _num == 4 ) _textGame.text = "Signature game";
		
		if ( _num == 0 ) _textMaximumPlayersForGame.x = 420 - _offsetX - _offsetX2; // left side of column
		if ( _num == 1 ) _textMaximumPlayersForGame.x = 420 - _offsetX - _offsetX2;
		if ( _num == 2 ) _textMaximumPlayersForGame.x = 420 - _offsetX - _offsetX2;
		if ( _num == 3 ) _textMaximumPlayersForGame.x = 420 - _offsetX - _offsetX2;
		if ( _num == 4 ) _textMaximumPlayersForGame.x = 477 - _offsetX - _offsetX2; // displayed after the min button.
		
		RegTypedef._dataMisc._allowSpectators[RegTypedef._dataMisc._room] = 1;
		
		if (_num == 0 || _num == 1 || _num == 2 || _num == 3) // remove _num == 1 when doing chess online.
		{
			_textAllowSpectatorsGame.text = "Yes";
		}
		
		_textAllowSpectatorsGame.visible = false;
		
		_buttonAllowSpectatorsGame.label.text = "Yes";
		_buttonAllowSpectatorsGame.active = true;
		_buttonAllowSpectatorsGame.visible = true;
		
		GameCreate.timeGivenForEachGame(_num);
		var _time = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._timeTotal);
		_text_allow_minutes.text = "0:" + _time;
	}
	
	public function spectatorsGame():Void // checkers
	{
		if (_buttonAllowSpectatorsGame.label.text == "Yes")
			_buttonAllowSpectatorsGame.label.text = "No";
		else _buttonAllowSpectatorsGame.label.text = "Yes";
	}
	
	private function toggle_game_rated():Void
	{
		if (_button_game_rated.label.text == "True")
			_button_game_rated.label.text = "False";
			
		else
			_button_game_rated.label.text = "True";
	}
	
	override public function destroy():Void
	{
		if (__title_bar != null)
		{
			__title_bar.visible = false;
			remove(__title_bar);
			__title_bar.destroy();
			__title_bar = null;
		}
		
		if (__menu_bar != null) 
		{
			__menu_bar.visible = false;
			remove(__menu_bar);
			__menu_bar.destroy();
			__menu_bar = null;
		}
		
		if (_t1 != null)
		{
			remove(_t1);
			_t1.destroy();
			_t1 = null;
		}
		
		if (_t2 != null)
		{
			remove(_t2);
			_t2.destroy();
			_t2 = null;		
		}
		
		if (_t3 != null)
		{
			remove(_t3);
			_t3.destroy();
			_t3	= null;
		}
		
		if (_t4 != null)
		{
			remove(_t4);
			_t4.destroy();
			_t4 = null;	
		}
		
		if (_t5 != null)
		{
			remove(_t5);
			_t5.destroy();
			_t5 = null;
		}
		
		if (_textMaximumPlayersForGame != null)
		{
			remove(_textMaximumPlayersForGame);
			_textMaximumPlayersForGame.destroy();
			_textMaximumPlayersForGame = null;		
		}
		
		if (_minusTotalPlayersForGame != null)
		{
			remove(_minusTotalPlayersForGame);
			_minusTotalPlayersForGame.destroy();
			_minusTotalPlayersForGame = null;
		}
		
		if (_plusTotalPlayersForGame != null)
		{
			remove(_plusTotalPlayersForGame);
			_plusTotalPlayersForGame.destroy();
			_plusTotalPlayersForGame = null;
		}
		
		if (_textGame != null)
		{
			remove(_textGame);
			_textGame.destroy();
			_textGame = null;
		}
		
		if (_buttonAllowSpectatorsGame != null)
		{
			remove(_buttonAllowSpectatorsGame);
			_buttonAllowSpectatorsGame.destroy();
			_buttonAllowSpectatorsGame = null;
		}
		
		if (_textAllowSpectatorsGame != null)
		{
			remove(_textAllowSpectatorsGame);
			_textAllowSpectatorsGame.destroy();
			_textAllowSpectatorsGame = null;
		}
		
		if (_text_allow_minutes != null)
		{
			remove(_text_allow_minutes);
			_text_allow_minutes.destroy();
			_text_allow_minutes = null;
		}
		
		if (_button_game_rated != null)
		{
			remove(_button_game_rated);
			_button_game_rated.destroy();
			_button_game_rated = null;
		}
		
		if (_table_row != null)
		{
			remove(_table_row);
			_table_row.destroy();
			_table_row = null;
		}
		
		if (_table_horizontal_cell_padding != null)
		{
			remove(_table_horizontal_cell_padding);
			_table_horizontal_cell_padding.destroy();
			_table_horizontal_cell_padding = null;
		}
		
		if (_table_horizontal_bottom_cell_padding != null)
		{
			remove(_table_horizontal_bottom_cell_padding);
			_table_horizontal_bottom_cell_padding.destroy();
			_table_horizontal_bottom_cell_padding = null;		
		}
		
		if (_table_vertical_cell_padding1 != null)
		{
			remove(_table_vertical_cell_padding1);
			_table_vertical_cell_padding1.destroy();
			_table_vertical_cell_padding1 = null;
		}
		
		if (_table_vertical_cell_padding2 != null)
		{
			remove(_table_vertical_cell_padding2);
			_table_vertical_cell_padding2.destroy();
			_table_vertical_cell_padding2 = null;
		}
		
		if (_table_vertical_cell_padding3 != null)
		{
			remove(_table_vertical_cell_padding3);
			_table_vertical_cell_padding3.destroy();
			_table_vertical_cell_padding3 = null;
		}
		
		if (_table_vertical_cell_padding4 != null)
		{
			remove(_table_vertical_cell_padding4);
			_table_vertical_cell_padding4.destroy();
			_table_vertical_cell_padding4 = null;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		//if (Reg._at_create_room == false) return;
		
		if (Reg._gameId == 4)
		{
			_minusTotalPlayersForGame.active = true;
			_minusTotalPlayersForGame.visible = true;
			_plusTotalPlayersForGame.active = true;
			_plusTotalPlayersForGame.visible = true;
		}
		
		else if (Reg._total_games_in_release > 0)
		{
			_minusTotalPlayersForGame.visible = false;
			_minusTotalPlayersForGame.active = false;
			_plusTotalPlayersForGame.visible = false;
			_plusTotalPlayersForGame.active = false;
		}
		
		for (i in 0... Reg._total_games_in_release)
		{
			if (Reg2._gameId_sprite[i] != null)
			{
				if (ActionInput.overlaps(Reg2._gameId_sprite[i]) == true)
					Reg2._gameId_sprite_highlight.setPosition(75 + ( i * 255), 120);
				
				if (ActionInput.overlaps(Reg2._gameId_sprite[i]) == true
				&&  ActionInput.justPressed() == true)
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._scrollable_area_is_scrolling == false)
						FlxG.sound.play("click", 1, false);			
				}
				
				if (ActionInput.overlaps(Reg2._gameId_sprite[i]) == true
				&&  ActionInput.justReleased() == true)
				{
					_textMaximumPlayersForGame.text = "2";
					game(Reg2._gameIds_that_can_be_selected[i]);		
				}
			}
		}
		
		// do not move this code.
		if (_button_game_rated.label.text == "True")
			RegTypedef._dataMisc._rated_game[RegTypedef._dataMisc._room] = 1;
		else
			RegTypedef._dataMisc._rated_game[RegTypedef._dataMisc._room] = 0;
			
		super.update(elapsed);
	}
	
}