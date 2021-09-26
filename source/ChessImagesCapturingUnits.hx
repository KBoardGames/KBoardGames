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
 * ...
 * @author kboardgames.com
 */
class ChessImagesCapturingUnits extends FlxSprite {

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
		
		loadGraphic("assets/images/capturingUnits.png", false);

		Reg._capturingUnitsForImages[0][_yID][_xID] = 0;
		Reg._capturingUnitsForImages[1][_yID][_xID] = 0;
		
		color = RegFunctions.color_show_capturing_units();
		visible = false;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 1)
		{
			RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
			
			
			//if (Reg._unitDistanceFromPiece[_yID][_xID] == 5) // delete 
			//visible = true; else visible = false; // delete
			/*
			if (Reg._chessKingAsQueen[Reg._playerNotMoving][_yID][_xID] > 0) //&& Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][_yID][_xID] == true 
			visible = true;
			else visible = false;
			*/
			
			if (Reg._chessUnitsInCheckTotal[Reg._playerMoving] == 1 && Reg._chessIsKingMoving == true
			&&  RegCustom._show_capturing_units[Reg._tn] == true)
			{
				// used to display the highlight units for the king in check correctly.
				if (Reg._gameDidFirstMove == true && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][_yID][_xID] == true && Reg._gamePointValueForPiece[_yID][_xID] != 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][_yID][_xID] <= 2 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[_yID][_xID] > 10

				|| Reg._gameDidFirstMove == true && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][_yID][_xID] == true && Reg._gamePointValueForPiece[_yID][_xID] != 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][_yID][_xID] <= 2 && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[_yID][_xID] > 0 && Reg._gamePointValueForPiece[_yID][_xID] < 11) visible = true;
				
				else if (Reg._gameDidFirstMove == true && Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][_yID][_xID] == true && Reg._gamePointValueForPiece[_yID][_xID] == 0 && Reg._capturingUnitsForPieces[Reg._playerNotMoving][_yID][_xID] == 0) visible = true;
				else 
				{
					visible = false;
				}
			}
			
			else
			{
				// when selecting a piece, these are the units the piece can move to.
				if (Reg._gameDidFirstMove == true && Reg._gameMovePiece == false && Reg._capturingUnitsForImages[Reg._playerMoving][_yID][_xID] > 0 && Reg._chessIsKingMoving == false
				&&  RegCustom._show_capturing_units[Reg._tn] == true
				) 
					visible = true;
				
				// highlight to and from but after the move is made.
				else if (Reg._gameXXold == _xID && Reg._gameYYold == _yID
				&&		 RegCustom._chess_show_last_piece_moved[Reg._tn] == true
				||		 Reg._gameXXold2 == _xID && Reg._gameYYold2 == _yID
				&&		 RegCustom._chess_show_last_piece_moved[Reg._tn] == true
				||		 Reg._gameXXnew2 == _xID && Reg._gameYYnew2 == _yID
				&&		 RegCustom._chess_show_last_piece_moved[Reg._tn] == true
				) 
					visible = true;
				
				// king moving to unit, highlights.
				else if (Reg._game_offline_vs_player == false
				&&		 Reg._game_offline_vs_cpu == false
				&&		 Reg._capturingUnitsForImages[Reg._playerMoving][_yID][_xID] > 0 
				&& 		 Reg._capturingUnitsForPieces[Reg._playerNotMoving][_yID][_xID] <= 2
				&&		 Reg._chessIsKingMoving == true 
				&&		 RegCustom._show_capturing_units[Reg._tn] == true)
					visible = true;
				else 
					visible = false;
				
			}
			
			
			// this is for the move history.
			if (Reg._gameOverForPlayer == true)
			{
				if (Reg._gameYYold == _yID && Reg._gameXXold == _xID
				||  Reg._gameYYnew == _yID && Reg._gameXXnew == _xID)
					visible = true;
				else if (Reg._gameYYold2 == _yID && Reg._gameXXold2 == _xID
				||       Reg._gameYYnew2 == _yID && Reg._gameXXnew2 == _xID)
					visible = true;
				else 
					visible = false;
			}
			//*/
			//trace(Reg._capturingUnitsForPieces[Reg._playerNotMoving][6][5]);
			super.update(elapsed);
		}
		
	}

}
