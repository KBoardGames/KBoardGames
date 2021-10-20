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
 * press esc for a message box to return back to title. Also a keyboard T key to output many trace command to find bugs.
 * @author kboardgames.com
 */
class ActionCommands extends FlxGroup
{
	/******************************
	* if the user has not moved or used an action key within a set time then the player will be logged off.
	*/
	private var _logoff_timer:FlxTimer;
	
	/******************************
	* used to start the logoff timer.
	*/
	private var _logoff_timer_start:Bool = true;
	
	public function new() 
	{
		super();
			
		_logoff_timer = new FlxTimer();
	}
	/***************************************************************************
	 * output trace data when a display bug displays. helps find where in code the bugs happens.
	 */
	public static function commandTraceAll():Void
	{
		trace ("1:_dataMisc.id: "+RegTypedef._dataMisc.id);
		trace ("2:_dataMisc._room: "+RegTypedef._dataMisc._room);
		trace ("3:_dataMisc._username: "+RegTypedef._dataMisc._username);
		trace ("4:_dataMisc._spectatorWatching: "+RegTypedef._dataMisc._spectatorWatching); 
		trace ("5:_dataMisc._roomState: "+RegTypedef._dataMisc._roomState);
		trace ("6:_dataMisc._roomPlayerLimit: "+RegTypedef._dataMisc._roomPlayerLimit);
		trace ("7:_dataMisc._roomPlayerCurrentTotal: "+RegTypedef._dataMisc._roomPlayerCurrentTotal);
		trace ("8:_dataMisc._roomGameIds: "+RegTypedef._dataMisc._roomGameIds);
		trace ("9:_dataMisc._roomHostUsername: "+RegTypedef._dataMisc._roomHostUsername);
		trace ("10:_dataMisc._userLocation: "+RegTypedef._dataMisc._userLocation);
		trace ("11:_dataMisc._chat: "+RegTypedef._dataMisc._chat);
		trace ("12:_dataMisc._gameRoom: "+RegTypedef._dataMisc._gameRoom);
		trace ("14:_dataMisc._clientCommandMessage: "+RegTypedef._dataMisc._clientCommandMessage); 
		trace ("15:_dataMisc._clientCommandUsers: "+RegTypedef._dataMisc._clientCommandUsers);
		trace ("16:_dataMisc._clientCommandIPs: "+RegTypedef._dataMisc._clientCommandIPs);
		
		trace ("17:_dataPlayers.id: "+RegTypedef._dataPlayers.id);
		trace ("18:_dataPlayers._username: "+RegTypedef._dataPlayers._username);
		trace ("19:_dataPlayers._usernamesDynamic: "+RegTypedef._dataPlayers._usernamesDynamic);
		trace ("20:_dataPlayers._usernamesStatic: "+RegTypedef._dataPlayers._usernamesStatic);
		trace ("21:_dataPlayers._spectatorPlaying: "+RegTypedef._dataPlayers._spectatorPlaying);
		trace ("22:_dataPlayers._spectatorWatching:"+RegTypedef._dataPlayers._spectatorWatching); 	
		trace ("23:_dataPlayers._spectatorWatchingGetMoveNumber: "+RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber);
		trace ("24:_dataPlayers._gamePlayersValues: "+RegTypedef._dataPlayers._gamePlayersValues);
		trace ("25:_dataPlayers._moveNumberDynamic: "+RegTypedef._dataPlayers._moveNumberDynamic);
		trace ("26:_dataPlayers._room: "+RegTypedef._dataPlayers._room);
		trace ("27:_dataPlayers._gameId: "+RegTypedef._dataPlayers._gameId);
		trace ("28:_dataPlayers._gamesAllTotalWins: "+RegTypedef._dataPlayers._gamesAllTotalWins);
		trace ("29:_dataPlayers._gamesAllTotalLosses: "+RegTypedef._dataPlayers._gamesAllTotalLosses);
		trace ("30:_dataPlayers._gamesAllTotalDraws: "+RegTypedef._dataPlayers._gamesAllTotalDraws);
		trace ("31:_dataPlayers._gameName: "+RegTypedef._dataPlayers._gameName);
		trace ("32:_dataPlayers._usernameInvite: "+RegTypedef._dataPlayers._usernameInvite);
		trace ("33:_dataPlayers._gameMessage: "+RegTypedef._dataPlayers._gameMessage);
		trace ("34:_dataPlayers._actionWho: "+RegTypedef._dataPlayers._actionWho);
		trace ("35:_dataPlayers._actionNumber: "+RegTypedef._dataPlayers._actionNumber);
		trace ("36:_dataPlayers._actionDo: "+RegTypedef._dataPlayers._actionDo);
		trace ("37:_dataPlayers._moveTimeRemaining: "+RegTypedef._dataPlayers._moveTimeRemaining);
		trace ("38:_dataPlayers._score: "+RegTypedef._dataPlayers._score);
		trace ("39:_dataPlayers._cash: "+RegTypedef._dataPlayers._cash);
		trace ("40:_dataPlayers._quitGame: "+RegTypedef._dataPlayers._quitGame);
		trace ("41:_dataPlayers._isGameFinished: "+RegTypedef._dataPlayers._isGameFinished);
		trace ("42:_dataPlayers._gameIsFinished: "+RegTypedef._dataPlayers._gameIsFinished);

		trace ("26:_dataOnlinePlayers._room: " + RegTypedef._dataOnlinePlayers._room);
		
		trace ("43:Reg._roomPlayerLimit: "+Reg._roomPlayerLimit);
		trace ("44:Reg._at_create_room: "+Reg._at_create_room);
		trace ("45:Reg._at_waiting_room: "+Reg._at_waiting_room);
		trace ("46:Reg._currentRoomState: "+Reg._currentRoomState);				
		trace ("47:Reg._gameOverForPlayer: "+Reg._gameOverForPlayer); 
		trace ("48:Reg._gameOverForAllPlayers: "+Reg._gameOverForAllPlayers);
		trace ("49:Reg._gameHost :"+Reg._gameHost);
	}
	
	public function commandESC():Void 
	{
		Reg._messageId = 15000;
		Reg._buttonCodeValues = "s9"; // value 9 = esc charCode. a value other than 0 is needed or else the message will not be displayed.		
		SceneGameRoom.messageBoxMessageOrder();		
	}
	
	/******************************
	* this function handles the logoff count down. when the could down reaches zero, the player will be logged off. this countdown will reset to zero and the countdown will begin again when the player is moved or an action key is pressed.
	*/
	public function logoffCountdown():Void
	{
		// determine if the logoff timer should be started or if it is running then restart it.
		if (_logoff_timer_start == true ) 
		{
			_logoff_timer_start = false; // stop this loop so that the countdown can begin.
			_logoff_timer.start(0.05, null, Reg._logoffTimeCurrent); // start/restart the timer.
		}
			
		// countdown.
		Reg._logoffTime = -_logoff_timer.elapsedLoops + Reg._logoffTimeCurrent;
	
		// logoff player if countdown reaches zero.
		if (Reg._logoffTime == 0)
		{
			Reg._clientDisconnected = true;
			Reg._disconnectNow = true;
		}
	}	
	
	override public function update(elapsed:Float):Void
	{
		// if the OK button was pressed at the MessageBox.hx and the player selected the esc key then disconnect the server.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s9")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			PlayState._clientDisconnect = true;
			PlayState.prepareToDisconnect();
		}
		
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "s9")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		}
	
		// stop the logoff timer if a mouse button/wheel or mobile touch was clicked.
		if (ActionInput.justPressed() == true 
		 || ActionInput.pressed() == true )
		{
			_logoff_timer_start = true; // start or restart the logoff timer. if the player still needs updating then this var will restart the timer again.
		}
		
		logoffCountdown(); // determine if player should be logged off at every game tick.
		
		if (Reg._loggedIn == true)
		{
			#if desktop
				if ( FlxG.keys.anyJustReleased(["ESCAPE"]))
					commandESC();
				
				if ( FlxG.keys.anyJustReleased(["T"]))
					commandTraceAll();
			#end
		}
		
		super.update(elapsed);
	}
	
}//