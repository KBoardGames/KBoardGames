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
 * TODO make a highlight piece to show where piece moved from.
 * ...move a piece over an opponents piece.
 * @author kboardgames.com
 */
class SignatureGameMovePlayersPiece extends FlxSprite {

	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
	
	/******************************   
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	/******************************
	 * game message and message popups when that player wins, loses or draws.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;

	/******************************
	 * true if player's piece is located at the board parameter.
	 */
	public var _pieceAtBoardParameter:Array<Bool> = [true, true, true, true];
	
	/******************************
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	
	private var _snake:FlxTimer;
	private var _snake2:FlxTimer;
	
	public function new (y:Float, x:Float, id:Int, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
	
		_startX = x;
		_startY = y;
		
		_id = id;
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;

		for (i in 1...5)
		{
			if (i == _id) 
			{
				loadGraphic("assets/images/signatureGame/player/"+i+".png", false, 75, 75, true);
				
				if (i == 1) color = Reg._game_piece_color1[0]; // red.
				if (i == 2) color = Reg._game_piece_color1[1]; // blue.
				if (i == 3) color = Reg._game_piece_color1[2]; // green.
				if (i == 4) color = Reg._game_piece_color1[3]; // yellow.
			}
		}
		
		
		
		_snake = new FlxTimer();
		_snake2 = new FlxTimer();
		
	}
	
	override public function destroy()
	{
		_pieceAtBoardParameter = [true, true, true, true];
	
		super.destroy();
	}
	
	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 4 && Reg._gameOverForPlayer == false && Reg._gameDidFirstMove == true || Reg._gameId == 4 && Reg._isThisPieceAtBackdoor == true && Reg._gameDidFirstMove == true)
		{
			if (Reg._isThisPieceAtBackdoor == false) RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
			
			movePiece();			
		}
		
		
		super.update(elapsed);
	}
	
	public function movePiece():Void
	{
		// move the piece if movement var is less than maximum value.
		if (_id == Reg._move_number_next + 1 && Reg._gameDiceCurrentIndex[Reg._move_number_next] != Reg._gameDiceMaximumIndex[Reg._move_number_next]
		)
		{						
			Reg._gameDiceCurrentIndex[Reg._move_number_next] = Reg._gameDiceMaximumIndex[Reg._move_number_next];
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gamePointValueForPiece[yy][xx] - 1 == Reg._gameDiceMaximumIndex[Reg._move_number_next])
					{
						// display the player's piece at a different unit.
						y = IDsCreateAndMain._gameBoard[0].y + yy * 75;
						x = IDsCreateAndMain._gameBoard[0].x + xx * 75;
						// this is used so that we can see if a player owns a unit. if the value of Reg._gameUniqueValueForPiece, its x and y, using this var, matches the player currently moving then we can do something such as buy house or pay rent. this is all done at SignatureGame.hx
						Reg._gameYYnew2 = yy;
						Reg._gameXXnew2 = xx;
					}
				}
			}
			
		}
		
		if (_pieceAtBoardParameter[Reg._move_number_next] == true)
		{
			//```````````````````````````````````
			// enter into inner icons.
			if (Reg._gameDiceCurrentIndex[Reg._move_number_next] == 7 && Reg._gameDiceMaximumIndex[Reg._move_number_next] == 7) 
			{
				_pieceAtBoardParameter[Reg._move_number_next]
= false;
				
				Reg._gameDiceCurrentIndex[Reg._move_number_next] = 7;
				Reg._gameDiceMaximumIndex[Reg._move_number_next] = 28;

				//updatePiece();
			}
			//```````````````````````````````````
			
		}					
		
		if (_pieceAtBoardParameter[Reg._move_number_next] == true)
		{
			//```````````````````````````````````
			// enter into inner icons.
			if (Reg._gameDiceCurrentIndex[Reg._move_number_next] == 21 && Reg._gameDiceMaximumIndex[Reg._move_number_next] == 21) 
			{
				_pieceAtBoardParameter[Reg._move_number_next]
= false;
				Reg._gameDiceCurrentIndex[Reg._move_number_next] = 21;
				Reg._gameDiceMaximumIndex[Reg._move_number_next] = 28;

				//updatePiece();
			}
			//```````````````````````````````````
			
		}	
			
		// should piece stay at outer icons?
		else if (_pieceAtBoardParameter[Reg._move_number_next] == true && Reg._gameDiceCurrentIndex[Reg._move_number_next] > 28) Reg._gameDiceCurrentIndex[Reg._move_number_next] = 1;
		
		// should piece be moved back to outer icons?
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > 47)
		{
			_pieceAtBoardParameter[Reg._move_number_next] = true;
			
			Reg._gameDiceCurrentIndex[Reg._move_number_next] = -1;
			Reg._gameDiceMaximumIndex[Reg._move_number_next] = 0;
			
			//updatePiece();
		}

		// outer movement. the same code works only when moving passed unit 27, avoiding it. without this code, going to unit 27 would set it to -1 because we are moving to lower unit values. if doing a mortgage, the vales would be calculated using a value of -1 given an error.
		/*if (_pieceAtBoardParameter[Reg._move_number_next] == true
		 && Reg._gameDiceCurrentIndex[Reg._move_number_next] == 27 && Reg._gameDiceMaximumIndex[Reg._move_number_next] != 27) 
		{
			Reg._gameDiceMaximumIndex[Reg._move_number_next] -= 28;
			Reg._gameDiceCurrentIndex[Reg._move_number_next] -= 28;
		}*/
		
		
		//Reg._gameMovePiece = true;
		
		// end the players turn.
		if (Reg._gameMovePiece == true)
		{
			if (Reg._gameDiceCurrentIndex[Reg._move_number_next] == Reg._gameDiceMaximumIndex[Reg._move_number_next])
			{
				// option to buy, sell, trade or pay rent at outer units. only show the sub state at the end of the move, for the player moving only
				if (Reg._game_offline_vs_cpu == true 
				||  Reg._game_offline_vs_player == true
				||  Reg._game_online_vs_cpu == true)
				{
					Reg._triggerNextStuffToDo = 1;
					
					if (Reg._playerCanMovePiece == true)
					{
						RegTriggers._signatureGame = true;
					}
					else 
					{
						changePlayer();
					}
				}
				
				else
				{
					if (Reg._gameDiceCurrentIndex[Reg._move_number_next] == Reg._gameDiceMaximumIndex[Reg._move_number_next] 
	&& Reg._triggerNextStuffToDo == 1
					)
					{
						//RegTriggers._signatureGame = true; 
					}
				}
			}
		}	
		
	}
	
	// if at unit 7, 21 or returning to unit 1, this function updates the piece so that it displays on one of these units. for example, if rolled a dice and landed on unit 7, this function will put the piece at unit 28.
	private function updatePiece():Void
	{
		if (_id == Reg._move_number_next + 1 && Reg._gameDiceCurrentIndex[Reg._move_number_next] == Reg._gameDiceMaximumIndex[Reg._move_number_next]
		)
		{						
			Reg._gameDiceCurrentIndex[Reg._move_number_next] = Reg._gameDiceMaximumIndex[Reg._move_number_next];
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gamePointValueForPiece[yy][xx] - 1 == Reg._gameDiceMaximumIndex[Reg._move_number_next])
					{						
						// display the player's piece at a different unit.
						y = IDsCreateAndMain._gameBoard[0].y + yy * 75;
						x = IDsCreateAndMain._gameBoard[0].x + xx * 75;
						// this is used so that we can see if a player owns a unit. if the value of Reg._gameUniqueValueForPiece, its x and y, using this var, matches the player currently moving then we can do something such as buy house or pay rent. this is all done at SignatureGame.hx
						Reg._gameYYnew2 = yy;
						Reg._gameXXnew2 = xx;
					}
				}
			}
			
		}
	}
	
	public static function changePlayer():Void
	{
		if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._game_online_vs_cpu == false)
		{
			// this is needed for basic notation buttons use.
			Reg._moveNumberCurrentForNotation = Reg._move_number_next;
			
			Reg._move_number_next += 1;
										
			// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
			if (Reg._move_number_next >= Reg._roomPlayerLimit - Reg._playerOffset)
			Reg._move_number_next = 0;

			Reg._gameXXnew = Reg._move_number_next;
						
			
			if (Reg._isThisPieceAtBackdoor == false) 
			{
				Reg._playerCanMovePiece = false;
				Reg._pieceMovedUpdateServer = true;
			}
			
			else 
			{
				Reg._number_wheel_ticks = 0;
				Reg._playerCanMovePiece = true;
			}
			
			Reg._isThisPieceAtBackdoor = false; 
		}
			
		// offline playing.
		else
		{
			// this is needed for basic notation buttons use.
			Reg._moveNumberCurrentForNotation = Reg._move_number_next;
			
			Reg._move_number_next += 1;
		
			// what player moves next. a value of 3 means its the third player. e.g, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
			if (Reg._move_number_next >= Reg._roomPlayerLimit - Reg._playerOffset)
			Reg._move_number_next = 0;
			
			Reg._move_number_current = Reg._move_number_next;
			
			if (Reg._gameHost == false) Reg._gameHost = true;
			else if (Reg._gameHost == true) Reg._gameHost = false;		
			
			Reg._pieceMovedUpdateServer = true;
			
		}
		
		
		Reg._gameDidFirstMove = false;				
		
	}
}//