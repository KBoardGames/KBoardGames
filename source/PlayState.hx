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

#if !html5
	import sys.net.Address;
	import sys.net.Host;
#end

#if chess
	import modules.games.chess.*;
#end

/**
 * ...
 * @author kboardgames.com
 */
class PlayState extends FlxState
{
	/******************************
	 * keyboard for mobile.
	 */
	private var __action_keyboard:ActionKeyboard;
		
	/******************************
	* this is part of the client software. it is used mainly to connect, disconnect or access event.
	*/
	public static var clientSocket:vendor.mphx.client.Client;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	/******************************
	 * this is used to save/load the client data such as username to place into the login username field box. Players data is not saved here. this var should only be used before the user logs in. after the user logs in, config data should be pulled from the server.
	 */
	public static var _gameMenu:FlxSave;
	
	public var messageBox:MessageBox;
	
	/******************************
	 * system operator class. handles key presses. can disconnect the server by pressing the ESC key, etc.
	 */
	public var __action_commands:ActionCommands;
	public static var __scene_lobby:SceneLobby;
	public var __scene_create_room:SceneCreateRoom;
	public var __scene_waiting_room:SceneWaitingRoom;
	public var __scene_game_room:SceneGameRoom;	
	public var __network_events_main:NetworkEventsMain;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/******************************
    * closes the socket if true. there will be an error if closing within an event because the event code cannot continue if not connected so this var is called in the event and this var "if true" is needed outside the event to close it.
    */
    private var _closeSocket:Bool = false;
   
	/******************************
	 * delays going to the lobby when first logging in. this is needed to draw the front door data to scene. without this var, sometimes that data is not seen.
	 */	
	private var _ticks_logging_in_delay:Int = 0;
			
	/******************************
	 * server data displayed at front door.
	 */
	public static var _text_server_login_data:FlxText;
    public static var _text_server_login_data2:TextGeneral;
	public static var _text_server_login_data3:TextGeneral;
	public static var _text_server_login_data4:TextGeneral;
	
	/******************************
	 * this gives the user a list of events displayed at front door as they are completed because logging in to the lobby takes a few seconds. 
	 */
	public static var _text_client_login_data:FlxText;
	public static var _text_client_login_data2:FlxText;
	public static var _text_client_login_data3:FlxText;	
	public static var _text_client_login_data4:FlxText;
	
	/******************************
	 * text the client is trying to login to server.
	 */
	public static var _text_logging_in:FlxText;

	/******************************
	* if true then a block of code that has something to do with one or more of these classes will be executed.
	*/
	private var _lobbyRoomChat:Bool = true;  
      	
	private var _data:Dynamic;
	
	/******************************
	 * is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
	 */
	#if chess
		private var __chess_check_or_checkmate:ChessCheckOrCheckmate;
   #end
   
	/******************************
	 * disconnect if true.
	 */
	public static var _clientDisconnect:Bool = false;
	public static var _clientDisconnectDo:Bool = true;
	
	override public function create():Void
	{
		super.create();
		
		RegFunctions.fontsSharpen();
		
		persistentDraw = true;
		persistentUpdate = true;
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		__scene_background = new SceneBackground();
		add(__scene_background);
		
		FlxG.mouse.enabled = false;
		
		_ticks_logging_in_delay = 0;
		_clientDisconnect = false;
		_clientDisconnectDo = true;
		
		setExitHandler(function() 
		{
			prepareToDisconnect();
		});
	
		
		//------------------------------
		#if !html5
			_gameMenu = new FlxSave(); // initialize		
			_gameMenu.bind("LoginData"); // bind to the named save slot.	
			loadClientConfig();
		
			//------------------------------
			RegFunctions._gameMenu = new FlxSave(); // initialize		
			RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
			RegCustom.resetConfigurationVars();
			RegFunctions.loadConfig();
			if (Reg._tn == 0) RegCustom.resetConfigurationVars2();
		#end
				
		FlxG.autoPause = false;	// this class will pause when not in focus.
				
		getPlayersNamesAndAvatars();
		
		if (Reg.__title_bar != null) remove(Reg.__title_bar);
			Reg.__title_bar = new TitleBar("Front Door");
			add(Reg.__title_bar);
		
		_text_server_login_data = new FlxText(0, 0, 0, "");
		_text_server_login_data.scrollFactor.set(0, 0);
		_text_server_login_data.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text_server_login_data.setPosition(15, FlxG.height / 2 - 200);
		_text_server_login_data.visible = false;
		_text_server_login_data.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		add(_text_server_login_data);
		
		
		_text_server_login_data2 = new TextGeneral(15, FlxG.height / 2 - 200 + 45, 0, "");
		_text_server_login_data2.scrollFactor.set(0, 0);
		_text_server_login_data2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text_server_login_data2.visible = false;
		_text_server_login_data2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_server_login_data2);
		
		
		_text_server_login_data3 = new TextGeneral(15, _text_server_login_data2.y + 80, 0, "");
		_text_server_login_data3.scrollFactor.set(0, 0);
		_text_server_login_data3.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text_server_login_data3.visible = false;
		_text_server_login_data3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_server_login_data3);		
		
		_text_server_login_data4 = new TextGeneral(15, _text_server_login_data3.y + 80, 0, "");
		_text_server_login_data4.scrollFactor.set(0, 0);
		_text_server_login_data4.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text_server_login_data4.visible = false;
		_text_server_login_data4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_server_login_data4);
		
		_text_client_login_data = new FlxText(0, 0, 0, "");
		_text_client_login_data.scrollFactor.set(0, 0);
		_text_client_login_data.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_client_login_data.setPosition(FlxG.width / 2, _text_server_login_data.y);
		_text_client_login_data.visible = false;
		_text_client_login_data.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
		add(_text_client_login_data);
				
		_text_client_login_data2 = new TextGeneral(0, 0, 0, "", 8, true, false, 0, 0, false);
		_text_client_login_data2.scrollFactor.set(0, 0);
		_text_client_login_data2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_client_login_data2.setPosition(FlxG.width / 2, _text_server_login_data2.y);
		_text_client_login_data2.visible = false;
		_text_client_login_data2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_client_login_data2);
		
		_text_client_login_data3 = new TextGeneral(0, 0, 0, "", 8, true, false, 0, 0, false);
		_text_client_login_data3.scrollFactor.set(0, 0);
		_text_client_login_data3.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_client_login_data3.setPosition(FlxG.width / 2, _text_server_login_data3.y);
		_text_client_login_data3.visible = false;
		_text_client_login_data3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_client_login_data3);
		
		_text_client_login_data4 = new TextGeneral(0, 0, 0, "", 8, true, false, 0, 0, false);
		_text_client_login_data4.scrollFactor.set(0, 0);
		_text_client_login_data4.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_client_login_data4.setPosition(FlxG.width / 2, _text_server_login_data4.y);
		_text_client_login_data4.visible = false;
		_text_client_login_data4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_text_client_login_data4);
		
		_text_logging_in = new FlxText(0, 700, 0, "Logging in to server...");
		_text_logging_in.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PURPLE);
		_text_logging_in.scrollFactor.set(0, 0);
		_text_logging_in.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_logging_in.screenCenter(X);
		add(_text_logging_in);			
		
		#if chess
			__chess_check_or_checkmate = new ChessCheckOrCheckmate(__ids_win_lose_or_draw);
		#end
	}
	
	public function saveClientConfig():Void
	{
		// save data
		#if !html5
			_gameMenu.data._username_last_remembered = Reg2._username_last_remembered;

			_gameMenu.flush();
			_gameMenu.close;
			
		#end
	}
	
	private function loadClientConfig():Void
	{
		#if !html5
			if (_gameMenu.data._username_last_remembered != null)
				Reg2._username_last_remembered = _gameMenu.data._username_last_remembered;
			
			_gameMenu.close;
		
		#end
	}

	
	public static function prepareToDisconnect():Void
	{
		if (Reg._game_offline_vs_player == false
		&&	Reg._game_offline_vs_player == false
		&&	Reg._game_online_vs_cpu == false)
		{
			if (RegTypedef._dataMisc._userLocation > 0
			&&  RegTypedef._dataMisc._userLocation < 3) 
			{
				PlayState.clientSocket.send("Lesser RoomState Value", RegTypedef._dataMisc);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 0;
				RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = 0;
				RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = -1;
				RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room] = "";
				RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = "";
				RegTypedef._dataMisc._userLocation -= 1;
				RegTypedef._dataMisc._room = 0;
				
				PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers); // ping.
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			// call the leave room code at SceneGameRoom.hx
			Reg._yesNoKeyPressValueAtMessage = 1;
			Reg._buttonCodeValues = "g1000";
		}		
	
		Reg._disconnectNow = true;
	}
	
	/******************************
	 * user is disconnecting by pressing the esc key.
	 */
	public static function disconnectByESC():Void
	{
		Reg._buttonCodeValues = "";
		_clientDisconnect = false;
			
		if (PlayState.clientSocket.isConnected() == true) PlayState.clientSocket.close();
		FlxG.switchState(new MenuState());
	}
	
	override public function destroy()
	{
		if ( __scene_lobby != null)
		{
			remove(__scene_lobby);
			__scene_lobby.destroy();
		}
		
		if (__scene_create_room != null)
		{
			remove(__scene_create_room);
			__scene_create_room.destroy();
		}
		
		if (__scene_waiting_room != null)
		{
			remove(__scene_waiting_room);
			__scene_waiting_room.destroy();
		}
		
		super.destroy();
	}
	
	static function setExitHandler(_exit:Void->Void):Void 
	{
		#if openfl_legacy
		openfl.Lib.current.stage.onQuit = function() {
			_exit();
			openfl.Lib.close();
		};
		#else
		openfl.Lib.current.stage.application.onExit.add(function(code) {
			_exit();
		});
		#end
	}
	
	public static function getPlayersNamesAndAvatars():Void
	{
		if (Reg._game_offline_vs_cpu == true) RegFunctions.offlineCpuUserNames(); // generate the computer names and computer avatar numbers to be used when playing against computer. if playing a one player game against the computer, use the name and avatar created at this function for that BOT player.
			
		if (Reg._loggedIn == false)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[0] == "")
				RegTypedef._dataPlayers._usernamesDynamic[0] = RegCustom._profile_username_p1[Reg._tn];
			
			if (Reg._game_offline_vs_player == true)
				RegTypedef._dataPlayers._usernamesDynamic[1] = RegCustom._profile_username_p2[Reg._tn];
			else
				RegTypedef._dataPlayers._usernamesDynamic[1] = Reg2._offline_cpu_host_name2;
				
			RegTypedef._dataPlayers._usernamesDynamic[2] = Reg2._offline_cpu_host_name3;
			RegTypedef._dataPlayers._usernamesDynamic[3] = "";
			
			RegTypedef._dataPlayers._moveNumberDynamic[0] = 0;
			RegTypedef._dataPlayers._moveNumberDynamic[1] = 1;
			RegTypedef._dataPlayers._moveNumberDynamic[2] = 2;
			RegTypedef._dataPlayers._moveNumberDynamic[3] = 3;
			
			RegTypedef._dataPlayers._avatarNumber[0] = RegCustom._profile_avatar_number1[Reg._tn];
			RegTypedef._dataPlayers._avatarNumber[1] = RegCustom._profile_avatar_number2[Reg._tn];
			RegTypedef._dataPlayers._avatarNumber[2] = RegCustom._profile_avatar_number3[Reg._tn];
			RegTypedef._dataPlayers._avatarNumber[3] = "0.png";
		}
	}
	
	private function client():Void
	{
		RegTypedef._dataGame0.id = RegTypedef._dataGame.id;
		RegTypedef._dataGame1.id = RegTypedef._dataGame.id;
		RegTypedef._dataGame2.id = RegTypedef._dataGame.id;
		RegTypedef._dataGame3.id = RegTypedef._dataGame.id;
		RegTypedef._dataGame4.id = RegTypedef._dataGame.id;
		RegTypedef._dataMisc.id = RegTypedef._dataGame.id;
		RegTypedef._dataPlayers.id = RegTypedef._dataGame.id;
		RegTypedef._dataOnlinePlayers.id = RegTypedef._dataGame.id;
		RegTypedef._dataDailyQuests.id = RegTypedef._dataGame.id;
		RegTypedef._dataQuestions.id = RegTypedef._dataGame.id;
		RegTypedef._dataAccount.id = RegTypedef._dataGame.id;		
		RegTypedef._dataGameMessage.id = RegTypedef._dataGame.id;
		RegTypedef._dataMovement.id = RegTypedef._dataGame.id;
		RegTypedef._dataStatistics.id = RegTypedef._dataGame.id;
		RegTypedef._dataHouse.id = RegTypedef._dataGame.id;
		RegTypedef._dataLeaderboards.id = RegTypedef._dataGame.id;
		
		if (__ids_win_lose_or_draw != null)
		{
			remove(__ids_win_lose_or_draw);
			__ids_win_lose_or_draw.destroy();
		}
				
		__ids_win_lose_or_draw = new IDsWinLoseOrDraw();
		add(__ids_win_lose_or_draw);
		
		//############################# CODE BLOCK
		// delete this block when game is finished. also, at join event, uncomment the block.
		if (Reg._game_online_vs_cpu == false && Reg._game_offline_vs_cpu == true
		||  Reg._game_online_vs_cpu == false && Reg._game_offline_vs_player == true)
		{
			_lobbyRoomChat = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			RegTypedef._dataMisc._room = 26;
			RegTypedef._dataMisc._roomState[26] = 6; 
			RegTypedef._dataMisc._gameRoom = true;
			Reg._gameRoom = true;
			//TODO make auto start start for offline mode here. //Reg._gameOverForPlayer = false;
			RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = Reg._gameId;
			
			Reg._move_number_next = 0;
		}
		
		if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)		
		{
			try
			{
				#if html5				
					clientSocket = new vendor.mphx.client.impl.WebsocketClient(Reg._ipAddress, Reg._port);
				#else
					clientSocket = new vendor.mphx.client.Client(Reg._ipAddress, Reg._port);
				#end
					
				// cannot connect to server.
				clientSocket.onConnectionError = function (s)
				{
					Reg._cannotConnectToServer = true;
					clientSocket.close();
					
					FlxG.switchState(new MenuState());
				}				
				
				clientSocket.connect();	
				
				if (RegTypedef._dataAccount._username == "")
					RegTypedef._dataAccount._username = RegCustom._profile_username_p1[Reg._tn];
				
				RegTypedef._dataAccount._ip = Internet.getIP();
				
				if (RegTypedef._dataAccount._ip == "")
				{
					Reg._cannotConnectToServer = true;
					FlxG.switchState(new MenuState());
				}
				
				#if html5
					RegTypedef._dataAccount._hostname = "html5";
				#else
					RegTypedef._dataAccount._hostname = Internet.getHostname();
				#end
				
				RegTypedef._dataAccount._password_hash = Md5.encode(RegCustom._profile_password_p1);
					
				clientSocket.send("Join", RegTypedef._dataAccount); // go to the event "join" at server then at server at event join there could be a broadcast that will send data to a client event.
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
			}	
			
			catch (e:Dynamic)
			{
				#if neko
					trace(e);
				#end
			}		
		
		
			//############################ CODE BLOCK #############################
			// delete this line  when game is finished.
			//_data._popupMessage = "Login successful.";
			
			
			// uncomment this commented code block when game is finished.
			__scene_lobby = new SceneLobby();
			__scene_lobby.visible = false;
			__scene_lobby.active = false;
			add(__scene_lobby);
			
			__scene_create_room = new SceneCreateRoom(); // Reg._at_create_room now equals true. if this event is called from room.hx then this block of code will not be read. third var is used to clear screen.
			__scene_create_room.visible = false;
			__scene_create_room.active = false;			
			add(__scene_create_room);
			
			__scene_waiting_room = new SceneWaitingRoom();
			__scene_waiting_room.scrollable_area();
			__scene_waiting_room.__scrollable_area.visible = false;
			__scene_waiting_room.__scrollable_area.active = false;
			__scene_waiting_room.visible = false;
			__scene_waiting_room.active = false;
			add(__scene_waiting_room);
					
			if (Reg._clientReadyForPublicRelease == false)
			{
				__action_commands = new ActionCommands(); 
				add(__action_commands);
			}
			
			// these value could have been set to true when creating the room and chat class. they need to be set back to false for the buttons text at lobby to refresh.
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			
					
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				 __network_events_main = new NetworkEventsMain(__ids_win_lose_or_draw, _data, __scene_lobby, __scene_create_room, __scene_waiting_room);
				add(__network_events_main);			
			}
			
			
			//####################### END CODE BLOCK ########################
		}
			
		Reg._hasUserConnectedToServer = true; // this var is misleading. game in offline mode cannot be played unless this var is moved outside of a Reg._game_offline_vs_cpu check.
	}

	/******************************
	 * player is entering the lobby.
	 */
	private function lobbyEnter():Void
	{
		if (Reg._game_offline_vs_cpu == false  && Reg._game_offline_vs_player == false && _clientDisconnect == false)
		{
			if (Reg._goBackToLobby == true || Reg._loginSuccessfulWasRead == true && Reg._doOnce == true)
			{
				FlxG.mouse.reset();
				FlxG.mouse.enabled = true;
						
				Reg._doOnce = false; 
				Reg._goBackToLobby = false;
				__scene_lobby.active = true;
				
				//ActionInput.enable();
	
				if (Reg._lobbyDisplay == true) {Reg._lobbyDisplay = false;  __scene_lobby.display(); }		
				
				__scene_lobby.visible = true;			
				__scene_lobby.__scrollable_area.visible = true;
				
				if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
				{
					GameChatter.__scrollable_area2.visible = true;
				}
				
				__scene_waiting_room.visible = false;
				__scene_waiting_room.active = false;
				__scene_create_room.visible = false;
			}
		}
	}
	
	/******************************
	 * everything inside this block is ran when a game is first started at every move.
	 */
	private function enterGameRoom():Void
	{
		if (Reg._gameRoom == true)
		{
			if (Reg._doStartGameOnce == true)
			{
				// the host player always moves first.
				if (RegTypedef._dataTournaments._move_piece == false
				&&  Reg._gameHost == false)
					Reg._playerCanMovePiece = false; 
				
				if (Reg._game_offline_vs_cpu == false 
				&&  Reg._game_offline_vs_player == false
				&&  __scene_waiting_room != null
				&&  SceneWaitingRoom.__game_chatter != null)
				{
					SceneWaitingRoom.__game_chatter.visible = false;
					SceneWaitingRoom.__game_chatter.active = false;
					
					__scene_waiting_room.visible = false;
					__scene_waiting_room.active = false;
									
				}

				if (Reg._createGameRoom == true)
				{
					Reg._createGameRoom = false;							
									
					if (__scene_game_room != null)
					{
						remove(__scene_game_room);
						__scene_game_room.destroy();
					}					
					
				}
				
				#if chess
					__scene_game_room = new SceneGameRoom(__ids_win_lose_or_draw, __chess_check_or_checkmate);
					add(__scene_game_room);					
				#else
					__scene_game_room = new SceneGameRoom(__ids_win_lose_or_draw, null);
					add(__scene_game_room);
				#end
				
				__scene_game_room.active = true;
				__scene_game_room.visible = true;
								
				if (Reg._gameId == 0) 
				{
					
					// this is needed because the first notation is not printed for checkers.
					if (Reg._notation_output == true)
					{
						if (Reg._game_offline_vs_cpu == true
						||  Reg._game_offline_vs_player == true) 
						{
							SceneGameRoom.__game_history_and_notations.notationPrint();
						}
					}
				}
				
				
			}
			
			
			gameMessagesAtSubState(); // should a message be displayed?
			if (Reg._createGameRoom == false && Reg._doStartGameOnce == false)
			{
				if (Reg._gameId <= 1)
				{
									
					// should the scroller text be displayed?
					if (Reg._gameId == 1 
					&&  SceneGameRoom.__game_history_and_notations != null
					&&  RegCustom._chess_opening_moves_enabled[Reg._tn] == true)
						SceneGameRoom.__game_history_and_notations.gameNotationScrollerText(); 
						
				}						
					
				if (Reg._pieceMovedUpdateServer == true)
				{
					Reg._pieceMovedUpdateServer = false;
					
					if (RegTypedef._dataTournaments._move_piece == true)
					{
						// needed to display game over messages after a player in tournament game moves a game piece.
						if (Reg._gameHost == true)
						{
							Reg._gameHost = false;
							Reg._playerMoving = 1;
							Reg._playerNotMoving = 0;
						}
						
						else
						{
							Reg._gameHost = true;
							Reg._playerMoving = 0;
							Reg._playerNotMoving = 1;
						}
						
					}
					
					// send gameboard data to server.
					__scene_game_room.__game_create.gameId_send_data_to_server(); 
					
					if (RegTypedef._dataTournaments._move_piece == true)
					{
						Reg._gameOverForPlayer = true;
						Reg._gameOverForAllPlayers = true;
						RegFunctions.playerAllStop();
						
						RegTypedef._dataTournaments._time_remaining_player2 = Std.string(RegTypedef._dataPlayers._moveTimeRemaining[1]);
						RegTypedef._dataTournaments._time_remaining_player1 = Std.string(RegTypedef._dataPlayers._moveTimeRemaining[0]);
												
						PlayState.clientSocket.send("Tournament Chess Standard 8 Put", RegTypedef._dataTournaments);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
					}
				}
			}
			
			if (Reg._doStartGameOnce == true)
			{						
				Reg._doStartGameOnce = false;  // TODO does this var need to be anywhere?
			
			}
			
				
		}
	}
	/******************************
	 * restart the game for either p1 vs computer or p1 vs p2,p3,p4.
	 */
	private function restartGame():Void
	{
		if (Reg._createGameRoom == true 
		&& Reg._game_offline_vs_cpu == true 
		&& Reg._game_online_vs_cpu == false
		|| Reg._createGameRoom == true 
		&& Reg._game_offline_vs_player == true 
		&& Reg._game_online_vs_cpu == false)
		{
			RegTypedef.resetTypedefData();					
			Reg.resetRegVars();
			Reg2.resetRegVars();
			RegCustom.resetRegVars();
			RegTriggers.resetTriggers();
			
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				Reg._playerMoving = 0;
				Reg._playerNotMoving = 1;
			}
			
			_lobbyRoomChat = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			RegTypedef._dataMisc._room = 5;
			RegTypedef._dataMisc._roomState[3] = 6; 
			RegTypedef._dataMisc._gameRoom = true;
			Reg._gameRoom = true;
			Reg._gameHost = true;
			Reg._gameOverForPlayer = false;
			
			//getPlayersNamesAndAvatars();
			
			Reg._playerCanMovePiece = true;
			Reg._playerMoving = 0;
								
			Reg._move_number_current = 0;
			Reg._move_number_next = 0;
			Reg._gameJumpTo = 0; 
		}
	
		if (Reg._createGameRoom == true
		&&  Reg._game_offline_vs_cpu == false
		&&  Reg._game_offline_vs_player == false
		||  Reg._createGameRoom == true
		&&  Reg._game_online_vs_cpu == true)
		{
			RegTypedef.resetTypedefData();
		
			Reg.resetRegVars(); 
			Reg2.resetRegVars();
			RegCustom.resetRegVars();
			RegTriggers.resetTriggers();
			
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				if (Reg._gameHost == true) Reg._playerCanMovePiece = true;
				else 
				{				
					Reg._otherPlayer = true;
					Reg._playerCanMovePiece = false;
				}
				
			}
			
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				Reg._playerMoving = 0;
				Reg._playerNotMoving = 1;
			}
			
			if (Reg._game_online_vs_cpu == true) 
				RegTypedef._dataPlayers._spectatorPlaying = true;	
			Reg._at_create_room = true;
			Reg._at_waiting_room = true;
			_lobbyRoomChat = false;
			Reg._goBackToLobby = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._gameRoom = true;
			Reg._hasUserConnectedToServer = true;
			
			if (RegTypedef._dataTournaments._move_piece == false)
				Reg._move_number_next = 0;
			//if (__scene_waiting_room.visible == false) Reg._loginSuccessfulWasRead = true;
			Reg._doOnce = false;			
			Reg._lobbyDisplay = false;
			//Reg._gameOverForPlayer = false;
			
			
	//RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = 3;	
			
		}
	}
	
	
	private function gameMessagesAtSubState():Void
	{
		//############################# CHESS PROMOTION
		#if chess
			if (Reg._chessPromote == true)
			{
				Reg._chessPromote = false;			
				openSubState(new ChessPromote());
			}
		#end
	}	
	
	private function gameMessage():Void
	{
		if (Reg._chessCheckmateBypass == true
		&& Reg._gameMessage != "Check" 
		&& Reg._gameMessage != "White piece wins."
		&& Reg._gameMessage != "Black piece wins."
		|| Reg._gameMessage == "") return;
	
		openSubState( new GameMessage());		
		Reg._outputMessage = false;
	}
	
	/******************************
	 * if player clicks the watch game button or enters into the waiting room then these typedefs need to be updated.
	 */
	public static function allTypedefRoomUpdate(_room:Int):Void
	{
		RegTypedef._dataGame._room = _room;
		RegTypedef._dataGame0._room = _room;// this line is needed or else the server will not be able to send back the data or will send back to the wrong client. remember that the server broadcasts to a room using the room var. 
		RegTypedef._dataGame1._room = _room;
		RegTypedef._dataGame2._room = _room;
		RegTypedef._dataGame3._room = _room;
		RegTypedef._dataGame4._room = _room;
		
		RegTypedef._dataGameMessage._room = 	_room;
		RegTypedef._dataQuestions._room = 		_room;
		RegTypedef._dataTournaments._room = 	_room;
		RegTypedef._dataOnlinePlayers._room = 	_room;
		RegTypedef._dataPlayers._room = 		_room; 
		RegTypedef._dataMovement._room = 		_room; 
		RegTypedef._dataStatistics._room = 		_room; 

	}
	
	/******************************
	 * _dataMisc does not been this assignment a value because it already has the correct username from the "Is logging In" network event. This function is needed or else there will be a null error at server for the username when saving user actions to the server log file. _dataGame is not used here because its not needed for server log file. hence, in this board game its not a location where a player can go.
	 */
	public static function allTypedefUsernameUpdate(_username:String):Void
	{
		RegTypedef._dataGame0._username = _username;
		
		RegTypedef._dataGame1._username = _username;
		RegTypedef._dataGame2._username = _username;
		RegTypedef._dataGame3._username = _username;
		RegTypedef._dataGame4._username = _username;
		
		RegTypedef._dataGameMessage._username = 	_username;
		RegTypedef._dataDailyQuests._username = 	_username;
		RegTypedef._dataQuestions._username = 		_username;
		RegTypedef._dataTournaments._username = 	_username;
		RegTypedef._dataOnlinePlayers._username = 	_username;
		RegTypedef._dataPlayers._username = 		_username;
		RegTypedef._dataMovement._username = 		_username; 
		RegTypedef._dataStatistics._username = 		_username;
		RegTypedef._dataHouse._username = 			_username;
	}
	
	/******************************
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		// should message box be displayed?
		if (Reg._messageId > 0 && Reg._messageId != 1000000
		&&	RegTriggers._buttons_set_not_active == false)
		{
			var _msg = new IdsMessageBox();
			add(_msg);
		}
		
		if (RegTriggers._keyboard_open == true)
		{
			RegTriggers._keyboard_open = false;
			RegTriggers._keyboard_opened = true;

			//#if mobile
				if (__action_keyboard != null)
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
				
				if (__action_keyboard == null)
				{
					__action_keyboard = new ActionKeyboard();
					add(__action_keyboard);
				}
				
				__action_keyboard.drawButtons();
			//#end
		}
		
		if (RegTriggers._keyboard_close == true)
		{
			RegTriggers._keyboard_close = false;

			//#if mobile
				if (__action_keyboard != null) 
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
			//#end
		}
		
		// go to the client() function and connect to the server. If connected then define the events.
		if ( Reg._hasUserConnectedToServer == false) client();
		
		if ( Reg._hasUserConnectedToServer == true)
		{
			//############################# EVENT KEYS AND BUTTONS
			
			if (Reg._loggedIn == true)
			{
				//trace("playState. debug timer error.");
								
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{
					// login successful. do the following once.
					if (Reg._doUpdate == true)
					{
						Reg._doUpdate = false;
						
						Reg.__title_bar.visible = false;
						
						_text_server_login_data.visible = false;
						_text_server_login_data2.visible = false;
						_text_server_login_data3.visible = false;
						_text_server_login_data4.visible = false;
						
						_text_client_login_data.visible = false;
						_text_client_login_data2.visible = false;
						_text_client_login_data3.visible = false;
						_text_client_login_data4.visible = false;
						
						#if !html5
							saveClientConfig();
						
						#end
						
						//#if mobile
							if (__action_keyboard != null) 
							{
								__action_keyboard.close();
								remove(__action_keyboard);
								__action_keyboard = null;
							}
						//#end
						
					}
					
				}
				
				// everything inside this code block is ran when a game is first started.
				enterGameRoom();
				
				// restart the game for either p1 vs computer or p1 vs p2.
				if (Reg._playerLeftGame == false) restartGame();
				
			}
			
		}
		
		if (Reg._isLoggingIn == true) _ticks_logging_in_delay += 1;
		
		// user is sending logging in data to the server.
		if (Reg._isLoggingIn == true 
		&&	Reg._game_offline_vs_cpu == false
		&&	Reg._game_offline_vs_player == false
		&&	_ticks_logging_in_delay >= 31)
		{
			Reg._isLoggingIn = false; 
			_ticks_logging_in_delay = 0;
			
			// client at website is only for guest accounts.
			#if html5
				RegTypedef._dataAccount._guest_account = true;
			#else
				RegTypedef._dataAccount._guest_account = false;
			#end
			
			// TODO add a RegCustom here if bypass this code so that the user's avatar at website is used. see near bottom of server, is logging in event. that code also needs to be bypassed.
			RegTypedef._dataAccount._avatarNumber = RegCustom._profile_avatar_number1[Reg._tn];
			
			clientSocket.send("Is Logging In", RegTypedef._dataAccount); //events	
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}
		
		// player is entering the lobby.
		lobbyEnter();
		
		if (RegTriggers._lobby == true
		&& PlayState._clientDisconnect == false
		&& Reg._game_offline_vs_cpu == false
		|| RegTriggers._lobby == true
		&& PlayState._clientDisconnect == false
		&& Reg._game_offline_vs_player == false)
		{
			Reg._at_lobby = true;
			RegTriggers._lobby = false;
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			Reg2._lobby_button_alpha = 0.3;
			RegTriggers._buttons_set_not_active = false;
			
			if (__scene_game_room != null)
			{
				if (__scene_game_room._playerTimeRemainingMove != null)
				{
					__scene_game_room._playerTimeRemainingMove.destroy();
					__scene_game_room._playerTimeRemainingMove = null;
				}
				
				remove(__scene_game_room);
			}
			
			PlayersLeftGameResetThoseVars.playerRepopulateTypedefPlayers();
			Reg._playerOffset = 0;
				
			Reg._clearDoubleMessage = false;
			Reg._game_online_vs_cpu = false;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			
			//room.group.visible = false;
			__scene_create_room.visible = false;
			//room.group.active = false; 
			__scene_create_room.active = false;
			
			if (GameChatter._groupChatterScroller != null)
				GameChatter._groupChatterScroller.x = 0;
			
			// this check is needed because user might be coming from creating room.
			if (GameChatter.__scrollable_area3 != null)
			{
				SceneWaitingRoom.__game_chatter.visible = false;
				GameChatter.__scrollable_area3.visible = false;
			
				SceneWaitingRoom.__game_chatter.active = false;
				GameChatter.__scrollable_area3.active = false;
			}
			
			__scene_waiting_room.visible = false;					
			__scene_waiting_room.active = false;
			
			__scene_lobby.active = true;
			__scene_lobby.visible = true;
			
			__scene_lobby.__scrollable_area.active = true;			
			__scene_lobby.__scrollable_area.visible = true;
			
			__scene_lobby.set_active_for_buttons();			
			__scene_lobby.initialize();
			
			if (SceneLobby.__game_chatter != null)
			{
				SceneLobby.__game_chatter.active = true;
				SceneLobby.__game_chatter.visible = true;
			}
			
			if (GameChatter.__scrollable_area2 != null)
			{
				GameChatter.__scrollable_area2.active = true;
				GameChatter.__scrollable_area2.visible = true;
			}
			
			RegTriggers._recreate_chatter_input_chat = true;
			
			Reg._updateScrollbarBringUp = true; 
			
		}
		
		if (RegTriggers._createRoom == true)
		{
			Reg._at_create_room = true;
			RegTriggers._createRoom = false;
			Reg._clearDoubleMessage = false;
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			Reg2._lobby_button_alpha = 0.3;
			RegTriggers._buttons_set_not_active = false;
			
			if (GameChatter.__scrollable_area2 != null)
			{
				GameChatter.__scrollable_area2.visible = false;
				__scene_lobby.__scrollable_area.visible = false;
				
				GameChatter.__scrollable_area2.active = false;
				__scene_lobby.__scrollable_area.active = false;
			}
			
			if (GameChatter.__scrollable_area3 != null)
			{
				GameChatter.__scrollable_area3.visible = false;
				GameChatter.__scrollable_area3.active = false;
			}
									
			__scene_lobby.__scrollable_area.visible = false;
			__scene_lobby.__scrollable_area.active = false;
			
			__scene_lobby.visible = false;
			__scene_lobby.active = false;			
			
			__scene_create_room.active = true;
			__scene_create_room.visible = true;
			
			__scene_create_room.initialize();
			
			Reg._updateScrollbarBringUp = true; 
		}
		
		
		if (RegTriggers.__scene_waiting_room == true)
		{
			Reg._at_lobby = false;
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			RegTriggers.__scene_waiting_room = false;
			Reg._clearDoubleMessage = false;
			Reg2._lobby_button_alpha = 0.3;
			RegTriggers._buttons_set_not_active = false;
			Reg._at_waiting_room = true;
			
			__scene_create_room.visible = false;
			__scene_create_room.active = false;			
			
			if (GameChatter.__scrollable_area2 != null)
			{
				GameChatter.__scrollable_area2.visible = false;
				__scene_lobby.__scrollable_area.visible = false;
							
				GameChatter.__scrollable_area2.active = false;
				__scene_lobby.__scrollable_area.active = false;
			}
			
			__scene_lobby.__scrollable_area.visible = false;
			__scene_lobby.__scrollable_area.active = false;
			
			__scene_lobby.visible = false;	
			__scene_lobby.active = false;
			
			if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
			{
				SceneLobby.__game_chatter.visible = false;
				SceneLobby.__game_chatter.active = false;
			}
			
			if (GameChatter._chatterOpenCloseButton != null)
			{
				GameChatter._chatterOpenCloseButton.visible = false;
				GameChatter._chatterOpenCloseButton.active = false;
			}
			
			__scene_waiting_room.active = true;			
			__scene_waiting_room.visible = false;			
			__scene_waiting_room.initialize();
			__scene_waiting_room.visible = true;
			
			if (SceneWaitingRoom.__game_chatter != null)
			{
				SceneWaitingRoom.__game_chatter.active = true;
				SceneWaitingRoom.__game_chatter.visible = true;
			}
			
			if (GameChatter.__scrollable_area3 != null)
			{
				GameChatter.__scrollable_area3.active = true;
				GameChatter.__scrollable_area3.visible = true;
			}
			
			Reg._updateScrollbarBringUp = true; 
		}
		
		// kicked or banned. display message.
		if (RegTriggers._actionMessage == true)
		{
			RegTriggers._actionMessage = false;
						
			Reg._messageId = 1003;
			Reg._buttonCodeValues = "l1020";
			SceneGameRoom.messageBoxMessageOrder();
		}
		
		// action key clicked. destroy it.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l1020")
		{			
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
						
			__scene_lobby.active = true;
			__scene_lobby._group_scrollable_area.active = true;
			__scene_lobby.__scrollable_area.active = true;
			
			if (GameChatter.__scrollable_area2 != null)
			{
				GameChatter.__scrollable_area2.active = true;
			}			
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
		
		// close room is locked message box
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "lock1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			// Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
		}
		
		if (Reg._outputMessage == true) gameMessage();
		
		super.update(elapsed);
		
		if (Reg._game_offline_vs_cpu == false
		&&  Reg._game_offline_vs_player == false 
		&&  clientSocket != null
		||  Reg._game_online_vs_cpu == true
		&&  clientSocket != null)
		{
			if (clientSocket.isConnected() == true)
			{
				try
				{
					// this is needed or else the events will not be entered client side.
					clientSocket.update(); // this "if" statement is needed to stop a game crash in all build targets. also needed below update() to stop a cpp crash.
					
				}	
				catch (e:Dynamic)
				{
					trace(e);
				}
			}
		}
		
		// this block of code is also called from the end of the DisconnectFromUser event so that everything in that event is executed.
		if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			if (__network_events_main._closeSocket == true)
			{
				__network_events_main._closeSocket = false;
				
				if (clientSocket.isConnected() == true) clientSocket.close();
				FlxG.switchState(new MenuState());
			}
			
		}
			
		if (Reg._disconnectNow == true) 
		{
			Reg._disconnectNow = false;
			
			if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				if (clientSocket.isConnected() == true) clientSocket.close();
			}
			
			Reg._serverDisconnected = false;
			FlxG.switchState(new MenuState());
			
		}
	}
	
}//