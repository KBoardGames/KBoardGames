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
 * ...this class displays an image at the location of king when king is in danger from a check or checkmate.
 * @author kboardgames.com
 */
class ChessImageFutureCapturingUnits extends FlxSprite
{
	/******************************
	 * location of unit.
	 */
	private var _xID:Int = 0;
	
	/******************************
	 * location of unit.
	 */
	private var _yID:Int = 0;
	
	/**
	 * the location of this, a unit image, is determined when this instance is created.
	 * @param	x		image coordinate.
	 * @param	y		image coordinate.
	 * @param	xID		unit coordinate (0-7)
	 * @param	yID		unit coordinate (0-7)
	 */
	public function new (yy:Float, xx:Float, xID:Int, yID:Int)
	{
		super(yy, xx);		
		
		_xID = xID;
		_yID = yID;
		
		loadGraphic("assets/images/futureCapturingUnits.png", true, 75, 75);
		animation.add("king", [0], 1, false);
		animation.add("path attacking piece", [1], 1, false);
		animation.add("path empty unit", [2], 1, false);
		
		color = RegFunctions.color_future_capturing_units();
		visible = false;
	}

	override public function update (elapsed:Float)
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		
		if (Reg._checkmate == false)
		{
			if (Reg._gameMovePiece == true) visible = false;
						
			// is the king in danger? if so then play the king animation to the display the image under the king,
			else if (Reg._chessKingYcoordinate[Reg._playerMoving] == _yID 
			&&  Reg._chessKingXcoordinate[Reg._playerMoving] == _xID
			&& Reg._gameDidFirstMove == false	
			)
			{
				visible = false;
				
				var _found:Bool = false;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						if (Reg._chessFuturePathToKing[Reg._playerNotMoving][yy][xx] == 1) _found = true;
						
					}
				}
				
				if (_found == true)
				{
					if (visible == false)
					{
						animation.play("king");						
						visible = true;
					}
				}				
				
			} 
		
			
			if (Reg._gameOverForPlayer == false)
			{
				RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
					
				// player has moved to a highlighted square. therefore, set this to zero.
				if (Reg._gameMovePiece == true) visible = false;
				
				else
				{
					if (RegCustom._game_skill_level_chess == 0
					&& Reg._chessFuturePathToKing[Reg._playerNotMoving][_yID][_xID] == 1
					//&& Reg._gameUniqueValueForPiece[_yID][_xID] != 50
					&& Reg._gameDidFirstMove == false)
					{
						if (visible == false) 
						{
							// currently, this future capturing feature is only for player 1, so this will highlight the white pieces king and any black piece.
							if (Reg._gamePointValueForPiece[_yID][_xID] > 10)
								animation.play("path attacking piece");
							else
								animation.play("path empty unit");

							visible = true;
						}
					}
				}
				
				if (Reg._chessFuturePathToKing[Reg._playerNotMoving][_yID][_xID] == 0) visible = false;
				
			}
			
				
		}
		
		else
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					Reg._chessFuturePathToKing[Reg._playerMoving][y][x] = 0;
					Reg._chessFuturePathToKing[Reg._playerNotMoving][y][x] = 0;
				}
			}
			
		}
		
		super.update(elapsed);
	}

}
