/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.snakesAndLadders;

/**
 * ...
 * @author kboardgames.com
 */
class SnakesAndLaddersClickMe extends FlxSprite
{
	public var __number_wheel:NumberWheel;
	
	public function new(x:Float, y:Float, number_wheel:NumberWheel) 
	{
		super(x, y);
		
		__number_wheel = number_wheel;
		
		loadGraphic("assets/images/clickMe.png", true, 198, 198);	
	}
	
	override public function update(elapsed:Float):Void 
	{
		/*
		if (ActionInput.justPressed() == true) 
		{
			trace("------------------------------------------");
			trace(Reg._backdoorMoveValue + " Reg._backdoorMoveValue");
			trace(Reg._move_number_current + " _move_number_current"); 
			trace(Reg._move_number_next + " _move_number_next");
			trace(Reg._playerCanMovePiece + " _playerCanMovePiece"); 
			trace(Reg._gameDidFirstMove + " _gameDidFirstMove"); 
			trace(Reg._gameOverForPlayer + " _gameOverForPlayer"); 
			trace(Reg._gameOverForAllPlayers + " _gameOverForAllPlayers"); 
			trace(Reg._isThisPieceAtBackdoor + " _isThisPieceAtBackdoor");
			trace(Reg._gameDiceCurrentIndex[Reg._playerMoving] + " Reg._gameDiceCurrentIndex[Reg._playerMoving]");
			trace(Reg._gameDiceMaximumIndex[Reg._playerMoving] + " Reg._gameDiceMaximumIndex[Reg._playerMoving]");
			trace(Reg._triggerNextStuffToDo + " Reg._triggerNextStuffToDo");
			trace(Reg._playerMoving + " Reg._playerMoving");
			trace(Reg._gameHost + " Reg._gameHost");
			trace(Reg._rolledA6 + " Reg._rolledA6");
			trace("------------------------------------------");	
		}
		*/
		
		// move player's piece when this image is clicked
		if (Reg._backdoorMoveValue != -1 || Reg._playerCanMovePiece == true && ActionInput.overlaps(this) && ActionInput.justPressed() == true && __number_wheel.animation.paused == false && RegTypedef._dataMisc._spectatorWatching == false && Reg._at_input_keyboard == false)
		{
			Reg._number_wheel_get_value = true;
			//Reg._number_wheel_ticks = 0;
			
			__number_wheel.animation.pause();
				
		}
		
		if (Reg._number_wheel_get_value == true)
		{
			if (Reg._number_wheel_ticks > 1)
			{
				Reg._number_wheel_get_value = false;
				Reg._number_wheel_ticks = 0;
				
				if (Reg._triggerNextStuffToDo == 1) Reg._triggerNextStuffToDo = 0;
			
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 0)
				{
					Reg._gameYYold = -1;
					Reg._gameXXold = -1;
					Reg._gameYYold2 = -1;
					Reg._gameXXold2 = -1;
				}
			
				// backdoor. make the value of the dice equal the backdoor value.
				if (Reg._backdoorMoveValue != -1 
				&&  Reg._move_number_current == Reg._move_number_next
				)
				{
					Reg._gameHost = false;
					RegFunctions.is_player_attacker(false);
					
					Reg._gameDiceMinimumIndex[Reg._playerMoving] = Reg._gameDiceMaximumIndex[Reg._playerMoving];
					Reg._gameDiceMaximumIndex[Reg._playerMoving] = Reg._backdoorMoveValue;
					
					Reg._triggerNextStuffToDo = 1;
					Reg._hasPieceMovedFinished = 2; 
					Reg._isThisPieceAtBackdoor = true;
				
					/*
					trace("------------------------------------------");
					trace(Reg._backdoorMoveValue + " Reg._backdoorMoveValue");
					trace(Reg._move_number_current + " _move_number_current"); 
					trace(Reg._move_number_next + " _move_number_next");
					trace(Reg._playerCanMovePiece + " _playerCanMovePiece"); 
					trace(Reg._gameDidFirstMove + " _gameDidFirstMove"); 
					trace(Reg._gameOverForPlayer + " _gameOverForPlayer"); 
					trace(Reg._gameOverForAllPlayers + " _gameOverForAllPlayers"); 
					trace(Reg._isThisPieceAtBackdoor + " _isThisPieceAtBackdoor");
					trace(Reg._gameDiceCurrentIndex[Reg._playerMoving] + " Reg._gameDiceCurrentIndex[Reg._playerMoving]");
					trace(Reg._gameDiceMaximumIndex[Reg._playerMoving] + " Reg._gameDiceMaximumIndex[Reg._playerMoving]");
					trace(Reg._triggerNextStuffToDo + " Reg._triggerNextStuffToDo");
					trace(Reg._playerMoving + " Reg._playerMoving");
					trace(Reg._gameHost + " Reg._gameHost");
					trace(Reg._rolledA6 + " Reg._rolledA6");
					trace("------------------------------------------");
					*/
					
				}
				// this maximum var is the last move of the normal var.
				else
				{
					if (Reg._isThisPieceAtBackdoor == false && Reg._rolledA6 == false)
					{
						Reg._gameDiceMinimumIndex[Reg._playerMoving] = Reg._gameDiceMaximumIndex[Reg._playerMoving];
						Reg._gameDiceMaximumIndex[Reg._playerMoving] += __number_wheel.animation.curAnim.curIndex + 1;
						Reg._backdoorMoveValue = Reg._gameDiceMaximumIndex[Reg._playerMoving];
					}
				} 
				
				// TODO is this needed.
				//Reg._gameDiceMinimumIndex[Reg._playerMoving] = Reg._gameDiceCurrentIndex[Reg._playerMoving];
				
				// roll dice again.
				if (__number_wheel.animation.curAnim.curIndex + 1 == 6 && Reg._gameDiceMaximumIndex[Reg._playerMoving] < 64) 
				{
					Reg._rolledA6 = true;
					
					//if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) Reg._backdoorMoveValue = 0;
					Reg._triggerNextStuffToDo = 1; // a value of 1 means that the same player will roll again.
				}
			
					
				// don't move beyond the last unit to move to.
				if (Reg._gameDiceMaximumIndex[Reg._playerMoving] > 64)
				{
					Reg._gameDiceMaximumIndex[Reg._playerMoving] = 64;
				}
				
				Reg._gameMovePiece = true;
				Reg._gameDidFirstMove = true;
				
				// the player rolled the dice. the other player, that piece needs to move too, so this var is used to update the other client if not -1.
				//if (Reg._backdoorMoveValue != -1) Reg._isThisPieceAtBackdoor = true;
				//Reg._backdoorMoveValue = -1;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						if (Reg._gamePointValueForPiece[yy][xx] == Reg._gameDiceMaximumIndex[Reg._playerMoving]) 
						{
							// this value is the max unit the player moves to.
							Reg._gameYYnew = yy;
							Reg._gameXXnew = xx;
						}
					}
				}
				
				visible = false;
			}
			
			if (Reg._number_wheel_ticks < 2)
				Reg._number_wheel_ticks += 1;
		}
		
		// highlighted unit where the piece moved from.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// if not zero then this player has already moved from the start position. the _gameYYold and _gameXXold vars are used to stop the player at that unit when reached.
				Reg._gameYYold = yy;
				Reg._gameXXold = xx;
				
				if (Reg._gamePointValueForPiece[yy][xx] 
				==  Reg._gameDiceMinimumIndex[1]
				&&  Reg._gameDiceMinimumIndex[1]
				<   Reg._gameDiceMaximumIndex[1]) 
				{
					Reg._gameYYoldA = yy;
					Reg._gameXXoldA = xx;
												
				}
				
				if (Reg._gamePointValueForPiece[yy][xx] 
				==  Reg._gameDiceMinimumIndex[0]
				&&  Reg._gameDiceMinimumIndex[0]
				<   Reg._gameDiceMaximumIndex[0]) 
				{							
					Reg._gameYYoldB = yy;
					Reg._gameXXoldB = xx;
												
				}
			}
		}
		
		if (Reg._playerCanMovePiece == true && __number_wheel.animation.paused == false) 
		{			
			visible = true;
		}
		
		
		if (visible == false && Reg._gameOverForPlayer == false) visible = true; 
		if (visible == true && Reg._gameOverForPlayer == true) visible = false;

		
		super.update(elapsed);
		
		
	}
}