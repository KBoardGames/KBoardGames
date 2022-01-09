/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...
 * @author kboardgames.com
 */
class GameClearVars extends PlayState 
{
	/******************************
	 * this function is called after a piece is moved.
	 */
	public static function clearVarsOnMoveUpdate():Void
	{
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
		
		if (Reg._gameId != 1) return;
		
		for (i in 0...2)
		{
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					Reg._chessFuturePathToKing[i][qy][qx] = 0;
				}
			}
		}
		
		// chess vars down here.
		Reg._chessUnitsInCheckTotal[0] = 0;	
		Reg._chessUnitsInCheckTotal[1] = 0;	
		
		Reg._chessStrippedNotationTemp = "";
						
		for (p in 0...2) 
		{
			for (cy in 0...8)
			{
				for (cx in 0...8)
				{													
					if (Reg._game_offline_vs_cpu == false && Reg._game_online_vs_cpu == false )
					{					
						Reg._chessCapturingPathToKing[p][cy][cx] = 0;					 						
						for (d in 0...9) {Reg._chessCurrentPathToKing[p][d][cy][cx] = 0;}
						Reg._chessIsThisUnitInCheck[p][cy][cx] = 0;
						Reg._isThisUnitNextToKing[p][cy][cx] = false;
						// this does not work when commented. the bug is when clicking the king. after the king moved to the unit, when selecting the king again, the previous units that the king moved from, will still highlight.
						Reg._chessKingCanMoveToThisUnit[p][cy][cx] = false;
					}
				}										
			}
		}
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{						
				Reg._chessEnPassantPawnLocationX = 0;
				Reg._chessEnPassantPawnLocationY = 0;
				Reg._unitDistanceFromPiece[cy][cx] = 0;
			}
		}
		
		for (i in 0...10)
		{
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					for (p in 0...2)
					{
						if (i < 8)
						{
							// these must be set to zero or else there will be a shadow copy of the pieces. empty units will be able to capture.
							Reg._chessPawn[p][i][qy][qx] = 0;
							Reg._chessPawnDefenderKing[p][i][qy][qx] = 0;
							Reg._chessPawnAttackerKing[p][i][qy][qx] = 0;
						}
						
						Reg._chessBishop[p][i][qy][qx] = 0;
						Reg._chessBishopDefenderKing[p][i][qy][qx] = 0;
						Reg._chessBishopAttackerKing[p][i][qy][qx] = 0;
												
						Reg._chessHorse[p][i][qy][qx] = 0;
						Reg._chessHorseDefenderKing[p][i][qy][qx] = 0;
						Reg._chessHorseAttackerKing[p][i][qy][qx] = 0;
						
						Reg._chessRook[p][i][qy][qx] = 0;
						Reg._chessRookDefenderKing[p][i][qy][qx] = 0;
						Reg._chessRookAttackerKing[p][i][qy][qx] = 0;
												
						Reg._chessQueen[p][i][qy][qx] = 0;
						Reg._chessQueenDefenderKing[p][i][qy][qx] = 0;
						Reg._chessQueenAttackerKing[p][i][qy][qx] = 0;
												
						Reg._chessKing[p][qy][qx] = 0;
						Reg._chessKingCapturingUnitAsQueen[p][qy][qx] = 0;
						Reg._chessKingAsQueen[p][qy][qx] = 0;
					}
				}
			}
		}	
		
		// clear check/checkmate vars or else they will be double the value the next time we calculate if there is a check or checkmate.
		for (i in 0...2)
		{
			Reg._chessCanTakeOutOfCheck[i] = false;
		}
	}

	/******************************
	 * 
	 */
	public static function clearCheckAndCheckmateVars():Void
	{		
		Reg._doneEnPassant = false;
		Reg._gameDidFirstMove = false;
		Reg._promotePieceLetter = "";
		
		if (Reg._game_offline_vs_cpu == true && Reg._playerMoving == 0)
		{
			for (cy in 0...8)
			{
				for (cx in 0...8)
				{						
					Reg._chessTakeKingOutOfCheckUnits[0][cy][cx] = 0;
				}
			}
			
			Reg._chessUnitsInCheckTotal[0] = 0;
			Reg._chessCanTakeOutOfCheck[0] = false;
			
		}
		
		else if (Reg._game_offline_vs_cpu == true && Reg._playerMoving == 1)
		{
			for (cy in 0...8)
			{
				for (cx in 0...8)
				{						
					Reg._chessTakeKingOutOfCheckUnits[1][cy][cx] = 0;
				}
			}
			
			Reg._chessUnitsInCheckTotal[1] = 0;
			Reg._chessCanTakeOutOfCheck[1] = false;
		}
		
		else
		{
			for (cy in 0...8)
			{
				for (cx in 0...8)
				{						
					Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][cy][cx] = 0;
				}
			}
			
			Reg._chessUnitsInCheckTotal[Reg._playerMoving] = 0;
							
			//------------------------------------------------------------------------
			// clear check/checkmate vars or else they will be double the value the next time we calculate if there is a check or checkmate.
			for (i in 0...2)
			{
				Reg._chessCanTakeOutOfCheck[i] = false;
			}

			//------------------------------------------------------------------------
		}
						
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) Reg._gameMovePiece = true;				

				
	}
	
	
}
