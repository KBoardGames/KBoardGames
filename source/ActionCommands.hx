/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
	
	/******************************
	* background used when pressing ALT + SPACEBAR to display all hotkeys quick reference text.
	*/
	private var _background:FlxSprite;
	
	/******************************
	* ALT + M: Maximize stage.
	*/
	private var _maximize_stage:FlxText;
	
	/******************************
	* output useful traces to the console for debugging.
	* ALT + T: Output trace.
	*/
	private var _output_trace_data:FlxText;
	
	/******************************
	* Quickly take a screenshot of the screen and not the client window.
	* images are placed in the client's root folder.
	* images are saved in .jpg
	* the name of the image takes this format... scene-name_######.jpg
	* ALT + S: Screenshot.
	*/
	private var _screenshot_scene:FlxText;
	
	/******************************
	* ESC: Exit client
	*/
	private var _exit_client:FlxText;
	
	/******************************
	* toggles the display of hotkeys quick reference text.
	* ALT + SPACEBAR: Toggle this help
	*/
	private var _toggle_help:FlxText;
	
	/******************************
	* text showing a hotkey used to go to the waiting room.
	* ALT + X + GAME ID: waiting room
	*/
	private var _waiting_room:FlxText;
	
	/******************************
	* text showing a hotkey used to go to the game room.
	* ALT + C + GAME ID: Game room.
	*/
	private var _game_room:FlxText;
	
	public function new() 
	{
		super();
		
		_background = new FlxSprite(0, 0);
		_background.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_background.alpha = 0.9;
		_background.scrollFactor.set(0, 0);
		_background.visible = false;
		add(_background);
		
		_maximize_stage = new FlxText(30, 30, 0, "ALT + M: Maximize stage", Reg._font_size);
		_maximize_stage.color = FlxColor.RED;
		_maximize_stage.scrollFactor.set(0, 0);
		_maximize_stage.visible = false;
		add(_maximize_stage);
		
		_output_trace_data = new FlxText(30, 60, 0, "ALT + T: Output trace", Reg._font_size);
		_output_trace_data.color = FlxColor.RED;
		_output_trace_data.scrollFactor.set(0, 0);
		_output_trace_data.visible = false;
		add(_output_trace_data);
		
		_screenshot_scene = new FlxText(30, 90, 0, "ALT + S: Screenshot", Reg._font_size);
		_screenshot_scene.color = FlxColor.RED;
		_screenshot_scene.scrollFactor.set(0, 0);
		_screenshot_scene.visible = false;
		add(_screenshot_scene);
		
		_exit_client = new FlxText(30, 120, 0, "ESC: Exit client", Reg._font_size);
		_exit_client.color = FlxColor.RED;
		_exit_client.scrollFactor.set(0, 0);
		_exit_client.visible = false;
		add(_exit_client);
		
		_toggle_help = new FlxText(30, 150, 0, "ALT + SPACEBAR: Toggle this help", Reg._font_size);
		_toggle_help.color = FlxColor.RED;
		_toggle_help.scrollFactor.set(0, 0);
		_toggle_help.visible = false;
		add(_toggle_help);
		
		_waiting_room = new FlxText(30, 180, 0, "ALT + X + GAME ID: Waiting room", Reg._font_size);
		_waiting_room.color = FlxColor.RED;
		_waiting_room.scrollFactor.set(0, 0);
		_waiting_room.visible = false;
		add(_waiting_room);
		
		_game_room = new FlxText(30, 210, 0, "ALT + C + GAME ID: Game room", Reg._font_size);
		_game_room.color = FlxColor.RED;
		_game_room.scrollFactor.set(0, 0);
		_game_room.visible = false;
		add(_game_room);
		
		_logoff_timer = new FlxTimer();
	}
	/***************************************************************************
	 * output trace data when a display bug displays. helps find where in code when bugs happens.
	 */
	public static function output_trace_data():Void
	{
		trace ("1:_dataMisc.id: " + RegTypedef._dataMisc.id);
		trace ("2:_dataMisc._room: " + RegTypedef._dataMisc._room);
		trace ("3:_dataMisc._username: " + RegTypedef._dataMisc._username);
		trace ("4:_dataMisc._spectatorWatching: " + RegTypedef._dataMisc._spectatorWatching); 
		trace ("5:_dataMisc._roomState: " + RegTypedef._dataMisc._roomState);
		trace ("6:_dataMisc._roomPlayerLimit: " + RegTypedef._dataMisc._roomPlayerLimit);
		trace ("7:_dataMisc._roomPlayerCurrentTotal: " + RegTypedef._dataMisc._roomPlayerCurrentTotal);
		trace ("8:_dataMisc._roomGameIds: " + RegTypedef._dataMisc._roomGameIds);
		trace ("9:_dataMisc._roomHostUsername: " + RegTypedef._dataMisc._roomHostUsername);
		trace ("10:_dataMisc._userLocation: " + RegTypedef._dataMisc._userLocation);
		trace ("11:_dataMisc._chat: " + RegTypedef._dataMisc._chat);
		trace ("12:_dataMisc._gameRoom: " + RegTypedef._dataMisc._gameRoom);
		trace ("14:_dataMisc._clientCommandMessage: " + RegTypedef._dataMisc._clientCommandMessage); 
		trace ("15:_dataMisc._clientCommandUsers: " + RegTypedef._dataMisc._clientCommandUsers);
		trace ("16:_dataMisc._clientCommandIPs: " + RegTypedef._dataMisc._clientCommandIPs);
		
		trace ("17:_dataPlayers.id: " + RegTypedef._dataPlayers.id);
		trace ("18:_dataPlayers._username: " + RegTypedef._dataPlayers._username);
		trace ("19:_dataPlayers._usernamesDynamic: " + RegTypedef._dataPlayers._usernamesDynamic);
		trace ("20:_dataPlayers._usernamesStatic: " + RegTypedef._dataPlayers._usernamesStatic);
		trace ("21:_dataPlayers._spectatorPlaying: " + RegTypedef._dataPlayers._spectatorPlaying);
		trace ("22:_dataPlayers._spectatorWatching:" + RegTypedef._dataPlayers._spectatorWatching); 	
		trace ("23:_dataPlayers._spectatorWatchingGetMoveNumber: " + RegTypedef._dataPlayers._spectatorWatchingGetMoveNumber);
		trace ("24:_dataPlayers._gamePlayersValues: " + RegTypedef._dataPlayers._gamePlayersValues);
		trace ("25:_dataPlayers._moveNumberDynamic: " + RegTypedef._dataPlayers._moveNumberDynamic);
		trace ("26:_dataPlayers._room: " + RegTypedef._dataPlayers._room);
		trace ("27:_dataPlayers._gameId: " + RegTypedef._dataPlayers._gameId);
		trace ("28:_dataPlayers._gamesAllTotalWins: " + RegTypedef._dataPlayers._gamesAllTotalWins);
		trace ("29:_dataPlayers._gamesAllTotalLosses: " + RegTypedef._dataPlayers._gamesAllTotalLosses);
		trace ("30:_dataPlayers._gamesAllTotalDraws: " + RegTypedef._dataPlayers._gamesAllTotalDraws);
		trace ("31:_dataPlayers._gameName: " + RegTypedef._dataPlayers._gameName);
		trace ("32:_dataPlayers._usernameInvite: " + RegTypedef._dataPlayers._usernameInvite);
		trace ("33:_dataPlayers._gameMessage: " + RegTypedef._dataPlayers._gameMessage);
		trace ("34:_dataPlayers._actionWho: " + RegTypedef._dataPlayers._actionWho);
		trace ("35:_dataPlayers._actionNumber: " + RegTypedef._dataPlayers._actionNumber);
		trace ("36:_dataPlayers._actionDo: " + RegTypedef._dataPlayers._actionDo);
		trace ("37:_dataPlayers._moveTimeRemaining: " + RegTypedef._dataPlayers._moveTimeRemaining);
		trace ("38:_dataPlayers._score: " + RegTypedef._dataPlayers._score);
		trace ("39:_dataPlayers._cash: " + RegTypedef._dataPlayers._cash);
		trace ("40:_dataPlayers._quitGame: " + RegTypedef._dataPlayers._quitGame);
		trace ("41:_dataPlayers._isGameFinished: " + RegTypedef._dataPlayers._isGameFinished);
		trace ("42:_dataPlayers._gameIsFinished: " + RegTypedef._dataPlayers._gameIsFinished);
		trace ("26:_dataOnlinePlayers._room: " + RegTypedef._dataOnlinePlayers._room);		
		trace ("43:Reg._roomPlayerLimit: " + Reg._roomPlayerLimit);
		trace ("44:Reg._at_create_room: " + Reg._at_create_room);
		trace ("45:Reg._at_waiting_room: " + Reg._at_waiting_room);
		trace ("46:Reg._currentRoomState: " + Reg._currentRoomState);
		trace ("47:Reg._gameOverForPlayer: " + Reg._gameOverForPlayer);
		trace ("48:Reg._gameOverForAllPlayers: " + Reg._gameOverForAllPlayers);
		trace ("49:Reg._gameHost :" + Reg._gameHost);
		trace ("50:Reg._buttonCodeValues: " + Reg._buttonCodeValues);
		trace ("51:Reg._messageId: " + Reg._messageId);
		trace ("52:Reg._at_lobby: " + Reg._at_lobby);
	}
	
	public function exit_client():Void 
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
		if (FlxG.keys.pressed.ANY)
		{
			hotkeys();
			super.update(elapsed);
		}
	}
	
	private function hotkeys():Void
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
		
		#if desktop
			if ( FlxG.keys.justReleased.ESCAPE )
				exit_client();
			
			// jump to game room.
			if (FlxG.keys.pressed.ALT
			&&	FlxG.keys.pressed.C
			&&	Reg._at_menu_state == true)
			{
				#if checkers
					if (FlxG.keys.justPressed.ZERO)
					{
						Reg._jump_game_id = 0;
						jump_to_game_room();					
					}			
				#end
				
				#if chess
					if (FlxG.keys.justPressed.ONE)
					{
						Reg._jump_game_id = 1;
						jump_to_game_room();					
					}
				#end

				#if reversi
					if (FlxG.keys.justPressed.TWO)
					{
						Reg._jump_game_id = 2;
						jump_to_game_room();					
					}
				#end

				#if snakesAndLadders
					if (FlxG.keys.justPressed.THREE)
					{
						Reg._jump_game_id = 3;
						jump_to_game_room();					
					}
				#end

				#if wheelEstate
					if (FlxG.keys.justPressed.FOUR)
					{
						Reg._jump_game_id = 4;
						jump_to_game_room();					
					}
				#end
			}
			
			if (FlxG.keys.pressed.ALT
			&&	FlxG.keys.justPressed.S)
			{
				var _title = TitleBar._title_for_screenshot;
				_title = StringTools.replace(_title, " ", "");
				
				var _ra = FlxG.random.int(100000, 999999);
				
				Sys.command(sys.FileSystem.absolutePath("scripts/screenCapture " + _title + "_" + _ra + ".jpg"));
			}			
			
			if (FlxG.keys.pressed.ALT
			&&	FlxG.keys.justPressed.T)
				output_trace_data();
			
			// jump to waiting room.
			if (FlxG.keys.pressed.ALT
			&&	FlxG.keys.pressed.X
			&&	Reg._at_menu_state == true)
			{
				#if checkers
					if (FlxG.keys.justPressed.ZERO)
					{
						Reg._jump_game_id = 0;
						jump_to_waiting_room();					
					}			
				#end
				
				#if chess
					if (FlxG.keys.justPressed.ONE)
					{
						Reg._jump_game_id = 1;
						jump_to_waiting_room();					
					}
				#end

				#if reversi
					if (FlxG.keys.justPressed.TWO)
					{
						Reg._jump_game_id = 2;
						jump_to_waiting_room();					
					}
				#end

				#if snakesAndLadders
					if (FlxG.keys.justPressed.THREE)
					{
						Reg._jump_game_id = 3;
						jump_to_waiting_room();					
					}
				#end

				#if wheelEstate
					if (FlxG.keys.justPressed.FOUR)
					{
						Reg._jump_game_id = 4;
						jump_to_waiting_room();					
					}
				#end
			}
		#end
	
		#if !html5
			if (FlxG.keys.pressed.ALT
			&&	FlxG.keys.justPressed.M 
			&&	TitleBar._title_for_screenshot != "Configurations: Profile"
			)
			{
				#if !html5
					Lib.application.window.maximized = !Lib.application.window.maximized;
				#end
			}
		#end
		
		if (FlxG.keys.pressed.ALT
		&&	FlxG.keys.justPressed.SPACE)
		{
			_background.visible = !_background.visible;
			_maximize_stage.visible = !_maximize_stage.visible;
			_output_trace_data.visible = !_output_trace_data.visible;
			_screenshot_scene.visible = !_screenshot_scene.visible;
			_exit_client.visible = !_exit_client.visible;
			_toggle_help.visible = !_toggle_help.visible;
			_waiting_room.visible = !_waiting_room.visible;
			_game_room.visible = !_game_room.visible;
		}
		
	}
	
	private function jump_to_waiting_room():Void
	{
		RegTriggers._jump_creating_room = true;
		RegTriggers._jump_waiting_room = true;
		MenuState.PlayStateEnter();
	}
	
	private function jump_to_game_room():Void
	{
		RegTriggers._jump_creating_room = true;
		RegTriggers._jump_waiting_room = true;
		RegTriggers._jump_game_room = true;
		MenuState.PlayStateEnter();
	}
	
	override public function destroy():Void
	{
		// _logoff_timer cannot be removed.
		if (_logoff_timer != null)
		{
			_logoff_timer.destroy();
			_logoff_timer = null;
		}
		
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
		
		if (_maximize_stage != null)
		{	
			remove(_maximize_stage);
			_maximize_stage.destroy();
			_maximize_stage = null;
		}
		
		if (_output_trace_data != null)
		{	
			remove(_output_trace_data);
			_output_trace_data.destroy();
			_output_trace_data = null;
		}
		
		if (_screenshot_scene != null)
		{	
			remove(_screenshot_scene);
			_screenshot_scene.destroy();
			_screenshot_scene = null;
		}
		
		if (_exit_client != null)
		{	
			remove(_exit_client);
			_exit_client.destroy();
			_exit_client = null;
		}
		
		if (_toggle_help != null)
		{	
			remove(_toggle_help);
			_toggle_help.destroy();
			_toggle_help = null;
		}
		
		if (_waiting_room != null)
		{	
			remove(_waiting_room);
			_waiting_room.destroy();
			_waiting_room = null;
		}
		
		if (_game_room != null)
		{	
			remove(_game_room);
			_game_room.destroy();
			_game_room = null;
		}
		
		super.destroy();
	}
	
}//