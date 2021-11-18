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
 * ...
 * @author kboardgames.com
 */
class SceneCreateRoom extends FlxState
{
	/******************************
	* when creating a game, this will be the default number of total players permitted for the game.
	*/
	public static var _textMaximumPlayersForGame:FlxText;
	
	public var _vsHumanOrComputerGame:FlxText;

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
		
	// used to select either human to computer to play a game against.		
	public static var	_buttonHumanOrComputerGame:ButtonGeneralNetworkNo;
		
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offsetX:Int = 50;
	
	/******************************
	 * moves all row data, excluding the button row. to the left side.
	 */
	private var _offsetX2:Int = 13;
	private var _offset_y:Int = 250;
		
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
			var _t1 = new FlxText(100 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Game");
			_t1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t1.scrollFactor.set();
			add(_t1);
			
			var _t2 = new FlxText(420 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Players");
			_t2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t2.scrollFactor.set();
			add(_t2);
			
			var _t3 = new FlxText(600 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Against");
			_t3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t3.scrollFactor.set();
			add(_t3);
			
			var _t4 = new FlxText(828 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Spectators");
			_t4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t4.scrollFactor.set();
			add(_t4);
			
			var _t5 = new FlxText(1040 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Minutes");
			_t5.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
			_t5.scrollFactor.set();
			add(_t5);
			
			// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 26 loops will be made. 
			var _table_row = new FlxSprite(0, 0);
			_table_row.makeGraphic(FlxG.width, 55, RegCustomColors.color_table_body_background());		
			_table_row.setPosition(20, 120 + 70 + _offset_y); 
			_table_row.scrollFactor.set(0, 0);
			add(_table_row);
			
			var _table_horizontal_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_cell_padding.makeGraphic(FlxG.width, 2, FlxColor.BLACK);		
			_table_horizontal_cell_padding.setPosition(20, 120 + 70 + _offset_y); 
			_table_horizontal_cell_padding.scrollFactor.set(0, 0);
			add(_table_horizontal_cell_padding);
			
			var _table_horizontal_bottom_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_bottom_cell_padding.makeGraphic(FlxG.width, 2, FlxColor.BLACK);		
			_table_horizontal_bottom_cell_padding.setPosition(20, 120 + 55 + 70 + _offset_y - 2); 
			_table_horizontal_bottom_cell_padding.scrollFactor.set(0, 0);
			add(_table_horizontal_bottom_cell_padding);
			
			//-----------------------------
			// a black bar between table rows.
			// first column border. columns are minus 30 from Header column text.
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(404 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding);
			
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(584 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding);
			
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(812 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding);
			
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(1024 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			add(_table_vertical_cell_padding);
			
			// computer or human toggle button.
			_buttonHumanOrComputerGame = new ButtonGeneralNetworkNo(600 - _offsetX - _offsetX2, 130 + (1 * 70) + _offset_y, "", 160, 40, 22, 0xFF000000, 0, toggleAgainstHumanOrComputer);
			_buttonHumanOrComputerGame.label.text = "Human";
			_buttonHumanOrComputerGame.label.font = Reg._fontDefault;	
			_buttonHumanOrComputerGame.label.bold = true;
			add(_buttonHumanOrComputerGame);
			
			// the word checkers with empty spaces are needed to address a strange text alignment bug.
			_textGame = new FlxText(83 - _offsetX, 135 + (1 * 70) + _offset_y, 0, "Checkers", Reg._font_size);
			_textGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_textGame);
			
			_textMaximumPlayersForGame = new FlxText(420 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
			_textMaximumPlayersForGame.text = "2";
			_textMaximumPlayersForGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_textMaximumPlayersForGame);
			
			_vsHumanOrComputerGame = new FlxText(600 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 0, "", Reg._font_size);
			_vsHumanOrComputerGame.text = "Human";
			_vsHumanOrComputerGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			add(_vsHumanOrComputerGame);
			
			_buttonAllowSpectatorsGame = new ButtonGeneralNetworkNo(818 - _offsetX, 132 + (1 * 70) + _offset_y, "Yes", 65, 35, 22, 0xFF000000, 0, spectatorsGame, RegCustomColors.button_colors());		
			_buttonAllowSpectatorsGame.label.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.button_text_colors());
			_buttonAllowSpectatorsGame.label.bold = true;
			add(_buttonAllowSpectatorsGame);
			
			_textAllowSpectatorsGame = new FlxText(828 - _offsetX - _offsetX2, 135 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
			_textAllowSpectatorsGame.text = "No";
			_textAllowSpectatorsGame.fieldWidth = 300;
			_textAllowSpectatorsGame.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_textAllowSpectatorsGame.visible = false;
			add(_textAllowSpectatorsGame);
			
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
		
		//#############################
		// this button is not added to the _group, so it will not scroll with the other buttons.
		if (Reg.__title_bar3 != null) remove(Reg.__title_bar3);
		Reg.__title_bar3 = new TitleBar("Creating Room " + Std.string(RegTypedef._dataMisc._room));
		add(Reg.__title_bar3);
		
		if (Reg.__menu_bar3 != null) remove(Reg.__menu_bar3);
		Reg.__menu_bar3 = new MenuBar(false, false, null, null, this);
		add(Reg.__menu_bar3);
		
		// might need to recreate the scrollbar to bring it back up.

		Reg._roomPlayerLimit = 0;
		Reg._gameId = 0;

		if (Reg._total_games_in_release > 0)
		{
			_textMaximumPlayersForGame.text = "2";		
			_buttonHumanOrComputerGame.label.text = "Human";
			
			game(Reg2._gameIds_that_can_be_selected[0]); 
		}
		
		else RegFunctions.no_game_modules_installed_notice(this);
		
	}
	
	public function amountOfPlayersForGame():Void
	{
		_minusTotalPlayersForGame = new ButtonGeneralNetworkNo(423 - _offsetX - _offsetX2, 130 + (1 * 70 + 1) + _offset_y, "-", 40, 40, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, playersTotalToggleMinus);
		_minusTotalPlayersForGame.offset.y = 2;
		_minusTotalPlayersForGame.label.font = Reg._fontDefault;
		_minusTotalPlayersForGame.label.bold = true;
		add(_minusTotalPlayersForGame);
		
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
		
		RegTypedef._dataMisc._vsComputer[RegTypedef._dataMisc._room] = 0;
		RegTypedef._dataMisc._allowSpectators[RegTypedef._dataMisc._room] = 1;
		/*
		if (_num == 1) // against button when doing chess online. // uncomment when doing chess online.
		{
			_buttonHumanOrComputerGame.active = true;
			_buttonHumanOrComputerGame.visible = true;
						
			_textAllowSpectatorsGame.text = "No";
		}*/

		if (_num == 0 || _num == 1 || _num == 2 || _num == 3) // remove _num == 1 when doing chess online.
		{
			_buttonHumanOrComputerGame.active = false;
			_buttonHumanOrComputerGame.visible = false;
			
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
	
	private function buttonAgainstGame():Void
	{
		_buttonHumanOrComputerGame.visible = false;
	}
			
	public static function createRoomOnlineAgainstCPU():Void
	{
		RegTypedef._dataPlayers._room = RegTypedef._dataMisc._room;
		
		if (Reg._game_online_vs_cpu == true
		&&  Reg._gameId == 1) 
		{			
			RegTypedef._dataPlayers._gameName = "Chess";
			RegTypedef._dataPlayers._gameId = 1;
			
			RegTypedef._dataPlayers._usernamesDynamic[0] = "";
			RegTypedef._dataPlayers._usernamesDynamic[1] = "";
			RegTypedef._dataPlayers._usernamesDynamic[2] = "";
			RegTypedef._dataPlayers._usernamesDynamic[3] = "";
			
			RegTypedef._dataPlayers._username = RegTypedef._dataPlayers._usernamesDynamic[0] = RegTypedef._dataPlayers._usernamesStatic[0] = RegTypedef._dataAccount._username;
			
			RegTypedef._dataMisc._roomLockMessage = "";
			RegTypedef._dataMisc._roomIsLocked[RegTypedef._dataMisc._room] = 0;
			RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 0;
			
			RegTypedef._dataMisc._userLocation = 2;
			RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 7;
			RegTypedef._dataMisc._gameRoom = true;
			//RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room] = RegTypedef._dataMisc._username;
			RegTypedef._dataMisc._roomPlayerCurrentTotal[RegTypedef._dataMisc._room] = 2;
			RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = 2;			
			RegTypedef._dataMisc._vsComputer[RegTypedef._dataMisc._room] = 1;
			RegTypedef._dataMisc._allowSpectators[RegTypedef._dataMisc._room] = 0;
			RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = 1;
			
			Reg._gameOverForPlayer = false;
			Reg._gameOverForAllPlayers = false;
			Reg._gameHost = true;
			
			RegTypedef._dataMisc._gameRoom = true;
			
			PlayState.clientSocket.send("Greater RoomState Value", RegTypedef._dataMisc); 
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			Reg._alreadyOnlineHost = false;
			Reg._alreadyOnlineUser = false;
						
			Reg.playChessVsCPU();
			Reg._game_offline_vs_player = false;
			//ActionInput.enable();			
			
		}
		
			
		RegTypedef._dataPlayers._usernamesDynamic[1] = Reg2._offline_cpu_host_name2;
		RegTypedef._dataPlayers._avatarNumber[1] = RegCustom._profile_avatar_number2[Reg._tn];
		
	}
	
	private function toggleAgainstHumanOrComputer():Void
	{
		if (_buttonHumanOrComputerGame.label.text == "Computer")
			_buttonHumanOrComputerGame.label.text = "Human";
		else
			_buttonHumanOrComputerGame.label.text = "Computer";
	}
	
	override public function update(elapsed:Float):Void 
	{		
		// if player selected "computer" at game 4 of the drop down menu, then hide the buttons that increases the amount of players for the signature game since currently only 1 computer player can play in that game. 
		if (Reg._gameId == 4)
		{
			if (_buttonHumanOrComputerGame.label.text == "Computer")
			{
				_textMaximumPlayersForGame.text = "2";
				_minusTotalPlayersForGame.visible = false;
				_minusTotalPlayersForGame.active = false;
				_plusTotalPlayersForGame.visible = false;
				_plusTotalPlayersForGame.active = false;
			}
			
			else
			{
				_minusTotalPlayersForGame.active = true;
				_minusTotalPlayersForGame.visible = true;
				_plusTotalPlayersForGame.active = true;
				_plusTotalPlayersForGame.visible = true;
			}
		}
		
		else if (Reg._total_games_in_release > 0)
		{
			_minusTotalPlayersForGame.visible = false;
			_minusTotalPlayersForGame.active = false;
			_plusTotalPlayersForGame.visible = false;
			_plusTotalPlayersForGame.active = false;
		}
		
		// TODO uncomment when doing a chess game against the computer online.
		// for a game, if "Computer" was selected at the drop down menu then at the spectators row set the text to "No" because spectators cannot be an option since most network events will not work.
		/*if (Reg._gameId == 1)
		{
			_vsHumanOrComputerGame.visible = false;
			
			if (_buttonHumanOrComputerGame.label.text == "Computer")
			{
				_buttonAllowSpectatorsGame.visible = false;
				_buttonAllowSpectatorsGame.active = false;
				_textAllowSpectatorsGame.visible = true;
			}
			
			else
			{
				_buttonAllowSpectatorsGame.active = true;
				_buttonAllowSpectatorsGame.visible = true;
				_textAllowSpectatorsGame.visible = false;
			}
		}
		
		else*/ 
		if (Reg._total_games_in_release > 0)
			_vsHumanOrComputerGame.visible = true;
				
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
		
		super.update(elapsed);
	}
	
}