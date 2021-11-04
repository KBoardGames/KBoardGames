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
 * ...
 * @author kboardgames.com
 */
class GameCreate extends FlxState
{
	/******************************
	 * is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
	 */
	private var __chess_check_or_checkmate:ChessCheckOrCheckmate; // instance of a class.
	
	/******************************
	 * player move piece total time.
	 */
	public static var _t:Int = 0;
	
	/******************************
	 * buy, sell, trade or pay rent. main game loop.
	 */
	public var __signature_game_main:SignatureGameMain;
	
	/******************************
	 * the unit is highlighted when the mouse is clicked on it.
	 */
	public var __game_image_current_unit:GameImageCurrentUnit;
	
	/******************************
	* the dice wheel, highlights each number, in turn. from 1 to 6. the number highlighted, after a mouse click, is the number used to move a piece that many times from the piece's current location.
	*/
	public var __number_wheel:NumberWheel;
	
	public var _playerPieces1:Dynamic;
	public var _playerPieces2:Dynamic;
	public var _playerPieces3:Dynamic;
	public var _playerPieces4:Dynamic;
	
	/******************************
	 * alternating colors of game board squares. this is the light color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorDark:Array<FlxColor> = [0xFFc2d93c, 0xFF9d6253, 0xFF003300, 0xFFf5f151, 0xFFbbbbbb];
	
	/******************************
	 * alternating colors of game board squares. this is the dark color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorLight:Array<FlxColor> = [0xFF114c2e, 0xFF562a20, 0xFF004400, 0xFFf5515a, 0xFFffffff];
	
	/******************************
	 * the numbers 1 to 8 and the letter a to h at the side of the gameboard.
	 */
	private var _gameboardBorder:FlxSprite;
	
	/******************************
	 * fill the screen with a random color.
	 */
	private var _background_scene_color:FlxSprite;
	
	/******************************
	 * display an image to full the scene.
	 */
	private var _background_gradient_scene:FlxSprite;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/******************************
	* this refers to the chess, checker or another board currently displayed.
	*/
	public static var _gameBoard:Array<FlxSprite> = [];
	
	/******************************
	 * when players can overlap one another on a game unit (games such as snakes and ladders) then this group is used to bring the player's sprite that is moving to the front.
	 */
	public var _spriteGroup:FlxGroup;
	
	/******************************
	 * holds all player's pieces. used to ADD both player's pieces to the screen.
	 */
	public var _groupPlayerPieces:FlxSpriteGroup;
	
	/******************************
	 * a sprite group that refers to highlights any square, with an image, that the player is able to move the piece to.
	 */
	public var _groupCapturingUnit:FlxSpriteGroup;
	
	public var __game_house_taxi_cafe:SignatureGameReferenceImages;
		
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var _scene_background:SceneBackground;
	
	public static var _sprite_board_game_unit_even:FlxSprite;
	public static var _sprite_board_game_unit_odd:FlxSprite;
	public static var _currentUnitClicked_gameID0:CheckersCurrentUnitClicked;
	public static var _currentUnitClicked_gameID1:ChessCurrentUnitClicked;
	
	private var __checkers:Checkers;
	private var __chess:Chess;
	private var __reversi:Reversi;
	private var __snakes_and_ladders:SnakesAndLadders;
	private var __signature_game:SignatureGame;
	
	public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw, chess_check_or_checkmate:ChessCheckOrCheckmate) 
	{
		super();
		
		_t = 0;
		
		RegFunctions.fontsSharpen();
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		__chess_check_or_checkmate = chess_check_or_checkmate;
	}
	
	
	/******************************
	 * draw the board and players pieces.
	 */
	public function gameId_set_board_and_pieces():Void
	{
		_groupCapturingUnit = new FlxSpriteGroup();
		_groupCapturingUnit.scrollFactor.set(0, 0);
		_groupPlayerPieces = new FlxSpriteGroup();
		_groupPlayerPieces.scrollFactor.set(0, 0);
		
		Reg._groupPlayer1 = new FlxSpriteGroup();
		Reg._groupPlayer1.scrollFactor.set(0, 0);
		Reg._groupPlayer2 = new FlxSpriteGroup();
		Reg._groupPlayer2.scrollFactor.set(0, 0);
		
		draw_gameboard_border_and_coordinates();
		
		switch (Reg._gameId)
		{
			// checker game.
			case 0: // 0 = empty tile. 1 = player one. 11 = plyer two. 7/17:circle, 8/18:X. circle and X are used for teaching checkers. put them on the board here then screenshot the image.	
			{
				__checkers = new Checkers(this); // draw the standard gameboard to screen and coordinate image and any other stuff.
				add(__checkers);
				
				// this is the layout of the checkers pieces when the game first starts.
				__checkers.default_layout_checkers();
				gameId_draw_pieces(); // this function will draw the game pieces to the screen.
			}
			
			// chess game.
			case 1: // 0 = empty tile. 1 = player one. 11 = plyer two.		
			{
				__chess = new Chess(this);
				add(__chess);
			
				__chess.default_layout_chess();				
				gameId_draw_pieces(); // this function will draw the game pieces to the screen.
			}	
			// Reversi game.
			case 2:	
			{
				//#############################
				// uncomment this when testing different piece positions other than beginning of game.
				//Reg._triggerNextStuffToDo = 4;
				//#############################
				__reversi = new Reversi(this);
				add(__reversi);
			
				__reversi.default_layout_reversi();
				gameId_draw_pieces();
			}
			
			// snakes and ladders game.
			case 3:	
			{
				__snakes_and_ladders = new SnakesAndLadders(this);
				add(__snakes_and_ladders);
			
				__snakes_and_ladders.default_layout_snakes_and_ladders();				
				gameId_draw_pieces();
			}
			
			// signature game.
			case 4:	
			{
				__signature_game = new SignatureGame(this);
				add(__signature_game);
			
				__signature_game.default_layout_signature_game();			gameId_draw_pieces();
			}
		}	
		
		if (Reg._spectator_watching_entering_game_room_message == false 
		&&  RegTypedef._dataPlayers._spectatorWatching == true)
		{
			Reg._spectator_watching_entering_game_room_message = true;
			
			Reg._gameMessage = "You are a watching spectator.";
			Reg._outputMessage = true;
			
		}

	}
	
	private function gameId_draw_pieces():Void
	{
		var pp = -1;
		
		if (RegTypedef._dataTournaments._move_piece == false)
			RegTypedef._dataPlayers._moveTotal = 0;
			
		if (RegTypedef._dataMovement._history_get_all == 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					pp += 1;
					
					Reg._gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece2[yy][xx];
					Reg._gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece2[yy][xx];
					
					Reg._gamePointValueOfUnit[pp] = Reg._gamePointValueForPiece[yy][xx];
				}
			}
		}
		
		else
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
			Reg._moveHistoryPieceValueOld3.splice(0, Reg._moveHistoryPieceValueOld3.length);
			Reg._step = 0;
			//------------------------------
		}
		
		switch (Reg._gameId)
		{
			case 0: __checkers.create_checkers_game();
			case 1: __chess.create_chess_game();
			case 2: __reversi.create_reversi_game();
			case 3: __snakes_and_ladders.create_snakes_and_ladders_game();
			case 4: __signature_game.create_signature_game();
		}
		
	}	
	
	/******************************
	 * when a player move is completed then this function sends all the important data to the server when the Reg._pieceMovedUpdateServer is set to true.
	 * @param	i	the game being played. 0:checkers, 1:chess,
	 */
	public function gameId_send_data_to_server():Void
	{
		//*****************************
		// PLAYER MOVEMENT ************					
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
		{
			RegTypedef._dataPlayers._moveTotal += 1;
			
			switch (Reg._gameId)
			{
				case 0: Checkers.server_data();
				case 1: Chess.server_data();
				case 2: Reversi.server_data();
				case 3: SnakesAndLadders.server_data();
				case 4: SignatureGame.server_data();
			}
		}
		
		//events. online.
		if (Reg._game_offline_vs_cpu == false 
		&&  Reg._game_offline_vs_player == false
		&&  RegTypedef._dataTournaments._move_piece == false) 
		{
			NetworkEventsIds.gotoMovePlayerEvent();
		}
		else // if here then this is an offline game.
		{										
			if (Reg._game_offline_vs_cpu == true 
			||  Reg._game_offline_vs_player == true
			||  RegTypedef._dataTournaments._move_piece == true)
			{
				if (Reg._playerMoving == 1) 
					Reg._chessUnitsInCheckTotal[1] = 0; 
				else if (RegTypedef._dataTournaments._move_piece == false)
					RegTypedef._dataPlayers._moveTotal += 1;
				
				// by default all board games use this class.
				GameClearVars.clearVarsOnMoveUpdate();
				
				if (Reg._gameId == 0)
				{
					if (Reg._gameNotationOddEven == 0) Reg._gameNotationOddEven = 1;
					
					Reg._checkersFoundPieceToJumpOver = false;

					if (Reg._gameYYnew != -1 && Reg._gameXXnew != -1)
					CheckersCapturingUnits.jumpCapturingUnitsForPiece(Reg._gameYYnew, Reg._gameXXnew, Reg._playerMoving);
					
					if (Reg._checkersFoundPieceToJumpOver == true)
						Reg._checkersIsThisFirstMove = false;
				}
				
				if (Reg._gameId == 1)						
				{
					GameClearVars.clearCheckAndCheckmateVars();						
					ChessCapturingUnits.capturingUnits();						
					
					if (Reg._chessCheckBypass == false)
					{							
						if (Reg._chessCheckmateBypass == false) 
							__chess_check_or_checkmate.isThisCheckOrCheckmate();
					}
					
					GameClearVars.clearVarsOnMoveUpdate();
					GameClearVars.clearCheckAndCheckmateVars();
					
					//ChessMoveCPUsPiece._checkmate_loop = 0;
					
					if (Reg._gameNotationOddEven == 0) Reg._gameNotationOddEven = 1;
					
					__ids_win_lose_or_draw.canPlayerMove1();
				}
					
			}
				
			
		}		
	}

	/******************************
	 * client is sending a move request to the other clients
	 */
	public static function gameId_set_movement():Void
	{
		if (Reg._gameId == 4)
		{
			//RegTypedef._dataMovement._triggerNextStuffToDo = Reg._triggerNextStuffToDo;
			RegTypedef._dataMovement._gameDiceMaximumIndex = Reg._backdoorMoveValue;
		}
		
		PlayState.clientSocket.send("Movement", RegTypedef._dataMovement);
		// send event here.
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
	public function removeSpriteGroup():Void
	{
		if (_spriteGroup != null)
		{
			if (_spriteGroup.members != null)
			{
				if (_playerPieces1 != null)
				{
					_spriteGroup.members.remove(_playerPieces1);
					_playerPieces1.visible = false;
					_playerPieces1 = null;
				}
				
				if (_playerPieces2 != null)
				{
					_spriteGroup.members.remove(_playerPieces2);
					_playerPieces2.visible = false;
					_playerPieces2 = null;
				}
				
				if (_playerPieces3 != null)
				{
					_spriteGroup.members.remove(_playerPieces3);
					_playerPieces3.visible = false;
					_playerPieces3 = null;
				}
				
				if (_playerPieces4 != null)
				{
					_spriteGroup.members.remove(_playerPieces4);
					_playerPieces4.visible = false;
					_playerPieces4 = null;
				}
				
				_spriteGroup.members = null;
			}
			
			_spriteGroup.visible = false;		
			remove(_spriteGroup);
			
			_spriteGroup.destroy();
			_spriteGroup = null;
		}
				
		
		
	}
	
	public function addSpriteGroup():Void
	{
		// player's piece used to navigate the game board.
		_spriteGroup = new FlxGroup();		
		
		var _y = 0;
		var _x = 0;
	
		// x and y values are in correct positions. These are player's game pieces. they represent the player. player has one piece, different then the other pieces. the piece that is about to move, after a dice rotation mouse click, will be sent to the front of all other pieces.
		_y = get_piece_location_from_value_y(0);
		_x = get_piece_location_from_value_x(0);
		
		_playerPieces1 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 1, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		_playerPieces1.scrollFactor.set(0, 0);
		_spriteGroup.add(_playerPieces1);
		
		// need + 1 because Reg._totalPlayersInRoom starts with 0 for the first player.
		if (Reg._totalPlayersInRoom + 1 >= 2)
		{
			_y = get_piece_location_from_value_y(1);
			_x = get_piece_location_from_value_x(1);
			
			_playerPieces2 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 2, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces2.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces2);			
		}
		
		if (Reg._totalPlayersInRoom + 1 >= 3)
		{
			_y = get_piece_location_from_value_y(2);
			_x = get_piece_location_from_value_x(2);
			
			_playerPieces3 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 3, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces3.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces3);
		}
		
		if (Reg._totalPlayersInRoom + 1 >= 4)
		{
			_y = get_piece_location_from_value_y(3);
			_x = get_piece_location_from_value_x(3);
			
			_playerPieces4 = new SignatureGameMovePlayersPiece(_gameBoard[0].x + (_x * 75), _gameBoard[0].y + (_y * 75), 4, __ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
			_playerPieces4.scrollFactor.set(0, 0);
			_spriteGroup.add(_playerPieces4);
		}
		
		add(_spriteGroup);
		
	}
		
	// when a player leaves the game and the game continues for the other players, a new piece color is given to each player. this function is used to move the new colored piece for the player back to the location where the last player's color was at. this gets the value of the piece location. y coordinates. 
	private function get_piece_location_from_value_y(_num):Int
	{
		var _y = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == (Reg._gameDiceCurrentIndex[_num] + 1))
				{
					_y = yy;
				}
				
			}
		}
	
		return _y;
	}
	
	// gets the value of the piece location. x coordinates.
	private function get_piece_location_from_value_x(_num):Int
	{
		var _x = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == (Reg._gameDiceCurrentIndex[_num] + 1))
				{
					_x = xx;
				}
				
			}
		}
	
		return _x;
	}
	
	private function draw_gameboard_border_and_coordinates():Void
	{
		//------------------------------
		RegFunctions._gameMenu = new FlxSave(); // initialize		
		RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
		
		RegCustom.resetConfigurationVars();
		RegFunctions.loadConfig();
		if (Reg._tn == 0) RegCustom.resetConfigurationVars2();
		
		PlayState.getPlayersNamesAndAvatars();
		
		if (_scene_background != null)
		{
			remove(_scene_background);
			_scene_background.destroy();
		}
		
		_scene_background = new SceneBackground();
		add(_scene_background);
		
		if (RegCustom._gameboard_border_enabled[Reg._tn] == true)
		{
			_gameboardBorder = new FlxSprite();
			_gameboardBorder.loadGraphic("assets/images/gameboardBorder"+ RegCustom._gameboard_border_number[Reg._tn] +".png", false);
			_gameboardBorder.setPosition(Reg._unitXgameBoardLocation[0]-30, Reg._unitYgameBoardLocation[0]-30);
			_gameboardBorder.scrollFactor.set(0, 0);
			add(_gameboardBorder);
		}
		
		// the numbers 1 to 8 and the letter a to h at the side of the gameboard.
		if (RegCustom._gameboard_coordinates_enabled[Reg._tn] == true)
		{
			var _coordinates = new FlxSprite();
			_coordinates.loadGraphic("assets/images/coordinates.png", false);
			_coordinates.setPosition(Reg._unitXgameBoardLocation[0]-30, Reg._unitYgameBoardLocation[0]-30);
			_coordinates.scrollFactor.set(0, 0);
			add(_coordinates);
		}
	}
	
	public function gameId_dice(X:Float, Y:Float):Void
	{
		__number_wheel = new NumberWheel(X, Y);
		add(__number_wheel);
		
		if (Reg._gameId == 3)
		{
			var _clickMe = new SnakesAndLaddersClickMe(X, Y, __number_wheel);
			add(_clickMe);	
		}
		if (Reg._gameId == 4)
		{
			var _clickMe = new SignatureGameClickMe(X, Y, __number_wheel, __ids_win_lose_or_draw, _playerPieces1, _playerPieces2, _playerPieces3, _playerPieces4);
			add(_clickMe);	
		}
			
	}
	
	
	public static function timeGivenForEachGame(_num:Int = -1):Void
	{
		if (_num == -1) _num = Reg._gameId;
		
		// set to 10 minutes for a move if playing a tournament game.
		if (RegTypedef._dataTournaments._move_piece == false)
		{
			// time is set at the ConfigurationGames.hx file. we times it by 60 to create the seconds allowed for the game.
			#if !html5
				_t = RegCustom._time_remaining_for_game[Reg._tn][_num] * 60;
			#else
				_t = 10 * 60;
			#end
		}
		
		RegTypedef._dataPlayers._timeTotal = _t;
		RegTypedef._dataStatistics._timeTotal = _t;
	}
	
	
}//