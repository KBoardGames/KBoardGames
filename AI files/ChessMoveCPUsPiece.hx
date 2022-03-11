/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.chess;

/**
 * ...this class holds all computers move calculations.
 * author: kboardgames.com.
 */
class ChessMoveCPUsPiece extends FlxSubState
{
	/******************************
	 * _phm=piece has moved: used to stop going to other functions such as attach or defend function.
	 */
	public static var _phm:Bool = false;
	
	/******************************
	 *used to stop a loop so that code will not go to a function to calculate a move.
	 */
	public static var _pawnHasMoved:Bool = false;

	/******************************
	 * pass _p to a function. its value determines the piece used in that function.
	 * 1=pawn, 2=bishop, 3=horse, 4=rook, 5=queen, 6=king.
	 */
	public static var _p:Bool = false;
	
	/******************************
	 * at move piece function, every pawn will be called when this var has a value of 0. this var is useful if a single piece should be moved such as a pawn in check from a bishop. the move function can be called using this var as a value of 1.
	 * 0 = any piece can be selected. 1:pawn, 2:bishop, 3:horse, 4:rook, 5:queen, 6:king.
	 */
	public static var _ps:Int = 0;
	
	/******************************
	 * other Player's Piece Value.
	 */
	public static var _otherPlayersPieceValue:Int = -1; 
	
	/******************************
	 * if true then the vars needed to move the piece is set. the only thing left to do is sort these vars and select the highest value in the MyP var. this var is used to bypass a function that deals with determining if a piece should be moved. if this is true then there is already a piece that can be moved.
	 */
	public static var _setMyPVar:Bool = false;
	
	
	/******************************
	 * if true then the computer will go to functions to move a piece. set this to true ( above the constructor, not options() ) if you want the computer to move first.
	 */
	public static var _cpuTriggerMovePiece:Bool = false;
	
	/******************************
	 *	game tick used to select a function to move a piece or display a thinking message. 
	 */
	public static var _ticks:Int = 0;
		
	/******************************
	 * a value of one means that the code is searching for checkmate. 0 means that the code finished or is not searching for checkmate.
	 * when searching for checkmate, a piece with a value of 17 is changed within the search code and does not need to be changed at GameClearVars. when moving a piece normally, the GameClearVars need to make all piece value of 17 set to 0 so that the code can later populate the piece data using the game board vars.
	 * depending on the value of this var, at GameClearVars, a piece with a 17 value will either be ignored or set back to 0. 
	 * // sometimes when the computer moves a piece, the 17 value should not be cleared. setting this value to 1 stops the clearing. the clearVarsOnMoveUpdate function is called a few times after each move so this var cannot be reset at the end of that function.
	 */
	public static var _checkmate_loop:Int = 0;
	
	public static var _doKingDefendFunctionsOnce:Bool = true;
		
	/******************************
	 * is it a check or checkmate? anything related to a checkmate such as setting capturing units for the king or determining if a pawn can free the king from check, etc.
	 */
	public static var __chess_check_or_checkmate:ChessCheckOrCheckmate;
	
	/******************************
	 * is there a piece found at the function that the computer will search for checkmate in how many steps. this determines if the loop should continue.
	 */
	public static var _foundPiece:Bool = false;
	
	/******************************
	 * if true then computer king will not move but instead the other piece capture will defend.
	 */
	public static var _isPieceCapturedNotKing:Bool = false;
	
	 override public function new(__ids_win_lose_or_draw:IDsWinLoseOrDraw):Void
	{
		super();
		
		persistentDraw = true;
		persistentUpdate = true;
		
		_phm = false;
		_pawnHasMoved = false;
		_p = false;
		_ps = 0; 
		_otherPlayersPieceValue = -1; 
		_setMyPVar = false;
		_cpuTriggerMovePiece = false;
		_ticks = 0;
		_checkmate_loop = 0;
		 _doKingDefendFunctionsOnce = true;
		_foundPiece = false;
		_isPieceCapturedNotKing = false;
				
		__chess_check_or_checkmate = new ChessCheckOrCheckmate(__ids_win_lose_or_draw);
	}
	
	public static function options():Void
	{
		_phm = false;
		_pawnHasMoved = false;
		_p = false;
		_ps = 0; 
		_otherPlayersPieceValue = -1; 
		_setMyPVar = false;
		_cpuTriggerMovePiece = true;
		_ticks = 0;
				
		_checkmate_loop = 0;
		_doKingDefendFunctionsOnce = true;
		_foundPiece = false;
		_isPieceCapturedNotKing = false; // if true then computer king will not move but instead the other piece capture will defend.
	}
	
	override public function destroy()
	{
		_phm = false;
		_pawnHasMoved = false;
		_p = false;
		_ps = 0;  
		_otherPlayersPieceValue = -1; 
		_setMyPVar = false;
		_cpuTriggerMovePiece = false;
		_ticks = 0;
	
		super.destroy();
	}
	
	public static function getMoveAnyPieceDefendKing():Void
	{	
		// 1=piece number. 0=instance/unique piece.
		if (_setMyPVar == false) setMoveAnyPieceDefendKing(1);
		if (_setMyPVar == false) setMoveAnyPieceDefendKing(2);
		if (_setMyPVar == false) setMoveAnyPieceDefendKing(3);
		if (_setMyPVar == false) setMoveAnyPieceDefendKing(4);
		if (_setMyPVar == false) setMoveAnyPieceDefendKing(5);
		
	}
	
	public static function moveAnyPieceDefendKing():Void
	{
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMoveAnyPieceDefendKingMyP.copy();

		if (_temp[0] != -1 && _phm == false) 
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
				_ticks = 1;
				
				if (_temp[0] == Reg._chessMoveAnyPieceDefendKingMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMoveAnyPieceDefendKingYold[i];
					Reg._gameXXold = Reg._chessMoveAnyPieceDefendKingXold[i];
					Reg._gameYYnew = Reg._chessMoveAnyPieceDefendKingYnew[i];
					Reg._gameXXnew = Reg._chessMoveAnyPieceDefendKingXnew[i];
					
					_phm = true;
					_setMyPVar = false;
					_ticks = 4;
				
					break;
				}
			}		
			
			for (i in 0...1) 
			{
				Reg._chessMoveAnyPieceDefendKingMyP[i] = -1;
				Reg._chessMoveAnyPieceDefendKingYold[i] = -1;
				Reg._chessMoveAnyPieceDefendKingXold[i] = -1;
				Reg._chessMoveAnyPieceDefendKingYnew[i] = -1;
				Reg._chessMoveAnyPieceDefendKingXnew[i] = -1;
				Reg._chessMoveAnyPieceDefendKingYourP[i] = -1;
			}

		}

	}
	
	public static function setMoveAnyPieceDefendKing(p:Int):Void
	{				
		var _n:Int = 2; // added to first loop. piece.
				
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.
				
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				for (i in 0...10)
				{
					// search for a piece to Capture.
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
					 
					|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 
					
					|| p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 
						 
					|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
					)					
					{
						// p_all starts here.
						Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
						var _str_get1:String = ""; var _str1:Array<String> = [];
						var zy:Int = 0; var zx:Int = 0;
						
						while (Reg._p_all_dynamic1.length > 0)
						{			
							_str_get1 = RegFunctions.pAll1();
							_str1 = _str_get1.split(",");
							
							zy = Std.parseInt(_str1[0]);
							zx = Std.parseInt(_str1[1]);
								
							if (p == 1 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 5 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							&& Reg._gamePointValueForPiece[zy][zx] < 11
							
							|| p == 2
							&& Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							&& Reg._gamePointValueForPiece[zy][zx] < 11
							|| p == 3  
							&& Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							&& Reg._gamePointValueForPiece[zy][zx] < 11
							|| p == 4 
							&& Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							&& Reg._gamePointValueForPiece[zy][zx] < 11
							|| p == 5 
							&& Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1
							&& Reg._gamePointValueForPiece[zy][zx] < 11						
							)
							{
								// if unit does not have a piece but there is 1 of both parties capturing that unit.
								if (Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] < 2 && Reg._gameUniqueValueForPiece[zy][zx] == 0
								|| Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > -1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] >= 2 && Reg._gameUniqueValueForPiece[zy][zx] != 0 // if we can capture the piece putting the king in check.
								)
								{
									setMoveAnyPieceDefendKingVars(p, yy, xx, zy, zx);	
								}
							}								
						
						
						
								// pawns capturing in an angle.
								
								if (p == 1 && i == 0 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 1 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 2 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 3 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 4 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 5 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 6 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 7 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 4 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							
							|| p == 1 && i == 0 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 1 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 2 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 3 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 4 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 5 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 6 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
							
							|| p == 1 && i == 7 
							&& Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 6 
							&& Reg._chessCapturingPathToKing[Reg._playerNotMoving][zy][zx] == 1 
					
					
							)
							{
								// if unit does not have a piece but there is 1 of both parties capturing that unit.
								if (Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] < 2 && Reg._gameUniqueValueForPiece[zy][zx] == 0
								||  Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > -1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] >= 2 && Reg._gameUniqueValueForPiece[zy][zx] != 0 // if we can capture the piece putting the king in check.
								)
								{
									setMoveAnyPieceDefendKingVars(p, yy, xx, zy, zx);	
								}
							}
						
						}
					}
				}
			}
		}
	}
	
	public static function getMoveKingOutOfCheck():Void
	{
		setMoveKingOutOfCheck();
	}
	
	public static function moveKingOutOfCheck():Void
	{
		var _temp:Dynamic = [-1];

		_temp = Reg._chessMoveKingOutOfCheckMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
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
				_ticks = 1;
				
				if (_temp[0] == Reg._chessMoveKingOutOfCheckMyP[i] && _temp[0] != -1)
				{				
					Reg._gameYYold = Reg._chessMoveKingOutOfCheckYold[i];
					Reg._gameXXold = Reg._chessMoveKingOutOfCheckXold[i];
					Reg._gameYYnew = Reg._chessMoveKingOutOfCheckYnew[i];
					Reg._gameXXnew = Reg._chessMoveKingOutOfCheckXnew[i];
				
					_phm = true;
					_ticks = 4;
					break;
				}
			}					
		}
	}	
	
	public static function setMoveKingOutOfCheck():Void
	{
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		ChessCheckOrCheckmate.isUnitBesideKingInCheck(yy, xx);

		// top
		// if unit that king can move to has the other player's piece that is not protected.
		if (yy - 1 >= 0)
		{
			if (Reg._gamePointValueForPiece[yy - 1][xx] > 0 && Reg._gamePointValueForPiece[yy - 1][xx] < 11)	// white piece.	
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy -1][xx] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx);
				}
			}
		}
		
		// top-right
		if (yy - 1 >= 0 && xx + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy - 1][xx + 1] > 0 && Reg._gamePointValueForPiece[yy - 1][xx + 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy -1][xx + 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx + 1);
				}
			}
		}		
		
		// right
		if (xx + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy][xx + 1] > 0 && Reg._gamePointValueForPiece[yy][xx + 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx + 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy, xx + 1);
				}
			}
		}		
		
		// bottom-right
		if (yy + 1 <= 7 && xx + 1 <= 7 )
		{
			if (Reg._gamePointValueForPiece[yy + 1][xx + 1] > 0 && Reg._gamePointValueForPiece[yy + 1][xx + 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy +1][xx + 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx + 1);
				}
			}
		}		
		
		// bottom
		if (yy + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy + 1][xx] > 0 && Reg._gamePointValueForPiece[yy + 1][xx] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy +1][xx] <= 2)
				{	var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx);
				}
			}
		}	
		
		// bottom-left
		if (yy + 1 <= 7 && xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy + 1][xx - 1] > 0 && Reg._gamePointValueForPiece[yy + 1][xx - 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy +1][xx - 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx - 1);
				}
			}
		}	
		
		// left
		if (xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy][xx - 1] > 0 && Reg._gamePointValueForPiece[yy][xx - 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx - 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy, xx - 1);
				}
			}
		}
		
		// top-left
		if (yy - 1 >= 0 && xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy - 1][xx - 1] > 0 && Reg._gamePointValueForPiece[yy - 1][xx - 1] < 11)		
			{
				// if unit king can move to is not captured but has another player's piece there.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy - 1][xx - 1] <= 2)
				{
					var ra = FlxG.random.int(100001, 900000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx - 1);
				}
			}
		}
		
		//#############################
		
		// top
		// if unit that king can move to is empty.
		if (yy - 1 >= 0)
		{
			if (Reg._gamePointValueForPiece[yy -1][xx] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy - 1][xx] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx);
				}
			}
		}
		
		// top-right
		if (yy - 1 >= 0 && xx + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy -1][xx + 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy - 1][xx + 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx + 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx + 1);
				}
			}
		}		
		
		// right
		if (xx + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy][xx + 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx + 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx + 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy, xx + 1);
				}
			}
		}		
		
		// bottom-right
		if (yy + 1 <= 7 && xx + 1 <= 7 )
		{
			if (Reg._gamePointValueForPiece[yy +1][xx + 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx + 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx + 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx + 1);
				}
			}
		}		
		
		// bottom
		if (yy + 1 <= 7)
		{
			if (Reg._gamePointValueForPiece[yy + 1][xx] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx] == true)
				{	var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx);
				}
			}
		}	
		
		
		// bottom-left
		if (yy + 1 <= 7 && xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy +1][xx - 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx - 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy + 1][xx - 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy + 1, xx - 1);
				}
			}
		}	
		
		// left
		if (xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy][xx - 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx - 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy][xx - 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy, xx - 1);
				}
			}
		}
		
		// top-left
		if (yy - 1 >= 0 && xx - 1 >= 0 )
		{
			if (Reg._gamePointValueForPiece[yy - 1][xx - 1] < 11)		
			{
				// if unit king can move to is not captured.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy - 1][xx - 1] == 0 && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][yy - 1][xx - 1] == true)
				{
					var ra = FlxG.random.int(1, 100000);
					setMoveKingOutOfCheckVars(ra, yy, xx, yy - 1, xx - 1);
				}
			}
		}
	}
		
	
	public static function getMovePieceToDefendNotProtected():Void
	{		
		Reg2._random_num.splice(0, Reg2._random_num.length);
		// this number of elements here...
		Reg2._random_num = [1, 2, 3, 4, 5];
		
		// must match the max value here.
		for (i in 0...5)
		{
			_ps = RegFunctions.randomNumberFromArrayElements();
			
			setMovePieceToDefendNotProtected(_ps, 1, 3);
			
		}		
		
		_ps = 0;
	
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePieceToDefendNotProtectedMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
		{
			/*
			if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}
			*/				
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePieceToDefendNotProtectedMyP[i] && _temp[0] != -1)
				{				
					Reg._gameYYold = Reg._chessMovePieceToDefendNotProtectedYold[i];
					Reg._gameXXold = Reg._chessMovePieceToDefendNotProtectedXold[i];
					Reg._gameYYnew = Reg._chessMovePieceToDefendNotProtectedYnew[i];
					Reg._gameXXnew = Reg._chessMovePieceToDefendNotProtectedXnew[i];
				
					_phm = true;
				
					break;
				}
			}					
		}		
	}	
	
	// a piece had been moved that jeopardized this player's piece. this function moves the player's piece in position to defend another of its piece that is under attack.
	public static function setMovePieceToDefendNotProtected(p:Int, min:Int, max:Int):Void
	{
		if (p == 2) Reg._chessForAnotherPieceValue = 1; // this line is needed. its used to generate the future piece.
		else if (p == 3) Reg._chessForAnotherPieceValue = 4;
		else if (p == 4) Reg._chessForAnotherPieceValue = 2;
		else if (p == 5) Reg._chessForAnotherPieceValue = 3;
		else Reg._chessForAnotherPieceValue = 0;
		
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.
		
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					var _canDefendAnyTwoOrMorePieces:Int = 0;
					
					// search for a capturing units that the player now moving can take.
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					|| p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0)
					{
						// create a future piece at that location. this will act as if the rook had moved there. we do this to determine if there is a piece to capture at that future location.
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy][xx] = 17;
						
						// pawn. pawn will be first on the list to attack since pawn has a value of only 1 and is not as important a piece as the last in this function which is a queen.
						if (p == 1 && yy < 7 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5) 
						{							
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx - 1] = 1;
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx + 1] = 1;						
						}
						
						// horse. generate future var for horse.
						else if (p == 3)
						{							
							ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, yy, xx);
						}
						
						// future var is not a pawn nor horse.
						else ChessCapturingUnits.futurePrepareCapturingUnits(1, p, i, yy, xx);
												
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// can move to new location only if that new location is not a capturing unit.
								if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0	
								&& Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17
								&& Reg._gamePointValueForPiece[cy][cx] < 11
								)
								{
									// p_all starts here.
									Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
									var _str_get2:String = ""; var _str2:Array<String> = [];
									var qy:Int = 0; var qx:Int = 0;

									while (Reg._p_all_dynamic2.length > 0)
									{			
										_str_get2 = RegFunctions.pAll2();
										_str2 = _str_get2.split(",");
										
										qy = Std.parseInt(_str2[0]);
										qx = Std.parseInt(_str2[1]);

										// if the player capturing unit is at its piece.
										if (
										Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 	&& Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 0			   && Reg._gamePointValueForPiece[qy][qx] >= 11)
										{	
											// player's piece can move only if the other player's capturing unit on that piece can be matched in capturing value.
											if (Reg._chessForAnotherPieceValue == 0 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] >= min && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] //for pawn its a value of 5 not 1.  
											)
											{
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													// don't move if protecting its pieces
													if (vx > 0)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerMoving][vy][vx-1] > 0 && Reg._gamePointValueForPiece[vy][vx-1] >= 11)
							
														{
														_canDefendAnyTwoOrMorePieces += 1;
														}
													}
													
													if (vx < 7)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerMoving][vy][vx+1] > 0 && Reg._gamePointValueForPiece[vy][vx+1] >= 11)
							
														{
														_canDefendAnyTwoOrMorePieces += 1;
															
														}
													}
												
												
												}
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 17)
													{
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1)
														{
															setMoveDefendNotProtectedVars(cy+cx, vy, vx, cy, cx);					
														}
													}							
												}
											
											}
											
											if (Reg._chessForAnotherPieceValue == 1 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] >= min && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx]
											)
											{											
												_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefend(p, cy, cx);
																			
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessBishop[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefend(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
												
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMoveDefendNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											
											}
											
											if (Reg._chessForAnotherPieceValue == 4 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] >= min && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx]
											)
											{											_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefend(p, cy, cx);
															
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessHorse[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefend(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
												
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMoveDefendNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											
											}
											
											if (Reg._chessForAnotherPieceValue == 2 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] >= min && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx]
											)
											{											
												_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefend(p, cy, cx);
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessRook[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefend(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
												if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMoveDefendNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											
											}
											
											
											if (Reg._chessForAnotherPieceValue == 3 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] >= 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] >= min && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx]
											)
											{											
												_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefend(p, cy, cx);
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessQueen[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefend(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
												
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMoveDefendNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
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
		}	
	}
	
	
	public static function getMovePieceToCaptureNotProtected():Void
	{
		Reg2._random_num.splice(0, Reg2._random_num.length);
		// this number of elements here...
		Reg2._random_num = [1, 2, 3, 4, 5];
		
		// must match the max value here.
		for (i in 0...5)
		{
			_ps = RegFunctions.randomNumberFromArrayElements();
			
			setMovePieceToCaptureNotProtected(_ps, 1, 1);
			
		}
		
		_ps = 0;
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePieceToCaptureNotProtectedMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
		{
			/*
			if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}*/
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePieceToCaptureNotProtectedMyP[i] && _temp[0] != -1)
				{					
					Reg._gameYYold = Reg._chessMovePieceToCaptureNotProtectedYold[i];
					Reg._gameXXold = Reg._chessMovePieceToCaptureNotProtectedXold[i];
					Reg._gameYYnew = Reg._chessMovePieceToCaptureNotProtectedYnew[i];
					Reg._gameXXnew = Reg._chessMovePieceToCaptureNotProtectedXnew[i];
				
					_phm = true;
				
					break;
				}
			}					
		}
	}
	
	
	// a piece had been moved that jeopardized this player's piece. this function moves the player's piece in position to attack attack when player's capturing unit is greater in value than the capturing unit of the attacked player. in other words, the piece will not move if there is already another player's piece attacking it.
	public static function setMovePieceToCaptureNotProtected(p:Int, min:Int, max:Int):Void
	{
		if (p == 2) Reg._chessForAnotherPieceValue = 1; // this line is needed. its used to generate the future piece.
		else if (p == 3) Reg._chessForAnotherPieceValue = 4;
		else if (p == 4) Reg._chessForAnotherPieceValue = 2;
		else if (p == 5) Reg._chessForAnotherPieceValue = 3;
		else Reg._chessForAnotherPieceValue = 0;
		
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.

		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					var _canAttackAnyTwoOrMorePieces:Int = 0;
					
					// search for a capturing units that the player now moving can take.
					if (p == 1 && i < 8 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					||  p == 2 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					||  p == 3 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					||  p == 4 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0 
					||  p == 5 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1 && Reg._gameUniqueValueForPiece[yy][xx] == 0)
					{
						// create a future piece at that location. this will act as if the rook had moved there. we do this to determine if there is a piece to capture at that future location.
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy][xx] = 17;
						
						// pawn. pawn will be first on the list to attack since pawn has a value of only 1 and is not as important a piece as the last in this function which is a queen.
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5 && yy < 7 && xx < 7) 
						{							
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx - 1] = 1;
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx + 1] = 1;						
						}
						
						// horse. generate future pieces for horse.
						else if (p == 3) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, yy, xx);
						
						// future var is not a pawn nor horse.
						else ChessCapturingUnits.futurePrepareCapturingUnits(1, p, i, yy, xx);
												
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// can move to new location only if that new location is not a capturing unit.
								if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0 
								&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0 
								&& Reg._gamePointValueForPiece[cy][cx] < 11
								&& Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17 						  
								)
								{
									// p_all starts here.
									Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
									var _str_get2:String = ""; var _str2:Array<String> = [];
									var qy:Int = 0; var qx:Int = 0;

									while (Reg._p_all_dynamic2.length > 0)
									{			
										_str_get2 = RegFunctions.pAll2();
										_str2 = _str_get2.split(",");
										
										qy = Std.parseInt(_str2[0]);
										qx = Std.parseInt(_str2[1]);
										
										// if the player capturing unit is at the other player's piece.
										if (
										Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 	&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] > 0			   && Reg._gamePointValueForPiece[qy][qx] > 0
				 && Reg._gamePointValueForPiece[qy][qx] < 11)
										{	
											// player's piece can move only if the other player's capturing unit on that piece can be matched in capturing value.
											if (Reg._chessForAnotherPieceValue == 0 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] <= Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] //for pawn its a value of 5 not 1.  
											)
											{
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													// don't move if protecting its pieces
													if (vx > 0)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][vy][vx-1] > 0 && Reg._gamePointValueForPiece[vy][vx-1] > 0 && Reg._gamePointValueForPiece[vy][vx-1] < 11)
							
														{
														_canAttackAnyTwoOrMorePieces += 1;
														}
													}
													
													if (vx < 7)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][vy][vx+1] > 0 && Reg._gamePointValueForPiece[vy][vx+1] > 0 && Reg._gamePointValueForPiece[vy][vx+1] < 11)
							
														{
														_canAttackAnyTwoOrMorePieces += 1;
															
														}
													}
												
												
												}
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 17)
													{
														if (min == 0 || _canAttackAnyTwoOrMorePieces > 1)
														{
															setMoveAttackNotProtectedVars(cy+cx, vy, vx, cy, cx);					
														}
													}							
													
												}
											}
											
											if (Reg._chessForAnotherPieceValue == 1 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] <= Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx]
											)
											{
												_canAttackAnyTwoOrMorePieces = isPieceAtUnitCapture(p, cy, cx);												
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessBishop[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canAttackAnyTwoOrMorePiecesOld = isPieceAtUnitCapture(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canAttackAnyTwoOrMorePieces > 1 && _canAttackAnyTwoOrMorePiecesOld < _canAttackAnyTwoOrMorePieces)
														{

															if (_canAttackAnyTwoOrMorePieces > 0) {cy2 = _canAttackAnyTwoOrMorePieces; cx2 = 0; }
																																	setMoveAttackNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											}
										
											if (Reg._chessForAnotherPieceValue == 4 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] <= Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] 
											)
											{													_canAttackAnyTwoOrMorePieces = isPieceAtUnitCapture(p, cy, cx);																					
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessHorse[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canAttackAnyTwoOrMorePiecesOld = isPieceAtUnitCapture(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canAttackAnyTwoOrMorePieces > 1 && _canAttackAnyTwoOrMorePiecesOld < _canAttackAnyTwoOrMorePieces)
														{
												
															if (_canAttackAnyTwoOrMorePieces > 0) {cy2 = _canAttackAnyTwoOrMorePieces; cx2 = 0; }
														
												setMoveAttackNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}

											}
											
											if (Reg._chessForAnotherPieceValue == 2 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] <= Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx]
											)
											{
												_canAttackAnyTwoOrMorePieces = isPieceAtUnitCapture(p, cy, cx);															
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													
													if (Reg._chessRook[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canAttackAnyTwoOrMorePiecesOld = isPieceAtUnitCapture(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canAttackAnyTwoOrMorePieces > 1 && _canAttackAnyTwoOrMorePiecesOld < _canAttackAnyTwoOrMorePieces)
														{
												if (_canAttackAnyTwoOrMorePieces > 0) {cy2 = _canAttackAnyTwoOrMorePieces; cx2 = 0; }

												setMoveAttackNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}

											}
											
											if (Reg._chessForAnotherPieceValue == 3 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] > 0 && Reg._gamePointValueForPiece[qy][qx] < 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] <= Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx]
											)
											{													_canAttackAnyTwoOrMorePieces = isPieceAtUnitCapture(p, cy, cx);												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
													
													if (Reg._chessQueen[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canAttackAnyTwoOrMorePiecesOld = isPieceAtUnitCapture(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canAttackAnyTwoOrMorePieces > 1 && _canAttackAnyTwoOrMorePiecesOld < _canAttackAnyTwoOrMorePieces)
														{
												if (_canAttackAnyTwoOrMorePieces > 0) {cy2 = _canAttackAnyTwoOrMorePieces; cx2 = 0; }
														
												setMoveAttackNotProtectedVars(cy2+cx2, vy, vx, cy, cx);					
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
		}	
	}
	
	public static function getMoveFromAttacker():Void
	{
		// i = instance of piece from AI. i value is passed to this function from ChessCPUsAI.
		
		setMoveFromAttacker(6, 0, 3);
		setMoveFromAttacker(5, 0, 3);
		setMoveFromAttacker(4, 0, 3);
		setMoveFromAttacker(3, 0, 3);
		setMoveFromAttacker(2, 0, 3);
		setMoveFromAttacker(1, 0, 3);
		
		_ps = 0; // this is needed
		
		if (RegCustom._game_skill_level_chess < 2)
		{
			var _temp_defend:Dynamic = [-1];		
			_temp_defend = Reg._chessMoveFromAttackerMyP.copy(); // computer piece.
			
			if (_temp_defend[0] != -1 && _phm == false) 
			{
				if (_temp_defend.length > 1)
				{
					haxe.ds.ArraySort.sort(_temp_defend, function(a, b):Int {
						if (a > b) return -1; // change "<" into  ">" for high piece value first.
						else if (a < b) return 1; // change ">" into  "<" for high piece value 
						return 0;
					});
				}
				
				for (i in 0...65)
				{
					if (_temp_defend[0] == Reg._chessMoveFromAttackerMyP[i] && _temp_defend[0] != -1)
					{
						Reg._gameYYold = Reg._chessMoveFromAttackerYold[i];
						Reg._gameXXold = Reg._chessMoveFromAttackerXold[i];
						Reg._gameYYnew = Reg._chessMoveFromAttackerYnew[i];
						Reg._gameXXnew = Reg._chessMoveFromAttackerXnew[i];
					
						_phm = true;
						
						break;
					}
				}		
			}
		}
						
	}
	
	public static function setMoveFromAttacker(p:Int, min:Int, max:Int):Void
	{
		var _ra = FlxG.random.int(0, 9);
		var _chessPointsOther = chessPointsOther();
		
		var _chessPoints = chessPoints();
		if (_chessPoints == 0) _ra = 0; // if computer has lone king then move it.
		
		if (_chessPoints < 8) unitDistanceFromPiece();
		
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// the player's pieces.
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 6 && _ra < 8 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17
					)
					{
						// is there a capture that the pawn at that location cannot match?
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
								
								// if pawn can move to this unit.
								if (p == 1 
								&&  Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 5 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
								}						
								
								// found a piece to capture.
								if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 5
								&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 
								&& Reg._gamePointValueForPiece[zy][zx] > 0
								&& Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+1000, yy, xx, zy, zx); 	
								}						
								
							}								

							
						}
						
						// is there a capture that the bishop at that location cannot match?
						if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
								
								// if bishop can move to this unit.
								if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] > 0	&& Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
								}						
								
								// found a piece to capture.
								if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 && Reg._gamePointValueForPiece[zy][zx] > 0	&& Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+1000, yy, xx, zy, zx); 	
								}	
								
								// don't run away. look one move in advanced and see if there is a piece to capture.
								Reg._chessForAnotherPieceValue = 1;
								if (p == 2) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, zy, zx);
								Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] = 17;				

								
								// p_all starts here.
								Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
								var _str_get2:String = ""; var _str2:Array<String> = [];
								var qy:Int = 0; var qx:Int = 0;

								while (Reg._p_all_dynamic2.length > 0)
								{			
									_str_get2 = RegFunctions.pAll2();
									_str2 = _str_get2.split(",");
									
									qy = Std.parseInt(_str2[0]);
									qx = Std.parseInt(_str2[1]);								
									if (p == 2 && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] > 1 && Reg._gameUniqueValueForPiece[yy][xx] < Reg._gameUniqueValueForPiece[qy][qx] && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1
									)
									{
										setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+(Reg._futureCapturesFromPieceLocation[Reg._playerMoving][p][i][zy][zx]*1)+2000, yy, xx, zy, zx); 	
									}
								}
														
							}
						}
					
						// is there a capture that the horse at that location cannot match?
						if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								// if horse can move to this unit.
								if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
								}	
								
								// found a piece to capture.
								if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+1000, yy, xx, zy, zx); 	
								}										
							
								
								// don't run away. look one move in advanced and see if there is a piece to capture.
								Reg._chessForAnotherPieceValue = 4;
								if (p == 3) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, zy, zx);
								Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] = 17;				

								// determine the best place to move to. maybe a unit that can capture two pieces.
								// p_all starts here.
								Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
								var _str_get2:String = ""; var _str2:Array<String> = [];
								var qy:Int = 0; var qx:Int = 0;

								while (Reg._p_all_dynamic2.length > 0)
								{			
									_str_get2 = RegFunctions.pAll2();
									_str2 = _str_get2.split(",");
									
									qy = Std.parseInt(_str2[0]);
									qx = Std.parseInt(_str2[1]);
									
									if (p == 3 && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] > 1 && Reg._gameUniqueValueForPiece[yy][xx] < Reg._gameUniqueValueForPiece[qy][qx] && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1
									)
									{
										setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+(Reg._futureCapturesFromPieceLocation[Reg._playerMoving][p][i][zy][zx]*1)+2000, yy, xx, zy, zx); 	
									}
								}

							
							}
						}
														
						// is there a capture that the rook at that location cannot match?
						if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 
						)
						{			
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								// if rook can move to this unit.
								if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] > 0	&& Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
								}
								
								// found a piece to capture.
								if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 
								&& Reg._gamePointValueForPiece[zy][zx] > 0
								&& Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+1000, yy, xx, zy, zx); 	
								}
								
								
								// don't run away. look one move in advanced and see if there is a piece to capture.
								Reg._chessForAnotherPieceValue = 2;
								if (p == 4) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, zy, zx);
								Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] = 17;				

								// p_all starts here.
								Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
								var _str_get2:String = ""; var _str2:Array<String> = [];
								var qy:Int = 0; var qx:Int = 0;

								while (Reg._p_all_dynamic2.length > 0)
								{			
									_str_get2 = RegFunctions.pAll2();
									_str2 = _str_get2.split(",");
									
									qy = Std.parseInt(_str2[0]);
									qx = Std.parseInt(_str2[1]);								
									if (p == 4 && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] > 1 && Reg._gameUniqueValueForPiece[yy][xx] < Reg._gameUniqueValueForPiece[qy][qx] && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1
									)
									{
										setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+(Reg._futureCapturesFromPieceLocation[Reg._playerMoving][p][i][zy][zx]*1)+2000, yy, xx, zy, zx); 	
									}
								}
								

							}
						}
						
						// is there a capture that the queen at that location cannot match?
						if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0 
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								// if queen can move to this unit.
								if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
								}						
								
								// found a piece to capture.
								// if queen can move to this unit.
								if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11
								)
								{
									setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+1000, yy, xx, zy, zx); 	
								}
								
								
								// don't run away. look one move in advanced and see if there is a piece to capture.
								Reg._chessForAnotherPieceValue = 3;
								if (p == 5) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, zy, zx);
								Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] = 17;				

								// p_all starts here.
								Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
								var _str_get2:String = ""; var _str2:Array<String> = [];
								var qy:Int = 0; var qx:Int = 0;

								while (Reg._p_all_dynamic2.length > 0)
								{			
									_str_get2 = RegFunctions.pAll2();
									_str2 = _str_get2.split(",");
									
									qy = Std.parseInt(_str2[0]);
									qx = Std.parseInt(_str2[1]);								
									if (p == 5 && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][zy][zx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] > 1 && Reg._gameUniqueValueForPiece[yy][xx] < Reg._gameUniqueValueForPiece[qy][qx] && Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1
									)
									{
										setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+(Reg._futureCapturesFromPieceLocation[Reg._playerMoving][p][i][zy][zx]*1)+2000, yy, xx, zy, zx); 	
									}
								}
								
							}
						}
						
						// if there is no computer piece being captured then enter this loop.
						if (_ra < 8 && _isPieceCapturedNotKing == false)
						{
							// king in check.
							if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
							)
							{
								// p_all starts here.
								Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
								var _str_get1:String = ""; var _str1:Array<String> = [];
								var zy:Int = 0; var zx:Int = 0;
								
								while (Reg._p_all_dynamic1.length > 0)
								{			
									_str_get1 = RegFunctions.pAll1();
									_str1 = _str_get1.split(",");
									
									zy = Std.parseInt(_str1[0]);
									zx = Std.parseInt(_str1[1]);
		
									// a value of 7 refers to 2 horses that the other player has. any higher value then computer king will not try to box the other king in to checkmate. a value could be 1 which refers to a pawn. a pawn could promote, so king should try to move if under or equal to the value of 7. so a high value means that the other player has to many pieces for computer king to try to force checkmate.
									if (_chessPointsOther < 8) 
									{
										// if king can move to this unit.
										if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17 && Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11
										)
										{
											if (Reg._unitDistanceFromPiece[zy][zx] < Reg._unitDistanceFromPiece[yy][xx])	
											{
												var _ra = FlxG.random.int(0, 8);
												
												var qy = Reg._chessKingYcoordinate[Reg._playerNotMoving];
												var qx = Reg._chessKingXcoordinate[Reg._playerNotMoving];
												setMoveFromAttackerVars(qy + qx + _ra + 1500, yy, xx, zy, zx);
											}
										}	

										if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17 && Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 && Reg._gamePointValueForPiece[zy][zx] > 0
										&& Reg._gamePointValueForPiece[zy][zx] < 11
										)
										{
											if (Reg._unitDistanceFromPiece[zy][zx] < Reg._unitDistanceFromPiece[yy][xx])	
											{
												var _ra = FlxG.random.int(0, 8);
												
												var qy = Reg._chessKingYcoordinate[Reg._playerNotMoving];
												var qx = Reg._chessKingXcoordinate[Reg._playerNotMoving];
												setMoveFromAttackerVars(qy + qx + _ra + 1000, yy, xx, zy, zx);
											}
										}								
									}

									else
									{
										// if king can move to this unit.
										if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17 && Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 && Reg._gamePointValueForPiece[zy][zx] == 0
										&& Reg._gamePointValueForPiece[zy][zx] < 11
										)
										{
											setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx); 	
										}						
										
										// if king can move to this unit.
										if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17 && Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11
										)
										{
											setMoveFromAttackerVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx]+900, yy, xx, zy, zx); 	
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
	
	public static function getMovePawnToPromoteAnyProtection(i:Int = 0):Void
	{	
		// i = instance of piece from AI. i value is passed to this function from ChessCPUsAI.
		
		if (i > 0) setMovePawnToPromoteAnyProtection(i);
		else
		{
			Reg2._random_num.splice(0, Reg2._random_num.length);
			// this number of elements here...
			Reg2._random_num = [0, 1, 2, 3, 4, 5, 6, 7];
			
			// must match the max value here.
			for (i in 0...7)
			{
				_ps = RegFunctions.randomNumberFromArrayElements();
			
				setMovePawnToPromoteAnyProtection(_ps);
			}
		}
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePawnToPromoteMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
		{
			/*
			if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}*/
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePawnToPromoteMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMovePawnToPromoteYold[i];
					Reg._gameXXold = Reg._chessMovePawnToPromoteXold[i];
					Reg._gameYYnew = Reg._chessMovePawnToPromoteYnew[i];
					Reg._gameXXnew = Reg._chessMovePawnToPromoteXnew[i];
				
					_phm = true;
				
					break;
				}
			}	
		}
		}	
		
	/**
	 * moves a pawn piece if two unit or closer to pawn promotion.
	 * @param	v`	pawn piece number.
	 */
	public static function setMovePawnToPromoteAnyProtection(v:Int):Void
	{						
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// if pawn is 2 units or closer to the promotion row then move that pawn if the following conditions are true.
				
				// if piece is pawn and one unit ahead of pawn if not captured by the other player .				
				if (Reg._chessPawn[Reg._playerMoving][v][yy][xx] == 17 
				&& Reg._chessPawn[Reg._playerMoving][v][yy + 1][xx] == 5 
				&& Reg._capturingUnitsForPieces[Reg._playerMoving][yy + 1][xx] > Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx] 
				&& yy > 3 && yy < 7
				&& Reg._gamePointValueForPiece[yy+1][xx] == 0
				)
				{
					var cy = yy + 1;
					var ra = FlxG.random.int(1, 8);
					setMovePawnToPromoteVars(yy+xx+ra, yy, xx, cy, xx); // move piece.
				}
			}
		}
	}
	
	public static function getMovePieceDefendPawnForPromotion():Void
	{
		setMovePieceDefendPawnForPromotion(1, 1, 3); // a unit that is captured by both players.
		setMovePieceDefendPawnForPromotion(2, 1, 3);
		setMovePieceDefendPawnForPromotion(3, 1, 3);
		setMovePieceDefendPawnForPromotion(4, 1, 3);
		setMovePieceDefendPawnForPromotion(5, 1, 3);
		setMovePieceDefendPawnForPromotion(1, 0, 3); // player's piece not captured.
		setMovePieceDefendPawnForPromotion(2, 0, 3);
		setMovePieceDefendPawnForPromotion(3, 0, 3);
		setMovePieceDefendPawnForPromotion(4, 0, 3);
		setMovePieceDefendPawnForPromotion(5, 0, 3);
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePieceDefendPawnForPromotionMyP;
		
		if (_temp[0] != -1 && _phm == false) 
		{							
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePieceDefendPawnForPromotionMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMovePieceDefendPawnForPromotionYold[i];
					Reg._gameXXold = Reg._chessMovePieceDefendPawnForPromotionXold[i];
					Reg._gameYYnew = Reg._chessMovePieceDefendPawnForPromotionYnew[i];
					Reg._gameXXnew = Reg._chessMovePieceDefendPawnForPromotionXnew[i];
				
					_phm = true;
				
					break;
				}
			}					
			
		}
	}	
	
	/**
	 * this function defends a pawn that is close to promotion.
	 * @param	p		the piece point value that might be able to protect a pawn that is close to promotion.
	 * @param	min		this value is used determine if a unit is captured and also selects either not protected or protected code.	
	 * @param	max		used to determine if capturing at a max value and below value.
	 */
	public static function setMovePieceDefendPawnForPromotion(p:Int, min:Int, max:Int):Void
	{
		if (p == 2) Reg._chessForAnotherPieceValue = 1; // this line is needed. its used to generate the future piece.
		else if (p == 3) Reg._chessForAnotherPieceValue = 4;
		else if (p == 4) Reg._chessForAnotherPieceValue = 2;
		else if (p == 5) Reg._chessForAnotherPieceValue = 3;
		else Reg._chessForAnotherPieceValue = 0;
		
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.

		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					var _canDefendAnyTwoOrMorePieces:Int = 0;
					
					// search for a capturing units that the player now moving can take.
					if (p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					|| p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					)
					{
						// create a future piece at that location. this will act as if the rook had moved there. we do this to determine if there is a piece to capture at that future location.
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy][xx] = 17;
						
						// pawn. pawn will be first on the list to attack since pawn has a value of only 1 and is not as important a piece as the last in this function which is a queen.
						if (p == 1 && yy < 7 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5) 
						{							
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx - 1] = 1;
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx + 1] = 1;						
						}
						
						// horse. generate future var for horse.
						else if (p == 3) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, yy, xx);
						
						// future  var is not a pawn nor horse.
						else ChessCapturingUnits.futurePrepareCapturingUnits(1, p, i, yy, xx);
												
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// can move to new location only if that new location is not a capturing unit.
								if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0	&& Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17
								|| Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 2	&& Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17
								)
								{
									// p_all starts here.
									Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
									var _str_get2:String = ""; var _str2:Array<String> = [];
									var qy:Int = 0; var qx:Int = 0;

									while (Reg._p_all_dynamic2.length > 0)
									{			
										_str_get2 = RegFunctions.pAll2();
										_str2 = _str_get2.split(",");
										
										qy = Std.parseInt(_str2[0]);
										qx = Std.parseInt(_str2[1]);
									
										// if the player capturing unit is at its piece.
										if (
										Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 	&& Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 0			   && Reg._gamePointValueForPiece[qy][qx] == 11 && qy > 4 && qy < 7 )
										{
											// player's piece can move only if the other player's capturing unit on that piece can be matched in capturing value.
											if (Reg._chessForAnotherPieceValue == 0 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5 && Reg._gamePointValueForPiece[qy][qx] == 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < 2 && min == 0 && qy > 4 && qy < 7 
											)
											{
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													// don't move if protecting its pieces
													if (vx > 0)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerMoving][vy][vx-1] > 0 && Reg._gamePointValueForPiece[vy][vx-1] == 11)
							
														{
														_canDefendAnyTwoOrMorePieces += 1;
														}
													}
													
													if (vx < 7)
													{
														if (
							Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 5 && Reg._capturingUnitsForPieces[Reg._playerMoving][vy][vx+1] > 0 && Reg._gamePointValueForPiece[vy][vx+1] == 11)
							
														{
														_canDefendAnyTwoOrMorePieces += 1;
															
														}
													}
												
												}
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessPawn[Reg._playerMoving][i][vy][vx] == 17)
													{
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1)
														{
															setMovePieceDefendPawnVars(cy+cx, vy, vx, cy, cx);					
														}
													}							
												
												}
											}
											
											if (Reg._chessForAnotherPieceValue == 1 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] == 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < 2 && min == 0 && qy > 4 && qy < 7 
											)
											{
												_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefendPawn(p, cy, cx);
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessBishop[Reg._playerMoving][i][vy][vx] == 17)
													{															var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefendPawn(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
												if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
											
												setMovePieceDefendPawnVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											
											}
											
											if (Reg._chessForAnotherPieceValue == 4 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] == 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < 2 && min == 0 && qy > 4 && qy < 7 
											)
											{											_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefendPawn(p, cy, cx);
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);

													if (Reg._chessHorse[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefendPawn(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
														setMovePieceDefendPawnVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
													
												}
											}
											
											if (Reg._chessForAnotherPieceValue == 2 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] == 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < 2 && min == 0 && qy > 4 && qy < 7 
											)
											{											_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefendPawn(p, cy, cx);
												
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
												
													if (Reg._chessRook[Reg._playerMoving][i][vy][vx] == 17)
													{
														var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefendPawn(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMovePieceDefendPawnVars(cy2+cx2, vy, vx, cy, cx);					
														}
													}							
												}
											}
									
											if (Reg._chessForAnotherPieceValue == 3 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1 && Reg._gamePointValueForPiece[qy][qx] == 11 && Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] > 1 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] < 2 && min == 0 && qy > 4 && qy < 7 	 
											)
											{											_canDefendAnyTwoOrMorePieces = isPieceAtUnitDefendPawn(p, cy, cx);
												// p_all starts here.
												Reg._p_all_dynamic3 = Reg._p_all_static3.copy();
												var _str_get3:String = ""; var _str3:Array<String> = [];
												var vy:Int = 0; var vx:Int = 0;

												while (Reg._p_all_dynamic3.length > 0)
												{			
													_str_get3 = RegFunctions.pAll3();
													_str3 = _str_get3.split(",");
													
													vy = Std.parseInt(_str3[0]);
													vx = Std.parseInt(_str3[1]);
													
													if (Reg._chessQueen[Reg._playerMoving][i][vy][vx] == 17)
													{															var _canDefendAnyTwoOrMorePiecesOld = isPieceAtUnitDefendPawn(p, vy, vx);
														
														var cy2 = cy;
														var cx2 = cx;
														
														if (min == 0 || _canDefendAnyTwoOrMorePieces > 1 && _canDefendAnyTwoOrMorePiecesOld < _canDefendAnyTwoOrMorePieces)
														{
															if (_canDefendAnyTwoOrMorePieces > 0) {cy2 = _canDefendAnyTwoOrMorePieces; cx2 = 0; }
																																	setMovePieceDefendPawnVars(cy2 + cx2, vy, vx, cy, cx);					
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
		}	
	}
	
	public static function getMovePawnNormallyNotProtected(i:Int = 0):Void
	{
		// i = instance of piece from AI. i value is passed to this function from ChessCPUsAI.
		if (i > 0) setMovePawnNormallyNotProtected(1, i);
		else
		{		
			Reg2._random_num.splice(0, Reg2._random_num.length);
			// this number of elements here...
			Reg2._random_num = [0, 1, 2, 3, 4, 5, 6, 7];
			
			// must match the max value here.
			for (i in 0...7)
			{
				_ps = RegFunctions.randomNumberFromArrayElements();
				
				setMovePawnNormallyNotProtected(1, _ps);
				
			}
		}
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePawnNormallyNotProtectedMyP;

		if (_temp[0] != -1 && _phm == false) 
		{
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePawnNormallyNotProtectedMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMovePawnNormallyNotProtectedYold[i];
					Reg._gameXXold = Reg._chessMovePawnNormallyNotProtectedXold[i];
					Reg._gameYYnew = Reg._chessMovePawnNormallyNotProtectedYnew[i];
					Reg._gameXXnew = Reg._chessMovePawnNormallyNotProtectedXnew[i];
				
					_phm = true;
				
					break;
				}
			}
		}
	}
	
	/**
	 * @param	p		piece point value.
	 * @param	i		piece instance.
	 */
	public static function setMovePawnNormallyNotProtected(p:Int, i:Int):Void
	{		
		var _n:Int = 2; // added to first loop. piece.
				
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{					
				// search for a piece to Capture.
				if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
				)
				{
					// used to move the pawn number i if the value is 3 or less than 3. see below.
					var ra = FlxG.random.int(1, 7);
					var ra2 = FlxG.random.int(1, 100000);	
					var ra3 = FlxG.random.int(1, 2); // 1=pawn never moved. 2:go to pawn that has moved.
					
					var yy2 = yy + 1;
					var yy3 = yy + 2;
					
					if (yy == 1 && ra3 == 1)
					{
						// move the pawn once if true. 
						if (ra == 3 
						&& Reg._chessPawn[Reg._playerMoving][i][yy + 1][xx] == 5 
						&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx] == 0
						&& Reg._gamePointValueForPiece[yy2][xx] == 0
						)
						{
								setMovePawnNormallyNotProtectedVars(ra2, yy, xx, yy2, xx);
						}	
						
						// else move it two units.
						else if (ra < 3 
						&& Reg._chessPawn[Reg._playerMoving][i][yy+2][xx] == 5 
				
						&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy+2][xx] == 0 // location pawn can move to.
						&& Reg._gamePointValueForPiece[yy3][xx] == 0
						)
						{
								setMovePawnNormallyNotProtectedVars(ra2, yy, xx, yy3, xx);
						}
					}	
					// move a pawn that has moved before.
					else if (yy < 5 
					&& Reg._chessPawn[Reg._playerMoving][i][yy+1][xx] == 5 				
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy + 1][xx] == 0
					&& Reg._gamePointValueForPiece[yy2][xx] == 0
				
					)
					{
						setMovePawnNormallyNotProtectedVars(ra2, yy, xx, yy2, xx);
					}
					
				}
			}
		}
	}
	
	public static function getMoveCaptureUnitNextToKing():Void
	{
		Reg2._random_num.splice(0, Reg2._random_num.length);
		// this number of elements here...
		Reg2._random_num = [2, 3, 4, 5];
		
		// must match the max value here.
		for (i in 2...6)
		{
			_ps = RegFunctions.randomNumberFromArrayElements();
			
			setMoveCaptureUnitNextToKing(_ps, 0, 3);
			
		}
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMoveCaptureUnitNextToKingMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
		{
			/*
			if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}*/
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMoveCaptureUnitNextToKingMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMoveCaptureUnitNextToKingYold[i];
					Reg._gameXXold = Reg._chessMoveCaptureUnitNextToKingXold[i];
					Reg._gameYYnew = Reg._chessMoveCaptureUnitNextToKingYnew[i];
					Reg._gameXXnew = Reg._chessMoveCaptureUnitNextToKingXnew[i];
				
					_phm = true;
				
					break;
				}
			}					
		}
	}
	
	public static function setMoveCaptureUnitNextToKing(p:Int, min:Dynamic, max:Dynamic):Void
	{		
		if (p == 2) Reg._chessForAnotherPieceValue = 1; // this line is needed. its used to generate the future piece.
		else if (p == 3) Reg._chessForAnotherPieceValue = 4;
		else if (p == 4) Reg._chessForAnotherPieceValue = 2;
		else if (p == 5) Reg._chessForAnotherPieceValue = 3;
		else Reg._chessForAnotherPieceValue = 0;
		
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.
		
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// search for a capturing units that the player now moving can take.
					if (p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					|| p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					)
					{
						// create a future piece at that location. this will act as if the rook had moved there. we do this to determine if there is a piece to capture at that future location.
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy][xx] = 17;
						
						// pawn. pawn will be first on the list to attack since pawn has a value of only 1 and is not as important a piece as the last in this function which is a queen.
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5) 
						{							
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx - 1] = 1;
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx + 1] = 1;						
						}
						
						// horse. generate future var for horse.
						else if (p == 3) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, yy, xx);
						
						// future var is not a pawn nor horse.
						else if (p != 1) ChessCapturingUnits.futurePrepareCapturingUnits(1, p, i, yy, xx);
						
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// can move to new location only if that new location is not a capturing unit.
								if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17 && Reg._gamePointValueForPiece[cy][cx] < 11 && Reg._isThisUnitNextToKing[Reg._playerNotMoving][cy][cx] == true			  
								)
								{
									// p_all starts here.
									Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
									var _str_get2:String = ""; var _str2:Array<String> = [];
									var qy:Int = 0; var qx:Int = 0;

									while (Reg._p_all_dynamic2.length > 0)
									{			
										_str_get2 = RegFunctions.pAll2();
										_str2 = _str_get2.split(",");
										
										qy = Std.parseInt(_str2[0]);
										qx = Std.parseInt(_str2[1]);
										
										// can capture unit only if it is empty or only if piece to be captured is not protected.
										if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 
										&&  Reg._futureCapturingUnitsForPiece[Reg._playerNotMoving][p][i][qy][qx] == 0 
										&&  Reg._isThisUnitNextToKing[Reg._playerNotMoving][qy][qx] == true 
										|| Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 
										&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][qy][qx] == 2 
										&&  Reg._gamePointValueForPiece[qy][qx] > 0
	
										&&  Reg._gamePointValueForPiece[qy][qx] < 11
										&&  Reg._isThisUnitNextToKing[Reg._playerNotMoving][qy][qx] == true)
										{
											// p_all starts here.
											Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
											var _str_get1:String = ""; var _str1:Array<String> = [];
											var zy:Int = 0; var zx:Int = 0;
											
											while (Reg._p_all_dynamic1.length > 0)
											{			
												_str_get1 = RegFunctions.pAll1();
												_str1 = _str_get1.split(",");
												
												zy = Std.parseInt(_str1[0]);
												zx = Std.parseInt(_str1[1]);	
											
												if (
			   p == 2 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 17
			|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 17
			|| p == 4 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 17
			|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 17
													)
												
												{
													// move to a unit that can box the king in.
													// we need plus 1 in this condition because kings capturing unit are zero until king is clicked.
													if (Reg._chessKingAsQueen[Reg._playerNotMoving][cy][cx] > 0 
													 && Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] > 0
													 && Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] > Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] + 1
													 ) 
													 setMoveCaptureUnitNextToKingVars(p, zy, zx, cy, cx);
													 					
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
	
	// the order that setMoveCapturePlayerKing is called is not important since sort is called in this function. sorted by queen first followed by lower pieces.
	public static function getMoveCapturePlayerKing():Void
	{
		setMoveCapturePlayerKing(1, 0, 3);
		setMoveCapturePlayerKing(2, 0, 3);
		setMoveCapturePlayerKing(3, 0, 3);
		setMoveCapturePlayerKing(4, 0, 3);
		setMoveCapturePlayerKing(5, 0, 3);
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMoveCapturePlayerKingMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
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
				if (_temp[0] == Reg._chessMoveCapturePlayerKingMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMoveCapturePlayerKingYold[i];
					Reg._gameXXold = Reg._chessMoveCapturePlayerKingXold[i];
					Reg._gameYYnew = Reg._chessMoveCapturePlayerKingYnew[i];
					Reg._gameXXnew = Reg._chessMoveCapturePlayerKingXnew[i];
				
					_phm = true;
				
					break;
				}
			}
		}
	}
	
	public static function setMoveCapturePlayerKing(p:Int, min:Dynamic, max:Dynamic):Void
	{	
		if (p == 2) Reg._chessForAnotherPieceValue = 1; // this line is needed. its used to generate the future piece.
		else if (p == 3) Reg._chessForAnotherPieceValue = 4;
		else if (p == 4) Reg._chessForAnotherPieceValue = 2;
		else if (p == 5) Reg._chessForAnotherPieceValue = 3;
		else Reg._chessForAnotherPieceValue = 0;
		
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.
						
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// search for a capturing units that the player now moving can take.
					if (p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					|| p == 1 && i < 8 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 2 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2 
					&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					||  p == 3 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 1 
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					||  p == 4
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 0
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					||  p == 5 
					&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2
					&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 1
					&& Reg._gamePointValueForPiece[yy][xx] > 0 
					&& Reg._gamePointValueForPiece[yy][xx] < 11
					)
					{
						// create a future piece at that location. this will act as if the rook had moved there. we do this to determine if there is a piece to capture at that future location.
						Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy][xx] = 17;
						
						// pawn. pawn will be first on the list to attack since pawn has a value of only 1 and is not as important a piece as the last in this function which is a queen.
						if (p == 1 && yy < 7 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5) 
						{							
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx - 1] = 1;
							Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][yy + 1][xx + 1] = 1;						
						}
						
						// horse. generate future var for horse.
						else if (p == 3) ChessCapturingUnits.horseFutureCapturingUnits(1, p, i, yy, xx);
						
						// future var is not a pawn nor horse.
						else if (p != 1) ChessCapturingUnits.futurePrepareCapturingUnits(1, p, i, yy, xx);
						
						for (cy in 0...8)
						{
							for (cx in 0...8)
							{
								// can move to new location only if that new location is not a capturing unit.
								if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][cy][cx] == 17 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0	&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2				  
								)
								{
									// p_all starts here.
									Reg._p_all_dynamic2 = Reg._p_all_static2.copy();
									var _str_get2:String = ""; var _str2:Array<String> = [];
									var qy:Int = 0; var qx:Int = 0;

									while (Reg._p_all_dynamic2.length > 0)
									{			
										_str_get2 = RegFunctions.pAll2();
										_str2 = _str_get2.split(",");
										
										qy = Std.parseInt(_str2[0]);
										qx = Std.parseInt(_str2[1]);
										
										if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][p][i][qy][qx] == 1 && Reg._chessKingYcoordinate[Reg._playerNotMoving] == qy && Reg._chessKingXcoordinate[Reg._playerNotMoving] == qx)
										{
											// p_all starts here.
											Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
											var _str_get1:String = ""; var _str1:Array<String> = [];
											var zy:Int = 0; var zx:Int = 0;
											
											while (Reg._p_all_dynamic1.length > 0)
											{			
												_str_get1 = RegFunctions.pAll1();
												_str1 = _str_get1.split(",");
												
												zy = Std.parseInt(_str1[0]);
												zx = Std.parseInt(_str1[1]);	
											
												if (
			   p == 2 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 17
			|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 17
			|| p == 4 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 17
			|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 17
												)
												{
													setMoveCapturePlayerKingVars(p, zy, zx, yy, xx);
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
	
	
	public static function getCapturePieceThatIsNotProtected():Void
	{
		setPieceCaptureProtectionAndNot(1, 0, 3);
		setPieceCaptureProtectionAndNot(2, 0, 3);
		setPieceCaptureProtectionAndNot(3, 0, 3);
		setPieceCaptureProtectionAndNot(4, 0, 3);
		setPieceCaptureProtectionAndNot(5, 0, 3);
		setPieceCaptureProtectionAndNot(6, 0, 3);
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessAbleToCaptureNotProtectedYourP.copy();
					
		if (_temp[0] != -1 && _phm == false) 
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
				if (_temp[0] == Reg._chessAbleToCaptureNotProtectedYourP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessAbleToCaptureNotProtectedYold[i];
					Reg._gameXXold = Reg._chessAbleToCaptureNotProtectedXold[i];
					Reg._gameYYnew = Reg._chessAbleToCaptureNotProtectedYnew[i];
					Reg._gameXXnew = Reg._chessAbleToCaptureNotProtectedXnew[i];
				
					_phm = true;	

					break;
				}
			}
		}
	}	
		
	
	public static function getCapturePieceThatIsProtected():Void
	{
		// i = instance of piece from AI. i value is passed to this function from ChessCPUsAI.
		
		setPieceCaptureProtectionAndNot(1, 3, 100);
		setPieceCaptureProtectionAndNot(2, 3, 100);
		setPieceCaptureProtectionAndNot(3, 3, 100);
		setPieceCaptureProtectionAndNot(4, 3, 100);
		setPieceCaptureProtectionAndNot(5, 3, 100);
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessAbleToCaptureProtectedMyP.copy();

		if (_temp[0] != -1 && _phm == false) 
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
				if (_temp[0] == Reg._chessAbleToCaptureProtectedMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessAbleToCaptureProtectedYold[i];
					Reg._gameXXold = Reg._chessAbleToCaptureProtectedXold[i];
					Reg._gameYYnew = Reg._chessAbleToCaptureProtectedYnew[i];
					Reg._gameXXnew = Reg._chessAbleToCaptureProtectedXnew[i];
					
					_phm = true;	
					
					break;
				}
			}
		}
	}	
	
	// defending piece... min = 3: protected. min = 0: not protected.
	public static function setPieceCaptureProtectionAndNot(p:Int, min:Dynamic = -1, max:Dynamic = -1):Void
	{
		var _n:Int = 2; // added to first loop. piece.
		
		// if pawn then increase the loop;
		if (p == 1) _n = 8; // pawn.
		
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{					
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
					 || p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17      		   
					 || p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17	 
					 || p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17	
					 || p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
					 || p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17)
					{			
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
								
								if (Reg._gamePointValueForPiece[yy+1][xx-1] > 0 && Reg._gamePointValueForPiece[yy+1][xx-1] < 11 && min == 0
								 || Reg._gamePointValueForPiece[yy+1][xx+1] > 0 && Reg._gamePointValueForPiece[yy+1][xx+1] < 11 && min == 0
								)
								{
									if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy+1][xx-1] <= 2)
									{											
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[yy+1][xx-1], yy, xx, yy+1, xx-1);
									}
									
									if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy+1][xx+1] <= 2)
									{											
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[yy+1][xx+1], yy, xx, yy+1, xx+1);
									}
									
									// capturing piece is protected.
									if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy+1][xx-1] > 2)
									{											
										setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[yy+1][xx-1], yy, xx, yy+1, xx-1);
									}
									
									if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy+1][xx+1] > 2)
									{											
										setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[yy+1][xx+1], yy, xx, yy+1, xx+1);
									}
								}	
								
							}
						}
							
						
										
						if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);							
								if (Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 0)									
								{
									if (Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] <= 2)
									{										
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
									}
								}	
								
								else if (Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && p <= Reg._gamePointValueForPiece[zy][zx] && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] > 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 3) 
								{
									setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
								}	
							
							}
						}
											
						if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
						)
						{						
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								if (Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 0)									
								{
									if (Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] <= 2)
									{											
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
									}
								}	
								
								else if (Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && p <= Reg._gamePointValueForPiece[zy][zx] && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] > 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 3) 
								{
									setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
								}	
							}
							
						}
						
						
						if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17
						)
						{						
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								if (Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 0)
								{
									if (Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] <= 2)
									{											
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
									}
									
								}
								
								else if (Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && p <= Reg._gamePointValueForPiece[zy][zx] && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] > 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 3) 
								{
									setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
								}	
							}
						}
						
						if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
						)
						{				
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
								
								if (Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 0)
								{
									if (Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] <= 2)
									{									
										setCaptureNotProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
									}
									
								}	
								
								else if (Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && p <= Reg._gamePointValueForPiece[zy][zx] && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] > 2 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && min == 3) 
								{
									setCaptureProtectedVars(Reg._gameUniqueValueForPiece[yy][xx] + Reg._gamePointValueForPiece[zy][zx], yy, xx, zy, zx);
								}						
							}
						}
							
						if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17
						)
						{				
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
							
								if (Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11)
								{
									if (min == 0 && Reg._capturingUnitsForPieces[Reg._playerMoving][zy][zx] > 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] <= 2)
									{											
										setCaptureNotProtectedVars(p, yy, xx, zy, zx);
									}
									
								}
								
							}
						}
									
						
					}
				}
			}
		}
	}		
	
	// pawn is first to capture pieces. hence, no sort is called at this function.
	public static function getCaptureAnyPiece():Void
	{
		// i = instance of piece from AI. i value is passed to this function from ChessCPUsAI.
		
		setCaptureAnyPiece(1);
		setCaptureAnyPiece(2); 
		setCaptureAnyPiece(3);
		setCaptureAnyPiece(4);
		setCaptureAnyPiece(5);
		
		_ps = 0; // this is needed/
		
		if (RegCustom._game_skill_level_chess < 2)
		{
			var _temp_attack:Dynamic = [-1];
			_temp_attack = Reg._chessCaptureAnyPieceMyP.copy(); // players piece.
		
			// attack		
			if (_temp_attack[0] != -1 && _phm == false) 
			{				
				for (i in 0...65)
				{
					if (_temp_attack[0] == Reg._chessCaptureAnyPieceMyP[i] && _temp_attack[0] != -1)
					{
						Reg._gameYYold = Reg._chessCaptureAnyPieceYold[i];
						Reg._gameXXold = Reg._chessCaptureAnyPieceXold[i];
						Reg._gameYYnew = Reg._chessCaptureAnyPieceYnew[i];
						Reg._gameXXnew = Reg._chessCaptureAnyPieceXnew[i];
					
						_phm = true;
					
						break;
					}
				}		
			}
		}
	}
	
	/**
	 * capture any piece where the computer piece is less in value then the defenders.
	 * @param	p
	 */
	public static function setCaptureAnyPiece(p:Int):Void
	{
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// the player's pieces.
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
										
					|| p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 
					
					|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
					
					)
					{	
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
						)
						{							
							if (p == 1 && Reg._gamePointValueForPiece[yy+1][xx-1] > 0 && Reg._gamePointValueForPiece[yy+1][xx-1] < 11 && Reg._gamePointValueForPiece[yy+1][xx-1] >= p
							)
							{
								setCaptureAnyPieceVars(1, yy, xx, yy+1, xx-1);
							}

							if (p == 1 && Reg._gamePointValueForPiece[yy+1][xx+1] > 0 && Reg._gamePointValueForPiece[yy+1][xx+1] < 11 && Reg._gamePointValueForPiece[yy+1][xx+1] >= p
							)
							{
								setCaptureAnyPieceVars(1, yy, xx, yy+1, xx+1);
							}

						}
						
						if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{		
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);										
								if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] >= p
								|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] < p && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2
								)
								{
									setCaptureAnyPieceVars(2, yy, xx, zy, zx);
								}
							
							}
						}
						
						if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] >= p
								|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] < p && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2
								)
								{
									setCaptureAnyPieceVars(3, yy, xx, zy, zx);
								}
							
							}
						}
						
						if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 4 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] >= p
								|| p == 4 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] < p && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2
								)
								{
									setCaptureAnyPieceVars(4, yy, xx, zy, zx);
								}
							
							}
						}
						
						if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);
								
								if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] >= p
								|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] > 0 && Reg._gamePointValueForPiece[zy][zx] < 11 && Reg._gamePointValueForPiece[zy][zx] < p && Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 2
								)
								{
									setCaptureAnyPieceVars(5, yy, xx, zy, zx);
								}

								
							}
						}
						
						
					}
				}
			}
		}
	}
	
	public static function attackOrDefend():Void
	{
		_ps = 0; // this is needed/
		
		
		// defend.
		var _temp_defend:Dynamic = [-1];		
		_temp_defend = Reg._chessMoveFromAttackerMyP.copy(); // computer piece.
		
		var _temp_attack:Dynamic = [-1];
		_temp_attack = Reg._chessCaptureAnyPieceMyP.copy(); // players piece.
		
		// should we defend computer piece or attack players piece.
		// determine which piece, defender or attacker has the highest piece value.
		// _temp_defend is computer piece. _temp_attack is players piece.
		if (_temp_defend[0] < _temp_attack[0]
		||  _temp_attack[0] == -1)
		{		
			if (_temp_defend[0] != -1 && _phm == false) 
			{
				if (_temp_defend.length > 1)
				{
					haxe.ds.ArraySort.sort(_temp_defend, function(a, b):Int {
						if (a > b) return -1; // change "<" into  ">" for high piece value first.
						else if (a < b) return 1; // change ">" into  "<" for high piece value 
						return 0;
					});
				}
				
				for (i in 0...65)
				{
					if (_temp_defend[0] == Reg._chessMoveFromAttackerMyP[i] && _temp_defend[0] != -1)
					{
						Reg._gameYYold = Reg._chessMoveFromAttackerYold[i];
						Reg._gameXXold = Reg._chessMoveFromAttackerXold[i];
						Reg._gameYYnew = Reg._chessMoveFromAttackerYnew[i];
						Reg._gameXXnew = Reg._chessMoveFromAttackerXnew[i];
					
						_phm = true;
						
						break;
					}
				}		
			}
		}
		
		else 
		{
			// attack		
			if (_temp_attack[0] != -1 && _phm == false) 
			{
				
				for (i in 0...65)
				{
					if (_temp_attack[0] == Reg._chessCaptureAnyPieceMyP[i] && _temp_attack[0] != -1)
					{
						Reg._gameYYold = Reg._chessCaptureAnyPieceYold[i];
						Reg._gameXXold = Reg._chessCaptureAnyPieceXold[i];
						Reg._gameYYnew = Reg._chessCaptureAnyPieceYnew[i];
						Reg._gameXXnew = Reg._chessCaptureAnyPieceXnew[i];
					
						_phm = true;
					
						break;
					}
				}		
			}
		}
		
		
	}
	
	public static function getMovePieceAnywhere():Void
	{
		Reg2._random_num.splice(0, Reg2._random_num.length);
		// this number of elements here...
		Reg2._random_num = [1, 2, 3, 4, 5, 6];
		
		// must match the max value here.
		for (i in 0...6)
		{
			_ps = RegFunctions.randomNumberFromArrayElements();
			
			setMovePieceAnywhere(_ps);
		}	
		
		_ps = 0;
		
		var _temp:Dynamic = [-1];
		
		_temp = Reg._chessMovePieceAnywhereMyP.copy();
		
		if (_temp[0] != -1 && _phm == false) 
		{
			/*if (_temp.length > 1)
			{
				haxe.ds.ArraySort.sort(_temp, function(a, b):Int {
					if (a > b) return -1; // change "<" into  ">" for high piece value first.
					else if (a < b) return 1; // change ">" into  "<" for high piece value 
					return 0;
				});
			}*/
			
			for (i in 0...65)
			{
				if (_temp[0] == Reg._chessMovePieceAnywhereMyP[i] && _temp[0] != -1)
				{
					Reg._gameYYold = Reg._chessMovePieceAnywhereYold[i];
					Reg._gameXXold = Reg._chessMovePieceAnywhereXold[i];
					Reg._gameYYnew = Reg._chessMovePieceAnywhereYnew[i];
					Reg._gameXXnew = Reg._chessMovePieceAnywhereXnew[i];
				
					_phm = true;
				
					break;
				}
			}		
		}
	}
	
	public static function setMovePieceAnywhere(p:Int):Void
	{
		var _found:Bool = false;
		
		for (i in 0...10)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{					
					// the player's pieces.
					if (p == 1 && i < 8 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
										
					|| p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17 
					
					|| p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
					
					|| p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17
					)
					{	
						if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 1 && Reg._chessPawn[Reg._playerMoving][i][zy][zx] == 5 
								&& Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx);
									break;
								}
							}
						
						}
						
						if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 2 && Reg._chessBishop[Reg._playerMoving][i][zy][zx] == 1
								&& Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx);
									break;
								}
							}
						
						}
						
						if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 3 && Reg._chessHorse[Reg._playerMoving][i][zy][zx] == 1 
								&& Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx);
									break;
								}
							}
						
						}
						
						if (p == 4 && Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 4 && Reg._chessRook[Reg._playerMoving][i][zy][zx] == 1 
								&& Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx);
									break;
								}
							}
						}
						
						if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);								
								if (p == 5 && Reg._chessQueen[Reg._playerMoving][i][zy][zx] == 1 
								&& Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx);
									break;
								}
							}

							
						}
						
						if (p == 6 && Reg._chessKing[Reg._playerMoving][yy][xx] == 17
						)
						{
							// p_all starts here.
							Reg._p_all_dynamic1 = Reg._p_all_static1.copy();
							var _str_get1:String = ""; var _str1:Array<String> = [];
							var zy:Int = 0; var zx:Int = 0;
							
							while (Reg._p_all_dynamic1.length > 0)
							{			
								_str_get1 = RegFunctions.pAll1();
								_str1 = _str_get1.split(",");
								
								zy = Std.parseInt(_str1[0]);
								zx = Std.parseInt(_str1[1]);									
								if (p == 6 && Reg._chessKing[Reg._playerMoving][zy][zx] == 1 && Reg._gamePointValueForPiece[zy][zx] == 0
								&& Reg._capturingUnitsForPieces[Reg._playerNotMoving][zy][zx] == 0 
								&& Reg._chessKing[Reg._playerMoving][yy][xx] == 17
								&& _found == false
								)
								{
									_found = true;
									setMovePieceAnywhereVars(1000, yy, xx, zy, zx, 6);
									break;
								}
								
							}
						}
					}
				}
			}
		}
	}
	
			
	/**
	 * returns true if there is the other player's piece at a unit.
	 * @param	p		the piece that is moving. not the unit to check a piece at.
	 * @param	yy		the y coordinate of the unit to check.
	 * @param	xx		the x coordinate...
	 * @return
	 */
	public static function isPieceAtUnitCapture(p:Int, yy:Int, xx:Int):Int
	{
		var _ret:Int = 0;
		var cy = yy;
		var cx = xx;
		
		if (p == 3)
		{
			// top-right1
			if (xx < 7 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx + 1] > 0 && Reg._gamePointValueForPiece[yy - 2][xx + 1] < 11) _ret += 1;
			}
			
			// top-right2
			if (xx < 6 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx + 2] > 0 && Reg._gamePointValueForPiece[yy - 1][xx + 2] < 11) _ret += 1;
			}
						
			// bottom-right1
			if (xx < 7 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx + 1] > 0 && Reg._gamePointValueForPiece[yy + 2][xx + 1] < 11) _ret += 1;
			}
			
			// bottom-right2
			if (xx < 6 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx + 2] > 0 && Reg._gamePointValueForPiece[yy + 1][xx + 2] < 11) _ret += 1;
			}
			
			// top-left1
			if (xx > 0 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx - 1] > 0 && Reg._gamePointValueForPiece[yy - 2][xx - 1] < 11) _ret += 1;
			}
			
			// top-left2
			if (xx > 1 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx - 2] > 0 && Reg._gamePointValueForPiece[yy - 1][xx - 2] < 11) _ret += 1;
			}
						
			// bottom-left1
			if (xx > 0 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx - 1] > 0 && Reg._gamePointValueForPiece[yy + 2][xx - 1] < 11) _ret += 1;
			}
			
			// bottom-left2
			if (xx > 1 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx - 2] > 0 && Reg._gamePointValueForPiece[yy + 1][xx - 2] < 11) _ret += 1;
			}
		}
		
		
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{			
			while (yy - 1 > 0 && xx - 1 > 0) // top-left
			{
				yy -= 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11) 
				
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy > 0 && xx < 7) // top-right
			{
				yy -= 1; xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx < 7) // bottom-right
			{
				yy += 1; xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11) 
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx > 0) // bottom-left
			{
				yy += 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy > 0) // top
			{
				yy -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx < 7) // right
			{
				xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11) 
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy + 1 < 7) // bottom
			{
				yy += 1; 
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx > 0) // left
			{
				xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11) 
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		
		return _ret;
	}
	
	/**
	 * returns true if there is the same color piece at a unit.
	 * @param	p		the piece that is moving. not the unit to check a piece at.
	 * @param	yy		the y coordinate of the unit to check.
	 * @param	xx		the x coordinate...
	 * @return
	 */
	public static function isPieceAtUnitDefend(p:Int, yy:Int, xx:Int):Int
	{
		var _ret:Int = 0;
		var cy = yy;
		var cx = xx;
		
		if (p == 3)
		{
			// top-right1
			if (xx < 7 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx + 1] >= 11)
				{
					_otherPlayersPieceValue = 3;
					_ret += 1;
				}
			}
			
			// top-right2
			if (xx < 6 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx + 2] >= 11)
				{
					
					_ret += 1;
				}
			}
						
			// bottom-right1
			if (xx < 7 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx + 1] >= 11)
				{
					
					_ret += 1;
				}
			}
			
			// bottom-right2
			if (xx < 6 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx + 2] >= 11)
				{
					
					_ret += 1;
				}
			}
			
			// top-left1
			if (xx > 0 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx - 1] >= 11)
				{
					
					_ret += 1;
				}
			}
			
			// top-left2
			if (xx > 1 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx - 2] >= 11)
				{
					
					_ret += 1;
				}
			}
						
			// bottom-left1
			if (xx > 0 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx - 1] >= 11)
				{
					
					_ret += 1;
				}
			}
			
			// bottom-left2
			if (xx > 1 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx - 2] >= 11)
				{
					
					_ret += 1;
				}
			}
		}
		
		
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{			
			while (yy > 0 && xx > 0) // top-left
			{
				yy -= 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy > 0 && xx < 7) // top-right
			{
				yy -= 1; xx += 1;
								
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx < 7) // bottom-right
			{
				yy += 1; xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx > 0) // bottom-left
			{
				yy += 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy > 0) // top
			{
				yy -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx + 1 < 7) // right
			{
				xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy < 7) // bottom
			{
				yy += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx > 0) // left
			{
				xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] >= 11) 
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		
		return _ret;
	}
	
	public static function isPieceAtUnitDefendPawn(p:Int, yy:Int, xx:Int):Int
	{
		var _ret:Int = 0;
		var cy = yy;
		var cx = xx;
		
		if (p == 3)
		{
			// top-right1
			if (xx < 7 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx + 1] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
			
			// top-right2
			if (xx < 6 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx + 2] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
						
			// bottom-right1
			if (xx < 7 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx + 1] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
			
			// bottom-right2
			if (xx < 6 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx + 2] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
			
			// top-left1
			if (xx > 0 && yy > 1)
			{
				if (Reg._gamePointValueForPiece[yy - 2][xx - 1] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
			
			// top-left2
			if (xx > 1 && yy > 0)
			{
				if (Reg._gamePointValueForPiece[yy - 1][xx - 2] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
						
			// bottom-left1
			if (xx > 0 && yy < 6)
			{
				if (Reg._gamePointValueForPiece[yy + 2][xx - 1] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
			
			// bottom-left2
			if (xx > 1 && yy < 7)
			{
				if (Reg._gamePointValueForPiece[yy + 1][xx - 2] == 11 && yy > 4 && yy < 7) _ret += 1;
			}
		}
		
		
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{			
			while (yy > 0 && xx > 0) // top-left
			{
				yy -= 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy > 0 && xx < 7) // top-right
			{
				yy -= 1; xx += 1;
								
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx < 7) // bottom-right
			{
				yy += 1; xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 2 && Reg._chessForAnotherPieceValue == 1 || p == 5 && Reg._chessForAnotherPieceValue == 3) // bishop and queen.
		{
			while (yy < 7 && xx > 0) // bottom-left
			{
				yy += 1; xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy > 0) // top
			{
				yy -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx + 1 < 7) // right
			{
				xx += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (yy < 7) // bottom
			{
				yy += 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7)
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		yy = cy; xx = cx;
		
		if (p == 4 && Reg._chessForAnotherPieceValue == 2 || p == 5 && Reg._chessForAnotherPieceValue == 3) // rook and queen.
		{
			while (xx > 0) // left
			{
				xx -= 1;
				
				if (Reg._gamePointValueForPiece[yy][xx] == 11 && yy > 4 && yy < 7) 
				{
					_ret += 1;
					break;
				}
			}			
		}
		
		
		
		return _ret;
	}
	
	
	public static function setCaptureNotProtectedVars(p:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
			
		for (v in 0...65)
		{
			if (Reg._chessAbleToCaptureNotProtectedMyP[v] == -1) 
			{
				Reg._chessAbleToCaptureNotProtectedMyP[v] = p;									
				Reg._chessAbleToCaptureNotProtectedYold[v] = cy;
				Reg._chessAbleToCaptureNotProtectedXold[v] = cx;
				
				Reg._chessAbleToCaptureNotProtectedYnew[v] = yy;
				Reg._chessAbleToCaptureNotProtectedXnew[v] = xx;								
				Reg._chessAbleToCaptureNotProtectedYourP[v] = Reg._gamePointValueForPiece[yy][xx];
			
				break;
			}
		}
	}
	
	public static function setCaptureProtectedVars(p:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (v in 0...65)
		{
			if (Reg._chessAbleToCaptureProtectedMyP[v] == -1) 
			{
				Reg._chessAbleToCaptureProtectedMyP[v] = p;									
				Reg._chessAbleToCaptureProtectedYold[v] = cy;
				Reg._chessAbleToCaptureProtectedXold[v] = cx;
				
				Reg._chessAbleToCaptureProtectedYnew[v] = yy;
				Reg._chessAbleToCaptureProtectedXnew[v] = xx;								
				Reg._chessAbleToCaptureProtectedYourP[v] = Reg._gamePointValueForPiece[yy][xx];
			
				break;
			}
		}
	}
	
	public static function setMoveDefendNotProtectedVars(p:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		// if this unit is selected to be moved to, don't move back to the same old unit unless piece is captured.
		if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0
		 && yy == Reg._chessCPUdontMoveBackYYold 
		 && xx == Reg._chessCPUdontMoveBackXXold ){}
		else
		{
		
			// save the old move unit.
			Reg._chessCPUdontMoveBackYYold = cy;
			Reg._chessCPUdontMoveBackXXold = cx;
									
			for (v in 0...65)
			{
				if (Reg._chessMovePieceToDefendNotProtectedMyP[v] == -1) 
				{
					Reg._chessMovePieceToDefendNotProtectedMyP[v] = p;									
					Reg._chessMovePieceToDefendNotProtectedYold[v] = cy;
					Reg._chessMovePieceToDefendNotProtectedXold[v] = cx;
					
					Reg._chessMovePieceToDefendNotProtectedYnew[v] = yy;
					Reg._chessMovePieceToDefendNotProtectedXnew[v] = xx;								
					Reg._chessMovePieceToDefendNotProtectedYourP[v] = Reg._gamePointValueForPiece[yy][xx];
				
					break;
				}
			}
		}	
	}
	
	public static function setMoveAttackNotProtectedVars(p:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		// if this unit is selected to be moved to, don't move back to the same old unit unless piece is captured.
		if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0
		 && yy == Reg._chessCPUdontMoveBackYYold 
		 && xx == Reg._chessCPUdontMoveBackXXold ){}
		else
		{
			// save the old move unit.
			Reg._chessCPUdontMoveBackYYold = cy;
			Reg._chessCPUdontMoveBackXXold = cx;
			
			for (v in 0...65)
			{
				if (Reg._chessMovePieceToCaptureNotProtectedMyP[v] == -1) 
				{
					Reg._chessMovePieceToCaptureNotProtectedMyP[v] = p;									
					Reg._chessMovePieceToCaptureNotProtectedYold[v] = cy;
					Reg._chessMovePieceToCaptureNotProtectedXold[v] = cx;
					
					Reg._chessMovePieceToCaptureNotProtectedYnew[v] = yy;
					Reg._chessMovePieceToCaptureNotProtectedXnew[v] = xx;								
					Reg._chessMovePieceToCaptureNotProtectedYourP[v] = Reg._gamePointValueForPiece[yy][xx];
				
					break;
				}
			}
		}	
	}
	
	
	public static function setMovePieceDefendPawnForPromotionSet(p:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (v in 0...65)
		{
			if (Reg._chessMovePieceDefendPawnForPromotionMyP[v] == -1) 
			{
				Reg._chessMovePieceDefendPawnForPromotionMyP[v] = p;									
				Reg._chessMovePieceDefendPawnForPromotionYold[v] = cy;
				Reg._chessMovePieceDefendPawnForPromotionXold[v] = cx;
				
				Reg._chessMovePieceDefendPawnForPromotionYnew[v] = yy;
				Reg._chessMovePieceDefendPawnForPromotionXnew[v] = xx;								
				Reg._chessMovePieceDefendPawnForPromotionYourP[v] = Reg._gamePointValueForPiece[yy][xx];
			
				break;
			}
		}	
	}
	
	public static function setMovePawnToPromoteVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (i in 0...65)
		{
			if (Reg._chessMovePawnToPromoteMyP[i] == -1) 
			{
				Reg._chessMovePawnToPromoteMyP[i] = v;									
				Reg._chessMovePawnToPromoteYold[i] = cy;
				Reg._chessMovePawnToPromoteXold[i] = cx;
				
				Reg._chessMovePawnToPromoteYnew[i] = yy;
				Reg._chessMovePawnToPromoteXnew[i] = xx;								
				Reg._chessMovePawnToPromoteYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	public static function setMovePieceDefendPawnVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (i in 0...65)
		{
			if (Reg._chessMovePieceDefendPawnForPromotionMyP[i] == -1) 
			{
				Reg._chessMovePieceDefendPawnForPromotionMyP[i] = v;									
				Reg._chessMovePieceDefendPawnForPromotionYold[i] = cy;
				Reg._chessMovePieceDefendPawnForPromotionXold[i] = cx;
				
				Reg._chessMovePieceDefendPawnForPromotionYnew[i] = yy;
				Reg._chessMovePieceDefendPawnForPromotionXnew[i] = xx;								
				Reg._chessMovePieceDefendPawnForPromotionYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	
	public static function setMovePawnNormallyNotProtectedVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{		
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (i in 0...65)
		{
			if (Reg._chessMovePawnNormallyNotProtectedMyP[i] == -1) 
			{
				Reg._chessMovePawnNormallyNotProtectedMyP[i] = v;									
				Reg._chessMovePawnNormallyNotProtectedYold[i] = cy;
				Reg._chessMovePawnNormallyNotProtectedXold[i] = cx;
				
				Reg._chessMovePawnNormallyNotProtectedYnew[i] = yy;
				Reg._chessMovePawnNormallyNotProtectedXnew[i] = xx;								
				Reg._chessMovePawnNormallyNotProtectedYourP[i] = Reg._gamePointValueForPiece[yy][xx];

				break;
			}
		}
	}
	
	
	public static function setMoveCaptureUnitNextToKingVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		for (i in 0...65)
		{
			if (Reg._chessMoveCaptureUnitNextToKingMyP[i] == -1) 
			{
				Reg._chessMoveCaptureUnitNextToKingMyP[i] = v;									
				Reg._chessMoveCaptureUnitNextToKingYold[i] = cy;
				Reg._chessMoveCaptureUnitNextToKingXold[i] = cx;
				
				Reg._chessMoveCaptureUnitNextToKingYnew[i] = yy;
				Reg._chessMoveCaptureUnitNextToKingXnew[i] = xx;								
				Reg._chessMoveCaptureUnitNextToKingYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	public static function setMoveCapturePlayerKingVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		for (i in 0...65)
		{
			if (Reg._chessMoveCapturePlayerKingMyP[i] == -1) 
			{
				Reg._chessMoveCapturePlayerKingMyP[i] = v;									
				Reg._chessMoveCapturePlayerKingYold[i] = cy;
				Reg._chessMoveCapturePlayerKingXold[i] = cx;
				
				Reg._chessMoveCapturePlayerKingYnew[i] = yy;
				Reg._chessMoveCapturePlayerKingXnew[i] = xx;								
				Reg._chessMoveCapturePlayerKingYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	
	public static function setMoveAnyPieceDefendKingVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMoveDefendCheck(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		for (i in 0...65)
		{
			if (Reg._chessMoveAnyPieceDefendKingMyP[i] == -1) 
			{
				Reg._chessMoveAnyPieceDefendKingMyP[i] = v;									
				Reg._chessMoveAnyPieceDefendKingYold[i] = cy;
				Reg._chessMoveAnyPieceDefendKingXold[i] = cx;
				
				Reg._chessMoveAnyPieceDefendKingYnew[i] = yy;
				Reg._chessMoveAnyPieceDefendKingXnew[i] = xx;								
				Reg._chessMoveAnyPieceDefendKingYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				_setMyPVar = true;
				break;
			}
		}
		
		moveAnyPieceDefendKing();
	}
	
	
	
	public static function setMoveKingOutOfCheckVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		for (i in 0...65)
		{
			if (Reg._chessMoveKingOutOfCheckMyP[i] == -1) 
			{
				Reg._chessMoveKingOutOfCheckMyP[i] = v;									
				Reg._chessMoveKingOutOfCheckYold[i] = cy;
				Reg._chessMoveKingOutOfCheckXold[i] = cx;
				
				Reg._chessMoveKingOutOfCheckYnew[i] = yy;
				Reg._chessMoveKingOutOfCheckXnew[i] = xx;								
				Reg._chessMoveKingOutOfCheckYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
		
		moveKingOutOfCheck();
	}
	
	public static function setMoveFromAttackerVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// if this unit is selected to be moved to, don't move back to the same old unit unless piece is captured.
		if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0
		 && yy == Reg._chessCPUdontMoveBackYYold 
		 && xx == Reg._chessCPUdontMoveBackXXold ){}
		else
		{		
			// save the old move unit.
			Reg._chessCPUdontMoveBackYYold = cy;
			Reg._chessCPUdontMoveBackXXold = cx;
				
			for (i in 0...65)
			{
				if (Reg._chessMoveFromAttackerMyP[i] == -1) 
				{
					Reg._chessMoveFromAttackerMyP[i] = v;									
					Reg._chessMoveFromAttackerYold[i] = cy;
					Reg._chessMoveFromAttackerXold[i] = cx;
					
					Reg._chessMoveFromAttackerYnew[i] = yy;
					Reg._chessMoveFromAttackerXnew[i] = xx;								
					Reg._chessMoveFromAttackerYourP[i] = Reg._gamePointValueForPiece[yy][xx];
					
					break;
				}
			}
		}
	}
	
	public static function setCaptureAnyPieceVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int):Void
	{
		var _ret = canPieceMove(cy, cx, yy, xx);
		if (_ret == false) return; 
		
		// save the old move unit.
		Reg._chessCPUdontMoveBackYYold = cy;
		Reg._chessCPUdontMoveBackXXold = cx;
		
		for (i in 0...65)
		{
			if (Reg._chessCaptureAnyPieceMyP[i] == -1) 
			{
				Reg._chessCaptureAnyPieceMyP[i] = v;									
				Reg._chessCaptureAnyPieceYold[i] = cy;
				Reg._chessCaptureAnyPieceXold[i] = cx;
				
				Reg._chessCaptureAnyPieceYnew[i] = yy;
				Reg._chessCaptureAnyPieceXnew[i] = xx;								
				Reg._chessCaptureAnyPieceYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	public static function setMovePieceAnywhereVars(v:Int, cy:Int, cx:Int, yy:Int, xx:Int, _p:Int = -1):Void
	{
		if (_p == -1)
		{
			var _ret = canPieceMove(cy, cx, yy, xx);
			if (_ret == false) return; 
			
			// save the old move unit.
			Reg._chessCPUdontMoveBackYYold = cy;
			Reg._chessCPUdontMoveBackXXold = cx;
		}
		
		for (i in 0...65)
		{
			if (Reg._chessMovePieceAnywhereMyP[i] == -1) 
			{
				Reg._chessMovePieceAnywhereMyP[i] = v;									
				Reg._chessMovePieceAnywhereYold[i] = cy;
				Reg._chessMovePieceAnywhereXold[i] = cx;
				
				Reg._chessMovePieceAnywhereYnew[i] = yy;
				Reg._chessMovePieceAnywhereXnew[i] = xx;								
				Reg._chessMovePieceAnywhereYourP[i] = Reg._gamePointValueForPiece[yy][xx];
				
				break;
			}
		}
	}
	
	
	/**
	 * is defender the only piece that blocks the king from check. returns true if piece can move.
	 */
	public static function canPieceMove(yy:Int, xx:Int, zy:Int, zx:Int):Bool
	{
		var _defendersCount:Int = 0; // used to store the total count of the defender pieces on a single path.
		var _pathNumber:Int = -1;
		var _pieceAtPathNumber:Int = 0;
		var _ret:Int = 0; // return statement value.
		
		// how many player's piece defending king.
		for (v in 0...9)
		{
			// piece found at path. determine if piece can move to defend check. piece can only move if there are two or more defending pieces at path.
			if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] > 2 && Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] < 7)
			{
				_pathNumber = v;
								
				for (cy in 0...8)
				{
					for (cx in 0...8)
					{
						// find how many defender's on single path where the piece trying to defend is at.
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][Reg._chessKingYcoordinate[Reg._playerMoving]][Reg._chessKingXcoordinate[Reg._playerMoving]] == _pathNumber 
						&& Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][cy][cx] > 0 
						&& Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 16 
						&& Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v)
						{
							_defendersCount += 1;
						}	
						
						// there is only one defender on path and there is an attacker at that path so enter condition.
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][Reg._chessKingYcoordinate[Reg._playerMoving]][Reg._chessKingXcoordinate[Reg._playerMoving]] == _pathNumber 
						&& Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v
						&& Reg._gamePointValueForPiece[cy][cx] > 0 
						&& Reg._gamePointValueForPiece[cy][cx] < 11 && Reg._gamePointValueForPiece[cy][cx] != 3)
						{
							// piece can move only on same path. see return condition at bottom of this function.
							if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == v 
							&& Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][zy][zx] == v)
			_pieceAtPathNumber = _pathNumber;
							
							_ret = 1; // return statement value.
							break;
							
						}
						
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v && Reg._gamePointValueForPiece[cy][cx] == 0)
						{
							_ret = 2;
							break;
							
						}
						
					}
				}
			}
			
			else if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == 7
			|| Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == 8 
			|| Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == 1
			|| Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == 2)
			{
				var cy:Int = 8; var cx:Int = 8;
				_pathNumber = v;
				
				// search for path in reverse.
				while (--cy >= 0)
				{
					while (--cx >= 0)
					{
						// find how many defender's on single path where the piece trying to defend is at.
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][Reg._chessKingYcoordinate[Reg._playerMoving]][Reg._chessKingXcoordinate[Reg._playerMoving]] ==_pathNumber && Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 16 && Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v)
						{
							_defendersCount += 1;							
						}	
						
						// there is only one defender on path and there is an attacker at that path so enter condition.
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][Reg._chessKingYcoordinate[Reg._playerMoving]][Reg._chessKingXcoordinate[Reg._playerMoving]] ==_pathNumber && Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 && Reg._gamePointValueForPiece[cy][cx] != 3)
						{
							// piece can move only on same path. see return condition at bottom of this function.
							if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] == v && Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][zy][zx] == v)
			_pieceAtPathNumber = _pathNumber;
							
							_ret = 1;
							break;
							
						}
						
						if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][cy][cx] == v && Reg._gamePointValueForPiece[cy][cx] == 0)
						{
							_ret = 2;
							break;
							
						}
						
					}
				}
			}
			
		}
		
		// more than one piece at path when attacked: any defender because no attacker exists at that path: defender not at path.
		if (_defendersCount > 1 && _ret > 0 || _defendersCount == 0 && _ret == 0 || Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pieceAtPathNumber][zy][zx] == _pieceAtPathNumber && _pieceAtPathNumber != 0) return true;
		else return false;
		
		
	}
	
	
	/**
	 * move piece to take king out of check. 
	 */
	public static function canPieceMoveDefendCheck(yy:Int, xx:Int, zy:Int, zx:Int):Bool
	{
		var _def:Int = 0; // used to store the total count of the defender pieces on a single path that is currently blocking the king.
		var _att:Int = 0; // total attackers on the same path as this piece, if any.
		
		var _pathNumber:Int = 0; // current path number where this piece, if any, is at.
					
		
		for (v in 0...9)
		{
			if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][v][yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] > 10)
			{
				_pathNumber = v;
				break;
			}
		}
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// find how many defender's on single path where the piece trying to defend is at.
				if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 16)
				{
					_def += 1;
				}	
			}
		}
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// find how many defender's on single path where the piece trying to defend is at.
				if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][_pathNumber][cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
				{
					_att += 1;
				}	
			}
		}
		
		
		if (_att == 0 || _def > 1 && _att >= 1) return true;
		else return false;
		
		
	}
		
	/******************************
	 * computer move logic. determine what computer piece should be moved.
	 */
	public static function whatPieceShouldBeMoved():Void
	{
		Reg._gameHost = true;
		RegFunctions.is_player_attacker(true);
		
		GameClearVars.clearVarsOnMoveUpdate();
		GameClearVars.clearCheckAndCheckmateVars();

		ChessCapturingUnits.capturingUnits();
				
		RegTriggers._button_show_all_scene_game_room = true;
		
		Reg._gameHost = false;
		RegFunctions.is_player_attacker(false);
		
		ChessCPUsAI.startAI();	
	}
		
	override public function update(elapsed:Float):Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		
		if (_cpuTriggerMovePiece == true)
		{
			// move the computer piece.	
			if (_ticks == 4)
			{
				RegTriggers._button_show_all_scene_game_room = true;
				//_checkmate_loop = 1;				
				
				for (qy in 0...8)
				{
					for (qx in 0...8)
					{
						for (i in 0...2)
						{				
							Reg._capturingUnitsForImages[i][qy][qx] = 0;
							Reg._capturingUnitsForPieces[i][qy][qx] = 0;
						}
					}
				}

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
				
				
				// p is the unit number. at the loop below, p starts at the top-left corner of the gameboard, the xx/yy value of zero, and increments as each unit is looped and moving in the direction of east. when the end of that first row is loop, the next row will be looped and p will still continue to be increased in size.
				var p = -1; // gameboard pieces.
			
				var yy = Reg._gameYYold;
				var xx = Reg._gameXXold;
				
				p = RegFunctions.getP(yy, xx);
				
				Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] -= 1;
				Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] -= 1;
				ChessCurrentUnitClicked.populateCapturingUnits(yy, xx, p);
									
				var yy = Reg._gameYYnew;
				var xx = Reg._gameXXnew;

				var p = RegFunctions.getP(yy, xx);
				
				Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 1;
				Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
				
				
				ChessCurrentUnitClicked.populateCapturingUnits(yy, xx, p);
				
				// no need to search for checkmate the second time.
				
				ChessCurrentUnitClicked._ticksDelay = 0;
				_ticks = 0;
				
				// do not reset this var here. it will be reset at the beginning of each player's turn. 
				//_checkmate_loop = 0;
				_cpuTriggerMovePiece = false;
				_foundPiece = false;
				_phm = false;
				
				// save the old move to var.
				Reg._chessCPUdontMoveBackYYold = Reg._gameYYold;
				Reg._chessCPUdontMoveBackXXold = Reg._gameXXold;
				
			}
			
				
			if (_ticks == 3) // not currently used.
			{					
				_ticks = 4;				
			}
			
			// search for checkmate in 1 and checkmate in 2 if checkmate in 1 is not found. the checkmate in 1 function is at the beginning of checkmate in 2.
			if (_ticks == 2)
			{
				_checkmate_loop = 1;
				
				ChessFindCheckmate.resetVars();					
				
				if (RegCustom._game_skill_level_chess > 0) 
					ChessFindCheckmate.getCheckmate();					
				
				if (Reg._checkmate_break_loop == false)
				{
					Reg._chessCheckmateBypass = false;

					_foundPiece = false;
					_phm = false;
					
					whatPieceShouldBeMoved(); // computer move logic. determine what piece should be moved.
					_ticks = 3;
				}
								
				Reg._chessCheckmateBypass = false;
				Reg._gameMessageCPUthinkingEnded = true; // checkmate search is over so remove thinking message.
			}
			
			if (_ticks == 1) // prepare to search for checkmate.
			{
				//FlxG.mouse.enabled = false; // you can safely comment this line if the compiler barks.
				//FlxG.mouse.visible = false;
				RegTriggers._button_hide_all_scene_game_room = true;				
				if (RegCustom._chess_computer_thinking_enabled == true)
				{
					Reg._messageBoxNoUserInput = "Thinking...";
					Reg._outputMessage = true;
				}
				
				_ticks = 2;
			}		
						
			// is the computer in check?
			if (_ticks == 0)
			{
				_phm = false; _pawnHasMoved = false; 
							
				// computer is in check from one piece...
				if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 1 && _doKingDefendFunctionsOnce == true)
				{
					getMoveAnyPieceDefendKing(); // defend computer king
					getMoveKingOutOfCheck(); // // get computer king out of check.
					
					_doKingDefendFunctionsOnce = false;
				}
				// the computer is in check. if one or more pieces are checking the king then move the piece instead of trying to block one path (that is still a check) by a single attacker's piece.
				else if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] > 1 && _doKingDefendFunctionsOnce == true)
				{
					getMoveKingOutOfCheck();
					_doKingDefendFunctionsOnce = false;
				}
				
				else _ticks = 1;			
			}
			
		}
		
		//if (_cpuTriggerMovePiece == false) _ticks = 0;
		
		super.update(elapsed);
	}
	
	// get the chess points. if points is below a determined value then king will start to move towards other king to try to force checkmate.
	public static function chessPoints():Int
	{
		var _chessPoints:Int = 0;
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				if (Reg._gamePointValueForPiece[y][x] == 11) _chessPoints += 1;
				if (Reg._gamePointValueForPiece[y][x] == 12) _chessPoints += 2;
				if (Reg._gamePointValueForPiece[y][x] == 13) _chessPoints += 3;
				if (Reg._gamePointValueForPiece[y][x] == 14) _chessPoints += 4;
				if (Reg._gamePointValueForPiece[y][x] == 15) _chessPoints += 5;
				
			}
		}
		
		return _chessPoints;
	}


	public static function chessPointsOther():Int
	{
		var _chessPointsOther:Int = 0;
		_isPieceCapturedNotKing = false;
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				if (Reg._gamePointValueForPiece[y][x] == 1) _chessPointsOther += 1;
				if (Reg._gamePointValueForPiece[y][x] == 2) _chessPointsOther += 2;
				if (Reg._gamePointValueForPiece[y][x] == 3) _chessPointsOther += 3;
				if (Reg._gamePointValueForPiece[y][x] == 4) _chessPointsOther += 4;
				if (Reg._gamePointValueForPiece[y][x] == 5) _chessPointsOther += 5;
				
				// is there a CPU piece captured. if true then at the function that called this function will not be able to move king because there is a piece that needs to defend itself.
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][y][x] > 0 && Reg._gamePointValueForPiece[y][x] > 0 && Reg._gamePointValueForPiece[y][x] < 6) _isPieceCapturedNotKing = true; 
			}
		}
		
		return _chessPointsOther;
	}
	
	public static function unitDistanceFromPiece():Void
	{
		var _unitValue:Int = 1;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerNotMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerNotMoving];
			
		// set king to value 1
		if (Reg._unitDistanceFromPiece[yy][xx] > 0) return;
		else Reg._unitDistanceFromPiece[yy][xx] = _unitValue;
				
		// set unit that are around king to value 2.
		_unitValue = 2;
		
		if (yy > 0) // up	
		Reg._unitDistanceFromPiece[yy - 1][xx] = _unitValue;
		if (yy > 0 && xx < 7) // up-right
		Reg._unitDistanceFromPiece[yy - 1][xx + 1] = _unitValue;
		if (xx < 7)	// left	
		Reg._unitDistanceFromPiece[yy][xx + 1] = _unitValue;
		if (yy < 7 && xx < 7) // down-right	
		Reg._unitDistanceFromPiece[yy + 1][xx + 1] = _unitValue;
		if (yy < 7) // down				
		Reg._unitDistanceFromPiece[yy + 1][xx] = _unitValue;
		if (yy < 7 && xx > 0) // down-left	
		Reg._unitDistanceFromPiece[yy + 1][xx - 1] = _unitValue;
		if (xx > 0) // left				
		Reg._unitDistanceFromPiece[yy][xx - 1] = _unitValue;
		if (yy > 0 && xx > 0)	// up-left
		Reg._unitDistanceFromPiece[yy - 1][xx - 1] = _unitValue;
		
		for (i in 0...8)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					if (Reg._unitDistanceFromPiece[y][x] == _unitValue)
					{
						if (y > 0 && Reg._unitDistanceFromPiece[y - 1][x] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // up
						Reg._unitDistanceFromPiece[y - 1][x] = _unitValue + 1;
						
						if (y > 0 && x < 7 && Reg._unitDistanceFromPiece[y - 1][x + 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // up-right
						Reg._unitDistanceFromPiece[y - 1][x + 1] = _unitValue + 1; 					
						if (x < 7 && Reg._unitDistanceFromPiece[y][x + 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue)	// left	
						Reg._unitDistanceFromPiece[y][x + 1] = _unitValue + 1;
						
						if (y < 7 && x < 7 && Reg._unitDistanceFromPiece[y + 1][x + 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // down-right	
						Reg._unitDistanceFromPiece[y + 1][x + 1] = _unitValue + 1;
						
						if (y < 7 && Reg._unitDistanceFromPiece[y + 1][x] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // down				
						Reg._unitDistanceFromPiece[y + 1][x] = _unitValue + 1;
						
						if (y < 7 && x > 0 && Reg._unitDistanceFromPiece[y + 1][x - 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // down-left	
						Reg._unitDistanceFromPiece[y + 1][x - 1] = _unitValue + 1;
						
						if (x > 0 && Reg._unitDistanceFromPiece[y][x - 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue) // left				
						Reg._unitDistanceFromPiece[y][x - 1] = _unitValue + 1;
						
						if (y > 0 && x > 0 && Reg._unitDistanceFromPiece[y - 1][x - 1] == 0 && Reg._unitDistanceFromPiece[y][x] ==  _unitValue)	// up-left
						Reg._unitDistanceFromPiece[y - 1][x - 1] = _unitValue + 1;
					}
				}
			}
			
			_unitValue += 1;
		}
		
		
	}
} // 