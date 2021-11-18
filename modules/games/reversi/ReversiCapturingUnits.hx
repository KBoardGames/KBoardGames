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

package modules.games.reversi;

/**
 * ...
 * @author kboardgames.com
 */
class ReversiCapturingUnits
{
	/**
	 * this function redirects to a function that will find all capturing units on board. 
	 */
	public static function capturingUnits():Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		// value for the player not moving.
		if (Reg._playerMoving == 0) Reg._pieceNumber = 11;
		else Reg._pieceNumber = 1;
		
		if (Reg._triggerNextStuffToDo <= 3)
		{	
			// game started. highlight units so that players can place the four pieces on board. we are here. so a unit was clicked. if true then a piece can be added to the board.
			if (Reg._gamePointValueForPiece[3][3] == 0)
			Reg._capturingUnitsForPieces[Reg._playerMoving][3][3] = 1;
			else Reg._capturingUnitsForPieces[Reg._playerMoving][3][3] = 0;
			
			if (Reg._gamePointValueForPiece[3][4] == 0)
			Reg._capturingUnitsForPieces[Reg._playerMoving][3][4] = 1;
			else Reg._capturingUnitsForPieces[Reg._playerMoving][3][4] = 0;
			
			if (Reg._gamePointValueForPiece[4][3] == 0)
			Reg._capturingUnitsForPieces[Reg._playerMoving][4][3] = 1;	
			else Reg._capturingUnitsForPieces[Reg._playerMoving][4][3] = 0;
			
			if (Reg._gamePointValueForPiece[4][4] == 0)
			Reg._capturingUnitsForPieces[Reg._playerMoving][4][4] = 1;
			else Reg._capturingUnitsForPieces[Reg._playerMoving][4][4] = 0;
		}
		else locationsPieceCanMove(Reg._pieceNumber, Reg._playerMoving); // the player moving.
	
	}
	
	//#############################  LOCATIONS PIECE CAN MOVE
	/******************************
	 * this function finds all capturing units on board.
	 */
	public static function locationsPieceCanMove(_pieceNumber:Int, _playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		Reg._pieceNumber = _pieceNumber;
		
		// the player moving.
		var _pieceNumber2:Int = 1;
		if (_pieceNumber == 1) _pieceNumber2 = 11;
		
		if (Reg._reversiReverseIt == true)
		{
			if (Reg._playerMoving == 0) Reg._playerMoving = 1;
			else Reg._playerMoving = 0;
			
			if (Reg._playerNotMoving == 0) Reg._playerNotMoving = 1;
			else Reg._playerNotMoving = 0;
			
			if (_pieceNumber == 11)
			{
				_pieceNumber = 1;
				_pieceNumber2 = 11;
			}
			else if (_pieceNumber == 1)
			{
				_pieceNumber = 11;
				_pieceNumber2 = 1;
			}
		}
		
		// ################################### NORTH #################################
		var yy:Int = 8;
		
		// this code searches in reverse. starting at the button of the board and decreasing in yy value.
		while (--yy >= 0)
		{
			for (xx in 0...8)
			{
				var cy:Int = yy;

				// if a player's piece is found then enter the loop.
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{
					while (cy > 0)
					{
						// search N...
						
						// ...for other player's piece.
						if (Reg._gamePointValueForPiece[cy - 1][xx] == Reg._pieceNumber)
						{
							if (cy - 2 >= 0)
							{
								// ... then decrease cy again to search for an empty piece. if instead an empty piece is found then that unit will be a capturing unit.
								if (Reg._gamePointValueForPiece[cy - 2][xx] == 0)
								{
									// empty piece is now the players capturing piece.
									Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 2][xx] = 1;											
								}
								
							}
							
						  // another player's moving piece is found so break out of while loop so that no capturing units will be set for this direction.						  
						} else break;
						
						cy -= 1;
					}					
				}
			}
		}
		
		//############################# NORTH EAST
		
		var yy:Int = 7;
		
		while (yy > 0)
		{			
			for (xx in 0...8)
			{
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{					
					var cy:Int = yy;
					var cx:Int = xx;
					
					while (cy > 0 && cx < 7)
					{						
						// search NE...
												
						// ...for other player's piece.
						if (Reg._gamePointValueForPiece[cy - 1][cx + 1] == Reg._pieceNumber)
						{								
							if (cy - 2 >= 0 && cx + 2 <= 7)
							{
								// ... then search in reverse for an empty piece.
								if (Reg._gamePointValueForPiece[cy - 2][cx + 2] == 0)
								{
									// empty piece is now the players capturing piece.						
									Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 2][cx + 2] = 1;
								}
							}
							
						} else break;

						
						if (cy > 0) cy -= 1;
						if (cx < 7) cx += 1;					
					}					
				}		
			}
			
			if (yy > 0) yy -= 1;
		}
		
		
		// ############################## East ######################################
		// this will set a value of 1, a highlighted unit, where a Reversi piece can be moved.	 
		
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{				
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				 {
					for (cx in xx...8)
					{
						// search E...
						if (cx < 7)
						{
							// ...for other player's piece.
							if (Reg._gamePointValueForPiece[yy][cx + 1] == Reg._pieceNumber)
							{
								if (cx + 2 <= 7)
								{
									// ... then search in reverse for an empty piece.
									if (Reg._gamePointValueForPiece[yy][cx + 2] == 0)
									{
										// empty piece is now the players capturing piece.
										Reg._capturingUnitsForPieces[Reg._playerMoving][yy][cx + 2] = 1;
									}
								}
								
							} else break;
						}
					}
					
				}
			}
		}	
		
		//############################# SOUTH EAST
				
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{
					var cy:Int = yy;
					var cx:Int = xx;
					
					// search SE...
					while (cy < 7 && xx < 7)
					{		
						// ...for other player's piece.
						if (Reg._gamePointValueForPiece[cy + 1][cx + 1] == Reg._pieceNumber)
						{								
							if (cy + 2 <= 7 && cx + 2 <= 7)
							{
								// ... then search in reverse for an empty piece.
								if (Reg._gamePointValueForPiece[cy + 2][cx + 2] == 0)
								{
									// empty piece is now the players capturing piece.						
									Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 2][cx + 2] = 1;
								}
							}
							
						} else break;
						
						if (cy < 7) cy += 1;
						if (cx < 7) cx += 1;
						
					}					
				}				
			}
		}	
		
		// ################################# SOUTH  #################################
		
		for (xx in 0...8)
		{
			for (yy in 0...8)
			{
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				 {
					for (cy in yy...8)
					{
						// search S...
						if (cy < 7)
						{
							// ...for other player's piece.
							if (Reg._gamePointValueForPiece[cy + 1][xx] == Reg._pieceNumber)
							{
								if (cy + 2 <= 7)
								{
									// ... then search in reverse for an empty piece.
									if (Reg._gamePointValueForPiece[cy + 2][xx] == 0)
									{
										// empty piece is now the players capturing piece.
										Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 2][xx] = 1;
									}
								}
								
							} else break;
						}
					}
					
						
				}
			}
		}	
			
		//############################# SOUTH WEST
		
		for (yy in 0...8)
		{
			var xx:Int = 7;
			
			while (xx > 0)
			{
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{					
					var cy:Int = yy;
					var cx:Int = xx;
					
					while (cy < 7 && cx > 0)
					{						
						// search SW...
						
						// ...for other player's piece.
						if (Reg._gamePointValueForPiece[cy + 1][cx - 1] == Reg._pieceNumber)
						{								
							if (cy + 2 <= 7 && cx - 2 >= 0)
							{
								// ... then search in reverse for an empty piece.
								if (Reg._gamePointValueForPiece[cy + 2][cx - 2] == 0)
								{
									// empty piece is now the players capturing piece.						
									Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 2][cx - 2] = 1;
								}
							}
							
						} else break;
													
						if (cy < 7) cy += 1;
						if (cx > 0) cx -= 1;						
					}
				}
				
				if (xx > 0) xx -= 1;
				
			}
		}	
		
		
		// ################################### WEST #################################
		
		var xx:Int = 8;
		
		while (--xx >= 0)
		{
			for (yy in 0...8)
			{
				var cx:Int = xx;

				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{
					while (cx > 0)
					{
						// search W...
						
						// ...for other player's piece.						
						if (Reg._gamePointValueForPiece[yy][cx - 1] == Reg._pieceNumber)
						{
							if (cx - 2 >= 0)
							{
								// ... then search in reverse for an empty piece.
								if (Reg._gamePointValueForPiece[yy][cx - 2] == 0)
								{
									// empty piece is now the players capturing piece.
									Reg._capturingUnitsForPieces[Reg._playerMoving][yy][cx - 2] = 1;
								}
							}
							
						} else break;
						
						cx -= 1;
					}
					
				}
			}
		}	
				
		//############################# NORTH WEST
		
		var yy:Int = 7;
		
		while (yy > 0)
		{			
			var xx:Int = 7;
			
			while (xx > 0)
			{
				if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 10
				 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3)
				{					
					var cy:Int = yy;
					var cx:Int = xx;
					
					while (cy > 0 && cx > 0)
					{						
						// search NE...
												
						// ...for other player's piece.
						if (Reg._gamePointValueForPiece[cy - 1][cx - 1] == Reg._pieceNumber)
						{								
							if (cy - 2 >= 0 && cx - 2 >= 0)
							{
								// ... then search in reverse for an empty piece.
								if (Reg._gamePointValueForPiece[cy - 2][cx - 2] == 0)
								{
									// empty piece is now the players capturing piece.						
									Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 2][cx - 2] = 1;
								}
							}
							
						} else break;

						
						if (cy > 0) cy -= 1;
						if (cx > 0) cx -= 1;					
					}					
				}	
				if (xx > 0) xx -= 1;
			}
			
			if (yy > 0) yy -= 1;
		}
		
		
		
		
		
		
		
		
	}	
	
	public static function findCapturingUnits():Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		if (Reg._playerMoving == 0) Reg._pieceNumber = 11;
		else Reg._pieceNumber = 1;
		
		captureThePieces(Reg._pieceNumber, Reg._playerMoving); // the player moving.
	
	}
	
	//#############################  LOCATIONS PIECE CAN MOVE
	/******************************
	 * this function finds all capturing units on board. the moving player will find its capturing units.
	 */
	public static function captureThePieces(_pieceNumber:Int, _playerMoving:Int):Void
	{
		var _pieceNumber2:Int = 1; // moving player.
		if (_pieceNumber == 1) _pieceNumber2 = 11;
		
		if (Reg._reversiReverseIt == true)
		{
			if (Reg._playerMoving == 0) Reg._playerMoving = 1;
			else Reg._playerMoving = 0;
			
			if (Reg._playerNotMoving == 0) Reg._playerNotMoving = 1;
			else Reg._playerNotMoving = 0;
			
			if (_pieceNumber == 11)
			{
				_pieceNumber = 1;
				_pieceNumber2 = 11;
			}
			else if (_pieceNumber == 1)
			{
				_pieceNumber = 11;
				_pieceNumber2 = 1;
			}
		}
		// ################################### NORTH #################################
		
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			var yy2:Int = Reg._gameYYold - 1;
			
			Reg._reversiGamePointValueForPiece[1][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[1][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (xx in Reg._gameXXold...8)
			{
				while (yy >= 0)
				{				
					if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == _pieceNumber2) 
					{
						_found = true;
					}
										
					else if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == 0 && _found == false) 
					{
						// set vars to back to default because there are no Reversi here.
						while (yy2 >= 0)
						{
							//Reg._reversiGamePointValueForPiece[1][Reg._gameYYold][xx2] = _pieceNumber;
							Reg._reversiCapturingUnitsForPieces[1][yy2][Reg._gameXXold] = 0;
						
							yy2 -= 1;
						}
						
						if (_found == false) _empty = true;
						break;
					}

					else 
					if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == _pieceNumber && _found == false)
					{
						Reg._reversiGamePointValueForPiece[1][yy][Reg._gameXXold] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[1][yy][Reg._gameXXold] = 2;
						
						_piece = true;
					}				
					
					yy -= 1;
				}				
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (xx in Reg._gameXXold...8)
			{
				while (yy >= 0)
				{
					if (Reg._reversiGamePointValueForPiece[1][yy][xx] > 0)
					{
						Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
					}
					
					yy -= 1;
				}
			}
		}
		
		//############################## NORTH EAST
				
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			var xx:Int = Reg._gameXXold - 1;
			var yy2:Int = Reg._gameYYold + 1;
			var xx2:Int = Reg._gameXXold - 1;
			
			Reg._reversiGamePointValueForPiece[2][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[2][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy <= 7 && xx >= 0)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber2) 
				{
					_found = true;
				}
				
				else if (Reg._gamePointValueForPiece[yy][xx] == 0 && _found == false) 
				{
					// set vars to back to default because there are no Reversi here.
					while (yy2 <= 7 && xx2 >= 0)
					{
						//Reg._reversiGamePointValueForPiece[2][yy2][xx2] = 0;
						Reg._reversiCapturingUnitsForPieces[2][yy2][xx2] = 0;
					
						xx2 -= 1;
						yy2 += 1;
					}
					
					if (_found == false) _empty = true;
					break;
				}

				else 
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber && _found == false)
				{
					Reg._reversiGamePointValueForPiece[2][yy][xx] = _pieceNumber;
					Reg._reversiCapturingUnitsForPieces[2][yy][xx] = 2;
					
					_piece = true;
				}				
				
				xx -= 1;
				yy += 1;
			}
		
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			var xx:Int = Reg._gameXXold - 1;
		
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy <= 7 && xx >= 0)
			{
				if (Reg._reversiGamePointValueForPiece[2][yy][xx] > 0)
				{
					Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
				}
				
				xx -= 1;
				yy += 1;
			}
		}
		
		//############################# EAST
	
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var xx:Int = Reg._gameXXold - 1;
			var xx2:Int = Reg._gameXXold - 1;
			
			Reg._reversiGamePointValueForPiece[3][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[3][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (yy in Reg._gameYYold...8)
			{
				while (xx >= 0)
				{				
					if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == _pieceNumber2) 
					{
						_found = true;
					}
										
					else if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == 0 && _found == false) 
					{
						// set vars to back to default because there are no Reversi here.
						while (xx2 >= 0)
						{
							//Reg._reversiGamePointValueForPiece[3][Reg._gameYYold][xx2] = _pieceNumber;
							Reg._reversiCapturingUnitsForPieces[3][Reg._gameYYold][xx2] = 0;
						
							xx2 -= 1;
						}
						
						if (_found == false) _empty = true;
						break;
					}

					else 
					if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == _pieceNumber && _found == false)
					{
						Reg._reversiGamePointValueForPiece[3][Reg._gameYYold][xx] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[3][Reg._gameYYold][xx] = 2;
						
						_piece = true;
					}				
					
					xx -= 1;
				}				
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var xx:Int = Reg._gameXXold - 1;
			
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (yy in Reg._gameYYold...8)
			{
				while (xx >= 0)
				{
					if (Reg._reversiGamePointValueForPiece[3][yy][xx] > 0)
					{
						Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
					}
					
					xx -= 1;
				}
			}
		}
		
		//############################# SOUTH EAST
				
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			var xx:Int = Reg._gameXXold - 1;
			var yy2:Int = Reg._gameYYold - 1;
			var xx2:Int = Reg._gameXXold - 1;
			
			Reg._reversiGamePointValueForPiece[4][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[4][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy >= 0 && xx >= 0)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber2) 
				{
					_found = true;
				}
				
				else if (Reg._gamePointValueForPiece[yy][xx] == 0 && _found == false) 
				{
					// set vars to back to default because there are no Reversi here.
					while (yy2 >= 0 && xx2 >= 0)
					{
						//Reg._reversiGamePointValueForPiece[4][yy2][xx2] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[4][yy2][xx2] = 0;
					
						xx2 -= 1;
						yy2 -= 1;
					}
					
					if (_found == false) _empty = true;
					break;
				}

				else 
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber && _found == false)
				{
					Reg._reversiGamePointValueForPiece[4][yy][xx] = _pieceNumber;
					Reg._reversiCapturingUnitsForPieces[4][yy][xx] = 2;
					
					_piece = true;
				}				
				
				xx -= 1;
				yy -= 1;
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			var xx:Int = Reg._gameXXold - 1;
		
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy >= 0 && xx >= 0)
			{
				if (Reg._reversiGamePointValueForPiece[4][yy][xx] > 0)
				{
					Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
				}
				
				xx -= 1;
				yy -= 1;
			}
		}
		// ################################# SOUTH  #################################
			
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			var yy2:Int = Reg._gameYYold + 1;
			
			Reg._reversiGamePointValueForPiece[5][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[5][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (xx in Reg._gameXXold...8)
			{
				while (yy <= 7)
				{				
					if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == _pieceNumber2) 
					{
						_found = true;
					}
										
					else if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == 0 && _found == false) 
					{
						// set vars to back to default because there are no Reversi here.
						while (yy2 <= 7)
						{
							//Reg._reversiGamePointValueForPiece[3][Reg._gameYYold][xx2] = _pieceNumber;
							Reg._reversiCapturingUnitsForPieces[5][yy2][Reg._gameXXold] = 0;
						
							yy2 += 1;
						}
						
						if (_found == false) _empty = true;
						break;
					}

					else 
					if (Reg._gamePointValueForPiece[yy][Reg._gameXXold] == _pieceNumber && _found == false)
					{
						Reg._reversiGamePointValueForPiece[5][yy][Reg._gameXXold] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[5][yy][Reg._gameXXold] = 2;
						
						_piece = true;
					}				
					
					yy += 1;
				}				
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (xx in Reg._gameXXold...8)
			{
				while (yy <= 7)
				{
					if (Reg._reversiGamePointValueForPiece[5][yy][xx] > 0)
					{
						Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
					}
					
					yy += 1;
				}
			}
		}
		
		//############################# SOUTH WEST
				
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			var xx:Int = Reg._gameXXold + 1;
			var yy2:Int = Reg._gameYYold - 1;
			var xx2:Int = Reg._gameXXold + 1;
			
			Reg._reversiGamePointValueForPiece[6][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[6][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy >= 0 && xx <= 7)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber2) 
				{
					_found = true;
				}
				
				else if (Reg._gamePointValueForPiece[yy][xx] == 0 && _found == false) 
				{
					// set vars to back to default because there are no Reversi here.
					while (yy2 >= 0 && xx2 <= 7)
					{
						//Reg._reversiGamePointValueForPiece[6][yy2][xx2] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[6][yy2][xx2] = 0;
					
						xx2 += 1;
						yy2 -= 1;
					}
					
					if (_found == false) _empty = true;
					break;
				}

				else 
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber && _found == false)
				{
					Reg._reversiGamePointValueForPiece[6][yy][xx] = _pieceNumber;
					Reg._reversiCapturingUnitsForPieces[6][yy][xx] = 2;
					
					_piece = true;
				}				
				
				xx += 1;
				yy -= 1;
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold - 1;
			var xx:Int = Reg._gameXXold + 1;
		
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy >= 0 && xx <= 7)
			{
				if (Reg._reversiGamePointValueForPiece[6][yy][xx] > 0)
				{
					Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
				}
				
				xx += 1;
				yy -= 1;
			}
		}
		
		// ################################### WEST #################################
		
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{				
			var xx:Int = Reg._gameXXold + 1;
			var xx2:Int = Reg._gameXXold + 1;
			
			Reg._reversiGamePointValueForPiece[7][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[7][Reg._gameYYold][Reg._gameXXold] = 2;
			
			
			for (yy in Reg._gameYYold...8)
			{
				while (xx <= 7)
				{				
					if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == _pieceNumber2) 
					{
						_found = true;
					}
					
					else if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == 0 && _found == false) 
					{
						// set vars to back to default because there are no Reversi here.
						while (xx2 <= 7)
						{
							//Reg._reversiGamePointValueForPiece[7][Reg._gameYYold][xx2] = 0;
							Reg._reversiCapturingUnitsForPieces[7][Reg._gameYYold][xx2] = 0;
						
							xx2 += 1;
						}
						
						if (_found == false) _empty = true;
						break;
					}
					else 
					if (Reg._gamePointValueForPiece[Reg._gameYYold][xx] == _pieceNumber && _found == false)
					{
						Reg._reversiGamePointValueForPiece[7][Reg._gameYYold][xx] = _pieceNumber;
						Reg._reversiCapturingUnitsForPieces[7][Reg._gameYYold][xx] = 2;
						
						_piece = true;
					}				
					
					xx += 1;
						
				}				
			}
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var xx:Int = Reg._gameXXold + 1;
			
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			for (yy in Reg._gameYYold...8)
			{
				while (xx <= 7)
				{	
					if (Reg._reversiGamePointValueForPiece[7][yy][xx] > 0)
					{
						Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
					}
					
					xx += 1;
				}
			}
		}
		
		//############################# NORTH WEST
		
		var _found:Bool = false;
		var _piece:Bool = false;
		var _empty:Bool = false;
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			var xx:Int = Reg._gameXXold + 1;
			var yy2:Int = Reg._gameYYold + 1;
			var xx2:Int = Reg._gameXXold + 1;
			
			Reg._reversiGamePointValueForPiece[2][Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._reversiCapturingUnitsForPieces[2][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy <= 7 && xx <= 7)
			{
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber2) 
				{
					_found = true;
				}
				
				else if (Reg._gamePointValueForPiece[yy][xx] == 0 && _found == false) 
				{
					// set vars to back to default because there are no Reversi here.
					while (yy2 <= 7 && xx2 <= 7)
					{
						//Reg._reversiGamePointValueForPiece[2][yy2][xx2] = 0;
						Reg._reversiCapturingUnitsForPieces[2][yy2][xx2] = 0;
					
						xx2 += 1;
						yy2 += 1;
					}
					
					if (_found == false) _empty = true;
					break;
				}

				else 
				if (Reg._gamePointValueForPiece[yy][xx] == _pieceNumber && _found == false)
				{
					Reg._reversiGamePointValueForPiece[2][yy][xx] = _pieceNumber;
					Reg._reversiCapturingUnitsForPieces[2][yy][xx] = 2;
					
					_piece = true;
				}				
				
				xx += 1;
				yy += 1;
			}
		
		}
		
		if (Reg._gameYYold != -1 && Reg._gameXXold != -1 && _found == true && _piece == true && _empty == false)			
		{	
			var yy:Int = Reg._gameYYold + 1;
			var xx:Int = Reg._gameXXold + 1;
		
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = _pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;
			
			while (yy <= 7 && xx <= 7)
			{
				if (Reg._reversiGamePointValueForPiece[2][yy][xx] > 0)
				{
					Reg._gamePointValueForPiece[yy][xx] = _pieceNumber;
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 2;
				}
				
				xx += 1;
				yy += 1;
			}
		}
		
		
		
		
	}
}
