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

package modules.games.chess;

/**
 * ...
 * @author kboardgames.com
 */
class ChessCastling
{	
	public static function setCastling():Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
		
		var _found:Bool = false;
		
		// if found that king was in check.
		for (i in 0...8)
		{
			if (Reg._chessOriginOfCheckX[i] != -1
			||	Reg._chessOriginOfCheckY[i] != -1
			) _found = true;
		}
		
		if (_found == true) return;
	 
		// Castling is permissible if and only if all of the following conditions hold true:
		// 1: The king and the chosen rook are on the player's first rank.
		if (Reg._playerMoving == 0)
		{
			// the first array in Reg._chessCastlingDetermine[0] is the player. 0 for host and 1 for other player. the second array is rules. each rule stored as an element. this is rule 1 and at 0 element. the last array: castling at 0 for left side and 1 = right side. 
			Reg._chessCastlingDetermine[0][0][0] = ChessCastling.firstRank(7, Reg._gameYYold, 4, 0, 30, 4);
			Reg._chessCastlingDetermine[0][0][1] = ChessCastling.firstRank(7, Reg._gameYYold, 4, 7, 31, 4);		
		}
		
		else if (Reg._playerMoving == 1)
		{ 
			Reg._chessCastlingDetermine[1][0][0] = ChessCastling.firstRank(0, Reg._gameYYold, 4, 0, 30, 14);
			Reg._chessCastlingDetermine[1][0][1] = ChessCastling.firstRank(0, Reg._gameYYold, 4, 7, 31, 14);		
		}
		
		// 2 Neither the king nor the chosen rook has previously moved.
		if (Reg._playerMoving == 0)
		{
			Reg._chessCastlingDetermine[0][1][0] = Reg._chessCastlingKingHasNotMoved[0];
			Reg._chessCastlingDetermine[0][1][1] = Reg._chessCastlingKingHasNotMoved[0];
		}
		
		else 
		{
			Reg._chessCastlingDetermine[1][1][0] = Reg._chessCastlingKingHasNotMoved[1];
			Reg._chessCastlingDetermine[1][1][1] = Reg._chessCastlingKingHasNotMoved[1];			
		}
		
		// 3: true if there are no pieces between the king and the chosen rook.
		if (Reg._playerMoving == 0)
		{
			Reg._chessCastlingDetermine[0][2][0] = ChessCastling.noPiecesBetweenKingAndRook(7, true, 3, 1, 2);
			Reg._chessCastlingDetermine[0][2][1] = ChessCastling.noPiecesBetweenKingAndRook(7, false, 5, 6, 0);		
		}
		
		else if (Reg._playerMoving == 1)
		{ 
			Reg._chessCastlingDetermine[1][2][0] = ChessCastling.noPiecesBetweenKingAndRook(0, true, 3, 1, 2);
			Reg._chessCastlingDetermine[1][2][1] = ChessCastling.noPiecesBetweenKingAndRook(0, false, 5, 6, 0);
		}
		
		// 4: The king is not currently in check.
		// 5: The king does not pass through a square that is attacked by an enemy piece.
		// 6: The king does not end up in check. (True of any legal move.)
		if (Reg._playerMoving == 0)
		{
			Reg._chessCastlingDetermine[0][3][0] = ChessCastling.castleOutThroughOrIntoCheck(7, Reg._gameYYold, true, 4, 0, 3, 1, 2);
			Reg._chessCastlingDetermine[0][3][1] = ChessCastling.castleOutThroughOrIntoCheck(7, Reg._gameYYold, false, 4, 7, 5, 6, 0);		
		}
		
		else if (Reg._playerMoving == 1)
		{ 
			Reg._chessCastlingDetermine[1][3][0] = ChessCastling.castleOutThroughOrIntoCheck(0, Reg._gameYYold, true, 4, 0, 3, 1, 2);
			Reg._chessCastlingDetermine[1][3][1] = ChessCastling.castleOutThroughOrIntoCheck(0, Reg._gameYYold, false, 4, 7, 5, 6, 0);
		}
		
		
		if (Reg._playerMoving == 0)
		{
			Reg._chessCastlingDetermine[0][4][0] = Reg._chessCastlingRookHasNotMoved[0][0];
			Reg._chessCastlingDetermine[0][4][1] = Reg._chessCastlingRookHasNotMoved[0][1];
		}
		
		else if (Reg._playerMoving == 1)
		{ 
			Reg._chessCastlingDetermine[1][4][0] = Reg._chessCastlingRookHasNotMoved[1][0];
			Reg._chessCastlingDetermine[1][4][1] = Reg._chessCastlingRookHasNotMoved[1][1];
		}
		
		var _left:Int = 0;
		var _right:Int = 0;
		
		if (Reg._playerMoving == 0)
		{		
			for (c in 0...5)
			{
				// if these var = 4 then a castle left / right can be performed.
				if (Reg._chessCastlingDetermine[0][c][0] == true) _left += 1;
				if (Reg._chessCastlingDetermine[0][c][1] == true) _right += 1;
			}
			
			if (_left == 5)
			{
				// TODO do we need += 1?
				Reg._capturingUnitsForPieces[Reg._playerMoving][7][2] += 1;
				Reg._capturingUnitsForImages[Reg._playerMoving][7][2] = 1;
				Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][7][2] = 0;
				Reg._chessIsThisUnitInCheck[Reg._playerMoving][7][2] = 0;
				Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][7][2] = true;
				Reg._chessKingCanCastleHere[7][2] = 1;	
				
				Reg._chessCastling = true;
			}
			if (_right == 5)
			{
				Reg._capturingUnitsForPieces[Reg._playerMoving][7][6] += 1;
				Reg._capturingUnitsForImages[Reg._playerMoving][7][6] += 1;
				Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][7][6] = 0;
				Reg._chessIsThisUnitInCheck[Reg._playerMoving][7][6] = 0;
				Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][7][6] = true;
				Reg._chessKingCanCastleHere[7][6] = 1;	
				
				Reg._chessCastling = true;
			}
		}
		
		else if (Reg._playerMoving == 1)
		{ 		
			for (c in 0...5)
			{
				if (Reg._chessCastlingDetermine[1][c][0] == true) _left += 1;
				if (Reg._chessCastlingDetermine[1][c][1] == true) _right += 1;
			}
			
			if (_left == 5)
			{
				Reg._capturingUnitsForPieces[Reg._playerMoving][0][2] += 1;
				Reg._capturingUnitsForImages[Reg._playerMoving][0][2] = 1;
				Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][0][2] = 0;
				Reg._chessIsThisUnitInCheck[Reg._playerMoving][0][2] = 0;
				Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][0][2] = true;
				Reg._chessKingCanCastleHere[0][2] = 1;	
				
				Reg._chessCastling = true;
			}
			if (_right == 5)
			{
				Reg._capturingUnitsForPieces[Reg._playerMoving][0][6] += 1;
				Reg._capturingUnitsForImages[Reg._playerMoving][0][6] = 1;
				Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][0][6] = 0;
				Reg._chessIsThisUnitInCheck[Reg._playerMoving][0][6] = 0;
				Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][0][6] = true;
				Reg._chessKingCanCastleHere[0][6] = 1;	
				
				Reg._chessCastling = true;
			}
		}
		
	}	
	
	/**
	 * .
	 * @param	yy 				selected piece.
	 * @param	_kingUnit		unit where the king is located.
	 * @param	_leftSide		castling to the left side of king.
	 * @param	_rookUnit		unit where the rook is located.
	 * @param	_rookUnique		unique value of the rook.
	 * @param	_rookPoint		point value of the rook.
	 * @return
	 */
	public static function firstRank(yLocationOfKing:Int, yy:Int, _kingUnit:Int, _rookUnit:Int, _rookUnique:Int, _rookPoint:Int ):Bool
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
		
		// var _leftSide false equals trying to castle to the left side of the king, else _leftSide = true.
		if (Reg._playerMoving == 0 && yy != 7) return false;
		var _king:Int = 0;		
		
		if (Reg._playerMoving == 1 && yy != 0) return false;
		if (Reg._playerMoving == 1) _king = 10;
		
		if (Reg._gameUniqueValueForPiece[yLocationOfKing][_kingUnit] == 50 && Reg._gamePointValueForPiece[yLocationOfKing][_kingUnit] == 6	+ _king
		&&  Reg._gameUniqueValueForPiece[yLocationOfKing][_rookUnit] == _rookUnique && Reg._gamePointValueForPiece[yLocationOfKing][_rookUnit] == _rookPoint) return true;			

		return false;
	}
	
	public static function hasKingMoved():Void
	{
		if (Reg._playerMoving == 0)
		{
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 50 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 6)
			Reg._chessCastlingKingHasNotMoved[0] = false;
		}
		
		if (Reg._playerMoving == 1)
		{
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 50 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 16)
			Reg._chessCastlingKingHasNotMoved[1] = false;
		}

	}
	
	public static function hasRookMoved():Void
	{
		if (Reg._playerMoving == 0)		{
			
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 30
			&&	Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 4)
			Reg._chessCastlingRookHasNotMoved[0][0] = false;
			
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 31
			&&	Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 4)
			Reg._chessCastlingRookHasNotMoved[0][1] = false;
		}
		
		if (Reg._playerMoving == 1)
		{
			// has rook moved. if true then castling cannot be done at that rook side.
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 30
			&&	Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 14)
			Reg._chessCastlingRookHasNotMoved[1][0] = false;
			
			if (Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 31
			&&	Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 14)
			Reg._chessCastlingRookHasNotMoved[1][1] = false;			
		}

	}
	
	/**
	 * 
	 * @param	yLocationOfCastling
	 * @param	yy
	 * @param	_leftSide
	 * @param	_unitNextToKing
	 * @param	_unitNextToRook
	 * @param	_unitBetweenRookAndKing
	 * @return
	 */
	public static function noPiecesBetweenKingAndRook(yLocationOfCastling:Int, _leftSide:Bool, _unitNextToKing:Int, _unitNextToRook:Int, _unitBetweenRookAndKing:Int ):Bool
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
		
		// var _leftSide false equals trying to castle to the left side of the king, else _leftSide = true.
		if (_leftSide == true)
		{
			// if at the first rank, all units that are between the king and rook have no pieces then return true.
			if (Reg._gameUniqueValueForPiece[yLocationOfCastling][_unitNextToRook] == 0 
			&&  Reg._gameUniqueValueForPiece[yLocationOfCastling][_unitBetweenRookAndKing] == 0	
			&&  Reg._gameUniqueValueForPiece[yLocationOfCastling][_unitNextToKing] == 0) return true;
		}
		
		if (_leftSide == false)
		{
			if (Reg._gameUniqueValueForPiece[yLocationOfCastling][_unitNextToRook] == 0 
			&&  Reg._gameUniqueValueForPiece[yLocationOfCastling][_unitNextToKing] == 0) return true;
		}
		
		return false;
	}
	
	/**
	 * 
	 * @param	yLocationOfKing
	 * @param	yy
	 * @param	_leftSide
	 * @param	_kingUnit
	 * @param	_rookUnit
	 * @param	_rookUnique
	 * @param	_rookPoint
	 * @param	_unitNextToKing
	 * @param	_unitNextToRook
	 * @param	_unitBetweenRookAndKing
	 * @return
	 */
	public static function castleOutThroughOrIntoCheck(yLocationOfKing:Int, yy:Int, _leftSide:Bool, _kingUnit:Int, _rookUnit:Int, _unitNextToKing:Int, _unitNextToRook:Int, _unitBetweenRookAndKing:Int ):Bool
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
		
		if (_leftSide == true)
		{
			// if at the first rank, all units that are between the king and rook have no pieces then return true.
			if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_kingUnit] == 0
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_rookUnit] == 0
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_unitNextToRook] == 0 
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_unitBetweenRookAndKing] == 0	
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_unitNextToKing] == 0)
			{
				return true;
			}
		}
		
		else if (_leftSide == false)
		{
			if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_kingUnit] == 0
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_rookUnit] == 0
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_unitNextToRook] == 0 
			&&  Reg._capturingUnitsForPieces[Reg._playerNotMoving][yLocationOfKing][_unitNextToKing] == 0) 
			{
				return true;
			}
		}
		
		return false;
	}
}