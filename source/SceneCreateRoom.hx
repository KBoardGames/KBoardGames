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
 * ...
 * @author kboardgames.com
 */
class SceneCreateRoom extends FlxState
{
	public var __menu_bar:MenuBar;
	
	/******************************
	* the _title of this state.
	*/
	private var _title:FlxText;	
	private var _title_background:FlxSprite;
	
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
	
	/******************************
	 * the image of the game that can be selected. once this image is selected the options such as number of players and if player can play against the computer will be displayed for that game.
	 */
	public var _sprite:FlxSprite;
	
	/******************************
	 * when clicking on a game image, this image has a border that highlighted it.
	 */
	public var _game_highlighted:FlxSprite;
	
	/******************************
	 * value starts at 0. access members here.
	 */
	public var _group_sprite:Array<FlxSprite> = [];
	
	public function new() 
	{
		super();
		RegFunctions.fontsSharpen();		
				
		RegTypedef._dataPlayers._gameName = RegFunctions.gameName(0);
		RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = 0;
		
		
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width - 40, 160, 0xFF000000); 
		_title_background.scrollFactor.set(0, 0);
		add(_title_background);
		
		_title = new FlxText(0, 0, 0, "Creating Room " + Std.string(RegTypedef._dataMisc._room));
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_title.scrollFactor.set();
		_title.setPosition(0, 20);
		_title.visible = true;
		_title.screenCenter(X);
		add(_title);	
		
		_group_sprite.splice(0, _group_sprite.length);
		
		for (i in 0...Reg._total_games_in_release)
		{
			// all gameboards images are stored in frames.
			_sprite = new FlxSprite(50, 120);
			_sprite.loadGraphic("assets/images/games.png", true, 240, 240); // height is the same value as width.
			_sprite.scrollFactor.set(0, 0);
			_sprite.visible = false;
			_sprite.updateHitbox();
			add(_sprite);			
			
			// add this member to _group_sprite.			
			_group_sprite.push(_sprite);
							
			// position this image on scene.
			_group_sprite[i].setPosition(100 + (i * 250), 120);
			_group_sprite[i].animation.add(Std.string(i), [i], 30, false);
			_group_sprite[i].animation.play(Std.string(i));
			_group_sprite[i].visible = true;
			
			add(_group_sprite[i]);
		}
		
		// when clicking on a game image, this image has a border that highlighted it.
		// all gameboards images are stored in frames.
		_game_highlighted = new FlxSprite(50, 120);
		_game_highlighted.loadGraphic("assets/images/gamesBorder.png", true, 240, 240); // height is the same value as width.
		_game_highlighted.scrollFactor.set(0, 0);
		_game_highlighted.animation.add("anim", [0, 1], 2);
		_game_highlighted.animation.play("anim");
		_game_highlighted.updateHitbox();
		add(_game_highlighted);
		
		//--------------------------------- Header columns for the data rows.		
		var _t1 = new FlxText(100 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Game");
		_t1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t1.scrollFactor.set();
		add(_t1);
		
		var _t2 = new FlxText(420 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Players");
		_t2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t2.scrollFactor.set();
		add(_t2);
		
		var _t3 = new FlxText(600 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Against");
		_t3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t3.scrollFactor.set();
		add(_t3);
		
		var _t4 = new FlxText(828 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Spectators");
		_t4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t4.scrollFactor.set();
		add(_t4);
		
		var _t5 = new FlxText(1040 - _offsetX - _offsetX2, 130 + _offset_y, 0, "Minutes");
		_t5.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t5.scrollFactor.set();
		add(_t5);
		
		// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 26 loops will be made. 
		for (i in 1...2)
		{
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(FlxG.width - 40, 55, 0xFF001210);		
			slotBox.setPosition(20, 120 + (i * 70) + _offset_y); 
			slotBox.scrollFactor.set(0, 0);
			add(slotBox);
		}		
		
		//.....................................
		// a black bar between table rows.
		// first column border. columns are minus 30 from Header column text.
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (28 * 70), 0xFF000000);		
		slotBox.setPosition(400 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
		slotBox.scrollFactor.set(0, 0);
		add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (28 * 70), 0xFF000000);		
		slotBox.setPosition(580 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
		slotBox.scrollFactor.set(0, 0);
		add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (28 * 70), 0xFF000000);		
		slotBox.setPosition(808 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
		slotBox.scrollFactor.set(0, 0);
		add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (28 * 70), 0xFF000000);		
		slotBox.setPosition(1020 - _offsetX - _offsetX2, 120 + (1 * 70) + _offset_y); 
		slotBox.scrollFactor.set(0, 0);
		add(slotBox);
		
		// buttons for the drop down menu list.
		_buttonHumanOrComputerGame = new ButtonGeneralNetworkNo(600 - _offsetX - _offsetX2, 130 + (1 * 70) + _offset_y, "", 160, 40, 22, 0xFF000000, 0, toggleAgainstHumanOrComputer);
		_buttonHumanOrComputerGame.label.text = "Human";
		_buttonHumanOrComputerGame.label.font = Reg._fontDefault;	
		_buttonHumanOrComputerGame.label.bold = true;
		add(_buttonHumanOrComputerGame);
		
		// the word checkers with empty spaces are needed to address a strange text alignment bug.
		_textGame = new FlxText(83 - _offsetX, 130 + (1 * 70) + _offset_y, 0, "Checkers", Reg._font_size);
		_textGame.font = Reg._fontDefault;
		add(_textGame);
		
		_textMaximumPlayersForGame = new FlxText(420 - _offsetX - _offsetX2, 135 + (1 * 70) - 5 + _offset_y, 35, "", Reg._font_size);
		_textMaximumPlayersForGame.text = "2";
		_textMaximumPlayersForGame.offset.y = -6;
		_textMaximumPlayersForGame.font = Reg._fontDefault;
		_textMaximumPlayersForGame.color = FlxColor.WHITE;
		add(_textMaximumPlayersForGame);
		
		_vsHumanOrComputerGame = new FlxText(600 - _offsetX - _offsetX2, 135 + (1 * 70) + 2 + _offset_y, 0, "", Reg._font_size);
		_vsHumanOrComputerGame.text = "Human";
		_vsHumanOrComputerGame.font = Reg._fontDefault;
		_vsHumanOrComputerGame.color = FlxColor.WHITE;
		add(_vsHumanOrComputerGame);
		
		_buttonAllowSpectatorsGame = new ButtonGeneralNetworkNo(818 - _offsetX, 130 + (1 * 70) + _offset_y, "Yes", 65, 40, 22, 0xFF000000, 0, spectatorsGame);		
		_buttonAllowSpectatorsGame.label.font = Reg._fontDefault;	
		_buttonAllowSpectatorsGame.label.bold = true;
		add(_buttonAllowSpectatorsGame);
		
		_textAllowSpectatorsGame = new FlxText(828 - _offsetX - _offsetX2, 137 + (1 * 70) - 5 + _offset_y, 35, "", Reg._font_size);
		_textAllowSpectatorsGame.text = "No";
		_textAllowSpectatorsGame.fieldWidth = 300;
		_textAllowSpectatorsGame.font = Reg._fontDefault;
		_textAllowSpectatorsGame.color = FlxColor.WHITE;
		_textAllowSpectatorsGame.visible = false;
		add(_textAllowSpectatorsGame);
		
		_text_allow_minutes = new FlxText(1040 - _offsetX - _offsetX2, 137 + (1 * 70) + _offset_y, 35, "", Reg._font_size);
		_text_allow_minutes.fieldWidth = 300;
		_text_allow_minutes.font = Reg._fontDefault;
		_text_allow_minutes.color = FlxColor.WHITE;
		add(_text_allow_minutes);
		
		//-----------------------------
				
		// toggle amount of players that can play the selected game.
		amountOfPlayersForGame();		
			
		Reg._keyOrButtonDown = false;
		
		//#############################
		
		options();
		
		_game_highlighted.setPosition(100, 120);
		
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
	
	
	public function options():Void
	{
		
		//#############################
		// this button is not added to the _group, so it will not scroll with the other buttons.
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
		// might need to recreate the scrollbar to bring it back up.

		Reg._roomPlayerLimit = 0;
		Reg._gameId = 0;
		_game_highlighted.setPosition(100, 120);
		
		_textMaximumPlayersForGame.text = "2";
		
		_buttonHumanOrComputerGame.label.text = "Human";
				
		_title.text = "Creating Room " + Std.string(RegTypedef._dataMisc._room);
		_title.setPosition(0, 20);
		_title.visible = true;
		_title.screenCenter(X);

		game(); 
	}
	
	public function game(_num:Int = 0):Void // checkers
	{
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
		
		IDsCreateAndMain.timeGivenForEachGame(_num);
		var _time = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._timeTotal);
		_text_allow_minutes.text = "0:" + _time;
	}
	
	public function spectatorsGame():Void // checkers
	{
		if (_buttonAllowSpectatorsGame.label.text == "Yes")
			_buttonAllowSpectatorsGame.label.text = "No";
		else _buttonAllowSpectatorsGame.label.text = "Yes";
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
		
		else
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
		
		else*/ _vsHumanOrComputerGame.visible = true;
				
		for (i in 0... Reg._total_games_in_release)
		{
			if (ActionInput.overlaps(_group_sprite[i]) == true
			&&  ActionInput.justPressed() == true)
			{
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&  Reg2._boxScroller_is_scrolling == false)
					FlxG.sound.play("click", 1, false);
			}
			
			if (ActionInput.overlaps(_group_sprite[i]) == true
			&&  ActionInput.justReleased() == true)
			{
				_textMaximumPlayersForGame.text = "2";
				game(i);
			
				// highlight the game image that was selected.
				_game_highlighted.setPosition(100 + (i * 250), 120);
				_game_highlighted.visible = true;
			}
		}
		
		super.update(elapsed);
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
}