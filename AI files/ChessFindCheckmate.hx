/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.chess;

/**
 * computer uses this class. set of functions that are needed to search for checkmate and if found will call a function to move that piece to end game.
 * @author kboardgames.com
 */
class ChessFindCheckmate 
{
	/******************************
	 * at populatePiecesTemporary(), each computer piece is assigned this temp var. at checkmateSearch(), this temp var is read in a loop. if this value equals a number one then that piece can be moved and a loop in the checkmateSearch() Loop is entered.
	 */
	public static var _temp_piece_captures:Array<Array<Array<Array<Array<Int>>>>> = [for (w in 0...2) [for (p in 0...6) [for (i in 0...10) [for (y in 0...8) [for (x in 0...8) 0]]]]];
	
	/******************************
	 * in the checkmateSearch() loop, this var is used to temp move a piece then a search for checkmate is made. if a search failed then the original location of that piece is restored.
	 */
	public static var _temp_piece_YYold:Array<Array<Array<Int>>> = [for (w in 0...2) [for (p in 0...6) [for (i in 0...10) 0]]];
	
	/******************************
	 * in the checkmateSearch() loop, this var is used to temp move a piece then a search for checkmate is made. if a search failed then the original location of that piece is restored.
	 */
	public	static var _temp_piece_XXold:Array<Array<Array<Int>>> = [for (w in 0...2) [for (p in 0...6) [for (i in 0...10) 0]]];
	
	/******************************
	 * when searching for a king, sometimes the computer piece needs to capture a piece to put the king into checkmate. when such a capture is made and a checkmate fails, this var is used to set back the piece that was captured.
	 */
	public	static var _gamePointValueForPiece:Array<Array<Int>> = [for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 *  used for regular none checkmate search. this var will be used to populate its Reg._gamePointValueForPiece
	 */
	public	static var _gamePointValueForPiece2:Array<Array<Int>> = [for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 * when searching for a king, sometimes the computer piece needs to capture a piece to put the king into checkmate. when such a capture is made and a checkmate fails, this var is used to set back the piece that was captured.
	 */
	public	static var _gameUniqueValueForPiece:Array<Array<Int>> = [for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 *  used for regular none checkmate search. this var will be used to populate its Reg._gamePointValueForPiece
	 */
	public	static var _gameUniqueValueForPiece2:Array<Array<Int>> = [for (y in 0...8) [for (x in 0...8) 0]];
	
	/******************************
	 * go to the function that will begin searching for checkmate but only if some conditions are true.
	 * at ChessMoveCPUsPiece.update() function, tick is used to do somethings before calling this function. 
	 */
	public static function getCheckmate():Void
	{
		// _phm: used to stop going to other functions such as attach or defend function. 
		if (ChessMoveCPUsPiece._phm == false) 
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// create a backup copy of each piece point value and piece unique value that will be used to restore a players piece what was captured in a checkmate search. remember that a checkmate search is simply a search. no move is committed until the checkmate is found.
					_gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece[yy][xx];
					_gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece[yy][xx];
					
					_gamePointValueForPiece2[yy][xx] = Reg._gamePointValueForPiece[yy][xx];
					_gameUniqueValueForPiece2[yy][xx] = Reg._gameUniqueValueForPiece[yy][xx];
					
				}
			}
			
			checkmateSearch();
			
		}		
	}
	
	public static function resetVars():Void
	{
		// yy and xx refers to every unit on the board.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// search all piece instances. for example, a rook may have more then 2 pieces, eg, 2 instances.
				for (_i in 0...10)
				{
					// clear this var for all pieces except king then populate it at the next loop block.
					for (_d in 1...6)
					{
						_temp_piece_captures[Reg._playerMoving][_d][_i][yy][xx] = 0;
					
						_temp_piece_YYold[Reg._playerMoving][_d][_i] = 0;
						_temp_piece_XXold[Reg._playerMoving][_d][_i] = 0;
					}					
				}				
				
				
			}
		}
		
		// this code is needed or else checkmate cannot be completed.
		if (ChessMoveCPUsPiece._checkmate_loop == 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					_gamePointValueForPiece[yy][xx] = 0;
					_gameUniqueValueForPiece[yy][xx] = 0;
				}
			}
		}
	}
	
	public static function populatePiecesTemporary():Void
	{
		resetVars();
				
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// search all piece instances. for example, a rook may have more then 2 pieces, eg, 2 instances.
				for (_i in 0...10)
				{
					if (_i < 8)
					{
						// this sets up the _temp_piece_captures that will be read in a loop to move computer pieces when searching for checkmate.
						if (Reg._chessPawn[Reg._playerMoving][_i][yy][xx] == 4
						&&  Reg._gamePointValueForPiece[yy][xx] > 0
						&&  Reg._gamePointValueForPiece[yy][xx] < 11
						&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
						||  Reg._chessPawn[Reg._playerMoving][_i][yy][xx] == 4
						&&  Reg._gamePointValueForPiece[yy][xx] == 0
						&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
							
						||  Reg._chessPawn[Reg._playerMoving][_i][yy][xx] == 6
						&&  Reg._gamePointValueForPiece[yy][xx] > 0
						&&  Reg._gamePointValueForPiece[yy][xx] < 11
						&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
						||  Reg._chessPawn[Reg._playerMoving][_i][yy][xx] == 6
						&&  Reg._gamePointValueForPiece[yy][xx] == 0
						&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
						)
							_temp_piece_captures[Reg._playerMoving][1][_i][yy][xx] = 1;
						// the location of the pawn has a value of 17.
						if (Reg._chessPawn[Reg._playerMoving][_i][yy][xx] == 17)
						{
							// at this point, Reg._playerMoving has a value of 1, the computer. the second element is 1, referring to the point value which is a pawn. _i is the instance, the number of the pawn. yy is the y value of a unit, from top of the board of 0 to bottom of the board, unit 7.
							_temp_piece_YYold[Reg._playerMoving][1][_i] = yy;
							_temp_piece_XXold[Reg._playerMoving][1][_i] = xx;
						}
					}
					
					//------------------------
					// the first condition, bishop of value 1 is a unit that bishop can capture. a value of 0 refers to a bishop that cannot move to that unit. _gamePointValueForPiece > 0 to < 11 refers to players piece. so the condition reads that bishop can capture a players piece if players capture value is less than 3. a value of 2 for the player means that the player is not protected by another of players piece.
					if (Reg._chessBishop[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] > 0
					&&  Reg._gamePointValueForPiece[yy][xx] < 11
					&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
					// this condition, can capture an empty unit but only if player is not capturing that unit. Reg._capturingUnitsForPieces[0] = player.
					||  Reg._chessBishop[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] == 0
					&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
					)
						_temp_piece_captures[Reg._playerMoving][2][_i][yy][xx] = 1;
					
					if (Reg._chessBishop[Reg._playerMoving][_i][yy][xx] == 17)
					{
						_temp_piece_YYold[Reg._playerMoving][2][_i] = yy;
						_temp_piece_XXold[Reg._playerMoving][2][_i] = xx;
					}
					
					//------------------------
					if (Reg._chessHorse[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] > 0
					&&  Reg._gamePointValueForPiece[yy][xx] < 11
					&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
					||  Reg._chessHorse[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] == 0
					&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
					)
						_temp_piece_captures[Reg._playerMoving][3][_i][yy][xx] = 1;
					
					if (Reg._chessHorse[Reg._playerMoving][_i][yy][xx] == 17)
					{
						_temp_piece_YYold[Reg._playerMoving][3][_i] = yy;
						_temp_piece_XXold[Reg._playerMoving][3][_i] = xx;
					}
					
					//------------------------
					if (Reg._chessRook[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] > 0
					&&  Reg._gamePointValueForPiece[yy][xx] < 11
					&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
					||  Reg._chessRook[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] == 0
					&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
					)
						_temp_piece_captures[Reg._playerMoving][4][_i][yy][xx] = 1;
					
					if (Reg._chessRook[Reg._playerMoving][_i][yy][xx] == 17)
					{
						_temp_piece_YYold[Reg._playerMoving][4][_i] = yy;
						_temp_piece_XXold[Reg._playerMoving][4][_i] = xx;
					}
					
					//------------------------
					if (Reg._chessQueen[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] > 0
					&&  Reg._gamePointValueForPiece[yy][xx] < 11
					&&  Reg._capturingUnitsForPieces[0][yy][xx] < 3
					||  Reg._chessQueen[Reg._playerMoving][_i][yy][xx] == 1
					&&  Reg._gamePointValueForPiece[yy][xx] == 0
					&&  Reg._capturingUnitsForPieces[0][yy][xx] == 0
					)
						_temp_piece_captures[Reg._playerMoving][5][_i][yy][xx] = 1;
					
					if (Reg._chessQueen[Reg._playerMoving][_i][yy][xx] == 17)
					{
						_temp_piece_YYold[Reg._playerMoving][5][_i] = yy;
						_temp_piece_XXold[Reg._playerMoving][5][_i] = xx;
					}
					
					// king is not used because king cannot put a king in check.
				}
			}
		}
	}
	
	/******************************
	 * a tight loop that is used to search for checkmate. in this loop, a temp var is used to move to a unit then a search for checkmate is made. then the piece is moved back to its location. then if checkmate exists, a function is called to commit to the checkmate. this function calls all other functions that are needs to execute a checkmate.
	 */
	public static function checkmateSearch():Void
	{
		populatePiecesTemporary();

		Reg._checkmate_break_loop = false;
		Reg._checkmate = false; // if true then this var will end the game displaying a checkmate message to the player.
		
		// p	= p=piece. 1.pawn, 2.bishop, etc.
		for (_p in 1...6)
		{
			// piece instance. first rook, second rook, etc.
			for (_i in 0...10)
			{
				// y coordinates on board.
				for (_YYnew in 0...8)
				{
					// x coordinates on board.
					for (_XXnew in 0...8)
					{
						// if piece = pawn and greater than piece 8. remember 0=piece 1. only a max of 8 pawns can exists in game.
						if (_p == 1 && _i > 7) {}
						else
						{
							// if piece can move to this unit.
							if (_temp_piece_captures[Reg._playerMoving][_p][_i][_YYnew][_XXnew] == 1)
							{
								// get the current location of piece, value 17.
								var _YYold = _temp_piece_YYold[Reg._playerMoving][_p][_i];
								var _XXold = _temp_piece_XXold[Reg._playerMoving][_p][_i];				
								// if here then we are looking for a checkmate in the first move. therefore, do not bypass an event that will end the game.
								Reg._chessCheckmateBypass = false;
								
								// this function will move a temp piece and then search for a checkmate. _p= piece, _i is the piece instance. _YYold and _XXold is the piece location. _YYnew and _XXnew refers to the location we will temp move the piece. followed by the point value of the computer piece and its unique piece value.
								movePieceTemporarily(_p, _i, _YYold, _XXold, _YYnew, _XXnew, Reg._gamePointValueForPiece[_YYold][_XXold], Reg._gameUniqueValueForPiece[_YYold][_XXold]);
								
								
								if (RegCustom._game_skill_level_chess == 2)
								{
									//-----------------------------
									// this is the second move. pretend that the first move was a rook moving 1 unit up. directly after that move is this other piece which will move. this is depth 2. this piece will search for checkmate will be not end the game if a checkmate if found. more about that later below.
									for (_p2 in 1...6)
									{
										for (_i2 in 0...10)
										{
											for (_YYnew2 in 0...8)
											{
												for (_XXnew2 in 0...8)
												{
													// don't move the same piece. a _p == _p2 refers to, if piece such as the first depth rook is the same as the second depth rook. we cannot move the a rook that was already moved. the second condition refers to a pawn that does not exist. in both of these conditions, trap the event.
													if (_p == _p2 && _i == _i2) {}
													else if (_p2 == 1 && _i2 > 7) {}
													else
													{
														if (Reg._checkmate_break_loop == true) break;
														
														if (_temp_piece_captures[Reg._playerMoving][_p2][_i2][_YYnew2][_XXnew2] == 1)
														{
															var _YYold2 = _temp_piece_YYold[Reg._playerMoving][_p2][_i2];
															var _XXold2 = _temp_piece_XXold[Reg._playerMoving][_p2][_i2];		
														Reg._chessCheckmateBypass = true;
														movePieceTemporarily(_p2, _i2, _YYold2, _XXold2, _YYnew2, _XXnew2, Reg._gamePointValueForPiece[_YYold2][_XXold2], Reg._gameUniqueValueForPiece[_YYold2][_XXold2]);
															
															movePieceUndo(_p2, _i2, _YYold2, _XXold2, _YYnew2, _XXnew2, Reg._gamePointValueForPiece[_YYnew2][_XXnew2], Reg._gameUniqueValueForPiece[_YYnew2][_XXnew2]);
																						
															if (Reg._checkmate_break_loop == true)
															{
																// checkmate is known. so now we need to move the piece the correct way.
																				
																movePieceCommit(_p, _YYold2, _XXold2, Reg._chessOriginOfcheckmateYYnew, Reg._chessOriginOfcheckmateXXnew);		
																break;
															}	
															
															if (Reg._checkmate_break_loop == true) break;
														}
														
														if (Reg._checkmate_break_loop == true) break;																		
													}
													
													if (Reg._checkmate_break_loop == true) break;
													
												}
												
												if (Reg._checkmate_break_loop == true) break;
											}
											
											if (Reg._checkmate_break_loop == true) break;
										}
										
										if (Reg._checkmate_break_loop == true) break;
									}
									
									
									//---------------------------
								}	
			
																
								
								
								movePieceUndo(_p, _i, _YYold, _XXold, _YYnew, _XXnew, Reg._gamePointValueForPiece[_YYnew][_XXnew], Reg._gameUniqueValueForPiece[_YYnew][_XXnew]);
								
						
								if (Reg._checkmate_break_loop == true)
								{
									// checkmate is known. so now we need to move the piece the correct way.
									movePieceCommit(_p, _YYold, _XXold, Reg._chessOriginOfcheckmateYYnew, Reg._chessOriginOfcheckmateXXnew);		
									break;
														}
								if (Reg._checkmate_break_loop == true) break;
							}	
							
							if (Reg._checkmate_break_loop == true) break;
						}
						
						if (Reg._checkmate_break_loop == true) break;
					}
					
					if (Reg._checkmate_break_loop == true) break;
				}
				
				if (Reg._checkmate_break_loop == true) break;
			}
			
			if (Reg._checkmate_break_loop == true) break;
		}
		
		// get the board to the state is was before the piece was moved but do so only if no checkmate was found.
		if (Reg._checkmate_break_loop == false) 
		{
			ChessMoveCPUsPiece._checkmate_loop = 0;
		
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// create a backup copy of each piece point value and piece unique value that will be used to restore a players piece what was captured in a checkmate search. remember that a checkmate search is simply a search. no move is committed until the checkmate is found.
					Reg._gamePointValueForPiece[yy][xx] = _gamePointValueForPiece2[yy][xx];
					Reg._gameUniqueValueForPiece[yy][xx] = _gameUniqueValueForPiece2[yy][xx];
					
				}
			}
		}
	}
	
	/******************************
	 * this function Temporarily moves a piece on the board.
	 * @param	_p						piece number. _p is used in a loop to refer to pieces where as _gamePointValueOld is _p value of that unit.
	 * @param	_i						piece instance number.
	 * @param	YYold					unit y coordinate of piece before starting a checkmate search.
	 * @param	XXold					unit X coordinate of piece before starting a checkmate search.
	 * @param	YYnew					move piece to this unit. y coordinate.
	 * @param	XXnew					move piece to this unit. x coordinate.
	 * @param	_gamePointValueOld		if value is 14 then its a rook. piece point value can also be _p but _p is coded to start at 1. so the value of 4 is a rook for player and if at a computer function then that _p can refer to a computer rook.
	 * @param	_gameUniqueValueOld		unique value of piece. each instance of piece has a different unique value. see, IDsCreateAndMain.gameIdSetBoardAndPieces() game id 1.
	 */
	public static function movePieceTemporarily(_p:Int, _i:Int, YYold:Int, XXold:Int, YYnew:Int, XXnew:Int, _gamePointValueOld:Int, _gameUniqueValueOld:Int):Void
	{			
		Reg._gameDidFirstMove = false;
		
		// computer is moving.
		Reg._gameHost = true;
		RegFunctions.is_player_attacker(true);
				
		// clear the rest of the pieces but not at the board and not at the piece that has a value of 17 which is the piece location.
		GameClearVars.clearVarsOnMoveUpdate();
		GameClearVars.clearCheckAndCheckmateVars();	
		
		if (Reg._chessCheckmateBypass == false)
		{
			// put the board back to the way it looked before the checkmate search started moving pieces.
			for (yy2 in 0...8)
			{
				for (xx2 in 0...8)
				{
					// create a backup copy of each piece point value and piece unique value that will be used to restore a players piece what was captured in a checkmate search. remember that a checkmate search is simply a search. no move is committed until the checkmate is found.
					Reg._gamePointValueForPiece[yy2][xx2] = _gamePointValueForPiece2[yy2][xx2];
					Reg._gameUniqueValueForPiece[yy2][xx2] = _gameUniqueValueForPiece2[yy2][xx2];
					
				}
			}
		}
		
		// update the board. move this piece.
		Reg._gamePointValueForPiece[YYnew][XXnew] = _gamePointValueOld;
		Reg._gameUniqueValueForPiece[YYnew][XXnew] = _gameUniqueValueOld;
	
		// this is where the piece was located.
		Reg._gamePointValueForPiece[YYold][XXold] = 0;
		Reg._gameUniqueValueForPiece[YYold][XXold] = 0;
		
		// computer is moving this piece.
		if (_p == 1)
		{
			Reg._chessPawn[Reg._playerMoving][_i][YYold][XXold] = 0;
			Reg._chessPawn[Reg._playerMoving][_i][YYnew][XXnew] = 17;
		}
		
		if (_p == 2)
		{
			Reg._chessBishop[Reg._playerMoving][_i][YYold][XXold] = 0;
			Reg._chessBishop[Reg._playerMoving][_i][YYnew][XXnew] = 17;
		}
		
		if (_p == 3)
		{
			Reg._chessHorse[Reg._playerMoving][_i][YYold][XXold] = 0;
			Reg._chessHorse[Reg._playerMoving][_i][YYnew][XXnew] = 17;
		}
		
		if (_p == 4)
		{
			Reg._chessRook[Reg._playerMoving][_i][YYold][XXold] = 0;
			Reg._chessRook[Reg._playerMoving][_i][YYnew][XXnew] = 17;
		}
		
		if (_p == 5)
		{
			Reg._chessQueen[Reg._playerMoving][_i][YYold][XXold] = 0;
			Reg._chessQueen[Reg._playerMoving][_i][YYnew][XXnew] = 17;
		}
		
		Reg._gameYYold = YYold;
		Reg._gameXXold = XXold;
		Reg._gameYYnew = YYnew;
		Reg._gameXXnew = XXnew;
		
		// repopulate computer vars
		ChessCapturingUnits.populateCaptures(Reg._playerMoving);
		RegFunctions.is_player_attacker(false);
		ChessCapturingUnits.populateCaptures(Reg._playerMoving);
		
		// this is now the king's value. we use these values to check if there is a check beside the king.
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		var cy:Int = yy;
		var cx:Int = xx;
		
		// these function determine if a piece can take king out of check and if king can move to a unit.
		ChessCheckOrCheckmate.isKingsLocationInCheck(yy, xx);		
		ChessCheckOrCheckmate.isUnitBesideKingInCheck(yy, xx);
		
		//ChessCheckOrCheckmate.isKingInCheckFromPawn();
		ChessCheckOrCheckmate.isKingInCheckFromHorse();
		ChessCheckOrCheckmate.canKingInCheckTakeThatPiece();		
		ChessCheckOrCheckmate.canPieceTakeKingOutOfCkeck();
		
		
		Reg._messageBoxNoUserInput = "";
		// for the defending player, determine if this is check or checkmate or if the king can move.
		ChessMoveCPUsPiece.__chess_check_or_checkmate.isThisCheckOrCheckmate();
		
		// set the vars so that the computer can continue to move.
		Reg._gameHost = true;
		RegFunctions.is_player_attacker(true);
		
	
	}

	/******************************
	 * this function moves back the temporarily piece that was moved at the function movePieceTemporarily().
	 * @param	_p						piece number. _p is used in a loop to refer to pieces where as _gamePointValueNew is _p value of that unit.
	 * @param	_i						piece instance number.
	 * @param	YYold					unit y coordinate of piece before starting a checkmate search.
	 * @param	XXold					unit X coordinate of piece before starting a checkmate search.
	 * @param	YYnew					move piece to this unit. y coordinate.
	 * @param	XXnew					move piece to this unit. x coordinate.
	 * @param	_gamePointValueNew		if value is 14 then its a rook. piece point value can also be _p but _p is coded to start at 1. so the value of 4 is a rook for player and if at a computer function then that _p can refer to a computer rook.
	 * @param	_gameUniqueValueNew		unique value of piece. each instance of piece has a different unique value. see, IDsCreateAndMain.gameIdSetBoardAndPieces() game id 1.
	 */
	public static function movePieceUndo(_p:Int, _i:Int, YYold:Int, XXold:Int, YYnew:Int, XXnew:Int, _gamePointValueNew:Int, _gameUniqueValueNew:Int):Void
	{
		RegFunctions.is_player_attacker(true);
				
		// location of piece that was temp moved on the board.					
		Reg._gamePointValueForPiece[YYold][XXold] = _gamePointValueNew;
		Reg._gameUniqueValueForPiece[YYold][XXold] = _gameUniqueValueNew;
		
		// set back the unit on the board to the state it was before a computer temp piece was moved to it.
		Reg._gamePointValueForPiece[YYnew][XXnew] = _gamePointValueForPiece[YYnew][XXnew];
		Reg._gameUniqueValueForPiece[YYnew][XXnew] = _gameUniqueValueForPiece[YYnew][XXnew];
		
		// also, move the piece back to its location.
		if (_p == 1)
		{
			Reg._chessPawn[Reg._playerMoving][_i][YYold][XXold] = 17;
			Reg._chessPawn[Reg._playerMoving][_i][YYnew][XXnew] = 0;
		}
		
		if (_p == 2)
		{
			Reg._chessBishop[Reg._playerMoving][_i][YYold][XXold] = 17;
			Reg._chessBishop[Reg._playerMoving][_i][YYnew][XXnew] = 0;
		}
		
		if (_p == 3)
		{
			Reg._chessHorse[Reg._playerMoving][_i][YYold][XXold] = 17;
			Reg._chessHorse[Reg._playerMoving][_i][YYnew][XXnew] = 0;
		}
		
		if (_p == 4)
		{
			Reg._chessRook[Reg._playerMoving][_i][YYold][XXold] = 17;
			Reg._chessRook[Reg._playerMoving][_i][YYnew][XXnew] = 0;			
		}
		
		if (_p == 5)
		{
			Reg._chessQueen[Reg._playerMoving][_i][YYold][XXold] = 17;
			Reg._chessQueen[Reg._playerMoving][_i][YYnew][XXnew] = 0;
		}
		
		// this is needed.
		GameClearVars.clearVarsOnMoveUpdate();
	//ChessCapturingUnits.populateCaptures(Reg._playerMoving); 		
		Reg._gameHost = false;
		RegFunctions.is_player_attacker(false);
		
	}
	
	
	/**
	 * Move piece.
	 * @param	v	piece value. 4=rook
	 * @param	cy	move from. yy coordinates.
	 * @param	cx	move from. xx coordinates.
	 * @param	yy	move to location.
	 * @param	xx	move to location.
	 */
	public static function movePieceCommit(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = ChessMoveCPUsPiece.canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		for (i in 0...65)
		{
			if (Reg._chessCheckmateIn1MyP[i] == -1) 
			{
				Reg._chessCheckmateIn1MyP[i] = v; // computer piece.
				Reg._chessCheckmateIn1Yold[i] = cy;
				Reg._chessCheckmateIn1Xold[i] = cx;
				
				Reg._chessCheckmateIn1Ynew[i] = yy;
				Reg._chessCheckmateIn1Xnew[i] = xx;								
				Reg._chessCheckmateIn1YourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
		
		ChessFindCheckmate.movePieceToCheckmate();
		
	}
	
	
	/******************************
	 * move the piece that will checkmate the king.
	 */
	public static function movePieceToCheckmate():Void
	{		
		var _p = FlxG.random.int(0, 1);
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessCheckmateIn1MyP.copy();
		
		if (_temp[0] != -1 && ChessMoveCPUsPiece._phm == false) 
		{
			if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessCheckmateIn1MyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessCheckmateIn1Yold[i];
					Reg._gameXXold = Reg._chessCheckmateIn1Xold[i];
					Reg._gameYYnew = Reg._chessCheckmateIn1Ynew[i];
					Reg._gameXXnew = Reg._chessCheckmateIn1Xnew[i];
				
					// sometimes when piece is moved, this message is not cancelled so this is needed here to stop this message after piece is moved.
					Reg._gameMessageCPUthinkingEnded = true;
					
					// if this is true then the computer can checkmate in 1.
					if (Reg._chessCheckmateBypass = false) 
					{
						ChessMoveCPUsPiece.__chess_check_or_checkmate.doCheckmate();
					}
					
					ChessMoveCPUsPiece._phm = true;
					ChessMoveCPUsPiece._ticks = 4; // jump to the move piece function.
					break;
				}
			}		
		}
		
	}
}