/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.wheelEstate;

/**
 * @author kboardgames.com
 */
class SignatureGame extends FlxGroup
{
	public static var _sprite_board_game_unit_even:FlxSprite;
	public static var _sprite_board_game_unit_odd:FlxSprite;

	/******************************
	 * alternating colors of game board squares. this is the light color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorDark:Array<FlxColor> = [0xFFc2d93c, 0xFF9d6253, 0xFF003300, 0xFFf5f151, 0x00000000];
	
	/******************************
	 * alternating colors of game board squares. this is the dark color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorLight:Array<FlxColor> = [0xFF114c2e, 0xFF562a20, 0xFF004400, 0xFFf5515a, 0x00000000];
	
	/******************************
	 * the unit is highlighted when the mouse is clicked on it.
	 */
	public var __game_image_current_unit:GameImageCurrentUnit;
	
	private var __game_create:GameCreate;
		
	override public function new(game_create:GameCreate):Void
	{
		super();
		
		__game_create = game_create;
		
		var i = -1;
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				i += 1;				
				
				if (Reg._gameId == 4 && y > 1 && y < 6 && x > 1 && x < 6) {} // don't draw center unit if playing the signature game.
				else
				{		
					// a standard gameboard.
					GameCreate._gameBoard[i] = new FlxSprite();
					GameCreate._gameBoard[i].loadGraphic("assets/images/gameboardUnit.png", false);
					GameCreate._gameBoard[i].setPosition(Reg._unitXgameBoardLocation[x], Reg._unitYgameBoardLocation[y]);
					
					// draw each board unit creating the game board.
					if (y == 0 || y == 2 || y == 4 || y == 6) // every second row.
					{
						// draw colored blocks
						if (FlxMath.isOdd(i) == true) 
						{
							GameCreate._gameBoard[i].color = _unitgameBoardColorLight[Reg._gameId]; 
						}
						
						else
						{
							GameCreate._gameBoard[i].color = _unitgameBoardColorDark[Reg._gameId];
						}
					} 
					else	
					{
						// draw blocks in reverse color. even is odd and odd is even.
						if (FlxMath.isEven(i) == true)
						{
							GameCreate._gameBoard[i].color = _unitgameBoardColorLight[Reg._gameId];
							
						}
						
						else
						{
							GameCreate._gameBoard[i].color = _unitgameBoardColorDark[Reg._gameId];
						}
					}

					GameCreate._gameBoard[i].scrollFactor.set(0, 0);
					add(GameCreate._gameBoard[i]);
				}
				
			}
		}
		
	}
	
	public function default_layout_signature_game():Void
	{
		// dice moves in this order. 0: not a playable unit
		Reg._gamePointValueOfUnit = [
		22, 21, 20, 19, 18, 17, 16, 15,
		23, 44, 43, 42, 41, 40, 39, 14,
		24, 45,  0,  0,  0,  0, 38, 13,
		25, 46,  0,  0,  0,  0, 37, 12,
		26, 47,  0,  0,  0,  0, 36, 11,
		27, 48,  0,  0,  0,  0, 35, 10,
		28, 29, 30, 31, 32, 33, 34,  9,
		 1,  2,  3,  4,  5,  6,  7,  8
		];
		
		// -1 = not used. 0 = nobody owns this unit. 1 = player 1's unit. 2:player 2's unit. 3:player 3's unit. 4:player 4's unit.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0, -1, -1, -1, -1,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		// the total amount of houses, taxi cabs and cafe stores that a player has.
		Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		// This is used to determine if unit is a 1:house. 2:taxi cab. 3:cafe store. this var can be used with 2 vars such as the Reg._gameYYold and Reg._gameXXold to find its value.
		Reg._gameHouseTaxiCabOrCafeStoreTypeOfUnit = [
		 0,  1,  0,  2,  3,  1,  1,  0,
		 3,  0,  0,  0,  0,  0,  0,  1,
		 2,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  3,
		 1,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  1,
		 1,  0,  0,  0,  0,  0,  0,  2,
		 0,  1,  1,  1,  2,  3,  0,  0
		];
			
		// building groups.
		Reg._gameUnitGroupsValueOfUnit = [
		 0,  5,  0,  0,  0,  4,  4,  0,
		 0,  0,  0,  0,  0,  0,  0,  3,
		 0,  0,  0,  0,  0,  0,  0,  3,
		 6,  0,  0,  0,  0,  0,  0,  0,
		 6,  0,  0,  0,  0,  0,  0,  2,
		 6,  0,  0,  0,  0,  0,  0,  2,
		 6,  0,  0,  0,  0,  0,  0,  0,
		 0,  1,  1,  1,  0,  0,  0,  0
		];
	}
		
	public function create_signature_game():Void
	{
		var p = -1; // gameboard pieces.
			
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				Reg._gameHouseTaxiCabOrCafeStoreForPiece[y][x] = Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[p];					
				Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] = Reg._gameHouseTaxiCabOrCafeStoreTypeOfUnit[p];					
				Reg._gameUnitGroupsForPiece[y][x] = Reg._gameUnitGroupsValueOfUnit[p];				
				
			}
		}
		
		var p = -1; // gameboard pieces.
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// highlights any square, with an image, that the player is able to move the piece to.
				if (y > 1 && y < 6 && x > 1 && x < 6) {} // don't draw centre unit if playing the signature game.
				else
				{
					var _gameOwnershipImages = new 
					SignatureGameUnitOwnershipImages(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75) - 4, Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
					_gameOwnershipImages.scrollFactor.set(0, 0);
					__game_create._groupPlayerPieces.add(_gameOwnershipImages);
					
					// note that the x and y values here are reverse of the class. it works. don't change them.
					var _gameDevelopedLandIcons = new 
					SignatureGameDevelopedLandImages(GameCreate._gameBoard[0].x + (x * 75) + 5, GameCreate._gameBoard[0].y + (y * 75) + 5, Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
					_gameDevelopedLandIcons.scrollFactor.set(0, 0);
					__game_create._groupPlayerPieces.add(_gameDevelopedLandIcons);
															
					__game_create.__game_house_taxi_cafe = new 
					SignatureGameReferenceImages(GameCreate._gameBoard[0].x + (x * 75) + 5, GameCreate._gameBoard[0].y + (y * 75) + 5, Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[p], p); // pieces are 75x75 pixels wide.
					__game_create.__game_house_taxi_cafe.scrollFactor.set(0, 0);
					__game_create._groupPlayerPieces.add(__game_create.__game_house_taxi_cafe);
					
					add(__game_create._groupPlayerPieces);
					
				}
			}
		}			
		
		//#############################  PLAYER'S PIECE
		__game_create.addSpriteGroup();
					
		__game_create.__signature_game_main = new SignatureGameMain();
		add(__game_create.__signature_game_main);
					
		__game_create.gameId_dice(FlxG.width - 283, FlxG.height - 453);		
	
		if (Reg._gameId == 4) 
		{	
			var _informationCards = new SignatureGameInformationCards(GameCreate._gameBoard[0].y, GameCreate._gameBoard[0].x);
			add(_informationCards);

		}
		
		RegTypedef._dataMovement._history_get_all = 0;
		
		// unit is surrounded by a border at the location of the mouse. when the mouse moves around the grid then so does this border move.
		__game_image_current_unit = new GameImageCurrentUnit(GameCreate._gameBoard[0].y, GameCreate._gameBoard[0].x);
		__game_image_current_unit.scrollFactor.set(0, 0);
		add(__game_image_current_unit);
	}
	
	public static function server_data():Void
	{
		// these are the vars needed to move a piece.
		RegTypedef._dataGame4._gameXXold = Reg._gameXXold;
		RegTypedef._dataGame4._gameYYold = Reg._gameYYold;
		
		// this var is being used.
		RegTypedef._dataGame4._gameXXnew = Reg._gameXXnew;
		RegTypedef._dataGame4._gameYYnew = Reg._gameYYnew;
		
		
		RegTypedef._dataGame4._gameXXold2 = Reg._gameXXold2; // other piece. the unit of the player you would like to trade with.
		RegTypedef._dataGame4._gameYYold2 = Reg._gameYYold2; // other piece.
		RegTypedef._dataGame4._gameXXnew2 = Reg._gameXXnew2; // trading your piece.
		RegTypedef._dataGame4._gameYYnew2 = Reg._gameYYnew2; // trading your piece.
		RegTypedef._dataGame4._gameUniqueValueForPiece = Reg._gameUniqueValueForPiece;
		RegTypedef._dataGame4._unitNumberTrade = Reg._signatureGameUnitNumberTrade;
		RegTypedef._dataGame4._gameUniqueValueForPiece = Reg._gameUniqueValueForPiece;
		RegTypedef._dataGame4._gameHouseTaxiCabOrCafeStoreForPiece = Reg._gameHouseTaxiCabOrCafeStoreForPiece;
	}
}