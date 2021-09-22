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
 * player's move time remaining while playing a game. 
 * @author kboardgames.com
 */
class PlayerTimeRemainingMove extends FlxState
{	 	
	public var _ticks:Float = 0;
	
	// this is the timer remaining text.
	public var _textMoveTimer1:FlxText;
	public var _textMoveTimer2:FlxText;
	public var _textMoveTimer3:FlxText;
	public var _textMoveTimer4:FlxText;
	
	// this stop the entering of the timer function the second time for that player. once that timer is timer.run, everything in that function does not need to be updated again because timer will enter that function once every second. 
	public var _doOnce1:Bool = false;
	public var _doOnce2:Bool = false;
	public var _doOnce3:Bool = false;
	public var _doOnce4:Bool = false;
	
	private var _doOnce:Bool = false; // when true a loop will not be entered.
	
	private var _offsetY:Int = 15; // use this var to change to vertical layout of this class elements.
	
	public static var _ticksStart:Int = 0; // this stops a double "player losses game" message when restarting a game when timer reaches zero.
	
	private var __scene_game_room:SceneGameRoom;
	
	// p1, p2, p3, p4. text.
	private var _textPlayer3:FlxText;
	private var _textPlayer4:FlxText;
	
	// player 1 timer background.
	private var _BGtimerForP1:FlxSprite;
	private var _BGtimerForP2:FlxSprite;
	private var _BGtimerForP3:FlxSprite;
	private var _BGtimerForP4:FlxSprite;
	
	private var _t:Int = 0;
	
	public function new(t:Int, scene_game_room:SceneGameRoom) 
	{
		super();
		
		_t = t; // time.
		
		_ticks = 0;
		_ticksStart = 0;
		
		__scene_game_room = scene_game_room;
		
		_doOnce = false;
		
		_doOnce1 = false;
		_doOnce2 = false;
		_doOnce3 = false;
		_doOnce4 = false;
	
		Reg._playerWaitingAtGameRoom = false;
		
		// move timer text.
		var _textMoveTimer = new FlxText(FlxG.width - 252, 172 - _offsetY, 0, "", 20);
		_textMoveTimer.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_textMoveTimer.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_textMoveTimer.text = "Move Timer.";		
		_textMoveTimer.scrollFactor.set(0, 0);
		add(_textMoveTimer);
		
		
		// table. the rows have players idle time remaining and players game move time remaining. if any of those times reach 0, the player will lose the game.
		_BGtimerForP1 = new FlxSprite(0, 0);
		_BGtimerForP1.makeGraphic(112, 40, 0xFF440044);		
		_BGtimerForP1.setPosition(FlxG.width - 307, 170 + (1 * 45) - _offsetY); 
		_BGtimerForP1.scrollFactor.set(0, 0);
		add(_BGtimerForP1);	

		// table column divider.
		var _BGtimerForP2 = new FlxSprite(0, 0);
		_BGtimerForP2.makeGraphic(112, 40, 0xFF440044);		
		_BGtimerForP2.setPosition(FlxG.width - 133, 170 + (1 * 45) - _offsetY); 
		_BGtimerForP2.scrollFactor.set(0, 0);
		add(_BGtimerForP2);
	
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			// table column divider.
			var _BGtimerForP3 = new FlxSprite(0, 0);
			_BGtimerForP3.makeGraphic(112, 40, 0xFF440044);		
			_BGtimerForP3.setPosition(FlxG.width - 307, 170 + (2 * 45) - _offsetY); 
			_BGtimerForP3.scrollFactor.set(0, 0);
			add(_BGtimerForP3);
		}
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			// table column divider.
			var _BGtimerForP4 = new FlxSprite(0, 0);
			_BGtimerForP4.makeGraphic(112, 40, 0xFF440044);		
			_BGtimerForP4.setPosition(FlxG.width - 133, 170 + (2 * 45) - _offsetY); 
			_BGtimerForP4.scrollFactor.set(0, 0);
			add(_BGtimerForP4);
		}
	
		//#############################		
		// p1 text.
		var _textPlayers = new FlxText(FlxG.width - 352, 175+ (1 * 45) - _offsetY, 0, "", 20);
		_textPlayers.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_textPlayers.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_textPlayers.text = "P1";		
		_textPlayers.scrollFactor.set(0, 0);
		add(_textPlayers);

		var _textPlayers = new FlxText(FlxG.width - 181, 175 + (1 * 45) - _offsetY, 0, "", 20);
		_textPlayers.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_textPlayers.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_textPlayers.text = "P2";		
		_textPlayers.scrollFactor.set(0, 0);
		add(_textPlayers);
			
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			// p3 text.
			_textPlayer3 = new FlxText(FlxG.width - 352, 175 + (2 * 45) - _offsetY, 0, "", 20);
			_textPlayer3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
			_textPlayer3.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			_textPlayer3.text = "P3";		
			_textPlayer3.scrollFactor.set(0, 0);
			add(_textPlayer3);	
		}

		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			// p4 text.
			_textPlayer4 = new FlxText(FlxG.width - 181, 175 + (2 * 45) - _offsetY, 0, "", 20);
			_textPlayer4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
			_textPlayer4.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
			_textPlayer4.text = "P4";		
			_textPlayer4.scrollFactor.set(0, 0);
			add(_textPlayer4);
		}
	
		
		//############################# Move timer text for each player.
		// move timer 1 text.
		_textMoveTimer1 = new FlxText(FlxG.width - 296, 176 + (1 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
		_textMoveTimer1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_textMoveTimer1.scrollFactor.set(0, 0);
		add(_textMoveTimer1);
		
		Reg._textTimeRemainingToMove1 = formatTime(_t);
		
		// move timer 2 text.		
		_textMoveTimer2 = new FlxText(FlxG.width - 125, 176 + (1 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
		_textMoveTimer2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_textMoveTimer2.scrollFactor.set(0, 0);
		add(_textMoveTimer2);
		
		Reg._textTimeRemainingToMove2 = formatTime(_t);
		
		if (Reg._roomPlayerLimit - Reg._playerOffset > 2)
		{
			// move timer 3 text.
			_textMoveTimer3 = new FlxText(FlxG.width - 296, 176 + (2 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
			_textMoveTimer3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_textMoveTimer3.scrollFactor.set(0, 0);
			add(_textMoveTimer3);
			
			Reg._textTimeRemainingToMove3 = formatTime(_t);
		}

		if (Reg._roomPlayerLimit - Reg._playerOffset > 3)
		{
			// move timer 4 text.
			_textMoveTimer4 = new FlxText(FlxG.width - 125, 176 + (2 * 45) - _offsetY, 0, formatTime(_t), Reg._font_size);
			_textMoveTimer4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_textMoveTimer4.scrollFactor.set(0, 0);
			add(_textMoveTimer4);
			
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
					_textMoveTimer1.text = "0";
					Reg._textTimeRemainingToMove1 = "0";
					updateStats(Reg._move_number_next);
				}
				
				if (Reg._move_number_next == 1) 
				{
					_textMoveTimer2.text = "0";
					Reg._textTimeRemainingToMove2 = "0";
					updateStats(Reg._move_number_next);
					
				}
				
				if (Reg._move_number_next == 2) 
				{
					_textMoveTimer3.text = "0";
					Reg._textTimeRemainingToMove3 = "0";
					updateStats(Reg._move_number_next);
					
				}
				
				if (Reg._move_number_next == 3) 
				{
					_textMoveTimer4.text = "0";
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
					PlayState.clientSocket.send("Game Players Values", RegTypedef._dataPlayers); 
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
					
					if (_totalPlayers >= 2 && Reg._move_number_current == Reg._move_number_next)
					{
						PlayState.clientSocket.send("Player Left Game", RegTypedef._dataPlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
					}
					
				}
				// else, this is now or was a two player game. for each player (time will run out at both clients at the same time), update the gamePlayers var.
				else if (_totalPlayers <= 1) 
				{
					PlayState.clientSocket.send("Game Players Values", RegTypedef._dataPlayers); 
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
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
					PlayState.clientSocket.send("Save Lose Stats", RegTypedef._dataPlayers);	
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
		}
			
		else // 2 players.
		{
			Reg._gameOverForPlayer = true;
				
			// the value of _totalPlayers is a bit misleading. the value refers to a two player game. the player that entered this function still should register a lose and is still playing a game but is not added to this vars total because time remaining is zero.
			if (_totalPlayers == 1 && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._move_number_current == _playerNumber) 
			{
				PlayState.clientSocket.send("Save Lose Stats For Both", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
		}
		
		switch (Reg._gameId)
		{
			case 0: __scene_game_room._finalizeWhenGameOver.id0();
			case 1: __scene_game_room._finalizeWhenGameOver.id1();
			case 2: __scene_game_room._finalizeWhenGameOver.id2();
			case 3: __scene_game_room._finalizeWhenGameOver.id3();
			case 4: __scene_game_room._finalizeWhenGameOver.id4();
		}
	}
	
	override public function destroy()
	{
		// timer background.
		if (_BGtimerForP1 != null)
		{
			_BGtimerForP1.visible = false;
			_BGtimerForP1.destroy();
			_BGtimerForP1 = null;
		}
		
		if (_BGtimerForP2 != null)
		{
			_BGtimerForP2.visible = false;
			_BGtimerForP2.destroy();
			_BGtimerForP2 = null;
		}
		
		if (_BGtimerForP3 != null) 
		{
			_BGtimerForP3.visible = false;
			_BGtimerForP3.destroy();
			_BGtimerForP3 = null;
		}
		
		if (_BGtimerForP4 != null) 
		{
			_BGtimerForP4.visible = false;
			_BGtimerForP4.destroy();
			_BGtimerForP4 = null;
		}
		
		
		// timer text.
		if (_textMoveTimer1 != null)
		{
			_textMoveTimer1.visible = false;
			_textMoveTimer1.destroy();
			_textMoveTimer1 = null;
		}
		
		if (_textMoveTimer2 != null)
		{
			_textMoveTimer2.visible = false;
			_textMoveTimer2.destroy();
			_textMoveTimer2 = null;
		}
		
		if (_textMoveTimer3 != null) 
		{
			_textMoveTimer3.visible = false;
			_textMoveTimer3.destroy();
			_textMoveTimer3 = null;
		}
		
		if (_textMoveTimer4 != null) 
		{
			_textMoveTimer4.visible = false;
			_textMoveTimer4.destroy();
			_textMoveTimer4 = null;
		}
		
		if (Reg._playerAll != null)
		{
			Reg._playerAll.stop();		
			Reg._playerAll = null;
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
					PlayState.clientSocket.send("Save Win Stats", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
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
					_textMoveTimer3.visible = false;
				}
				
				else
				{
					_textPlayer3.visible = true;
					_textMoveTimer3.visible = true;
				}
			}
			
			// should player 4 timer be hidden?
			if (_textPlayer4 != null)
			{
				if (Reg._roomPlayerLimit - Reg._playerOffset <= 3)
				{
					_textPlayer4.visible = false;
					_textMoveTimer4.visible = false;
				}
				
				else
				{
					_textPlayer4.visible = true;
					_textMoveTimer4.visible = true;
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
			
			// game has just started because _textMoveTimer1 equals empty. therefore, display the maximum time for each player.
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				if (_textMoveTimer1 != null && _textMoveTimer1.text == "")
					_textMoveTimer1.text = _time;
				if (_textMoveTimer2 != null && _textMoveTimer2.text == "") 
					_textMoveTimer2.text = _time;
			}
			
			else
			{
				// display how much time is remaining for tournament play.
				if (_textMoveTimer1 != null && _textMoveTimer1.text == "")
					_textMoveTimer1.text = Reg._textTimeRemainingToMove1;
				if (_textMoveTimer2 != null && _textMoveTimer2.text == "") 
					_textMoveTimer2.text = Reg._textTimeRemainingToMove2;
			}
			
			if (_textMoveTimer3 != null && _textMoveTimer3.text == "") 
				_textMoveTimer3.text = _time;
			if (_textMoveTimer4 != null && _textMoveTimer4.text == "") 
				_textMoveTimer4.text = _time;
			
			// addresses the double button/key firing bug when timer reaches zero.
			if (_ticksStart < Reg._framerate * 2) _ticksStart += 1;
			
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 0
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 0)
			{
				if (_doOnce1 == false)
				{	
					_doOnce1 = true;
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
					else _textMoveTimer1.text = "0";
					
					_doOnce2 = false; _doOnce3 = false; _doOnce4 = false;
				}
			}
			
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 1
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 1)
			{
				if (_doOnce2 == false)
				{	
					_doOnce2 = true;
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
					else _textMoveTimer2.text = "0";
					
					_doOnce1 = false; _doOnce3 = false; _doOnce4 = false;
				}
			}
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 2
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 2)
			{
				if (_doOnce3 == false)
				{
					_doOnce3 = true;
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
					else _textMoveTimer3.text = "0";
					
					_doOnce1 = false; _doOnce2 = false; _doOnce4 = false;
				}
			}
			
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&	Reg._move_number_next == 3
			||	RegTypedef._dataPlayers._spectatorWatching == true
			&&	Reg._spectator_start_timer == true
			&&	Reg._move_number_next == 3)
			{
				if (_doOnce4 == false)
				{
					_doOnce4 = true;
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
					else _textMoveTimer4.text = "0";
					
					_doOnce1 = false; _doOnce2 = false; _doOnce3 = false;
				}
			}
						
			if (Reg._gameOverForPlayer == true && _doOnce == false)
			{
				// set values to false so that the timer does not run again. restarting the game will set this value correctly.
				_doOnce1 = false; _doOnce2 = false; _doOnce3 = false; _doOnce4 = false;
			
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
			
			
			if (_textMoveTimer1 != null && Reg._move_number_next == 0) _textMoveTimer1.text = Reg._textTimeRemainingToMove1;
			if (_textMoveTimer2 != null && Reg._move_number_next == 1) _textMoveTimer2.text = Reg._textTimeRemainingToMove2;
			if (_textMoveTimer3 != null && Reg._move_number_next == 2) _textMoveTimer3.text = Reg._textTimeRemainingToMove3;
			if (_textMoveTimer4 != null && Reg._move_number_next == 3) _textMoveTimer4.text = Reg._textTimeRemainingToMove4;
			
			// every once in a while, send move value for this player to the other clients. those other client will then have an updated value.
			if (_ticks == 0 ) 
			{
				if (Reg._playerCanMovePiece == false)
				{
					if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
					{
						// used for bug tracking. see function receive() at TcpClient.
						RegTypedef._dataPlayers._triggerEvent = "foo"; // add this to an event if you do not want to see its output at console.
						PlayState.clientSocket.send("Player Move Time Remaining", RegTypedef._dataPlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
						
						RegTypedef._dataPlayers._triggerEvent = "";
					}
				}
				
				// when it is the other players turn to move, this changes the white box underneath the P1, P2, P3 or P4.
				__scene_game_room._playerWhosTurnToMove.updateMove();
			}
			
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			if (_ticks >= 41) _ticks = 0;
			
			
		}
		
		else
		{
			// when it is the other players turn to move, this changes the white box underneath the P1, P2, P3 or P4.
			__scene_game_room._playerWhosTurnToMove.updateMove();
		}
		
		super.update(elapsed);	
	}
	
}