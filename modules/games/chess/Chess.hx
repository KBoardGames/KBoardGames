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

package modules.games.chess;

/**
 * @author kboardgames.com
 */
class Chess extends FlxGroup
{
	public static var _sprite_board_game_unit_even:FlxSprite;
	public static var _sprite_board_game_unit_odd:FlxSprite;
	public static var _currentUnitClicked:ChessCurrentUnitClicked;
		
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
	
	/******************************
	 * the king's unit will highlight a color when king is in danger.
	 */
	private var __chess_image_future_capturing_units:ChessImageFutureCapturingUnits;
	
	private var __chessImagePathToKing:ChessImagePathToKing;
	
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
						
						GameCreate._gameBoard[i].alpha = 0;
					}
					
					else
					{
						GameCreate._gameBoard[i].color = _unitgameBoardColorDark[Reg._gameId];
						
						GameCreate._gameBoard[i].alpha = 0;
					}
				} 
				else	
				{
					// draw blocks in reverse color. even is odd and odd is even.
					if (FlxMath.isEven(i) == true)
					{
						GameCreate._gameBoard[i].color = _unitgameBoardColorLight[Reg._gameId];
						
						GameCreate._gameBoard[i].alpha = 0;
						
					}
					
					else
					{
						GameCreate._gameBoard[i].color = _unitgameBoardColorDark[Reg._gameId];
						
						GameCreate._gameBoard[i].alpha = 0;
					}
				}

				GameCreate._gameBoard[i].scrollFactor.set(0, 0);
				add(GameCreate._gameBoard[i]);
					
			}
		}
	
		// display the custom game board from options menu.
		if (RegCustom._gameboard_even_units_show_enabled[Reg._tn] == true)
		{
			_sprite_board_game_unit_even = new FlxSprite(0, 0, "assets/images/scenes/tiles/even/"+ Std.string(RegCustom._gameboard_units_even_shade_number[Reg._tn][Reg._gameId]) + ".png");
			_sprite_board_game_unit_even.scrollFactor.set();
			_sprite_board_game_unit_even.setPosition(Reg._unitXgameBoardLocation[0], Reg._unitYgameBoardLocation[0]);
			_sprite_board_game_unit_even.color = RegCustomColors.colorToggleUnitsEven(Reg._gameId);
			//_sprite_board_game_unit_even.alpha = 0.5;
			add(_sprite_board_game_unit_even);			
		}
		
		_sprite_board_game_unit_odd = new FlxSprite(0, 0, "assets/images/scenes/tiles/odd/"+ Std.string(RegCustom._gameboard_units_odd_shade_number[Reg._tn][Reg._gameId]) +".png");
		_sprite_board_game_unit_odd.scrollFactor.set();
		_sprite_board_game_unit_odd.setPosition(Reg._unitXgameBoardLocation[0], Reg._unitYgameBoardLocation[0]);
		_sprite_board_game_unit_odd.color = RegCustomColors.colorToggleUnitsOdd(Reg._gameId);
		//_sprite_board_game_unit_odd.alpha = 0.5;
		add(_sprite_board_game_unit_odd);			
	
	
		// the unit is highlighted when the mouse is clicked on it.
		_currentUnitClicked = new ChessCurrentUnitClicked(GameCreate._gameBoard[0].y, GameCreate._gameBoard[0].x, __game_create.__ids_win_lose_or_draw);
		_currentUnitClicked.scrollFactor.set(0, 0);
		add(_currentUnitClicked);
		
	}	
	
	public function default_layout_chess():Void
	{
		// the first element is the top right corner of the board. element 2 or unit number 2 has a value of 12. white piece rook has a value of 4 and black piece is plus 10 that amount at 14. so, rook is 4/14, horse 3/13, bishop 2/12, queen 5/15, king 6/16 and pawn 1/11. 
				
		// these point values are not the values of a normal chess piece. a normal piece for horse and bishop has a value of 3 but in code a value of 3 is for a horse while 2 is for bishop.
		// 1/11 pawn. 2:12 bishop, 3:13 horse, 4/14 rook. 5/15 queen. 6/16 king. 7/17:circle, 8/18:X. circle and X are used for teaching chess. put them on the board here then screenshot the image.
		
		// unique values of pieces. 1-9 pawn. 10-19 bishop. 20-29 horse. 30-39 rook. 40-49 queen. 50 king.
		// pieces on set.	
		/*Reg._gamePointValueOfUnit = [
		16, 12,  0,  0,  0,  0,  0,  0,
		 0,  0, 12,  0,  0,  0,  0,  0,
		 0,  0,  0, 12,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0,  1,  0,
		 0,  0,  0,  0,  0,  0,  0,  2,
		 6,  1,  0,  0,  1,  0,  0,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
	   50,  10,  0,  0,  0,  0,  0,  0,
		0,  0,  11,  0,  0,  0,  0,  0,
		0,  0,  0, 12,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  2,  0,
		0,  1,  0,  0,  0,  0,  0,  10,
	   50,  0,  0,  0,  3,  0,  0,  40
		];*/ 
		/*
		Reg._gamePointValueOfUnit = [
		13, 0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0, 16,  0,  0,  0,  0,
		0,  0, 14,  0,  0,  0, 11,  0,
		0,  0,  0, 14,  0,  0,  0,  0, 
		5,  0,  0, 13,  0,  0,  0,  0,
		5,  0,  0,  5,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  1,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		20, 0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0, 50,  0,  0,  0,  0,
		0,  0, 31,  0,  0,  0,  1,  0,
		0,  0,  0, 30,  0,  0,  0,  0,
		40, 0,  0, 20,  0,  0,  0,  0,
		42, 0,  0, 43,  0,  0,  0,  0,
		50, 0,  0,  0,  0,  0,  1,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
	   11, 11,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  1,  0,
		0, 16,  0,  0,  0,  0,  0,  0, 
		0,  0,  0, 11, 15,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  0,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
		6,  7,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  7,  0,
		0, 50,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  1, 41,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0,
		50, 0,  0,  0,  0,  0,  0,  0
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		0,  0,  0,  0,  0,  0,  0,  0,
		0,  0, 15,  0,  0,  0,  0,  0,
		0,  0,  0,  0, 16, 13,  0,  0,
		0,  0,  0, 14, 12,  0,  0,  0,
		0,  0,  0,  0,  0,  0,  0,  0, 
		0,  5,  0,  0,  0,  0,  0,  0,
		6,  0,  0,  0,  0,  0,  0,  0,
		0,  0,  0,  0,  0, 12,  3,  4
		];
					
		 Reg._gameUniqueValueOfUnit = [
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, 40,  0,  0,  0,  0,  0,
		 0,  0,  0,  0, 50, 21,  0,  0,
		 0,  0,  0, 30, 11,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0, 40,  0,  0,  0,  0,  0,  0,
		 50, 0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0, 10, 21, 31			
		];*/
		/*
		Reg._gamePointValueOfUnit = [
		12,  0, 0, 15, 16, 0, 0, 0,
		13, 0,  14, 0, 11, 11, 11, 11,
		14,  0, 14,  0,  0,  0,  0,  0,
		 0,  13, 0,  0,  0, 0,  0,  0,
		 0,  0,  0,  0, 11, 0,  0,  0, 
		 0,  6,  1,  1,  0,  0,  0,  0,
		 0,  1,  1,  0,  1,  0,  1,  1,
		 0,  3,  0,  0,  0,  0,  3,  4
		];
		
		Reg._gameUniqueValueOfUnit = [
		 10, 0, 0,  40,  50,  0,  0,  0,
		 20, 0, 31,  0,  4,  6,  7,  8,
		 30, 0, 32,  0,  0,  0,  0,  0,
		 0, 21,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 0, 50,  1,  4,  0,  0,  0,  0,
		 0,  2,  3,  0,  5,  0,  7,  8,
		 0, 20,  0,  0,  0,  0,  21, 31
		 ];
		*/
		 /*	 
		Reg._gamePointValueOfUnit = [
		14, 13, 12, 15, 16, 12, 13, 14,
		11, 11, 11, 11, 11,  0,  0, 11,
		 0,  0,  0,  0,  0, 11,  0,  0,
		 0,  0,  0,  0,  0,  0, 11,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  1,  0,  0,  0,
		 1,  1,  1,  1,  0,  1,  1,  1,
		 4,  3,  2,  5,  6,  2,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 20, 10, 40, 50, 11, 21, 31,
		 1,  2,  3,  4,  5,  0,  0,  8,
		 0,  0,  0,  0,  0,  6,  0,  0,
		 0,  0,  0,  0,  0,  0,  7,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 1,  2,  3,  4,  0,  6,  7,  8,
		 30, 20, 10, 40, 50, 11, 21, 31
		 ];
		*//*
		Reg._gamePointValueOfUnit = [
		0, 0, 0, 0,16, 0, 0, 14,
		0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0, 14,  0,
		 1,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  6,  5,  0,  0
		];
						
		Reg._gameUniqueValueOfUnit = [
		 0, 0, 0, 0, 50, 0, 0, 31,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  30,  0,
		 1,  0,  0,  0,  0,  0,  0,  0,
		 0, 0, 0, 0, 50, 40, 0, 0
		 ];*/
		
		 /*
		Reg._gamePointValueOfUnit = [
		14,  0, 12, 15, 16, 12, 0, 14,
		11, 11, 11, 11, 11,  0, 11, 11,
		 0,  0, 13,  0,  0, 11,  0, 13,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  2,  1,  0,  0,  0,  0, 
		 0,  0,  0,  0,  1,  0,  0,  0,
		 1,  1,  1,  0,  0,  1,  1,  1,
		 4,  3,  2,  5,  6,  0,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 0, 10, 40, 50, 11, 0, 31,
		 1,  2,  3,  4,  5,  0,  7,  8,
		 0,  0, 20,  0,  0,  6,  0,  21,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0, 11,  4,  0,  0,  0,  0,
		 0,  0,  0,  0,  5,  0,  0,  0,
		 1,  2,  3,  0,  0,  6,  7,  8,
		 30, 20, 10, 40, 50, 0, 21, 31
		 ];*/
		
		 Reg._gamePointValueOfUnit = [
		14, 13, 12, 15, 16, 12, 13, 14,
		11, 11, 11, 11, 11, 11, 11, 11,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0, 
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  1,  1,  1,  1,  1,  1,  1,
		 4,  3,  2,  5,  6,  2,  3,  4
		];
						
		Reg._gameUniqueValueOfUnit = [
		 30, 20, 10, 40, 50, 11, 21, 31,
		 1,  2,  3,  4,  5,  6,  7,  8,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 0,  0,  0,  0,  0,  0,  0,  0,
		 1,  2,  3,  4,  5,  6,  7,  8,
		 30, 20, 10, 40, 50, 11, 21, 31
		 ];
	}	
	
	
	public function create_chess_game():Void
	{
		var p = -1; // gameboard pieces.
		
		if (RegCustom._chess_future_capturing_units_enabled[Reg._tn] == true)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					// the king's unit will highlight a color when king is in danger.
					__chess_image_future_capturing_units = new ChessImageFutureCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), x, y);
					__chess_image_future_capturing_units.scrollFactor.set(0, 0);
					add(__chess_image_future_capturing_units);
					
				}
			}
			
		}
		 
		// keep this outside of the above loop, so that when displaying an image of the capturing path to king at __chessImagePathToKing class, that class can set a var to hide the future capturing path to king image that might be displayed overtop of that unit that was set at __chess_image_future_capturing_units class.
		if (RegCustom._chess_path_to_king_enabled[Reg._tn] == true)
		{
			for (y in 0...8)
			{
				for (x in 0...8)
				{
					// path to king is units that can capture the king in a straight line.
					__chessImagePathToKing = new ChessImagePathToKing(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), x, y);
					__chessImagePathToKing.scrollFactor.set(0, 0);
					add(__chessImagePathToKing);
				}
			}
		}
		
		for (y in 0...8)
		{
			for (x in 0...8)
			{
				p += 1;
				
				// each piece is now stored in a XY coordinate system so that a piece can be found using a mouse.				
				if (RegTypedef._dataMovement._history_get_all == 0)
				{
					Reg._gamePointValueForPiece[y][x] = Reg._gamePointValueOfUnit[p];
					Reg._gameUniqueValueForPiece[y][x] = Reg._gameUniqueValueOfUnit[p];
				}
				
				Reg._capturingUnitsForImages[0][y][x] = 0;
				Reg._capturingUnitsForImages[1][y][x] = 0;
				
				
				// highlights any square, with a square image, that the player is able to move the piece to. note that the x and y values here are reverse of the class. it works. don't change them.
				var _capturingUnits = new ChessImagesCapturingUnits(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), x, y);					
				_capturingUnits.scrollFactor.set(0, 0);
				__game_create._groupCapturingUnit.add(_capturingUnits);
				add(__game_create._groupCapturingUnit);		
									
				var _playerPieces = new ChessMovePlayersPiece(GameCreate._gameBoard[0].x + (x * 75), GameCreate._gameBoard[0].y + (y * 75), Reg._gamePointValueOfUnit[p], p); // pieces are 75x75 pixels wide.
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
		
		RegTypedef._dataMovement._history_get_all = 0;
		
		// unit is surrounded by a border at the location of the mouse. when the mouse moves around the grid then so does this border move.
		__game_image_current_unit = new GameImageCurrentUnit(GameCreate._gameBoard[0].y, GameCreate._gameBoard[0].x);
		__game_image_current_unit.scrollFactor.set(0, 0);
		add(__game_image_current_unit);
	}
	
	public static function server_data():Void
	{
		// these are the vars needed to move a piece.
		RegTypedef._dataGame1._pieceValue = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
		RegTypedef._dataGame1._uniqueValue = Reg._gameUniqueValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
		RegTypedef._dataGame1._gameUnitNumberNew = Reg._gameUnitNumberNew;
		RegTypedef._dataGame1._gameUnitNumberOld = Reg._gameUnitNumberOld;
		RegTypedef._dataGame1._gameUnitNumberNew2 = Reg._gameUnitNumberNew2;
		RegTypedef._dataGame1._gameUnitNumberOld2 = Reg._gameUnitNumberOld2;
		RegTypedef._dataGame1._piece_capturing_image_value = Reg._imageValueOfUnitOld3;
		RegTypedef._dataGame1._gameXXnew = Reg._gameXXnew;
		RegTypedef._dataGame1._gameYYnew = Reg._gameYYnew;
		RegTypedef._dataGame1._gameXXold = Reg._gameXXold;
		RegTypedef._dataGame1._gameYYold = Reg._gameYYold;
		RegTypedef._dataGame1._gameXXnew2 = Reg._gameXXnew2;
		RegTypedef._dataGame1._gameYYnew2 = Reg._gameYYnew2;
		RegTypedef._dataGame1._gameXXold2 = Reg._gameXXold2;
		RegTypedef._dataGame1._gameYYold2 = Reg._gameYYold2;
		RegTypedef._dataGame1._isEnPassant = Reg._isEnPassant;
		RegTypedef._dataGame1._isEnPassantPawnNumber = Reg._chessEnPassantPawnNumber;
		RegTypedef._dataGame1._triggerNextStuffToDo = Reg._triggerNextStuffToDo;
		RegTypedef._dataGame1._pointValue2 = Reg._pointValue2;
		RegTypedef._dataGame1._uniqueValue2 = Reg._uniqueValue2;
		RegTypedef._dataGame1._promotePieceLetter = Reg._promotePieceLetter;
		RegTypedef._dataGame1._doneEnPassant = Reg._doneEnPassant;
	}
}