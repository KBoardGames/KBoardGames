/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * player's move time remaining while playing a game. 
 * @author kboardgames.com
 */
class PlayerTimeRemainingMove extends FlxState
{
 	
	private var __scene_game_room:SceneGameRoom;
	
	/******************************
	 * "p1", "p2", "p3", "p4". text.
	 */
	private var _textPlayer3:FlxText;
	private var _textPlayer4:FlxText;
	
	/******************************
	 * player timer background.
	 */
	private var _background_for_timer:Array<FlxSprite> = [];
	
	/******************************
	 * this is the timer remaining text for each player.
	 */
	private var _text_player_move_timer:Array<FlxText> = [];
	
	/******************************
	 * every once in a while, send move value for this player to the other clients. those other client will then have an updated value.
	 */
	public var _ticks:Float = 0;
		
	/******************************
	 * this stop the entering of the timer function the second time for that player. once that timer is timer.run, everything in that function does not need to be updated again because timer will enter that function once every second.
	 */
	private var _do_once:Array<Bool> = [false, false, false, false];
	
	/******************************
	 * when true a loop will not be entered.
	 */
	private var _doOnce:Bool = false;
	
	/******************************
	 * use this var to change to vertical layout of this class elements.
	 */
	private var _offsetY:Int = 15;
	
	/******************************
	 * this stops a double "player losses game" message when restarting a game when timer reaches zero.
	 */
	public static var _ticksStart:Int = 0;
	
	/******************************
	 * this is the time remaining.
	 */
	private var _t:Int = 0;
	
	public function new(t:Int, scene_game_room:SceneGameRoom) 
	{
		super();
		
		_t = t; // time.
		
		_ticks = 0;
		_ticksStart = 0;
		
		__scene_game_room = scene_game_room;
		
		_do_once = [false, false, false, false];
		_doOnce = false;
		
		Reg._playerWaitingAtGameRoom = false;
		
		// move timer text.
		var _textMoveTimer = new FlxText(FlxG.width - 252, 172 - _offsetY, 0, "", 20);
		_textMoveTimer.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_textMoveTimer.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textMoveTimer.text = "Move Timer";		
		_textMoveTimer.scrollFactor.set(0, 0);
		add(_textMoveTimer);
				
		// table. the rows have players idle time remaining and players game move time remaining. if any of those times reach 0, the player will lose the game.
		if (_background_for_timer[0] != null)
		{
			remove(_background_for_timer[0]);
			_background_for_timer[0].destroy();
		}
		
		_background_for_timer[0] = new FlxSprite(0, 0);
		_background_for_timer[0].makeGraphic(112, 40, 0xFF440044);		
		_background_for_timer[0].setPosition(FlxG.width - 307, 170 + (1 * 45) - _offsetY); 
		_background_for_timer[0].scrollFactor.set(0, 0);
		add(_background_for_timer[0]);	
	
		if (_background_for_timer[1] != null)
		{
			remove(_background_for_timer[1]);
			_background_for_timer[1].destroy();
		}
		
		_background_for_timer[1] = new FlxSprite(0, 0);
		_background_for_timer[1].makeGraphic(112, 40, 0xFF440044);		
		_background_for_timer[1].setPosition(FlxG.width - 133, 170 + (1 * 45) - _offsetY); 
		_background_for_timer[1].scrollFactor.set(0, 0);
		add(_background_for_timer[1]);
	
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			if (_background_for_timer[2] != null)
			{
				remove(_background_for_timer[2]);
				_background_for_timer[2].destroy();
			}
			
			_background_for_timer[2] = new FlxSprite(0, 0);
			_background_for_timer[2].makeGraphic(112, 40, 0xFF440044);
			_background_for_timer[2].setPosition(FlxG.width - 307, 170 + (2 * 45) - _offsetY); 
			_background_for_timer[2].scrollFactor.set(0, 0);
			add(_background_for_timer[2]);
		}
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			if (_background_for_timer[3] != null)
			{
				remove(_background_for_timer[3]);
				_background_for_timer[3].destroy();
			}
			
			_background_for_timer[3] = new FlxSprite(0, 0);
			_background_for_timer[3].makeGraphic(112, 40, 0xFF440044);	
			_background_for_timer[3].setPosition(FlxG.width - 133, 170 + (2 * 45) - _offsetY); 
			_background_for_timer[3].scrollFactor.set(0, 0);
			add(_background_for_timer[3]);
		}
	
		//#############################		
		// p1 text.
		var _textPlayers = new FlxText(FlxG.width - 352, 175+ (1 * 45) - _offsetY, 0, "", 20);
		_textPlayers.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_textPlayers.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textPlayers.text = "P1";		
		_textPlayers.scrollFactor.set(0, 0);
		add(_textPlayers);

		var _textPlayers = new FlxText(FlxG.width - 181, 175 + (1 * 45) - _offsetY, 0, "", 20);
		_textPlayers.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_textPlayers.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textPlayers.text = "P2";		
		_textPlayers.scrollFactor.set(0, 0);
		add(_textPlayers);
			
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			// p3 text.
			_textPlayer3 = new FlxText(FlxG.width - 352, 175 + (2 * 45) - _offsetY, 0, "", 20);
			_textPlayer3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_textPlayer3.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_textPlayer3.text = "P3";		
			_textPlayer3.scrollFactor.set(0, 0);
			add(_textPlayer3);	
		}

		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			// p4 text.
			_textPlayer4 = new FlxText(FlxG.width - 181, 175 + (2 * 45) - _offsetY, 0, "", 20);
			_textPlayer4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_textPlayer4.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			_textPlayer4.text = "P4";		
			_textPlayer4.scrollFactor.set(0, 0);
			add(_textPlayer4);
		}
	
		
		//############################# Move timer text for each player.
		// move timer 1 text.
		_text_player_move_timer[0] = new FlxText(FlxG.width - 296, 176 + (1 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
		_text_player_move_timer[0].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_text_player_move_timer[0].scrollFactor.set(0, 0);
		add(_text_player_move_timer[0]);
		
		Reg._textTimeRemainingToMove1 = formatTime(_t);
		
		// move timer 2 text.		
		_text_player_move_timer[1] = new FlxText(FlxG.width - 125, 176 + (1 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
		_text_player_move_timer[1].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_text_player_move_timer[1].scrollFactor.set(0, 0);
		add(_text_player_move_timer[1]);
		
		Reg._textTimeRemainingToMove2 = formatTime(_t);
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			// move timer 3 text.
			_text_player_move_timer[2] = new FlxText(FlxG.width - 296, 176 + (2 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
			_text_player_move_timer[2].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_text_player_move_timer[2].scrollFactor.set(0, 0);
			add(_text_player_move_timer[2]);
			
			Reg._textTimeRemainingToMove3 = formatTime(_t);
		}

		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			// move timer 4 text.
			_text_player_move_timer[3] = new FlxText(FlxG.width - 125, 176 + (2 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
			_text_player_move_timer[3].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_text_player_move_timer[3].scrollFactor.set(0, 0);
			add(_text_player_move_timer[3]);
			
			Reg._textTimeRemainingToMove4 = formatTime(_t);
		}
		
		// starting a new game. therefore, set each player's move time.
		if (RegTypedef._dataTournaments._move_piece == false)
		{
			RegTypedef._dataPlayers._moveTimeRemaining[0] = _t;
			RegTypedef._dataPlayers._moveTimeRemaining[1] = _t;
			RegTypedef._dataPlayers._moveTimeRemaining[2] = _t;
			RegTypedef._dataPlayers._moveTimeRemaining[3] = _t;
		} 
		
		if (Reg._playerAll == null)
		{
			Reg._playerAll = new PlayersTimer(1000);
		}
		
	}
		
	public static function formatTime(_time:Int):String
	{
		var _minutes:Int = 0;
		var _seconds:Int = 0;
		
		// to get the number of full minutes, divide the number of total seconds by 60 (60 seconds / minute):
		if (_time > 0)
		{
			_minutes = Math.floor(_time / 60);
		
			// And to get the remaining seconds, multiply the full minutes with 60 and subtract from the total seconds:
			_seconds = _time - _minutes * 60;
		}
		
		if (_seconds < 10) return _minutes + ":0" + _seconds;
		else return _minutes + ":" + _seconds;
		
	}
	
	// by taking the Reg_gameOver var check away from this class, it gives a chance for all other players to set the time to zero when a player's time reaches zero.
	private function moveZeroReached():Void
	{
		if (Reg._atTimerZeroFunction == false && _ticksStart == Reg._framerate * 2)
		{
			if (RegTypedef._dataPlayers._moveTimeRemaining[Reg._move_number_next] <= 0 
			&&  Reg._playerWaitingAtGameRoom == false
			&&  RegTypedef._dataPlayers._spectatorPlaying == true) // this line is only read once because Reg._playerWaitingAtGameRoom is set to true below since player is now waiting in game room for another game. 
			{
				if (Reg._gameOverForPlayer == true) return;
				else Reg._atTimerZeroFunction = true;
				
				Reg2._removePlayerFromTypedefPlayers = true;
				
				if (Reg._move_number_next == 0) 
				{
					_text_player_move_timer[0].text = "0";
					Reg._textTimeRemainingToMove1 = "0";
					updateStats(Reg._move_number_next);
				}
				
				if (Reg._move_number_next == 1) 
				{
					_text_player_move_timer[1].text = "0";
					Reg._textTimeRemainingToMove2 = "0";
					updateStats(Reg._move_number_next);
					
				}
				
				if (Reg._move_number_next == 2) 
				{
					_text_player_move_timer[2].text = "0";
					Reg._textTimeRemainingToMove3 = "0";
					updateStats(Reg._move_number_next);
					
				}
				
				if (Reg._move_number_next == 3) 
				{
					_text_player_move_timer[3].text = "0";
					Reg._textTimeRemainingToMove4 = "0";
					updateStats(Reg._move_number_next);
					
				}
				
				var _foundPlayer:Bool = false;
				
				for (i in 0...4)
				{
					// get the username that holds the current move number. the difference between _usernamesDynamic and _usernamesStatic is that a username can get removed from the list of _usernamesDynamic, but the _usernamesStatic will always have the same names through out the actions within the game room.
					if (RegTypedef._dataPlayers._usernamesStatic[i] == RegTypedef._dataPlayers._usernamesDynamic[Reg._move_number_next])
					{
						// currently this player is still at the game room but no longer playing the game.
						RegTypedef._dataPlayers._gamePlayersValues[i] = 0;	
						Reg._playerIDs = i;
						_foundPlayer = true;
					}
				}
				
									
				Reg._playerWaitingAtGameRoom = true; // the player has no more time left and has not left the game room yet so set this var true so that gamePlayer var can be used at "Player Left Game Room" event.
				
			
				var _totalPlayers:Int = 0;
				
				// get total players still playing game.
				for (i in 0...Reg._roomPlayerLimit)
				{
					if (RegTypedef._dataPlayers._usernamesDynamic[i] != "")
					{
						_totalPlayers += 1;
					}
				}	
				
				
				
				if (_totalPlayers <= 2)
				{
					// all players game over for this game.
					for (i in 0...4)
					{
						// currently this player is still at the game room but no longer playing the game.
						RegTypedef._dataPlayers._gamePlayersValues[i] = 0;	
						Reg._playerIDs = i;
					}

					//RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();					
				}
				
				// if true then this is the player who had time expire.
				if (_foundPlayer == true)
				{
					// save _gamePlayersValues values to database because this function sets this var for the player that time expired to 0, so that the player is no longer playing game. near the bottom of this class, a lose to game stats will be given to this player.
					PlayState.send("Game Players Values", RegTypedef._dataPlayers); 
					
					
					if (_totalPlayers >= 2 && Reg._move_number_current == Reg._move_number_next)
					{
						PlayState.send("Player Left Game", RegTypedef._dataPlayers);					
					}
					
				}
				// else, this is now or was a two player game. for each player (time will run out at both clients at the same time), update the gamePlayers var.
				else if (_totalPlayers <= 1) 
				{
					PlayState.send("Game Players Values", RegTypedef._dataPlayers);					
				}					
								
				// note that player has left the game but player might still be at the game room.
				if (Reg._game_offline_vs_cpu == false  && Reg._game_offline_vs_player == false && Reg._gameHost == true)
				{				
					RegTypedef._dataPlayers._moveTimeRemaining[0] = 0;
					RegTypedef._dataPlayers._moveTimeRemaining[1] = 0;
					RegTypedef._dataPlayers._moveTimeRemaining[2] = 0;
					RegTypedef._dataPlayers._moveTimeRemaining[3] = 0;
				}		
				
				
				__scene_game_room.buttonHideAll(); // hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room or time expires.
				
				if (Reg._move_number_current == Reg._move_number_next)
				{
					RegTriggers._messageLoss = "You lose.";
					RegTriggers._loss = true;					
				}
				
				if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
				{
					RegFunctions.playerAllStop();
				}				

			}
			
			else if (Reg._game_offline_vs_cpu == true 
			&& RegTypedef._dataPlayers._moveTimeRemaining[1] <= 0 
			&& Reg._playerWaitingAtGameRoom == false
			|| Reg._game_offline_vs_player == true 
			&& RegTypedef._dataPlayers._moveTimeRemaining[1] <= 0 
			&& Reg._playerWaitingAtGameRoom == false)
			{
				Reg2._removePlayerFromTypedefPlayers = false;
				
				Reg._playerIDs = 0;
				
				RegTriggers._messageLoss = "CPU losses.";
				RegTriggers._loss = true;
				
				Reg._textTimeRemainingToMove2 = "0"; 
				Reg._playerWaitingAtGameRoom = true;
				
				updateStats(Reg._move_number_next);

				RegTypedef._dataPlayers._moveTimeRemaining[0] = 0;
				RegTypedef._dataPlayers._moveTimeRemaining[1] = 0;
				RegTypedef._dataPlayers._moveTimeRemaining[2] = 0;
				RegTypedef._dataPlayers._moveTimeRemaining[3] = 0;

				
				if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
				{
					Reg._gameOverForPlayer = true;					
					RegFunctions.playerAllStop();
				}
				
				Reg._atTimerZeroFunction = true;
			}
			
			else // when there is only two playing remaining and we are at this function then both players enter here at the same time.
			{
				if (Reg._game_offline_vs_cpu == true 
				||  Reg._game_offline_vs_player == true)
				{
					for (i in 0...4)
					{
						// if we are here then only two players were playing the game, so loop through the array to find the other player.
						if (RegTypedef._dataMisc._username != RegTypedef._dataPlayers._usernamesDynamic[i] && RegTypedef._dataPlayers._usernamesDynamic[i] != "")
						{							
							RegTriggers._messageLoss = "You lose.";
							RegTriggers._loss = true;
							
							Reg._gameOverForPlayer = true;
							Reg._gameOverForAllPlayers = true;
							RegFunctions.playerAllStop();
						}
					}
				}
			}
			
			_ticksStart = 0;
		}
		
	}
	
	public function updateStats(_playerNumber:Int):Void
	{
		var _totalPlayers:Int = 0; // get total players still playing game.
		
		// get total players still playing game.
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "" && RegTypedef._dataPlayers._moveTimeRemaining[i] > 0)
			{
				_totalPlayers += 1;
			}
		}		
		
		// the value of _totalPlayers is a bit misleading. the value refers to a two player game. the player that entered this function still should register a lose and is still playing a game but is not added to this vars total because time remaining is zero.
		if (_totalPlayers > 1)
		{
			// not that _playerNumber = Reg._move_number_next.
			if (Reg._move_number_current == _playerNumber)
			{
				Reg._gameOverForPlayer = true;
				
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Save Lose Stats", RegTypedef._dataPlayers);					
				}
			}
		}
			
		else // 2 players.
		{
			Reg._gameOverForPlayer = true;
				
			// the value of _totalPlayers is a bit misleading. the value refers to a two player game. the player that entered this function still should register a lose and is still playing a game but is not added to this vars total because time remaining is zero.
			if (_totalPlayers == 1 && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._move_number_current == _playerNumber) 
			{
				PlayState.send("Save Lose Stats For Both", RegTypedef._dataPlayers);				
			}
		}
		
		switch (Reg._gameId)
		{
			case 0: {};
			case 1: {};
			case 2: {};
			case 3: {};
			case 4: __scene_game_room.__finalize_when_game_over.id4();
		}
	}
	
	override public function destroy()
	{
		// timer background.
		for (i in 0... _background_for_timer.length)
		{
			if (_background_for_timer[i] != null)
			{
				_background_for_timer[i].visible = false;
				_background_for_timer[i].destroy();
				_background_for_timer[i] = null;
			}
		}
		
		// timer text.
		for (i in 0... _text_player_move_timer.length)
		{
			if (_text_player_move_timer[i] != null)
			{
				_text_player_move_timer[i].visible = false;
				_text_player_move_timer[i].destroy();
				_text_player_move_timer[i] = null;
			}
		}
		
		if (Reg._playerAll != null)
		{
			Reg._playerAll.stop();		
			Reg._playerAll = null;
		}
		
		__scene_game_room = null;
	
		if (_textPlayer3 != null)
		{
			remove(_textPlayer3);
			_textPlayer3.destroy();
			_textPlayer3 = null;
		}
		
		if (_textPlayer4 != null)
		{
			remove(_textPlayer4);
			_textPlayer4.destroy();
			_textPlayer4 = null;
		}	
	
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._gameOverForAllPlayers == false)
		{
			var _count:Int = 0;
			
			for (i in 0...4)
			{
				if (RegTypedef._dataPlayers._username
				==  RegTypedef._dataPlayers._usernamesDynamic[i])
				{
					_count = i;
				}
			}
			
			if (Reg._roomPlayerLimit - Reg._playerOffset <= 1
			&&  RegTypedef._dataPlayers._spectatorWatching == false
			&&  RegTypedef._dataPlayers._spectatorPlaying == true
			&&  RegTypedef._dataPlayers._gamePlayersValues[_count] == 1
			&&  Reg._playerLeftGameUsername != RegTypedef._dataPlayers._username)
			{
				RegTriggers._messageWin = "You win";
				RegTriggers._win = true;
				RegTypedef._dataTournaments._game_over = 1;
				RegTypedef._dataTournaments._won_game = 1;
				
				// this is needed here so that a win save can be made.
				RegTypedef._dataPlayers._spectatorPlaying = false;
				
				if (Reg._game_online_vs_cpu == false && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{
					PlayState.send("Save Win Stats", RegTypedef._dataPlayers);					
				}
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
				Reg._playerOffset = 0;
			}
			
			// should player 3 timer be hidden?
			if (_textPlayer3 != null)
			{
				if (Reg._roomPlayerLimit - Reg._playerOffset <= 2)
				{
					_textPlayer3.visible = false;
					_text_player_move_timer[2].visible = false;
				}
				
				else
				{
					_textPlayer3.visible = true;
					_text_player_move_timer[2].visible = true;
				}
			}
			
			// should player 4 timer be hidden?
			if (_textPlayer4 != null)
			{
				if (Reg._roomPlayerLimit - Reg._playerOffset <= 3)
				{
					_textPlayer4.visible = false;
					_text_player_move_timer[3].visible = false;
				}
				
				else
				{
					_textPlayer4.visible = true;
					_text_player_move_timer[3].visible = true;
				}
			}
			
			// when a player quits game or time expires in a three or four player game that player waits for the game to end for the other players. when that happens, this code triggers the end of game for the waiting player so that if that player was host of the room, the restart button can then be shown.
			// when a player quits game or time expires in a three or four if the _gameOverForAllPlayers var was set to true, the game would not continue for the other players.
			if (RegTypedef._dataPlayers._usernamesTotalDynamic == 1
			&&  RegTypedef._dataPlayers._spectatorWatching == false
			&&  RegTypedef._dataPlayers._spectatorPlaying == true
			&&  RegTypedef._dataPlayers._gamePlayersValues[_count] != 1)
			{
				Reg._gameOverForAllPlayers = true;
			}
			
			var _time:String = formatTime(_t);
			
			// game has just started because _text_player_move_timer[0] equals empty. therefore, display the maximum time for each player.
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				if (_text_player_move_timer[0] != null && _text_player_move_timer[0].text == "")
					_text_player_move_timer[0].text = _time;
				if (_text_player_move_timer[1] != null && _text_player_move_timer[1].text == "") 
					_text_player_move_timer[1].text = _time;
			}
			
			else
			{
				// display how much time is remaining for tournament play.
				if (_text_player_move_timer[0] != null && _text_player_move_timer[0].text == "")
					_text_player_move_timer[0].text = Reg._textTimeRemainingToMove1;
				if (_text_player_move_timer[1] != null && _text_player_move_timer[1].text == "") 
					_text_player_move_timer[1].text = Reg._textTimeRemainingToMove2;
			}
			
			if (_text_player_move_timer[2] != null && _text_player_move_timer[2].text == "") 
				_text_player_move_timer[2].text = _time;
			if (_text_player_move_timer[3] != null && _text_player_move_timer[3].text == "") 
				_text_player_move_timer[3].text = _time;
			
			// addresses the double button/key firing bug when timer reaches zero.
			if (_ticksStart < Reg._framerate * 2) _ticksStart += 1;
			
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 0
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 0)
			{
				if (_do_once[0] == false)
				{	
					_do_once[0] = true;
					_ticks = 0;
					
					Reg._playerAll.run = function() 
					{
						// minus 1 from total move var.
						if (RegTypedef._dataPlayers._moveTimeRemaining[0] > 0)
						RegTypedef._dataPlayers._moveTimeRemaining[0] -= 1;

						if (Reg._playerWaitingAtGameRoom == false)
						Reg._textTimeRemainingToMove1 = formatTime(RegTypedef._dataPlayers._moveTimeRemaining[0]);
						
					}
				}
				else 
				{
					// end game and minus 1 from the player whos move var value reaches zero.
					if (RegTypedef._dataPlayers._moveTimeRemaining[0] <= 0)
					moveZeroReached();
					else _text_player_move_timer[0].text = "0";
					
					_do_once = [false, false, false, false];
				}
			}
			
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 1
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 1)
			{
				if (_do_once[1] == false)
				{	
					_do_once[1] = true;
					_ticks = 0;
					
					Reg._playerAll.run = function() 
					{
						// minus 1 from total move var.
						if (RegTypedef._dataPlayers._moveTimeRemaining[1] > 0)
						RegTypedef._dataPlayers._moveTimeRemaining[1] -= 1;

						if (Reg._playerWaitingAtGameRoom == false)
						Reg._textTimeRemainingToMove2 = formatTime(RegTypedef._dataPlayers._moveTimeRemaining[1]);
						
					}
				}
				
				else 
				{				
					// end game and minus 1 from the player whos move var value reaches zero.
					if (RegTypedef._dataPlayers._moveTimeRemaining[1] <= 0)
					moveZeroReached();
					else _text_player_move_timer[1].text = "0";
					
					_do_once = [false, false, false, false];
				}
			}
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 2
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 2)
			{
				if (_do_once[2] == false)
				{
					_do_once[2] = true;
					_ticks = 0;
					
					Reg._playerAll.run = function() 
					{
						// minus 1 from total move var.
						if (RegTypedef._dataPlayers._moveTimeRemaining[2] > 0)
						RegTypedef._dataPlayers._moveTimeRemaining[2] -= 1;

						if (Reg._playerWaitingAtGameRoom == false)
						Reg._textTimeRemainingToMove3 = formatTime(RegTypedef._dataPlayers._moveTimeRemaining[2]);
							
					}
				}
				
				else
				{
					// end game and minus 1 from the player whos move var value reaches zero.
					if (RegTypedef._dataPlayers._moveTimeRemaining[2] <= 0)
					moveZeroReached();
					else _text_player_move_timer[2].text = "0";
					
					_do_once = [false, false, false, false];
				}
			}
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 3
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 3)
			{
				if (_do_once[3] == false)
				{
					_do_once[3] = true;
					_ticks = 0;
					
					Reg._playerAll.run = function() 
					{
						// minus 1 from total move var.
						if (RegTypedef._dataPlayers._moveTimeRemaining[3] > 0)
						RegTypedef._dataPlayers._moveTimeRemaining[3] -= 1;

						if (Reg._playerWaitingAtGameRoom == false)
						Reg._textTimeRemainingToMove4 = formatTime(RegTypedef._dataPlayers._moveTimeRemaining[3]);
						
					}
				}
				
				else
				{
					// end game and minus 1 from the player whos move var value reaches zero.
					if (RegTypedef._dataPlayers._moveTimeRemaining[3] <= 0)
					moveZeroReached();
					else _text_player_move_timer[3].text = "0";
					
					_do_once = [false, false, false, false];
				}
			}
						
			if (Reg._gameOverForPlayer == true && _doOnce == false)
			{
				// set values to false so that the timer does not run again. restarting the game will set this value correctly.
				_do_once = [false, false, false, false];
			
				// clear the timer function so that nothing runs.
				Reg._playerAll.run = function() 
				{
				}
				
				Reg._moveNumberCurrentForHistory = Reg._move_number_next;
				//Reg._move_number_next = -1;
									
				_doOnce = true;
				if (Reg._playerAll != null)
				{
					Reg._playerAll.stop();	
					//Reg._playerAll = null;
				};
			}
			
			
			if (_text_player_move_timer[0] != null && Reg._move_number_next == 0) _text_player_move_timer[0].text = Reg._textTimeRemainingToMove1;
			if (_text_player_move_timer[1] != null && Reg._move_number_next == 1) _text_player_move_timer[1].text = Reg._textTimeRemainingToMove2;
			if (_text_player_move_timer[2] != null && Reg._move_number_next == 2) _text_player_move_timer[2].text = Reg._textTimeRemainingToMove3;
			if (_text_player_move_timer[3] != null && Reg._move_number_next == 3) _text_player_move_timer[3].text = Reg._textTimeRemainingToMove4;
			
			// every once in a while, send move value for this player to the other clients. those other client will then have an updated value.
			if (_ticks == 0 ) 
			{
				if (Reg._playerCanMovePiece == false)
				{
					if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
					{
						PlayState.send("Player Move Time Remaining", RegTypedef._dataPlayers);			
					}
				}
			}
			
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			if (_ticks >= 41) _ticks = 0;
			
			
		}
		
		// putting __scene_game_room._playerWhosTurnToMove.updateMove(); here will stop dialog boxes from closing.
		//else
		
		super.update(elapsed);	
	}
	
}