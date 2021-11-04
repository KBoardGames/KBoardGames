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
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * @author kboardgames.com
 */
class Reversi extends FlxGroup
{
	public static var _sprite_board_game_unit_even:FlxSprite;
	public static var _sprite_board_game_unit_odd:FlxSprite;
	
	/******************************
	 * alternating colors of game board squares. this is the light color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorDark:Array<FlxColor> = [0xFFc2d93c, 0xFF9d6253, 0xFF003300, 0xFFf5f151, 0xFFbbbbbb];
	
	/******************************
	 * alternating colors of game board squares. this is the dark color units.
	 * see private function SignatureGameUnitOwnership.unitOwnership() to change the signature game background color that is displayed underneath the icons.
	 */
	public var _unitgameBoardColorLight:Array<FlxColor> = [0xFF114c2e, 0xFF562a20, 0xFF004400, 0xFFf5515a, 0xFFffffff];
	
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
	
	public function default_layout_reversi():Void
	{
		/*Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  1,  1,  0,  0,  0,
		 0,  0,  0, 11,  1,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  1, 11,  1,  0,  0,  0
		];
		
		// in the Reversi game the _gameUniqueValueOfUnit var is not needed.
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		 0,  0,  1, 11,  1,  1,  1, 11,
		 0,  1,  1,  1,  1,  1,  1, 11,
		11,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1,  1,  1,  1,  1,  1,  1, 11,
		 1, 11,  1,  1,  1, 11, 11, 11,
		 1,  1,  1,  1,  1,  1, 11, 11
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		*/	
		Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		/*Reg._gamePointValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  1, 11,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];
		
		Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0
		];*/
	}
	
	public function create_reversi_game():Void
	{
		var p = -1; // gameboard pieces.
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._capturingUnitsForImages[0][y][x] = 0;
				Reg._capturingUnitsForImages[1][y][x] = 0;
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				
				// highlights any square, with an image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnits = new ReversiImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), x, y);					
				_capturingUnits.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnits);
				add(__game_create._groupCapturingUnit);			
				
				var _playerPieces = new ReversiMovePlayersPiece(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
				_playerPieces.scrollFactor.set(0, 0);
				__game_create._groupPlayerPieces.add(_playerPieces);
				add(__game_create._groupPlayerPieces);
				
				// add the white pieces to this group.
				if (Reg._gamePointValueOfUnit[p] < 11 && Reg._gamePointValueOfUnit[p] > 0) // value 11+ is second player's gameboard pieces. 
				{
					Reg._groupPlayer1.add(_playerPieces);
					add(Reg._groupPlayer1);
				}
				
				// add the black pieces to this group.
				else if (Reg._gamePointValueOfUnit[p] >= 11) 
				{				
					Reg._groupPlayer2.add(_playerPieces);
					add(Reg._groupPlayer2);
				}
			}
		}
		
		// the unit is highlighted when the mouse is clicked on it.
		var _currentUnitClicked = new ReversiCurrentUnitClicked(Std.int(GameCreate._gameBoard[0].y), Std.int(GameCreate._gameBoard[0].x), __game_create.__ids_win_lose_or_draw);
		_currentUnitClicked.scrollFactor.set(0, 0);
		add(_currentUnitClicked);
		
		var _reversi_unit_total = new ReversiUnitsTotal();
		add(_reversi_unit_total);
		
		RegTypedef._dataMovement._history_get_all = 0;
		
		// unit is surrounded by a border at the location of the mouse. when the mouse moves around the grid then so does this border move.
		__game_image_current_unit = new GameImageCurrentUnit(GameCreate._gameBoard[0].y, GameCreate._gameBoard[0].x);
		__game_image_current_unit.scrollFactor.set(0, 0);
		add(__game_image_current_unit);
	}
	
	public static function server_data():Void
	{
		RegTypedef._dataGame2._gameXXold = Reg._gameXXold;
		RegTypedef._dataGame2._gameYYold = Reg._gameYYold;
		//RegTypedef._dataGame2._pieceValue = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
		RegTypedef._dataGame2._pointValue2 = Reg._pieceNumber + 1;
		RegTypedef._dataGame2._triggerNextStuffToDo = Reg._triggerNextStuffToDo; // Reversi. used to place the four piece on the board.
	}
}