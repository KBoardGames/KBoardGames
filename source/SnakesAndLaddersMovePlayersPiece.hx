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
 * ...move a piece over an opponents piece.
 * @author kboardgames.com
 */
class SnakesAndLaddersMovePlayersPiece extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	private var _doOnce:Bool = false;
	public static var _snakeMovePiece:Bool = false;
	private var _ladderMovePiece:Bool = false;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * game message and message popups when that player wins, loses or draws.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	private var _snake:FlxTimer;
	private var _timerFinshed:Bool = true;
	
	private var _found:Bool = false;
	
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */	
	public function new (y:Float, x:Float, id:Int, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
	
		ID = _id = id;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;

		_snakeMovePiece = false;
		_ladderMovePiece = false;
		
		visible = false;
		
		//_snake = new FlxTimer();
		//_snake.start(0.065, ladder1PlayerClimbIt, 10);
	}
	
	private function isThereMovement():Void
	{
		// for a 2 player game, this code forces only 1 piece to be moved per player. for an offline game, this code moves pieces normally.
		if (Reg._move_number_current == Reg._move_number_next
		||  Reg._game_offline_vs_cpu == true
		||  Reg._game_offline_vs_player == true )
		{
			if (_id == 1 ||  _id == 2) 
			{
				_snakeMovePiece = false;
				_ladderMovePiece = false;
				
				// the first four are snake head locations and the last four are bottom ladder locations.
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 15)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 5;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 5;
					
					_snakeMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 35)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 7;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 7;
					
					_snakeMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 59)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 31;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 31;
					
					_snakeMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 42)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 23;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 23;
					
					_snakeMovePiece = true;
				}
				
				
				
				// for snakes and ladders animation, see Reg, var _snakePlayerSlideDownLocationsX and _snakePlayerSlideDownLocationsY and at this class, see snake1PlayerSlideDown and ladder1PlayerClimbIt
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 8)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 25;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 25;
					
					_ladderMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 16)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 32;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 32;
					
					_ladderMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 28)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 44;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 44;
					
					_ladderMovePiece = true;
				}
				
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 50)
				{
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = 63;
					Reg._gameDiceCurrentIndex[Reg._playerMoving] = 63;
					
					_ladderMovePiece = true;
				}
							
				movePiecePrepare();

			
			}
		}
	}
	
	private function movePiecePrepare():Void
	{
		var _unit:Int = 0;

		if (_snakeMovePiece == true || _ladderMovePiece == true)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// move can be made. create the new var used to move piece.
					if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceMaximumIndex[Reg._playerMoving] && Reg._gameDiceCurrentIndex[Reg._playerMoving] == Reg._gameDiceMinimumIndex[Reg._playerMoving]
					)
					{
						Reg._gameYYold = yy;
						Reg._gameXXold = xx;						
						
						// move piece and send data to other player so that both players move at the same time.
						if (_found == false && Reg._isThisPieceAtBackdoor == false && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false
						) 
						{	
							// triggers an event at PlayStateNetworkEventsIds.
							RegTriggers._eventForAllPlayers = false;
							Reg._pieceMovedUpdateServer = true;	
						}
						
						_found = true;
					}
				}
			}
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// move can be made. create the new var used to move piece.
					if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceCurrentIndex[Reg._playerMoving] && Reg._gameDiceCurrentIndex[Reg._playerMoving] == Reg._gameDiceMinimumIndex[Reg._playerMoving]
					)
					{
						Reg._gameDiceMinimumIndex[Reg._playerMoving] = 0;
						Reg._gameDiceMaximumIndex[Reg._playerMoving] = Reg._gameDiceCurrentIndex[Reg._playerMoving];
						
						if (ID == _id && _id == 1)
						{							
							Reg._gameYYnewA = yy;
							Reg._gameXXnewA = xx;
						}
						
						else if (ID == _id && _id == 2)
						{
							Reg._gameYYnewB = yy;
							Reg._gameXXnewB = xx;
						}
						
						movePieceNormally();							
					}
				}
			}
		}
		
		if (_snakeMovePiece == false && _ladderMovePiece == false)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// move can be made. create the new var used to move piece.
					if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceCurrentIndex[Reg._playerMoving] && Reg._gameDiceCurrentIndex[Reg._playerMoving] < Reg._gameDiceMaximumIndex[Reg._playerMoving]
					)
					{
						Reg._gameYYold = yy;
						Reg._gameXXold = xx;
						
						// move piece and send data to other player so that both players move at the same time.
						if (_found == false && Reg._isThisPieceAtBackdoor == false && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false
						) 
						{	
							// triggers an event at PlayStateNetworkEventsIds.
							RegTriggers._eventForAllPlayers = false;
							Reg._pieceMovedUpdateServer = true;	
						}
						
						_found = true;
					}
				}
			}
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// move can be made. create the new var used to move piece.
					if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceCurrentIndex[Reg._playerMoving] + 1 && Reg._gameDiceCurrentIndex[Reg._playerMoving] < Reg._gameDiceMaximumIndex[Reg._playerMoving]
					)
					{
						if (ID == _id && _id == 1)
						{							
							Reg._gameYYnewA = yy;
							Reg._gameXXnewA = xx;
						}
						
						else if (ID == _id && _id == 2)
						{
							Reg._gameYYnewB = yy;
							Reg._gameXXnewB = xx;
						}
						
						movePieceNormally();							
					}
				}
			}
		}		
	}
	
	
	override public function update (elapsed:Float)
	{
		if (Reg._gameOverForPlayer == false && Reg._gameId == 3)
		{
			// ######### MOVE PIECE TO UNIT #################################
			// this loop moves a piece that was clicked to the empty unit selected.
			if (Reg._gameMovePiece == true && Reg._gameDidFirstMove == true) // _gameId with a value of 0 is snakes and ladders.
			{			
				if (_id == 1 || _id == 2) isThereMovement();
			}
							
			// move the piece.
			if (Reg._hasPieceMovedFinished == 2 
			&&  Reg._gameDiceCurrentIndex[Reg._playerMoving] 
			==  Reg._gameDiceMaximumIndex[Reg._playerMoving]
			)
			{
				// this code is needed to update highlighted capturing unit. the moved to unit.
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// move can be made. create the new var used to move piece.
						if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceMaximumIndex[Reg._playerMoving])
						{
							if (ID == _id && _id == 1)
							{							
								Reg._gameYYnewA = yy;
								Reg._gameXXnewA = xx;
							}
							
							else if (ID == _id && _id == 2)
							{
								Reg._gameYYnewB = yy;
								Reg._gameXXnewB = xx;
							}
						}
					}
				}
					
				RegTriggers._eventForAllPlayers = true; // triggers an event at PlayStateNetworkEventsIds.
				
				// for a 2 player game, this code forces only 1 piece to be moved per player. for an offline game, this code moves pieces normally.
				if (Reg._move_number_current == Reg._move_number_next
				||  Reg._game_offline_vs_cpu == true
				||  Reg._game_offline_vs_player == true )
				{
					if (_id == 1 || _id == 2)
					 {				 
						// end the game if piece is at the end of the board.
						if (Reg._gameDiceMaximumIndex[Reg._playerMoving] >= 64)
						{
							__ids_win_lose_or_draw.canPlayerMove2();
							Reg._playerCanMovePiece = false;						
						}
						
						else 
						{
							Reg._number_wheel_ticks = 0;
							Reg._playerCanMovePiece = true;
						}
						
						// second time here, so the backdoor piece was updated. trigger the change of players.
						if (Reg._triggerNextStuffToDo == 1 && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._rolledA6 == false) Reg._pieceMovedUpdateServer = true;
						
						// if here then piece has been moved. prepare the vars to end movement. the Reg._isThisPieceAtBackdoor below these lines, will determine if at the back door, the other player, if the piece should be updated. update if Reg._isThisPieceAtBackdoor is true.
						Reg._hasPieceMovedFinished = 0;
						Reg._gameDidFirstMove = false;
						
						if (Reg._backdoorMoveValue != -1)
							RegTypedef._dataGame3._gameUnitNumberNew = Reg._backdoorMoveValue;
						Reg._backdoorMoveValue = -1;
						
						Reg._gameMovePiece = false;
						_doOnce = false;
						
						if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
						{
							if (Reg._triggerNextStuffToDo == 1)
							{
								 if (Reg._rolledA6 == true)
								 {
									// did the other player roll a 6. pass the roll dice message to that player, so that the player will only move again when received this message. because sometime the player not rolling has not finished moving.
									if (Reg._isThisPieceAtBackdoor == false)
									{								
										Reg._gameMessage = "Roll dice again.";
										RegTypedef._dataGameMessage._gameMessage = "Other player rolls dice again.";
										
										// send message to server then server to other client.
										PlayState.clientSocket.send("Game Message Not Sender", RegTypedef._dataGameMessage);
										haxe.Timer.delay(function (){}, Reg2._event_sleep);
										
										Reg._gameHost = true;
										RegFunctions.is_player_attacker(true);
										
										Reg._gameDidFirstMove = false;
										Reg._outputMessage = true;
										Reg._number_wheel_ticks = 0;
										Reg._playerCanMovePiece = true;
									}
									
									else
									{
										// other player that is waiting to move piece.
										Reg._gameHost = false;
										RegFunctions.is_player_attacker(false);
										
										Reg._gameDidFirstMove = true;
										Reg._playerCanMovePiece = false;
									}
								
									Reg._hasPieceMovedFinished = 0;
									Reg._triggerNextStuffToDo = 0;
									Reg._backdoorMoveValue = -1;
																		
									return;
								}
								
							}
							
							// Reg._isThisPieceAtBackdoor is set to true at SnakesAndLaddersClickMe.hx if Reg._backdoorMoveValue != -1
							if (Reg._isThisPieceAtBackdoor == true) 
							{
								Reg._isThisPieceAtBackdoor = false;
								Reg._number_wheel_ticks = 0;
								Reg._playerCanMovePiece = true;
								
								Reg._gameHost = true;
								RegFunctions.is_player_attacker(true);
						
							}
							else
							{
								// update the server because it is the other players turn to move piece.
								if (Reg._playerCanMovePiece == true) 
								{						
									// this is needed for basic notation buttons use.
									Reg._moveNumberCurrentForNotation = Reg._move_number_next;
						
									Reg._move_number_next += 1;
																
									// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
									if (Reg._move_number_next >= 2)
									Reg._move_number_next = 0;
									
									Reg._playerCanMovePiece = false;
									
									Reg._pieceMovedUpdateServer = true;		
									//Reg._triggerNextStuffToDo = 0;
									Reg._rolledA6 = false;
									
									Reg._gameHost = false;
									RegFunctions.is_player_attacker(false);
								}
								else 
								{
									Reg._number_wheel_ticks = 0;
									Reg._playerCanMovePiece = true;
								}								
							}
						}
						
						else
						{	// do this if not playing online. the other player can now move the piece. 2 player mode.
							if (Reg._triggerNextStuffToDo == 0)
							{							
								// this is needed for basic notation buttons use.
								Reg._moveNumberCurrentForNotation = Reg._move_number_next;
								if (Reg._backdoorMoveValue != -1)
									RegTypedef._dataGame3._gameUnitNumberNew = Reg._backdoorMoveValue;
								Reg._backdoorMoveValue = -1;
						
								Reg._move_number_next += 1;
																
								// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
								if (Reg._move_number_next >= 2)
								Reg._move_number_next = 0;
								
								
								if (Reg._gameHost == false) 
								{
									Reg._gameHost = true;
									RegFunctions.is_player_attacker(true);
								}
								else 
								{
									Reg._gameHost = false;
									RegFunctions.is_player_attacker(false);
								}
								
							} else  Reg._triggerNextStuffToDo = 0;
						}
					 }
				}
				
				
			}  
		}
		
		
		super.update(elapsed);		
	}
	
	private function movePieceNormally():Void
	{
		if (_id == 1 ||  _id == 2) 
		{			
			if (_snakeMovePiece == false && _ladderMovePiece == false) Reg._gameDiceCurrentIndex[Reg._playerMoving] += 1; 
			//else Reg._gameDiceCurrentIndex[Reg._playerMoving] -= 1;
			
			
			// should piece be moved.
			if (Reg._gameDiceCurrentIndex[Reg._playerMoving] == Reg._gameDiceMaximumIndex[Reg._playerMoving])
			{
				Reg._hasPieceMovedFinished = 2;
				_found = false;
			}
			
			movePiecePrepare();				
			
			
		}
		
		
	}
	
		private function snake1PlayerSlideDown(i:FlxTimer):Void
	{
		var _count = i.elapsedLoops;
		
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 5; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 5;
		
		// first find the top left corner of board then the snakes coordinates. those are used to slide the player down the snake. to set the player's piece at the head of this snake we minus the values of 38 and 48.
		if (_count <= 22)
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[0][_count] - 45;
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[0][_count] - 35;
		}
		else // last movement of the player that slides down the snake. this code aligns the player's image to the unit.
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[0][_count];
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[0][_count];
		}
		
		if (_count == 23) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;

	}
	
		
	private function snake2PlayerSlideDown(i:FlxTimer):Void
	{
		var _count = i.elapsedLoops;
		
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 7; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 7;
		
		// first find the top left corner of board then the snakes coordinates. those are used to slide the player down the snake. to set the player's piece at the head of this snake we minus the values of 38 and 48.
		if (_count <= 29)
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[1][_count] - 45;
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[1][_count] - 35;
		}
		else // last movement of the player that slides down the snake. this code aligns the player's image to the unit.
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[1][_count];
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[1][_count];
		}
		
		if (_count == 30) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
		
	}	
	
	private function snake3PlayerSlideDown(i:FlxTimer):Void
	{
		var _count = i.elapsedLoops;
		
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 31; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 31;
		
		// first find the top left corner of board then the snakes coordinates. those are used to slide the player down the snake. to set the player's piece at the head of this snake we minus the values of 38 and 48.
		if (_count <= 28)
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[2][_count] - 45;
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[2][_count] - 35;
		}
		else
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[2][_count];
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[2][_count];
		}
		
		if (_count == 29) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
				
	}
		
	private function snake4PlayerSlideDown(i:FlxTimer):Void
	{
		var _count = i.elapsedLoops;
		
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 23; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 23;
		
		// first find the top left corner of board then the snakes coordinates. those are used to slide the player down the snake. to set the player's piece at the head of this snake we minus the values of 38 and 48.
		if (_count <= 15)
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[3][_count] - 45;
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[3][_count] - 35;
		}
		else
		{
			y = Reg._unitYgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsY[3][_count];
			x = Reg._unitXgameBoardLocation[0] + Reg._snakePlayerSlideDownLocationsX[3][_count];
		}
		
		if (_count == 16) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
				
	}
	
	private function ladder1PlayerClimbIt(i:FlxTimer):Void
	{
		var _count = i.loopsLeft;
		
		if (_count == 0) 
		{
			_timerFinshed = true; 
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
	
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 32; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 32;

		y -= 15; // there is 75 height pixels per game board unit. 75 / 15 = 5. so 5 piece movements per unit.		
	}
	
	private function ladder2PlayerClimbIt(i:FlxTimer):Void
	{
		var _count = i.loopsLeft;
		
		if (_count == 0) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;

		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 63; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 63;
		
		y -= 15; // there is 75 height pixels per game board unit. 75 / 15 = 5. so 5 piece movements per unit.		
	}
	
	private function ladder3PlayerClimbIt(i:FlxTimer):Void
	{
		var _count = i.loopsLeft;
		
		if (_count == 0) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
		
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 44; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 44;

		y -= 15; // there is 75 height pixels per game board unit. 75 / 15 = 5. so 5 piece movements per unit.		
	}
	
	private function ladder4PlayerClimbIt(i:FlxTimer):Void
	{
		var _count = i.loopsLeft;
		
		if (_count == 0) 
		{
			_timerFinshed = true;
			Reg._hasPieceMovedFinished = 2;
		}
		else _timerFinshed = false;
	
		Reg._gameDiceCurrentIndex[Reg._playerMoving] = 40; 
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = 40; 

		y -= 15; // there is 75 height pixels per game board unit. 75 / 15 = 5. so 5 piece movements per unit.	
			
	}
} //