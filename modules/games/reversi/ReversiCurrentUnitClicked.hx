/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.reversi;

/**
 * ...the main loop. find units to move to.
 * @author kboardgames.com
 */
class ReversiCurrentUnitClicked extends FlxSprite
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
	 * game message and message popups when that player wins, loses or draws.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	private var _doOnce:Bool = false;
	
	
	public function new (y:Float, x:Float, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
		
		_startX = x;
		_startY = y;
		
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;

		loadGraphic("assets/images/currentUnitClicked.png", false);

		visible = false;
	}

	private function populateCapturingUnits(yy:Int, xx:Int, p:Int):Void
	{
		// when the unit is clicked, the unit number is stored in this var. later this var will be read so that the unit to be move to and moved from can be determined.
		Reg._gameUnitNumber = p;
	
		//############################# Reversi.			
		
		moveReversiPieceHere(xx, yy);								
	}
	
	/******************************
	 * determines if a piece can be moved. 
	 * this is the main function that passes data to other functions to determine check or even if a piece can be moved.
	 * @param	xx		x coordinate of the piece that was clicked on.
	 * @param	yy		y coordinate.
	 */
	private function moveReversiPieceHere(cx:Int, cy:Int):Void
	{		
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
		// consider that the last unit of that gameboard was clicked. xx and yy will always refer to the unit number of 7/7. the units start from the top-left corner at a coordinate value of 0/0. 0 to 7 from left to right and 0 to 7 from top to bottom. cx/cy is used in this function for calculations. so, their value may change.
		var xx:Int = cx;
		var yy:Int = cy;
		
		
		Reg._gameYYold = yy;
		Reg._gameXXold = xx;
		
		if (xx < 0) xx = 0;
		if (yy < 0) yy = 0;
		if (xx > 7) xx = 7;
		if (yy > 7) yy = 7;
			
		
	/*	//############################# MOVE PIECE
				
		// ReversiImagesCapturingUnits is the unit that the player has clicked.
		if (Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] > 0 && Reg._gameYYold > -1)
		{
			// these vars holds the value of xx/yy. later, they will be read to determine where, at a different class, the players had clicked. 
			Reg._gameXXold = xx;
			Reg._gameYYold = yy;	
			
			// at mouse click, _gameUnitNumber equals p. since this unit is a move to unit, we need to store the value of p so we can loop through xx/yy or do something when an ID matches this value so that we can move this piece. see ReversiMovePlayersPiece.hx class for move information.
			Reg._gameUnitNumberNew = Reg._gameUnitNumber; 		
				
			Reg._gameXXnew2 = -1;
			Reg._gameYYnew2 = -1;
			Reg._gameXXold2 = -1;
			Reg._gameYYold2 = -1;
			Reg._gameUnitNumberNew2 = -1;
			Reg._gameUnitNumberOld2 = -1;
			Reg._pointValue2 = -1;
			Reg._uniqueValue2 = -1;
			
			// make the final movement change. when this var is true, a code block at ReversiMovePlayersPiece.hx is read at its update function. see update at that class for how the pieces are flipped at units where the player moving has pieces on each side of them.				
			Reg._gameMovePiece = true;
			
			Reg._pieceMovedUpdateServer = true;
						
			return;
		}
	*/
		Reg._gameUnitNumberOld = Reg._gameUnitNumber; // we do that same here for its p value.
		 
		// 	we need to correct player moving var...
		Reg._playerMoving = 0;
		if (Reg._gameHost == false) Reg._playerMoving = 1;
		
		
		for (p in 0...8)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					Reg._reversiGamePointValueForPiece[p][yy][xx] = 0;
					Reg._reversiCapturingUnitsForPieces[p][yy][xx] = 0;
					Reg._capturingUnitsForPieces[0][yy][xx] = 0;
					Reg._capturingUnitsForPieces[1][yy][xx] = 0;
				}
			}
			
		}
		
		
	
		if (Reg._triggerNextStuffToDo <= 3)
		{	
			
			// value for the player not moving.
			if (Reg._playerMoving == 0) Reg._pieceNumber = 11;
			else Reg._pieceNumber = 1;			
			
			if (Reg._reversiReverseIt == true)
			{
				if (Reg._playerMoving == 0) Reg._playerMoving = 1;
				else Reg._playerMoving = 0;
			}
			
			Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = Reg._pieceNumber;
			Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 2;			
		}
		else 
		{
			// the following will determine if there is a capturing piece...
			ReversiCapturingUnits.capturingUnits();
			
			//... and what to do when player clicks that capturing piece.
			ReversiCapturingUnits.findCapturingUnits();
		}
				
		Reg._gameDidFirstMove = true;

	}	
	
	override public function update (elapsed:Float)
	{
		if (Reg._gameOverForPlayer == false
		&&	Reg._messageId == 0)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
			// p is the unit number. at the loop below, p starts at the top-left corner of the gameboard, the xx/yy value of zero, and increments as each unit is looped and moving in the direction of east. when the end of that first row is loop, the next row will be looped and p will still continue to be increased in size.
			var p = -1;

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
							// this is needed to display a different capturing image depending what player is moving.
							if (Reg._playerMoving == 0) Reg._pieceNumber = 1;
		else Reg._pieceNumber = 11;		
		
							if (Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0)
							{	
								// display an image at a capturing unit when moving the mouse around.
								if (Reg._pieceNumber == 1) loadGraphic("modules/games/reversi/assets/images/2.png", false);
								if (Reg._pieceNumber == 11) loadGraphic("modules/games/reversi/assets/images/12.png", false);
								
								x = _startX + (xx * 75);						
								y = _startY + (yy * 75);
									
								visible = true;
							} else visible = false;
		
							if (ActionInput.justReleased() == true && RegTypedef._dataMisc._spectatorWatching == false)
							{
								// if this unit is a capturing unit.
								if (Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 
								&& ActionInput.overlaps(Reg._groupPlayer1) == false 
								&& ActionInput.overlaps(Reg._groupPlayer2) == false				
								)
								{
									x = _startX + (xx * 75);						
									y = _startY + (yy * 75);																			
									
									visible = true; // display a highlighted unit where the mouse cursor is located.

									// these vars need to be cleared at every mouse click.
									Reg._gameYYold = -1; Reg._gameXXold = -1;
									Reg._reversiProcessAllIdsTotal = 0;	
									
									populateCapturingUnits(yy, xx, p);
									
									break;
								}
							}
						}					
					}
				}
			}
				
			// this code block will be read after the player clicks the empty capturing unit.
			
			// move the piece highlighter...
			if (Reg._gameMovePiece == true && Reg._triggerNextStuffToDo > 3)
			{
				//... if this condition is true.
				if (Reg._gameYYold != -1 && Reg._gameXXold != -1)
				{
					if (Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] != 0)
					{
						if (visible == false) visible = true;
								
						// the XY coordinate equals the start of the board plus the unit coordinate times the width/height of this image.
						 x = _startX + Reg._gameXXold * 75;						
						 y = _startY + Reg._gameYYold * 75;
						 
						Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
					}	
				}
			
			}
			
			// this code block will be read before the player can click a unit.			
			if (Reg._gameDidFirstMove == false) 
			{				
				ReversiCapturingUnits.capturingUnits();
				if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
					__ids_win_lose_or_draw.canPlayerMove2();
				else if (_doOnce == false) __ids_win_lose_or_draw.canPlayerMove2();
				_doOnce = true;
				
				if (Reg._playerCanMovePiece == false && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._gameYYold != -1 && Reg._gameXXold != -1) 
				{
					
					ReversiCapturingUnits.findCapturingUnits();			
						
					Reg._gameDidFirstMove = true;
					_doOnce = false;
				}
			}
					
		} 
		
		
		super.update(elapsed);
	}
	
}