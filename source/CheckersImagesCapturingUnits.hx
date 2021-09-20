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
 * ...highlights the capturing unit using an image from this class.
 * @author kboardgames.com
 */
class CheckersImagesCapturingUnits extends FlxSprite {

	/******************************
	 * location of unit.
	 */
	private var _xID:Int = 0;
	
	/******************************
	 * location of unit.
	 */
	private var _yID:Int = 0;
	
	/******************************
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
		
		loadGraphic("assets/images/capturingUnits.png", false);

		Reg._capturingUnitsForImages[0][_yID][_xID] = 0;
		Reg._capturingUnitsForImages[1][_yID][_xID] = 0;
		
		color = RegFunctions.color_show_capturing_units();
		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 0)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
				
			if (Reg._gameOverForPlayer == false)
			{
				// player has moved to a highlighted square. therefore, set this to zero.
				if (Reg._gameMovePiece == true && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false
				||  Reg._gameMovePiece == true && Reg._playerMoving == 0 && Reg._game_offline_vs_cpu == true
				||  Reg._gameMovePiece == true && Reg._playerMoving == 0 && Reg._game_offline_vs_player == true
				) Reg._capturingUnitsForPieces[Reg._playerMoving][_yID][_xID] = 0;
				
				if (Reg._capturingUnitsForPieces[Reg._playerMoving][_yID][_xID] > 0
				&&  RegCustom._show_capturing_units[Reg._tn] == true) 
					visible = true
				
				else if (Reg._game_offline_vs_cpu == false 
				|| Reg._playerMoving == 1 
				&& Reg._game_offline_vs_cpu == true 
				|| Reg._playerMoving == 1 
				&& Reg._game_offline_vs_player == true
				|| Reg._playerMoving == 0 
				&& ActionInput.justPressed() == true 
				&& Reg._game_offline_vs_cpu == true
				|| Reg._playerMoving == 0 
				&& ActionInput.justPressed() == true 
				&& Reg._game_offline_vs_player == true) visible = false;
			
				
				// piece has moved from here to there. now highlight the piece's move.
				if (Reg._gamePointValueForPiece[_yID][_xID] == 0 
				&& _yID == Reg._gameYYold
				&& _xID == Reg._gameXXold) 
					visible = true;
			
				// highlight the moved piece but only after that piece was moved.
				if (Reg._gameDidFirstMove == false
				)
				{
					if (_yID == Reg._gameYYnew
					&&  _xID == Reg._gameXXnew) 
						visible = true;
					
				}
			}
			
			// this is for the move history.
			if (Reg._gameOverForPlayer == true
			||	RegTypedef._dataPlayers._spectatorWatching == true)
			{
				visible = false;
				
				if (Reg._gameYYold == _yID && Reg._gameXXold == _xID
				||  Reg._gameYYnew == _yID && Reg._gameXXnew == _xID)
					visible = true;
													
			}			
			
		}		
					
		super.update(elapsed);
	}

}
