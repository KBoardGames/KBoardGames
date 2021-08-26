package;

/**
 * ...
 * @author kboardgames.com
 */
class ChessEnPassant
{	
	public static function isThisMoveAnEnPassant():Void
	{
		if (Reg._playerCanMovePiece == false) return;
		
		Reg._triggerNextStuffToDo = 0;
		
		// piece has been moved. therefore, check if pawn En passant.
		if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 9
		|| Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 9) 
		{
			Reg._chessEnPassantPawnNumber[Reg._playerMoving] = Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
			
		
			
			Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._chessEnPassantPawnNumber[Reg._playerMoving]] += 1;
			Reg._triggerNextStuffToDo = Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._chessEnPassantPawnNumber[Reg._playerMoving]];

			// in passing only if the pawn had moved 2 units in 1 move. if conditions are true then set the pawn as En passant. En passant is possible if player had moved the pawn two units from start possible.
			
			// check that the pawn had only moved once...
			if (Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._chessEnPassantPawnNumber[Reg._playerMoving]] == 1)
			{
				// ... and that the pawn is positioned two units from start.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1 && Reg._gameYYnew == 4 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11 && Reg._gameYYnew == 3) 
				{
					Reg._isEnPassant = true;					
				}
				
				else
				{
					Reg._isEnPassant = false;
				}
				
			}
		}
	}
		
	public static function getVarsFromOtherPlayer():Void
	{
		if (Reg._gameYYold > -1 && Reg._gameXXold > -1)
		{
			// this is used for the En passant. we need the other users coordinates not ours.
			Reg._gameOtherPlayerXnew = Reg._gameXXnew;
			Reg._gameOtherPlayerYnew = Reg._gameYYnew;
		
			if (Reg._triggerNextStuffToDo > 0) Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._chessEnPassantPawnNumber[Reg._playerMoving]] += 1;			
		}
	}
	
	public static function enPassantpawnCapturingUnitsForImages(cy:Int, cx:Int):Void
	{			
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[cy][cx] == 1 || Reg._gameHost == false && Reg._gamePointValueForPiece[cy][cx] == 11)
		{
			if (Reg._gameHost == true)
			{
				//-------------------------------------------------
				// En passant. pawn moving up.
				if (cx > 0)
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 3 && Reg._gamePointValueForPiece[cy][cx - 1] == 11 && Reg._gamePointValueForPiece[cy - 1][cx - 1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx - 1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessEnPassantPawnLocationX = cx - 1; // this is used to remove the pawn after En passant is done.
						Reg._chessEnPassantPawnLocationY = cy;
						
						Reg._capturingUnitsForImages[Reg._playerMoving][cy-1][cx-1] = 1;
					}
				}
				if (cx < 7) // pawn moving up.
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 3 && Reg._gamePointValueForPiece[cy][cx + 1] == 11 && Reg._gamePointValueForPiece[cy - 1][cx + 1] == 0 && Reg._isEnPassant == true &&  Reg._gameUniqueValueForPiece[cy][cx + 1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessEnPassantPawnLocationX = cx + 1;
						Reg._chessEnPassantPawnLocationY = cy;
						Reg._capturingUnitsForImages[Reg._playerMoving][cy-1][cx+1] = 1;
					}
				}
				
				//-------------------------------------------
			}
			
			else
			{
				//-----------------------------------------------
				if (cx > 0) // En passant. pawn moving down.
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 4 && Reg._gamePointValueForPiece[cy][cx - 1] == 1 && Reg._gamePointValueForPiece[cy + 1][cx - 1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx - 1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessEnPassantPawnLocationX = cx - 1;
						Reg._chessEnPassantPawnLocationY = cy;
						Reg._capturingUnitsForImages[Reg._playerMoving][cy+1][cx-1] = 1;
					}
				}
				if (cx < 7) // pawn moving down.
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 4 && Reg._gamePointValueForPiece[cy][cx + 1] == 1 && Reg._gamePointValueForPiece[cy + 1][cx + 1] == 0 && Reg._isEnPassant == true &&  Reg._gameUniqueValueForPiece[cy][cx + 1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessEnPassantPawnLocationX = cx + 1;
						Reg._chessEnPassantPawnLocationY = cy;
						Reg._capturingUnitsForImages[Reg._playerMoving][cy+1][cx+1] = 1;
					}
				}
				//-----------------------------------------------
				
			}
		}
	}
	
	public static function enPassantpawnCapturingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] == 1 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] == 11)
		{
			if (Reg._playerMoving == 0)
			{
				//-------------------------------------------------
				// En passant. pawn moving up.
				if (cx > 0)
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 3 && Reg._gamePointValueForPiece[cy][cx - 1] == 11 && Reg._gamePointValueForPiece[cy-1][cx-1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx-1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving]) 
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy-1][cx-1] = 2;
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy-1][cx-1] += 1;
					}
				}
				if (cx < 7) // pawn moving up.
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 3 && Reg._gamePointValueForPiece[cy][cx + 1] == 11 && Reg._gamePointValueForPiece[cy-1][cx+1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx+1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy-1][cx+1] = 8;
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy-1][cx+1] += 1;
					}
				}
				
				//-----------------------------------------------
			}			
			
			else
			{
				//------------------------------------------------
				// En passant. pawn moving down.
				if (cx > 0)
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 4 && Reg._gamePointValueForPiece[cy][cx - 1] == 1 && Reg._gamePointValueForPiece[cy+1][cx-1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx-1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving]) 
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy+1][cx-1] = 6;
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy+1][cx-1] += 1;
					}
				}
				
				if (cx < 7) // pawn moving down.
				{
					if (Reg._triggerNextStuffToDo == 1 && cy == 4 && Reg._gamePointValueForPiece[cy][cx + 1] == 1 && Reg._gamePointValueForPiece[cy+1][cx+1] == 0 && Reg._isEnPassant == true && Reg._gameUniqueValueForPiece[cy][cx+1] == Reg._chessEnPassantPawnNumber[Reg._playerNotMoving])
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy+1][cx+1] = 4;
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy+1][cx+1] += 1;
					}
				}
				//------------------------------------------------
			}
		}
	}

	public static function doneEnPassant():Void
	{
		Reg._doneEnPassant = true;
	}
}