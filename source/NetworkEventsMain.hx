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
 * network events main.
 * @author kboardgames.com
 */

class NetworkEventsMain extends FlxState
{
	/******************************
	 * a user had pressed the ESC key. if player has lost game then when an event "Player Left Game Room" is called, this var will be used to stop the event "Lesser RoomState Value" from disconnecting player because the "Lose Game" event will be called later down the code.
	 * 
	 */
	private var _playerHasLostGame:Bool = false;
	
	public static var __scene_lobby:SceneLobby;		// class instance of lobby screen.
	public var __scene_create_room:SceneCreateRoom;			// class instance of creating room screen.
	public var __scene_waiting_room:SceneWaitingRoom;			// class instance of __scene_waiting_room.
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/******************************
	* closes the socket if true. there will be an error if closing within an event because the event code cannot continue if not connected, so this var is called in the event and this var "if true" is needed outside the event to close it.
	*/
	public var _closeSocket:Bool = false;
   
	/******************************
	* used to pass data to the server.
	*/
	private var _data:Dynamic; 
  	
	private var __network_events_ids:NetworkEventsIds;
	
	/******************************
	* when playing a game with 3 or more players, when 1 player requests a restart or draw, these vars increase by one when a player agrees or disagrees with that request. when _restartSayYes or _drawSayYes equals Reg._totalPlayersInRoom when a positive message will display else the request was rejected.
	*/
	private var _restartSayYes:Int = 0;
	
	/******************************
	* every time a player accepts or rejects a restart or draw, this var increases in total, until the maximum players in that room total the yes and no var of either _restartSay### or _drawSay###, at which time, a restart or draw will happen.
	*/
	private var _restartSayNo:Int = 0;
	
	/******************************
	* every time a player accepts or rejects a restart or draw, this var increases in total, until the maximum players in that room total the yes and no var of either _restartSay### or _drawSay###, at which time, a restart or draw will happen.
	*/
	private var _drawSayYes:Int = 0;
	
	/******************************
	* every time a player accepts or rejects a restart or draw, this var increases in total, until the maximum players in that room total the yes and no var of either _restartSay### or _drawSay###, at which time, a restart or draw will happen.
	*/
	private var _drawSayNo:Int = 0;
	

	override public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw, data:Dynamic, scene_lobby:SceneLobby, scene_create_room:SceneCreateRoom, scene_waiting_room:SceneWaitingRoom):Void
	{
		super();
		
		_data = data;
		
		__scene_lobby = scene_lobby;
		__scene_create_room = scene_create_room;
		__scene_waiting_room = scene_waiting_room;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
							
		// set a close event. If the server exits or crashes then do the following.
		PlayState.clientSocket.onConnectionClose = function (error:vendor.mphx.utils.Error.ClientError)
		{
			Reg._serverDisconnected = true;
			FlxG.switchState(new MenuState());
		}
		
			
		join();						// this function is called after this client connects to the server.
		disconnectByServer();		// then server is full, this event closes the client that tries to connect.
		disconnectAllByServer();	// disconnect all clients.
		messageAllByServer();		// send everyone everywhere, a message that the server will disconnect.
		isLoggingIn(); 				// the player is logging in.
		houseLoad();					// players house where they buy items, place items in room and vote for best house for prizes.
		getStatisticsWinLossDraw();	// Get Statistics Win Loss Draw, such as, wins and draws.
		getStatisticsAll();			// get all stats such as experience points, credits, wins, etc.
		greaterRoomStateValue();	// event player has entered the room, so change the roomState value.
		lesserRoomStateValue();		// event player has left the room, so change the roomState value.
		setRoomData(); 				// save room data to database. able to put user into room.
		getRoomData();				// load room data from database.
		returnedToLobby();			// return all vars to 0 for player, so that lobby data can be calculated to display data at lobby correctly.
		isRoomLocked();
		roomLock1();				// used to unlock the room at server and to stop entering a room the second time until ticks are used to update the lobby buttons at client. 
		getRoomPlayers();
		chatSend();					// the players chat message.
		gameMessageNotSender(); // an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party.
		gameMessageBoxForSpectatorWatching(); // Message box used for spectator Watching.
		messageKick();				// a command so that player cannot play for some time.
		messageBan();				// a command so that player cannot play again.
		
		drawOffer();				// offer draw so that it is a tie.
		drawAnsweredAs();			// draw reply.
		restartOffer();				// offer game restart so that another game can be played.
		restartAnsweredAs();		// chess restart reply.
		onlinePlayerOfferInvite();	// offer an invite to a player at the lobby.
		enterGameRoom();			// this event enters the game room.
		gameWin();					// win text using a message popup.
		gameLose();					// lose text using a message popup.
		gameWinThenLoseForOther();	// win text using a message popup then lose message box for the other player.
		gameLoseThenWinForOther();	// lose text using a message popup, then win message box for the other player.
		gameDraw();					// draw text using a message popup.
		saveWinStats();				// increase the win stat by 1.
		saveLoseStats();			// increase the lose stat by 1.
		saveWinStatsForBoth();		// increase the win stat by 1, and other player lose by 1.
		saveLoseStatsForBoth();		// increase the lose stat by 1 and the other player win by 1.
		saveDrawStats();			// increase the draw stat by 1.
		tournamentChessStandard8Get();			// gets the selected tournament data.
		tournamentChessStandard8Put();			// puts the selected tournament data to the MySQL database.
		playerLeftGameRoom();		// Trigger an event that the player has left the game room.
		playerLeftGame();			// Trigger an event that the player has left the game.
		gameIsFinished();			// save a var to mySql so that someone cannot invite when still in game room. also, triggers a var called Reg._gameOverForAllPlayers to equal true so that the game has ended for everyone.
		isGameFinished();			// false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
		gamePlayersValues();
		loggedInUsers();			// list of online players with stats. used to invite.
		actionByPlayer();			// refers to an action, eg, 1 = kick. see the "Action By Player" event at server.
		playerMoveTimeRemaining();	// gets the current move timer for the player that is moving. the value is sent to the other clients so that they have the update value.
		isActionNeededForPlayer();
		tradeProposalOffer();		// at signature game, a unit trade is proposed to a waiting to move player.
		tradeProposalAnsweredAs(); 	// what did the player answer as the trade request message box!
		
		spectatorWatching();		// user who requested to watch a game. this can be a message such as "checkmate" or "restarting game". also, any var needed to start or stop a game will be passed here.
		spectatorWatchingGetMoveNumber(); // send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
		moveHistoryNextEntry();		// every player that moves a piece will use the host of the room to call this event so to update the move history at MySQL. this is needed so that when a spectator watching enters the room, that person can get all the move history for that game.
		moveHistoryAllEntry();	// the spectator has just joined the game room because there is currently only one move in that users history, do this event to get all the moves in the move history for this game.
		leaderboards();
		dailyQuests(); // complete these daily quests for rewards.
		
		// more functions at PlayStateNetworkEventsIds.hx. this Ids function defines the events used depending on what game is played.
		__network_events_ids = new NetworkEventsIds(__ids_win_lose_or_draw);
		add(__network_events_ids);
		
  	}
	
	
	override public function destroy()
	{
		
		super.destroy();
	}
	
	/******************************
	 * EVENT JOIN	
	 */
	public function join():Void
	{
		PlayState.clientSocket.events.on("Join",function (_data){
			if (_data.id != RegTypedef._dataAccount.id) return;
			
			PlayState._text_server_login_data.text += "Server Data.\n\n";
			PlayState._text_server_login_data.text += "Clients connected: " + Std.string(_data._clients_connected) + ".\n";
			PlayState._text_server_login_data.text += "Send data immediately: " + Std.string(_data._server_fast_send) + ".\n";
			PlayState._text_server_login_data.text += "Blocking: " + Std.string(_data._server_blocking) + ".\n";
			
			
			PlayState._text_client_login_data.text += "Clients Data.\n\n";
			PlayState._text_client_login_data.text += "Welcome: " + RegTypedef._dataAccount._username + ".\n";
			PlayState._text_client_login_data.text += ""
				+ "Last known IP: " + _data._ip + ".\n";
			
			RegTypedef._dataAccount = _data;
			RegTypedef._dataAccount._alreadyOnlineHost = _data._alreadyOnlineHost;
			
			// if _alreadyOnlineHost equals true that than means there is already a client opened at that device.
			if ( RegTypedef._dataAccount._alreadyOnlineHost == true && Reg._loginMoreThanOnce == false)
			{
				Reg._alreadyOnlineHost = true;
				Reg._displayOneDeviceErrorMessage = true; // prepare to show the error message.	At MenuState, if this var is true then a message about devices will be displayed.

				PlayState.clientSocket.close();
				FlxG.switchState(new MenuState());
			}
			
			else 
			{
				Reg._isLoggingIn = true;
			}
		});	
	}	
		
	/******************************
	* EVENT DISCONNECT BY SERVER
	*/
	public function disconnectByServer():Void
	{
		PlayState.clientSocket.events.on("DisconnectByServer", function (_data)
		{
			if (_data.id == RegTypedef._dataMisc.id)
			{
				Reg._serverDisconnected = true;
				PlayState.clientSocket.close();			
				FlxG.switchState(new MenuState());
			}
		});	
	}
	
	/******************************
	* EVENT DISCONNECT BY SERVER
	*/
	public function disconnectAllByServer():Void
	{
		PlayState.clientSocket.events.on("Disconnect All By Server", function (_data)
		{
			Reg._serverDisconnected = true;
			PlayState.clientSocket.close();			
			FlxG.switchState(new MenuState());
		});	
	}
	
	/******************************
	* EVENT SERVER WILL SOON DISCONNECT. SEND MESSAGE To ALL CLIENT.
	* DataQuestions
	*/
	public function messageAllByServer():Void
	{
		PlayState.clientSocket.events.on("Message All By Server", function (_data)
		{
			Reg._messageId = 2222;
			Reg._buttonCodeValues = "l2222";
			SceneGameRoom.messageBoxMessageOrder();
			
			Reg._server_message = _data;
		});	
	}
	
	/******************************
	* EVENT IS LOGGED IN
	*/
	public function isLoggingIn():Void
	{
		PlayState.clientSocket.events.on("Is Logging In", function (_data)
		{			
			// if _alreadyOnlineHost equals true that than means there is already a user logged in with that name.
			RegTypedef._dataAccount._alreadyOnlineUser = _data._alreadyOnlineUser;
			
			if ( RegTypedef._dataAccount._alreadyOnlineUser == true && Reg._loginMoreThanOnce == false)
			{
				Reg._alreadyOnlineUser = true;
				Reg._displayOneDeviceErrorMessage = true; // prepare to show the error message.	At MenuState, if this var is true then a message about devices will be displayed.
				
				PlayState.clientSocket.close();
				FlxG.switchState(new MenuState());
			}
			
			else if (Reg._alreadyOnlineUser == false)
			{
				if (_data._popupMessage == "Login failed.")
				{
					Reg._login_failed = true;
					PlayState.clientSocket.close();
					
					FlxG.switchState(new MenuState());
					
				}
				
				else if (_data._popupMessage == "Login successful.") // if you change the value of this string then you need to change it also at server.
				{
					Reg2._username_last_remembered = Reg._username = RegTypedef._dataAccount._username = RegTypedef._dataMisc._username = RegTypedef._dataHouse._username = _data._username;
					
					PlayState.allTypedefUsernameUpdate(_data._username);
					
					Reg._loggedIn = true; 
					Reg._loginSuccessfulWasRead = true; 
					Reg._doOnce = true;
				
					PlayState.allTypedefUsernameUpdate(Reg._username);
										
					PlayState.clientSocket.send("Get Statistics All", RegTypedef._dataStatistics);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
			
		});	
	}
		
	/******************************
	* EVENT HOUSE LOAD.
	* players house where they buy items, place items in room and vote for best house for prizes.
	* _dataHouse
	*/
	private function houseLoad():Void
	{
		PlayState.clientSocket.events.on("House Load", function (_data)
		{			
			RegTypedef._dataHouse._sprite_number = Std.string(_data._sprite_number);
			RegTypedef._dataHouse._sprite_name = Std.string(_data._sprite_name);
			RegTypedef._dataHouse._items_x = Std.string(_data._items_x);
			RegTypedef._dataHouse._items_y = Std.string(_data._items_y);
			RegTypedef._dataHouse._map_x = Std.string(_data._map_x);
			RegTypedef._dataHouse._map_y = Std.string(_data._map_y);
			RegTypedef._dataHouse._is_item_purchased = Std.string(_data._is_item_purchased);
			RegTypedef._dataHouse._item_direction_facing = Std.string(_data._item_direction_facing);
			RegTypedef._dataHouse._map_offset_x = Std.string(_data._map_offset_x);
			RegTypedef._dataHouse._map_offset_y = Std.string(_data._map_offset_y);
			RegTypedef._dataHouse._item_is_hidden = Std.string(_data._item_is_hidden);
			RegTypedef._dataHouse._item_order = Std.string(_data._item_order);
			RegTypedef._dataHouse._item_behind_walls = Std.string(_data._item_behind_walls);
			RegTypedef._dataHouse._floor = Std.string(_data._floor);
			RegTypedef._dataHouse._wall_left = Std.string(_data._wall_left);
			RegTypedef._dataHouse._wall_up_behind = Std.string(_data._wall_up_behind);
			RegTypedef._dataHouse._wall_up_in_front = Std.string(_data._wall_up_in_front);
			RegTypedef._dataHouse._floor = Std.string(_data._floor);
			RegTypedef._dataHouse._wall_left_is_hidden = Std.string(_data._wall_left_is_hidden);
			RegTypedef._dataHouse._wall_up_behind_is_hidden = Std.string(_data._wall_up_behind_is_hidden);
			RegTypedef._dataHouse._wall_up_in_front_is_hidden = Std.string(_data._wall_up_in_front_is_hidden);
			
			if (RegTypedef._dataHouse._sprite_number != "")
			{
				
				var _str = RegTypedef._dataHouse._sprite_number.split(",");
				_str.pop();
				var _str2 = RegTypedef._dataHouse._sprite_name.split(",");
				_str2.pop();
				
				RegHouse._namesPurchased.pop();
				
				for (i in 0..._str.length)
				{
					RegHouse._sprite_number.push(Std.parseInt(_str[i]));
					RegHouse._namesPurchased.push(_str2[i]);
				}
				
				RegHouse._namesPurchased.unshift("No item selected.");
				
				var _str = RegTypedef._dataHouse._items_x.split(",");
				_str.pop();
				var _str2 = RegTypedef._dataHouse._items_y.split(",");
				_str2.pop();
				var _str3 = RegTypedef._dataHouse._map_x.split(",");
				_str3.pop();
				var _str4 = RegTypedef._dataHouse._map_y.split(",");
				_str4.pop();
				var _str5 = RegTypedef._dataHouse._is_item_purchased.split(",");
				_str5.pop();
				var _str6 = RegTypedef._dataHouse._item_direction_facing.split(",");
				_str6.pop();
				var _str7 = RegTypedef._dataHouse._map_offset_x.split(",");
				_str7.pop();
				var _str8 = RegTypedef._dataHouse._map_offset_y.split(",");
				_str8.pop();
				var _str9 = RegTypedef._dataHouse._item_is_hidden.split(",");
				_str9.pop();
				var _str10 = RegTypedef._dataHouse._item_order.split(",");
				_str10.pop();
				var _str11 = RegTypedef._dataHouse._item_behind_walls.split(",");
				_str11.pop();
				
				for (i in 0..._str.length)
				{
					RegHouse._items_x[i] = Std.parseFloat(_str[i]);
					RegHouse._items_y[i] = Std.parseFloat(_str2[i]);
					RegHouse._map_x[i] = Std.parseFloat(_str3[i]);
					RegHouse._map_y[i] = Std.parseFloat(_str4[i]);
					RegHouse._is_item_purchased[i] = Std.parseInt(_str5[i]);
					RegHouse._item_direction_facing[i] = Std.parseInt(_str6[i]);
					RegHouse._map_offset_x[i] = Std.parseInt(_str7[i]);
					RegHouse._map_offset_y[i] = Std.parseInt(_str8[i]);
					RegHouse._item_is_hidden[i] = Std.parseInt(_str9[i]);
					RegHouse._item_order[i] = Std.parseInt(_str10[i]);
					RegHouse._item_behind_walls[i] = Std.parseInt(_str11[i]);
				}
				
			}
			
			if (RegTypedef._dataHouse._floor != "")
			{
				var _str = RegTypedef._dataHouse._floor.split(",");
				_str.pop();
				var _str2 = RegTypedef._dataHouse._wall_left.split(",");
				_str2.pop();
				var _str3 = RegTypedef._dataHouse._wall_left_is_hidden.split(",");
				_str3.pop();
				var _str4 = RegTypedef._dataHouse._wall_up_behind.split(",");
				_str4.pop();
				var _str5 = RegTypedef._dataHouse._wall_up_behind_is_hidden.split(",");
				_str5.pop();
				var _str6 = RegTypedef._dataHouse._wall_up_in_front.split(",");
				_str6.pop();
				var _str7 = RegTypedef._dataHouse._wall_up_in_front_is_hidden.split(",");
				_str7.pop();
				
				var i:Int = -1;
				
				for (x in 0...11)
				{
					for (y in 0...22)
					{
						i += 1;
						
						RegHouse._floor[x][y] = Std.parseInt(_str[i]);
						RegHouse._wall_left[x][y] = Std.parseInt(_str2[i]);
						RegHouse._wall_left_is_hidden[x][y] = Std.parseInt(_str3[i]);
						RegHouse._wall_up_behind[x][y] = Std.parseInt(_str4[i]);
						RegHouse._wall_up_is_hidden[1][x][y] = Std.parseInt(_str5[i]);
						RegHouse._wall_up_in_front[x][y] = Std.parseInt(_str6[i]);
						RegHouse._wall_up_is_hidden[0][x][y] = Std.parseInt(_str7[i]);
					}
				}
			}
			
			RegTriggers._new_the_house = true;
			
			
			RegTypedef._dataMisc._roomCheckForLock[0] = 0;
			PlayState.clientSocket.send("Get Room Data", RegTypedef._dataMisc);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			#if html5
				RegTypedef._dataStatistics._houseCoins = 1000;
			#end
				
		});
	}
		
	/******************************
	* EVENT PLAYER MOVE TIME REMAINING
	* Gets the current move timer for the player that is moving. the value is sent to the other clients so that they have the update value.
	*/
	public function playerMoveTimeRemaining():Void
	{
		PlayState.clientSocket.events.on("Player Move Time Remaining", function (_data)
		{
			// only for players in the same room but not for the player who sent the data.
			if (_data._room == RegTypedef._dataPlayers._room && _data.id != RegTypedef._dataPlayers.id)
			{
				RegTypedef._dataPlayers._moveTimeRemaining[0] = RegTypedef._dataStatistics._moveTimeRemaining[0] = _data._moveTimeRemaining[0];
								
				RegTypedef._dataPlayers._moveTimeRemaining[1] = RegTypedef._dataStatistics._moveTimeRemaining[1] =  _data._moveTimeRemaining[1];
				
				RegTypedef._dataPlayers._moveTimeRemaining[2] = RegTypedef._dataStatistics._moveTimeRemaining[2] = _data._moveTimeRemaining[2];
				
				RegTypedef._dataPlayers._moveTimeRemaining[3] = RegTypedef._dataStatistics._moveTimeRemaining[3] = _data._moveTimeRemaining[3];
				
			}
		});	
	}
			
	/******************************
	* EVENT GAME MESSAGE.	
	* send a general message such as check or checkmate to the other player.
	* _dataGameMessage
	*/
	public function gameMessageNotSender():Void
	{
		PlayState.clientSocket.events.on("Game Message Not Sender", function (_data)
		{
			if (_data._room == RegTypedef._dataGameMessage._room && _data.id != RegTypedef._dataGameMessage.id && Reg._gameOverForPlayer == false)
			{
				Reg._gameMessage = _data._gameMessage;		

				if (Reg._gameMessage == "Roll dice again.")
				{
					RegTriggers._snakesAndLaddersRollAgainMessage = true;		
				}
				
				
				else if (Reg._gameMessage == "Check" && Reg._chessCheckBypass == false) 
				{
					GameHistoryAndNotations._messageForBoxScroller.text = GameHistoryAndNotations._messageForBoxScroller.text.substr(0, GameHistoryAndNotations._messageForBoxScroller.text.length);
					
					GameHistoryAndNotations._messageForBoxScroller.text = GameHistoryAndNotations._messageForBoxScroller.text + "+";
				}
				
				if (Reg._gameMessage == "Checkmate" && Reg._chessCheckBypass == false) 
				{
					GameHistoryAndNotations._messageForBoxScroller.text = GameHistoryAndNotations._messageForBoxScroller.text.substr(0, GameHistoryAndNotations._messageForBoxScroller.text.length);
					
					GameHistoryAndNotations._messageForBoxScroller.text = GameHistoryAndNotations._messageForBoxScroller.text + "++";
				}
								
				if (Reg._gameMessage != "") 
				{					
					RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
				}			
						
				Reg._outputMessage = true;
			}// else Reg._rolledA6 = false;
				
		});	
	}
		
	/******************************
	* EVENT GAME MESSAGE.	
	* send a general message such as check or checkmate to the other player.
	* _dataGameMessage
	*/
	public function gameMessageBoxForSpectatorWatching():Void
	{
		PlayState.clientSocket.events.on("Game Message Box For Spectator Watching", function (_data)
		{
			if (RegTypedef._dataMisc._spectatorWatching == true)
			{
				RegTypedef._dataGameMessage._userFrom = _data._userFrom;
				RegTypedef._dataGameMessage._gameMessage = _data._gameMessage;
				RegTriggers._eventSpectatorWatchingMessageBoxMessages = true;
			}
		});	
	}
	
	/******************************
	* EVENT MESSAGE KICK.	
	* admin sent a kick command so that the user cannot play for some time.
	*/
	public function messageKick():Void
	{
		PlayState.clientSocket.events.on("Message Kick", function (_data)
		{
			// if at this line then server sent client here because user is kicked.
			var text:String = Std.string( _data._clientCommandUsers);
			var paragraph = text.split(",");
			
			var text2:String = Std.string(_data._clientCommandMessage);
			var paragraph2 = text2.split(",");
			
			for (i in 0...paragraph.length)
			{
				if (paragraph[i] == RegTypedef._dataAccount._username)
				{
					paragraph2[i] = StringTools.replace(paragraph2[i], "{a}", "Kicked. Reason: ");
					paragraph2[i] = StringTools.replace(paragraph2[i], "{b}", " minutes remaining.");				
					Reg._kickOrBanMessage = paragraph2[i];
					Reg._disconnectNow = true;
					RegTriggers._kickOrBan = true;
				}
			}	
			
			// remove is_kick from player.
			if (RegTriggers._kickOrBan == false)
			{
				PlayState.clientSocket.send("Remove Kicked From User", RegTypedef._dataMisc);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
		});	
	}
	
	/******************************
	* EVENT MESSAGE BAN.	
	* admin sent a ban command so that the user cannot play this game anymore.
	*/
	public function messageBan():Void
	{
		PlayState.clientSocket.events.on("Message Ban", function (_data)
		{
			// if at this line then server sent client here because user is kicked.
			var text:String = Std.string(_data._username);
			var paragraph = text.split(",");
			
			var text2:String = Std.string(_data._clientCommandIPs);
			var paragraph2 = text2.split(",");
			
			var text3:String = Std.string(_data._clientCommandMessage);
			var paragraph3 = text3.split(",");
			
			for (i in 0...paragraph.length)
			{	
				if (paragraph[i] == RegTypedef._dataAccount._username)
				{
					paragraph3[i] = StringTools.replace(paragraph3[i], "{c}", "Banned by domain. Reason: ");		
					Reg._kickOrBanMessage = paragraph3[i];
					Reg._disconnectNow = true;
					RegTriggers._kickOrBan = true;
				}
			}		
			
			PlayState.clientSocket.send("Message Kick", RegTypedef._dataMisc);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		});	
	}
	
	/******************************
	* EVENT CHAT SEND.
	* send chat text to other user using chatter
	* _dataMisc
	*/
	public function chatSend():Void
	{
		PlayState.clientSocket.events.on("Chat Send", function (_data)
		{	
			if (RegTypedef._dataPlayers._usernamesDynamic[0] == _data._username
			 || RegTypedef._dataPlayers._usernamesDynamic[1] == _data._username
			 || RegTypedef._dataPlayers._usernamesDynamic[2] == _data._username
			 || RegTypedef._dataPlayers._usernamesDynamic[3] == _data._username
			 || RegTypedef._dataMisc._userLocation == 0 )
			 {
				// THIS CODE WILL NOT WORK UNLESS THE ABOVE USES STD.
				// both player receive this same text from the _username that sent the data _chat. 
				if (RegTypedef._dataMisc._userLocation == 0)
				{
					SceneLobby.__game_chatter.chatSent(_data._username + ": ", _data._chat);
				}
				
				else if (RegTypedef._dataMisc._userLocation > 0 
				&&		 RegTypedef._dataMisc._userLocation < 3)
				{
					SceneWaitingRoom.__game_chatter.chatSent(_data._username + ": ", _data._chat);
				}
				
				else SceneGameRoom.__game_chatter.chatSent(_data._username + ": ", _data._chat);
			}
		});
	}
	
	/******************************
	* EVENT GET STATISTICS WIN LOSS DRAW
	* gets the Win - Draw - Loss Stats for player(s).
	* _dataPlayers
	*/
	public function getStatisticsWinLossDraw():Void
	{
		PlayState.clientSocket.events.on("Get Statistics Win Loss Draw", function (_data)
		{
			if (RegTypedef._dataMisc._userLocation == 2 
			&&  _data._spectatorWatching == false
			||  _data._spectatorWatching == true
			&&  RegTypedef._dataTournaments._move_piece == false
			)
			{
				RegTypedef._dataPlayers._usernamesDynamic = _data._usernamesDynamic;
				
				RegTypedef._dataPlayers._usernamesStatic = RegTypedef._dataPlayers._usernamesDynamic.copy();
				
				RegTypedef._dataPlayers._gamesAllTotalWins = _data._gamesAllTotalWins;
				RegTypedef._dataPlayers._gamesAllTotalLosses = _data._gamesAllTotalLosses;
				RegTypedef._dataPlayers._gamesAllTotalDraws = _data._gamesAllTotalDraws;
				RegTypedef._dataPlayers._cash = _data._cash;
				RegTypedef._dataPlayers._avatarNumber = _data._avatarNumber;
									
				if (RegTypedef._dataMisc._userLocation < 3) 
				{
					RegTypedef._dataPlayers._usernamesStatic = RegTypedef._dataPlayers._usernamesDynamic;
					
					// used for bug tracking. see function receive() at TcpClient.
					//RegTypedef._dataOnlinePlayers._triggerEvent = "foo";
					if (_data.id == RegTypedef._dataPlayers.id)
					{
						PlayState.clientSocket.send("Logged In Users", RegTypedef._dataOnlinePlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
					}
					
					else
					{
						if (RegTypedef._dataMisc._userLocation > 0)	
						{
							__scene_waiting_room.mainButtonsAndTexts();
							SceneWaitingRoom.updateUsersInRoom();					}
						
					}
					
					
					__scene_waiting_room.__menu_bar._button_refresh_list.active = true;
					__scene_waiting_room.__menu_bar._button_refresh_list.visible = true;	
					
					__scene_waiting_room.__menu_bar._button_return_to_lobby_from_waiting_room.active = true;
					__scene_waiting_room.__menu_bar._button_return_to_lobby_from_waiting_room.visible = true;
					
				}
				
				else
				{					
					// player clicked the "watch game" button and is entering the room.
					if (_data.id == RegTypedef._dataPlayers.id 
					&&  _data._spectatorWatching == true)
					{
						
						// these three lines might not be needed but should be testing when removed. to test do a 2 player game. log into the game room when have the game watcher join. test the features of the game watcher.
						var _tempUsername = RegTypedef._dataMisc._username;
						//RegTypedef._dataPlayers._username = RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room];
						RegTypedef._dataPlayers._username = _tempUsername;
						
						Reg._gameHost = false;
						Reg._gameOverForPlayer = true;
						Reg._gameOverForAllPlayers = true;
						
						Reg._totalPlayersInRoom = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] - 1;
						
						
						// stop any sound playing.			
						if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();
						
						Reg._playerCanMovePiece = false;	
						//Reg._createGameRoom = true;
						
						PlayState._clientDisconnectDo = false;
						PlayState.clientSocket.send("Is Game Finished", RegTypedef._dataPlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
					}
					
				}
				
			}
			
			else
			{
				RegTypedef._dataPlayers._gamesAllTotalWins = _data._gamesAllTotalWins;
				RegTypedef._dataPlayers._gamesAllTotalLosses = _data._gamesAllTotalLosses;
				RegTypedef._dataPlayers._gamesAllTotalDraws = _data._gamesAllTotalDraws;
				RegTypedef._dataPlayers._cash = _data._cash;
				RegTypedef._dataPlayers._avatarNumber = _data._avatarNumber;
			}
			
			// user is disconnecting by pressing the esc key
			if (_data.id == RegTypedef._dataPlayers.id 
			&&   PlayState._clientDisconnect == true
			&&   PlayState._clientDisconnectDo == true)
				PlayState.disconnectByESC();
		
		});
	}
		
	/******************************
	* EVENT GET STATISTICS All
	* Example, experience points, credits, win - draw - loss, all stats.
	* _dataPlayers
	*/
	public function getStatisticsAll():Void
	{
		PlayState.clientSocket.events.on("Get Statistics All", function (_data)
		{
			RegTypedef._dataStatistics = _data;
			
			if (Reg2._miscMenuIparameter == 30)
				RegTriggers._miscellaneousMenuOutputClassActive = true;
				
			SceneLobby._lobby_data_received = false;
		});
	}
		
	/******************************
	* EVENT PLAYER HAS ENTERED THE ROOM, SO CHANGE THE RoomSTATE.
	* _miscData
	*/
	public function greaterRoomStateValue():Void
	{
		PlayState.clientSocket.events.on("Greater RoomState Value", function (_data)
		{
			if (_data.id == RegTypedef._dataMisc.id)
			{
				RegTypedef._dataMisc = _data; // _data give an invalid call error.
				
				if (_data._roomLockMessage == "" && _data._userLocation <= 2)
				{
					_data._roomState[_data._room] += 1;
					
					PlayState.clientSocket.send("Set Room Data", _data);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
					
					if (__scene_create_room.__menu_bar._buttonCreateRoom.visible == true)
						_data._roomState[_data._room] -= 1;
				}
				
				else 
				{
					PlayState.clientSocket.send("Set Room Data", _data);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
				
				// this code needs to stay here. if moved up top a room cannot be entered. the _data._roomState above changes this value.
				Reg._currentRoomState = _data._roomState[_data._room];
				
				RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
				Reg._playerIDs = -1;
				
				
				
			}			
		});
	}
	
	/******************************
	* EVENT PLAYER HAS LEFT THE ROOM, SO CHANGE THE RoomSTATE.
	* _dataMisc
	*/
	public function lesserRoomStateValue():Void
	{
		PlayState.clientSocket.events.on("Lesser RoomState Value", function (_data)
		{
			if (_data.id == RegTypedef._dataMisc.id)
			{
				RegTypedef._dataMisc._roomLockMessage = "";
				RegTypedef._dataMisc._roomState = _data._roomState;
				RegTypedef._dataMisc._roomState[_data._room] = 0;
				RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;
				RegTypedef._dataMisc._roomPlayerLimit[_data._room] = 0;
				RegTypedef._dataMisc._room = 0;
				PlayState.allTypedefRoomUpdate(RegTypedef._dataMisc._room);
				
				RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;
				RegTypedef._dataMisc._roomHostUsername = _data._roomHostUsername;
				RegTypedef._dataMisc._gid = _data._gid;
				RegTypedef._dataMisc._allowSpectators = _data._allowSpectators;
				RegTypedef._dataMisc._userLocation = _data._userLocation;
				RegTypedef._dataPlayers._spectatorPlaying = false;
				
				for (i in 0...4)
				{
					RegTypedef._dataPlayers._moveTimeRemaining.pop();
					RegTypedef._dataPlayers._gamesAllTotalWins.pop();
					RegTypedef._dataPlayers._gamesAllTotalLosses.pop();
					RegTypedef._dataPlayers._gamesAllTotalDraws.pop();
				}
				
				// player left, so clear these data.
				for (i in 0...4)
				{
					RegTypedef._dataPlayers._usernamesDynamic[i] = "";
					RegTypedef._dataPlayers._usernamesStatic[i] = "";
					RegTypedef._dataPlayers._gamePlayersValues[i] = 0;
					RegTypedef._dataPlayers._moveNumberDynamic[i] = 0;
					RegTypedef._dataPlayers._moveTimeRemaining.push(0);
					RegTypedef._dataPlayers._gamesAllTotalWins.push(0);
					RegTypedef._dataPlayers._gamesAllTotalLosses.push(0);
					RegTypedef._dataPlayers._gamesAllTotalDraws.push(0);
				}
				
				Reg._roomPlayerLimit = 0;
				Reg._currentRoomState = 0;
				
				__scene_create_room.__menu_bar._buttonReturnToLobby.visible = false;
				__scene_create_room.__menu_bar._buttonReturnToLobby.active = false;
				
				__scene_create_room.__menu_bar._buttonCreateRoom.visible = false;
				__scene_create_room.__menu_bar._buttonCreateRoom.active = false;
	
				RegTypedef._dataMisc._room = 0; // returning to the lobby
				RegTypedef._dataMisc._userLocation = 0;
						
				// event at lobby, so return all vars to 0 for player, so that lobby data can be calculated to display data at lobby correctly.				
				PlayState.clientSocket.send("Returned To Lobby", 	RegTypedef._dataMisc); 
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			else if (RegTypedef._dataMisc._userLocation == 2)
			{
				// if here then a player left the waiting room. this is the other player. we use this var to find the other player's name is the _usernamesDynamic array.
				var _count:Int = -1;
				
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._usernamesDynamic[i] == _data._username)
					{
						_count = i;
					}
				}
				
				if (_count > -1)
				{
					// now that the _username is found we remove that player from the other players arrays.
					RegTypedef._dataPlayers._usernamesDynamic.splice(_count, 1);
					// we push the array because one element has just been removed. now we need to added it back so to always hold a total of four players data.
					RegTypedef._dataPlayers._usernamesDynamic.push("");
										
					RegTypedef._dataPlayers._gamesAllTotalWins.splice(_count, 1);
					RegTypedef._dataPlayers._gamesAllTotalWins.push(0);
					
					RegTypedef._dataPlayers._gamesAllTotalLosses.splice(_count, 1);
					RegTypedef._dataPlayers._gamesAllTotalLosses.push(0);
					
					RegTypedef._dataPlayers._gamesAllTotalDraws.splice(_count, 1);
					RegTypedef._dataPlayers._gamesAllTotalDraws.push(0);
					
					RegTypedef._dataPlayers._cash.splice(_count, 1);
					RegTypedef._dataPlayers._cash.push(7000);
					
					__scene_waiting_room.mainButtonsAndTexts();
				}
				
			}
			
			// user is disconnecting by pressing the esc key
			if (_data.id == RegTypedef._dataPlayers.id 
			&&   PlayState._clientDisconnect == true
			&&   PlayState._clientDisconnectDo == true)
				PlayState.disconnectByESC();
				
			// anything added below this line, remember that we are at lobby but _data_room data does not equal 0. the reason is anyone at lobby can set back a room to zero. see the code block above this line.
		});
	}
	/*####################################################################################################
	* EVENT SET ROOM DATA. SAVE ROOM DATA TO DATABASE.
	* _miscData
	*/
	public function setRoomData():Void
	{
		PlayState.clientSocket.events.on("Set Room Data", function (_data)
		{
			if (Reg._playerLeftGame == false)
			{
				RegTypedef._dataMisc._roomState = _data._roomState;
				RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;		
				RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;
				RegTypedef._dataMisc._roomHostUsername = _data._roomHostUsername;
				RegTypedef._dataMisc._gid = _data._gid;
				RegTypedef._dataMisc._allowSpectators = _data._allowSpectators; 
				
				//PlayState.clientSocket.send("Get Room Data", _data); // update data for lobby.
				//haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				if (Reg._game_online_vs_cpu == false)
				{
					if (RegTypedef._dataPlayers._spectatorWatching == true)
					{
						
						PlayState.clientSocket.send("Move History All Entry", RegTypedef._dataMovement); 
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
						
					}
					
					else if (__scene_create_room.__menu_bar._buttonCreateRoom.visible == false 
					&&  Reg._currentRoomState == 2)
					{
						__scene_create_room.__menu_bar._buttonReturnToLobby.active = true;
						__scene_create_room.__menu_bar._buttonReturnToLobby.visible = true;
						
						__scene_create_room.__menu_bar._buttonCreateRoom.active = true;
						__scene_create_room.__menu_bar._buttonCreateRoom.visible = true; 
						
						RegTriggers._createRoom = true;
						

					}
					
					else if (Reg._currentRoomState > 1
					&&  Reg._currentRoomState < 7)
					{
						//__scene_create_room._buttonCreateRoom.visible = false;
						__scene_create_room.__menu_bar._buttonReturnToLobby.active = false;
						__scene_create_room.__menu_bar._buttonCreateRoom.active = false;
						
						RegTriggers.__scene_waiting_room = true;
					}
				} 
				
				else if (RegTypedef._dataPlayers._spectatorWatching == false)
				{
					Reg._createGameRoom = true;
				}
			}
			
		});
	}
	
	
	/*####################################################################################################
	* EVENT GET ROOM Data. LOAD ROOM DATA FROM DATABASE.
	USED AT LOBBY TO GET ROOM DATA.
	* _dataMisc
	*/
	public function getRoomData():Void
	{
		PlayState.clientSocket.events.on("Get Room Data", function (_data)
		{
			RegTypedef._dataMisc._roomState = _data._roomState; 
						
			RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;
			
			// never get a value of -1 or there will be a server error when saving stats.
			if (RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] > -1)
			{
				RegTypedef._dataPlayers._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
			}
										
			RegTypedef._dataMisc._roomHostUsername = _data._roomHostUsername;
			RegTypedef._dataMisc._gid = _data._gid;
			
			// if room is empty, set the game playing text beside room button to empty.
			for (i in 0...27)
			{
				if (RegTypedef._dataMisc._roomState[i] == 0) 
				RegTypedef._dataMisc._roomGameIds[i] = -1;
			}
			
			
			RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;
			RegTypedef._dataMisc._roomPlayerCurrentTotal = _data._roomPlayerCurrentTotal;
	
			RegTypedef._dataMisc._vsComputer = _data._vsComputer;
			RegTypedef._dataMisc._allowSpectators = _data._allowSpectators;
	
			if (RegTypedef._dataMisc._userLocation == 2)
			{
				//RegTypedef._dataMisc._roomHostUsername[_data._room] = RegTypedef._dataPlayers._usernamesDynamic[0];
				
				// this code seems to work with the above commented.
				Reg._roomPlayerLimit = RegTypedef._dataMisc._roomPlayerLimit[_data._room];
				
			}
			
			// at lobby?
			if (RegTypedef._dataMisc._userLocation == 0)
			{
				SceneLobby._lobby_data_received = true;
			}
						
			// admin banned or kicked user events.
			//PlayState.clientSocket.send("Message Ban", RegTypedef._dataMisc);
			//haxe.Timer.delay(function (){}, Reg2._event_sleep);
		});
	}
	
	/*####################################################################################################
	* RETURN ALL VARS TO 0 FOR PLAYER, SO THAT LOBBY DATA CAN BE CALCULATED TO DISPLAY DATA AT LOBBY CORRECTLY.
	*/
	public function returnedToLobby():Void
	{
		PlayState.clientSocket.events.on("Returned To Lobby", function (_data)
		{
			PlayState.clientSocket.send("Get Room Data", RegTypedef._dataMisc);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		});
	}
	
	// miscData
	public function isRoomLocked():Void
	{
		PlayState.clientSocket.events.on("Is Room Locked", function (_data)
		{
			if (_data.id == RegTypedef._dataMisc.id)
			{
				if (_data._roomLockMessage == "")
				{
					PlayState.clientSocket.send("Greater RoomState Value", _data);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
				
				// if at lobby and room is locked then display message.
				else if (Reg._at_create_room == false && Reg._at_waiting_room == false)
				{
					//ActionInput.enable();

					// send the message that the room is locked.
					Reg._messageId = 1002;
					Reg._buttonCodeValues = "lock1000";
					SceneGameRoom.messageBoxMessageOrder();	
					RegTypedef._dataMisc._roomLockMessage = _data._roomLockMessage;
					
				}	
			}
			
			
		});
	}
	
	/******************************
	* EVENT ROOM LOCK. used to unlock the room at server and to stop entering a room the second time until ticks are used to update the lobby buttons at client. 
	* miscData
	*/
	public function roomLock1():Void
	{
		PlayState.clientSocket.events.on("Room Lock 1", function (_data)
		{
			RegTypedef._dataMisc._roomLockMessage = "";
			RegTypedef._dataMisc._roomCheckForLock[_data._room] = 0;
			
			PlayState.clientSocket.send("Room Lock 2", _data);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		});
	}
		
	/******************************
	* EVENT GET ROOM PLAYERS. IF this does not work then set back to broadcast this event to every one at server. see: OnlinePlayerOfferInvite event at server for the example.
	*/
	public function getRoomPlayers():Void
	{
		PlayState.clientSocket.events.on("Get Room Players", function (_data)
		{
			if (_data.id == RegTypedef._dataMisc.id) 
			{
				RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit; // this looks wrong but remember that server is passing _roomPlayerLimit to a room and not to everyone.
				RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;

				PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
		});
	}
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function drawOffer():Void
	{
		PlayState.clientSocket.events.on("Draw Offer", function (_data)
		{	
			if (_data.id != RegTypedef._dataQuestions.id && RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
			{
				Reg._drawOffer = true;
			}
		});
	}	
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function drawAnsweredAs():Void
	{
		PlayState.clientSocket.events.on("Draw Answered As", function (_data)
		{			
			// only players in a room will see this message. see this event at server. server reads this event first.
			if (RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true)
			{
				if (_data._drawAnsweredAs == true) _drawSayYes += 1;
				if (_data._drawAnsweredAs == false) _drawSayNo += 1;
				
				Reg._totalPlayersInRoom = 0;
						
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._gamePlayersValues[i] <= 1
					&&  RegTypedef._dataPlayers._usernamesStatic[i] != "")
					{
						Reg._totalPlayersInRoom += 1;
					}
				}
				
				Reg._totalPlayersInRoom -= 1;
				
				if ((Reg._totalPlayersInRoom) == (_drawSayYes + _drawSayNo))
				{
					if (_data._drawAnsweredAs == true && Reg._totalPlayersInRoom == _drawSayYes)
					{
						Reg._gameMessage = "Draw accepted.";
						Reg._outputMessage = true;
						Reg._playerCanMovePiece = false;
						RegTriggers._messageDraw = "Game ended in a draw.";
						RegTriggers._draw = true;					
						
						PlayState.clientSocket.send("Save Draw Stats", RegTypedef._dataPlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
						
						Reg._gameOverForPlayer = true;
						Reg._gameOverForAllPlayers = true;
						
						if (Reg._gameHost == true)
						{
							RegTypedef._dataQuestions._gameOver = true;
							RegTypedef._dataQuestions._gameMessage = Reg._gameMessage;
							RegTypedef._dataQuestions._restartGameAnsweredAs = false;
							RegTypedef._dataQuestions._drawAnsweredAs = true;
							PlayState.clientSocket.send("Spectator Watching", RegTypedef._dataQuestions);
							haxe.Timer.delay(function (){}, Reg2._event_sleep);
						}
					}
					
					else
					{
						Reg._gameMessage = "Draw rejected.";
						Reg._outputMessage = true;
						
						if (Reg._gameHost == true)
						{
							RegTypedef._dataQuestions._gameOver = false;
							RegTypedef._dataQuestions._gameMessage = Reg._gameMessage;
							RegTypedef._dataQuestions._restartGameAnsweredAs = false;
							RegTypedef._dataQuestions._drawAnsweredAs = false;
							PlayState.clientSocket.send("Spectator Watching", RegTypedef._dataQuestions);
							haxe.Timer.delay(function (){}, Reg2._event_sleep);
						}
					}
					
					_drawSayYes = 0;
					_drawSayNo = 0;
				}
				
				if (_data.id == RegTypedef._dataQuestions.id) 
				{
					RegTypedef._dataQuestions._drawAnsweredAs = false;
				}		
					
			}

		});
	}
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function restartOffer():Void
	{
		PlayState.clientSocket.events.on("Restart Offer", function (_data)
		{			
			if (_data.id != RegTypedef._dataQuestions.id && RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
			{
				Reg._restartOffer = true;				
			}
			
		});
	}	
	
	/******************************
	* EVENT DRAW OTHER
	* should game by restarted.
	*/
	public function restartAnsweredAs():Void
	{
		PlayState.clientSocket.events.on("Restart Answered As", function (_data)
		{			
			// only players in a room will see this message. see this event at server. server reads this event first.
			if (RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true)
			{
				if (_data._restartGameAnsweredAs == true) _restartSayYes += 1;
				if (_data._restartGameAnsweredAs == false) _restartSayNo += 1;
				
				Reg._totalPlayersInRoom = 0;
				
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._gamePlayersValues[i] <= 1
					&&  RegTypedef._dataPlayers._usernamesStatic[i] != ""
					)
					{
						Reg._totalPlayersInRoom += 1;
					}
				}
		
				RegTypedef._dataPlayers._usernamesTotalStatic = RegTypedef._dataPlayers._usernamesStatic.length;
				RegTypedef._dataPlayers._usernamesTotalDynamic = RegTypedef._dataPlayers._usernamesDynamic.length;
								
				Reg._totalPlayersInRoom -= 1; // minus 1 because host must be excluded from count.
				
				if ((Reg._totalPlayersInRoom) == (_restartSayYes + _restartSayNo))
				{
					if (_data._restartGameAnsweredAs == true && Reg._totalPlayersInRoom == _restartSayYes)
					{			
						if (Reg._gameOverForAllPlayers == true)			
							Reg._gameMessage = "Game started.";
						else Reg._gameMessage = "Game restarted.";
						
						Reg2._do_once_game_start_request = true;
						
						if (RegTypedef._dataPlayers._spectatorWatching == false)
							RegTypedef._dataPlayers._spectatorPlaying = true;
						
						RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
						
						// set the total players in room to the total players able to play a game and set all vars that depend on that total.
						RegTypedef._dataPlayers._usernamesTotalDynamic = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = Reg._roomPlayerLimit = Reg._totalPlayersInRoom + 1;
						
						Reg._gameOverForPlayer = false;
						Reg._gameOverForAllPlayers = false;
						SceneGameRoom.assignMoveNumberPlayer();	
						
						if (Reg._gameHost == true)
						{
							RegTypedef._dataQuestions._gameOver = false;
							RegTypedef._dataQuestions._gameMessage = Reg._gameMessage;
							RegTypedef._dataQuestions._drawAnsweredAs = false;
							RegTypedef._dataQuestions._restartGameAnsweredAs = true;
							if (RegTypedef._dataPlayers._spectatorWatching == false
							)
							{
								PlayState.clientSocket.send("Spectator Watching", RegTypedef._dataQuestions);
								haxe.Timer.delay(function (){}, Reg2._event_sleep);
							}							
							
						}
						
						// reassign the move_player MySQL field at room_data table when the next event is called below.
						for (i in 0...4)
						{
							if (RegTypedef._dataPlayers._username
							==  RegTypedef._dataPlayers._usernamesStatic[i])
							{
								RegTypedef._dataPlayers._moveNumberDynamic[i] = i;
							}
						}

						PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
						
						Reg._outputMessage = true;
						Reg._createGameRoom = true;
					
					}
					
					else
					{
						if (Reg._gameOverForAllPlayers == true)			
							Reg._gameMessage = "Request to start game was rejected.";
						else Reg._gameMessage = "Request to restart game was rejected.";
						if (Reg._gameHost == true)
						{
							RegTypedef._dataQuestions._gameOver = true;
							RegTypedef._dataQuestions._gameMessage = Reg._gameMessage;
							RegTypedef._dataQuestions._drawAnsweredAs = false;
							RegTypedef._dataQuestions._restartGameAnsweredAs = false;
							
							PlayState.clientSocket.send("Spectator Watching", RegTypedef._dataQuestions);
							haxe.Timer.delay(function (){}, Reg2._event_sleep);
						}
							
						Reg._outputMessage = true;
					}
					
					_restartSayYes = 0;
					_restartSayNo = 0;
				}	
				
				if (_data.id == RegTypedef._dataQuestions.id) 
				{
					RegTypedef._dataQuestions._restartGameAnsweredAs = false;
				}
			
			}

		});
	}
	
	/************************************************************************
	 * currently this event is for the signature game. a player sends a trade unit to another player and this event is for that other player receiving the trade. a message box displays, with trade details, asking if the player would like that trade. 30 seconds countdown. when timer reaches zero, the message box closes.
	 */
	public function tradeProposalOffer():Void
	{
		PlayState.clientSocket.events.on("Trade Proposal Offer", function (_data)
		{	
			if (_data._userTo == RegTypedef._dataPlayers._username && RegTypedef._dataMisc._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
			{
				RegTypedef._dataGameMessage._gameMessage = _data._gameMessage;
				RegTypedef._dataGameMessage._userTo = _data._userTo;
				RegTypedef._dataGameMessage._userFrom = _data._userFrom;
				
				RegTriggers._tradeProposalOffer = true;
			}
		});
	}	
	
	/************************************************************************
	 * what did the player answer as the trade request message box!
	 */
	public function tradeProposalAnsweredAs():Void
	{
		PlayState.clientSocket.events.on("Trade Proposal Answered As", function (_data)
		{
			if (_data._userFrom == RegTypedef._dataPlayers._username && RegTypedef._dataMisc._room == _data._room && Reg._gameRoom == true) 
			{				
				// use this so we know if the trade was answered or not.
				RegTypedef._dataGameMessage._questionAnsweredAs = _data._questionAnsweredAs;
				
				// reverse them one last time to make them current for player that first sent trade request.
				RegTypedef._dataGameMessage._userTo = _data._userFrom;
				RegTypedef._dataGameMessage._userFrom = _data._userTo;
				
				RegTriggers._tradeWasAnswered = true; // trigger an event that the trade request was answered.
				
				
			}
		});
	}
	
	/******************************
	* EVENT ONLINE PLAYER OFFER INVITE.
	* offer an invite to a player at the lobby.
	*/
	public function onlinePlayerOfferInvite():Void
	{
		PlayState.clientSocket.events.on("Online Player Offer Invite", function (_data)
		{
			if (_data._usernameInvite == RegTypedef._dataAccount._username) 
			{
				if (RegTypedef._dataMisc._userLocation == 0)
				{
					// boxScroller at GameLobby needs to be inactive so that when invite message box is displayed, player cannot create a room which when player cancels the room creation, the player will be stuck with only a black screen.
					__scene_lobby.group.active = false;
					
					Reg._messageId = 2003;
					Reg._buttonCodeValues = "l1000";
					SceneGameRoom.messageBoxMessageOrder();
					
					RegTypedef._dataPlayers._usernameInvite = _data._username;
					Reg._inviteRoomNumberToJoin = _data._room;
					RegTypedef._dataPlayers._gameName = _data._gameName;
					
				}
			}
			
		});
	}	
	
	/******************************
	* EVENT ENTER GAME ROOM
	* this event enters the game room.
	* _miscData
	*/
	public function enterGameRoom():Void
	{
		PlayState.clientSocket.events.on("Enter Game Room", function (_data)
		{			
			if (_data._room != RegTypedef._dataMisc._room) return;
			
			if (_data.id != RegTypedef._dataMisc.id) 
			{
				Reg._gameOverForPlayer = true;				
				Reg._gameOverForAllPlayers = true;
				
				Reg._totalPlayersInRoom = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] - 1;
				
				// stop any sound playing.			
				if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();
			
				//RegTypedef._dataGame._room = _data._room; // tested once. seems to be not needed.
				
				Reg._gameHost = false;
				Reg._gameId = _data._gameId;
								
				SceneWaitingRoom._textPlayer1Stats.text = "";
				SceneWaitingRoom._textPlayer2Stats.text = "";
				SceneWaitingRoom._textPlayer3Stats.text = "";
				SceneWaitingRoom._textPlayer4Stats.text = "";
				
				
				RegTypedef._dataMisc._userLocation = 3;			
				
				__scene_waiting_room.__boxscroller.visible = false;
				__scene_waiting_room.__boxscroller.active = false;
				
				Reg._createGameRoom = true;
								
				RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 0;
				
			}
			
			if (RegTypedef._dataPlayers._usernamesStatic[0] == "")	
				RegTypedef._dataPlayers._usernamesStatic = RegTypedef._dataPlayers._usernamesDynamic.copy(); // without copy, when an element from _usernamesDynamic is removed, automatically, the same element at _usernamesStatic will be removed.
			
			// this is needed to save a game win to the game being played. if chess is being played and player won that game then this var will be used to save a win to chess, not just the overall wins of any game played.
			
			// never get a value of -1 or there will be a server error when saving stats.
			if (RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] > -1)
				RegTypedef._dataPlayers._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
			
			//RegTypedef._dataPlayers._triggerEvent = "foo"; // any data can be used here. ignore stuff if true.
			RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						
			RegTypedef._dataPlayers._triggerEvent = "";
			
			_data._gameRoom = false;
		});
	}
		
	/******************************
	* EVENT GAME WIN
	* this player wins the game.
	*/
	public function gameWin():Void
	{
		PlayState.clientSocket.events.on("Game Win", function (_data)
		{	
			if (_data.id == RegTypedef._dataPlayers.id) 
			{
				var _found:Bool = false;
				
				// determine if player was playing a game.
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._username
					==  RegTypedef._dataPlayers._usernamesDynamic[i]
					&&  RegTypedef._dataPlayers._gamePlayersValues[i] != 1)
					{
						_found = true;
					}
				}
				
				// if player was not playing a game then do not continue. do not display a win or lose message for this player.
				if (_found == true) return;
	
				if (RegTypedef._dataPlayers._spectatorPlaying == false
				&&  RegTypedef._dataPlayers._isGameFinished == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true) return;
								
				RegTriggers._messageWin = "You win";
				RegTriggers._win = true;
				RegTypedef._dataTournaments._game_over = 1;
				RegTypedef._dataTournaments._won_game = 1;
				
				PlayState.clientSocket.send("Save Win Stats", _data);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
			}
			
		});
	}
	
	/******************************
	* EVENT GAME LOSE
	* this player loses the game.
	*/
	public function gameLose():Void
	{
		PlayState.clientSocket.events.on("Game Lose", function (_data)
		{
			// at server, do not use "_sender.send" because more than one player can lose game.
			if (_data.id == RegTypedef._dataPlayers.id) 
			{
				if (RegTypedef._dataPlayers._spectatorPlaying == false
				&&  RegTypedef._dataPlayers._isGameFinished == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true) return;
				
				if (PlayState._clientDisconnect == false)
				{
					RegTriggers._messageLoss = "You lose.";
					RegTriggers._loss = true;
				}
				
				PlayState.clientSocket.send("Save Lose Stats", _data);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
		});
	}
	
	/******************************
	* EVENT GAME WIN
	* this player wins the game.
	* only a 2 player game should use this event.
	*/
	public function gameWinThenLoseForOther():Void
	{
		PlayState.clientSocket.events.on("Game Win Then Lose For Other", function (_data)
		{
			if (_data.id == RegTypedef._dataPlayers.id) 
			{
				if (RegTypedef._dataPlayers._spectatorPlaying == false
				&&  RegTypedef._dataPlayers._isGameFinished == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true) return;
				
				RegTriggers._messageWin = "You win";
				RegTriggers._win = true;
				RegTypedef._dataTournaments._game_over = 1;
				RegTypedef._dataTournaments._won_game = 1;
				RegTypedef._dataPlayers._spectatorPlaying = false;
				
				PlayState.clientSocket.send("Save Win Stats For Both", _data);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			if (_data.id != RegTypedef._dataPlayers.id)
			{
				if ( Reg._roomPlayerLimit <= 2 )
				{
					if (RegTypedef._dataPlayers._spectatorPlaying == false
				    &&  RegTypedef._dataPlayers._isGameFinished == true
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||  RegTypedef._dataPlayers._spectatorWatching == true) return;
										
					if (PlayState._clientDisconnect == false)
					{
						RegTriggers._messageLoss = "You lose.";
						RegTriggers._loss = true;
					}
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					
					updateStats(_data);
					RegFunctions.playerAllStop();
				}
			}
		});
	}
	
	/******************************
	* EVENT GAME LOSE
	* this player loses the game.
	* only a 2 player game should use this event.
	*/
	public function gameLoseThenWinForOther():Void
	{
		PlayState.clientSocket.events.on("Game Lose Then Win For Other", function (_data)
		{
			if (_data.id == RegTypedef._dataPlayers.id) 
			{
				if (RegTypedef._dataPlayers._spectatorPlaying == false
				&&  RegTypedef._dataPlayers._isGameFinished == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true) return;
				
				if (PlayState._clientDisconnect == false)
				{
					RegTriggers._messageLoss = "You lose.";
					RegTriggers._loss = true;
					RegTypedef._dataPlayers._spectatorPlaying = false;
				}
				
				PlayState.clientSocket.send("Save Lose Stats For Both", _data);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}			
			
			if (_data.id != RegTypedef._dataPlayers.id)
			{
				if ( Reg._roomPlayerLimit <= 2 )
				{
					if (RegTypedef._dataPlayers._spectatorPlaying == false
			    	&&  RegTypedef._dataPlayers._isGameFinished == true
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||  RegTypedef._dataPlayers._spectatorWatching == true) return;
					
					RegTriggers._messageWin = "You win.";
					RegTriggers._win = true;
					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 1;
					RegTypedef._dataPlayers._spectatorPlaying = false;
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					
					updateStats(_data);
					RegFunctions.playerAllStop();
					
					
				}
				
			}
		});
	}	
	
	/******************************
	* EVENT GAME DRAW
	* this game is in a tie.
	*/
	public function gameDraw():Void
	{
		PlayState.clientSocket.events.on("Game Draw", function (_data)
		{
			// at server, do not use "_sender.send" because more than one player can be in a draw.
			if (_data.id == RegTypedef._dataPlayers.id)
			{
				if (RegTypedef._dataPlayers._spectatorPlaying == false
				&&  RegTypedef._dataPlayers._isGameFinished == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true) return;
				
				RegTriggers._messageDraw = _data._gameMessage;
				RegTriggers._draw = true;
				
				if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
				{					
					RegFunctions.playerAllStop();
					Reg._gameOverForPlayer = true;
				}
				
				PlayState.clientSocket.send("Save Draw Stats", _data);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			if (_data.id != RegTypedef._dataPlayers.id)
			{
				if (RegTypedef._dataPlayers._spectatorWatching == true) return;
								
				if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
				{
					RegTriggers._messageDraw = _data._gameMessage;
					RegTriggers._draw = true;
					
					Reg._gameOverForPlayer = true;
					RegFunctions.playerAllStop();
				}				
			}
		});
	}
		
	/******************************
	* EVENT SAVE WIN STATS
	* save the win stats of the player that was sent here and then return that value here.
	* _dataPlayers.
	*/
	public function saveWinStats():Void
	{
		PlayState.clientSocket.events.on("Save Win Stats", function (_data)
		{			
			if (_data._room == RegTypedef._dataPlayers._room 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				updateStats(_data);
				RegTypedef._dataPlayers._spectatorPlaying = false;
			}
		});
	}
		
	/***********************************************************************
	* EVENT SAVE LOSE STATS
	* save the lose stats of the player that was sent here and then return that value here.
	* _dataPlayers.
	*/
	public function saveLoseStats():Void
	{
		PlayState.clientSocket.events.on("Save Lose Stats", function (_data)
		{
			// at server, do not use "_sender.send" because more than one player can lose game.
			if (_data._room == RegTypedef._dataPlayers._room 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				updateStats(_data);
				RegTypedef._dataPlayers._spectatorPlaying = false;
				
				// user is disconnecting by pressing the esc key. the PlayState._clientDisconnectDo var was set to false before entering this event so a check here is not needed because this is the last event entered after the ActionCommands.hx esc key was pressed.
				if (PlayState._clientDisconnect == true)
					PlayState.disconnectByESC();
			}
		});
	}	
	
	/******************************
	* EVENT SAVE WIN STATS
	* save the win stats of the player that was sent here and then return that value here.
	* only a 2 player game should use this event. this event was called from "Game Win Then Lose For Other"
	* _dataPlayers.
	*/
	public function saveWinStatsForBoth():Void
	{
		PlayState.clientSocket.events.on("Save Win Stats For Both", function (_data)
		{			
			if (_data._room == RegTypedef._dataPlayers._room 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				updateStats(_data);
				RegTypedef._dataPlayers._spectatorPlaying = false;
			}
			
			else if (_data._room == RegTypedef._dataPlayers._room )
			{
				Reg._playerCanMovePiece = false;
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
				RegFunctions.playerAllStop();
			}
		});
	}
		
	/******************************
	* EVENT SAVE LOSE STATS
	* save the lose stats of the player that was sent here and then return that value here.
	* only a 2 player game should use this event.
	* _dataPlayers.
	*/
	public function saveLoseStatsForBoth():Void
	{
		PlayState.clientSocket.events.on("Save Lose Stats For Both", function (_data)
		{		
			if (_data._room == RegTypedef._dataPlayers._room 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				var _found:Bool = false;
				updateStats(_data);
		 		
				// determine if player was playing a game.
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._username
					==  RegTypedef._dataPlayers._usernamesDynamic[i]
					&&  RegTypedef._dataPlayers._gamePlayersValues[i] != 1)
					{
						_found = true;
					}
				}
				

				// if player was not playing a game then do not continue. do not display a win or lose message for this player.
				if (_found == true) return;
				
				Reg._gameOverForPlayer == true; 
				
				if (_data.id != RegTypedef._dataPlayers.id)
				{
					RegTriggers._messageWin = "You win.";
					RegTriggers._win = true;
					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 1;
					RegTypedef._dataPlayers._spectatorPlaying = false;
						
					RegFunctions.playerAllStop();
				}
				
				RegTypedef._dataPlayers._spectatorPlaying = false;
			}	
			
			else if (_data._room == RegTypedef._dataPlayers._room )
			{
				Reg._playerCanMovePiece = false;
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
				RegFunctions.playerAllStop();
			}
		});
	}
	
	/******************************
	* EVENT SAVE DRAW STATS
	* save the draw stats of the player that was sent here and then return that value here. this event was called from "Game Lose Then Win For Other"
	* _dataPlayers.
	*/
	public function saveDrawStats():Void
	{
		PlayState.clientSocket.events.on("Save Draw Stats", function (_data)
		{
			// at server, do not use "_sender.send" because more than one player can draw.
			if (_data._room == RegTypedef._dataPlayers._room 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				updateStats(_data);
			}		
		});
	}
	
	/******************************
	* EVENT GET TOURNAMENT
	* gets the selected tournament data.
	* _dataTournaments
	*/
	public function tournamentChessStandard8Get():Void
	{
		PlayState.clientSocket.events.on("Tournament Chess Standard 8 Get", function (_data)
		{
			RegTypedef._dataTournaments._player1 = _data._player1;
			RegTypedef._dataTournaments._player2 = _data._player2;
			RegTypedef._dataTournaments._move_number_current = _data._move_number_current;
			RegTypedef._dataTournaments._tournament_started = _data._tournament_started;
			RegTypedef._dataPlayers._moveTotal = _data._move_total;
			
			// is it the first player moving?
			if (RegTypedef._dataTournaments._move_number_current == 0)
			{
				RegTypedef._dataPlayers._usernamesStatic[0] = _data._player1;
				RegTypedef._dataPlayers._usernamesStatic[1] = _data._player2;
			
				RegTypedef._dataPlayers._usernamesDynamic[0] = _data._player1;
				RegTypedef._dataPlayers._usernamesDynamic[1] = _data._player2;
				
				Reg._gameHost = true;
				
				Reg._move_number_current = 0;
				Reg._move_number_next = 0;
				
				Reg._playerMoving = 0;
				Reg._playerNotMoving = 1;
			}
			
			// if here then its the second player moving piece. therefore, set these vars.
			else
			{
				RegTypedef._dataPlayers._usernamesStatic[0] = _data._player2;
				RegTypedef._dataPlayers._usernamesStatic[1] = _data._player1;
				
				RegTypedef._dataPlayers._usernamesDynamic[0] = _data._player2;
				RegTypedef._dataPlayers._usernamesDynamic[1] = _data._player1;
				
				Reg._gameHost = false;
				
				Reg._move_number_current = 1;
				Reg._move_number_next = 1;
				
				Reg._playerMoving = 1;
				Reg._playerNotMoving = 0;
			}
			
			RegTypedef._dataPlayers._moveTimeRemaining[1] = RegCustom._move_time_remaining_current[1] = Std.parseInt(_data._time_remaining_player2);
			RegTypedef._dataPlayers._moveTimeRemaining[0] = RegCustom._move_time_remaining_current[0] = Std.parseInt(_data._time_remaining_player1);
			
			Reg._textTimeRemainingToMove1 = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._moveTimeRemaining[0]);
			Reg._textTimeRemainingToMove2 = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._moveTimeRemaining[1]);
			
			Reg._playerCanMovePiece = true;
			
			RegTypedef._dataTournaments._gid = _data._gid;
			RegTypedef._dataTournaments._move_piece = _data._move_piece;
			RegTypedef._dataTournaments._round_current = _data._round_current;
			RegTypedef._dataTournaments._rounds_total = _data._rounds_total;		RegTypedef._dataTournaments._player_maximum = _data._player_maximum;
			RegTypedef._dataTournaments._player_current = _data._player_current;
			RegTypedef._dataTournaments._game_over = _data._game_over;
			RegTypedef._dataTournaments._timestamp = _data._timestamp;
			RegTypedef._dataTournaments._won_game = _data._won_game;
			
			RegTriggers._jump_to_tournament_standard_chess_8 = true;
		});
	}
	
	/******************************
	* EVENT GET TOURNAMENT
	* puts the selected tournament data to the MySQL database.
	* _dataTournaments
	*/
	public function tournamentChessStandard8Put():Void
	{
		PlayState.clientSocket.events.on("Tournament Chess Standard 8 Put", function (_data)
		{
			
			
		});
	}
	
	/****************************** NOTE... GAME WILL NOT UPDATE FOR SPECTATOR UNTIL SECOND MOVE 
	* EVENT GAME ROOM ENTERED SPECTATOR WATCHING
	* 
	*  // user who requested to watch a game. this can be a message such as "checkmate" or "restarting game". also, any var needed to start or stop a game will be passed here.
	* only the game host should send to this event.
	* _dataQuestions.
	*/
	public function spectatorWatching():Void
	{
		PlayState.clientSocket.events.on("Spectator Watching", function (_data)
		{			
			if (RegTypedef._dataMisc._spectatorWatching == true)
			{
				// get any game message
				Reg._gameMessage = _data._gameMessage;

				// game over if draw was answered as true.
				if (_data._drawAnsweredAs == true)
				{					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					Reg._outputMessage = true;
				}
				
				// game start is restart game was answered as true.
				else if (_data._restartGameAnsweredAs == true)
				{
					SceneGameRoom.assignMoveNumberPlayer();
					
					Reg._gameOverForPlayer = false;
					Reg._gameOverForAllPlayers = false;
					//Reg._playerOffset = 0;
											
					//RegTypedef._dataPlayers._gamePlayersValues = [1, 1, 1, 1];
					Reg._playerIDs = -1;
					
					Reg._outputMessage = true;
					//Reg._createGameRoom = true;
					
				}
				
				// else, no change. draw or restart was cancelled. send a user cancelled message.
				else
				{						
					Reg._outputMessage = true;
				}
			}		
		});
	}
	
	/****************************** NOTE... GAME WILL NOT UPDATE FOR SPECTATOR UNTIL SECOND MOVE 
	* EVENT SPECTATOR WATCHING GET MOVE NUMBER
	*  send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
	* _dataPlayers.
	*/
	public function spectatorWatchingGetMoveNumber():Void
	{
		PlayState.clientSocket.events.on("Spectator Watching Get Move Number", function (_data)
		{			
			if (RegTypedef._dataPlayers._spectatorWatching == true)
			{
				Reg._move_number_next = _data._spectatorWatchingGetMoveNumber;
				RegTypedef._dataPlayers._moveNumberDynamic[0] = Reg._move_number_next;
			
				Reg._spectator_start_timer = true;
			}
		});
	}
	
	
	
	
	
	
	
	
	private function updateStats(_data:Dynamic):Void
	{
		if (RegTypedef._dataPlayers._username == _data._usernamesDynamic[0]
		 || RegTypedef._dataPlayers._username == _data._usernamesDynamic[1]
		 || RegTypedef._dataPlayers._username == _data._usernamesDynamic[2]
		 || RegTypedef._dataPlayers._username == _data._usernamesDynamic[3])
		 {
			// display the new stat. note that if player can some how change the stat value of win, the real value will be displayed when entering a room.
			RegTypedef._dataPlayers._gamesAllTotalWins = _data._gamesAllTotalWins;
			RegTypedef._dataPlayers._gamesAllTotalLosses = _data._gamesAllTotalLosses;
			RegTypedef._dataPlayers._gamesAllTotalDraws = _data._gamesAllTotalDraws;
			
			Reg._gameMessage = "";
			Reg._outputMessage = false;
						
		}
	}
	
	/******************************
	* EVENT PLAYER LEFT GAME
	* Trigger an event that the player has left the game and then do stuff such as stop the ability to move piece.
	* _dataPlayers
	*/
	public function playerLeftGameRoom():Void
	{
		PlayState.clientSocket.events.on("Player Left Game Room", function (_data)
		{
			//RegTypedef._dataPlayers._usernamesStatic = _data._usernamesStatic; // uncommenting this creates an error where the last player in game room cannot go back to lobby.
			if (Reg._currentRoomState == 0
			||  Reg._currentRoomState == 7)
				RegTypedef._dataPlayers._gamePlayersValues = _data._gamePlayersValues;
			
			// does username exists at stats list.
			var _found:Bool = false;
						
			// a player left game so minus this var.
			RegTypedef._dataPlayers._usernamesTotalDynamic -= 1;
						
			for (i in 0...4)
			{
				if (Std.string(_data._username) == Std.string(RegTypedef._dataPlayers._usernamesStatic[i]))
				{
					_found = true;
				}
			}
			
	/*trace(RegTypedef._dataPlayers._gamePlayersValues + "_gamePlayersValues");
	trace(RegTypedef._dataPlayers._usernamesStatic + "_usernamesStatic");
	trace(RegTypedef._dataPlayers._usernamesDynamic + "_usernamesDynamic");
	trace(_data._username + "_username");
	trace(Reg._playerWaitingAtGameRoom+"Reg._playerWaitingAtGameRoom");
	trace("--------------------");
	*/					
			if (_found == false && RegTypedef._dataPlayers._spectatorPlaying == false) {return;} // username not found at room.
			
			Reg._atTimerZeroFunction = false;
			Reg2._removePlayerFromTypedefPlayers = true;
									
			var _totalPlayers:Int = 0; 
			
			for (i in 0...4)
			{
				if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1
				&&  RegTypedef._dataPlayers._usernamesStatic[i] != "")
				{
					_totalPlayers += 1;
				}
			}
			
			// the player disconnecting
			if (Std.string(_data._username) == Std.string(RegTypedef._dataPlayers._username))
			{
				// if this is false then player is leaving the game room.
				if (Reg._playerWaitingAtGameRoom == false)
				{
					if (Reg._gameOverForPlayer == false) 
					{
						Reg._playerLeftGame = true;		
					}
					
					//RegTypedef._dataPlayers._room = 0;
					//RegTypedef._dataMisc._userLocation = 0;
					
					for (i in 0...4)
					{
						if (RegTypedef._dataPlayers._username == _data._usernamesDynamic[i])
						{
							// if still playing the game and user is leaving game room then user will have a lose added to stats.
							if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1 || RegTypedef._dataPlayers._gamePlayersValues[i] == 2)
							{
								// set this to false since we need to go back to server. the below disconnect code will now be ignored since will have that code in the "Game Lose" event.
								PlayState._clientDisconnectDo = false;
							}
						}						
					}
					
					SceneGameRoom.go_back_to_lobby();
					
					#if !html5
						for (i in 0...4)
						{
							if (RegTypedef._dataPlayers._username == _data._usernamesDynamic[i])
							{
								// if still playing the game and user is leaving game room then user will have a lose added to stats.
								if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1 || RegTypedef._dataPlayers._gamePlayersValues[i] == 2)
								{
									// set this so that a save to lose can be made.
									RegTypedef._dataPlayers._spectatorPlaying = false;
									PlayState.clientSocket.send("Game Lose", _data);
									haxe.Timer.delay(function (){}, Reg2._event_sleep);
								}
							}						
						}
						
					#end
					
				}
				
				else 
				{
					Reg._gameOverForPlayer = true;
				}
				
				/*// user is disconnecting by pressing the esc key
				if (_data.id == RegTypedef._dataPlayers.id 
				&&   PlayState._clientDisconnect == true
				&&   PlayState._clientDisconnectDo == true)
					PlayState.disconnectByESC();*/
			}
			
			// the other player.
			else
			{				
				
				// NOTE THAT PLAYER WILL GET A LOSS FROM SERVER SIDE ONDISSCONNECT. EVENT.
				// need MySQL game_player here.
				if (_totalPlayers >= 1)
				{								
					for (i in 0...4)
					{
						if (RegTypedef._dataPlayers._usernamesDynamic[i] == _data._username)
						{
							// this var is used at PlayersLeftGameResetThoseVars.resetPlayersData() to do anything needed, such as reset the player's land back to its default state.
							Reg._playerLeftGameMoveNumber = i + 1;
						}
					}						
				}
				
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._usernamesStatic[i] == _data._username)
					{
						// the game is over or player might have left the game room, so use this var to open a message box using this var as the class instance.
						Reg._playerIDs = i;
					}
				}
				
				// this var holds the player's username that left the game. its used at message box messages saying that the player is no longer at the game room.
				Reg._playerLeftGameUsername = _data._username;			
						
				// jump to a code to determine what message should be displayed if any. it all depends to what value _gamePlayersValues typedef has.
				RegTriggers._playerLeftGame = true;
				Reg._player_left_game_room = true;
				Reg._playerLeftGame = true; 
				
			}
		
			if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
			{
				RegTypedef._dataPlayers._gameIsFinished = true;
				PlayState.clientSocket.send("Game Is Finished", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				RegFunctions.playerAllStop();
			}	
			
			if (_totalPlayers == 0) 
			{
				//RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
								
			}
			
	/*
	trace(Reg._gameOverForAllPlayers + "Reg._gameOverForAllPlayers");
	trace(Reg._playerLeftGameUsername + "Reg._playerLeftGameUsername");
	trace(_totalPlayers + "_totalPlayers");	
	trace(Reg._roomPlayerLimit + "Reg._roomPlayerLimit");
	trace(RegTypedef._dataPlayers._usernamesDynamic);
	trace(RegTypedef._dataPlayers._usernamesStatic + " static");
	trace(_data._gamePlayersValues+"_gamePlayersValues");
	*/
		});
	}
	
	/******************************
	 * this event is called when playing a game and player ran out of time or quit game.
	 */
	public function playerLeftGame():Void
	{
		PlayState.clientSocket.events.on("Player Left Game", function (_data)
		{
			// does username exists at stats list.
			var _found:Bool = false;			
			
			// a player left game so minus this var.
			RegTypedef._dataPlayers._usernamesTotalDynamic -= 1;
						
			for (i in 0...4)
			{
				if (Std.string(_data._username) == Std.string(RegTypedef._dataPlayers._usernamesDynamic[i]))
				{
					_found = true;
				}
			}
						
			if (_found == false && RegTypedef._dataPlayers._spectatorPlaying == false) {return;} // username not found at room.

			Reg2._removePlayerFromTypedefPlayers = true;
			
			if (Reg._currentRoomState == 0
			||  Reg._currentRoomState == 7)
				RegTypedef._dataPlayers._gamePlayersValues = _data._gamePlayersValues;
			
			RegTypedef._dataPlayers._quitGame = _data._quitGame;
						
			var _totalPlayers:Int = 0;
			var _didPlayerLeaveGameRoom:Bool = false;
			
			for (i in 0...4)
			{
				if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1
				&&  RegTypedef._dataPlayers._usernamesStatic[i] != "")
				{
					_totalPlayers += 1;
				}
			}
			
			// the player leaving the game.
			if (Std.string(_data._username) == Std.string(RegTypedef._dataPlayers._username))
			{
				// if this is false then player is leaving the game room.
				if (Reg._playerWaitingAtGameRoom == false)
				{
					if (Reg._gameOverForPlayer == false) 
					{
						Reg._playerLeftGame = true;		
					}
					
					for (i in 0...4)
					{
						if (RegTypedef._dataPlayers._username == _data._usernamesDynamic[i])
						{
							// if still playing the game and user is leaving game room then user will have a lose added to stats.
							if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1 || RegTypedef._dataPlayers._gamePlayersValues[i] == 2)
							{
								PlayState.clientSocket.send("Game Lose", _data); 
								haxe.Timer.delay(function (){}, Reg2._event_sleep);
							}
						}						
					}
					
					
				}
				
				else 
				{
					Reg._gameOverForPlayer = true;					
				}
				
				Reg._atTimerZeroFunction = false;
				//Reg._playerOffset = Reg._roomPlayerLimit - _totalPlayers;
				RegTriggers._removePlayersDataFromStage = true;
			}
			
			// the other player.
			else
			{				
				// NOTE THAT PLAYER WILL GET A LOSS FROM SERVER SIDE ONDISSCONNECT. EVENT.
				// need MySQL game_player here.
				if (Reg._gameOverForAllPlayers == false)
				{
					for (i in 0...4)
					{
						if (RegTypedef._dataPlayers._usernamesDynamic[i] == _data._username)
						{
							// this var is used at PlayersLeftGameResetThoseVars.resetPlayersData() to do anything needed, such as reset the player's land back to its default state.
							Reg._playerLeftGameMoveNumber = i + 1;
						}
					}
						
				
					for (i in 0...4)
					{
						if (RegTypedef._dataPlayers._usernamesStatic[i] == _data._username)
						{
							// the game is over or player might have left the game room, so use this var to open a message box using this var as the class instance.
							Reg._playerIDs = i;
						}
					}
				
					if (_data._quitGame == true)
					{
						Reg._playerCanMovePiece = false;
						Reg._playerWaitingAtGameRoom = true;
					}
					
					// this var holds the player's username that left the game. its used at message box messages saying that the player is no longer at the game room.
					Reg._playerLeftGameUsername = _data._username;
							
					// jump to a code to determine what message should be displayed if any. it all depends to what value _gamePlayersValues typedef has.
					RegTriggers._playerLeftGame = true;
					Reg._player_left_game_room = false;
					Reg._playerLeftGame = true; 
				}				
				
			}
	
	/*
	trace(Reg._gameOverForAllPlayers + "Reg._gameOverForAllPlayers");
	trace(Reg._playerLeftGameUsername + "Reg._playerLeftGameUsername");
	trace(_totalPlayers + "_totalPlayers");	
	trace(Reg._roomPlayerLimit + "Reg._roomPlayerLimit");
	trace(RegTypedef._dataPlayers._usernamesDynamic);
	trace(_data._gamePlayersValues+"_gamePlayersValues");
	trace(":Reg._atTimerZeroFunction" + Reg._atTimerZeroFunction);
	trace(":Reg._playerIDs" + Reg._playerIDs);
	trace("--------------------");
	*/
	
			if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
			{
				RegTypedef._dataPlayers._gameIsFinished = true;
				PlayState.clientSocket.send("Game Is Finished", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				RegFunctions.playerAllStop();
			}	
	
			if (_totalPlayers == 0) 
			{
				//RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
			}
			
		});
	}
	
	/******************************
	 * EVENT GAME IS FINISHED.
	 * save a var to mySql so that someone cannot invite when still in game room. also, triggers a var called Reg._gameOverForAllPlayers to equal true so that the game has ended for everyone.
	 * _dataPlayers
	 */
	public function gameIsFinished():Void
	{
		PlayState.clientSocket.events.on("Game Is Finished", function (_data)
		{
			if (_data.id == RegTypedef._dataPlayers.id
			&&  RegTypedef._dataPlayers._gameIsFinished == true) 
			{
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
			}
			
			/*	
				else
				{
					RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					
				}
			}
			*/
			// host of the room needs to send this or else all player will send this event to user that is a spectator watching. 
			if (RegTypedef._dataMisc._roomHostUsername == _data._usernamesDynamic[0])
			{
				PlayState.clientSocket.send("Is Game Finished", RegTypedef._dataPlayers); 
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
		
		});
	}	
	
	/******************************
	 * EVENT GAME IS FINISHED.
	 * false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
	 * _dataPlayers
	 */
	public function isGameFinished():Void
	{
		PlayState.clientSocket.events.on("Is Game Finished", function (_data)
		{
			if (RegTypedef._dataMisc._spectatorWatching == true)
			{
				// the code below this line will will fail with a bool error if there is first a trace code here or a trace code above this line.
				
				// data is does not pass a bool var so we need to do this...
				if (_data._isGameFinished == false)
					RegTypedef._dataPlayers._isGameFinished = false;
				else
					RegTypedef._dataPlayers._isGameFinished = true;
				
				// if here then "spectator watching" has entered the game room.
				if (RegTypedef._dataPlayers._spectatorWatching == true
				&&  _data._isGameFinished == false)
				{
					Reg._gameOverForPlayer = false;
					Reg._gameOverForAllPlayers = false;
					//Reg._playerOffset = 0;
											
					//RegTypedef._dataPlayers._gamePlayersValues = [1, 1, 1, 1];
					Reg._playerIDs = -1;					
				}
				
				// a player won the game and saved the _isGameFinished var to server MySQL then sent this event so that this code can be read. also this code will be read when the user enters into the game room and the _isGameFinished from server, this event, has a value of false.
				else 
				{
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
				}
			}
			
			// user is disconnecting by pressing the esc key
			if (_data.id == RegTypedef._dataPlayers.id 
			&&   PlayState._clientDisconnect == true)
				PlayState.disconnectByESC();
		});
	}
	
	
	/******************************
	* EVENT GAME PLAYERS VALUE.
	* save the player's game player state to the database. is the player playing a game or waiting to play. 
	* 0 = not playing but still at game room. 
	* 1 playing a game. 
	* 2: left game room while still playing it. 
	* 3 left game room when game was over. 
	* this var is used to display players who are waiting for a game at the game room and to get the _count of how many players are waiting at game room.
	*/
	public function gamePlayersValues():Void
	{
		PlayState.clientSocket.events.on("Game Players Values", function (_data)
		{
			if (RegTypedef._dataMisc._userLocation == 3) 
			{
				RegTypedef._dataPlayers._gamePlayersValues = _data._gamePlayersValues;
			}	
			
			if (Reg._buttonCodeValues == "g1000")
			{
				Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
				
				// this is the last event for this block of code and since RegTypedef._dataMisc._userLocation = 3 is used for this event, if the user pressed the ESC key while at the game room then that code to return to MenuState is used in this event else the player will return to the lobby.
				// see the bottom of this event of how the ESC code is used. basically, to handle more complicated loops, if there is a call to an event within this event then the PlayState._clientDisconnectDo is set to false so that at the end of this event, the code that handles the ESC key press will never be called but inside the other event it may disconnect if the check is true.
				if (RegTypedef._dataMisc._spectatorWatching == false)
				{
					PlayState.clientSocket.send("Player Left Game Room", RegTypedef._dataPlayers);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
				
				else 
				{
					PlayState.clientSocket.send("Lesser RoomState Value", RegTypedef._dataMisc);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
					
					// display the lobby.
					PlayersLeftGameResetThoseVars.playerRepopulateTypedefPlayers();
					RegTypedef.resetTypedefDataSome();
					Reg.resetRegVars();
					Reg2.resetRegVars();
					RegCustom.resetRegVars();
					RegTriggers.resetTriggers();
					
					Reg._game_online_vs_cpu = false;
					Reg._gameOverForPlayer = true;
					Reg._alreadyOnlineUser = true;
					Reg._loggedIn = true; 
					Reg._createGameRoom = false;
					Reg._loginSuccessfulWasRead = false;
					Reg._doOnce = true;			
					Reg._at_create_room = false;
					Reg._at_waiting_room = false;
					Reg._doStartGameOnce = false;
					Reg._gameRoom = false;
					Reg._hasUserConnectedToServer = true;
					Reg._lobbyDisplay = false;			
					Reg._clearDoubleMessage = true;			
					Reg._rememberChatterIsOpen = false;
					
					RegTriggers._lobby = true;
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
				}
			}
		
			
		});
	}
	
	/******************************
	* EVENT LOGGED IN USERS
	* list of online players with stats. used to invite.
	* _dataPlayers
	*/
	public function loggedInUsers():Void
	{
		PlayState.clientSocket.events.on("Logged In Users", function (_data)
		{
			if (_data.id == RegTypedef._dataPlayers.id) 
			{
				// no need for a (if (_data._room == ) check because at server this is broadcast based on the room var.
				RegTypedef._dataOnlinePlayers = _data;
				RegTriggers._onlineList = true;
				
				__scene_waiting_room.__menu_bar._button_refresh_list.active = true;
				__scene_waiting_room.__menu_bar._button_refresh_list.visible = true;	
				
				__scene_waiting_room.__menu_bar._button_return_to_lobby_from_waiting_room.active = true;
				__scene_waiting_room.__menu_bar._button_return_to_lobby_from_waiting_room.visible = true;

				// get the stats for the waiting room.
				if (RegTypedef._dataMisc._userLocation == 2 
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataPlayers._spectatorWatching == true
				&&  RegTypedef._dataTournaments._move_piece == false
				)
				{
					if (RegTypedef._dataMisc._userLocation > 0)	
						SceneWaitingRoom.updateUsersInRoom();
				}
				
				PlayState.clientSocket.send("Is Action Needed For Player", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}	
		});
	}
			
	/******************************
	* EVENT IS ACTION NEEDED FOR PLAYER.
	* should event action be done to player.
	*/
	public function isActionNeededForPlayer():Void
	{
		PlayState.clientSocket.events.on("Is Action Needed For Player", function (_data)
		{
			if (_data._username == RegTypedef._dataPlayers._username)
			{
				if (RegTypedef._dataPlayers._username == _data._actionWho && _data._actionDo > -1) 
				{
					RegTypedef._dataPlayers._actionNumber = _data._actionNumber;
					
					var _num:Dynamic = _data._actionDo;						
					// kicked.
					if (_data._actionNumber == 1)
					{
						RegTypedef._dataPlayers._actionDo = _num;
						
						Reg._actionMessage = "Attention! You are kicked by the host of room " + Std.string(RegTypedef._dataMisc._room)  + ".\n\n" + _num + " minute(s) remaining.";
					}
					
					// banned.
					if (_data._actionNumber == 2)
					{
						Reg._actionMessage = "Attention! You are banned by the host of room " + Std.string(RegTypedef._dataMisc._room) + " until the host leaves room " + Std.string(RegTypedef._dataMisc._room) + ".";
					}
					
					Reg._yesNoKeyPressValueAtMessage = 1;
					Reg._buttonCodeValues = "r1004";
					
					Reg._displayActionMessage = true;
					__scene_waiting_room.__boxscroller.visible = false;
					__scene_waiting_room.visible = false;
				} 
				else 
				{
					RegTypedef._dataPlayers._actionDo = -1;
					RegTypedef._dataPlayers._actionNumber = 0;
					RegTypedef._dataPlayers._actionWho = _data._actionWho;
					
					if (RegTypedef._dataMisc._userLocation == 2 && Reg._at_create_room == false)
					{
						__scene_waiting_room.mainButtonsAndTexts();
						__scene_waiting_room.__boxscroller.visible = true;
						__scene_waiting_room.visible = true;
					}
				}	
				
				if (RegTypedef._dataMisc._userLocation > 0
				&&  RegTypedef._dataMisc._userLocation < 3) // not in game room
				{
					PlayState.clientSocket.send("Room Lock 1", _data);
					haxe.Timer.delay(function (){}, Reg2._event_sleep);
				}
			}
		});
	}
	
	/******************************
	* EVENT ACTION BY PLAYER.
	* this is where player can kick, ban other players.
	* dataPlayers
	*/
	public function actionByPlayer():Void
	{
		PlayState.clientSocket.events.on("Action By Player", function (_data)
		{
			RegTypedef._dataPlayers._actionNumber = _data._actionNumber;
			RegTypedef._dataPlayers._actionWho = _data._actionWho;
			PlayState.clientSocket.send("Is Action Needed For Player", RegTypedef._dataPlayers);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		});
	}
		
	/******************************
	* EVENT MOVE HISTORY NEXT ENTRY.
	* every player that moves a piece will use the host of the room to call this event so to update the move history at MySQL. this is needed so that when a spectator watching enters the room, that person can get all the move history for that game.
	* _dataMovement.
	*/
	public function moveHistoryNextEntry():Void
	{
		PlayState.clientSocket.events.on("Move History Next Entry", function (_data)
		{
			// if this is true then do this event to get the spectator move history updated, getting the total moves in the move history for this game.
			if (RegTypedef._dataPlayers._spectatorWatching == true
			&&  RegTypedef._dataTournaments._move_piece == false)
			{
				var _step = RegTypedef._dataMovement._moveHistoryTotalCount = _data._moveHistoryTotalCount;
				
				Reg._moveHistoryPieceLocationOld1[_step] = Std.parseInt(_data._moveHistoryPieceLocationOld1);
						
				Reg._moveHistoryPieceLocationNew1[_step] = Std.parseInt(_data._moveHistoryPieceLocationNew1);
				Reg._gameYYnewB = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[_step]);
				Reg._gameXXnewB = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[_step]);
														
				Reg._moveHistoryPieceLocationOld2[_step] = Std.parseInt(_data._moveHistoryPieceLocationOld2);
				
				Reg._moveHistoryPieceLocationNew2[_step] = Std.parseInt(_data._moveHistoryPieceLocationNew2);
					
				Reg._moveHistoryPieceValueOld1[_step] = Std.parseInt(_data._moveHistoryPieceValueOld1);
				
				Reg._moveHistoryPieceValueNew1[_step] = Std.parseInt(_data._moveHistoryPieceValueNew1);
				
				Reg._moveHistoryPieceValueOld2[_step] = Std.parseInt(_data._moveHistoryPieceValueOld2);
				
				Reg._moveHistoryPieceValueNew2[_step] = Std.parseInt(_data._moveHistoryPieceValueNew2);
				
				RegTypedef._dataMovement._moveHistoryTotalCount = _data._moveHistoryTotalCount + 2;
					
				// this stops a crash and helps move pieces back to the beginning.
				Reg._step = Reg._moveHistoryPieceLocationOld1.length - 1;
				RegTypedef._dataMovement._history_get_all = 2;
			}
				
		});
	}
	
	/******************************
	* EVENT MOVE HISTORY ALL ENTRY.
	* the spectator has just joined the game room because there is currently only one move in that users history, do this event to get all the moves in the move history for this game.
	* when this RegTypedef._dataMovement._moveHistoryTotalCount has a value of one, the "Move History Next Entry" sends a request to the server for "Move History All Entry" event. at server Reg._moveHistoryPieceLocationOld and Reg._moveHistoryPieceLocationNew and the Reg._moveHistoryPieceValueOld and Reg._moveHistoryPieceValueNew are the unit move arrays that the server stores in the data base as a string. for example, the moves are stored in the Reg._moveHistoryPieceLocationNew as Reg._moveHistoryPieceLocationNew[0] = 24; Reg._moveHistoryPieceLocationNew[1] = 44; so server sends that data to MySQL as "24,44," string. then the server sends that string data here and here that data is string.split at "," then put into the Reg._moveHistoryPieceLocationNew array.
	* _dataMovement.
	*/
	public function moveHistoryAllEntry():Void
	{
		PlayState.clientSocket.events.on("Move History All Entry", function (_data)
		{
			if (RegTypedef._dataPlayers._spectatorWatching == true)
			{
				// this value is set to true at server if there was gameboard piece move data found in MySQL database.
				
				// at IDsCreateAndMain if this value is 1 then the gameboard will setup the pieces on the gameboard from the Reg._gamePointValueForPiece and Reg._gameUniqueValueForPiece data below.
				RegTypedef._dataMovement._history_get_all = _data._history_get_all;
				
				if (_data._history_get_all == 1)
				{
					// important. must clear all vars so that after game over the back history button works for moves in event "Move History All Entry". The vars cannot be cleared at Reg because they are passed to the Game room class.
					Reg._moveHistoryPieceLocationOld1.splice(0, Reg._moveHistoryPieceLocationOld1.length);
					Reg._moveHistoryPieceLocationNew1.splice(0, Reg._moveHistoryPieceLocationNew1.length);
					Reg._moveHistoryPieceLocationOld2.splice(0, Reg._moveHistoryPieceLocationOld2.length); 
					Reg._moveHistoryPieceLocationNew2.splice(0, Reg._moveHistoryPieceLocationNew2.length);
					Reg._moveHistoryPieceValueOld1.splice(0, Reg._moveHistoryPieceValueOld1.length);
					Reg._moveHistoryPieceValueNew1.splice(0, Reg._moveHistoryPieceValueNew1.length);
					Reg._moveHistoryPieceValueOld2.splice(0, Reg._moveHistoryPieceValueOld2.length);
					Reg._moveHistoryPieceValueNew2.splice(0, Reg._moveHistoryPieceValueNew2.length);
					Reg._step = 0;
					//------------------------------

					var _i = -1;
					var _p = -1;
					
					for (yy in 0...8)
					{
						for (xx in 0...8)
						{
							Reg._gamePointValueForPiece2[yy][xx] = 0;
							Reg._gameUniqueValueForPiece2[yy][xx] = 0;
						}
					}
					
					var _point_value = _data._point_value.split(",");
					var _unique_value = _data._unique_value.split(",");
										
					for (yy in 0...8)
					{
						for (xx in 0...8)
						{
							_p += 1;
							
							Reg._gamePointValueForPiece2[yy][xx] = Std.parseInt(_point_value[_p]);
							Reg._gameUniqueValueForPiece2[yy][xx] = Std.parseInt(_unique_value[_p]);
						}
					}
												
					// the old2 and new2 vars are for the second piece that may need to be moved. such as a chess promotion where a rook also needs moving.
					// here, the _data from the server is a string, such as moves "24,44," then split at "," and then stored here as an Array Int.
					var _moveHistory = Std.string(_data._moveHistoryPieceLocationOld1);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceLocationOld1[i] = Std.parseInt(_splitHistory[i]);
					}

					var _moveHistory = Std.string(_data._moveHistoryPieceLocationNew1);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceLocationNew1[i] = Std.parseInt(_splitHistory[i]);
						Reg._gameYYnewB = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[i]);
						Reg._gameXXnewB = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceLocationOld2);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceLocationOld2[i] = Std.parseInt(_splitHistory[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceLocationNew2);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceLocationNew2[i] = Std.parseInt(_splitHistory[i]);
					}
					
					
					
					
					var _moveHistory = Std.string(_data._moveHistoryPieceValueOld1);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceValueOld1[i] = Std.parseInt(_splitHistory[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceValueNew1);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceValueNew1[i] = Std.parseInt(_splitHistory[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceValueOld2);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceValueOld2[i] = Std.parseInt(_splitHistory[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceValueNew2);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceValueNew2[i] = Std.parseInt(_splitHistory[i]);
					}
					
					var _moveHistory = Std.string(_data._moveHistoryPieceValueOld3);
					var _splitHistory = _moveHistory.split(",");
					for (i in 0..._splitHistory.length-1)
					{
						Reg._moveHistoryPieceValueOld3[i] = Std.parseInt(_splitHistory[i]);
					}
					
					
					
					RegTypedef._dataMovement._moveHistoryTotalCount = _data._moveHistoryTotalCount;
					
					// this stops a crash and helps move pieces back to the beginning.
					Reg._step = RegTypedef._dataMovement._moveHistoryTotalCount - 1;
									
				}	
				
				Reg._createGameRoom = true;
			}

		});
	}	
	
	/******************************
	* EVENT LEADERBOARDS
	* display a 50 player list of the players with the top experience points.
	* _dataLeaderboards.
	*/
	public function leaderboards():Void
	{
		PlayState.clientSocket.events.on("Leaderboards", function (_data)
		{
			RegTypedef._dataLeaderboards._usernames = Std.string(_data._usernames); 
			RegTypedef._dataLeaderboards._experiencePoints = Std.string(_data._experiencePoints);
			
			RegTriggers._leaderboards_show = true;
		});
	}	
	
	/******************************
	* EVENT DAILY QUESTS
	* complete these daily quests for rewards.
	*/
	public function dailyQuests():Void
	{
		PlayState.clientSocket.events.on("Daily Quests", function (_data)
		{
			RegTypedef._dataDailyQuests._three_in_a_row = Std.string(_data._three_in_a_row);
			RegTypedef._dataDailyQuests._chess_5_moves_under = Std.string(_data._chess_5_moves_under);
			RegTypedef._dataDailyQuests._snakes_under_4_moves = Std.string(_data._snakes_under_4_moves);
			RegTypedef._dataDailyQuests._win_5_minute_game = Std.string(_data._win_5_minute_game);
			RegTypedef._dataDailyQuests._buy_four_house_items = Std.string(_data._buy_four_house_items);
			RegTypedef._dataDailyQuests._finish_signature_game = Std.string(_data._finish_signature_game);
			RegTypedef._dataDailyQuests._reversi_occupy_50_units = Std.string(_data._reversi_occupy_50_units);
			RegTypedef._dataDailyQuests._checkers_get_6_kings = Std.string(_data._checkers_get_6_kings);
			RegTypedef._dataDailyQuests._play_all_5_board_games = Std.string(_data._play_all_5_board_games);
			RegTypedef._dataDailyQuests._rewards = Std.string(_data._rewards);
			
			
			RegTriggers.__daily_quests = true;
		});
	}
	
}//