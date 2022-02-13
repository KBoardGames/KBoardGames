/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if chess
	import modules.games.chess.*;
#end

/**
 * game room. main loop. calls history, notation, chatter, functions to draw game, return to lobby button, draw button, etc.
 * @author kboardgames.com
 */
class SceneGameRoom extends FlxState
{
	public var __action_commands:ActionCommands;
	
	/******************************
	* the title of this state.
	*/
	private var _title:FlxText;
	
	public var buttonStartRestartGame:ButtonGeneralNetworkYes;
	public var buttonReturnToTitle:ButtonGeneralNetworkYes;
	
	/******************************
	 * offline buttons.
	 */
	public var buttonStartRestartGame2:ButtonGeneralNetworkNo;
	public var buttonReturnToTitle2:ButtonGeneralNetworkNo;
	
	/******************************
	 * offer a draw so that nobody wins that game.
	 */
	public var buttonDrawGame:ButtonGeneralNetworkYes;
	
	/******************************
	 * button that returns user to the lobby.
	 */
	public var buttonReturnToLobby:ButtonGeneralNetworkYes;	
	public var buttonQuitGame:ButtonGeneralNetworkYes;		
		
	/******************************
	 * pointer to GameChatter.
	 */
	public static var __game_chatter:GameChatter;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;	
	
	public var __game_create:GameCreate;
		
	/******************************
	* player's stats, displayed at bottom of playing area.
	*/
	public var _hud:HUD;
	
	/******************************
	* highlights which players turn it is to move.
	*/
	public var _playerWhosTurnToMove:PlayerWhosTurnToMove;
	
	/******************************
	* player's idle time remaining and move time remaining while playing a game. 
	*/
	public var _playerTimeRemainingMove:PlayerTimeRemainingMove;
	
	/******************************
	 * is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
	 */
	#if chess
		private var __chess_check_or_checkmate:ChessCheckOrCheckmate;
	#end
	
	public var _playersLeftGame:PlayersLeftGameResetThoseVars;
	public var _finalizeWhenGameOver:GameFinalize;
	
	/******************************
	* class that displays the game notations.
	*/
	public static var __game_history_and_notations:GameHistoryAndNotations;
	
	public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw, chess_check_or_checkmate:Dynamic) 
	{
		super();
		
		Reg._at_game_room = true;
		Reg._at_waiting_room = false;
		
		TitleBar._title_for_screenshot = "Game Room";
		
		// this is needed because if message box was centered to screen, it would overlap part of the right side scrollbar at lobby. if true then we are at the game room so center the message box since there is no scrollbar to the right of the scene.
		Reg2._messageBox_x = 380;
		
		Reg2._lobby_button_alpha = 0.3;
		RegTriggers._buttons_set_not_active = false;
		
		RegFunctions.fontsSharpen();
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		#if chess
			__chess_check_or_checkmate = chess_check_or_checkmate;
		#end
		
		RegTypedef._dataMisc._userLocation = 3;
		
		if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false && Reg._game_online_vs_cpu == false)
		{
			if (GameChatter.__scrollable_area2 != null)	
				GameChatter.__scrollable_area2.visible = false;
			
			if (GameChatter.__scrollable_area3 != null)
				GameChatter.__scrollable_area3.visible = false;
		}
		
		Reg._buttonCodeValues = "";
		Reg._yesNoKeyPressValueAtMessage = 0;
		
		if (RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] != -1) Reg._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
		
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) Reg._roomPlayerLimit = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room];
		
		#if chess
			__game_create = new GameCreate(__ids_win_lose_or_draw, __chess_check_or_checkmate);
			add(__game_create);
		#else
			__game_create = new GameCreate(__ids_win_lose_or_draw, null);
			add(__game_create);
		#end
		
		_finalizeWhenGameOver = new GameFinalize(this);
		add(_finalizeWhenGameOver);

		__game_create.gameId_set_board_and_pieces();
		
		_playersLeftGame = new PlayersLeftGameResetThoseVars(this);
		add(_playersLeftGame);
		
		addChatterAndGameTime();
		
		_title = new FlxText(0, 0, 0, "");
		_title.setFormat(Reg._fontDefault, 50, RegCustomColors.title_bar_text_color());
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		_title.scrollFactor.set();
		if (RegTypedef._dataMisc._room <= 9) 
			_title.setPosition(FlxG.width - 275, 20);
		else
			_title.setPosition(FlxG.width - 290, 20);
			
		if (Reg._game_offline_vs_player == true 
		||	Reg._game_offline_vs_cpu == true)
			_title.text = "Offline";
		else
			_title.text = "Room " + Std.string(RegTypedef._dataMisc._room ) + " ";
		_title.visible = true;
		add(_title);	
			
		
		//############################# FOR BUTTON NEW SEE gameIDRightSidePanel()
				
		// if at GameWaitingRoom player 1 had chatter open then when starting a game the _rememberChatterIsOpen will be true so that the chatter will be opened at this class.
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._rememberChatterIsOpen == true)
		{
			var _state:Bool = false;
			gameButtonActive(_state);
		}
		else
		{
			var _state:Bool = true;
			gameButtonActive(_state);
		}
		
		// add the game history for spectator watching for the following games when the game is being played
		if (Reg._gameId <= 1)
		{
			if (__game_history_and_notations != null)
				__game_history_and_notations.destroy();
			
			__game_history_and_notations = new GameHistoryAndNotations();
			add(__game_history_and_notations);
						
		}
		
		// disable chatter for the spectator watching feature but enable it when playing a game online.
		if (Reg._game_offline_vs_cpu == false 
		&&	Reg._game_offline_vs_player == false
		&&  RegTypedef._dataPlayers._spectatorWatching == false
		&&  RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
		{
			//-------------------------------
			if (__game_chatter != null) 
			{			
				__game_chatter.destroy();
			}
			
			__game_chatter = new GameChatter(6, this);
			__game_chatter.visible = true;
			
			if (GameChatter.__scrollable_area4 != null)
			{
				GameChatter.__scrollable_area4.visible = false;
				GameChatter.__scrollable_area4.active = false;
			}
			
			GameChatter._groupChatterScroller.x = 385; // hide,
			RegTriggers._scrollRight = true; // this is needed if hiding boxScoller.
			add(__game_chatter);
		}
		
		gameAddHUD();
		
		// should a game request be automatically sent to other player(S)?
		if (Reg._game_offline_vs_player == false
		&&  Reg._game_offline_vs_cpu == false
		&&  Reg2._do_once_game_start_request == false)
		{
			if (RegCustom._send_automatic_start_game_request[Reg._tn] == true
			&&  RegTypedef._dataMisc._username == RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room])
			{
				RegCustom._send_automatic_start_game_request[Reg._tn] = false;
				
				PlayState.send("Restart Offer", RegTypedef._dataQuestions);				
			}
		}
		
		if (Reg._clientReadyForPublicRelease == false)
		{
			if (__action_commands != null)
			{
				remove(__action_commands);
				__action_commands.destroy();
			}
			
			__action_commands = new ActionCommands(); 
			add(__action_commands);
		}
	}
	
	public function gameIDRightSidePanel():Void
	{
		var _y_offset = 1; // horizontal alignment to the baseline of the gameboard.
		
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			buttonStartRestartGame = new ButtonGeneralNetworkYes(FlxG.width - 373, FlxG.height - 237 - _y_offset , "Start Game", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageStartRestartGame, RegCustom._button_color[Reg._tn], false, 1000);
			
			if (Reg._gameHost == true
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
				buttonStartRestartGame.label.text = "Start Game";
			else 
			{
				buttonStartRestartGame.visible = false;
				buttonStartRestartGame.active = false;
			}
			
			buttonStartRestartGame.label.font = Reg._fontDefault;
			add(buttonStartRestartGame);
						
		}
		
		else
		{
			// offline
			buttonStartRestartGame2 = new ButtonGeneralNetworkNo(FlxG.width - 373, FlxG.height - 137 - _y_offset, "Start Game", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageStartRestartGame, RegCustom._button_color[Reg._tn], false, 1);
			buttonStartRestartGame2.label.font = Reg._fontDefault;
		add(buttonStartRestartGame2); 
		
		}
				
		
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			buttonReturnToTitle = new ButtonGeneralNetworkYes(FlxG.width - 183, FlxG.height - 187 - _y_offset, "To Title", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageReturnToTitle, RegCustom._button_color[Reg._tn], false, 1001);
			buttonReturnToTitle.label.font = Reg._fontDefault;
			add(buttonReturnToTitle);
			
		}			
		
		if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
		{
			// offline
			buttonReturnToTitle2 = new ButtonGeneralNetworkNo(FlxG.width - 183, FlxG.height - 137 - _y_offset, "To Title", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageReturnToTitle, RegCustom._button_color[Reg._tn], false, 1);
			buttonReturnToTitle2.label.font = Reg._fontDefault;
			add(buttonReturnToTitle2);
			
		}
		
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			buttonDrawGame = new ButtonGeneralNetworkYes(FlxG.width - 373, FlxG.height -  187 - _y_offset, "Draw", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageDrawOffer, RegCustom._button_color[Reg._tn], false, 1002);
			buttonDrawGame.label.font = Reg._fontDefault;
			buttonDrawGame.visible = false;
			buttonDrawGame.active = false;
			add(buttonDrawGame);
		}
		
		// Reg._game_online_vs_cpu code is needed to show this button while playing an online game.
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			buttonReturnToLobby = new ButtonGeneralNetworkYes(FlxG.width - 183, FlxG.height - 237 - _y_offset, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageReturnToLobby, RegCustom._button_color[Reg._tn], false, 1003);
			buttonReturnToLobby.label.font = Reg._fontDefault;
			add(buttonReturnToLobby);
		}
		
		if (Reg._game_online_vs_cpu == true)
		{
			buttonReturnToLobby = new ButtonGeneralNetworkYes(FlxG.width - 183, FlxG.height - 187 - _y_offset, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageReturnToLobby, RegCustom._button_color[Reg._tn], false, 1004);
			buttonReturnToLobby.label.font = Reg._fontDefault;
			add(buttonReturnToLobby);
		}
		
		// Reg._game_online_vs_cpu code is needed to show this button while playing an online game.
		if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			buttonQuitGame = new ButtonGeneralNetworkYes(FlxG.width - 373, FlxG.height - 137 - _y_offset, "Quit Game", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, messageQuitGame, RegCustom._button_color[Reg._tn], false, 1005);
			buttonQuitGame.label.font = Reg._fontDefault;
			buttonQuitGame.visible = false;
			buttonQuitGame.active = false;
			add(buttonQuitGame);
		}

	}
	
	private function spectatorWatchingMessageBoxMessage():Void
	{
		if (RegTypedef._dataMisc._spectatorWatching == true)
		{
			// Did the player one lose or win or do something else? this is the message box message for player 1 that displays for all spectators that are watching that game.
			if (RegTypedef._dataGameMessage._userFrom == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&  RegTypedef._dataPlayers._usernamesDynamic[0] != "")
			{
				Reg._messageId = 16000;
				messageBoxMessageOrder();
			}
			
			// player 2 uses a different message box so that the message box displayed at spectator Watching can be stacked instead of the message box 1 deleting replacing the already seen message box 1.
			if (RegTypedef._dataGameMessage._userFrom == RegTypedef._dataPlayers._usernamesDynamic[1]
			&&  RegTypedef._dataPlayers._usernamesDynamic[1] != "")
			{
				Reg._messageId = 16005;
				messageBoxMessageOrder();				
			}
			
			if (RegTypedef._dataGameMessage._userFrom == RegTypedef._dataPlayers._usernamesDynamic[2]
			&&  RegTypedef._dataPlayers._usernamesDynamic[2] != "")
			{
				Reg._messageId = 16010;
				messageBoxMessageOrder();
			}
			
			if (RegTypedef._dataGameMessage._userFrom == RegTypedef._dataPlayers._usernamesDynamic[3]
			&&  RegTypedef._dataPlayers._usernamesDynamic[3] != "")
			{
				Reg._messageId = 16015;
				messageBoxMessageOrder();
			}
		}
	}
	
	/******************************
	 * this code reassigns the _move_number_current so that the game can continue.
	 * see, GameClearVars.playerDataClearPlaying() and PlayState.playerRepopulateTypedefPlayers
	 */
	public static function assignMoveNumberPlayer():Void	
	{
		Reg._gameHost = false;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[i] && Reg._move_number_current != -1)
			{
				// now that a player had left game and there are two or move player still in game. reassign Reg._move_number_current var.
				Reg._move_number_current = i;				
				
				if (i == 0) 
				{
					Reg._gameHost = true;
					if (RegTypedef._dataMisc._spectatorWatching == false)
					{
						PlayState.send("Is Host", RegTypedef._dataMisc);
					}
				}
			}
		}
		
	}	
	
	private function howManyPlayersAreInGameRoom():Int
	{
		var _count:Int = 0;

		// used to count how many players are in room.
		if (RegTypedef._dataPlayers._usernamesStatic[0] != "")
			_count += 1;
		if (RegTypedef._dataPlayers._usernamesStatic[1] != "") 
			_count += 1;
		if (RegTypedef._dataPlayers._usernamesStatic[2] != "") 
			_count += 1;
		if (RegTypedef._dataPlayers._usernamesStatic[3] != "") 
			_count += 1;
		
		return _count;
	}
	
	// player left the game and there is still 2 or more players playing the game, so remove the player's piece and remove player's timer text and anything else that need to be removed from the stage and then new again some other classes so that the other players' pieces for those players still in room playing the game will the correct move order of those other players.
	public function removePlayersDataFromStage():Void
	{
		__game_create.removeSpriteGroup();
		
		if (Reg._gameId == 4)
		{
			Reg._triggerNextStuffToDo = 0;			
			__game_create.addSpriteGroup();
		}
		
		gamePlayerWhosTurnToMove();
		gamePlayerTimeRemainingMove(); 

				
		Reg._playerWaitingAtGameRoom = false;
	}
	
	public static function messageBoxMessageOrder():Void
	{
		for (i in 0...Reg._messageFocusId.length)
		{
			if (Reg._messageFocusId[i] == Reg._messageId)
			Reg._messageFocusId.splice(i, 1);
			
			if (Reg._buttonCodeFocusValues[i] == Reg._buttonCodeValues)
			Reg._buttonCodeFocusValues.splice(i, 1);
		}
		
		Reg._messageFocusId.push(0);
		Reg._messageFocusId[Reg._messageFocusId.length - 1] = Reg._messageId;
		
		Reg._buttonCodeFocusValues.push("");
		Reg._buttonCodeFocusValues[Reg._buttonCodeFocusValues.length - 1] = Reg._buttonCodeValues;
	}
		
	
	private function addChatterAndGameTime():Void
	{
		GameCreate.timeGivenForEachGame(); 
		
		gamePlayerWhosTurnToMove();
		gamePlayerTimeRemainingMove(); 
		
		for (i in 1...5)
		{
			if (Reg._gameId < 2) gameHistoryButtonsDisplayIt(i);
		}
		
		gameIDRightSidePanel();
				
	}
	
	
	public function buttonShowAll():Void
	{				
		if (buttonReturnToTitle != null)
		{
			buttonReturnToTitle.active = true;
			buttonReturnToTitle.visible = true;
		}
		
		if (buttonReturnToLobby != null)
		{
			buttonReturnToLobby.active = true;
			buttonReturnToLobby.visible = true;
		}
	
		
		if (buttonStartRestartGame != null && Reg._game_offline_vs_cpu == true
		||  buttonStartRestartGame != null && Reg._game_offline_vs_player == true)
		{
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&& Reg._game_online_vs_cpu == false)
			{
				buttonStartRestartGame.active = true;	
				buttonStartRestartGame.visible = true;
			}
		}	
		
		if (buttonDrawGame != null && Reg._game_offline_vs_cpu == false
		&&  Reg._game_offline_vs_player == false)
		{		
			if (Reg._gameOverForPlayer == false
			&&  Reg._roomPlayerLimit - Reg._playerOffset > 1
			&&  Reg._gameOverForAllPlayers == false 
			&&  RegTypedef._dataPlayers._spectatorWatching == false)
			{
				buttonDrawGame.active = true;
				buttonDrawGame.visible = true;
				
				buttonQuitGame.active = true;
				buttonQuitGame.visible = true;
			}	
		}
			
	}
	
	/******************************
	 * hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room.
	 */
	public function buttonHideAll():Void
	{
		if (Reg._game_offline_vs_player == true
		||	Reg._game_offline_vs_cpu == true) return;
		
		if (buttonReturnToTitle != null)
		{
			buttonReturnToTitle.visible = false;
			buttonReturnToTitle.active = false;
		}
		
		if (buttonReturnToTitle2 != null)
		{
			buttonReturnToTitle2.visible = false;
			buttonReturnToTitle2.active = false;
		}
				
		if (buttonReturnToLobby != null)
		{
			buttonReturnToLobby.visible = false;
			buttonReturnToLobby.active = false;
		}	
		
		if (buttonStartRestartGame != null)
		{
			buttonStartRestartGame.visible = false;
			buttonStartRestartGame.active = false;
		}
		
		if (buttonStartRestartGame2 != null)
		{
			buttonStartRestartGame2.visible = false;
			buttonStartRestartGame2.active = false;
		}
			
		if (buttonDrawGame != null)
		{
			buttonDrawGame.visible = false;
			buttonDrawGame.active = false;
		}
				
		if (buttonQuitGame != null)
		{
			buttonQuitGame.visible = false;
			buttonQuitGame.active = false;
		}	
	}

	private function toggleButtonsAsChatterScrolls():Void
	{
		Reg._buttonCodeValues = "";
		
		// this is not perfect. user is able to click button even though it is behind chatter but not when chatter is fully closed. there is no way around this limitation because Haxeflixel buttons cannot tell when there is another object on top of it.
		if (Reg._gameRoom == true && GameChatter._title_background.x > 1200)
		{
			var _state:Bool = true;
			
			gameButtonActive(_state);
		}
		
		if (Reg._gameRoom == true && GameChatter._title_background.x < 1200)
		{
			var _state:Bool = false;
			gameButtonActive(_state);
		}
	}
	
	/******************************
	 * toggles the active state of a button or text underneath chatter.
	 * @param	_state	not active if false.
	 */
	private function gameButtonActive(_state:Bool):Void
	{
		if (buttonReturnToTitle != null) buttonReturnToTitle.active = _state;
		if (buttonReturnToLobby != null) buttonReturnToLobby.active = _state;
	}
	
	/******************************
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		// return to lobby
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._playerWaitingAtGameRoom = false;			
			
			// clear chatter then hide this FlxState.
			//if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) GameChatter.clearText();
			
			if (PlayState._clientDisconnect == false)
			{
				if (Reg._game_online_vs_cpu == false
				&&  __game_chatter != null) 
					__game_chatter.visible = false;
				
				visible = false;
			}
			
			else
			{
				GameChatter._chatterOpenCloseButton.visible = false;
				GameChatter._chatterOpenCloseButton.active = false;
								
				buttonStartRestartGame.visible = false;
				buttonStartRestartGame.active = false;
				buttonReturnToTitle.visible = false;
				buttonReturnToTitle.active = false;
				buttonReturnToLobby.visible = false;
				buttonReturnToLobby.active = false;
				buttonDrawGame.visible = false;
				buttonDrawGame.active = false;
				buttonQuitGame.visible = false;
				buttonQuitGame.active = false;
			}
			
			RegTypedef._dataMisc._gameRoom = false;			
			RegTypedef._dataMisc._username = RegTypedef._dataAccount._username;
			
			Reg._game_offline_vs_cpu = false;
			Reg._game_online_vs_cpu = false;
			
			if (RegTypedef._dataMisc._spectatorWatching == false)
			{
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesStatic[i])
					{
						if (Reg._gameOverForPlayer == true) RegTypedef._dataPlayers._gamePlayersValues[i] = 3; // stats already saved so set this to 3
						else RegTypedef._dataPlayers._gamePlayersValues[i] = 2;
						
						Reg._gameOverForPlayer = true;
	
						PlayState.send("Game Players Values", RegTypedef._dataPlayers);					
					}
				}	
			}
			
			else go_back_to_lobby();			
			
			// stop any sound playing.			
			if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();		
			
			// destroy game notation if exists.
			if (__game_history_and_notations != null)
				__game_history_and_notations.destroy();			
			
		}
		
		// leaving room canceled
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "g1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		
		}
		
		// disconnect then return to title.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1002")
		{
			if (Reg._game_offline_vs_player == true 
			||	Reg._game_offline_vs_cpu == true
			) 
			{
				FlxG.switchState(new MenuState());
			}
			
			
			if (Reg._game_online_vs_cpu == true || RegTypedef._dataMisc._spectatorWatching == false && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && RegTypedef._dataPlayers._gamePlayersValues[Reg._move_number_next] == 1) 
			{
				PlayState.send("Save Lose Stats", RegTypedef._dataPlayers);				
				
				// do NOT use "Player Left Game Room" here. you will get a player left game, a lose was saved to player stats message after a normal game has ended.
				PlayState.send("Player Left Game", RegTypedef._dataPlayers);				
				
				Reg._game_offline_vs_cpu = false;
				Reg._game_online_vs_cpu = false;
				
				Reg._disconnectNow = true;	
			}			
		}
		
		// return to title screen cancelled
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "g1002")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

		}
		// leave __scene_waiting_room, this is what happens when the other player leaves the room.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "g1005"
		||  Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "g1005b")
		{			
			Reg._yesNoKeyPressValueAtMessage = 0;
		
			if (GameChatter != null && RegTypedef._dataPlayers._spectatorWatching == false)
			{
				// player has left so we can now click the chatter button.
				if (RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
				{
					GameChatter._chatterOpenCloseButton.active = true;
					GameChatter._chatterOpenCloseButton.visible = true;
				}
			}
			
			buttonShowAll();
			Reg._buttonCodeValues = "";
			
		}
				
		// draw offer.
		if (Reg._yesNoKeyPressValueAtMessage == 1 &&  Reg._buttonCodeValues == "g1004")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;			
			
			PlayState.send("Draw Offer", RegTypedef._dataQuestions);			
		}
		
		// draw button canceled.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "g1004")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
		}
		
		
		// restart game.
		if (Reg._yesNoKeyPressValueAtMessage == 1 &&  Reg._buttonCodeValues == "g1030")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;			
			Reg._notation_output = false;
			
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true) 
			{
				Reg._gameJumpTo = 0;				
				Reg._gameOverForAllPlayers = false;
				Reg._gameOverForPlayer = false;
				Reg._createGameRoom = true;
			}
			else PlayState.send("Restart Offer", RegTypedef._dataQuestions);
		}
		
		// restart canceled.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 &&  Reg._buttonCodeValues == "g1030")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
		}
		
		// draw accepted.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1010")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataQuestions._drawAnsweredAs = true;
			PlayState.send("Draw Answered As", RegTypedef._dataQuestions);			
		}
		
		// draw button, not accepted.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 &&  Reg._buttonCodeValues == "g1010")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataQuestions._drawAnsweredAs = false;
			PlayState.send("Draw Answered As", RegTypedef._dataQuestions);			
		}
		
		// restart game accepted.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1011")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataQuestions._restartGameAnsweredAs = true;
			PlayState.send("Restart Answered As", RegTypedef._dataQuestions);			
		}
		
		// restart game not accepted.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 &&  Reg._buttonCodeValues == "g1011")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataQuestions._restartGameAnsweredAs = false;
			PlayState.send("Restart Answered As", RegTypedef._dataQuestions);				
		}
		
		// this win block code is needed so that the next message that pops up does not automatically close.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1020")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// loss.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1021")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// quit game. yes button selected.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1050")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
			
			for (i in 0...4)
			{
				if (RegTypedef._dataMisc._username == RegTypedef._dataPlayers._usernamesStatic[i])
				{
					// currently this player is still at the game room but player requested to quit game, so set these values to 4.
					RegTypedef._dataPlayers._gamePlayersValues[i] = 4;	
					Reg._playerIDs = i;
				}
			}
			
			RegTriggers._messageLoss = "You lose.";
				
			RegTriggers._loss = true; // show a message box message from SceneGameRoom.hx
				
			Reg._gameOverForPlayer = true;
			Reg._playerWaitingAtGameRoom = true;
			RegTypedef._dataPlayers._quitGame = true;
			
			buttonHideAll();
			
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
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
				
				_totalPlayers -= 1;
				
				// the value of _totalPlayers is a bit misleading. the value refers to a two player game. the player that entered this function still should register a lose and is still playing a game but is not added to this vars total because time remaining is zero.
				if (_totalPlayers > 1)
				{					
					Reg._gameOverForPlayer = true;
					
					if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
					{
						PlayState.send("Save Lose Stats", RegTypedef._dataPlayers);						
					}
				}
								
				else // 2 players.
				{
					Reg._gameOverForPlayer = true;
						
					// the value of _totalPlayers is a bit misleading. the value refers to a two player game. the player that entered this function still should register a lose and is still playing a game but is not added to this vars total because time remaining is zero.
					if (_totalPlayers == 1 && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
					{
						PlayState.send("Save Lose Stats For Both", RegTypedef._dataPlayers);			
					}
				}
				
				PlayState.send("Game Players Values", RegTypedef._dataPlayers);				
				PlayState.send("Player Left Game", RegTypedef._dataPlayers);				
				
				for (i in 0...4)
				{
					if (RegTypedef._dataMisc._username == RegTypedef._dataPlayers._usernamesStatic[i])
					{
						// currently this player is still at the game room but player requested to quit game, so set these values to 4.
						RegTypedef._dataPlayers._gamePlayersValues[i] = 0;	
						Reg._playerIDs = i;
					}
				}
				
				PlayState.send("Game Players Values", RegTypedef._dataPlayers);				
			}
			
		}
		
		// quit game. no button selected.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "g1050")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// player1 lost online game
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1101")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// player2 lost online game
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1102")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// player3 lost online game
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1103")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// player4 lost online game
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1104")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// draw.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1022")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonShowAll();
		}
		
		// tournament eliminated.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "g1200")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		}
	}
	
	
	private function messageStartRestartGame():Void
	{
		Reg._messageId = 16210;
		Reg._buttonCodeValues = "g1030";
		messageBoxMessageOrder();
		
		// should this message box be displayed?
		if (RegCustom._start_game_offline_confirmation[Reg._tn] == true
		&&  Reg._game_offline_vs_cpu == true 
		||  RegCustom._start_game_offline_confirmation[Reg._tn] == true
		&&  Reg._game_offline_vs_player == true
		)
		{
			Reg._yesNoKeyPressValueAtMessage = 1;
		}
		
	}
	
	private function messageReturnToTitle():Void
	{
		Reg._buttonCodeValues = "g1002";
		
		if (RegCustom._to_title_from_game_room_confirmation[Reg._tn] == false)		
		{
			if (Reg._game_offline_vs_player == true 
			||	Reg._game_offline_vs_cpu == true
			) 
			{
				FlxG.switchState(new MenuState());
			}
			
			Reg._yesNoKeyPressValueAtMessage = 1;
		}
				
		else
		{
			Reg._messageId = 16250;			
			messageBoxMessageOrder();
		}
	}
	
	private function messageReturnToLobby():Void
	{
		Reg._buttonCodeValues = "g1000";
				
		if (RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] == false)
		{
			Reg._yesNoKeyPressValueAtMessage = 1;
		}
		
		else
		{
			Reg._messageId = 16300;
			messageBoxMessageOrder();
		}
		
	}
	
	private function messageQuitGame():Void
	{
		Reg._messageId = 16350;
		Reg._buttonCodeValues = "g1050";	
		messageBoxMessageOrder();
	}
	
	private function messageDrawOffer():Void
	{
		Reg._messageId = 16400;
		Reg._buttonCodeValues = "g1004";
		messageBoxMessageOrder();
	}
	
	private function messageReceiveDrawOffer():Void
	{
		Reg._messageId = 16450;
		Reg._buttonCodeValues = "g1010";	
		messageBoxMessageOrder();		
		
	}
	
	private function messageReceiveRestartOffer():Void
	{	
		Reg._messageId = 16500;
		Reg._buttonCodeValues = "g1011";	
		messageBoxMessageOrder();
		
		if (RegCustom._accept_automatic_start_game_request[Reg._tn] == true
		&&  Reg2._do_once_accept_game_start_request == false)
		{
			Reg2._do_once_accept_game_start_request = true;
			Reg._yesNoKeyPressValueAtMessage = 1;			
		}
		
	}
		
	// draw this class to screen.
	public function gamePlayerWhosTurnToMove():Void
	{
		if (_playerWhosTurnToMove != null)
		{
			_playerWhosTurnToMove.visible = false;
			_playerWhosTurnToMove.destroy();
			_playerWhosTurnToMove = null;
		}
		
		_playerWhosTurnToMove = new PlayerWhosTurnToMove();
		_playerWhosTurnToMove.visible = true;
		add(_playerWhosTurnToMove);
	}
	
	public function gamePlayerTimeRemainingMove():Void
	{	
		if (_playerTimeRemainingMove != null)
		{
			_playerTimeRemainingMove.visible = false;
			_playerTimeRemainingMove.destroy();
			_playerTimeRemainingMove = null;
		}

		if (RegCustom._timer_enabled[Reg._tn] == true
		||  RegTypedef._dataTournaments._move_piece == true) // always enabled for tournament play.
		{
			_playerTimeRemainingMove = new PlayerTimeRemainingMove(GameCreate._t, this);
			_playerTimeRemainingMove.visible = true;
			add(_playerTimeRemainingMove);
		}
		
		
		// this is needed.
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			PlayState.send("Player Move Time Remaining", RegTypedef._dataPlayers);
		}
		
	}

	// draw this class to screen.
	private function gameHistoryButtonsDisplayIt(i:Int):Void
	{
		var _iDsHistoryButtons = new IDsHistoryButtons(FlxG.width - 405 + (i * 75), FlxG.height - 453, i); 
		add(_iDsHistoryButtons);
	}
	
	// draw this class to screen.
	private function gameAddHUD():Void
	{
		if (_hud != null) _hud.destroy();
		_hud = new HUD();
		add(_hud);
	}
	
	
	public static function go_back_to_lobby():Void
	{
		// go back tolooby
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
		//Reg._goBackToLobby = true;
		
		SceneWaitingRoom._textPlayer1Stats.text = "";
		SceneWaitingRoom._textPlayer2Stats.text = "";
		SceneWaitingRoom._textPlayer3Stats.text = "";
		SceneWaitingRoom._textPlayer4Stats.text = "";
		
		RegTriggers._lobby = true;
	}

	public function printNotation():Void
	{		
		if (Reg2._updateNotation == true && Reg._chessCheckBypass == false) 
		{
			__game_history_and_notations.notationPrint();
			Reg2._updateNotation = false;
		}
	}	
	
	override public function destroy()
	{
		remove(__game_create);
		__game_create.destroy();
						
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._at_game_room == false) return;
		
		printNotation();
		
		if (RegTriggers._notationPrint == true)
		{
			RegTriggers._notationPrint = false;
			__game_history_and_notations.notationPrint();
			
		}
		
		
		if (RegTriggers._button_hide_all_scene_game_room == true)
		{
			RegTriggers._button_hide_all_scene_game_room = false;
			buttonHideAll();
		}
		
		if (RegTriggers._button_show_all_scene_game_room == true)
		{
			RegTriggers._button_show_all_scene_game_room = false;
			buttonShowAll();
		}
		
		// if offline then use these key events for these buttons
		if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true) 
		{			
			// disable these things so that playing cannot open a message box and mouse click it when computer is thinking about a move. the result will be a crash or some unexpected strange things, such as computer moving first.
			if (Reg._gameOverForPlayer == false && Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true && Reg._game_offline_vs_player == false)
			{
				if (buttonReturnToTitle != null) buttonReturnToTitle.active = false;
				if (buttonReturnToLobby != null) buttonReturnToLobby.active = false;
			}
		}
			
		var _count:Int = howManyPlayersAreInGameRoom();
		
		if (Reg._game_online_vs_cpu == true 
		&& PlayState._clientDisconnect == false
		|| Reg._game_offline_vs_cpu == false 
		&&  Reg._game_offline_vs_player == false
		&& PlayState._clientDisconnect == false)
		{
			if (Reg._game_online_vs_cpu == true 
			||  GameChatter._chatterIsOpen == false && Reg._messageId == 0 && _count > 1)
			{
				var _canStartGame = false;
				
				if (RegTypedef._dataMisc._username == RegTypedef._dataPlayers._usernamesStatic[0])
				{
					_canStartGame = true;
				}
				
				
				if (Reg._game_online_vs_cpu == true
				|| _canStartGame == true && Reg._gameOverForPlayer == true && Reg._gameOverForAllPlayers == true
				)
				{
					// this code hides the start game button if not a host or the game is in progress.
					if (RegTypedef._dataMisc._username 
					==  RegTypedef._dataPlayers._usernamesStatic[0])
					{
						if (Reg._game_online_vs_cpu == false
						&&  Reg._gameOverForAllPlayers == false
						||  Reg._game_online_vs_cpu == true
						&&  Reg._gameOverForPlayer == false
						)
						{
							if (buttonStartRestartGame != null)
							{
								buttonStartRestartGame.visible = false;
								buttonStartRestartGame.active = false;
							}
							
							else
							{
								buttonStartRestartGame2.visible = false;
								buttonStartRestartGame2.active = false;
							}
						}
						
						// this extra if code is needed because we could be entering into this if code from Reg._game_online_vs_cpu == true, the if condition above.
						else if (Reg._game_online_vs_cpu == false
						&&  Reg._gameOverForAllPlayers == true
						||  Reg._game_online_vs_cpu == true
						&&  Reg._gameOverForPlayer == true)
						{
							if (RegTypedef._dataPlayers._spectatorWatching == false)
							{
								if (buttonStartRestartGame != null)
									buttonStartRestartGame.active = true;	
								else
									buttonStartRestartGame2.visible = true;
							}
						}
					}
				}
				
				else
				{
					buttonStartRestartGame.visible = false;
					buttonStartRestartGame.active = false;
				}
				
				if (buttonReturnToTitle != null)
				{
					buttonReturnToTitle.active = true;
					buttonReturnToTitle.visible = true;
				}
				
				else
				{
					buttonReturnToTitle2.active = true;
					buttonReturnToTitle2.visible = true;
				}
				
				buttonReturnToLobby.active = true;
				buttonReturnToLobby.visible = true;
				
				// playing against the player online.
				if (Reg._game_online_vs_cpu == false
				&&  Reg._gameOverForPlayer == false 
				&&  Reg._gameOverForAllPlayers == false 
				&&  RegTypedef._dataPlayers._spectatorWatching == false)
				{
					buttonDrawGame.active = true;
					buttonDrawGame.visible = true;
					
					buttonQuitGame.active = true;
					buttonQuitGame.visible = true;
					
				}
				
				else if (Reg._game_online_vs_cpu == false)
				{					
					if (buttonDrawGame != null)
					{
						buttonDrawGame.visible = false;
						buttonDrawGame.active = false;
					}
					
					if (buttonQuitGame != null)
					{
						buttonQuitGame.visible = false;
						buttonQuitGame.active = false;
					}
				}
				if (buttonQuitGame != null)
				
				// show the quit game button if game against the computer online.
				// spectators cannot watch this game.
				if (buttonQuitGame != null
				&&  Reg._game_online_vs_cpu == true
				&&  RegTypedef._dataPlayers._spectatorWatching == false)
				{
					if (Reg._gameOverForPlayer == false)
					{
						buttonQuitGame.active = true;
						buttonQuitGame.visible = true;
					}
					else
					{
						buttonQuitGame.visible = false;
						buttonQuitGame.active = false;
					}
				}
				
			}
			
			// show / hide room letter when chatter window is open.
			if (GameChatter._chatterIsOpen == false)
			{
				_title.active = true;
				_title.visible = true;				
				
				if (Reg._gameHost == true 
				&&	Reg._gameOverForAllPlayers == true
				&&	RegTypedef._dataMisc._username
				==	RegTypedef._dataPlayers._usernamesDynamic[0])
				{
					buttonStartRestartGame.active = true;
					buttonStartRestartGame.visible = true;
				}
			}
			
			else
			{
				_title.visible = false;
				_title.active = false;
				
				buttonStartRestartGame.visible = false;
				buttonStartRestartGame.active = false;
			}
			
		}
		
		//*****************************
		// hide this button when computer's turn to move.
		if (Reg._gameId == 1) // chess
		{
			if (Reg._gameOverForPlayer == true)
			{
				Reg._move_number_next = 0;
				
			}
			
			else
			{
				if (Reg._game_online_vs_cpu == true
				&&	Reg._move_number_next == 1)
				{
					if (buttonStartRestartGame != null)
						buttonStartRestartGame.alpha = 0.3;
					else
						buttonStartRestartGame2.alpha = 0.3;
					
					Reg._messageId = 1000000;			
				}
				
				// hide this button when computer's turn to move.
				if (Reg._game_offline_vs_cpu == true
				&&	Reg._move_number_next == 1)
				{
					buttonStartRestartGame2.alpha = 0.3;
					Reg._messageId = 1000000;
				}
				
				// hide this button when computer's turn to move.
				if (Reg._game_online_vs_cpu == true
				&&	Reg._move_number_next == 1)
				{
					buttonReturnToTitle.alpha = 0.3;
					Reg._messageId = 1000000;
				}
				
				// hide this button when computer's turn to move.
				if (Reg._game_offline_vs_cpu == true
				&&	Reg._move_number_next == 1)
				{
					buttonReturnToTitle2.alpha = 0.3;
					Reg._messageId = 1000000;
				}
				
				// show this button when human's turn to move.
				if (Reg._game_online_vs_cpu == true
				&&	Reg._move_number_next == 0)
				{				
					if (buttonStartRestartGame != null)
						buttonStartRestartGame.alpha = 1;
					else
						buttonStartRestartGame2.alpha = 1;
				}
				
				// show this button when human's turn to move.
				if (Reg._game_offline_vs_cpu == true
				&&	Reg._move_number_next == 0)
				{
					buttonStartRestartGame2.alpha = 1;
				}
				
				// show this button when human's turn to move.
				if (Reg._game_online_vs_cpu == true
				&&	Reg._move_number_next == 0)
				{
					if (buttonReturnToTitle != null)
						buttonReturnToTitle.alpha = 1;
					else 
						buttonReturnToTitle2.alpha = 1;
				}
				
				// show this button when human's turn to move.
				if (Reg._game_offline_vs_cpu == true
				&&	Reg._move_number_next == 0)
				{
					buttonReturnToTitle2.alpha = 1;
				}
			}
			
		}
		
		//****************************
		var _totalPlayers:Int = 0;
		
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		// jump to a code to determine what message should be displayed if any. it all depends to what value _gamePlayersValues typedef has.
		if (RegTriggers._playerLeftGame == true)
		{				
			buttonHideAll(); // hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room.
						
			// hide open close chatter button because we have a message popup that needs to be clicked.
			if (GameChatter != null && RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
			{
				GameChatter._sprite_input_chat_border.visible = false;
				GameChatter._sprite_input_chat_border.active = false;	
				GameChatter._sprite_input_chat_background.visible = false;
				GameChatter._sprite_input_chat_background.active = false;
				GameChatter._input_chat.visible = false;
				GameChatter._input_chat.active = false;		
				GameChatter._chatInputButton.visible = false;
				GameChatter._chatInputButton.active = false;		
			}
			
			for (i in 0...4)
			{
				if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1 
				&&  RegTypedef._dataPlayers._usernamesDynamic[i] != "")
				{
					_totalPlayers += 1;
				}
			}
			
			var _count:Int = 0;
			
			
			// if more then 1 player in room and the _restartingTheGame game is true then that means that player has left the game while there are two or more players still playing game. continue the game after repopulating the data.
			if (_totalPlayers > 1)
			{
				var _restartingTheGame = _playersLeftGame.restartingTheGameForOthers();
				
				if (_restartingTheGame == true)
				{
					// if that player has a RegTypedef._dataPlayers._gamePlayersValues value of 1 or 3 then  this code is used so that playing the game for the other players the second time will not happen.	
					_playersLeftGame.assignMoveNumberPlayerAndShowRotator(); 
				}
				
			}

			

			for (i in 0...4)
			{
				// find the array element of the player leaving the game room. when we know if the player is leaving the game when its over or not.
				if (Reg._playerLeftGameUsername == RegTypedef._dataPlayers._usernamesStatic[i])
				{
					_count = i;
				}
			}
	
			// was player playing the game?
			var _found:Bool = false;
			
			// time expired. if _found var is true then show msg for players only.
			if (Reg._atTimerZeroFunction == true || RegTypedef._dataPlayers._gamePlayersValues[_count] == 0 && RegTypedef._dataPlayers._spectatorPlaying == true
			)
			{
				if (_totalPlayers <= 1) // only one player remaining.
				{
					if (RegTypedef._dataPlayers._spectatorWatching == false) 
					{
						Reg._messageId = 16800;
						Reg._buttonCodeValues = "g1005b";			
						messageBoxMessageOrder();							
					}	
									
					Reg._playerOffset += 1;
					
					if (RegTypedef._dataPlayers._spectatorWatching == true) 
					{
						// send this message to all spectator that are watching the game being played.
						RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
						
						if (Reg._game_online_vs_cpu == true)
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + "'s time expired. Game over for " + Reg._playerLeftGameUsername;
						else
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + "'s time expired. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
							
						PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
						
					}
				}
				
				else
				{
					if (RegTypedef._dataPlayers._spectatorWatching == false) 
					{
						Reg._messageId = 16850;
						Reg._buttonCodeValues = "g1005b";			
						messageBoxMessageOrder();								
					}	
					
					Reg._playerOffset += 1;
					
					if (RegTypedef._dataPlayers._spectatorWatching == true)
					{
						// send this message to all spectator that are watching the game being played. spectator cannot be player, so modify this message to exclude "you are now player message".
						RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
						
						if (Reg._game_online_vs_cpu == true)
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + "'s time expired. Game over for " + Reg._playerLeftGameUsername;
						else
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + "'s time expired. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
							
						PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
						
					}
					
					
				}
			}
			
	
			// 3: left game room when game was over. we need _count2 the value from _usernamesDynamic var and not _count the value from _usernamesStatic because _gamePlayersValues is redone when a player leaves the room. the array is re-populated from a MySQL table. only the spectatorPlaying var in that room is populated with the new data. so if there are two players left then the first player will now use element 1.
			else if (RegTypedef._dataPlayers._gamePlayersValues[_count] == 0 
			||  RegTypedef._dataPlayers._gamePlayersValues[_count] == 3)
			{
				if (RegTypedef._dataPlayers._spectatorWatching == false) 
				{
					Reg._messageId = 16900;
					Reg._buttonCodeValues = "g1005b";			
					messageBoxMessageOrder();
				}
								
				if (RegTypedef._dataPlayers._spectatorWatching == true)
				{
					// send this message to all spectator that are watching the game being played.
					RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
					RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " left the game room.";
					
					PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
				}
			}				
			
			// 4: quit game.
			else if (RegTypedef._dataPlayers._gamePlayersValues[_count] == 4 
			&&  Reg._atTimerZeroFunction == false
			&&	RegTypedef._dataPlayers._quitGame == true)
			{
				if (_totalPlayers <= 1)
				{
					if (RegTypedef._dataPlayers._spectatorWatching == false)
					{
						Reg._messageId = 16600;
						Reg._buttonCodeValues = "g1005";			
						messageBoxMessageOrder();
					}
					
					Reg._playerOffset += 1;
					
					if (RegTypedef._dataPlayers._spectatorWatching == true)
					{
						// send this message to all spectator that are watching the game being played.
						RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
						
						if (Reg._game_online_vs_cpu == true)
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " quit the game.";
						else
							RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " quit the game. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
					
						PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
						
					}
				}
				
				else
				{
					if (RegTypedef._dataPlayers._spectatorWatching == false)
					{
						Reg._messageId = 16700;
						Reg._buttonCodeValues = "g1005";			
						messageBoxMessageOrder();
					}
					
					Reg._playerOffset += 1;
					
					if (RegTypedef._dataPlayers._spectatorWatching == true)
					{
						// send this message to all spectator that are watching the game being played. spectator cannot be player, so modify this message to exclude "you are now player message".
						RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
						
						if (Reg._game_online_vs_cpu == true)
						RegTypedef._dataGameMessage._gameMessage = "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " quit the game.";
					else
						RegTypedef._dataGameMessage._gameMessage = "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " quit the game. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
						
						PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
					}
				
				}
			}
			
			// 2: left game room while still playing it. you are now player number...		
			else if (_totalPlayers > 1 
			&& RegTypedef._dataPlayers._gamePlayersValues[_count] == 2 
			&& Reg._playerLeftGameUsername 
			!= RegTypedef._dataMisc._username)
			{
				if (RegTypedef._dataPlayers._spectatorWatching == false)
				{
					Reg._messageId = 16750;
					Reg._buttonCodeValues = "g1005";			
					messageBoxMessageOrder();					
				}
				
				Reg._playerOffset += 1;
				
				if (RegTypedef._dataPlayers._spectatorWatching == true)
				{
					// send this message to all spectator that are watching the game being played. spectator cannot be player, so modify this message to exclude "you are now player message".
					RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
					
					if (Reg._game_online_vs_cpu == true)
						RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " left the game room.";
					else
						RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " left the game room. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
					
					PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);
				}
			}
			
			// 2: left game while still playing it.
			else if (RegTypedef._dataPlayers._gamePlayersValues[_count] == 2)	
			{
				if (RegTypedef._dataPlayers._spectatorWatching == false)
				{
					Reg._messageId = 16770;
					Reg._buttonCodeValues = "g1005";			
					messageBoxMessageOrder();		
				}						
								
				Reg._playerOffset += 1;
				
				if (RegTypedef._dataPlayers._spectatorWatching == true)
				{
					// send this message to all spectator that are watching the game being played.
					RegTypedef._dataGameMessage._userFrom = Reg._playerLeftGameUsername;
						
					if (Reg._game_online_vs_cpu == true)
						RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " left the game room.";
					else
						RegTypedef._dataGameMessage._gameMessage = Reg._playerLeftGameUsername + " left the game room. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.";
					
						
					PlayState.send("Game Message Box For Spectator Watching", RegTypedef._dataGameMessage);				
				}
			}
			
						
			
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
				Reg._gameOverForPlayer = true;
				RegFunctions.playerAllStop();
			}
			
			Reg._playerLeftGame = false;
			
			//--------------------------------- did player left the game room.
			RegTriggers._playerLeftGame = false;
			
			//---------------------------------
			
			var _count:Int = howManyPlayersAreInGameRoom(); 			
			
			
			// these buttons should be used only when both players are in room and playing a game. since a player has left game, hide these buttons.
			if (_count == 1) // only one player in room.
			{
				if (buttonStartRestartGame != null && Reg._game_online_vs_cpu == false)
				{
					buttonStartRestartGame.visible = false;
				}
				
				if (buttonStartRestartGame2 != null && Reg._game_online_vs_cpu == false)
				{
					buttonStartRestartGame2.visible = false;
				}
				
				if (buttonDrawGame != null) buttonDrawGame.visible = false;
				if (buttonQuitGame != null && Reg._game_online_vs_cpu == false)
					buttonQuitGame.visible = false;
				
				if (buttonStartRestartGame != null && Reg._game_online_vs_cpu == false) 
				{
					buttonStartRestartGame.active = false;
				}
				
				if (buttonStartRestartGame2 != null && Reg._game_online_vs_cpu == false) 
				{
					buttonStartRestartGame2.active = false;
				}
				
				if (buttonDrawGame != null) buttonDrawGame.active = false;
				if (buttonQuitGame != null && Reg._game_online_vs_cpu == false)
					buttonQuitGame.active = false;
			}
			
			for (i in 0...4)
			{
				// currently this player is still at the game room but player requested to quit game.
				if (RegTypedef._dataPlayers._gamePlayersValues[i] == 4)
				{
					// when game is over, this is needed to display a "player left game room" message to the other players when player leaves the game room.
					RegTypedef._dataPlayers._gamePlayersValues[i] = 0;	
					Reg._playerIDs = i;
					
					if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
					{
						PlayState.send("Game Players Values", RegTypedef._dataPlayers);					
					}
				}
			}
			
			
			RegTypedef._dataPlayers._quitGame = false;
			Reg._atTimerZeroFunction = false;
			Reg._playerIDs = -1;
			
		}
		
		/*
		var _restartingTheGame = restartingTheGameForOthers();
		
		// reset the _gamePlayersValues var for the other players because they need to continue a game after a player had left the game or had quit the game.
		if (_restartingTheGame == true)
		{
			var _count:Int = howManyPlayersAreInGameRoom();
			
			for (i in 0..._count-1)
			{
				// since game is continuing for the other player, this needs a value of 1 which means playing a game.
				RegTypedef._dataPlayers._gamePlayersValues[i] = 1;
			}
			
			
			var _user = Reg._playerLeftGameUsername;
			// remove the player, that left the game, from other player's RegTypedef.
			 
			if (_user == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&	RegTypedef._dataPlayers._gamePlayersValues[0] == 2
			||	_user == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&	RegTypedef._dataPlayers._gamePlayersValues[0] == 4)
			{
				RegTypedef._dataPlayers._gamePlayersValues.remove(RegTypedef._dataPlayers._gamePlayersValues[0]);
			}
			
			if (_user == RegTypedef._dataPlayers._usernamesDynamic[1]
			&&	RegTypedef._dataPlayers._gamePlayersValues[1] == 2
			||	_user == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&	RegTypedef._dataPlayers._gamePlayersValues[1] == 4)
			{
				RegTypedef._dataPlayers._gamePlayersValues.remove(RegTypedef._dataPlayers._gamePlayersValues[1]);
			}
			
			if (_user == RegTypedef._dataPlayers._usernamesDynamic[2]
			&&	RegTypedef._dataPlayers._gamePlayersValues[2] == 2
			||	_user == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&	RegTypedef._dataPlayers._gamePlayersValues[2] == 4)
			{
				RegTypedef._dataPlayers._gamePlayersValues.remove(RegTypedef._dataPlayers._gamePlayersValues[2]);
			}
			
			if (_user == RegTypedef._dataPlayers._usernamesDynamic[3]
			&&	RegTypedef._dataPlayers._gamePlayersValues[3] == 2
			||	_user == RegTypedef._dataPlayers._usernamesDynamic[0]
			&&	RegTypedef._dataPlayers._gamePlayersValues[3] == 4)
			{
				RegTypedef._dataPlayers._gamePlayersValues.remove(RegTypedef._dataPlayers._gamePlayersValues[3]);
			}

			for (i in 0...4)
			{
				if (i > RegTypedef._dataPlayers._gamePlayersValues.length-1)
							RegTypedef._dataPlayers._gamePlayersValues.push(0);
						
			}
		}	
	*/
		
		if (RegTriggers._win == true)
		{
			RegTriggers._win = false;			
			
			// game over message.			
			Reg._messageId = 16050;
			Reg._buttonCodeValues = "g1020";		
			messageBoxMessageOrder();			
			
			buttonHideAll(); // hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room.
			
			
			//############################# tournament eliminated message.			
			if (RegTypedef._dataTournaments._move_piece == true)
			{
				Reg._messageId = 16055;
				Reg._buttonCodeValues = "g1200";
				
				messageBoxMessageOrder();
				
			}
			
		}
		
		if (RegTriggers._loss == true)
		{	
			RegTriggers._loss = false;
			
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
				Reg._messageId = 16100;
				Reg._buttonCodeValues = "g1021";			
				messageBoxMessageOrder();
			}
			
			else
			{
				switch (Reg._move_number_next)
				{
					case 0:
					{
						Reg._messageId = 16105;
						Reg._buttonCodeValues = "g1101";			
						messageBoxMessageOrder();
					}
					
					case 1:
					{
						Reg._messageId = 16110;
						Reg._buttonCodeValues = "g1102";			
						messageBoxMessageOrder();
					}
					
					case 2:
					{
						Reg._messageId = 16115;
						Reg._buttonCodeValues = "g1103";			
						messageBoxMessageOrder();						
					}
					
					case 3:
					{
						Reg._messageId = 16120;
						Reg._buttonCodeValues = "g1104";			
						messageBoxMessageOrder();				
					}
				}
				
				
				if (RegTypedef._dataTournaments._move_piece == true)
				{
					Reg._messageId = 16150;
					Reg._buttonCodeValues = "g1200";
					messageBoxMessageOrder();
										
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					RegFunctions.playerAllStop();
					
					RegTypedef._dataTournaments._time_remaining_player1 = Std.string(RegTypedef._dataPlayers._moveTimeRemaining[0]);
					RegTypedef._dataTournaments._time_remaining_player2 = Std.string(RegTypedef._dataPlayers._moveTimeRemaining[1]);

					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 0;
					PlayState.send("Tournament Chess Standard 8 Put", RegTypedef._dataTournaments);		
				}				
			}
				
			buttonHideAll(); // hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room or time expires.
		}
		
		if (RegTriggers._draw == true)
		{
			RegTriggers._draw = false;			
			
			Reg._messageId = 16200;
			Reg._buttonCodeValues = "g1022";
			messageBoxMessageOrder();
				
			buttonHideAll(); // hide the restart, draw and lobby buttons because a restart button, for example, should not be shown when a player leave the game room.
		}
		
		
		// did user confirm the start game at the message popup. if so then run this code.
			
		if (Reg._drawOffer == true)
		{
			Reg._drawOffer = false;
			messageReceiveDrawOffer();
		}
		
		if (Reg._restartOffer == true)
		{
			Reg._restartOffer = false;
			messageReceiveRestartOffer();
		}
		
		// close / open chatter window. value c10000 is from game chatter class.
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._buttonCodeValues == "c10000")
		toggleButtonsAsChatterScrolls();
			
		//############################# GAMES THAT USE SPRITE GROUP
		if (__game_create._spriteGroup != null)
		{
			if (RegTriggers._spriteGroup > 0)
			{
				if (RegTriggers._spriteGroup == 1)
				{
					__game_create._spriteGroup.members.remove(__game_create._playerPieces1);
					__game_create._spriteGroup.add(__game_create._playerPieces1);
				}
				
				if (RegTriggers._spriteGroup == 2)
				{
					__game_create._spriteGroup.members.remove(__game_create._playerPieces2);
					__game_create._spriteGroup.add(__game_create._playerPieces2);
				}
				
				if (RegTriggers._spriteGroup == 3)
				{
					__game_create._spriteGroup.members.remove(__game_create._playerPieces3);
					__game_create._spriteGroup.add(__game_create._playerPieces3);
				}
				
				if (RegTriggers._spriteGroup == 4)
				{
					__game_create._spriteGroup.members.remove(__game_create._playerPieces4);
					__game_create._spriteGroup.add(__game_create._playerPieces4);
				}
				
				RegTriggers._spriteGroup = 0;
			}
		}
		
		#if wheelEstate
			// this is the window that appears after a dice click.	
			if (RegTriggers._signatureGame == true 
			&& Reg._gameDiceCurrentIndex[Reg._move_number_next] == Reg._gameDiceMaximumIndex[Reg._move_number_next] 
			&& Reg._triggerNextStuffToDo == 1
			&& Reg._isThisPieceAtBackdoor == false
			&& Reg._gameDidFirstMove == true)
			{
				RegTriggers._signatureGame = false;
				__game_create.__signature_game_main.initialize();
				
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._game_online_vs_cpu == false) Reg._triggerNextStuffToDo = 3;
			}
		#end
		
		var _count:Int = howManyPlayersAreInGameRoom();
		
		// these buttons should be used only when both players are in room and playing a game. since a player has left game, hide these buttons.
		if (_count == 1) // only one player in room.
		{
			if (buttonStartRestartGame != null && Reg._game_online_vs_cpu == false)
			{
				buttonStartRestartGame.visible = false;
				buttonStartRestartGame.active = false;
			}
			
			if (buttonStartRestartGame2 != null && Reg._game_online_vs_cpu == false)
			{
				buttonStartRestartGame2.visible = false;
				buttonStartRestartGame2.active = false;
			}
			
			if (buttonDrawGame != null)
			{		
				buttonDrawGame.visible = false;
				buttonDrawGame.active = false;
			}
			
		}
				
		// player quit, left game room or timer expired, so remove that players data from the stage of the other players stage.
		if (RegTriggers._removePlayersDataFromStage == true)
		{
			RegTriggers._removePlayersDataFromStage = false;
			removePlayersDataFromStage();
		}
		
		if (RegTriggers._eventSpectatorWatchingMessageBoxMessages == true)
		{
			RegTriggers._eventSpectatorWatchingMessageBoxMessages = false;
			spectatorWatchingMessageBoxMessage();
		}
	
		super.update(elapsed);
		
	}
}//