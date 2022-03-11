/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.chess;

/**
 * ...is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
 * @author kboardgames.com
 */

class ChessCheckOrCheckmate extends FlxSubState
{	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	public function new (ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super();
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
	
	}
	
	/******************************
	 * there are 8 units next to the king. this function determines if the king can take a piece or if the king should move. if a piece that puts the king in check is next to the king then that attacker unit will have a value of 2 and will have a value of 3 if that attacker piece has another piece that can capture that unit. each piece has a capture value of 2.
	 * @param	yy						a unit next to the king. y coordinate.
	 * @param	xx						a unit next to the king. x coordinate.
	 * @param	_pawnCanCaptureKing		a unit north-east, north-west, south-east or south-west from the king. a unit where a pawn can put the king in check.
	 */
	public static function isUnitNextToKingInCheck(yy:Int, xx:Int):Void
	{
		if (Reg._gameHost == false) return;
		
		Reg._chessKing[Reg._playerMoving][yy][xx] = 0;
		Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
		Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 0;
		//Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = false;
			
		// attacker piece next to defender king that has another attaching piece capturing its unit.
		if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 2
		)
		{
			Reg._chessKing[Reg._playerMoving][yy][xx] = 0;
			Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
			Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
			Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
			Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = false;
		}
		
		// attacker piece next to defender that is not protected by another of its piece.
		else if (Reg._playerMoving == 0
		&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
		&&  Reg._gamePointValueForPiece[yy][xx] > 10
		||  Reg._playerMoving == 1
		&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
		&&  Reg._gamePointValueForPiece[yy][xx] > 0
		&&  Reg._gamePointValueForPiece[yy][xx] < 11
		)
		{
			Reg._chessKing[Reg._playerMoving][yy][xx] = 1;
			if (Reg._chessIsKingMoving == true) 
				Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 1;
			Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
			Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
			Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] = 1;
			Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = true;
		}
		
		// empty unit but attacking piece..
		else if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0
		&&  Reg._gamePointValueForPiece[yy][xx] == 0
		)
		{
			Reg._chessKing[Reg._playerMoving][yy][xx] = 0;
			Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
			Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
			Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
			Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] = 1;
			Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = false;
		}
		
		else if (Reg._gamePointValueForPiece[yy][xx] == 0
		&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
		||  Reg._playerMoving == 0
		&&  Reg._gamePointValueForPiece[yy][xx] > 10
		&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] < 3
		||  Reg._playerMoving == 1
		&&  Reg._gamePointValueForPiece[yy][xx] > 0
		&&  Reg._gamePointValueForPiece[yy][xx] < 11
		&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] < 3) 
		{
			Reg._chessKing[Reg._playerMoving][yy][xx] = 1;
			if (Reg._chessIsKingMoving == true)
				Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 1;
			Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
			Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
			Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = true;
		}
		
		
	}
	
	/******************************
	 * if a horse puts the king in check then create a capturing path which will be the location of that horse.
	 */
	public static function isKingInCheckFromHorse():Void	
	{
		//RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
		for (i in 0...10)
		{							
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// a horse value of 1 is a captured unit not at the horse's location. this code is true if the horse's captured unit is at the defender king.
					if (Reg._chessHorse[Reg._playerNotMoving][i][yy][xx] == 1 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17)	
					{								
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// horse is putting the king in check. these vars help to find the location of the horse so that the defender pieces could capture that horse. 
								if (Reg._chessHorse[Reg._playerNotMoving][i][cy][cx] == 17)
								{									
									Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][cy][cx] = 1;
									Reg._chessIsThisUnitInCheck[Reg._playerMoving][cy][cx] = 1;
									Reg._chessUnitsInCheckTotal[Reg._playerMoving] = 1;
									Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] = 1;
									Reg._chessPathFromPawnOrHorse = true;
									
									break;
								}
							}
						}	
					}
				}
			}						
		}
	}
	
	/******************************
	 * king cannot take capturing piece if that capturing piece puts king in check.
	 */
	public static function canKingInCheckTakeThatPiece():Void
	{
		//RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		// if king is in check then set the var.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{	
				if (Reg._gameYYold > -1 && Reg._gameXXold > -1)
				{
					// piece can block king.
					if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] > 0 && Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] != 50 )
					{
						Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
					}
					 
					// king cannot take capturing piece if that capturing piece puts king in check.
					else if (Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] == 50 && Reg._gameUniqueValueForPiece[yy][xx] != 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2)
					{
						Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][yy][xx] = 1;
						Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] = 1;
					}
				}
			}
		}
	}	
	
	public static function shouldAttackersPathBeCreated():Void
	{
		//RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		// find the piece/pieces that put the king in check and then Reg._chessCapturingPathToKing will be that path/paths.
		
		// this function cannot be shortened. this code block is for the attacker. the attacker puts the defender king in check. this code creates the path to the king from the attacker.
		
		if (Reg._chessPathFromPawnOrHorse == false && Reg._chessUnitsInCheckTotal[Reg._playerMoving] <= 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					for (v in 0...8)
					{
						if (Reg._chessPawnAttackerKing[Reg._playerNotMoving][v][yy][xx] == 100)
						Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] = 1;
					}
					
					for (v in 0...10)
					{
						//if (Reg._chessHorseAttackerKing[Reg._playerNotMoving][v][yy][xx] == 100)
						//Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] = 1;
						
						// king found at attacker piece?
						if (Reg._chessBishopAttackerKing[Reg._playerNotMoving][v][yy][xx] == 100)
						{
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessBishopAttackerKing[Reg._playerNotMoving][v][cy][cx] > 0)
									Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] = 1;
								}
							}
						}
						
						if (Reg._chessRookAttackerKing[Reg._playerNotMoving][v][yy][xx] == 100)
						{
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessRookAttackerKing[Reg._playerNotMoving][v][cy][cx] > 0)
									Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] = 1;
								}
							}
						}
						
						if (Reg._chessQueenAttackerKing[Reg._playerNotMoving][v][yy][xx] == 100)
						{
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueenAttackerKing[Reg._playerNotMoving][v][cy][cx] > 0)
									Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] = 1;
								}
							}
						}
						
					}
				}
			}
		}
	}

	/******************************
	 * it is not possible for 3 or more pieces to but the king in to check at the same time. therefore, any piece that is able to put the king in to check will have capturing pieces added to the Reg._chessCapturingPathToKing var. if the Reg._chessUnitsInCheckTotal[Reg._playerMoving] is greater than 0 then there exists a piece that can put the king in to check.
	 */

	 public static function canPieceTakeKingOutOfCkeck():Int
	{
		//RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	

		var _count:Int = 0;
		
		// clear check units because king is not in check.
		if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 0)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{					
					Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] = 0;
				}
			}
		}
		
		if (Reg._gameDidFirstMove == false)
		{
			shouldAttackersPathBeCreated(); // go to a function that will check is any pieces, excluding pawns and horses, are in a straight or angle location from the king. if true then the function will create the path.
		
			ChessPieceAtPath.howManyDefendersOnCurrentPathSet(); // how many defender pieces are standing between the king and the attacker piece.
		}
		
		// if this value is true then a defender piece was found at the attacker path. this is used to determine if at the direction of a path should attacker pieces try to capture that path. for example, if there are two paths and one path is just in check, the var help to keep pieces to only capture those units just in check.
		var _directions:Array<Bool> = [false, false, false, false, false, false, false, false, false];
		var _direction:Int = 0;	
	
		//RegFunctions.is_player_attacker(false);
		
		// if the king is in check from bishop, rook or queen, see if the following defender pieces can take that attacker piece.
		if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 1)
		{		
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					// pawn.
					if (Reg._gameDidFirstMove == false || Reg._gameDidFirstMove == true && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 9) 
						{
							if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] > 0 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11		
							||  Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)   
							{									
								for (cy in 0...8)
								{
									for (cx in 0...8)
									{
										for (i in 0...8) 
										{
											if (Reg._gameHost == true)
											{
												if (cy > 0)
												{
													if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0)
													{											
														
														for (qy in 0...8)
														{
															for (qx in 0...8)
															{
																if (cy > 0)
																{
																	if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy - 1][qx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy - 1][qx] > 0 && Reg._gameUniqueValueForPiece[qy - 1][qx] == 0
			|| Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy - 1][qx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy - 1][qx - 1] > 0 && Reg._gameUniqueValueForPiece[qy - 1][qx - 1] > 0
			|| Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy - 1][qx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy - 1][qx + 1] > 0 && Reg._gameUniqueValueForPiece[qy - 1][qx + 1] > 0)
																	{
																		_count += 1;
																		Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
																		Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
																		
																	}
																}									
															}
														}				
													}
												}												
											}
											
											else
											{														
												if (cy < 7)
												{
													if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0)
													{											
														
														for (qy in 0...8)
														{
															for (qx in 0...8)
															{
																if (cy < 7)
																{
																	if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy + 1][qx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy + 1][qx] > 0 && Reg._gameUniqueValueForPiece[qy + 1][qx] == 0
			|| Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy + 1][qx - 1] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy + 1][qx - 1] > 0 && Reg._gameUniqueValueForPiece[qy + 1][qx - 1] > 0
			|| Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 17 && Reg._gamePointValueForPiece[qy + 1][qx + 1] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy + 1][qx + 1] > 0 && Reg._gameUniqueValueForPiece[qy + 1][qx + 1] > 0)
																	{
																		_count += 1;
																		Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
																		Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
																	}
																}									
															}
														}				
													}
												}
											}
										}
									}				
								}										
							}
						}
					
					// horses.
					if (Reg._gameDidFirstMove == false) 
					{
						if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] > 0)   
						{	
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{								
									for (i in 0...10) 
									{
										// true if a horse, bishop, rook, queen is able to move to a path unit.
										if (Reg._chessHorse[Reg._playerMoving][i][cy][cx] > 0 && Reg._chessHorse[Reg._playerMoving][i][cy][cx] < 18 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0
										 || Reg._chessBishop[Reg._playerMoving][i][cy][cx] > 0 && Reg._chessBishop[Reg._playerMoving][i][cy][cx] < 18 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0
										 || Reg._chessRook[Reg._playerMoving][i][cy][cx] > 0 && Reg._chessRook[Reg._playerMoving][i][cy][cx] < 18 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0
										 || Reg._chessQueen[Reg._playerMoving][i][cy][cx] > 0 && Reg._chessQueen[Reg._playerMoving][i][cy][cx] < 18 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0)
										{										
											for (zy in 0...8)
											{
												for (zx in 0...8)
												{
													if (Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 17
													||  Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 17
													||   Reg._chessRook[Reg._playerMoving][i][zy][zx] == 17
													||  Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 17
													)
													{
														_count += 1;
														Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][zy][zx] = 2;
														Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
														Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] += 1;
													}
												}
											}				
										}
									}
								}									
							}						
						}
					}					
				}
			}				
		}

		return _count;
	}

	public function isThisCheckOrCheckmate(_reverse:Bool = false):Void
	{
		// the number of units that the king is able to go to.
		var _check:Int = 0;
		var _check2:Int = 0;
				
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				for (i in 0...8) 
				{
					if (Reg._gameHost == true || _reverse == true)
					{
						if (cy > 0)
						{
							if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0)
							{									
								for (qy in 0...8)
								{
									for (qx in 0...8)
									{
										if (cy > 0)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 1 && Reg._gamePointValueForPiece[qy][qx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] == 0
)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
												
											}
										}	
										
										// pawn can take piece by moving in an angle.
										if (cy > 0)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 2 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] > 0
)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
												
											}
										}	
										
										if (cy > 0)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 8 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] > 0
)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
												
											}
										}	
									}
								}				
							}
						}												
					}
					
					else
					{														
						if (cy < 7)
						{
							if (Reg._chessCapturingPathToKing[Reg._playerNotMoving][cy][cx] > 0)
							{											
								
								for (qy in 0...8)
								{
									for (qx in 0...8)
									{
										if (cy < 7)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 5 && Reg._gamePointValueForPiece[qy][qx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] == 0)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
											}
										}	
										
										// pawn can take piece by moving in an angle.
										if (cy < 7)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 4 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] > 0)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
											}
										}	
										
										if (cy < 7)
										{
											if (Reg._chessPawn[Reg._playerMoving][i][qy][qx] == 6 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][qy][qx] > 0 && Reg._gameUniqueValueForPiece[qy][qx] > 0)
											{
												_check2 += 1;
												Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][qy][qx] = 2;								
												Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
											}
										}
									}
								}				
							}
						}
					}
				}
			}				
		}		

	
		for (zy in 0...8)
		{
			for (zx in 0...8)
			{								
				for (i in 0...10) 
				{
					// true if a horse, bishop, rook, queen is able to move to a path unit.
					if (Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0 && Reg._gameUniqueValueForPiece[zy][zx] == 0
					
					|| Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
				
					|| Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[zy][zx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
					
					|| Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0 && Reg._gameUniqueValueForPiece[zy][zx] == 0
								
					|| Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
				
					|| Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[zy][zx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
					
					||  Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0 && Reg._gameUniqueValueForPiece[zy][zx] == 0
								
					|| Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
				
					|| Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[zy][zx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
					
					|| Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0 && Reg._gameUniqueValueForPiece[zy][zx] == 0
					
					|| Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
				
					|| Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[zy][zx] >= 11 && Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] > 0
					)
					{
						_check2 += 1;
						Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][zy][zx] = 2;
						Reg._chessCanTakeOutOfCheck[Reg._playerMoving] = true;
						Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] += 1;
					}
				}
			}									
		}						
		

		// can king move to these units.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] > 0)
				{
					// don't do if piece is the same color.
					if (Reg._playerMoving == 1 
					&&  Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 
					&&  Reg._gamePointValueForPiece[yy][xx] > 0 
					&&  Reg._playerMoving == 0 
					&&  Reg._gamePointValueForPiece[yy][xx] < 11)
					{}
								
					// used to display the highlight units correctly.
					else if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] == true 
					&& Reg._gamePointValueForPiece[yy][xx] != 0 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] <= 2
					&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] == 0) 
					{
						_check += 1;
					}
					else if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] == true 
					&& Reg._gamePointValueForPiece[yy][xx] == 0
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
				)
					{
						_check += 1;					
					}
					
					else if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._gamePointValueForPiece[yy][xx] > 0
					&& Reg._isThisUnitNextToKing[Reg._playerMoving][yy][xx] == true
					)
					{				
						Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = true;
					}
					
					else Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx] = false;
					
				}		
			}
		}
		
		//-------------------------
		// count how many units that the king can move to.
		var _count = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		// plus the value of _count if the king can move to this unit.
		if (yy > 0) // up
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx] == true ) _count += 1;
			
		if (yy > 0 && xx < 7) // up-right
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx + 1] == true ) _count += 1;
		
		if (xx < 7)	// left
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx + 1] == true ) _count += 1;
		
		if (yy < 7 && xx < 7) // down-right		
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx + 1] == true ) _count += 1;
		
		if (yy < 7) // down
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx] == true ) _count += 1;
		
		if (yy < 7 && xx > 0) // down-left		
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx - 1] == true ) _count += 1;
			
		if (xx > 0) // left	
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx - 1] == true ) _count += 1;
		
		if (yy > 0 && xx > 0)	// up-left
			if (Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx - 1] == true ) _count += 1;
		
		//-------------------------
		//trace(_check +"check " + _check2 + "checkAgain " + Reg._chessUnitsInCheckTotal[Reg._playerMoving] + "Reg._chessUnitsInCheckTotal " + _count + "count");
	
		// this is checkmate.
		if (_check == 0 && _check2 == 0 && Reg._chessUnitsInCheckTotal[Reg._playerMoving] > 0 && _count == 0) 
		{
			Reg._chessOriginOfCheckY[Reg._playerMoving] = Reg._gameYYnew;
			Reg._chessOriginOfCheckX[Reg._playerMoving] = Reg._gameXXnew;
			
			// not reset at the end of player's turn.
			Reg._chessOriginOfcheckmateYYnew = Reg._gameYYnew; 
			Reg._chessOriginOfcheckmateXXnew = Reg._gameXXnew;
	
			Reg._checkmate_break_loop = true;
			
			#if chess
				//ChessMoveCPUsPiece._foundPiece = true;
			#end
			
			if (Reg._chessCheckmateBypass == false)
			{
				Reg._checkmate = true;				
				doCheckmate();
			}
			
			else 
			{
				#if chess
					//ChessFindCheckmate.populatePiecesTemporary();
				#end
			}
		}
		
		// if defending king is in check.
		else if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 1
		&&       Reg._capturingUnitsForPieces[Reg._playerNotMoving][Reg._chessKingYcoordinate[Reg._playerMoving]][Reg._chessKingXcoordinate[Reg._playerMoving]] > 0 ) 
		{
			Reg._chessOriginOfCheckY[Reg._playerMoving] = Reg._gameYYnew;
			Reg._chessOriginOfCheckX[Reg._playerMoving] = Reg._gameXXnew;
			
			if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false && Reg._game_online_vs_cpu == false) 
			{
				RegTypedef._dataGameMessage._gameMessage = "Check";
				PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);
			} 
			
			Reg._messageBoxNoUserInput = "Check";
			Reg._outputMessage = true;	
			//Reg2._updateNotation = true;
			
			
			if (Reg._game_offline_vs_cpu == true && Reg._playerMoving == 1)
			Reg._chessCheckBypass = true;
			
		}
		
	}
	
	public function doCheckmate():Void
	{
		if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false && Reg._game_online_vs_cpu == false) 
		{
			RegTypedef._dataGameMessage._gameMessage = "Checkmate"; 
			PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);			
		} 
		
		Reg._messageBoxNoUserInput = "Checkmate";
		Reg._outputMessage = true;				
		RegTriggers._chessCheckmateEvent = true;			
				
		ChessCapturingUnits.capturingUnits();
			
		if (__ids_win_lose_or_draw != null)
		{
			remove(__ids_win_lose_or_draw);
			__ids_win_lose_or_draw.destroy();
		}
		
		__ids_win_lose_or_draw = new IDsWinLoseOrDraw();
		add(__ids_win_lose_or_draw);
		
		__ids_win_lose_or_draw.canPlayerMove2();
	}
	
	public static function isKingsLocationInCheck(yy:Int, xx:Int):Void
	{
		// center unit where the defender king is location.
		if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0)
		{
			Reg._chessUnitsInCheckTotal[Reg._playerMoving] += 1;
		}
				
		//  if the king has his/her piece at this unit.
		if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
		|| Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
		{
			Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] = 1;
		}
	}
	
	public static function isUnitBesideKingInCheck(yy:Int, xx:Int):Void
	{
		// this is all 8 units next to the king's unit. this goes to a function where code will determine if a unit is in check and if the defender king can capture that unit that checks.
		if (yy > 0) // up	
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy - 1, xx);
		if (yy > 0 && xx < 7) // up-right
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy - 1, xx + 1);
		if (xx < 7)	// left	
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy, xx + 1);
		if (yy < 7 && xx < 7) // down-right	
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy + 1, xx + 1);
		if (yy < 7) // down				
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy + 1, xx);
		if (yy < 7 && xx > 0) // down-left	
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy + 1, xx - 1);
		if (xx > 0) // left				
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy, xx - 1);
		if (yy > 0 && xx > 0)	// up-left
			ChessCheckOrCheckmate.isUnitNextToKingInCheck(yy - 1, xx - 1);
	}
}