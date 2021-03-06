/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

import RegTypedef;
import vendor.ws.WebSocket;
import vendor.ws.Types;

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
	public static var __title_bar:TitleBar;
	
	private var _msg:IdsMessageBox;
	
	/******************************
	 * this gives the user a list of events displayed at front door as they are completed because logging in to the lobby takes a few seconds. 
	 */
	public static var _text_client_login_data:FlxText;
	
	public static var _websocket:WebSocket;
	
	/******************************
	 * keyboard for mobile.
	 */
	private var __action_keyboard:ActionKeyboard;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	/******************************
	 * system operator class. handles key presses. can disconnect the server by pressing the ESC key, etc.
	 */
	public var __hotkeys:Hotkeys;
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
	 * in html5 build the variable at the Internet.hx class function does not get populated before its return command. therefore this variable is used to delay code, which comes after the Internet.hx class function call, until the Internet.hx class function variable does get populated.
	 */
	private var _ticks_ip:Int = -1;
	private var _ticks_hostname:Int = -1;
	
	/******************************
	 * when at front door, user has so many seconds to press a key to enter lobby. if user has not pressed a key within these many ticks then user will be directed to the lobby.
	 */
	private var _ticks_lobby:Int = 0;
	
	/******************************
	 * user will be directed to the lobby from the front door when _ticks_lobby reaches this value.
	 */
	private var _ticks_lobby_maximum:Int = 240;
	
	/******************************
	 * before the user is sent to the front door, send a request to website to determine what position that user is at. a request will be sent to Internet.hx class every 1 second until the user is at position 1. The user can enter to the front door when at position 1.
	 * remember without this code, when two or more users enter to the front door at the same time, data will be corrupt and those users will not be able to go to lobby.
	 */
	public static var _front_door_queue:Int = 0;
	
	/******************************
	 * every 1 second, when this ticks reaches Reg._framerate, if user cannot yet go to the front door, another request to Internet.front_door_queue() will be made.
	 */
	private var _ticks_front_door_queue:Int = 0;
	
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
	
	/******************************
	 * if true the user will be redirected to the game room for offline play.
	 */
	private var _game_offline_enter_game_room:Bool = false;
	
	private var _id:Int = 0;
	
	override public function create():Void
	{
		super.create();
		
		RegFunctions.fontsSharpen();
		
		persistentDraw = true;
		persistentUpdate = true;
		
		_ticks_ip = - 1;
		_ticks_hostname = - 1;
		_ticks_lobby = 0;		
		
		_id = ID = Std.parseInt(RegTypedef._dataGame.id.substr(0, 7));
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		__scene_background = new SceneBackground();
		add(__scene_background);
		
		_clientDisconnect = false;
		_clientDisconnectDo = true;
		
		setExitHandler(function() 
		{
			prepareToDisconnect();
		});
		
		//------------------------------
		#if !html5
			RegFunctions._gameMenu = new FlxSave(); // initialize		
			RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
			RegCustom.resetConfigurationVars();
			RegFunctions.loadConfig();
			if (Reg._tn == 0) RegCustom.resetConfigurationVars2();
		#end
				
		FlxG.autoPause = false;	// this class will pause when not in focus.
				
		getPlayersNamesAndAvatars();
		
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Front Door");
		add(__title_bar);		
		
		_text_logging_in = new FlxText(0, 660, 0, "Logging in to server...");
		_text_logging_in.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_text_logging_in.scrollFactor.set(0, 0);
		_text_logging_in.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text_logging_in.screenCenter(X);
		add(_text_logging_in);			
		
		#if chess
			__chess_check_or_checkmate = new ChessCheckOrCheckmate(__ids_win_lose_or_draw);
		#end
		
		_game_offline_enter_game_room = false;
		
		if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false)
			Internet.isUsernameOnline();
		else 
			_game_offline_enter_game_room = true;
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
				PlayState.send("Lesser RoomState Value", RegTypedef._dataMisc);				
				
				RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 0;
				RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = 0;
				RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = -1;
				RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room] = "";
				RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = "";
				RegTypedef._dataMisc._userLocation -= 1;
				RegTypedef._dataMisc._room = 0;
				
				PlayState.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
				
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
			
		if (Reg._client_socket_is_connected == true)
		{
			Reg._client_socket_is_connected = false;
			_websocket.close();
		}
		
		FlxG.switchState(new MenuState());
	}
	
	public static function setExitHandler(_exit:Void->Void):Void 
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
				RegTypedef._dataPlayers._usernamesDynamic[0] = RegCustom._profile_username_p1[CID3._CRN];
			
			if (Reg._game_offline_vs_player == true)
				RegTypedef._dataPlayers._usernamesDynamic[1] = RegCustom._profile_username_p2;
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

	
    public static function updateInfo() 
	{
        var _message = "Client #";
		
        if (_websocket != null) 
		{
            _message += " - connected";
		} 
		
		else
		{
            _message += " - disconnected";
        }
    }
	
	public static function send(_event:Dynamic, _data:Dynamic):Void
	{
		_data._event_name = _event;
		
		var serializer = new Serializer();
		serializer.serialize(_data);
		var _send = serializer.toString();
		sendString(_send); 
	}
	
    public static function sendString(_send:String)
	{
        if (_websocket == null) 
		{
            trace("error: not connected");
            return;
        }
		
		_websocket.send(_send);		
    }

	/*
    public function sendBinary(b:Bytes) 
	{
        trace("sending binary: len = " + b.length);
        if (_websocket == null) {
            trace("error: not connected");
            return;
        }

        var buffer = new Buffer();
        buffer.writeBytes(b);
        _websocket.send(buffer);
    }
	*/
	
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
	
    public function disconnect() 
	{
		Reg._client_socket_is_connected = false;
        _websocket.close();
        _websocket = null;
    }
	
	private function initiate_variables():Void
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
		
	}
	
	private function offline_game_room():Void
	{
		if (Reg._game_online_vs_cpu == false && Reg._game_offline_vs_cpu == true
		||  Reg._game_online_vs_cpu == false && Reg._game_offline_vs_player == true)
		{
			_lobbyRoomChat = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			RegTypedef._dataMisc._room = 0;
			RegTypedef._dataMisc._roomState[0] = 6; 
			RegTypedef._dataMisc._gameRoom = true;
			Reg._gameRoom = true;
			
			//TODO make auto start start for offline mode here. //Reg._gameOverForPlayer = false;
			RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = Reg._gameId;
			
			Reg._move_number_next = 0;
		}
		
	}
	
	private function client():Void
	{
		if (_game_offline_enter_game_room == true)
		{
			_game_offline_enter_game_room = false;
			
			initiate_variables();
			offline_game_room();
		}
		
		// a value of 1 means that the user can enter to the front door.
		// a value of 2 means that the user is next user to enter the front door.
		// the order of the user is determined by the timestamp. a user's data is removed from the database when disconnecting or when entering the front door. the that time, the user with a value of 2 will be a value of 1 at the next check to the database. that check is made at Internet.front_door_queue.
		if (Reg._game_offline_vs_player == false
		&&	Reg._game_offline_vs_cpu == false
		&&	Reg._display_queue_message == true)
		{
			if (_id == ID)
			{
				if (_ticks_front_door_queue == 0)
				{
					Internet.front_door_queue();
			
					if (_front_door_queue == 1)
					{
						Reg._messageBoxNoUserInput = "Welcome.";
						_ticks_ip = 0;
					}
					
					else if (_front_door_queue > 1)
						Reg._messageBoxNoUserInput = "You are " + _front_door_queue + " in queue. Please wait...";
				} 
				
				_ticks_front_door_queue += 1;
				if (_ticks_front_door_queue >= Reg._framerate * 2)
					_ticks_front_door_queue = 0;
					
				Reg._outputMessage = true;
			}
		} else _ticks_ip = 0;
		
		// get ip address for the front door.
		if (_ticks_ip == 0
		&&	_id == ID
		&&	Reg._can_join_server == true)
		{
			// no simultaneous entry into the server.
			Reg._can_join_server = false;
			
			initiate_variables();
			
			if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)		
			{
				trace("connected"); // don't remove.
       
				try {
					_websocket = new WebSocket("ws://" + Reg._ipAddress + ":" + Reg._port);
					
					_websocket.onopen = function() 
					{
						Reg._client_socket_is_connected = true;
						sendString("Client connected.");
					}

					_websocket.onmessage = function(_message:Dynamic) 
					{
						var _data:Dynamic = "";
						var _str:String = Std.string(_message);
						
						_str = _str.substr(11, _str.length - 12);
						
						if (_str == "Client connected.") 
							_data = _str;
							
						else if (RegFunctions.contains(_str, "tidi10") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi11") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame0 = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi12") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame1 = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi13") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame2 = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi14") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame3 = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi15") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGame4 = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi40") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataMovement = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}						
						
						else if (RegFunctions.contains(_str, "tidi41") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataGameMessage = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi42") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataDailyQuests = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi43") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataQuestions = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi44") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataOnlinePlayers = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi45") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataTournaments = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi46") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataAccount = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi47") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataMisc = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi48") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataPlayers = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}
						
						else if (RegFunctions.contains(_str, "tidi49") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataStatistics = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}						
						
						else if (RegFunctions.contains(_str, "tidi50") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataHouse = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);
						}						
						
						else if (RegFunctions.contains(_str, "tidi51") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataLeaderboards = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);	
						}
						
						else if (RegFunctions.contains(_str, "tidi52") == true)
						{
							var unserializer = new Unserializer(_str);
							var _data:DataServerMessage = unserializer.unserialize();
							unserializer = null;
							go_to_event(_data);	
						}
						
					};
					
					_websocket.onerror = function(err) 
					{
						trace("error: " + err.toString());
						Reg._client_socket_is_connected = false;
						Reg._cannotConnectToServer = true;
						_websocket.close();
						
						FlxG.switchState(new MenuState());
					}
					
					if (RegTypedef._dataAccount._username == "")
						RegTypedef._dataAccount._username = RegCustom._profile_username_p1[CID3._CRN];
					
					//Internet.getIP();
				}
				
				catch (err:Dynamic) 
				{
					trace("Exception: " + err);
					Reg._cannotConnectToServer = true;
					FlxG.switchState(new MenuState());
				}
			}
			
		}
			
		if (_ticks_ip == 1
		&&	_ticks_hostname == -1
		&&	_id == ID)
		{
			if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				_ticks_hostname = 1;
			}
		
		}
		
		// display the front door text for this user and set the lobby ticks so that if user has not pressed a key within time allowed, that user will be redirected to lobby. see FlxG.keys.justPressed.ANY == true code.
		if (_ticks_hostname == 1
		&&	_id == ID)
		{
			_ticks_hostname = 2;
			_ticks_lobby = 1;
			
			if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)		
			{
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
				
				// these value could have been set to true when creating the room and chat class. they need to be set back to false for the buttons text at lobby to refresh.
				Reg._at_create_room = false;
				Reg._at_waiting_room = false;
				
				_text_client_login_data = new FlxText(0, 0, 0, "Clients Data.");
				_text_client_login_data.scrollFactor.set(0, 0);
				_text_client_login_data.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
				_text_client_login_data.setPosition(15, FlxG.height / 2 - 200);
				_text_client_login_data.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_topic_title_text_color());
				add(_text_client_login_data);
				
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
				{
					 __network_events_main = new NetworkEventsMain(__ids_win_lose_or_draw, _data, __scene_lobby, __scene_create_room, __scene_waiting_room);
					add(__network_events_main);			
				}
				
				try
				{
					RegTypedef._dataAccount._password_hash = Md5.encode(RegCustom._profile_password_p1[CID3._CRN]);
					RegTypedef._dataAccount._email_address = RegTypedef._dataTournaments._email_address = RegCustom._profile_email_address_p1[CID3._CRN];
					
					send("Join", RegTypedef._dataAccount); // go to the event "join" at server then at server at event join there could be a broadcast that will send data to a client event.					
				}	
				
				catch (e:Dynamic)
				{
					#if neko
						trace(e);
					#end
				}		
				
				if (Reg._gameJumpTo == -1) 
					Reg._hasUserConnectedToServer = true;	
				
			}			
			
			if (__hotkeys != null)
			{
				remove(__hotkeys);
				__hotkeys.destroy();
			}
			
			__hotkeys = new Hotkeys(); 
			add(__hotkeys);
		}
		
		// this is needed to show the SceneGameRoom.hx class in offline mode.
		if (Reg._gameJumpTo == 0) 
			Reg._hasUserConnectedToServer = true;	
				
		if (_id == ID 
		&&	_ticks_ip != -1
		&&	RegTypedef._dataMisc.id == RegTypedef._dataGame.id)
			_ticks_ip = 1;
	}

	private function go_to_event(_data:Dynamic):Void
	{
		trace("data received: " + _data._event_name);
		
		if (_data != "Client connected."
		&& 	_data._event_name != "")
		{
			if (__network_events_main != null)
			{
				__network_events_main.events(_data);
			}
		}
	}
	
	/******************************
	 * player is entering the lobby.
	 */
	/*private function lobbyEnter():Void
	{
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && _clientDisconnect == false)
		{trace("a");
			Reg._doOnce2 = false; 
			__scene_lobby.active = true;
			
			if (Reg._lobbyDisplay == true)
			{
				Reg._lobbyDisplay = false;
				__scene_lobby.display();
			}		
			
			__scene_lobby.visible = true;			
			__scene_lobby.__scrollable_area.visible = true;
			
			if (GameChatter.__scrollable_area2 != null
			&&	RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
			{
				GameChatter.__scrollable_area2.visible = true;
			}
			
			__scene_waiting_room.visible = false;
			__scene_waiting_room.active = false;
			__scene_create_room.visible = false;
		}
	}
	*/
	
	/******************************
	 * // everything inside this code block is ran when a game is first started.
	 */
	private function game_room_enter():Void
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
					
					__scene_waiting_room.__scrollable_area.visible = false;
					__scene_waiting_room.__scrollable_area.active = false;
					
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
												
						PlayState.send("Tournament Chess Standard 8 Put", RegTypedef._dataTournaments);
						
					}
				}
			}
			
			if (Reg._doStartGameOnce == true)
			{						
				Reg._doStartGameOnce = false;  // TODO does this var need to be anywhere?
				
				openSubState(new SceneTransition());
			}
		}
		
	}
	/******************************
	 * restart the game for either p1 vs computer or p1 vs p2,p3,p4.
	 */
	private function restartGame():Void
	{
		// offline.
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
			
			_lobbyRoomChat = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false; 
			RegTypedef._dataMisc._gameRoom = true;
			Reg._gameRoom = true;
			Reg._gameOverForPlayer = false;
			
			if (RegTypedef._dataTournaments._move_piece == false)
			{
				Reg._playerMoving = 0;
				Reg._playerNotMoving = 1;
			}
			
			Reg._gameHost = true;
			
			RegTypedef._dataMisc._room = 5;
			RegTypedef._dataMisc._roomState[3] = 6;
			
			Reg._playerCanMovePiece = true;
			Reg._playerMoving = 0;
								
			Reg._move_number_current = 0;
			Reg._move_number_next = 0;
			Reg._gameJumpTo = 0; 
		}
		
		// online.
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
			
			_lobbyRoomChat = false;
			Reg._loggedIn = true;
			Reg._doStartGameOnce = true;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			RegTypedef._dataMisc._gameRoom = true;
			Reg._gameRoom = true;
			InviteTable._ticks_invite_list = 0;
			
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
			
			Reg._hasUserConnectedToServer = true;
			
			if (RegTypedef._dataTournaments._move_piece == false)
				Reg._move_number_next = 0;
				
			// waiting room.
			if (GameChatter.__scrollable_area3 != null)
			{
				GameChatter.__scrollable_area3.visible = false;
				GameChatter.__scrollable_area3.active = false;			
			}
			
			Reg._doOnce = false;			
			Reg._lobbyDisplay = false;
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
		if (Reg._messageBoxNoUserInput != ""
		&&	Reg._outputMessage == true)
			openSubState( new MessageBoxNoUserInput());
	}
	
	/******************************
	 * changing scenes.
	 * lobby, creating room and waiting room are here.
	 */
	private function scene_trigger():Void
	{
		if (RegTriggers._lobby == true
		&& PlayState._clientDisconnect == false
		&& Reg._game_offline_vs_cpu == false
		|| RegTriggers._lobby == true
		&& PlayState._clientDisconnect == false
		&& Reg._game_offline_vs_player == false)
		{
			Reg._at_lobby = true;
			// lobby table starts at id 0. set first column as default.
			Reg._tc = 0;
			RegTriggers._lobby = false;
			RegTriggers._buttons_set_not_active = false;
			
			__scene_lobby.visible = false;
			
			if (Reg._lobbyDisplay == true)
			{
				Reg._lobbyDisplay = false;
				__scene_lobby.display();
			}		
			
			// title button at game room was clicked. if here then room data was updated. now go to the title scene.
			if (RegTriggers._return_to_title == true)
			{
				RegTriggers._return_to_title = false;
				Reg._disconnectNow = true;
			}
			
			if (__scene_game_room != null)
			{
				if (__scene_game_room.__player_time_remaining_move != null)
				{
					__scene_game_room.__player_time_remaining_move.destroy();
					__scene_game_room.__player_time_remaining_move = null;
				}
				
				remove(__scene_game_room);
			}
			
			PlayersLeftGameResetThoseVars.playerRepopulateTypedefPlayers();
			Reg._playerOffset = 0;
				
			Reg._clearDoubleMessage = false;
			Reg._game_online_vs_cpu = false;
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			
			__scene_create_room.visible = false;
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
			
			// this is needed to stop two room buttons highlighting simultaneously at lobby. remember lobby and waiting room share the same camera.
			__scene_waiting_room.__scrollable_area.scroll.y = 5000;
			
			__scene_waiting_room.__scrollable_area.visible = false;
			__scene_waiting_room.__scrollable_area.active = false;
			
			__scene_waiting_room.visible = false;					
			__scene_waiting_room.active = false;
			
			__scene_lobby.__scrollable_area.active = true;			
			__scene_lobby.__scrollable_area.visible = true;
			
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
			
			if (GameChatter == null)
				GameChatter._input_chat.active = true;
			
			__scene_lobby.set_active_for_buttons();			
			
			__scene_lobby.active = true;
			__scene_lobby.visible = true;
			
		}
		
		if (RegTriggers._createRoom == true)
		{
			Reg._at_create_room = true;
			RegTriggers._createRoom = false;
			Reg._clearDoubleMessage = false;
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
			
			openSubState(new SceneTransition());
		
		}
		
		
		if (RegTriggers.__scene_waiting_room == true)
		{
			Reg._at_lobby = false;
			// waiting room invite table starts at id 100.
			Reg._tc = 100; // default to the first table column.
			RegTriggers.__scene_waiting_room = false;
			Reg._clearDoubleMessage = false;
			RegTriggers._buttons_set_not_active = false;
			Reg._at_waiting_room = true;
			
			__scene_create_room.visible = false;
			__scene_create_room.active = false;			
			
			if (GameChatter.__scrollable_area2 != null)
			{
				GameChatter.__scrollable_area2.visible = false;
				GameChatter.__scrollable_area2.active = false;
			}
			
			// this is needed to stop two send buttons highlighting simultaneously at waiting room.
			__scene_lobby.__scrollable_area.scroll.y = 5000;
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
			
			openSubState(new SceneTransition());
		
		}

	}
	
	override public function destroy()
	{
		if (__action_keyboard != null)
		{
			remove(__action_keyboard);
			__action_keyboard.destroy();
			__action_keyboard = null;
		}
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
			__scene_background = null;
		}
		
		if (__hotkeys != null)
		{	
			remove(__hotkeys);
			__hotkeys.destroy();
			__hotkeys = null;
		}
		
		if (__scene_lobby != null)
		{	
			remove(__scene_lobby);
			__scene_lobby.destroy();
			__scene_lobby = null;
		}
		
		if (__scene_create_room != null)
		{	
			remove(__scene_create_room);
			__scene_create_room.destroy();
			__scene_create_room = null;
		}
		
		if (__scene_waiting_room != null)
		{	
			remove(__scene_waiting_room);
			__scene_waiting_room.destroy();
			__scene_waiting_room = null;
		}
		
		if (__scene_game_room != null)
		{	
			remove(__scene_game_room);
			__scene_game_room.destroy();
			__scene_game_room = null;
		}
		
		if (__network_events_main != null)
		{	
			remove(__network_events_main);
			__network_events_main.destroy();
			__network_events_main = null;
		}
		
		if (__ids_win_lose_or_draw != null)
		{	
			remove(__ids_win_lose_or_draw);
			__ids_win_lose_or_draw.destroy();
			__ids_win_lose_or_draw = null;
		}

		#if chess
			if (__chess_check_or_checkmate != null)
			{	
				remove(__chess_check_or_checkmate);
				__chess_check_or_checkmate.destroy();
				__chess_check_or_checkmate = null;
			}
		#end
		
		if (_text_logging_in != null)
		{	
			remove(_text_logging_in);
			_text_logging_in.destroy();
			_text_logging_in = null;
		}
		
		if (_msg != null)
		{	
			remove(_msg);
			_msg.destroy();
			_msg = null;
		}
		
		if (_text_client_login_data != null)
		{	
			remove(_text_client_login_data);
			_text_client_login_data.destroy();
			_text_client_login_data = null;
		}
		
		// websocket cannot be removed nor destroyed.
		if (_websocket != null)
		{	
			_websocket = null;
		}
		
		super.destroy();
	}
	
	/******************************
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		#if html5	
			if (RegTriggers._keyboard_open == true)
			{
				RegTriggers._keyboard_open = false;
				RegTriggers._keyboard_opened = true;

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
			}
			
			if (RegTriggers._keyboard_close == true)
			{
				RegTriggers._keyboard_close = false;

				if (__action_keyboard != null) 
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
				
			}
			
		#end
			
		// go to the client() function and connect to the server. If connected then define the events.
		if ( Reg._hasUserConnectedToServer == false
		&&	 Reg._alreadyOnlineUser == false) client();
		
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
						
						__title_bar.visible = false;
						
						if (__action_keyboard != null) 
						{
							__action_keyboard.close();
							remove(__action_keyboard);
							__action_keyboard = null;
						}
						
					}
					
				}
				
				// everything inside this code block is ran when a game is first started.
				game_room_enter();
				
				// restart the game for either p1 vs computer or p1 vs p2.
				if (Reg._playerLeftGame == false) restartGame();
				
			}
			
		}
		
		if (_ticks_lobby > 0 && _ticks_lobby < _ticks_lobby_maximum) 
			_ticks_lobby += 1;
			
		// user is sending logging in data to the server. do not use key/mouse click. that will stop some message box, their buttons, from firing.
		if (_ticks_lobby == _ticks_lobby_maximum)
		{
			if (Reg._isLoggingIn == true 
			&&	Reg._game_offline_vs_cpu == false
			&&	Reg._game_offline_vs_player == false)
			{
				Reg2._scrollable_area_is_scrolling = false;
				
				Reg._isLoggingIn = false; 
				
				// client at website is only for guest accounts.
				#if html5
					RegTypedef._dataAccount._guest_account = true;
				#else
					RegTypedef._dataAccount._guest_account = false;
				#end
				
				// TODO add a RegCustom here if bypass this code so that the user's avatar at website is used. see near bottom of server, is logging in event. that code also needs to be bypassed.
				RegTypedef._dataAccount._avatarNumber = RegCustom._profile_avatar_number1[Reg._tn];
				
				send("Is Logging In", RegTypedef._dataAccount); //events	
				
			}
		}
		
		// changing scenes. 
		// lobby, creating room and waiting room are here.
		scene_trigger();
		
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
		}
		
		// close room is locked message box
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "lock1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
		}
		
		// should message box be displayed?
		if (Reg._messageId > 0 && Reg._messageId != 1000000
		&&	Reg._messageId != Reg._message_id_temp
		&&	Reg._messageFocusId[Reg._messageFocusId.length-1] == Reg._messageId)
		{
			_msg = new IdsMessageBox();
			add(_msg);
		}
		
		if (Reg._outputMessage == true) gameMessage();
		
		super.update(elapsed);
		
		/*
		if (Reg._game_offline_vs_cpu == false
		&&  Reg._game_offline_vs_player == false 
		&&  _websocket != null
		||  Reg._game_online_vs_cpu == true
		&&  _websocket != null)
		{
			if (Reg._client_socket_is_connected == true)
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
		*/
		
		// at server the username is set to "nobody" when user logs off. the array element cannot be removed because handle id value always increments and the handle id value is used to get and set the username list.
		if (RegTypedef._dataAccount._username.toLowerCase() == "nobody")
		{
			Reg._username_banned = true;
			FlxG.switchState(new MenuState());
		}
		
		if (RegTypedef._dataAccount._ip == ""
		||	__network_events_main == null) return;
		
		// this block of code is also called from the end of the DisconnectFromUser event so that everything in that event is executed.
		if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			if (__network_events_main._closeSocket == true)
			{
				__network_events_main._closeSocket = false;
				
				if (Reg._client_socket_is_connected == true) 
				{
					Reg._client_socket_is_connected = false;
					_websocket.close();
				}
				
				FlxG.switchState(new MenuState());
			}
			
		}
			
		if (Reg._disconnectNow == true) 
		{
			if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				if (Reg._client_socket_is_connected == true) 
				{
					Reg._client_socket_is_connected = false;
					_websocket.close();
				}
			}
			
			Reg._serverDisconnected = false;
			FlxG.switchState(new MenuState());
			
		}
	}
	
}//