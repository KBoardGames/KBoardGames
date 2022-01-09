/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.wheelEstate;

/**
 * ...
 * @author kboardgames.com
 */
class SignatureGameUnitOwnershipImages extends FlxSprite {

	/*********************************************************************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	private var _ticks:Float = 0;
	private var _pieceValue:Int = 0;
	
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	str				the game board name and the folder to access. 
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (x:Float, y:Float, pieceValue:Int, id:Int)
	{
		super(x+1, y+6);		
		
		ID = _id = id;
		_pieceValue = pieceValue -= 1;
		
		loadGraphic("modules/games/wheelEstate/assets/images/ownership.png", false, 75, 75, true);
		color = 0xff0f0f0f;
	}

	override public function update (elapsed:Float)
	{
		if (Reg._gameId == 4 && Reg._gameOverForPlayer == false
		||  Reg._gameId == 4 && RegTypedef._dataPlayers._spectatorPlaying == true)
		{
			// delay updating data.
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			
			if (_ticks >= 40) 
			{
				_ticks = 0;
			
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						//if (_id == ID) visible = false;
						
						if (_id == ID // set unit tint back to default.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 0) 
						{
							color = 0xff0f0f0f;
						}
						
						if (_id == ID // red.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 1) 
						{
							visible = true;
							color = Reg._game_piece_color2[0];
						}
						
						if (_id == ID // blue.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 2) 
						{
							visible = true;
							color = Reg._game_piece_color2[1];
						}
						
						if (_id == ID // green.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 3)
						{
							visible = true;
							color = Reg._game_piece_color2[2];
						}
						
						if (_id == ID // yellow.
						&& (_pieceValue + 1) == Reg._gamePointValueForPiece[yy][xx]
						&& Reg._gameUniqueValueForPiece[yy][xx] == 4) 
						{
							visible = true;
							color = Reg._game_piece_color2[3];
						}
						
					}
				}
			}
		}
				
		super.update(elapsed);
	}

}
