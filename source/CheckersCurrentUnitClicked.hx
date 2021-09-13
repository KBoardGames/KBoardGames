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
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...the main loop. find units to move to.
 * @author kboardgames.com
 */
class CheckersCurrentUnitClicked extends FlxSprite
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	* this is part of the client software. it is used mainly to connect, disconnect or access event.
	*/
	private var clientSocket:vendor.mphx.client.Client;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/******************************
	 * this is used to go to a CheckersCapturingUnits.capturingUnits() to find all capturing units on board.
	 */
	private var _do_once:Bool = false;
	
	public function new (y:Float, x:Float, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
		
		_startX = x;
		_startY = y;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		// use an empty image because its selecting an unit is sometimes buggy. when there is a jump to be made, sometimes another unit piece can be selected. 
		loadGraphic("assets/images/0.png", false);

		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameOverForPlayer == false && Reg._gameId == 0)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			// p is the unit number. at the loop below, p starts at the top-left corner of the gameboard, the xx/yy value of zero, and increments as each unit is looped and moving in the direction of east. when the end of that first row is loop, the next row will be looped and p will still continue to be increased in size.
			
			var p = -1;
/*
trace("Reg._playerCanMovePiece " + Reg._playerCanMovePiece);
trace("Reg._checkersFoundPieceToJumpOver " +Reg._checkersFoundPieceToJumpOver);
trace("Reg._checkersIsThisFirstMove " + Reg._checkersIsThisFirstMove);
*/

			if (Reg._playerCanMovePiece == true
			&&  Reg._at_input_keyboard == false)
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
							&&  RegTypedef._dataTournaments._move_piece == true)
							{
								// a piece that has not been clicked at this game turn.
								if (Reg._checkersUniquePieceValue[yy][xx] == 0
								&& Reg._checkersFoundPieceToJumpOver == false
								&& Reg._gameHost == true 
								&& ActionInput.overlaps(Reg._groupPlayer1)
								&&	RegTriggers._buttons_set_not_active == false 
								// not been clicked for a game turn.
								|| Reg._checkersUniquePieceValue[yy][xx] == 0
								&& Reg._checkersFoundPieceToJumpOver == false
								&& Reg._gameHost == false
								&& ActionInput.overlaps(Reg._groupPlayer2)
								&&	RegTriggers._buttons_set_not_active == false
								// if true then this piece can jump over the other player's piece.
								|| Reg._checkersFoundPieceToJumpOver == true && Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] == 1 && Reg._gameHost == true && ActionInput.overlaps(Reg._groupPlayer1) 
								
								// piece that can jump over another of a different color.
								|| Reg._checkersFoundPieceToJumpOver == true && Reg._checkersIsThisFirstMove == true && Reg._checkersUniquePieceValue[yy][xx] == 1 && Reg._gameHost == false && ActionInput.overlaps(Reg._groupPlayer2)
								
								// king can jump.
								|| Reg._checkersFoundPieceToJumpOver == true && Reg._gameHost == true && ActionInput.overlaps(Reg._groupPlayer1)
								// king can jump.
								|| Reg._checkersFoundPieceToJumpOver == true && Reg._gameHost == false && ActionInput.overlaps(Reg._groupPlayer2)
							  
								// empty but capturing unit. if true then the piece will be moved / jumped. see CheckersImagesCapturingUnits.hx. that class deals with highlighting a unit by using an image.
								|| Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 && Reg._gameUniqueValueForPiece[yy][xx] == 0 && ActionInput.overlaps(Reg._groupPlayer1) == false && ActionInput.overlaps(Reg._groupPlayer2) == false									
								)
								{
									x = _startX + (xx * 75);						
									y = _startY + (yy * 75);													
									// if this is a moving or jumping piece and the computer already populated the capturing var.
									if (Reg._gamePointValueForPiece[yy][xx] > 0) Reg._gameDidFirstMove = true;
									
									if (Reg._gameDidFirstMove == false) return;
														
									visible = true; // display a highlighted unit where the mouse cursor is located.
									
									if (Reg._gamePointValueForPiece[yy][xx] > 0)
									{
										if (Reg._checkersIsThisFirstMove == false)
										{
											if (Reg._gameYYnew == yy
											&&  Reg._gameXXnew == xx)
											{
												Reg._checkersIsThisFirstMove = true;
												populateCapturingUnits(yy, xx, p);
												Reg._checkersIsThisFirstMove = false;
													
											}
										}
										
										else populateCapturingUnits(yy, xx, p);
										
									} else populateCapturingUnits(yy, xx, p);
									
									break;
								}
							}
						}					
					}
				}
			}
						
			// this code block will be read after the player clicks the empty capturing unit.
			
			// move the piece...
			if (Reg._gameMovePiece == true)
			{
				_do_once = false;
				
				//... if this condition is true.
				if (Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] != 0)
				{
					if (visible == false) visible = true;
							
					// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
					 x = _startX + Reg._gameXXnew * 75;						
					 y = _startY + Reg._gameYYnew * 75;
					 
					 if (Reg._gameYYold != -1 && Reg._gameYYnew != -1)
					 {
						Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
						Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1; // remember that this is no longer a capturing unit but needed for moved piece highlight.
					 }
				}
			
			}
			
			
			// this code block will be read before the player clicks a unit.
			
			if (Reg._gameDidFirstMove == false && Reg._playerCanMovePiece == false) 
			{
				 x = _startX + Reg._gameXXnew * 75;						
				 y = _startY + Reg._gameYYnew * 75;					
				 			
				if (Reg._gameYYold != -1 && Reg._gameYYnew != -1)
				 {
					 Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
					 Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1; // remember that this is no longer a capturing unit but needed for moved piece highlight.					 
					
					if (Reg._gameOverForAllPlayers == false)
						__ids_win_lose_or_draw.canPlayerMove2();
		 
				 }
			} else if (_do_once == false)
			{
				_do_once = true;
				CheckersCapturingUnits.capturingUnits();
			}
					
		} else if (visible == true) visible = false;

		super.update(elapsed);
	}
	
	private function populateCapturingUnits(yy:Int, xx:Int, p:Int):Void
	{
		// when the unit is clicked, the unit number is stored in this var. later this var will be read so that the unit to be move to and moved from can be determined.
		Reg._gameUnitNumber = p;
		
		//############################# checkers.			
		moveCheckersPieceHere(xx, yy);								
	}
	
		/**
	 * determines if a piece can be moved. 
	 * this is the main function that passes data to other functions to determine check or even if a piece can be moved.
	 * @param	xx		x coordinate of the piece that was clicked on.
	 * @param	yy		y coordinate.
	 */
	private function moveCheckersPieceHere(cx:Int, cy:Int):Void
	{		
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
			// consider that the last unit of that gameboard was clicked. xx and yy will always refer to the unit number of 7/7. the units start from the top-left corner at a coordinate value of 0/0. 0 to 7 from left to right and 0 to 7 from top to bottom. cx/cy is used in this function for calculations. so, their value may change.
		var xx:Int = cx;
		var yy:Int = cy;

		if (xx < 0) xx = 0;
		if (yy < 0) yy = 0;
		if (xx > 7) xx = 7;
		if (yy > 7) yy = 7;
			
		//############################# MOVE PIECE
			
		// CheckersImagesCapturingUnits is the unit that the player can move to. since this function is called when the mouse is clicked and this value is > than 0 then that means the player is moving to this unit that has a value of xx/yy.
		if (Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] == 0 && Reg._gameYYold > -1 && Reg._gameXXold > -1 && Reg._gameDidFirstMove == true)
		{
			// these vars holds the value of xx/yy. later, they will be read to determine where, at a different class, the players piece should be moved to. 
			Reg._gameXXnew = xx;
			Reg._gameYYnew = yy;			
			
			// at mouse click, _gameUnitNumber equals p. since this unit is a move to unit, we need to store the value of p so we can loop through xx/yy or do something when an ID matches this value so that we can move this piece. see CheckersMovePlayersPiece.hx class for move information.
			Reg._gameUnitNumberNew = Reg._gameUnitNumber; 		
				
			Reg._gameXXnew2 = -1;
			Reg._gameYYnew2 = -1;
			Reg._gameXXold2 = -1;
			Reg._gameYYold2 = -1;
			Reg._gameUnitNumberNew2 = -1;
			Reg._gameUnitNumberOld2 = -1;
			Reg._pointValue2 = -1;
			Reg._uniqueValue2 = -1;
			
			// consider that if the king at the bottom-left corner of the gameboard was clicked then we must make the move to unit the same values as that unit...
			Reg._gamePointValueForPiece[yy][xx] = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
			Reg._gameUniqueValueForPiece[yy][xx] = Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold];
			
			// ... next we make where the king would have been moved from, that unit a value of zero so that the other player can move to that unit at a later time.
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
			Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
			
			// make the final movement change to the sprite. when this var is true, a code block at CheckersMovePlayersPiece.hx is read at its update function. see update at that class for how the sprite is moved to the new unit.				
			Reg._gameMovePiece = true;
			//GameHistoryAndNotation.notationPrint();
			
			Reg._pieceMovedUpdateServer = true;
						
			return;
		}
	
		// the following code handles what happen when a gameboard piece is clicked. the code sets values to the CheckersImagesCapturingUnits and other important vars so that the CheckersImagesCapturingUnits class can use an image to highlight where the player can move to.
		Reg._gameXXold = xx; //since a player piece was clicked, we store the value of xx/yy so that...
		Reg._gameYYold = yy; //... its move from value can later be determined.
		 
		Reg._gameUnitNumberOld = Reg._gameUnitNumber; // we do that same here for its p value.
		 
		// 	we need to correct player moving var...
		Reg._playerMoving = 0;
		if (Reg._gameHost == false) Reg._playerMoving = 1;
		
		// if there are no more jumps then clear these vars so that later a new capturing var with a value of 0 could be populated. remember that a value of 2 is a king and if not cleared here then later another jump will be possible.
		if (Reg._checkersShouldKeepJumping == false)
		{		
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					// the Reg._playerMoving that might have a value of 0, meaning player 0, could replace the [0] code below.
					Reg._checkersUniquePieceValue[qy][qx] = 0;
					Reg._capturingUnitsForPieces[0][qy][qx] = 0;
					Reg._capturingUnitsForPieces[1][qy][qx] = 0;
				}				

			}
		}	

		// the following lines of code will determine if a jump is possible. if true then the code will set Reg._checkersFoundPieceToJumpOver to equal true and then will make its Reg._checkersUniquePieceValue to have a value of either 1 normal moving unit or 2 a king.
		CheckersCapturingUnits.capturingUnits();
		
		if (cy > -1 && cx > -1) CheckersCapturingUnits.jumpCapturingUnitsForPiece(cy, cx, Reg._playerMoving);
			
		if (Reg._checkersFoundPieceToJumpOver == false)
		{
			if (cy > -1 && cx > -1) CheckersCapturingUnits.capturingUnitsForPiece(cy, cx, Reg._playerMoving);
			
		}

	}	
}