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
 * ... a circle on a land refers to how many houses, taxi or cafe on that land. max 4 houses.
 * @author kboardgames.com
 */
class SignatureGameServicesCircleImages extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	/******************************
	 * // unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	 */
	private var p:Int = -1;	
	
	/******************************
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	str				the game board name and the folder to access. 
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (y:Float, x:Float, pieceValue:Int, p:Int)
	{
		super(y, x);		
		
		ID = _id = p;
		
		loadGraphic("assets/images/signatureGame/houseTaxiCafe/"+pieceValue+".png", false);
	}

	/******************************
	 * sets the rent bonus and group bonus for the land if player owns all land of that group.
	 * @param	_p	unit number.
	 * @return
	 */
	public static function setRentBonusAndBuildingGroups(_p:Int):Void
	{
		// if player owns a building group.
		// group 1.
		if (Reg._gameUniqueValueForPiece[7][1]
		==  Reg._gameUniqueValueForPiece[7][2]
		&&  Reg._gameUniqueValueForPiece[7][1]
		==  Reg._gameUniqueValueForPiece[7][3]
		&&  Reg._gameUniqueValueForPiece[7][1] > 0
		&&  Reg._gameUniqueValueForPiece[7][1] == _p + 1
		)
		{
			// increase the rent bonus. note that a rent bonus will only be given to you if you own a group. see SignatureGameSelect
			SignatureGameMain._rentBonus[_p][1] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][2] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][3] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			// if here, then player owns a group. the final rent will be the default _groupBonus value plus 0.75 of land value.
			SignatureGameMain._groupBonus[_p][1] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
			SignatureGameMain._groupBonus[_p][2] = SignatureGameMain._unitBuyingLandPrice[2] * 0.75;
			SignatureGameMain._groupBonus[_p][3] = SignatureGameMain._unitBuyingLandPrice[3] * 0.75;
		}
	
		// group 2.
		if (Reg._gameUniqueValueForPiece[5][7]
		==  Reg._gameUniqueValueForPiece[4][7]
		&&  Reg._gameUniqueValueForPiece[5][7] > 0
		&&  Reg._gameUniqueValueForPiece[5][7] == _p + 1
		)
		{
			SignatureGameMain._rentBonus[_p][9] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][10] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			SignatureGameMain._groupBonus[_p][9] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
			SignatureGameMain._groupBonus[_p][10] = SignatureGameMain._unitBuyingLandPrice[2] * 0.75;
		}
	
		// group 3.
		if (Reg._gameUniqueValueForPiece[2][7]
		==  Reg._gameUniqueValueForPiece[1][7]
		&&  Reg._gameUniqueValueForPiece[2][7] > 0
		&&  Reg._gameUniqueValueForPiece[2][7] == _p + 1
		)
		{
			SignatureGameMain._rentBonus[_p][12] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][13] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			SignatureGameMain._groupBonus[_p][12] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
			SignatureGameMain._groupBonus[_p][13] = SignatureGameMain._unitBuyingLandPrice[2] * 0.75;
		}
		
		// group 4.
		if (Reg._gameUniqueValueForPiece[0][6]
		==  Reg._gameUniqueValueForPiece[0][5]
		&&  Reg._gameUniqueValueForPiece[0][6] > 0
		&&  Reg._gameUniqueValueForPiece[0][6] == _p + 1
		)
		{
			SignatureGameMain._rentBonus[_p][15] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][16] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			SignatureGameMain._groupBonus[_p][15] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
			SignatureGameMain._groupBonus[_p][16] = SignatureGameMain._unitBuyingLandPrice[2] * 0.75;
		}
		
		// group 5.
		if (Reg._gameUniqueValueForPiece[0][1] == _p
		&&  Reg._gameUniqueValueForPiece[0][1] > 0
		&&  Reg._gameUniqueValueForPiece[0][1] == _p + 1
		)
		{
			SignatureGameMain._rentBonus[_p][20] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			SignatureGameMain._groupBonus[_p][20] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
		}
		
		// group 6.
		if (Reg._gameUniqueValueForPiece[3][24]
		==  Reg._gameUniqueValueForPiece[4][25]
		&&  Reg._gameUniqueValueForPiece[3][24]
		==  Reg._gameUniqueValueForPiece[5][26]
		&&  Reg._gameUniqueValueForPiece[3][24]
		==  Reg._gameUniqueValueForPiece[6][27]
		&&  Reg._gameUniqueValueForPiece[3][24] > 0
		&&  Reg._gameUniqueValueForPiece[3][24] == _p + 1
		)
		{
			// increase the rent bonus. note that a rent bonus will only be given to you if you own a group. see SignatureGameSelect
			SignatureGameMain._rentBonus[_p][24] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][25] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][26] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			SignatureGameMain._rentBonus[_p][27] = (RegTypedef._dataGame4._rentBonus[_p] * 50);
			
			// if here, then player owns a group. the final rent will be the default _groupBonus value plus 0.75 of land value.
			SignatureGameMain._groupBonus[_p][24] = SignatureGameMain._unitBuyingLandPrice[1] * 0.75;
			SignatureGameMain._groupBonus[_p][25] = SignatureGameMain._unitBuyingLandPrice[2] * 0.75;
			SignatureGameMain._groupBonus[_p][26] = SignatureGameMain._unitBuyingLandPrice[3] * 0.75;
			SignatureGameMain._groupBonus[_p][27] = SignatureGameMain._unitBuyingLandPrice[4] * 0.75;
		}		
		
		//############################# TAXI
		
		if (Reg._gameUniqueValueForPiece[7][4]
		==  Reg._gameUniqueValueForPiece[6][7]
		&&  Reg._gameUniqueValueForPiece[7][4]
		==  Reg._gameUniqueValueForPiece[0][3]
		&&  Reg._gameUniqueValueForPiece[7][4]
		==  Reg._gameUniqueValueForPiece[2][0]
		&&  Reg._gameUniqueValueForPiece[7][4] > 0
		&&  Reg._gameUniqueValueForPiece[7][4] == _p + 1
		)
		{
			// increase the rent bonus. note that a rent bonus will only be given to you if you own a group. see SignatureGameSelect
			SignatureGameMain._rentBonus[_p][4] = (RegTypedef._dataGame4._rentBonus[_p] * 80);
			SignatureGameMain._rentBonus[_p][8] = (RegTypedef._dataGame4._rentBonus[_p] * 80);
			SignatureGameMain._rentBonus[_p][18] = (RegTypedef._dataGame4._rentBonus[_p] * 80);
			SignatureGameMain._rentBonus[_p][23] = (RegTypedef._dataGame4._rentBonus[_p] * 80);
			
			// if here, then player owns a group. the final rent will be the default _groupBonus value plus 0.75 of land value.
			SignatureGameMain._groupBonus[_p][4] = SignatureGameMain._unitBuyingLandPrice[1] * 1.05;
			SignatureGameMain._groupBonus[_p][8] = SignatureGameMain._unitBuyingLandPrice[2] * 1.05;
			SignatureGameMain._groupBonus[_p][18] = SignatureGameMain._unitBuyingLandPrice[3] * 1.05;
			SignatureGameMain._groupBonus[_p][23] = SignatureGameMain._unitBuyingLandPrice[4] * 1.05;
		}
		
		//############################# CAFE
		
		if (Reg._gameUniqueValueForPiece[7][5]
		==  Reg._gameUniqueValueForPiece[3][7]
		&&  Reg._gameUniqueValueForPiece[7][5]
		==  Reg._gameUniqueValueForPiece[0][4]
		&&  Reg._gameUniqueValueForPiece[7][5]
		==  Reg._gameUniqueValueForPiece[1][0]
		&&  Reg._gameUniqueValueForPiece[7][5] > 0
		&&  Reg._gameUniqueValueForPiece[7][5] == _p + 1
		)
		{
			// increase the rent bonus. note that a rent bonus will only be given to you if you own a group. see SignatureGameSelect
			SignatureGameMain._rentBonus[_p][5] = (RegTypedef._dataGame4._rentBonus[_p] * 65);
			SignatureGameMain._rentBonus[_p][11] = (RegTypedef._dataGame4._rentBonus[_p] * 65);
			SignatureGameMain._rentBonus[_p][17] = (RegTypedef._dataGame4._rentBonus[_p] * 65);
			SignatureGameMain._rentBonus[_p][22] = (RegTypedef._dataGame4._rentBonus[_p] * 65);
			
			// if here, then player owns a group. the final rent will be the default _groupBonus value plus 0.75 of land value.
			SignatureGameMain._groupBonus[_p][5] = SignatureGameMain._unitBuyingLandPrice[1] * 0.90;
			SignatureGameMain._groupBonus[_p][11] = SignatureGameMain._unitBuyingLandPrice[2] * 0.90;
			SignatureGameMain._groupBonus[_p][17] = SignatureGameMain._unitBuyingLandPrice[3] * 0.90;
			SignatureGameMain._groupBonus[_p][22] = SignatureGameMain._unitBuyingLandPrice[4] * 0.90;
		}
	}
}
