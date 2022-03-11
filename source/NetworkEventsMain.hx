/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if house
	import modules.house.*;
#end

#if checkers
	import modules.games.checkers.*;
#end

#if chess
	import modules.games.chess.*;
#end

#if reversi
	import modules.games.reversi.*;
#end

#if wheelEstate
	import modules.games.wheelEstate.*;
#end

/**
 * network events main.
 * @author kboardgames.com
 */

class NetworkEventsMain extends FlxState
{	
	public var _text_client_login_data2:FlxText;
	public var _text_client_login_data3:FlxText;	
	public var _text_client_login_data4:FlxText;
	
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
	
	#if	chess
		private var __chess_check_or_checkmate:ChessCheckOrCheckmate;
	#end
	
	override public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw, data:Dynamic, scene_lobby:SceneLobby, scene_create_room:SceneCreateRoom, scene_waiting_room:SceneWaitingRoom):Void
	{
		super();
		
		_data = data;
		
		__scene_lobby = scene_lobby;
		__scene_create_room = scene_create_room;
		__scene_waiting_room = scene_waiting_room;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		#if chess
			__chess_check_or_checkmate = new ChessCheckOrCheckmate(__ids_win_lose_or_draw);
			add(__chess_check_or_checkmate);
		#end
		
		// set a close event. If the server exits or crashes then do the following.
		PlayState._websocket.onclose = function()
		{
			trace("disconnected"); // do not remove.
			
			PlayState._websocket = null;
			PlayState.updateInfo();
			
			// show server disconnected message only if not in public mode and if user has not logged in more than once.
			if (Reg._same_device_login_more_than_once == false
			&&	Reg._alreadyOnlineHost == false
			&&	Reg._same_device_login_more_than_once == false
			&&	Reg._alreadyOnlineUser == false)
				Reg._serverDisconnected = true;
			
			// if "x" button was not clicked.
			if (Reg._disconnectNow == false)
				Reg._ping_time_expired = true;
			
			FlxG.switchState(new MenuState());
			return;
		};
	}
	
	public static function gotoMovePlayerEvent():Void
	{
		// send _player _data to server so that server can send that _data to all other clients.
		switch (Reg._gameId)
		{
			case 0: PlayState.send("Player Move Id 0", RegTypedef._dataGame0);
			case 1:	PlayState.send("Player Move Id 1", RegTypedef._dataGame1);
			case 2: PlayState.send("Player Move Id 2", RegTypedef._dataGame2);
			case 3: PlayState.send("Player Move Id 3", RegTypedef._dataGame3);
			case 4: PlayState.send("Player Move Id 4", RegTypedef._dataGame4);
		}
	}
	
	public function defenderOrAttcker():Void
	{
		// 	PLAYER MOVING KING: check for blocking units.
		RegFunctions.is_player_attacker(false); // a value of false then the player is the defender.
			
		// this is both host and not host players. if at host and you want to target the host then use Reg._playerMoving. if you are at not host and want to target that player then use the same var. Reg._playerNotMoving is always the other player.
		
		if (Reg._gameHost == false)
		{
			RegFunctions.is_player_attacker(true);
		}		
	}	
	
	public function events(_data:Dynamic):Void
	{
		switch(_data._event_name)
		{
			// player moves piece.
			case "Player Move Id 0":
				playerMoveId0(_data);
			
			case "Player Move Id 1":
				playerMoveId1(_data);
				
			case "Player Move Id 2":
				playerMoveId2(_data);
				
			case "Player Move Id 3":
				playerMoveId3(_data);
				
			case "Player Move Id 4":
				playerMoveId4(_data);
				
			// this function is called after this client connects to the server.
			case "Join":
				join(_data);
			
			// the player is logging in.
			case "Is Logging In":
				isLoggingIn(_data);
			
			// players house where they buy items, place items in room and vote for best house for prizes.
			case "House Load":
				houseLoad(_data);
			
			// Get Statistics Win Loss Draw, such as, wins and draws.
			case "Get Statistics Win Loss Draw":
				getStatisticsWinLossDraw(_data);
			
			// verifies if the email address is valid. validation code could be sent to a user's email address.
			case "Email Address Validate":
				emailAddressValidate(_data);
			
			// get all stats such as experience points, credits, wins, etc.
			case "Get Statistics All":
				getStatisticsAll(_data);
			
			// event player has entered the room, so change the roomState value.
			case "Greater RoomState Value":
				greaterRoomStateValue(_data);
			
			// event player has left the room, so change the roomState value.
			case "Lesser RoomState Value":
				lesserRoomStateValue(_data);
			
			// save room data to database. able to put user into room.
			case "Set Room Data":
				setRoomData(_data);
			
			// load room data from database.
			case "Get Room Data":
				getRoomData(_data);
			
			// return all vars to 0 for player, so that lobby data can be calculated to display data at lobby correctly.
			case "Returned To Lobby":
				returnedToLobby(_data);
			
			case "Is Room Locked":
				isRoomLocked(_data);
			
			// used to unlock the room at server and to stop entering a room the second time until ticks are used to update the lobby buttons at client.
			case "Room Lock 1":
				roomLock1(_data); 
			
			case "Get Room Players":
				getRoomPlayers(_data);
			
			// the players chat message.
			case "Chat Send":
				chatSend(_data);
			
			// an example of this would be a chess game where a player just received a message saying that the king is in check. this event sends that same message to the other party.
			case "Game Message Not Sender":
				gameMessageNotSender(_data);
			
			// Message box used for spectator Watching.
			case "Game Message Box For Spectator Watching":
				gameMessageBoxForSpectatorWatching(_data);
			
			// a command so that player cannot play for some time.
			case "Message Kick":
				messageKick(_data);
			
			// a command so that player cannot play again.
			case "Message Ban":
				messageBan(_data);
			
			// offer draw so that it is a tie.
			case "Draw Offer":
				drawOffer(_data);
			
			// draw reply.
			case "Draw Answered As":
				drawAnsweredAs(_data);
			
			// offer game restart so that another game can be played.
			case "Restart Offer":
				restartOffer(_data);
			
			// game restart reply.
			case "Restart Answered As":
				restartAnsweredAs(_data);
			
			// offer an invite to a player at the lobby.
			case "Online Player Offer Invite":
				onlinePlayerOfferInvite(_data);
			
			// this event enters the game room.
			case "Enter Game Room":
				enterGameRoom(_data);
			
			// win text using a message popup.
			case "Game Win":
				gameWin(_data);
			
			// lose text using a message popup.
			case "Game Lose":
				gameLose(_data);
			
			// win text using a message popup then lose message box for the other player.
			case "Game Win Then Lose For Other":
				gameWinThenLoseForOther(_data);
			
			// lose text using a message popup, then win message box for the other player.
			case "Game Lose Then Win For Other":
				gameLoseThenWinForOther(_data);
			
			// draw text using a message popup.
			case "Game Draw":
				gameDraw(_data);
			
			// increase the win stat by 1.
			case "Save Win Stats":
				saveWinStats(_data);
			
			// increase the lose stat by 1.
			case "Save Lose Stats":
				saveLoseStats(_data);
			
			// increase the win stat by 1, and other player lose by 1.
			case "Save Win Stats For Both":
				saveWinStatsForBoth(_data);
			
			// increase the lose stat by 1 and the other player win by 1.
			case "Save Lose Stats For Both":
				saveLoseStatsForBoth(_data);
			
			// increase the draw stat by 1.
			case "Save Draw Stats":
				saveDrawStats(_data);
			
			// gets the selected tournament data.
			case "Tournament Chess Standard 8 Get":
				tournamentChessStandard8Get(_data);
			
			// puts the selected tournament data to the MySQL database.
			case "Tournament Chess Standard 8 Put":
				tournamentChessStandard8Put(_data);
			
			// 0: not subscribed to mail. 1: true.
			case "Tournament Reminder By Mail":
				tournamentReminderByMail (_data);
			
			// 0: removed from tournament. 1: joined.
			case "Tournament Participating":
				tournamentParticipating(_data);
			
			// Trigger an event that the player has left the game room.
			case "Player Left Game Room":
				playerLeftGameRoom(_data);
			
			// Trigger an event that the player has left the game.
			case "Player Left Game":
				playerLeftGame(_data);
			
			// save a var to mySql so that someone cannot invite when still in game room. also, triggers a var called Reg._gameOverForAllPlayers to equal true so that the game has ended for everyone.
			case "Game Is Finished":
				gameIsFinished(_data);
			
			// false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
			case "Is Game Finished":
				isGameFinished(_data);
					
			case "Game Players Values":
				gamePlayersValues(_data);
			
			// list of online players with stats. used to invite.
			case "Logged In Users":
				loggedInUsers(_data);
			
			// refers to an action, eg, 1 = kick. see the "Action By Player" event at server.
			case "Action By Player":
				actionByPlayer(_data);
			
			// gets the current move timer for the player that is moving. the value is sent to the other clients so that they have the update value.
			case "Player Move Time Remaining":
				playerMoveTimeRemaining(_data);
			
			case "Is Action Needed For Player":
				isActionNeededForPlayer(_data);
			
			// at signature game, a unit trade is proposed to a waiting to move player.
			case "Trade Proposal Offer":
				tradeProposalOffer(_data);
			
			// what did the player answer as the trade request message box!
			case "Trade Proposal Answered As":
				tradeProposalAnsweredAs(_data);
			
			// user who requested to watch a game. this can be a message such as "checkmate" or "restarting game". also, any var needed to start or stop a game will be passed here.
			case "Spectator Watching":
				spectatorWatching(_data);
			
			// send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
			case "Spectator Watching Get Move Number":
				spectatorWatchingGetMoveNumber(_data);
			
			// every player that moves a piece will use the host of the room to call this event so to update the move history at MySQL. this is needed so that when a spectator watching enters the room, that person can get all the move history for that game.
			case "Move History Next Entry":
				moveHistoryNextEntry(_data);
			
			// the spectator has just joined the game room because there is currently only one move in that users history, do this event to get all the moves in the move history for this game.
			case "Move History All Entry":
				moveHistoryAllEntry(_data);
			
			case "Leaderboards":
				leaderboards(_data);
			
			// complete these daily quests for rewards.
			case "Daily Quests":
				dailyQuests(_data);
			
			// makes all clients move the same piece at the same time.
			case "Movement":
				movement(_data);
				
			case "Disconnect All By Server":
				disconnectAllByServer(_data);
		}
		
		_data._event_name = "";
	}
		
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. checkers. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId0(_data:Dynamic):Void
	{
		#if checkers
			if (_data._room == RegTypedef._dataGame._room)
			{
				defenderOrAttcker();
				
				if (_data.id == RegTypedef._dataGame.id) 
				{
					GameClearVars.clearVarsOnMoveUpdate();
					CheckersCapturingUnits.capturingUnits();
									
					return; // return if this is the client that first moved the _player.
				}
				
				if (Reg._playerLeftGame == true ) return;
				
			// true if this instance matches the unit number that the player would like to move to.
				Reg._gameUnitNumberNew = _data._gameUnitNumberNew;
				Reg._gameUnitNumberOld = _data._gameUnitNumberOld;
				
				if (RegTypedef._dataPlayers._spectatorWatching == false
				)
				{
					Reg._gameXXnew = _data._gameXXnew;
					Reg._gameYYnew = _data._gameYYnew;
					Reg._gameXXold = _data._gameXXold;
					Reg._gameYYold = _data._gameYYold;	
					Reg._gameXXold2 = _data._gameXXold2;
					Reg._gameYYold2 = _data._gameYYold2;
				}
				
				else
				{
					Reg._gameXXnew = -1;
					Reg._gameYYnew = -1;
				}					
				
				Reg._triggerNextStuffToDo = _data._triggerNextStuffToDo;
				Reg._isThisPieceAtBackdoor = _data._isThisPieceAtBackdoor;
				
				Reg._checkersFoundPieceToJumpOver = false;

				if (Reg._gameYYnew != -1 && Reg._gameXXnew != -1)
				CheckersCapturingUnits.jumpCapturingUnitsForPiece(Reg._gameYYnew, Reg._gameXXnew, Reg._playerMoving);
				
				if (Reg._checkersFoundPieceToJumpOver == true)
					Reg._checkersIsThisFirstMove = false;
				
				
				Reg._move_number_next += 1;
													
				// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
				if (Reg._move_number_next >= 2)
				Reg._move_number_next = 0;
				
				if (Reg._gameUnitNumberNew > -1 
				&&	RegTypedef._dataPlayers._spectatorWatching == false) 
				{				
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1;
					Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
					Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold];
					Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._otherPlayer = true;
					
					GameClearVars.clearVarsOnMoveUpdate();				
					CheckersCapturingUnits.capturingUnits();	
					HUD.gameTurns(Reg._gameYYnew, Reg._gameXXnew); // each player has 50 turns at start of game. when a player has no more turns then the game is a draw.
					
					GameClearVars.clearCheckAndCheckmateVars();
				}	
				
				__ids_win_lose_or_draw.canPlayerMove1();
			}
		#end
	}

	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. chess. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId1(_data:Dynamic):Void
	{
		#if chess
			if (_data._room == RegTypedef._dataGame._room)
			{
				defenderOrAttcker();
				
				if (_data.id == RegTypedef._dataGame.id) 
				{
					GameClearVars.clearVarsOnMoveUpdate();
					ChessCapturingUnits.capturingUnits();
													
					return; // return if this is the client that first moved the _player.
				}
				
				if (Reg._playerLeftGame == true ) return;
				
				Reg._gameUnitNumberNew = _data._gameUnitNumberNew;
				Reg._gameUnitNumberOld = _data._gameUnitNumberOld;
				Reg._gameUnitNumberNew2 = _data._gameUnitNumberNew2;
				Reg._gameUnitNumberOld2 = _data._gameUnitNumberOld2;
				
				Reg._imageValueOfUnitOld3 = _data._piece_capturing_image_value;
				
				if (RegTypedef._dataPlayers._spectatorWatching == false
				)
				{
					Reg._gameXXnew = _data._gameXXnew;
					Reg._gameYYnew = _data._gameYYnew;
					Reg._gameXXold = _data._gameXXold;
					Reg._gameYYold = _data._gameYYold;	
					Reg._gameXXnew2 = _data._gameXXnew2;
					Reg._gameYYnew2 = _data._gameYYnew2;
					Reg._gameXXold2 = _data._gameXXold2;
					Reg._gameYYold2 = _data._gameYYold2;
				}
				
				else
				{
					Reg._gameXXnew = -1;
					Reg._gameYYnew = -1;
					Reg._gameXXnew2 = -1;
					Reg._gameYYnew2 = -1;
				}				
				
				Reg._isEnPassant = _data._isEnPassant;
				Reg._chessEnPassantPawnNumber = _data._isEnPassantPawnNumber;
				Reg._triggerNextStuffToDo = _data._triggerNextStuffToDo;
				Reg._pointValue2 = _data._pointValue2;
				Reg._uniqueValue2 = _data._uniqueValue2;
				Reg._promotePieceLetter = _data._promotePieceLetter;
				Reg._doneEnPassant = _data._doneEnPassant;
				
				Reg._move_number_next += 1;
													
				// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
				if (Reg._move_number_next >= 2)
				Reg._move_number_next = 0;
				
				if (_data._gameMessage == "Check" || _data._gameMessage == "Checkmate")
				{
					Reg._chessOriginOfCheckY[Reg._playerMoving] = Reg._gameYYnew;
					Reg._chessOriginOfCheckX[Reg._playerMoving] = Reg._gameXXnew;
				}
			
				if (Reg._gameUnitNumberNew > -1) 
				{				
					GameHistoryAndNotations.notationX();

					Reg._otherPlayer = false;
					Reg._gameDidFirstMove = false;
					HUD.gameTurns(Reg._gameYYnew, Reg._gameXXnew); // each player has 50 turns at start of game. when a player has no more turns then the game is a draw.
					
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1;
					Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
					Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold];
					
					// is this a chess promoted piece?
					if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1 || Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11)
					{
						// is the pawn at the unit where it can be promoted...
						if (Reg._gameYYnew == 0 || Reg._gameYYnew == 7)
						{
							Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = _data._pieceValue;
							Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = _data._uniqueValue;
							Reg._chessPawnPromotedMessage = true;
							
							openSubState( new ChessPromote());
						}
					}
					
					
					Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._otherPlayer = true;
					
					GameClearVars.clearVarsOnMoveUpdate();				
					ChessEnPassant.getVarsFromOtherPlayer();		
					ChessCapturingUnits.capturingUnits();	
					__chess_check_or_checkmate.isThisCheckOrCheckmate();
					
					
					GameClearVars.clearCheckAndCheckmateVars();
				}		
				
				__ids_win_lose_or_draw.canPlayerMove1();
			}
		#end
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. Reversi. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId2(_data:Dynamic):Void
	{
		#if reversi
			if (_data._room == RegTypedef._dataGame._room)
			{
				defenderOrAttcker();
				
				if (_data.id == RegTypedef._dataGame.id) 
				{
					GameClearVars.clearVarsOnMoveUpdate();
					
					Reg._otherPlayer = false;
					Reg._gameDidFirstMove = false;
					Reg._playerCanMovePiece = false;
					ReversiCapturingUnits.capturingUnits();					
					
					
					return; // return if this is the client that first moved the _player.
				}
				
				if (Reg._playerLeftGame == true ) return;
				
				//Reg._gameUnitNumberNew = _data._gameUnitNumberNew;
				//Reg._gameUnitNumberOld = _data._gameUnitNumberOld;
				//Reg._gameUnitNumberNew2 = _data._gameUnitNumberNew2;
				//Reg._gameUnitNumberOld2 = _data._gameUnitNumberOld2;
				Reg._gameXXold = _data._gameXXold;
				Reg._gameYYold = _data._gameYYold;
				Reg._pointValue2 = _data._pointValue2;
				Reg._triggerNextStuffToDo = _data._triggerNextStuffToDo;
									
				Reg._otherPlayer = true;					
				Reg._playerCanMovePiece = true;
				Reg._reversiMovePiece = true;
				Reg._gameDidFirstMove = true;
				Reg._reversiReverseIt = true;
				
				RegFunctions.is_player_attacker(false);
				
				GameClearVars.clearVarsOnMoveUpdate();				
				GameClearVars.clearCheckAndCheckmateVars();			
				
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._gameYYold != -1 && Reg._gameXXold != -1) 
				{
					ReversiCapturingUnits.capturingUnits();
					Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = Reg._pointValue2; // the other player's piece that was moved.
					ReversiCapturingUnits.findCapturingUnits();			
					
				}
				Reg._reversiReverseIt2 = true;
				Reg._reversiReverseIt = false;
				
				Reg._move_number_next += 1;
													
				// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
				if (Reg._move_number_next >= 2)
				Reg._move_number_next = 0;
				
				__ids_win_lose_or_draw.canPlayerMove1();
			}
		#end
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. snakes and ladders. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId3(_data:Dynamic):Void
	{
		if (_data._room == RegTypedef._dataGame._room)
		{
			defenderOrAttcker();
			
			if (_data.id == RegTypedef._dataGame.id) 
			{
				GameClearVars.clearVarsOnMoveUpdate();
				
				if (RegTriggers._eventForAllPlayers == true)
				{
					Reg._triggerNextStuffToDo = 0;
					RegTriggers._snakesAndLaddersRollAgainMessage = false;
				
				}
								
				return; // return if this is the client that first moved the _player.
			}
			
			if (Reg._playerLeftGame == true ) return;
			
			Reg._rolledA6 = _data._rolledA6;
			Reg._backdoorMoveValue = _data._gameUnitNumberNew;
			Reg._triggerNextStuffToDo = _data._triggerNextStuffToDo;
			RegTriggers._eventForAllPlayers = _data._triggerEventForAllPlayers; // if true then both players piece will move at the same time.
			
			if (RegTriggers._eventForAllPlayers == true)
			{			
				if (Reg._triggerNextStuffToDo == 1)
				{
					Reg._triggerNextStuffToDo = 2;	
					Reg._isThisPieceAtBackdoor = true;	
				}
				
				if (Reg._triggerNextStuffToDo == 0)
				{
					RegTriggers._snakesAndLaddersRollAgainMessage = false;
					
					Reg._move_number_next += 1;
														
					// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
					if (Reg._move_number_next >= 2)
					Reg._move_number_next = 0;	

				}
			}

			
			__ids_win_lose_or_draw.canPlayerMove1();	
		}
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. signature game. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId4(_data:Dynamic):Void
	{
		#if wheelEstate
			if (_data._room == RegTypedef._dataGame._room)
			{
				defenderOrAttcker();
				
				if (_data.id == RegTypedef._dataGame.id) 
				{
					GameClearVars.clearVarsOnMoveUpdate();
					if (Reg._game_online_vs_cpu == false)
					{
						Reg._triggerNextStuffToDo = 3;
						Reg._isThisPieceAtBackdoor = false; 
						Reg._playerCanMovePiece = false;		
						Reg._gameDidFirstMove = false;
					}					
					return; // return if this is the client that first moved the _player.
				}
			
				if (Reg._playerLeftGame == true ) return;
				
				Reg._gameXXold = _data._gameXXold; 
				Reg._gameYYold = _data._gameYYold;
				Reg._gameXXnew = _data._gameXXnew; // this var is being used.
				Reg._gameYYnew = _data._gameYYnew;	
				
				// used in trade unit. this is the other player's unit. player moving would like to trade other player's unit.
				Reg._gameXXold2 = _data._gameXXold2; 
				Reg._gameYYold2 = _data._gameYYold2;
				
				// used in trade unit. this is the player that is moving piece. player would like to trade this unit.
				Reg._gameXXnew2 = _data._gameXXnew2;
				Reg._gameYYnew2 = _data._gameYYnew2;
				
				Reg._gameUniqueValueForPiece = _data._gameUniqueValueForPiece; 
				Reg._signatureGameUnitNumberTrade = _data._unitNumberTrade;
				Reg._gameUniqueValueForPiece = _data._gameUniqueValueForPiece;
				Reg._gameHouseTaxiCabOrCafeStoreForPiece = _data._gameHouseTaxiCabOrCafeStoreForPiece;
				Reg._gameUndevelopedValueOfUnit = _data._gameUndevelopedValueOfUnit;
				
				Reg._triggerNextStuffToDo = 1;
				Reg._gameDidFirstMove = false;
				
				if (Reg._game_online_vs_cpu == false) 
					SignatureGameMovePlayersPiece.changePlayer();
				
				__ids_win_lose_or_draw.canPlayerMove1();
				
			}
		#end
	}
	
	/******************************
	 * EVENT JOIN	
	 */
	public function join(_data:Dynamic):Void
	{
		if (_data.id != RegTypedef._dataAccount.id) return;
		
		if (_data._username_banned != "")
		{
			Reg._username_banned = true;
			FlxG.switchState(new MenuState());
		}
		
		RegTypedef._dataAccount = _data;
		
		PlayState._text_client_login_data.text = "Clients Data.\n\n";
		PlayState._text_client_login_data.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		
		if (_text_client_login_data2 == null)
		{		
			_text_client_login_data2 = new TextGeneral(15, FlxG.height / 2 - 200 + 80, 0, "Logging in as: " + RegTypedef._dataAccount._username + ".\n", 8);
			_text_client_login_data2.scrollFactor.set(0, 0);
			_text_client_login_data2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_text_client_login_data2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			add(_text_client_login_data2);
		}
		
		if (_text_client_login_data3 == null)
		{
			_text_client_login_data3 = new TextGeneral(15, _text_client_login_data2.y + 80, 0, "IP Address: " + _data._ip + ".\n");
			_text_client_login_data3.scrollFactor.set(0, 0);
			_text_client_login_data3.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_text_client_login_data3.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			add(_text_client_login_data3);
		}
		
		if (_text_client_login_data4 == null)
		{
			_text_client_login_data4 = new TextGeneral(15, _text_client_login_data3.y + 80, 0, "Hostname: " + _data._hostname + ".\n");
			_text_client_login_data4.scrollFactor.set(0, 0);
			_text_client_login_data4.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_text_client_login_data4.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			add(_text_client_login_data4);
		}
		
		Reg._isLoggingIn = true;
		PlayState.allTypedefUsernameUpdate(RegTypedef._dataAccount._username);
		
	}	
		
	
	/******************************
	* EVENT IS LOGGED IN
	*/
	public function isLoggingIn(_data:Dynamic):Void
	{
		if (_data._popupMessage == "Login failed.")
		{
			Reg._login_failed = true;				
			Reg._client_socket_is_connected = false;
			PlayState._websocket.close();
			
			FlxG.switchState(new MenuState());
			
		}
		
		else if (_data._popupMessage == "Login successful.") // if you change the value of this string then you need to change it also at server.
		{
			Reg._username = RegTypedef._dataAccount._username = RegTypedef._dataMisc._username = RegTypedef._dataHouse._username = _data._username;
			
			PlayState.allTypedefUsernameUpdate(_data._username);
			
			Reg._loggedIn = true; 
			
			PlayState._text_client_login_data.visible = false;
			_text_client_login_data2.visible = false;
			_text_client_login_data3.visible = false;
			_text_client_login_data4.visible = false;
			PlayState._text_logging_in.visible = false;
			
			PlayState.allTypedefUsernameUpdate(Reg._username);
			
			PlayState.send("Get Statistics All", RegTypedef._dataStatistics);
			
			RegTriggers._lobby = true;
		}
	
	}
		
	/******************************
	* EVENT HOUSE LOAD.
	* players house where they buy items, place items in room and vote for best house for prizes.
	* _dataHouse
	*/
	private function houseLoad(_data:Dynamic):Void
	{
		#if house
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
			
			/*
			RegTypedef._dataMisc._roomCheckForLock[0] = 0;
			PlayState.send("Get Room Data", RegTypedef._dataMisc);
			
			*/
			#if html5
				RegTypedef._dataStatistics._houseCoins = 1000;
			#end
		#end		
	}
		
	/******************************
	* EVENT PLAYER MOVE TIME REMAINING
	* Gets the current move timer for the player that is moving. the value is sent to the other clients so that they have the update value.
	*/
	public function playerMoveTimeRemaining(_data:Dynamic):Void
	{
		// only for players in the same room but not for the player who sent the data.
		if (_data._room == RegTypedef._dataPlayers._room && _data.id != RegTypedef._dataPlayers.id)
		{
			RegTypedef._dataPlayers._moveTimeRemaining[0] = RegTypedef._dataStatistics._moveTimeRemaining[0] = _data._moveTimeRemaining[0];
							
			RegTypedef._dataPlayers._moveTimeRemaining[1] = RegTypedef._dataStatistics._moveTimeRemaining[1] =  _data._moveTimeRemaining[1];
			
			RegTypedef._dataPlayers._moveTimeRemaining[2] = RegTypedef._dataStatistics._moveTimeRemaining[2] = _data._moveTimeRemaining[2];
			
			RegTypedef._dataPlayers._moveTimeRemaining[3] = RegTypedef._dataStatistics._moveTimeRemaining[3] = _data._moveTimeRemaining[3];
			
		}
	}
			
	/******************************
	* EVENT GAME MESSAGE.	
	* send a general message such as check or checkmate to the other player.
	* _dataGameMessage
	*/
	public function gameMessageNotSender(_data:Dynamic):Void
	{
		if (_data._room == RegTypedef._dataGameMessage._room && _data.id != RegTypedef._dataGameMessage.id && Reg._gameOverForPlayer == false)
		{
			Reg._messageBoxNoUserInput = _data._gameMessage;		

			if (Reg._messageBoxNoUserInput == "Roll dice again.")
			{
				RegTriggers._snakesAndLaddersRollAgainMessage = true;		
			}
			
			
			else if (Reg._messageBoxNoUserInput == "Check" && Reg._chessCheckBypass == false) 
			{
				GameHistoryAndNotations._message_for_scrollable_area.text = GameHistoryAndNotations._message_for_scrollable_area.text.substr(0, GameHistoryAndNotations._message_for_scrollable_area.text.length);
				
				GameHistoryAndNotations._message_for_scrollable_area.text = GameHistoryAndNotations._message_for_scrollable_area.text + "+";
			}
			
			if (Reg._messageBoxNoUserInput == "Checkmate" && Reg._chessCheckBypass == false) 
			{
				GameHistoryAndNotations._message_for_scrollable_area.text = GameHistoryAndNotations._message_for_scrollable_area.text.substr(0, GameHistoryAndNotations._message_for_scrollable_area.text.length);
				
				GameHistoryAndNotations._message_for_scrollable_area.text = GameHistoryAndNotations._message_for_scrollable_area.text + "++";
			}
							
			if (Reg._messageBoxNoUserInput != "") 
			{					
				RegTypedef._dataGameMessage._gameMessage = Reg._messageBoxNoUserInput;
			}			
					
			Reg._outputMessage = true;
		}// else Reg._rolledA6 = false;
	}
		
	/******************************
	* EVENT GAME MESSAGE.	
	* send a general message such as check or checkmate to the other player.
	* _dataGameMessage
	*/
	public function gameMessageBoxForSpectatorWatching(_data:Dynamic):Void
	{
		if (RegTypedef._dataMisc._spectatorWatching == true)
		{
			RegTypedef._dataGameMessage._userFrom = _data._userFrom;
			RegTypedef._dataGameMessage._gameMessage = _data._gameMessage;
			RegTriggers._eventSpectatorWatchingMessageBoxMessages = true;
		}
	}
	
	/******************************
	* EVENT MESSAGE KICK.	
	* admin sent a kick command so that the user cannot play for some time.
	*/
	public function messageKick(_data:Dynamic):Void
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
			PlayState.send("Remove Kicked From User", RegTypedef._dataMisc);				
		}
	}
	
	/******************************
	* EVENT MESSAGE BAN.	
	* admin sent a ban command so that the user cannot play this game anymore.
	*/
	public function messageBan(_data:Dynamic):Void
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
		
		PlayState.send("Message Kick", RegTypedef._dataMisc);	
	}
	
	/******************************
	* EVENT CHAT SEND.
	* send chat text to other user using chatter
	* _dataMisc
	*/
	public function chatSend(_data:Dynamic):Void
	{
		if (RegTypedef._dataPlayers._usernamesDynamic[0] == _data._username
		 || RegTypedef._dataPlayers._usernamesDynamic[1] == _data._username
		 || RegTypedef._dataPlayers._usernamesDynamic[2] == _data._username
		 || RegTypedef._dataPlayers._usernamesDynamic[3] == _data._username
		 || RegTypedef._dataMisc._userLocation == 0 )
		 {
			GameChatter.chatSent(Std.string(_data._username) + ": ", Std.string(_data._chat));
		 }
	}
	
	/******************************
	* EVENT GET STATISTICS WIN LOSS DRAW
	* gets the Win - Draw - Loss Stats for player(s).
	* _dataPlayers
	*/
	public function getStatisticsWinLossDraw(_data:Dynamic):Void
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
				
				if (_data.id == RegTypedef._dataPlayers.id)
				{
					PlayState.send("Logged In Users", RegTypedef._dataOnlinePlayers);				
				}
				
				else
				{
					if (RegTypedef._dataMisc._userLocation > 0)	
					{
						__scene_waiting_room.mainButtonsAndTexts();
						SceneWaitingRoom.updateUsersInRoom();					}
					
				}
				
				
				SceneWaitingRoom.__menu_bar._button_refresh_list.active = true;
				SceneWaitingRoom.__menu_bar._button_refresh_list.visible = true;	
				
				SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.active = true;
				SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.visible = true;
				
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
					//if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();
					
					Reg._playerCanMovePiece = false;	
					//Reg._createGameRoom = true;
					
					PlayState._clientDisconnectDo = false;
					PlayState.send("Is Game Finished", RegTypedef._dataPlayers);
					
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
	}
		
	/******************************
	* EVENT GET STATISTICS All
	* Example, experience points, credits, win - draw - loss, all stats.
	* _dataPlayers
	*/
	public function getStatisticsAll(_data:Dynamic):Void
	{
		RegTypedef._dataStatistics = _data;
		
		if (Reg2._miscMenuIparameter == 30)
			RegTriggers._miscellaneousMenuOutputClassActive = true;
			
		SceneLobby._lobby_data_received = false;
	}
		
	/******************************
	* EVENT PLAYER HAS ENTERED THE ROOM, SO CHANGE THE RoomSTATE.
	* _miscData
	*/
	public function greaterRoomStateValue(_data:Dynamic):Void
	{
		if (_data.id == RegTypedef._dataMisc.id)
		{
			RegTypedef._dataMisc = _data; // _data give an invalid call error.
			// tournament play.
			if (RegTypedef._dataMisc._room == SceneLobby._room_total)
				RegTypedef._dataMisc._roomGameIds[SceneLobby._room_total] = Reg._gameId = 1;
				
			if (_data._roomLockMessage == "" && _data._userLocation <= 2)
			{
				_data._roomState[_data._room] += 1;
				
				PlayState.send("Set Room Data", _data);					
				
				if (SceneCreateRoom.__menu_bar._buttonCreateRoom.visible == true)
					_data._roomState[_data._room] -= 1;
			}
			
			else PlayState.send("Set Room Data", _data);
			
			// this code needs to stay here. if moved up top a room cannot be entered. the _data._roomState above changes this value.
			Reg._currentRoomState = _data._roomState[_data._room];
			
			RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
			Reg._playerIDs = -1;
		}			
	}
	
	/******************************
	* EVENT PLAYER HAS LEFT THE ROOM, SO CHANGE THE RoomSTATE.
	* _dataMisc
	*/
	public function lesserRoomStateValue(_data:Dynamic):Void
	{
		if (_data.id == RegTypedef._dataMisc.id)
		{
			RegTypedef._dataMisc._roomLockMessage = "";
			RegTypedef._dataMisc._roomState = _data._roomState;
			RegTypedef._dataMisc._roomState[_data._room] = 0;
			RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;
			RegTypedef._dataMisc._roomPlayerLimit[_data._room] = 0;
			//RegTypedef._dataMisc._room = 0;
			PlayState.allTypedefRoomUpdate(0);
			
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
			
			SceneCreateRoom.__menu_bar._buttonReturnToLobby.visible = false;
			SceneCreateRoom.__menu_bar._buttonReturnToLobby.active = false;
			
			SceneCreateRoom.__menu_bar._buttonCreateRoom.visible = false;
			SceneCreateRoom.__menu_bar._buttonCreateRoom.active = false;

			RegTypedef._dataMisc._room = 0; // returning to the lobby
			RegTypedef._dataMisc._userLocation = 0;
					
			// event at lobby, so return all vars to 0 for player, so that lobby data can be calculated to display data at lobby correctly.				
			PlayState.send("Returned To Lobby", RegTypedef._dataMisc);				
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
			
		// anything added below this line... remember that we are at lobby but _data_room data does not equal 0. the reason is anyone at lobby can set back a room to zero. see the code block above this line.
	}
	
	/******************************
	* EVENT SET ROOM DATA. SAVE ROOM DATA TO DATABASE.
	* _miscData
	*/
	public function setRoomData(_data:Dynamic):Void
	{
		if (Reg._playerLeftGame == false)
		{
			RegTypedef._dataMisc._roomState = _data._roomState;
			RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;		
			RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;
			RegTypedef._dataMisc._roomHostUsername = _data._roomHostUsername;
			RegTypedef._dataMisc._gid = _data._gid;
			RegTypedef._dataMisc._allowSpectators = _data._allowSpectators; 
			
			//PlayState.send("Get Room Data", _data); // update data for lobby.
			//
			
			if (Reg._game_online_vs_cpu == false)
			{
				if (RegTypedef._dataPlayers._spectatorWatching == true)
				{
					
					PlayState.send("Move History All Entry", RegTypedef._dataMovement); 			
				}
				
				else if (SceneCreateRoom.__menu_bar._buttonCreateRoom.visible == false 
				&&  Reg._currentRoomState == 2)
				{
					SceneCreateRoom.__menu_bar._buttonReturnToLobby.active = true;
					SceneCreateRoom.__menu_bar._buttonReturnToLobby.visible = true;
					
					SceneCreateRoom.__menu_bar._buttonCreateRoom.active = true;
					SceneCreateRoom.__menu_bar._buttonCreateRoom.visible = true; 
					
					RegTriggers._createRoom = true;
					

				}
				
				else if (Reg._currentRoomState > 1
				&&  Reg._currentRoomState < 7)
				{
					//__scene_create_room._buttonCreateRoom.visible = false;
					SceneCreateRoom.__menu_bar._buttonReturnToLobby.active = false;
					SceneCreateRoom.__menu_bar._buttonCreateRoom.active = false;
					
					RegTriggers.__scene_waiting_room = true;
				}
			} 
			
			else if (RegTypedef._dataPlayers._spectatorWatching == false)
			{
				Reg._createGameRoom = true;
			}
		}
	}	
	
	/******************************
	* EVENT GET ROOM Data. LOAD ROOM DATA FROM DATABASE.
	USED AT LOBBY TO GET ROOM DATA.
	* _dataMisc
	*/
	public function getRoomData(_data:Dynamic):Void
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
		for (i in 0... SceneLobby._room_total)
		{
			if (RegTypedef._dataMisc._roomState[i] == 0) 
			RegTypedef._dataMisc._roomGameIds[i] = -1;
		}
		
		RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit;
		RegTypedef._dataMisc._roomPlayerCurrentTotal = _data._roomPlayerCurrentTotal;

		RegTypedef._dataMisc._rated_game = _data._rated_game;
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
			SceneLobby._do_once = true;
			SceneLobby._lobby_data_received = true;
		}
			
		#if !html5
			if (Reg._doOnce_email_address_validate == true)
			{
				Reg._doOnce_email_address_validate = false;
				
				PlayState.send("Email Address Validate", RegTypedef._dataAccount);					
			}
		#end
	}
	
	/******************************
	* RETURN ALL VARS TO 0 FOR PLAYER, SO THAT LOBBY DATA CAN BE CALCULATED TO DISPLAY DATA AT LOBBY CORRECTLY.
	*/
	public function returnedToLobby(_data:Dynamic):Void
	{
		PlayState.send("Get Room Data", RegTypedef._dataMisc);			
	}
	
	// miscData
	public function isRoomLocked(_data:Dynamic):Void
	{
		if (_data.id == RegTypedef._dataMisc.id)
		{
			if (_data._roomLockMessage == "")
			{
				PlayState.send("Greater RoomState Value", _data);		
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
	}
	
	/******************************
	* EVENT ROOM LOCK. used to unlock the room at server and to stop entering a room the second time until ticks are used to update the lobby buttons at client. 
	* miscData
	*/
	public function roomLock1(_data:Dynamic):Void
	{
		if (_data._username == RegTypedef._dataPlayers._username)
		{
			RegTypedef._dataMisc._roomLockMessage = "";
			RegTypedef._dataMisc._roomCheckForLock[_data._room] = 0;
			
			PlayState.send("Room Lock 2", _data);
		}
	}
		
	/******************************
	* EVENT GET ROOM PLAYERS. IF this does not work then set back to broadcast this event to every one at server. see: OnlinePlayerOfferInvite event at server for the example.
	*/
	public function getRoomPlayers(_data:Dynamic):Void
	{
		if (_data.id == RegTypedef._dataMisc.id) 
		{
			RegTypedef._dataMisc._roomPlayerLimit = _data._roomPlayerLimit; // this looks wrong but remember that server is passing _roomPlayerLimit to a room and not to everyone.
			RegTypedef._dataMisc._roomGameIds = _data._roomGameIds;

			PlayState.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);				
		}
	}
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function drawOffer(_data:Dynamic):Void
	{
		if (_data.id != RegTypedef._dataQuestions.id && RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
		{
			Reg._drawOffer = true;
		}
	}	
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function drawAnsweredAs(_data:Dynamic):Void
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
					Reg._messageBoxNoUserInput = "Draw accepted.";
					Reg._outputMessage = true;
					Reg._playerCanMovePiece = false;
					RegTriggers._messageDraw = "Game ended in a draw.";
					RegTriggers._draw = true;					
					
					PlayState.send("Save Draw Stats", RegTypedef._dataPlayers);						
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					
					if (Reg._gameHost == true)
					{
						RegTypedef._dataQuestions._gameOver = true;
						RegTypedef._dataQuestions._gameMessage = Reg._messageBoxNoUserInput;
						RegTypedef._dataQuestions._restartGameAnsweredAs = false;
						RegTypedef._dataQuestions._drawAnsweredAs = true;
						PlayState.send("Spectator Watching", RegTypedef._dataQuestions);
						
					}
				}
				
				else
				{
					Reg._messageBoxNoUserInput = "Draw rejected.";
					Reg._outputMessage = true;
					
					if (Reg._gameHost == true)
					{
						RegTypedef._dataQuestions._gameOver = false;
						RegTypedef._dataQuestions._gameMessage = Reg._messageBoxNoUserInput;
						RegTypedef._dataQuestions._restartGameAnsweredAs = false;
						RegTypedef._dataQuestions._drawAnsweredAs = false;
						PlayState.send("Spectator Watching", RegTypedef._dataQuestions);
						
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
	}
	
	/******************************
	* EVENT DRAW OTHER
	* Offer draw to the other player.
	*/
	public function restartOffer(_data:Dynamic):Void
	{
		if (_data.id != RegTypedef._dataQuestions.id && RegTypedef._dataQuestions._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
		{
			Reg._restartOffer = true;				
		}
	}	
	
	/******************************
	* EVENT DRAW OTHER
	* should game by restarted.
	*/
	public function restartAnsweredAs(_data:Dynamic):Void
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
						Reg._messageBoxNoUserInput = "Game started.";
					else Reg._messageBoxNoUserInput = "Game restarted.";
					
					Reg2._do_once_game_start_request = true;
					
					if (RegTypedef._dataPlayers._spectatorWatching == false)
						RegTypedef._dataPlayers._spectatorPlaying = true;
					
					RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
					
					// set the total players in room to the total players able to play a game and set all vars that depend on that total.
					RegTypedef._dataPlayers._usernamesTotalDynamic = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = Reg._roomPlayerLimit = Reg._totalPlayersInRoom + 1;
					
					Reg._gameOverForPlayer = false;
					Reg._gameOverForAllPlayers = false;
					RegTypedef._dataPlayers._gameIsFinished = false;
					
					SceneGameRoom.assignMoveNumberPlayer();	
					
					if (Reg._gameHost == true)
					{
						RegTypedef._dataQuestions._gameOver = false;
						RegTypedef._dataQuestions._gameMessage = Reg._messageBoxNoUserInput;
						RegTypedef._dataQuestions._drawAnsweredAs = false;
						RegTypedef._dataQuestions._restartGameAnsweredAs = true;
						if (RegTypedef._dataPlayers._spectatorWatching == false
						)
						{
							PlayState.send("Spectator Watching", RegTypedef._dataQuestions);		
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
					
					if (RegTypedef._dataMisc._username
					==	RegTypedef._dataPlayers._usernamesStatic[0])
						PlayState.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
					
					RegTypedef._dataPlayers._triggerEvent = "";
					
					Reg._outputMessage = true;
					Reg._createGameRoom = true;
				
					// do not put the following code at the bottom of SceneGameRoom constructor. the auto start of game feature will work but returning to lobby message notices will not be seen.
					Reg._gameOverForPlayer = false;
					Reg._gameOverForAllPlayers = false;
					
					Reg._playerOffset = 0;
					
					if (Reg._game_offline_vs_player == false 
					&&	Reg._game_offline_vs_cpu == false)
					{
						RegTypedef._dataPlayers._gamePlayersValues = [1, 1, 1, 1];
						Reg._playerIDs = -1;
						if (RegTypedef._dataMisc._username
					==	RegTypedef._dataPlayers._usernamesStatic[0])
							PlayState.send("Game Players Values", RegTypedef._dataPlayers); 
						
						RegTypedef._dataPlayers._triggerEvent = "";
						
						
						RegTypedef._dataPlayers._gameIsFinished = false;
						
						if (RegTypedef._dataMisc._username
					==	RegTypedef._dataPlayers._usernamesStatic[0])
							PlayState.send("Game Is Finished", RegTypedef._dataPlayers);
						
						RegTypedef._dataPlayers._triggerEvent = "";
					}
				}
				
				else
				{
					if (Reg._gameOverForAllPlayers == true)			
						Reg._messageBoxNoUserInput = "Request to start game was rejected.";
					else Reg._messageBoxNoUserInput = "Request to restart game was rejected.";
					if (Reg._gameHost == true)
					{
						RegTypedef._dataQuestions._gameOver = true;
						RegTypedef._dataQuestions._gameMessage = Reg._messageBoxNoUserInput;
						RegTypedef._dataQuestions._drawAnsweredAs = false;
						RegTypedef._dataQuestions._restartGameAnsweredAs = false;
						
						PlayState.send("Spectator Watching", RegTypedef._dataQuestions);			
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
	}
	
 	/************************************************************************
	 * currently this event is for the signature game. a player sends a trade unit to another player and this event is for that other player receiving the trade. a message box displays, with trade details, asking if the player would like that trade. 30 seconds countdown. when timer reaches zero, the message box closes.
	 */
	public function tradeProposalOffer(_data:Dynamic):Void
	{
		if (_data._userTo == RegTypedef._dataPlayers._username && RegTypedef._dataMisc._room == _data._room && Reg._gameRoom == true && RegTypedef._dataPlayers._spectatorWatching == false) 
		{
			RegTypedef._dataGameMessage._gameMessage = _data._gameMessage;
			RegTypedef._dataGameMessage._userTo = _data._userTo;
			RegTypedef._dataGameMessage._userFrom = _data._userFrom;
			
			RegTriggers._tradeProposalOffer = true;
		}
	}	
	
	/************************************************************************
	 * what did the player answer as the trade request message box!
	 */
	public function tradeProposalAnsweredAs(_data:Dynamic):Void
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
	}
	
	/******************************
	* EVENT ONLINE PLAYER OFFER INVITE.
	* offer an invite to a player at the lobby.
	*/
	public function onlinePlayerOfferInvite(_data:Dynamic):Void
	{
		if (_data._usernameInvite == RegTypedef._dataAccount._username) 
		{
			if (RegTypedef._dataMisc._userLocation == 0)
			{
				// scrollable area at GameLobby needs to be inactive so that when invite message box is displayed, player cannot create a room which when player cancels the room creation, the player will be stuck with only a black screen.
				__scene_lobby._group_scrollable_area.active = false;
				
				Reg._messageId = 2003;
				Reg._buttonCodeValues = "l1000";
				SceneGameRoom.messageBoxMessageOrder();
				
				RegTypedef._dataPlayers._usernameInvite = _data._username;
				Reg._inviteRoomNumberToJoin = _data._room;
				RegTypedef._dataPlayers._gameName = _data._gameName;
				
			}
		}
	}	
	
	/******************************
	* EVENT ENTER GAME ROOM
	* this event enters the game room.
	* _miscData
	*/
	public function enterGameRoom(_data:Dynamic):Void
	{
		if (_data._room != RegTypedef._dataMisc._room) return;
		
		if (_data.id != RegTypedef._dataMisc.id) 
		{
			Reg._gameOverForPlayer = true;				
			Reg._gameOverForAllPlayers = true;
			
			Reg._totalPlayersInRoom = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] - 1;
			
			// stop any sound playing.			
			//if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();
		
			//RegTypedef._dataGame._room = _data._room; // tested once. seems to be not needed.
			
			Reg._gameHost = false;
			Reg._gameId = _data._gameId;
			
			for (i in 0... 4)
			{
				SceneWaitingRoom._text_player_stats[i].text = "";
			}
			
			RegTypedef._dataMisc._userLocation = 3;			
			
			__scene_waiting_room.__scrollable_area.visible = false;
			__scene_waiting_room.__scrollable_area.active = false;
			
			Reg._createGameRoom = true;
							
			RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 0;
			
		}
		
		if (RegTypedef._dataPlayers._usernamesStatic[0] == "")	
			RegTypedef._dataPlayers._usernamesStatic = RegTypedef._dataPlayers._usernamesDynamic.copy(); // without copy, when an element from _usernamesDynamic is removed, automatically, the same element at _usernamesStatic will be removed.
		
		// this is needed to save a game win to the game being played. if chess is being played and player won that game then this var will be used to save a win to chess, not just the overall wins of any game played.
		
		// never get a value of -1 or there will be a server error when saving stats.
		if (RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] > -1)
			RegTypedef._dataPlayers._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
		
		RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
					
		RegTypedef._dataPlayers._triggerEvent = ""; // any data can be used here. you can ignore stuff if true.
		
		_data._gameRoom = false;
	}
		
	/******************************
	* EVENT GAME WIN
	* this player wins the game.
	*/
	public function gameWin(_data:Dynamic):Void
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
			
			PlayState.send("Save Win Stats", _data);				
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
		}
	}
	
	/******************************
	* EVENT GAME LOSE
	* this player loses the game.
	*/
	public function gameLose(_data:Dynamic):Void
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
			
			PlayState.send("Save Lose Stats", _data);				
		}
	}
	
	/******************************
	* EVENT GAME WIN
	* this player wins the game.
	* only a 2 player game should use this event.
	*/
	public function gameWinThenLoseForOther(_data:Dynamic):Void
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
			
			PlayState.send("Save Win Stats For Both", _data);				
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
	}
	
	/******************************
	* EVENT GAME LOSE
	* this player loses the game.
	* only a 2 player game should use this event.
	*/
	public function gameLoseThenWinForOther(_data:Dynamic):Void
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
			
			PlayState.send("Save Lose Stats For Both", _data);				
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
	}	
	
	/******************************
	* EVENT GAME DRAW
	* this game is in a tie.
	*/
	public function gameDraw(_data:Dynamic):Void
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
			
			PlayState.send("Save Draw Stats", _data);				
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
	}
		
	/******************************
	* EVENT SAVE WIN STATS
	* save the win stats of the player that was sent here and then return that value here.
	* _dataPlayers.
	*/
	public function saveWinStats(_data:Dynamic):Void
	{
		if (_data._room == RegTypedef._dataPlayers._room 
		&&  RegTypedef._dataPlayers._spectatorWatching == false)
		{
			updateStats(_data);
			RegTypedef._dataPlayers._spectatorPlaying = false;
		}
	}
		
	/***********************************************************************
	* EVENT SAVE LOSE STATS
	* save the lose stats of the player that was sent here and then return that value here.
	* _dataPlayers.
	*/
	public function saveLoseStats(_data:Dynamic):Void
	{
		// at server, do not use "_sender.send" because more than one player can lose game.
		if (_data._room == RegTypedef._dataPlayers._room 
		&&  RegTypedef._dataPlayers._spectatorWatching == false)
		{
			updateStats(_data);
			RegTypedef._dataPlayers._spectatorPlaying = false;
			
			// user is disconnecting by pressing the esc key. the PlayState._clientDisconnectDo var was set to false before entering this event so a check here is not needed because this is the last event entered after the Hotkeys.hx esc key was pressed.
			if (PlayState._clientDisconnect == true)
				PlayState.disconnectByESC();
		}
	}	
	
	/******************************
	* EVENT SAVE WIN STATS
	* save the win stats of the player that was sent here and then return that value here.
	* only a 2 player game should use this event. this event was called from "Game Win Then Lose For Other"
	* _dataPlayers.
	*/
	public function saveWinStatsForBoth(_data:Dynamic):Void
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
	}
		
	/******************************
	* EVENT SAVE LOSE STATS
	* save the lose stats of the player that was sent here and then return that value here.
	* only a 2 player game should use this event.
	* _dataPlayers.
	*/
	public function saveLoseStatsForBoth(_data:Dynamic):Void
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
	}
	
	/******************************
	* EVENT SAVE DRAW STATS
	* save the draw stats of the player that was sent here and then return that value here. this event was called from "Game Lose Then Win For Other"
	* _dataPlayers.
	*/
	public function saveDrawStats(_data:Dynamic):Void
	{
		// at server, do not use "_sender.send" because more than one player can draw.
		if (_data._room == RegTypedef._dataPlayers._room 
		&&  RegTypedef._dataPlayers._spectatorWatching == false)
		{
			updateStats(_data);
		}		
	}
	
	/******************************
	* EVENT GET TOURNAMENT
	* gets the selected tournament data.
	* _dataTournaments
	*/
	public function tournamentChessStandard8Get(_data:Dynamic):Void
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
		
		RegTypedef._dataPlayers._moveTimeRemaining[1] = Std.parseInt(_data._time_remaining_player2);
		RegTypedef._dataPlayers._moveTimeRemaining[0] = Std.parseInt(_data._time_remaining_player1);

		Reg._textTimeRemainingToMove1 = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._moveTimeRemaining[0]);
		Reg._textTimeRemainingToMove2 = PlayerTimeRemainingMove.formatTime(RegTypedef._dataPlayers._moveTimeRemaining[1]);
		
		Reg._playerCanMovePiece = true;
		
		RegTypedef._dataTournaments._gid = _data._gid;
		RegTypedef._dataTournaments._move_piece = _data._move_piece;
		RegTypedef._dataTournaments._round_current = _data._round_current;
		RegTypedef._dataTournaments._rounds_total = _data._rounds_total;		
		RegTypedef._dataTournaments._player_maximum = _data._player_maximum;
		RegTypedef._dataTournaments._player_current = _data._player_current;
		RegTypedef._dataTournaments._reminder_by_mail = _data._reminder_by_mail;
		RegTypedef._dataTournaments._game_over = _data._game_over;
		RegTypedef._dataTournaments._timestamp = _data._timestamp;
		RegTypedef._dataTournaments._won_game = _data._won_game;
		
		RegTriggers._tournament_standard_chess_8 = true;
		RegTriggers._tournament_standard_chess_8_menubar = true;
	}
	
	
	/******************************
	* EVENT PUT TOURNAMENT
	* puts the selected tournament data to the MySQL database.
	* _dataTournaments
	*/
	public function tournamentChessStandard8Put(_data:Dynamic):Void
	{
		// TODO this event is not used.
	}
	
	/******************************
	* EVENT TOURNAMENT SUBSCRIBE To MAIL
	* 0: not subscribed to mail. 1: true.
	* _dataTournaments
	*/
	public function tournamentReminderByMail(_data:Dynamic):Void
	{
		RegTypedef._dataTournaments._reminder_by_mail = _data._reminder_by_mail;
		
		if (RegTypedef._dataTournaments._reminder_by_mail == false)
		{
			Reg._messageId = 7110;
			Reg._buttonCodeValues = "h1110";
			SceneGameRoom.messageBoxMessageOrder();
		}
		
		else
		{
			Reg._messageId = 7120;
			Reg._buttonCodeValues = "h1110";
			SceneGameRoom.messageBoxMessageOrder();
		}
		
		PlayState.send("Tournament Chess Standard 8 Get", _data);
	}
	
	/******************************
	* EVENT TOURNAMENT PARTICIPATING
	* 0: removed from tournament. 1: joined.
	* _dataTournaments
	*/
	public function tournamentParticipating(_data:Dynamic):Void
	{
		RegTypedef._dataTournaments._player1 = _data._player1;
		
		PlayState.send("Tournament Chess Standard 8 Get", _data);
	}
	
	/****************************** NOTE... GAME WILL NOT UPDATE FOR SPECTATOR UNTIL SECOND MOVE 
	* EVENT GAME ROOM ENTERED SPECTATOR WATCHING
	* 
	*  // user who requested to watch a game. this can be a message such as "checkmate" or "restarting game". also, any var needed to start or stop a game will be passed here.
	* only the game host should send to this event.
	* _dataQuestions.
	*/
	public function spectatorWatching(_data:Dynamic):Void
	{		
		if (RegTypedef._dataMisc._spectatorWatching == true)
		{
			// get any game message
			Reg._messageBoxNoUserInput = _data._gameMessage;

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
	}
	
	/****************************** NOTE... GAME WILL NOT UPDATE FOR SPECTATOR UNTIL SECOND MOVE 
	* EVENT SPECTATOR WATCHING GET MOVE NUMBER
	*  send the current move number to the watching spectator so that the timer and white box underneath the P1, P2, P3 or P4 moves, can be updated.
	* _dataPlayers.
	*/
	public function spectatorWatchingGetMoveNumber(_data:Dynamic):Void
	{
		if (RegTypedef._dataPlayers._spectatorWatching == true)
		{
			Reg._move_number_next = _data._spectatorWatchingGetMoveNumber;
			RegTypedef._dataPlayers._moveNumberDynamic[0] = Reg._move_number_next;
		
			Reg._spectator_start_timer = true;
		}
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
		}
	}
	
	/******************************
	* EVENT PLAYER LEFT GAME
	* Trigger an event that the player has left the game and then do stuff such as stop the ability to move piece.
	* _dataPlayers
	*/
	public function playerLeftGameRoom(_data:Dynamic):Void
	{
		//RegTypedef._dataPlayers._usernamesStatic = _data._usernamesStatic; // uncommenting this creates an error where the last player in game room cannot go back to lobby.
		
		if (Reg._currentRoomState == 0
		||  Reg._currentRoomState >= 7)
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
								PlayState.send("Game Lose", _data);									
							}
						}						
					}
					
				#end
				
			}
			
			else 
			{
				Reg._gameOverForPlayer = true;
			}
			
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
			
			if (RegTypedef._dataMisc._username
			==	RegTypedef._dataPlayers._usernamesStatic[0])
				PlayState.send("Game Is Finished", RegTypedef._dataPlayers);				
			
			RegFunctions.playerAllStop();
		}	
		
		if (_totalPlayers == 0) 
		{
			//RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
			
		}
	}
	
	/******************************
	 * this event is called when playing a game and player ran out of time or quit game.
	 */
	public function playerLeftGame(_data:Dynamic):Void
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
							PlayState.send("Game Lose", _data); 								
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
			
			if (RegTypedef._dataMisc._username
			==	RegTypedef._dataPlayers._usernamesStatic[0])
				PlayState.send("Game Is Finished", RegTypedef._dataPlayers);				
			
			RegFunctions.playerAllStop();
		}	

		if (_totalPlayers == 0) 
		{
			//RegTypedef._dataPlayers._usernamesDynamic = RegTypedef._dataPlayers._usernamesStatic.copy();
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
		}
	}
	
	/******************************
	 * EVENT GAME IS FINISHED.
	 * save a var to mySql so that someone cannot invite when still in game room. also, triggers a var called Reg._gameOverForAllPlayers to equal true so that the game has ended for everyone.
	 * _dataPlayers
	 */
	public function gameIsFinished(_data:Dynamic):Void
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
			PlayState.send("Is Game Finished", RegTypedef._dataPlayers); 				
		}
	}	
	
	/******************************
	 * EVENT GAME IS FINISHED.
	 * false if game is still being played. defaults to true because when entering the game room the game for those players has not started yet.
	 * _dataPlayers
	 */
	public function isGameFinished(_data:Dynamic):Void
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
	public function gamePlayersValues(_data:Dynamic):Void
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
				PlayState.send("Player Left Game Room", RegTypedef._dataPlayers);					
			}
			
			else 
			{
				PlayState.send("Lesser RoomState Value", RegTypedef._dataMisc);					
				
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
	}
	
	/******************************
	* EVENT LOGGED IN USERS
	* list of online players with stats. used to invite.
	* _dataPlayers
	*/
	public function loggedInUsers(_data:Dynamic):Void
	{
		if (_data.id == RegTypedef._dataPlayers.id) 
		{
			// no need for a (if (_data._room == ) check because at server this is broadcast based on the room var.
			RegTypedef._dataOnlinePlayers = _data;
			
			//InviteTable._populated_table_body = false;
			RegTriggers._waiting_room_refresh_invite_list = true;
			InviteTable._ticks_invite_list = 0;
			
			SceneWaitingRoom.__menu_bar._button_refresh_list.active = true;
			SceneWaitingRoom.__menu_bar._button_refresh_list.visible = true;	
			
			SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.active = true;
			SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.visible = true;

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
			
			PlayState.send("Is Action Needed For Player", RegTypedef._dataPlayers);				
		}	
	}
			
	/******************************
	* EVENT IS ACTION NEEDED FOR PLAYER.
	* should event action be done to player.
	*/
	public function isActionNeededForPlayer(_data:Dynamic):Void
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
				__scene_waiting_room.__scrollable_area.visible = false;
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
					__scene_waiting_room.__scrollable_area.visible = true;
					__scene_waiting_room.visible = true;
				}
			}	
			
			if (RegTypedef._dataMisc._userLocation > 0
			&&  RegTypedef._dataMisc._userLocation < 3) // not in game room
			{
				PlayState.send("Room Lock 1", _data);					
			}
		}
	}
	
	/******************************
	* EVENT ACTION BY PLAYER.
	* this is where player can kick, ban other players.
	* dataPlayers
	*/
	public function actionByPlayer(_data:Dynamic):Void
	{
		RegTypedef._dataPlayers._actionNumber = _data._actionNumber;
		RegTypedef._dataPlayers._actionWho = _data._actionWho;
		PlayState.send("Is Action Needed For Player", RegTypedef._dataPlayers);			
	}
		
	/******************************
	* EVENT MOVE HISTORY NEXT ENTRY.
	* every player that moves a piece will use the host of the room to call this event so to update the move history at MySQL. this is needed so that when a spectator watching enters the room, that person can get all the move history for that game.
	* _dataMovement.
	*/
	public function moveHistoryNextEntry(_data:Dynamic):Void
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
	}
	
	/******************************
	* EVENT MOVE HISTORY ALL ENTRY.
	* the spectator has just joined the game room because there is currently only one move in that users history, do this event to get all the moves in the move history for this game.
	* when this RegTypedef._dataMovement._moveHistoryTotalCount has a value of one, the "Move History Next Entry" sends a request to the server for "Move History All Entry" event. at server Reg._moveHistoryPieceLocationOld and Reg._moveHistoryPieceLocationNew and the Reg._moveHistoryPieceValueOld and Reg._moveHistoryPieceValueNew are the unit move arrays that the server stores in the data base as a string. for example, the moves are stored in the Reg._moveHistoryPieceLocationNew as Reg._moveHistoryPieceLocationNew[0] = 24; Reg._moveHistoryPieceLocationNew[1] = 44; so server sends that data to MySQL as "24,44," string. then the server sends that string data here and here that data is string.split at "," then put into the Reg._moveHistoryPieceLocationNew array.
	* _dataMovement.
	*/
	public function moveHistoryAllEntry(_data:Dynamic):Void
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
	}	
	
	/******************************
	* EVENT LEADERBOARDS
	* display a 50 player list of the players with the top experience points.
	* _dataLeaderboards.
	*/
	public function leaderboards(_data:Dynamic):Void
	{
		RegTypedef._dataLeaderboards._usernames = Std.string(_data._usernames); 
		RegTypedef._dataLeaderboards._experiencePoints = Std.string(_data._experiencePoints);
		RegTypedef._dataLeaderboards._houseCoins = Std.string(_data._houseCoins);
		RegTypedef._dataLeaderboards._worldFlag = Std.string(_data._worldFlag);
		
		RegTriggers._leaderboards_show = true;
	}	
	
	/******************************
	* EVENT DAILY QUESTS
	* complete these daily quests for rewards.
	*/
	public function dailyQuests(_data:Dynamic):Void
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
	}
	
	/******************************
	* EVENT EMAIL ADDRESS VALIDATE
	* verifies if the email address is valid. validation code could be sent to a user's email address.
	*/
	private function emailAddressValidate(_data:Dynamic):Void
	{
		RegTypedef._dataAccount._send_email_address_validation_code = false;
		
		// if _doOnce_email_address_validate value is false then user has already been online. A possible email has therefore already been sent out to user. therefore, set the _send_email_address_validation_code var to false so that another email is not sent out at this client session unless at configuration _send_email_address_validation_code is set back to true.
		RegFunctions._gameMenu.data._send_email_address_validation_code = RegCustom._send_email_address_validation_code = false;
		RegFunctions._gameMenu.flush();
		RegFunctions._gameMenu.close;		
	}
	
	/******************************
	 * you need to set the values below at the game code. see SignatureGameClickMe.hx and SignatureGameMovePlayersPiece.hx. makes all clients move the same piece at the same time. this is not automatic.
	 */
	public function movement(_data:Dynamic):Void
	{
		if (_data._room == RegTypedef._dataMovement._room)
		{
			defenderOrAttcker();
			
			if (_data.id == RegTypedef._dataMovement.id)
			{				
				GameClearVars.clearVarsOnMoveUpdate();
				Reg._triggerNextStuffToDo = 1;
														
				return; // return if this is the client that first moved the _player.
			}
								
			// triggers an event to move piece for the backdoor client. if dice is used to move piece then the Reg._backdoorMoveValue will be used to store that value.
			Reg._triggerNextStuffToDo = _data._triggerNextStuffToDo;			
			Reg._backdoorMoveValue = _data._gameDiceMaximumIndex;
			
			// a value of 2 will be used to stop backdoor client from entering options menu of the signature game.
			Reg._triggerNextStuffToDo = 2;
			Reg._isThisPieceAtBackdoor = true;
			Reg._playerCanMovePiece = true;
		}
	}
	
	/******************************
	* EVENT SERVER WILL SOON DISCONNECT. SEND MESSAGE TO ALL CLIENT.
	*/
	public function disconnectAllByServer(_data:Dynamic):Void
	{
		if (Std.string(_data._message_offline) != "")
			Reg._server_message = Std.string(_data._message_offline);	
		
		else if (Std.string(_data._message_online) != "")
			Reg._server_message = Std.string(_data._message_online);
		
		Reg._messageId = 2222;
		Reg._buttonCodeValues = "l2222";
		SceneGameRoom.messageBoxMessageOrder();
	}
	
	override public function destroy():Void
	{
		if (_text_client_login_data2 != null)
		{
			remove(_text_client_login_data2);
			_text_client_login_data2.destroy();
			_text_client_login_data2 = null;
		}
		
		if (_text_client_login_data3 != null)
		{
			remove(_text_client_login_data3);
			_text_client_login_data3.destroy();
			_text_client_login_data3 = null;
		}
		
		if (_text_client_login_data4 != null)
		{
			remove(_text_client_login_data4);
			_text_client_login_data4.destroy();
			_text_client_login_data4 = null;
		}
		
		__scene_lobby = null;
		__scene_create_room = null;
		__scene_waiting_room = null;
		__ids_win_lose_or_draw = null;
	
		#if	chess
			if (__chess_check_or_checkmate != null)
			{
				remove(__chess_check_or_checkmate);
				__chess_check_or_checkmate.destroy();
				__chess_check_or_checkmate = null;
			}
		#end
		
		super.destroy();
	}
}//