/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * the dice wheel, highlights each number, in turn. from 1 to 6. the number highlighted, after a mouse click, is the number used to move a piece that many times from the piece's current location.
 * @author kboardgames.com
 */
class NumberWheel extends FlxSprite
{
	private var _ticks:Float = 0; // used to delay the display of this sprite.
	
	public function new(x:Float, y:Float) 
	{
		super(x, y-7);
		
		loadGraphic("assets/images/numberWheel.png", true, 198, 198);

		animation.add("run", [0, 1, 2, 3, 4, 5], 17); // faster = higher value.
		animation.play("run");	
		
	}
	
	private function showRotator(i:FlxTimer):Void
	{
		visible = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (RegTypedef._dataPlayers._spectatorWatching == false)
		{
			if (Reg._gameId == 3 || Reg._gameId == 4)
			{
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
				trace(Reg._gameDiceCurrentIndex[Reg._move_number_next] + " Reg._gameDiceCurrentIndex[Reg._move_number_next]");
				trace(Reg._gameDiceMaximumIndex[Reg._move_number_next] + " Reg._gameDiceMaximumIndex[Reg._move_number_next]");
				trace(Reg._triggerNextStuffToDo + " Reg._triggerNextStuffToDo");
				trace(Reg._playerMoving + " Reg._playerMoving");
				*/
				// animate this number wheel when these conditions are true.
				if (Reg._gameId != 3 
				&& Reg._move_number_current == Reg._move_number_next
				&& Reg._playerCanMovePiece == true 
				&& Reg._gameDidFirstMove == false 
				&& Reg._gameOverForPlayer == false 
				&& Reg._isThisPieceAtBackdoor == false
				&& Reg._gameDiceCurrentIndex[Reg._move_number_next]
				== Reg._gameDiceMaximumIndex[Reg._move_number_next]				
				||
				Reg._gameId == 3 
				&& Reg._game_offline_vs_cpu == true 
				&& Reg._playerCanMovePiece == true 
				&& Reg._gameDidFirstMove == false 
				&& Reg._gameOverForPlayer == false 
				&& Reg._isThisPieceAtBackdoor == false
				||
				Reg._gameId == 3 
				&& Reg._game_offline_vs_player == true 
				&& Reg._playerCanMovePiece == true 
				&& Reg._gameDidFirstMove == false 
				&& Reg._gameOverForPlayer == false 
				&& Reg._isThisPieceAtBackdoor == false
				|| Reg._gameId == 3 
				&& Reg._gameDiceCurrentIndex[Reg._playerMoving] == Reg._gameDiceMaximumIndex[Reg._playerMoving] 
				&& Reg._playerCanMovePiece == true 
				&& Reg._gameDidFirstMove == false 
				&& Reg._gameOverForPlayer == false 
				&& Reg._triggerNextStuffToDo == 0
				&& Reg._isThisPieceAtBackdoor == false) 
				{
					_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
					if (_ticks > 55) // at this value the animation will start.
					{
						_ticks = 0;
						
						RegTriggers._spriteGroup = Reg._playerMoving + 1;
						if (Reg._triggerNextStuffToDo < 2)
						{
							// this var here is used to roll again for player.
							Reg._rolledA6 = false;
							animation.play("run");
						}
						new FlxTimer().start(0.2, showRotator, 1);
					}
				}
				else // when Reg._playerCanMovePiece has a value of false, this code will be read. the animation will stop.
				{
					_ticks = 0;
					
					RegTriggers._spriteGroup = Reg._playerMoving + 1;
					animation.pause();
				}
				
				// if the player waiting to move and there is nothing more to do then clear this var so that this player can move again when its turn to move.
				if (Reg._gameId == 3
				&&  Reg._rolledA6 == true
				&&  Reg._backdoorMoveValue == -1
				&&  Reg._move_number_current
				==  Reg._move_number_next
				&&  Reg._triggerNextStuffToDo == 0
				&&  Reg._isThisPieceAtBackdoor == true
				&&  Reg._gameHost == false)
				{
					Reg._rolledA6 = false;
					
					Reg._move_number_next += 1;
																
					// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
					if (Reg._move_number_next >= 2)
					Reg._move_number_next = 0;
				}
				
				if (visible == false && Reg._gameOverForPlayer == false) new FlxTimer().start(0.2, showRotator, 1);
				if (visible == true && Reg._gameOverForPlayer == true) visible = false;

			
			}
		}
		
		
		super.update(elapsed);
	}
	
}