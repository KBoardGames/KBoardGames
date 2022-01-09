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
class SignatureGameDevelopedLandImages extends FlxSprite
{
	/******************************
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
		super(x, y+5);		
		//Reg._gameUndevelopedValueOfUnit[58]=0;
		ID = _id = id;
		
		_pieceValue = pieceValue -= 1;
		loadGraphic("modules/games/wheelEstate/assets/images/"+pieceValue+".png", false, 65, 65, true);
		
		// TODO not used. remove this undeveloped named var.
		//if (Reg._gameUndevelopedValueOfUnit[_id] > 0) visible = false; // stop two images displaying at start-up. 1:undeveloped and 0:developed.
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
			
				// is there a mortgage at this unit. this code look wrong but it works. if the current mortgage matches the value of the land, not house, then enter code. this code happens when there is a change at unit of the houses/services.
				if (SignatureGameMain._houseTaxiCafeAmountY[0] == SignatureGameMain._mortgageLandPriceCurrentUnitY && SignatureGameMain._houseTaxiCafeAmountY[0] > 0
				&&  SignatureGameMain._houseTaxiCafeAmountX[0] == SignatureGameMain._mortgageLandPriceCurrentUnitX && SignatureGameMain._houseTaxiCafeAmountX[0] > 0)
				{
					var _p = RegFunctions.getP(SignatureGameMain._mortgageLandPriceCurrentUnitY, SignatureGameMain._mortgageLandPriceCurrentUnitX);
					
					// for this instance only. is there mortgage at current unit.
					if (ID == _p && SignatureGameMain._mortgageLandPriceCurrentUnitY > -1 && SignatureGameMain._mortgageLandPriceCurrentUnitX > -1)
					{
						// unit is owned by nobody.
						SignatureGameMain._mortgageLandPriceCurrentUnitY = -1;
						SignatureGameMain._mortgageLandPriceCurrentUnitX = -1;
					}
				}
				
				
			}
			
			super.update(elapsed);
		}
		
		
	}
	

}
