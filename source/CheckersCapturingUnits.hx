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
 * this class will highlight all units that piece can move to and will move that piece after a captured empty unit created at CheckersCurrentUnitClicked is user input clicked.
 * @author kboardgames.com
 */
class CheckersCapturingUnits
{

	//#############################
	/**
	 * this function is called from CheckersCurrentUnitClicked. at that function, every unit on the board is read. this function sets a Reg._checkersFoundPieceToJumpOver to be true if that piece can jump the opponents piece.
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 * @param	Reg._playerMoving		the player moving while _playerNotPlayer is the other player.
	 */	
	public static function jumpCapturingUnitsForPieceAll(cy:Int, cx:Int, _playerMoving:Int):Void
	{
		// both players read this function. the _temp var is used so that the player not moving can use this function to check for other player's pieces. once checked, at the end of this function, the Reg._playerMoving will equal this var so that its value cannot be lost.
		var _temp = Reg._playerMoving;
		Reg._playerMoving = _playerMoving;
		
		var yy = cy;
		var xx = cx;
		
		// normal checker pieces have a point value of 1 for player 1 while a value of 2 is a king. player 2 has normal checker pieces with a value of 11 and its king had a value of 12.
		
		// if at CheckersCurrentUnitClicked.hx this function is read twice at the beginning of a player's turn. the first time is before a mouse click can be made, that code at update() gets the values needed to tell the computer what to do after a mouse click is made. search for Reg._gameDidFirstMove at that class for more information. 
		
		// if there was a mouse click, then that unit passes its data here to be read. if that unit was clicked by player 1 then check that Reg._playerMoving = 0 which is player 1 and that the piece that was click has either a normal value or a king value.
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 3
		|| Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 13)
		{
			// a normal piece of player 1 always moves up. since this loop deals with upward movement, we only need to check if player 1 clicked that unit. if player 2 clicked a unit that is owned by that player 2, then we check for a value of 12 since that is a king that can also move in an upward direction.
			if (Reg._playerMoving == 0 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 12)
			{
				//#############################	CHECKERS MOVING IN UP DIRECTION.
			
				// a value of cy is a direction from top to bottom or bottom to top. not left to right. since a value of 0 is somewhere left to right located at the top of the board, we cannot jump at a value of 1. we need to jump from 2 units south of the top of the board or else an error will be given.
				if (cy > 1)	
				{				
					cy -= 1;
					
					// we are checking if a left movement is possible. so if already at far left of the board or a unit just to the right of that unit, a left movement is not possible to make a jump.
					if (cx > 1)
					{
						// this code does two things. when you click your red piece, the unit next to yours that is just NW is checked for player 2 piece. if found then another angle from that piece is checked for a unit that has no piece.
						if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx - 1] > 10 && Reg._gamePointValueForPiece[cy - 1][cx - 2] == 0
						 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx - 1] > 0 && Reg._gamePointValueForPiece[cy][cx - 1] < 11 && Reg._gamePointValueForPiece[cy - 1][cx - 2] == 0)
						{		
							// if code goes here then a jump can be made but first we need to check if this piece clicked was a king or a normal piece. the reason is normal pieces ends a players turn once becoming a king. a Reg._checkersUniquePieceValue value of 1 stops a normal piece from moving the second time. also if there are jumps available, makes a king jump to a y-0 unit and continue to jump over yet another piece.
							if (Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 12) 
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 2;
							}
							
							// normal unit is given a value of 1 and a jump value of true.
							if (Reg._checkersUniquePieceValue[yy][xx] !=2)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 1;
							}
						}
					}				
					if (cx < 6) // jumping NW
					{
						if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx + 1] > 10 && Reg._gamePointValueForPiece[cy - 1][cx + 2] == 0
						 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx + 1] > 0 && Reg._gamePointValueForPiece[cy][cx + 1] < 11 && Reg._gamePointValueForPiece[cy - 1][cx + 2] == 0)
						{							
							if (Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 12) 
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 2;
							}
							
							
							if (Reg._checkersUniquePieceValue[yy][xx] !=2)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 1;
							}
						}
					}
										
				}
				
			}
			
			if (Reg._playerMoving == 1 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 2)
			{
				//#############################	CHECKERS MOVING IN DOWN DIRECTION.
			
				if (cy < 6)
				{
					cy += 1;
								
					if (cx > 1) // jumping SW.
					{
						if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx - 1]  > 0 && Reg._gamePointValueForPiece[cy][cx - 1] < 11 && Reg._gamePointValueForPiece[cy + 1][cx - 2] == 0
						|| Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx - 1] > 10 && Reg._gamePointValueForPiece[cy + 1][cx - 2] == 0)
						{
							if (Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 12) 
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 2;
							}
							
							
							if (Reg._checkersUniquePieceValue[yy][xx] !=2)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 1;
							}
						}
					}				
					if (cx < 6 && cy < 7) // jumping SE.
					{
						if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx + 1] > 0 && Reg._gamePointValueForPiece[cy][cx + 1] < 11 && Reg._gamePointValueForPiece[cy + 1][cx + 2] == 0
						|| Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx + 1] > 10 && Reg._gamePointValueForPiece[cy + 1][cx + 2] == 0)
						{
							if (Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 12) 
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 2;
							}
							
							
							if (Reg._checkersUniquePieceValue[yy][xx] !=2)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._checkersUniquePieceValue[yy][xx] = 1;
							}
						}
					}
					
					
				}	
			}
		}
		
		// in case this is the player not moving, we give back that player's original value of this var that might have been changed when entering this function. for the reason that might having, see the top of this function.
		Reg._playerMoving = _temp;
	}
	
	/**
	 * This function is called twice. first when the player clicks a unit and second when the player jumps a piece. we need the second time to determine if another jump is possible or if no more jumps then that will be the end of a players turn.
	 * this function gives a value Reg._checkersFoundPieceToJumpOver of true if a jump can be made. also Reg._capturingUnitsForPieces is given a Y and X coordinate for that later at CheckersMovePlayersPiece.hx class that piece that you jumped over can be removed from the board.
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 * @param	Reg._playerMoving		this var is used by the defender player.
	 */	
	public static function jumpCapturingUnitsForPiece(cy:Int, cx:Int, _playerMoving:Int):Void
	{
		var _temp = Reg._playerMoving;
		Reg._playerMoving = _playerMoving;
		
		var yy = cy; // at this function, yy will always be the unit that was clicked.
		var xx = cx;
		
		// normal checker pieces have a point value of 1 for player 1 while a value of 2 is a king. player 2 has normal checker pieces with a value of 11 and its king had a value of 12.
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 3
		|| Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 13)
		{
			// if normal unit for player 1 or a king unit for player 2.		
			if (Reg._playerMoving == 0 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 12)
			{
				//#############################	CHECKERS MOVING IN UP DIRECTION.
			
				cy = yy;
				
				if (cy > 1)	
				{				
					cy -= 1;
					
					if (cx > 1) // jumping NW.
					{
						if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx - 1] > 10 && Reg._gamePointValueForPiece[cy - 1][cx - 2] == 0
						 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx - 1] > 0 && Reg._gamePointValueForPiece[cy][cx - 1] < 11 && Reg._gamePointValueForPiece[cy - 1][cx - 2] == 0)
						{						
							// a Reg._checkersIsThisFirstMove is used to stop a normal piece from jumping or moving twice using 1 turn.
							if (Reg._checkersUniquePieceValue[yy][xx] == 2 || Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] <= 1)
							{									
								Reg._checkersFoundPieceToJumpOver = true;
								
								// store the unit that this piece can move to.
								Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx - 2] = 1;
							}
						
						}
					}				
					if (cx < 6) // jumping NE.
					{
						if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx + 1] > 10 && Reg._gamePointValueForPiece[cy - 1][cx + 2] == 0
						 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx + 1] > 0 && Reg._gamePointValueForPiece[cy][cx + 1] < 11 && Reg._gamePointValueForPiece[cy - 1][cx + 2] == 0)
						{
							if (Reg._checkersUniquePieceValue[yy][xx] == 2 || Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] <= 1)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx + 2] = 1;
							}
						
						}
					}
										
				}
				
			}
			
			if (Reg._playerMoving == 1 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 2)
			{
				//#############################	CHECKERS MOVING IN DOWN DIRECTION.
			
				cy = yy;
				
				if (cy < 6)
				{
					cy += 1;
								
					if (cx > 1 && cy < 7) // jumping SW.
					{
						if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx - 1]  > 0 && Reg._gamePointValueForPiece[cy][cx - 1] < 11 && Reg._gamePointValueForPiece[cy + 1][cx - 2] == 0
						 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx - 1] > 10 && Reg._gamePointValueForPiece[cy + 1][cx - 2] == 0)
						{
							if (Reg._checkersUniquePieceValue[yy][xx] == 2 || Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] <= 1)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx - 2] = 1;		
							}
						}
					}				
					if (cx < 6 && cy < 7) // jumping SE.
					{
						if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx + 1] > 0 && Reg._gamePointValueForPiece[cy][cx + 1] < 11 && Reg._gamePointValueForPiece[cy + 1][cx + 2] == 0
						 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx + 1] > 10 && Reg._gamePointValueForPiece[cy + 1][cx + 2] == 0)
						{
							if (Reg._checkersUniquePieceValue[yy][xx] == 2 || Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] <= 1)
							{
								Reg._checkersFoundPieceToJumpOver = true;
								Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx + 2] = 1;
							}
						}
					}
					
					
				}	
			}
		}
		
			
		// if no jumps are found.
		if (Reg._checkersFoundPieceToJumpOver == false) 
		{
			Reg._hasPieceMovedFinished = 0;
			
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					Reg._checkersUniquePieceValue[qy][qx] = 0;
				}				
			}			
		}
		
		Reg._playerMoving = _temp;
	}
			
	/**
	 * this function deals with the normal movement of a piece. a normal piece moves in a forward yet in an angle. if the unit to move to is empty then a capturing var (Reg._capturingUnitsForPieces) will be set to 1, referring to a unit that the piece can move to. when a normal piece is clicked that units the piece can move to will be highlighted using an image. see CheckersImagesCapturingUnits.hx
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 * @param	Reg._playerMoving		this var is used by the defender player.
	 */	
	public static function capturingUnitsForPiece(cy:Int, cx:Int, _playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;

		var yy:Int = cy;
		var xx:Int = cx;
		
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 3
		 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 10 && Reg._gamePointValueForPiece[cy][cx] < 13)
		{
			
			if (Reg._playerMoving == 0 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 12)
			{
				//#############################	CHECKERS MOVING IN UP DIRECTION.
			
				cy = yy;
				
				if (cy > 0)	
				{				
					cy -= 1;
					
					
					if (cx > 0) // moving NW. 
					{
						if (Reg._gamePointValueForPiece[cy][cx - 1] == 0)
						
						// 0=empty unit. 1=the clicked piece can move to this unit. 
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx - 1] = 1;
					}				
					if (cx < 7) // moving NE.
					{
						if (Reg._gamePointValueForPiece[cy][cx + 1] == 0)
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx + 1] = 1;
					}
					
				}
				
			}
			
			if (Reg._playerMoving == 1 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 2)
			{
				//#############################	CHECKERS MOVING IN DOWN DIRECTION.
			
				cy = yy;
				
				if (cy < 7)
				{
					cy += 1;
								
					if (cx > 0) // moving SW.
					{
						if (Reg._gamePointValueForPiece[cy][cx - 1] == 0)
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx - 1] = 1;
					}
					if (cx < 7) // moving SE.
					{
						if (Reg._gamePointValueForPiece[cy][cx + 1] == 0)
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx + 1] = 1;
					}	
					
				}	
			}
		}	
	}
	
	/**
	 * this function redirects to a function that will find all capturing units on board. this Reg.is_player_attacker below is used to find what player is moving a piece.
	 */
	public static function capturingUnits():Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		locationsPieceCanMove(Reg._pieceNumber, Reg._playerMoving); // the player moving.
	
	}
	
	//#############################  LOCATIONS PIECE CAN MOVE 
	/******************************
	 * this function finds all capturing units on board. the moving player will find its capturing units.
	 * sometimes it is necessary for the player to find the other player's capturing units. see the Reg._checkersBackdoor var and search it for its usage. 
	 */
	public static function locationsPieceCanMove(_pieceNumber:Int, _playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		Reg._pieceNumber = _pieceNumber;
		
		var yy:Int = -1;
		var xx:Int = -1;
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// sometimes this function cannot search every unit because the piece has already been moved. after a piece has been moved it is necessary to find is there are any more jumps. to find those jumps, this function is called from CheckersMovePlayersPiece.hx and it _game##new2 vars are set before calling this function.
				// if a king matches these var when we can then determining if there is another jump. see below.
				if (Reg._checkersUniquePieceValue[cy][cx] == 2 && Reg._gameYYnew2 == yy && Reg._gameXXnew2 == xx) // do Reg._gameXXnew2 == xx not Reg._gameXXnew2 == cx
				{
					yy = cy; 
					xx = cx;
				}
			}
		}
		
		// this is the function that will set a value of 1, a highlighted unit where a checker piece can be moved to by setting that value.
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// the unique value of 1 to 12 are checker pieces.
				if (Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gameUniqueValueForPiece[cy][cx] < 13)
				{
					// if this is all true then this code was first setup from CheckersMovePlayersPiece.hx. there is a piece that was clicked, and was moved, and we now need to know if there is another jump for that piece. we do it that way because once a piece is selected and then used to jump over another piece then a different piece cannot be selected to jump. the player must stay with that selected piece.			
					if (yy != -1 && xx != -1 && Reg._checkersFoundPieceToJumpOver == true)
					{
						if (Reg._gameYYnew2 == yy && Reg._gameXXnew2 == xx)
						{
							// the way this game is set up is that sometimes the same data is read for the moving player and none moving player. using a backdoor var is sometimes needed so that the none moving player can get capturing data for the moving player. see CheckersMovePlayersPiece.hx, near the end of that class for how this function is called. a backdoor is used so that the none player can get data for the player that just jumped. so this Reg._playerMoving may not have a value referring to the player moving but instead the other player wanting that data.								
							jumpCapturingUnitsForPiece(yy, xx, Reg._playerMoving);
							Reg._checkersUniquePieceValue[Reg._gameYYold][Reg._gameXXold] = 2;
							return; // break out of the first loop in this block of code.
						}
					}
					// this code will be looped and every unit searched to determine if there is another jump.
					else jumpCapturingUnitsForPieceAll(cy, cx, Reg._playerMoving);
				}
			}
		}	
		
		
		
		
		
	}
}
