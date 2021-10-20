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
 * ...the main loop. find units to move to.
 * @author kboardgames.com
 */
class ChessCurrentUnitClicked extends FlxSprite
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
		
	/******************************   * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * delay the computer from moving piece.
	 */
	public static var _ticksDelay:Int = 0;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	public static var _doOnce:Bool = false;
	
	public function new (y:Float, x:Float, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
		
		_startX = x;
		_startY = y;
		
		_ticksDelay = 0;
		_doOnce = false;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		loadGraphic("assets/images/currentUnitClicked.png", false, 75, 75, true);
	
		
		visible = false;
	}
	
	public static function populateCapturingUnits(yy:Int, xx:Int, p:Int):Void
	{
		//Reg._gameDidFirstMove = true;
		Reg._chessIsKingMoving = false;	
		Reg._chessUnitsInCheckTotal[0] = 0;
		Reg._chessUnitsInCheckTotal[1] = 0;
			
		// when the unit is clicked, the unit number is stored in this var. later this var will be read so that the unit to be move to and moved from can be determined.
		Reg._gameUnitNumber = p;

		moveChessPieceHere(xx, yy, 1);							
	}
	
	
	public static function movePieceSub(yy:Int, xx:Int):Void
	{		
		// consider that if the rook at the bottom-right corner of the gameboard was clicked then we must make the move to unit the same values as that unit...
		Reg._gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
		Reg._gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold];
		
		// ... next we make that unit a value of zero so that it can not be captured and later have an empty image piece when we make the final movement changes to the sprite.
		Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
		Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;	
		
		Reg._gameOtherPlayerXold = Reg._gameXXold;
		Reg._gameOtherPlayerYold = Reg._gameYYold;
		Reg._gameOtherPlayerXnew = Reg._gameXXnew;
		Reg._gameOtherPlayerYnew = Reg._gameYYnew;
			
		ChessEnPassant.isThisMoveAnEnPassant();
		ChessCastling.hasKingMoved();
		ChessCastling.hasRookMoved();
		
		// make the final movement change to the sprite. when this var is true, a code block at PlaerPieces.hx is read at its update function. see update at that class for how the sprite is moved to the new unit.				
		Reg._gameMovePiece = true;
														
		// should a pawn be promoted?
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1 && Reg._gameYYnew == 0 
		|| Reg._gameHost == false && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11 && Reg._gameYYnew == 7) 
		Reg._chessPromote = true; 
		else Reg._pieceMovedUpdateServer = true;
	}
	
	public static function movePieceSub2(yy:Int, xx:Int):Void
	{		
		// consider that if the rook at the bottom-right corner of the gameboard was clicked then we must make the move to unit the same values as that unit...
		Reg._gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece[Reg._gameYYold2][Reg._gameXXold2];
		Reg._gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece[Reg._gameYYold2][Reg._gameXXold2];
		
		// ... next we make that unit a value of zero so that it can not be captured and later have an empty image piece when we make the final movement changes to the sprite.
		Reg._gamePointValueForPiece[Reg._gameYYold2][Reg._gameXXold2] = 0;
		Reg._gameUniqueValueForPiece[Reg._gameYYold2][Reg._gameXXold2] = 0;	
		
		// make the final movement change to the sprite. when this var is true, a code block at PlaerPieces.hx is read at its update function. see update at that class for how the sprite is moved to the new unit.				
		Reg._gameMovePiece = true;
		Reg._pieceMovedUpdateServer = true;
	}
	
	/**
	 * determines if a piece can be moved. 
	 * this is the main function that passes data to other functions to determine check or even if a piece can be moved.
	 * @param	xx		x coordinate of the piece that was clicked on.
	 * @param	yy		y coordinate.
	 * @param	val		game number. 0 = checkers. 1 = chess.
	 */
	public static function moveChessPieceHere(cx:Int, cy:Int, val:Int):Void
	{		
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
			// consider that the last unit of that gameboard was clicked. xx and yy will always refer to the unit number of 7/7. the units start from the top-left corner at a coordinate value of 0/0. 0 to 7 from left to right and 0 to 7 from top to bottom. cx/cy is used in this function for calculations. so, their value may change.
		var xx:Int = cx;
		var yy:Int = cy;

		if (xx < 0 || xx > 7) xx = 0;
		if (yy < 0 || yy > 7) yy = 0;
		
		//############################# MOVE PIECE
		
		// ChessImagesCapturingUnits is the unit that the player can move to. since this function is called when the mouse is clicked and this value is 1 then that means the player is moving to this unit that has a value of xx/yy.
		if (Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0 && Reg._gameYYold > -1)
		{
			// these vars holds the value of xx/yy. later, they will be read to determine where, at a different class, the players piece should be moved to. 
			Reg._gameXXnew = xx;
			Reg._gameYYnew = yy;
			
			HUD.gameTurns(yy, xx); // each player has 50 turns at start of game. when a player has no more turns then the game is a draw.
			
			// is this notation "x".
			GameHistoryAndNotations.notationX();
			
					
			// at mouse click, _gameUnitNumber equals p. since this unit is a move to unit, we need to store the value of p so we can loop through xx/yy or do something when an ID matches this value so that we can move this piece. see ChessMovePlayersPiece.hx class for move information.
			Reg._gameUnitNumberNew = Reg._gameUnitNumber; 		
				
			Reg._gameXXnew2 = -1;
			Reg._gameYYnew2 = -1;
			Reg._gameXXold2 = -1;
			Reg._gameYYold2 = -1;
			Reg._gameUnitNumberNew2 = -1;
			Reg._gameUnitNumberOld2 = -1;
			Reg._imageValueOfUnitOld3 = 0;
			Reg._pointValue2 = -1;
			Reg._uniqueValue2 = -1;
			
			// save the captured piece for the history when the game ends, if any.
			if (Reg._chessCastling == false)
			{
				// save the captured piece's location.
				if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 0)
				{
					// store the value of the captured piece.
					Reg._imageValueOfUnitOld3 = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
					
				}
			}
			
			movePieceSub(yy, xx);
			
			// computer - queenside castle.
			if (Reg._chessKingCanCastleHere[0][2] == 1 && Reg._gameXXnew == 2 && Reg._chessCastling == true)
			{
				Reg._chessKingCanCastleHere[0][2] = 0; 
				Reg._chessKingCanCastleHere[0][6] = 0;
				
				Reg._gameXXnew2 = 3;
				Reg._gameYYnew2 = 0;
				
				Reg._gameXXold2 = 0;
				Reg._gameYYold2 = 0;
			
				Reg._gameUnitNumberNew2 = 3;
				Reg._gameUnitNumberOld2 = 0;
				
				Reg._pointValue2 = 14;
				Reg._uniqueValue2 = 9; // TODO this value seems wrong.
			}
			
			// computer - kingside castle.
			if (Reg._chessKingCanCastleHere[0][6] == 1 && Reg._gameXXnew == 6 && Reg._chessCastling == true)
			{
				Reg._chessKingCanCastleHere[0][2] = 0;				
				Reg._chessKingCanCastleHere[0][6] = 0;
				
				Reg._gameXXnew2 = 5;
				Reg._gameYYnew2 = 0;
				
				Reg._gameXXold2 = 7;
				Reg._gameYYold2 = 0;
			
				Reg._gameUnitNumberNew2 = 5;
				Reg._gameUnitNumberOld2 = 7;
				
				Reg._pointValue2 = 14;
				Reg._uniqueValue2 = 10; // TODO this value seems wrong.
			}

			if (Reg._chessKingCanCastleHere[7][2] == 1 && Reg._gameXXnew == 2 && Reg._chessCastling == true)
			{
				Reg._chessKingCanCastleHere[7][2] = 0;
				Reg._chessKingCanCastleHere[7][6] = 0;
				
				Reg._gameXXnew2 = 3;
				Reg._gameYYnew2 = 7;
				
				Reg._gameXXold2 = 0;
				Reg._gameYYold2 = 7;
			
				Reg._gameUnitNumberNew2 = 59;
				Reg._gameUnitNumberOld2 = 56;
				
				Reg._pointValue2 = 4;
				Reg._uniqueValue2 = 9;
			}
		
			if (Reg._chessKingCanCastleHere[7][6] == 1 && Reg._gameXXnew == 6 && Reg._chessCastling == true)
			{
				Reg._chessKingCanCastleHere[7][2] = 0;				
				Reg._chessKingCanCastleHere[7][6] = 0;
				
				Reg._gameXXnew2 = 5;
				Reg._gameYYnew2 = 7;
				
				Reg._gameXXold2 = 7;
				Reg._gameYYold2 = 7;
			
				Reg._gameUnitNumberNew2 = 61;
				Reg._gameUnitNumberOld2 = 63;
				
				Reg._pointValue2 = 4;
				Reg._uniqueValue2 = 10;
				
			} 

			if (Reg._gameYYnew2 != -1) movePieceSub2(Reg._gameYYnew2, Reg._gameXXnew2);
			
						
			_doOnce = false;
			return;
		}
	
		// the following code handles what happen when a gameboard piece is clicked. the code sets values to the ChessImagesCapturingUnits and other important vars so that the ChessImagesCapturingUnits.hx class can use an image to highlight where the player can move to.
		Reg._gameXXold = xx; //since a player piece was clicked, we store the value of xx/yy so that...
		Reg._gameYYold = yy; //... its move from value can later be determined.
		 
		Reg._gameUnitNumberOld = Reg._gameUnitNumber; // we do that same here for its p value.
		 
		// 	PLAYER MOVING KING: check for protecting units.
		Reg._playerMoving = 0;
		if (Reg._gameHost == false) Reg._playerMoving = 1;
		
		// clear the ChessImagesCapturingUnits highlighted units.
		for (i in 0...2)
		{
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					Reg._capturingUnitsForImages[i][qy][qx] = 0;
					Reg._capturingUnitsForPieces[i][qy][qx] = 0;

				}				
			}
		}
		
		Reg._chessPathFromPawnOrHorse = false;
		
		normalMovementPieces(yy, xx);		
	}
	
	public static function normalMovementPieces(yy:Int, xx:Int)
	{
		GameClearVars.clearVarsOnMoveUpdate();
		
		var cx:Int = xx;
		var cy:Int = yy;
		
		ChessPieceAtPath.pathConditions(Reg._gameYYold, Reg._gameXXold);	
				
		ChessCapturingUnits.capturingUnits(false, false);
		ChessCastling.setCastling();
		
		ChessCapturingUnits.horseCapturingUnitsForImages(cy, cx);
		ChessCapturingUnits.pawnCapturingUnitsForImages(cy, cx);
		ChessCapturingUnits.BRQandKcapturingUnitsForImages(cy, cx);		
		
		ChessPieceAtPath.pathConditions(Reg._gameYYold, Reg._gameXXold); // needed again so that the pieces defending king stay within the path.
	}	
	
	override public function destroy()
	{
		_doOnce = false;
		_ticksDelay = 0;
	
		super.destroy();
	}
	
	override public function update (elapsed:Float)
	{
		if (Reg._checkmate == false 
		&&  Reg._gameOverForPlayer == false)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
			// p is the unit number. at the loop below, p starts at the top-left corner of the gameboard, the xx/yy value of zero, and increments as each unit is looped and moving in the direction of east. when the end of that first row is loop, the next row will be looped and p will still continue to be increased in size.
			var p = -1; // gameboard pieces.

			if (Reg._playerCanMovePiece == true && Reg._chessPawnPromotedMessage == false)//&& ChessMoveCPUsPiece._cpuTriggerMovePiece == false 
			{			 
				 // playing against the computer and its the computers turn...
				if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true
				||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true)
				{
					_ticksDelay += 1;
									
					if (_ticksDelay > 35) // delay the computer from moving piece.
					{
						if (Reg._gameDidFirstMove == true)
						{
							//ChessMoveCPUsPiece._checkmate_loop = 0;
							
							if (Reg._enableGameNotations == true)
							{								
								GameHistoryAndNotations.CPUgetNotationForNextMove();							
							}
							
							/*
							//############################# TODO DELETE THIS WHEN COMPUTER CODE IS FINSHED. IT IS USED TO BYPASS ECO NOTATION MOVES. UNCOMMENT WHEN TESTING CHESS PIECE UNIT LOCATIONS.
							Reg._foundNotation = false; // TODO delete this when changing piece order back to beginning at this location. if not true then a notation was not found. so the computer will not be able to move piece using that notation. this is a temp fix when programing computer.
							Reg._gameYYnew = Reg._gameOtherPlayerYnew; // delete.
							Reg._gameXXnew = Reg._gameOtherPlayerXnew; // delete.
							// DELETE THIS CODE BLOCK.							
							//#############################
							*/
							
							if (Reg._gameYYnew == Reg._gameOtherPlayerYnew && Reg._gameXXnew == Reg._gameOtherPlayerXnew && Reg._foundNotation == false)
							{
								Reg._chessKeepPieceDefendingAtPath = 0;
								
								Reg._chessStalemateBypassCheck = false;
								ChessCapturingUnits.setForPiecesVar(0);	
								Reg._chessStalemateBypassCheck = false;
								ChessCapturingUnits.setForPiecesVar(1);	
								
								Reg._chessCheckBypass = false;
								
								//ChessMoveCPUsPiece.initialize(); // reset vars.
								
							}
							
							else
							{
								//ChessMoveCPUsPiece._ticks = 4;
								//ChessMoveCPUsPiece._cpuTriggerMovePiece = true;
							}
													
						}
					}
									
					Reg._gameDidFirstMove = true;
					
				}
				
				// player.
				else if (Reg._at_input_keyboard == false)
				{				
					// these yy and xx vars are the vertical and horizonal coordinates of the units that make up the grid of the gameboard. each unit is 75 x 75 pixels. 
					for (yy in 0...8)
					{
						for (xx in 0...8)
						{
							p += 1;
												
							// determine if mouse is within a region of a grid unit.
							if (ActionInput.coordinateX() > _startX + (xx * 75) && ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
							&& ActionInput.coordinateY() > _startY + (yy * 75) && ActionInput.coordinateY() < _startY + 75 + (yy * 75)
							
							)
							{
								if (ActionInput.justPressed() == true
								&&  RegTypedef._dataMisc._spectatorWatching == false
								||  ActionInput.justPressed() == true
								&&  RegTypedef._dataTournaments._move_piece == true
								)
								{
									// if mouse is clicked and is at that player's piece then highlight that unit. also, you can click any unit that the player can move to.
									if (Reg._gameHost == true && ActionInput.overlaps(Reg._groupPlayer1) 
									|| Reg._gameHost == false && ActionInput.overlaps(Reg._groupPlayer2)
								  
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] != 0 && Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0 && Reg._gameDidFirstMove == true	&& Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] > 0 && Reg._chessIsKingMoving == true	  
														  
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] == true && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] <= 3 && Reg._gameUniqueValueForPiece[yy][xx] > 0 && Reg._gameDidFirstMove == true && Reg._chessIsKingMoving == true
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] > 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] == true && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 && Reg._gameUniqueValueForPiece[yy][xx] == 0 && Reg._gameDidFirstMove == true && Reg._chessIsKingMoving == true								  
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] == true && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 && Reg._gameDidFirstMove == true && Reg._chessIsKingMoving == true
								  
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 0 && Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0 && Reg._gameDidFirstMove == true && Reg._chessIsKingMoving == false

									// _chessCapturingPathToKing is reset at this point.
									|| Reg._chessUnitsInCheckTotal[Reg._playerMoving] != 0 && Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0 && Reg._gameDidFirstMove == true && Reg._chessIsKingMoving == false
									)
									{
										//ChessMoveCPUsPiece._checkmate_loop = 0;
										
										x = _startX + (xx * 75);
										y = _startY + (yy * 75);
										
										// when a second defender entered the path making the path smaller, the first defender will not be in that path anymore but will still have the value of this var as true. the result will be that the second defender piece will be limited in movement to the path. not what we want, so reset the vars.
										for (p in 0...10)
										{
											for (yy in 0...8)
											{
												for (xx in 0...8)
												{
													Reg._chessPathCoordinates[p][yy][xx] = 0;
													
												}
											}
										}
										
										Reg._chessKeepPieceDefendingAtPath = 0;
										Reg.resetCPUaiVars();	
										
										if (RegCustom._chess_show_last_piece_moved[Reg._tn] == true) visible = true;
										
										populateCapturingUnits(yy, xx, p);
										break;
									}
								}
							}					
						}
					}
				}
			} else _ticksDelay = 0;
			
			if (RegTypedef._dataPlayers._spectatorWatching == true
			&&  Reg._gameDidFirstMove == false
			&&  Reg._gameYYnewB == Reg._gameYYnew
			&&  Reg._gameXXnewB == Reg._gameXXnew
			||  Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true
			||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true)
			{
				x = _startX + Reg._gameXXnew * 75;						
				y = _startY + Reg._gameYYnew * 75;	
				
				if (RegCustom._chess_show_last_piece_moved[Reg._tn] == true) visible = true;
			}
					
			if (RegTypedef._dataPlayers._spectatorWatching == false
			&&  Reg._gameMovePiece == true
			||  RegTypedef._dataTournaments._move_piece == true
			&&  Reg._gameMovePiece == true
			||  RegTypedef._dataPlayers._spectatorWatching == true
			&&  RegTypedef._dataTournaments._move_piece == false)
			{
				if (visible == false
				&& RegTypedef._dataPlayers._spectatorWatching == false
				|| visible == false
				&& RegTypedef._dataTournaments._move_piece == true) 
				{
					// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
					x = _startX + Reg._gameXXnew * 75;						
					y = _startY + Reg._gameYYnew * 75;
				 
					if (RegCustom._chess_show_last_piece_moved[Reg._tn] == true) visible = true;
				}
						
				if (Reg._gameYYold != -1 && Reg._gameYYnew != -1)
				{
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1; // remember that this is no longer a capturing unit but needed for moved piece highlight.
				}
		
			}
			
				
			if (Reg._gameDidFirstMove == false && Reg._playerCanMovePiece == false) 
			{
				if (RegTypedef._dataPlayers._spectatorWatching == false
				||  RegTypedef._dataTournaments._move_piece == true)
				{
					x = _startX + Reg._gameXXnew * 75;						
					y = _startY + Reg._gameYYnew * 75;			
				}
				 
				if (Reg._gameYYold != -1 && Reg._gameYYnew != -1)
				{
					 Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
					 Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1; // remember that this is no longer a capturing unit but needed for moved piece highlight.
					
				}
			}			
		} else if (visible == true) visible = false;
		
		if (Reg._gameDidFirstMove == false && _doOnce == false
		&&  RegTypedef._dataTournaments._game_over == 0)
		{
			// by default all board games use this class.
			GameClearVars.clearVarsOnMoveUpdate();
			
			// clear the ChessImagesCapturingUnits highlighted units.
			for (i in 0...2)
			{
				for (qy in 0...8)
				{
					for (qx in 0...8)
					{
						Reg._capturingUnitsForImages[i][qy][qx] = 0;
						Reg._capturingUnitsForPieces[i][qy][qx] = 0;
						
					}				
				}
			}
			
			normalMovementPieces(Reg._chessKingYcoordinate[Reg._playerMoving], Reg._chessKingXcoordinate[Reg._playerMoving]); // king never gets moved. we are just setting the first movement pieces.
						
			Reg._gameDidFirstMove = false;
			
		if (Reg._game_offline_vs_player == true
		||  Reg._game_offline_vs_cpu == true)
			ChessPieceAtPath.howManyDefendersOnCurrentPathSet(); // how many defender pieces are standing between the king and the attacker piece.
			
			__ids_win_lose_or_draw.canPlayerMove1();
			
			_doOnce = true;
		}
		
		super.update(elapsed);
	}
}