/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.chess;

/**
 * Computer can decide what to do instead of a linear movement.
 * author: kboardgames.com.
 */
class ChessCPUsAI extends ChessMoveCPUsPiece
{
	private static var _ai:Int = 0;
	public static var _ai_function_name:String = "";
	
	public static function startAI():Void 
	{
		logic();
	}
	
	public static function logic():Void 
	{	
		//############################# CALCULATED MOVEMENT
		// _ai function. if for some reason _ai does not have a value other than 0 then a piece in these functions may move at random instance or all pieces at a function may be ignored.
		
		// check if computer king needs defending.
		ChessMoveCPUsPiece.getMoveAnyPieceDefendKing();
		
		// TODO later one day, at ChessMoveCPUsPiece function call "1 Capture any piece" function then call "2 Move from attacker", calculate which piece from those functions have the higher value then execute the most important function. 
		// capture any piece of any point value when that piece is not protected.
		if (RegCustom._game_skill_level_chess == 2)
		{
			if (ChessMoveCPUsPiece._phm == false) 
			{
				trace(1);
				_ai_function_name = "1 attack or defend";
				ChessMoveCPUsPiece.getCaptureAnyPiece();
				ChessMoveCPUsPiece.getMoveFromAttacker();
				ChessMoveCPUsPiece.attackOrDefend();
			}
		}
		
		else
		{
			if (ChessMoveCPUsPiece._phm == false) 
			{
				trace(1);
				_ai_function_name = "1 attack"; 
				ChessMoveCPUsPiece.getCaptureAnyPiece();
			}
			
			if (ChessMoveCPUsPiece._phm == false) 
			{
				trace(2);
				_ai_function_name = "2 defend"; 
				ChessMoveCPUsPiece.getMoveFromAttacker();
			}
		}
		
		// capture a higher point value piece that is protected.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(3);
			_ai_function_name = "3 Capture piece protected"; 
			ChessMoveCPUsPiece.getCapturePieceThatIsProtected();
		}
				
		//#############################
		if (RegCustom._game_skill_level_chess == 2
		&&  ChessMoveCPUsPiece._phm == false) 
		{
			trace(4);
			_ai_function_name = "4 inportant moves";
			importantMoves(); // ################## moves that should be made.
		}
		
		// move to a place, maybe a place that can take two pieces.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(5);
			_ai_function_name = "5 Capture not protected";
			ChessMoveCPUsPiece.getMovePieceToCaptureNotProtected();
		} 
		
		// capture a unit next to the defending king. that capture may or may not put the king into check.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(6);
			_ai_function_name = "6 Capture next to king";
			ChessMoveCPUsPiece.getMoveCaptureUnitNextToKing();
		}
		
		// put king in check.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(7);
			_ai_function_name = "7 Capture king";
			ChessMoveCPUsPiece.getMoveCapturePlayerKing();			
		}
		
		// pawn will try to promote no matter what protection it has. note that it will only move to a unit when its protection at that unit is greater than the attacker.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(8);
			_ai_function_name = "8 Pawn any protection";
			ChessMoveCPUsPiece.getMovePawnToPromoteAnyProtection(0);
		}
				
		// move a pawn to a unit that is not captured by the attacker.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(9);
			_ai_function_name = "9 Pawn not protected";
			ChessMoveCPUsPiece.getMovePawnNormallyNotProtected(0);
		}
		
		// protect the pawn that is near promotion.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(10);
			_ai_function_name = "10 Defend pawn"; 
			ChessMoveCPUsPiece.getMovePieceDefendPawnForPromotion();
		}
		
		// protect another piece that is not protected.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(11);
			_ai_function_name = "11 Defend not protected";
			ChessMoveCPUsPiece.getMovePieceToDefendNotProtected();
		}
		// move any piece anywhere.	
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(12);			
			_ai_function_name = "12 Move piece anywhere";
			ChessMoveCPUsPiece.getMovePieceAnywhere();
		}
			
		// if true then we cannot find a move to make, so re-enter main loop and try again to move piece.
		if (ChessMoveCPUsPiece._phm == false) 
		{
			trace(13);
			
			// piece has not been moved, so re-enter this function saying to move any piece if no piece is moved this time.
			logic();
		} 
	
		else {ChessMoveCPUsPiece._ticks = 4; }
	}
	


	// after game notation and just after _ai var of move number 4, these are moves that the computer should do, such as horse attack rook and king at the same time if queen cannot capture rook, or move pawn 2 units so rook can move.
	public static function importantMoves():Void
	{
		var ra:Int = 0;
		var ra2:Int = 0;
		
		ra = FlxG.random.int(0, 2);
		ra2 = FlxG.random.int(0, 5);
		
		if (ra == 2)
		{	
			// left side horse can put king into check at maybe capture rook at the same time.
			if (ra2 == 0)
			{
				if (Reg._gamePointValueForPiece[4][1] == 13 && Reg._gamePointValueForPiece[6][2] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][6][2] == 0
				   && Reg._gamePointValueForPiece[7][0] == 4 && Reg._gamePointValueForPiece[7][4] == 6)
				{
					Reg._gameYYold = 4;
					Reg._gameXXold = 1;
					Reg._gameYYnew = 6;
					Reg._gameXXnew = 2;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
			// left side horse can put king into check at maybe capture rook at the same time.
			if (ra2 == 1)
			{
				if (Reg._gamePointValueForPiece[4][3] == 13 && Reg._gamePointValueForPiece[6][2] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][6][2] == 0
				&& Reg._gamePointValueForPiece[7][0] == 4 && Reg._gamePointValueForPiece[7][4] == 6)
				{
					Reg._gameYYold = 4;
					Reg._gameXXold = 3;
					Reg._gameYYnew = 6;
					Reg._gameXXnew = 2;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
			// right side horse can put king into check at maybe capture rook at the same time.
			if (ra2 == 2)
			{
				if (Reg._gamePointValueForPiece[4][4] == 13 && Reg._gamePointValueForPiece[6][5] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][6][5] == 0
				&& Reg._gamePointValueForPiece[7][7] == 4 && Reg._gamePointValueForPiece[7][4] == 6)
				{
					Reg._gameYYold = 4;
					Reg._gameXXold = 4;
					Reg._gameYYnew = 6;
					Reg._gameXXnew = 5;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
			// right side horse can put king into check at maybe capture rook at the same time.
			if (ra2 == 3)
			{
				if (Reg._gamePointValueForPiece[4][6] == 13 && Reg._gamePointValueForPiece[6][5] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][6][5] == 0
				&& Reg._gamePointValueForPiece[7][7] == 4 && Reg._gamePointValueForPiece[7][4] == 6)
				{
					Reg._gameYYold = 4;
					Reg._gameXXold = 6;
					Reg._gameYYnew = 6;
					Reg._gameXXnew = 5;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
			// move first pawn
			if (ra2 == 4)
			{
				if (Reg._gamePointValueForPiece[1][0] == 11 && Reg._gamePointValueForPiece[2][0] == 0 && Reg._gamePointValueForPiece[3][0] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][3][0] == 0)
				{
					Reg._gameYYold = 1;
					Reg._gameXXold = 0;
					Reg._gameYYnew = 3;
					Reg._gameXXnew = 0;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
			// move last pawn.
			if (ra2 == 5)
			{
				if (Reg._gamePointValueForPiece[1][7] == 11 && Reg._gamePointValueForPiece[2][7] == 0 && Reg._gamePointValueForPiece[3][7] < 11 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][3][7] == 0)
				{
					Reg._gameYYold = 1;
					Reg._gameXXold = 7;
					Reg._gameYYnew = 3;
					Reg._gameXXnew = 7;
							
					ChessMoveCPUsPiece._phm = true;
				}
			}
			
		}
	}
	
	override public function destroy()
	{
		_ai = 0;
		super.destroy();
	}
}