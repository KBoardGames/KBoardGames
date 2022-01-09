/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.snakesAndLadders;

/**
 * @author kboardgames.com
 */
class SnakesAndLadders extends FlxGroup
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
		
	public function default_layout_snakes_and_ladders():Void
	{
		Reg._gamePointValueOfUnit = [
		64, 63, 62, 61, 60, 59, 58, 57,
		49, 50, 51, 52, 53, 54, 55, 56,
		48, 47, 46, 45, 44, 43, 42, 41,
		33, 34, 35, 36, 37, 38, 39, 40,
		32, 31, 30, 29, 28, 27, 26, 25,
		17, 18, 19, 20, 21, 22, 23, 24,
		16, 15, 14, 13, 12, 11, 10,  9,
		 1,  2,  3,  4,  5,  6,  7,  8
		];
		
		// not needed.
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
	}
		
	public function create_snakes_and_ladders_game():Void
	{
		var p = -1; // gameboard pieces.
		
		// display the snakes and ladders. including the arrows.
		var _snakesAndLaddersImage = new SnakesAndLaddersImage(GameCreate._gameBoard[0].x, GameCreate._gameBoard[0].y);					
		_snakesAndLaddersImage.scrollFactor.set(0, 0);
		add(_snakesAndLaddersImage);

		for (y in 0...8)
		{
			for (x in 0...8)
			{
				// highlights any square, with a square image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnitsPlayer1a = new SnakesAndLaddersImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), 1, x, y);						
				_capturingUnitsPlayer1a.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnitsPlayer1a);
				
				var _capturingUnitsPlayer1b = new SnakesAndLaddersImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), 2, x, y);						
				_capturingUnitsPlayer1b.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnitsPlayer1b);
				
				var _capturingUnitsPlayer2a = new SnakesAndLaddersImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), 3, x, y);						
				_capturingUnitsPlayer2a.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnitsPlayer2a);
				
				var _capturingUnitsPlayer2b = new SnakesAndLaddersImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), 4, x, y);						
				_capturingUnitsPlayer2b.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnitsPlayer2b);
				
				add(__game_create._groupCapturingUnit);
			}
		}
		
					
		//##########################  PLAYER'S PIECE #############################
		// player's piece used to navigate the game board.
		__game_create._spriteGroup = new FlxGroup();
		
		__game_create._playerPieces2 = new SnakesAndLaddersMovePlayersPiece(GameCreate._gameBoard[0].x - 75, GameCreate._gameBoard[0].y + (7 * 75), 2, __game_create.__ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		__game_create._playerPieces2.scrollFactor.set(0, 0);
		__game_create._spriteGroup.add(__game_create._playerPieces2);
		
		__game_create._playerPieces1 = new SnakesAndLaddersMovePlayersPiece(GameCreate._gameBoard[0].x - 75, GameCreate._gameBoard[0].y + (7 * 75), 1, __game_create.__ids_win_lose_or_draw); // pieces are 75x75 pixels wide.
		__game_create._playerPieces1.scrollFactor.set(0, 0);
		__game_create._spriteGroup.add(__game_create._playerPieces1);

		add(__game_create._spriteGroup);
					
		__game_create.gameId_dice(FlxG.width - 283, FlxG.height - 453);
										
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
				Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
			}
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
		
		// if true then other player was at the head of the snake. set this player at the head of the snake so that player's piece can move down.
		
		if (SnakesAndLaddersMovePlayersPiece._snakeMovePiece == true)
		{
			if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 5)
				Reg._gameDiceMaximumIndex[Reg._playerMoving] = 15;
				
			if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 7)
				Reg._gameDiceMaximumIndex[Reg._playerMoving] = 35;
			
			if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 31)
				Reg._gameDiceMaximumIndex[Reg._playerMoving] = 59;
				
			if (Reg._gameDiceMaximumIndex[Reg._playerMoving] == 23)
				Reg._gameDiceMaximumIndex[Reg._playerMoving] = 42;
		}
		
		// since move piece was sent to the server, current and maximum index are the same, so since _gameDiceMaximumIndex might have been changed at the above code, "if (SnakesAndLaddersMovePlayersPiece._snakeMovePiece == true)", change the var back to the correct value.
		Reg._gameDiceMaximumIndex[Reg._playerMoving] = Reg._gameDiceCurrentIndex[Reg._playerMoving];
		
		
		RegTypedef._dataGame3._triggerNextStuffToDo = Reg._triggerNextStuffToDo; // used in snakes and ladders. if 6 is rolled then roll again.
		RegTypedef._dataGame3._rolledA6 = Reg._rolledA6;
		RegTypedef._dataGame3._triggerEventForAllPlayers = RegTriggers._eventForAllPlayers; // if true then both players piece will move at the same time.	
	}
}