package;

/**
 * highlights which players turn it is to move. 
 * @author kboardgames.com
 */
class NetworkEventsIds extends FlxState
{

	private var __chess_check_or_checkmate:ChessCheckOrCheckmate;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	private var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	override public function new(ids_win_lose_or_draw:IDsWinLoseOrDraw):Void
	{
		super();
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		__chess_check_or_checkmate = new ChessCheckOrCheckmate(__ids_win_lose_or_draw);
		add(__chess_check_or_checkmate);
		
		ids();
	}
	
	public function ids():Void
	{
		playerMoveId0(); // checkers. this function is called when player moves a piece.
			
		playerMoveId1();
		playerMoveId2();
		playerMoveId3();
		playerMoveId4();
		
		Movement(); // makes all clients move the same piece at the same time.
	}
		
	public static function gotoMovePlayerEvent():Void
	{
		switch (Reg._gameId)
		{
			case 0: 
			{
				PlayState.clientSocket.send("Player Move Id 0", RegTypedef._dataGame0); // send _player _data to server so that server can send that _data to all other clients.
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			case 1:
			{
				PlayState.clientSocket.send("Player Move Id 1", RegTypedef._dataGame1);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			case 2: 
			{
				PlayState.clientSocket.send("Player Move Id 2", RegTypedef._dataGame2);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			case 3: 
			{
				PlayState.clientSocket.send("Player Move Id 3", RegTypedef._dataGame3);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			case 4: 
			{
				PlayState.clientSocket.send("Player Move Id 4", RegTypedef._dataGame4);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
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
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. checkers. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId0():Void
	{
		PlayState.clientSocket.events.on("Player Move Id 0", function (_data)
		{
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
				
				if (Reg._gameUnitNumberNew > -1) 
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
		});
	}

	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. chess. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId1():Void
	{
		PlayState.clientSocket.events.on("Player Move Id 1", function (_data)
		{
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
		});
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. Reversi. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId2():Void
	{
		PlayState.clientSocket.events.on("Player Move Id 2", function (_data)
		{
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
		});
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. snakes and ladders. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId3():Void
	{
		PlayState.clientSocket.events.on("Player Move Id 3", function (_data)
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
		});
	}
	
	/******************************
	* EVENT PLAYER MOVE
	* player moves piece. signature game. also change vars at GameIDsCreateAndMain.hx
	*/
	public function playerMoveId4():Void
	{
		PlayState.clientSocket.events.on("Player Move Id 4", function (_data)
		{
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
		});
	}
			
	/******************************
	 * makes all clients move the same piece at the same time. this is not automatic. you need to set the values below at the game code. see SignatureGameClickMe.hx and SignatureGameMovePlayersPiece.hx.
	 */
	public function Movement():Void
	{
		PlayState.clientSocket.events.on("Movement", function (_data)
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
		});
	}
}