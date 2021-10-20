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
 * ...
 * @author kboardgames.com
 */
class ChessCapturingUnits
{
	/******************************
	 * value of true means that a currentUnit is now visible.
	 */
	private static var _found:Bool = false;
	
	/******************************
	 * true if king is found.
	 */
	private static var _isKing:Array<Bool> = [false,false];
	
	/******************************
	 * a queen, rook or bishop can capture units behind that king. this var stops that.
	 */
	private static var _stopAtKing:Bool = false;
	
	/******************************
	 * this var triggers the creation of pieces that are protecting the king from a check.
	 */
	private static var _defenderUnits:Bool = false;
	
	/******************************
	 * true if at the path there is a same colored piece found.
	 */
	private static var _sameColoredPieceFound:Bool = false;
	private static var _otherColoredPieceFound:Bool = false; // player not moving.
	
	/******************************
	 * piece will not be able to move if moving will place king in to check.
	 */
	private static var _defenderPiece:Bool = false;
	
	/******************************
	 * if a defender piece moves, will an attacker piece be able to capture king.
	 */
	private static var _attackerPiece:Bool = false;
	
	/******************************
	 * true is there is a piece at some location.
	 */
	private static var _pieceFound:Bool = false;
		
	//#############################	PAWN.
	/******************************
	 * when mouse clicked on a pawn, this function sets the units a pawn is able to move to by setting _capturingUnitsForImages to a value of 1.
	 * @param	cy		unit y coordinate of a pawn.
	 * @param	cx		unit x coordinate of a pawn.
	 */	
	public static function pawnCapturingUnitsForImages(cy:Int, cx:Int):Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		// pawns have a point value of 1 for the white player, the game host. the black player, the player that joined the room from the lobby had plus 10 that value.
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[cy][cx] == 1 || Reg._gameHost == false && Reg._gamePointValueForPiece[cy][cx] == 11)
		{
			// this will be true when mouse clicked on a pawn and that pawn sits at yy = 6 or yy = 1.
			var pawnCanMakeExtraMove:Bool = false;
			
			if (Reg._gameHost == true)
			{
				if (cy == 6) pawnCanMakeExtraMove = true; // pawn is at the starting position. therefore, pawn is able to move two spaces instead of one.
			
				ChessEnPassant.enPassantpawnCapturingUnitsForImages(cy, cx);
								
				cy -= 1;
				
				// if there is no piece north of this pawn then set this unit as capturing.
				if (Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 2;
				
				}
				
			
				// check if there is the other players piece at an angle from the pawn. this pawn can take the other players piece but only when moving north in an angle.
				if (cx > 0)
				{
					if (Reg._gamePointValueForPiece[cy][cx-1] >= 11) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx-1] = 1;
				}
				if (cx < 7)
				{
					if (Reg._gamePointValueForPiece[cy][cx+1] >= 11) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx+1] = 1;
				}
				
				// if pawn can move two spaces then use an image to highlight that second space and that will refer yo a capturing unit.
				if (pawnCanMakeExtraMove == true && Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					cy -= 1;
					if (Reg._gamePointValueForPiece[cy][cx] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 2;
				}				
											
			}
			
			else
			{
				if (cy == 1) pawnCanMakeExtraMove = true;
				
				ChessEnPassant.enPassantpawnCapturingUnitsForImages(cy, cx);
				
				cy += 1;
				
				// if there is no piece south of this pawn then set unit as capturing.
				if (Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 2;
							
				}
				
				// check if there is the other players piece at an angle from the pawn. this pawn can take the other players piece but only when moving south in an angle.
				if (cx > 0)
				{
					if (Reg._gamePointValueForPiece[cy][cx-1] > 0 && Reg._gamePointValueForPiece[cy][cx-1] < 11) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx-1] = 1;
				}
				if (cx < 7)
				{
					if (Reg._gamePointValueForPiece[cy][cx+1] > 0 && Reg._gamePointValueForPiece[cy][cx+1] < 11) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx+1] = 1;
				}
				
				// if pawn can move two spaces then set image to highlight that second space.
				if (pawnCanMakeExtraMove == true && Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					cy += 1;
					if (Reg._gamePointValueForPiece[cy][cx] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 2;
				}
				
			}
		}		
	}
	
	//#############################	PAWN.
	/******************************
	 * this _capturingUnitsForPieces var can hold data for any unit on the board. a value of 1 means that 1 piece can only capture that unit. a value of 2 refers to a unit that can be captured by 2 pieces. _capturingUnitsForPieces is useful when a king is in check. it can ne used to search for other var values. _capturingUnitsForPieces can hold a value greater than 1 while _capturingUnitsForImages currently is limited to 1 and 0.
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 * @param	_instance					each player starts the game with 8 pawns and 2 horses. this var can loop through those numbers. this var with a value of 1 can refer to the first horse or pawn number 1. search Reg._gamePointValueOfUnit at PlayState.hx for more information.
	 * @param	Reg._playerMoving		this var is used by the defender player.
	 */	
	public static function pawnCapturingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;

		// pawns have a point value of 1 for the white player, the game host. the black player, the player that joined the room from the lobby had plus 10 that value.
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] == 1 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] == 11)
		{
			// this will be true when mouse clicked on a pawn and that pawn sits at yy = 6 or yy = 1.
			var pawnCanMakeExtraMove:Bool = false;
			
			if (Reg._playerMoving == 0)
			{
				//#############################	PAWN MOVING IN UP DIRECTION.
							
				if (cy == 6) pawnCanMakeExtraMove = true; // pawn is at the starting position. therefore, pawn is able to move two spaces instead of one.
			
				ChessEnPassant.enPassantpawnCapturingUnitsForPiece(cy, cx, _instance, _playerMoving);
				
				cy -= 1;
					
				// if there is no piece north of this pawn then highlight that unit.
				if (cy >= 0)
				{
					if (Reg._gamePointValueForPiece[cy][cx] == 0)
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 1;
						if (Reg._chessStalemateBypassCheck == true) Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
					}
				}
				
				// check if there is the other players piece at an angle from the pawn. this pawn can take the other players piece but only when moving north in an angle.
				if (cy >= 0 && cx > 0)
				{
					if (Reg._chessStalemateBypassCheck == false) Reg._chessPawn[Reg._playerMoving][_instance][cy][cx - 1] = 8;
					else Reg._chessPawn[Reg._playerMoving][_instance][cy][cx - 1] = 0;
				}				
				if (cy >= 0 && cx < 7)
				{
					if (Reg._chessStalemateBypassCheck == false) Reg._chessPawn[Reg._playerMoving][_instance][cy][cx + 1] = 2;
					else Reg._chessPawn[Reg._playerMoving][_instance][cy][cx + 1] = 0;
				}
				
				// if pawn can move two spaces then use an image to highlight that second space.
				if (pawnCanMakeExtraMove == true && Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					cy -= 1;
					if (Reg._gamePointValueForPiece[cy][cx] == 0) 
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 1;
						if (Reg._chessStalemateBypassCheck == true) Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
					}
				}
			}
			
			else
			{
				//#############################	PAWN MOVING IN DOWN DIRECTION.
							
				if (cy == 1) pawnCanMakeExtraMove = true;
				
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._game_online_vs_cpu == false)
				ChessEnPassant.enPassantpawnCapturingUnitsForPiece(cy, cx, _instance, _playerMoving);
				
				cy += 1;
				
				// if there is no piece south of this pawn then that unit can be captured.
				if (cy <= 7)
				{
					if (Reg._gamePointValueForPiece[cy][cx] == 0)
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 5;
						if (Reg._chessStalemateBypassCheck == true) Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
					}
				}
				
				// check if there is the other players piece at an angle from the pawn. this pawn can take the other players piece but only when moving south in an angle.
				if (cy <= 7 && cx > 0)
				{
					// down left
					if (Reg._chessStalemateBypassCheck == false) Reg._chessPawn[Reg._playerMoving][_instance][cy][cx - 1] = 6;
					else Reg._chessPawn[Reg._playerMoving][_instance][cy][cx - 1] = 0;
				}
				if (cy <= 7 && cx < 7)
				{
					if (Reg._chessStalemateBypassCheck == false) Reg._chessPawn[Reg._playerMoving][_instance][cy][cx + 1] = 4;
					else Reg._chessPawn[Reg._playerMoving][_instance][cy][cx + 1] = 0;
				}
				
				// if pawn can move two spaces then highlight that second space.
				if (pawnCanMakeExtraMove == true && Reg._gamePointValueForPiece[cy][cx] == 0)
				{
					cy += 1;
					if (Reg._gamePointValueForPiece[cy][cx] == 0)
					{
						Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 5;
						if (Reg._chessStalemateBypassCheck == true) Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
					}
				}
				
			}
		}	
	}
	
	//#############################	HORSE.
	/******************************
	 * when a horse is mouse clicked, the Reg._capturingUnitsForImages will be set to a value of 1 when that horse can take that unit. at the update() of ChessImagesCapturingUnits.hx as soon as Reg._capturingUnitsForImages has a value of 1 a unit will be highlighted to show that the horse can move to that unit.
	 * @param	cy	this is the y coordinate for a unit such as an unique value of a piece or a unit that holds data, a value of a piece, at that unit.
	 * @param	cx	this is the x coordinate for a unit.
	 */
	public static function horseCapturingUnitsForImages(cy:Int, cx:Int):Void
	{
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[cy][cx] == 3 || Reg._gameHost == false && Reg._gamePointValueForPiece[cy][cx] == 13)
		{
			var _addToPlayersPointMin:Int =  0; // if player is not a game host then these values will be used. since the black pieces try to take the white piece, when moving a black piece the values will check first for a white piece at that ChessImagesCapturingUnits. all pieces of white range from 1 to 6 so in code the greater symbol ">" will be used when checking this min var. remember that a unit with a value of 0 refers to an empty unit.
			var _addToPlayersPointMax:Int =  10;
			
			if (Reg._gameHost == true)
			{
				_addToPlayersPointMin = 10; // these vars are the value range of the black pieces.
				_addToPlayersPointMax = 20; // if host is true then _capturingUnitsForImages can be set to 1 which means that a unit in that value range can be highlighted, the ChessImagesCapturingUnits unit visible. 
			}

			// when the horse is near the center of the gameboard then that horse can move to any of the 8 units. the following code checks the first top-right corner location.
			// top-right1
			if (cx < 7 && cy > 1)
			{
				// this line checks for san empty unit. if found, it will set it to a 1 so that ChessImagesCapturingUnits will highlight that unit.
				if (Reg._gamePointValueForPiece[cy - 2][cx + 1] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 2][cx + 1] = 1;
				// depending on the value of min and max, this code will either check for a white or black piece. if found then it will set to 1 so that at ChessImagesCapturingUnits.hx, that class can display an image at this cy - 2 and cx + 1.
				if (Reg._gamePointValueForPiece[cy - 2][cx + 1] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy - 2][cx + 1]  < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 2][cx + 1] = 1;
				
			}
			
			//----------------------------------------------------------------------------------------------
			// the following seven other ways that the horse can move will not be commented because they are similar in code as above.
			//----------------------------------------------------------------------------------------------
			
			// top-right2
			if (cx < 6 && cy > 0)
			{
				if (Reg._gamePointValueForPiece[cy - 1][cx + 2] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 1][cx + 2] = 1;
				if (Reg._gamePointValueForPiece[cy - 1][cx + 2] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy - 1][cx + 2] < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 1][cx + 2] = 1;
			}
						
			// bottom-right1
			if (cx < 7 && cy < 6)
			{
				if (Reg._gamePointValueForPiece[cy + 2][cx + 1] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 2][cx + 1] = 1;				
				if (Reg._gamePointValueForPiece[cy + 2][cx + 1] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy + 2][cx + 1]  < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 2][cx + 1] = 1;
				
			}
			// bottom-right2
			if (cx < 6 && cy < 7)
			{
				if (Reg._gamePointValueForPiece[cy + 1][cx + 2] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 1][cx + 2] = 1;
				if (Reg._gamePointValueForPiece[cy + 1][cx + 2] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy + 1][cx + 2] < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 1][cx + 2] = 1;
			}
			
			// top-left1
			if (cx > 0 && cy > 1)
			{
				if (Reg._gamePointValueForPiece[cy - 2][cx - 1] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 2][cx - 1] = 1;				
				if (Reg._gamePointValueForPiece[cy - 2][cx - 1] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy - 2][cx - 1]  < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 2][cx - 1] = 1;
				
			}
			// top-left2
			if (cx > 1 && cy > 0)
			{
				if (Reg._gamePointValueForPiece[cy - 1][cx - 2] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 1][cx - 2] = 1;
				if (Reg._gamePointValueForPiece[cy - 1][cx - 2] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy - 1][cx - 2] < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy - 1][cx - 2] = 1;
			}
						
			// bottom-left1
			if (cx > 0 && cy < 6)
			{
				if (Reg._gamePointValueForPiece[cy + 2][cx - 1] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 2][cx - 1] = 1;				
				if (Reg._gamePointValueForPiece[cy + 2][cx - 1] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy + 2][cx - 1]  < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 2][cx - 1] = 1;
				
			}
			// bottom-left2
			if (cx > 1 && cy < 7)
			{
				if (Reg._gamePointValueForPiece[cy + 1][cx - 2] == 0) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 1][cx - 2] = 1;
				if (Reg._gamePointValueForPiece[cy + 1][cx - 2] > _addToPlayersPointMin && Reg._gamePointValueForPiece[cy + 1][cx - 2] < _addToPlayersPointMax) Reg._capturingUnitsForImages[Reg._playerMoving][cy + 1][cx - 2] = 1;
			}
		}
	}
	
	/******************************
	 * this function sets the Reg._capturingUnitsForPieces var. this var can be used when a king is in check. it can be used to find where a horse is located or to determine where a piece should be moved to take a king out of check. it cam also be used to display a unit where that selected piece can be moved to.
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 * @param	_instance					there are two horses for each player. a value of 2 refers to the second horse. a pawn has eight _instance.
	 * @param	Reg._playerMoving		the defender player.
	 */
	public static function horseCapturingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int):Void
	{	
		Reg._playerMoving = _playerMoving;
		
		//#############################	HORSE.
		
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] == 3 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] == 13)
		{
			var _addToPlayersPointMin:Int =  0; // if player is not a game host then these values will be used. since the black pieces try to take the white piece, when moving a black piece the values will check first for a white piece at that ChessImagesCapturingUnits. all pieces of white range from 1 to 6 so in code the greater symbol ">" will be used when checking this min var. remember that a unit with a value of 0 refers to an empty unit.
			var _addToPlayersPointMax:Int =  10;
			
			if (Reg._playerMoving == 0)
			{
				_addToPlayersPointMin = 10; // these vars are the value range of the black pieces.
				_addToPlayersPointMax = 20; // if host is true then _capturingUnitsForImages can be set to 1 which means that a unit in that value range can be highlighted, the ChessImagesCapturingUnits unit visible. 
			}
			
			// when the horse is near the center of the gameboard then that horse can move to any of the 8 units. the following code checks the first top-right corner location.
			// top-right1
			if (cx < 7 && cy > 1)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy - 2][cx + 1] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 2][cx + 1] += 1;
				
				if (Reg._gamePointValueForPiece[cy - 2][cx + 1] == 6
				||  Reg._gamePointValueForPiece[cy - 2][cx + 1] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
			
			//----------------------------------------------------------------------------------------------
			// the following seven other ways that the horse can move will not be commented because they are similar in code as above.
			//----------------------------------------------------------------------------------------------
			
			// top-right2
			if (cx < 6 && cy > 0)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy - 1][cx + 2] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx + 2] += 1;
				
				if (Reg._gamePointValueForPiece[cy - 1][cx + 2] == 6
				||  Reg._gamePointValueForPiece[cy - 1][cx + 2] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
						
			// bottom-right1
			if (cx < 7 && cy < 6)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy + 2][cx + 1] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 2][cx + 1] += 1;
				
				if (Reg._gamePointValueForPiece[cy + 2][cx + 1] == 6
				||  Reg._gamePointValueForPiece[cy + 2][cx + 1] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
			
			// bottom-right2
			if (cx < 6 && cy < 7)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy + 1][cx + 2] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx + 2] += 1;
				
				if (Reg._gamePointValueForPiece[cy + 1][cx + 2] == 6
				||  Reg._gamePointValueForPiece[cy + 1][cx + 2] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
			
			// top-left1
			if (cx > 0 && cy > 1)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy - 2][cx - 1] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 2][cx - 1] += 1;
			
				if (Reg._gamePointValueForPiece[cy - 2][cx - 1] == 6
				||  Reg._gamePointValueForPiece[cy - 2][cx - 1] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
			
			// top-left2
			if (cx > 1 && cy > 0)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy - 1][cx - 2] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx - 2] += 1;
				
				if (Reg._gamePointValueForPiece[cy - 1][cx - 2] == 6
				||  Reg._gamePointValueForPiece[cy - 1][cx - 2] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
						
			// bottom-left1
			if (cx > 0 && cy < 6)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy + 2][cx - 1] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 2][cx - 1] += 1;
				
				if (Reg._gamePointValueForPiece[cy + 2][cx - 1] == 6
				||  Reg._gamePointValueForPiece[cy + 2][cx - 1] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
			
			// bottom-left2
			if (cx > 1 && cy < 7)
			{
				Reg._chessHorse[Reg._playerMoving][_instance][cy + 1][cx - 2] = 1;
				//Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx - 2] += 1;
				
				if (Reg._gamePointValueForPiece[cy + 1][cx - 2] == 6
				||  Reg._gamePointValueForPiece[cy + 1][cx - 2] == 16)
				Reg._chessHorseAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100; 	
			}
		}
	}
	
	/******************************
	 * this function sets the Reg._futureCapturingUnitsForPiece var. 
	 * @param	Reg._playerMoving		the defender player.
	 * @param	_instance				there are two horses for each player. a instance of 2 refers to the second horse. a pawn has eight _instance.
	 * @param	cy						the y coordinate of a unit.
	 * @param	cx						the x coordinate of a unit.
	 */
	public static function horseFutureCapturingUnits(_playerMoving:Int, _p:Int, _instance:Int, cy:Int, cx:Int):Void
	{	
		Reg._playerMoving = _playerMoving;
		
		//#############################	HORSE.
		
		var _addToPlayersPointMin:Int =  0; // if player is not a game host then these values will be used. since the black pieces try to take the white piece, when moving a black piece the values will check first for a white piece at that ChessImagesCapturingUnits. all pieces of white range from 1 to 6 so in code the greater symbol ">" will be used when checking this min var. remember that a unit with a value of 0 refers to an empty unit.
		var _addToPlayersPointMax:Int =  10;
		
		if (Reg._playerMoving == 0)
		{
			_addToPlayersPointMin = 10; // these vars are the value range of the black pieces.
			_addToPlayersPointMax = 20; // if host is true then _capturingUnitsForImages can be set to 1 which means that a unit in that value range can be highlighted, the ChessImagesCapturingUnits unit visible. 
		}
		
		// when the horse is near the center of the gameboard then that horse can move to any of the 8 units. the following code checks the first top-right corner location.
		// top-right1
		if (cx < 7 && cy > 1)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy - 2][cx + 1] = 1;
			
			if (Reg._gamePointValueForPiece[cy - 2][cx + 1] > 0	
			&&  Reg._gamePointValueForPiece[cy - 2][cx + 1] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		//----------------------------------------------------------------------------------------------
		// the following seven other ways that the horse can move will not be commented because they are similar in code as above.
		//----------------------------------------------------------------------------------------------
		
		// top-right2
		if (cx < 6 && cy > 0)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy - 1][cx + 2] = 1;
			
			if (Reg._gamePointValueForPiece[cy - 1][cx + 2] > 0	
			&&  Reg._gamePointValueForPiece[cy - 1][cx + 2] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
					
		// bottom-right1
		if (cx < 7 && cy < 6)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy + 2][cx + 1] = 1;
			
			if (Reg._gamePointValueForPiece[cy + 2][cx + 1] > 0	
			&&  Reg._gamePointValueForPiece[cy + 2][cx + 1] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		// bottom-right2
		if (cx < 6 && cy < 7)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy + 1][cx + 2] = 1;
			
			if (Reg._gamePointValueForPiece[cy + 1][cx + 2] > 0	
			&&  Reg._gamePointValueForPiece[cy + 1][cx + 2] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		// top-left1
		if (cx > 0 && cy > 1)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy - 2][cx - 1] = 1;
			
			if (Reg._gamePointValueForPiece[cy - 2][cx - 1] > 0	
			&&  Reg._gamePointValueForPiece[cy - 2][cx - 1] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		// top-left2
		if (cx > 1 && cy > 0)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy - 1][cx - 2] = 1;
			
			if (Reg._gamePointValueForPiece[cy - 1][cx - 2] > 0	
			&&  Reg._gamePointValueForPiece[cy - 1][cx - 2] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
					
		// bottom-left1
		if (cx > 0 && cy < 6)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy + 2][cx - 1] = 1;
			
			if (Reg._gamePointValueForPiece[cy + 2][cx - 1] > 0	
			&&  Reg._gamePointValueForPiece[cy + 2][cx - 1] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		// bottom-left2
		if (cx > 1 && cy < 7)
		{
			Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][_instance][cy + 1][cx - 2] = 1;
			
			if (Reg._gamePointValueForPiece[cy + 1][cx - 2] > 0	
			&&  Reg._gamePointValueForPiece[cy + 1][cx - 2] < 11)
				Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][_instance][cy][cx] += 1;
		}
		
		
	}
	
	//#############################	BISHOP - ROOK - QUEEN - KING
	/******************************
	 * the following code is easy to understand. these four pieces of bishop, rook, queen and king can either move horizontally, vertically or both.
	 * @param	yy	y coordinate for a unit.
	 * @param	xx	x coordinate for a unit
	 * @param	cy	this var is used to find the next unit a piece can be moved to. after this var has found the edge of the board, this vars value will be the value of yy var so to start over from the beginning to find another piece.
	 * @param	cx	used to find the next unit a piece can move to.
	 */	// 
		
	public static function BRQandKcapturingUnitsForImages(cy:Int, cx:Int):Void
	{
		var yy = cy;
		var xx = cx;
		
		Reg._playerMoving = 0;
		if (Reg._gameHost == false) Reg._playerMoving = 1;
		
		_found = false;
		
		
		
		// bishop with a value of 2 cannot move up and therefore is not in this code. rook = 4 or 14 for the black piece. 5/15 for queen. 6/16 = king.
		if (Reg._gamePointValueForPiece[cy][cx] == 4 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 14 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			// moves from top of screen to bottom.
			while (cy < 7) 
			{
				cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	// jump to a function where a ChessImagesCapturingUnits var could be set to 1. if set to 1 then this piece at the ChessImagesCapturingUnits.hx will display an image, highlighting the unit to let the player know that the piece can move to this highlighted unit.		
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		//----------------------------------------------------------------------------------------------
		// the following seven other ways that these pieces can move will not be commented because they are similar in code as above.
		//----------------------------------------------------------------------------------------------
					
		if (Reg._gamePointValueForPiece[cy][cx] == 2 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 12 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			// up-right to bottom left.
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		if (Reg._gamePointValueForPiece[cy][cx] == 4 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 14 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{	
			// right to left.
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cx > 0)
			{
				cx -= 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		if (Reg._gamePointValueForPiece[cy][cx] == 2 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 12 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			// right-down to left-up.
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}

			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		if (Reg._gamePointValueForPiece[cy][cx] == 4 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 14 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			// from down to up.
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cy > 0)
			{
				cy -= 1;
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);		
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		if (Reg._gamePointValueForPiece[cy][cx] == 2 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 12 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			// down-left to up-right.
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);					
			}
			
		}
		
		_found = false; cx = xx; cy = yy;
		
		if (Reg._gamePointValueForPiece[cy][cx] == 4 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 14 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{
			// moves left to right
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cx < 7)
			{
				cx += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	
			}
			
		}
		
		_found = false; cx = xx; cy = yy;

		if (Reg._gamePointValueForPiece[cy][cx] == 2 || Reg._gamePointValueForPiece[cy][cx] == 5 || Reg._gamePointValueForPiece[cy][cx] == 6
		|| Reg._gamePointValueForPiece[cy][cx] == 12 || Reg._gamePointValueForPiece[cy][cx] == 15 || Reg._gamePointValueForPiece[cy][cx] == 16)
		{	// moves left-up to right-down
			if (Reg._gamePointValueForPiece[cy][cx] == 6 || Reg._gamePointValueForPiece[cy][cx] == 16)
			{
				Reg._chessIsKingMoving = true;
			}
			
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForImages(cy, cx, yy, xx);	
			}
			
		}
		
		_found = false;

	}
	
	//#############################	BISHOP - ROOK - QUEEN - KING
	/******************************
	 * the following code is easy to understand. these four pieces of bishop, rook, queen and king can either move horizontally, vertically or both. the code checks the unit above the clicked piece.
	 * @param	cy						y coordinate of a unit.
	 * @param	cx						x coordinate of a unit.
	 * @param	_instance				what pawn piece or horse piece is being used.
	 * @param	Reg._playerMoving		the defender player.
	 * @param	_type					6=defender king when used with Reg._playerMoving, 6=attacker king when used with Reg._playerNotMoving.
	*/	
	public static function BRQandKcapturingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int, _type:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		
		_pieceFound = false; _found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false; _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		
		var xx = cx;
		var yy = cy;
		
				
		// bishop with a value of 2 cannot move up and therefore is not in this code. rook = 4 or 14 for the black piece. 5/15 for queen. 6/16 = king.
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 4 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 14 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{					
			_pieceFound = false;
			
			// searches from up and goes to bottom unit.
			while (cy < 7) // cannot move down if not already at the bottom of the gameboard.
			{
				cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	// jump to a function where a ChessImagesCapturingUnits var could be set to 1. if set to 1 then this piece at the ChessImagesCapturingUnits.hx will display an image, highlighting the unit to let the player know that the piece can move to this highlighted unit.			
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
			
				Reg._chessCurrentPathToKing[Reg._playerMoving][0][yy][xx] = 1; // set this piece a _direction var that can determine the path that points to the king.
			}
			
			while (cy < 7)
			{
				cy += 1; 
				if (_defenderUnits == true && _sameColoredPieceFound == true)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
						
			while (cy < 7)
			{
				cy += 1;  
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 1 );	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][1][cy][cx] = 1;  
			}
			
			while (cy < 7)
			{
				cy += 1;  
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 1);
				}
			}	
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		//----------------------------------------------------------------------------------------------
		// the following seven other ways that these pieces can move will not be commented because they are similar in code as above.
		//----------------------------------------------------------------------------------------------
					
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 12 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{
			// moves to find king from up-right corner to bottom-left.
			_pieceFound = false;
			
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
			}
			
			_found = false; _pieceFound = false;					
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
				
				Reg._chessCurrentPathToKing[Reg._playerMoving][1][yy][xx] = 1;
			}
			
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;		
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;		
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 2);	
				}
			}		
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
		  
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][2][cy][cx] = 2;  
			}
			
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;		
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 2);	
				}
			}		
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 4 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 14 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{	
			// moves right to left.
			
			_pieceFound = false;
						
			while (cx > 0)
			{
				cx -= 1;				
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);		
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
						
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
				
				Reg._chessCurrentPathToKing[Reg._playerMoving][2][yy][xx] = 1;
			
			}
			
			while (cx > 0)
			{
				cx -= 1;
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
					
			while (cx > 0)
			{
				cx -= 1;
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 3);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][3][cy][cx] = 3;  
			} 
			
			while (cx > 0)
			{
				cx -= 1;
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 3);	
				}
			}	
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false;  _isKing[Reg._playerMoving] = false; _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 12 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{
			// right-down to left-up.
			_pieceFound = false;
			
			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;			
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
			}
			
			_found = false; _pieceFound = false;			
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
			
				Reg._chessCurrentPathToKing[Reg._playerMoving][3][yy][xx] = 1;
			}
			
			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 4);	
				}
			}		
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][4][cy][cx] = 4;  
			}  
			
			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 4);	
				}
			}	
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 4 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 14 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{
			// down to up.
			_pieceFound = false;
			
			while (cy > 0)
			{
				cy -= 1;
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);		
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
			
				Reg._chessCurrentPathToKing[Reg._playerMoving][4][yy][xx] = 1;
			}
			
			while (cy > 0)
			{
				cy -= 1;
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false; 
						
			while (cy > 0)
			{
				cy -= 1;
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 5);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false; 
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][5][cy][cx] = 5;  
			}  
			
			while (cy > 0)
			{
				cy -= 1;
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 5);	
				}
			}	
		}
				
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 12 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{
			// down-left to up-right.
			_pieceFound = false;
			
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
				Reg._chessTakeKingOutOfCheckUnits[Reg._playerMoving][cy][cx] = 1;								
				
				Reg._chessCurrentPathToKing[Reg._playerMoving][5][yy][xx] = 1;
			}
			
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false; 
			
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 6);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false; 
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][6][cy][cx] = 6;  
			} 
			
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 6);	
				}
			}		
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 4 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 14 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{
			// left to right.
			_pieceFound = false;
			
			while (cx < 7)
			{
				cx += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
			
				Reg._chessCurrentPathToKing[Reg._playerMoving][6][yy][xx] = 1;
			}
			
			while (cx < 7)
			{
				cx += 1;	
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			while (cx < 7)
			{
				cx += 1;	
				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 7);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][7][cy][cx] = 7;  
			} 
			
			while (cx < 7)
			{
				cx += 1;	
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 7);	
				}
			}	
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
		
		if (_type == 1 || Reg._gamePointValueForPiece[yy][xx] == 2 || Reg._gamePointValueForPiece[yy][xx] == 5 || Reg._gamePointValueForPiece[yy][xx] == 6
		|| Reg._gamePointValueForPiece[yy][xx] == 12 || Reg._gamePointValueForPiece[yy][xx] == 15 || Reg._gamePointValueForPiece[yy][xx] == 16
		|| Reg._gamePointValueForPiece[yy][xx] == 1 || Reg._gamePointValueForPiece[yy][xx] == 11
		|| Reg._gamePointValueForPiece[yy][xx] == 3 || Reg._gamePointValueForPiece[yy][xx] == 13
		)
		{	
			// left-up to bottom-right
			_pieceFound = false;
			
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;				
				if (_found == false) assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
			}
			
			_found = false; _pieceFound = false;
			cy = yy; cx = xx; _stopAtKing = false; _defenderPiece = false; _attackerPiece = false;
			
			if (_isKing[Reg._playerMoving] == true)
			{ 
				_defenderUnits = true; _defenderPiece = true; _attackerPiece = true;
				Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx] += 1;
			
				Reg._chessCurrentPathToKing[Reg._playerMoving][7][yy][xx] = 1;
			}
			
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;	
				if (_defenderUnits == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKcapturingUnitsForPiece(yy, xx, cy, cx, _instance, Reg._playerMoving, _type);	
				}
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
						
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;

				if (_defenderPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKdefendingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 8);	
				}				
			}	
			
			cy = yy; cx = xx; _stopAtKing = false; _sameColoredPieceFound = false;
			
			if (_attackerPiece == true) 
			{
				Reg._chessCurrentPathToKing[Reg._playerMoving][8][cy][cx] = 8;  
			} 
			
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;
				
				if (_attackerPiece == true && _sameColoredPieceFound == false)  
				{
					assignBRQandKattackingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type, 8);	
				} 				
			}		
		}
		
		_found = false; _isKing[Reg._playerMoving] = false; _isKing[Reg._playerNotMoving] = false; _isKing[Reg._playerMoving] = false;  _stopAtKing = false; _defenderUnits = false; _sameColoredPieceFound = false; _otherColoredPieceFound = false;
		cy = yy; cx = xx;
	}
	
	/**
	 * otherCapturingSet calls this function until found var is true.
	 * @param	cx	the next left or right x location from the piece that was mouse clicked. if the rook is clicked then only the horizontal or vertical locations from its current location will be checked. this value decreases/increases in size then a check is made to determine if a move can be made.
	 * @param	cy	the next up or down y location from the piece that was mouse clicked.
	 * @param	xx	the x location of the piece when mouse clicked.
	 * @param	yy	the y location of the piece when mouse clicked.
	 */
	public static function assignBRQandKcapturingUnitsForImages(cy:Int, cx:Int, yy:Int, xx:Int):Void
	{	
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		
		// other player's pieces that is not moving.
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[cy][cx] >= 11 || Reg._gameHost == false && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
		{	
			if (_found == false)
			{				
				var _pawnCanCaptureKing:Bool = false;
			
				Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 1; 	
				
				_found = true;
			}
		}
		
		// cannot move piece passed the same color as your piece.
		if (Reg._gameHost == true && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._gameHost == false && Reg._gamePointValueForPiece[cy][cx] >= 11)
		{
			_found = true;
		}

		// this is an empty, none player square.
		if (Reg._gamePointValueForPiece[cy][cx] == 0) 
		{
			if (Reg._chessIsKingMoving == true)
			{								
				// this code stops a king from moving in to check. queen, rook and bishop capture pieces behind the king.
				for (i in 0...10)
				{
					if (Reg._chessKing[Reg._playerNotMoving][cy][cx] != 0 && Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] != 0 || Reg._chessRook[Reg._playerNotMoving][i][cy][cx] != 0 || Reg._chessBishop[Reg._playerNotMoving][i][cy][cx] != 0)
					{
							_found = true;
							return;
					}						
				}
			}
			
			// pawn can move in angles. those angles do not use _capturingUnitsForImages of 1 and therefore when the king is near a pawn a green movement image will display for the king when it should not. this line hide that those unit green colored image.
			if (Reg._chessIsKingMoving == true && Reg._capturingUnitsForPieces[Reg._playerNotMoving][cy][cx] == 0 && Reg._chessKing[Reg._playerNotMoving][cy][cx] == 0)
			{
				Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 1;
			}
			
			if (Reg._chessIsKingMoving == false) Reg._capturingUnitsForImages[Reg._playerMoving][cy][cx] = 1;
			//_found = true;
		} 
		
		
			
		// do not come back to this function because a king was clicked on and a king can only move one unit from its current location.
		if (Reg._gamePointValueForPiece[yy][xx] == 6 || Reg._gamePointValueForPiece[yy][xx] == 16)
			_found = true;
	}
	
	/**
	 * 
	 * @param	cx	the next left or right x location from the piece that was mouse clicked. if the rook is clicked then only the horizontal or vertical locations from its current location will be checked. this value decreases/increases in size then a check is made to determine if a move can be made.
	 * @param	cy	the next up or down y location from the piece that was mouse clicked.
	 */
	public static function assignBRQandKcapturingUnitsForPiece(yy:Int, xx:Int, cy:Int, cx:Int, _instance:Int, _playerMoving:Int, _type:Int):Void
	{		
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		// if king is found then trigger vars so that the next time at this function a different capture var will be used to store the king unit and the path to the king. this code is needed so that if in check, the pieces will only move to units that check the king.
		if (Reg._chessKingYcoordinate[Reg._playerNotMoving] == cy && Reg._chessKingXcoordinate[Reg._playerNotMoving] == cx) 
		{
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] >= 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
			{
				if (_isKing[Reg._playerMoving] == true) _stopAtKing = true;				
				if (_isKing[Reg._playerMoving] == false) _isKing[Reg._playerMoving] = true;
			}
		}
				
		// king of queen captures same piece because the computer searches for this path to capture including a piece on this path.
		if (Reg._gameUniqueValueForPiece[yy][xx] == 50 && Reg._gamePointValueForPiece[cy][cx] > 0 && _sameColoredPieceFound == false) 
		{
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11)
			Reg._chessKingAsQueen[Reg._playerMoving][cy][cx] = 1;	
		}
		
		
		// used to move computer pieces to this path to capture the king.
		if (Reg._gameUniqueValueForPiece[yy][xx] == 50)
			Reg._chessKingAsQueen[Reg._playerMoving][cy][cx] = 1;
		
		if (_type > 4 && _found == false)
		{
			// there is another of your piece at this location.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11) 
			{				
				if (_defenderUnits == true) _found = true;				
				
				if (_type > 4) 
				{
					_found = true;
					//Reg._chessKing[Reg._playerMoving][cy][cx] = 1; // can capture only a unit beside this king so do not come back to this function to capture another unit in this direction.	
				}	
			}
			
			// no piece at this location.
			if (_found == false && _pieceFound == false)
			{
				if (Reg._gamePointValueForPiece[cy][cx] == 0)
				{					
					if (_type > 4)
					{
						_found = true;
						Reg._chessKing[Reg._playerMoving][cy][cx] = 1; // can capture only a unit beside this king so do not come back to this function to capture another unit in this direction.
					}
										
					if (_defenderUnits == true) 
					{
						_found = true;
					}
				}
				else if (_defenderUnits == true) 
				{
					Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][cy][cx] = false;
				}
			}			
			
		}		
		
		// the other players capturing pieces.
		if (_pieceFound == false && _stopAtKing == false && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] >= 11 || _pieceFound == false && _stopAtKing == false && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || _type == 1)
		{		
			_sameColoredPieceFound = false;
			
			// this code is so if the king is found the unit behind king can be captured because this code only sets _otherColoredPieceFound to true if king is not found. 
			if (_isKing[Reg._playerMoving] == false) _otherColoredPieceFound = true;
			
			if (_isKing[Reg._playerMoving] == true && _defenderUnits == true && _found == false)
			{
				if (_type == 2) {Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 3) {Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 4) {Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 1;}					
							
				if (_type > 4) 
				{
					Reg._chessKing[Reg._playerMoving][cy][cx] = 1;
					
					_found = true;
				}
				
			}
			
			
			if (_isKing[Reg._playerMoving] == true && _stopAtKing == false)
			{
				_stopAtKing = true;
			}				
			
			// do not update a unit to be captured when that unit has another other player piece. when the defender king is found, the capture will continue to and beyond all empty units in that path.  
			if (Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gameUniqueValueForPiece[cy][cx] < 50 && _type > 0 
			|| Reg._gameUniqueValueForPiece[cy][cx] > 0 && _type == 1 )
			{
				if (_type == 1) {_found = true; }
				
				if (_type == 2) {Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 3) {Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 4) {Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 1;}					
							
				if (_type > 4) 
				{
					//Reg._chessKing[Reg._playerMoving][cy][cx] = 1;
					
					_pieceFound = true;
					_stopAtKing = true;
				}
				
				if (_stopAtKing == true)
				{
					_found = true;
					_defenderUnits = false;	
				}
			}
			
			else 
			{
				// king's unit.
				if (_type == 1)
				{
					if (_found == false) 
					{
						if (_instance == 0) Reg._chessKingCapturingUnitAsQueen[Reg._playerMoving][cy][cx] = 1; 
						
					}					
				}
				if (_type == 2) {Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 3) {Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 4) {Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 1;}
			}
			
			if (_isKing[Reg._playerMoving] == false) _pieceFound = true; // without this if statement, this line creates a bug where king can move down when at above king there is a piece that puts king in check. when commented, when a king is in check and its piece then blocking that check, the next move will be another message about check even thou there is no current check. 
		}
		
		else
		{
			// cannot move piece passed the same color as your piece.
			if (_found == false && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || _found == false && Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11 || _type == 1)
			{
				if (_pieceFound == false)
				{
					// for these pieces capture a piece of the same piece color.
					if ( _otherColoredPieceFound == false)
					{
						if (_type == 2) {Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] += 1;}
						if (_type == 3) {Reg._chessRook[Reg._playerMoving][_instance][cy][cx] += 1;}
						if (_type == 4) {Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] += 1; }

					}
					//_sameColoredPieceFound = true;
					_found = true; 
				}
				
				if (Reg._playerMoving == 0 && Reg._game_offline_vs_cpu == true && _stopAtKing == false  && _sameColoredPieceFound == false
				||  Reg._playerMoving == 0 && Reg._game_online_vs_cpu == true && _stopAtKing == false  && _sameColoredPieceFound == false// when computer is moving, computer needs to know that is should not take a piece when that capture will result in the player capturing the computer piece. therefore, the computer's piece will not stop populating its units when the other player's piece is found. Instead, with this code, that stop is ignored and it searches on that path until its piece is found.
				 )
				{
					
					if (_otherColoredPieceFound == false)
					{
						if (_type == 2) {Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] += 1;}
						if (_type == 3) {Reg._chessRook[Reg._playerMoving][_instance][cy][cx] += 1;}
						if (_type == 4) {Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] += 1; }
						
					}
				
					_sameColoredPieceFound = true;
				}
				
				_pieceFound = true;
			}

			// this is an empty, none player square.
			if (Reg._gamePointValueForPiece[cy][cx] == 0)
			{
				// stop loop one step after the king. king cannot move to this location because it is captured by the opponent.
				if (_stopAtKing == true && _pieceFound == false)
				{
					_pieceFound = true;
				}				

				// extend one unit past the defending king so that the defending king cannot capture that behind unit.
				if (_isKing[Reg._playerNotMoving] == true && _sameColoredPieceFound == false && _otherColoredPieceFound == false)
				{
					if (_type == 2)	Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 1;
					if (_type == 3)	Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 1;
					if (_type == 4)	Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 1;
				}
								
				// for bishop, rook and queen, do not capture a unit after same piece or other piece is found.
				if (_sameColoredPieceFound == false
				&&  _otherColoredPieceFound == false 
				)
				{
					if (_type == 2)	Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 1;
					if (_type == 3)	Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 1;
					if (_type == 4)	Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 1;
				}
								
				if (_pieceFound == true)
				{
					if (_isKing[Reg._playerMoving] == true) Reg._chessKing[Reg._playerMoving][cy][cx] = 0;
				}
				
				
				// defender king cannot capture a piece when that piece is protected.
				if (_isKing[Reg._playerMoving] == true && _pieceFound == false)
				{						
					if (_type > 4)
					{											
						Reg._chessKing[Reg._playerMoving][cy][cx] = 1;
					}
				}
				
				else if (_type > 4 && _pieceFound == false)
				{
					Reg._chessKingCanMoveToThisUnit[Reg._playerMoving][cy][cx] = true;		
					Reg._chessKing[Reg._playerMoving][cy][cx] = 1;
					_pieceFound = true;
				}								
			}				
		}
	}
	
	/**
	 * 
	 * @param	cx	the next left or right x location from the piece that was mouse clicked. if the rook is clicked then only the horizontal or vertical locations from its current location will be checked. this value decreases/increases in size then a check is made to determine if a move can be made.
	 * @param	cy	the next up or down y location from the piece that was mouse clicked.
	 */
	public static function assignBRQandKdefendingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int, _type:Int, _direction:Int):Void
	{		
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		if (_found == false)
		{
			// there is another of your piece at this location.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11) 
			{				
				_found = true;				
			}
		}		
		
		// the other players capturing pieces.
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] >= 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
		{		
			_sameColoredPieceFound = false;
			
			if (_defenderPiece == true)
			{
				if (_type == 0) {Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1; }
				
				if (_type == 2) {Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 3) {Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}
				if (_type == 4) {Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}	
			}
			
			// king found so stop looking for other unit in this path.   
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] == 6 
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] == 16) 
			{
				if (_type == 0) {Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100; }
				
				if (_type == 2) {Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 3) {Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 4) {Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}	
			
				_defenderPiece = false;
			}
		}
		
		else
		{
			// cannot move piece passed the same color as your piece.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11)
			{
				_sameColoredPieceFound = true;
				
				if (_type == 0) {Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100; }
				
				if (_type == 2) {Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 3) {Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 4) {Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 100;}	
					
				_found = true;
				_defenderPiece = false;
			}

			// this is an empty, none player square.
			if (Reg._gamePointValueForPiece[cy][cx] == 0 && _defenderPiece == true ) 
			{
				if (_type == 0) {Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1; }
				
				else if (_type == 2) {Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}
				else if (_type == 3) {Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}
				else if (_type == 4) {Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;}
			}			
		}
	}		
	
	/**
	 * 
	 * @param	cx	the next left or right x location from the piece that was mouse clicked. if the rook is clicked then only the horizontal or vertical locations from its current location will be checked. this value decreases/increases in size then a check is made to determine if a move can be made.
	 * @param	cy	the next up or down y location from the piece that was mouse clicked.
	 */
	public static function assignBRQandKattackingUnitsForPiece(cy:Int, cx:Int, _instance:Int, _playerMoving:Int, _type:Int, _direction:Int):Void
	{		
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		if (_found == false)
		{
			// there is another of your piece at this location.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11) 
			{				
				// highlights the path. assign a value to this path based on its direction to the king.
				if (_type == 0) 
				{
					Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1; 
					Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction; 
					
				}
				if (_type == 2) 
				{
					Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;
					Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;
					
				}
				if (_type == 3)
				{
					Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;
					Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;
					
				}
				if (_type == 4) 
				{
					Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 1;
					Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;
					
				}
				
				//_found = true;				
			}
		}		
		
		// the other players pieces.
		if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] >= 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
		{		
			_sameColoredPieceFound = false;

			if (_attackerPiece == true)
			{
				if (_type == 2) {Reg._chessBishopAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1;Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;}
				if (_type == 3) {Reg._chessRookAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1; Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;}
				if (_type == 4) {Reg._chessQueenAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1; Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction; }	
				
			}
			
			// king found so stop looking for other unit in this path. 
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] == 6 
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] == 16) 
			{				
				if (_type == 2) {Reg._chessBishopAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 3) {Reg._chessRookAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100;}
				if (_type == 4) {Reg._chessQueenAttackerKing[Reg._playerMoving][_instance][cy][cx] = 100;}	
			
				_attackerPiece = false;
			}
		}
		
		else
		{
			// cannot move piece passed the same color as your piece.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] >= 11)
			{
				_sameColoredPieceFound = true;
				
				if (_type == 0) {Reg._chessPawnDefenderKing[Reg._playerNotMoving][_instance][cy][cx] = 100; }
				if (_type == 2) {Reg._chessBishopDefenderKing[Reg._playerNotMoving][_instance][cy][cx] = 100;}
				if (_type == 3) {Reg._chessRookDefenderKing[Reg._playerNotMoving][_instance][cy][cx] = 100;}
				if (_type == 4) {Reg._chessQueenDefenderKing[Reg._playerNotMoving][_instance][cy][cx] = 100;}	
					
				_found = true;
				_defenderPiece = false;
			}

			// this is an empty, none player square.
			if (Reg._gamePointValueForPiece[cy][cx] == 0 && _attackerPiece == true ) 
			{
				if (_type == 2) {Reg._chessBishopAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1; Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;}
				else if (_type == 3) {Reg._chessRookAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1;Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;}
				else if (_type == 4) {Reg._chessQueenAttackerKing[Reg._playerMoving][_instance][cy][cx] = 1; Reg._chessCurrentPathToKing[Reg._playerMoving][_direction][cy][cx] = _direction;}	
			}			
		}
	}	
	
	//#############################	BISHOP - ROOK - QUEEN 
	/******************************
	 * the following code is easy to understand. these four pieces of bishop, rook, queen and king can either move horizontally, vertically or both. the code checks the unit above the clicked piece.
	 
	 * @param	Reg._playerMoving		the defender player.
	 * @param	_instance				what pawn piece or horse piece is being used.
	 * @param	cy						y coordinate of a unit.
	 * @param	cx						x coordinate of a unit.
	 */	
	public static function futurePrepareCapturingUnits(_playerMoving:Int, _p:Int, i:Int, cy:Int, cx:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		_found = false;
		
		var xx = cx;
		var yy = cy;
		
				
		if (Reg._chessForAnotherPieceValue == 2 || Reg._chessForAnotherPieceValue == 3)
		{					
			// searches from up and goes to bottom unit.
			while (cy < 7) // cannot move down if not already at the bottom of the gameboard.
			{
				cy += 1;				
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);	// jump to a function where a ChessImagesCapturingUnits var could be set to 1. if set to 1 then this piece at the ChessImagesCapturingUnits.hx will display an image, highlighting the unit to let the player know that the piece can move to this highlighted unit.			
			}
			
			_found = false;	
		}
		
		cy = yy; cx = xx;
		
		//----------------------------------------------------------------------------------------------
		// the following seven other ways that these pieces can move will not be commented because they are similar in code as above.
		//----------------------------------------------------------------------------------------------
					
		if (Reg._chessForAnotherPieceValue == 1 || Reg._chessForAnotherPieceValue == 3)
		{
			// moves to find king from up-right corner to bottom-left.
			while (cy < 7 && cx > 0)
			{
				cx -= 1; cy += 1;				
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);	
			}
			
			_found = false;	
		}
		
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 2 || Reg._chessForAnotherPieceValue == 3)
		{	
			// moves right to left.
			while (cx > 0)
			{
				cx -= 1;				
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);		
			}
			
			_found = false;	
		}
		
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 1 || Reg._chessForAnotherPieceValue == 3)
		{
			// right-down to left-up.
			while (cx > 0 && cy > 0)
			{
				cx -= 1; cy -= 1;			
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);	
			}
			
			_found = false;	
		}
		
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 2 || Reg._chessForAnotherPieceValue == 3)
		{
			// down to up.
			while (cy > 0)
			{
				cy -= 1;
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);		
			}
			
			_found = false;
		}
				
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 1 || Reg._chessForAnotherPieceValue == 3)
		{
			// down-left to up-right.
			while (cy > 0 && cx < 7)
			{
				cy -= 1; cx += 1;
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);
			}
			
			_found = false;
		}
		
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 2 || Reg._chessForAnotherPieceValue == 3)
		{
			// left to right.
			while (cx < 7)
			{
				cx += 1;				
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);	
			}
			
			_found = false;
		}
		
		cy = yy; cx = xx;
		
		if (Reg._chessForAnotherPieceValue == 1 || Reg._chessForAnotherPieceValue == 3)
		{	
			// left-up to bottom-right
			while (cx < 7 && cy < 7)
			{
				cx += 1; cy += 1;				
				if (_found == false) futureCreateCapturingUnits(_p, i, cy, cx, yy, xx, Reg._playerMoving);	
			}
			
			_found = false;
		}

		cy = yy; cx = xx;
	}
	
	public static function futureCreateCapturingUnits(_p:Int, i:Int, cy:Int, cx:Int, yy:Int, xx:Int, _playerMoving:Int):Void
	{		
		Reg._playerMoving = _playerMoving;
		
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
			
		// the following code will stop creating capturing units for the future piece when the same colored piece is found or at the unit where the other player's piece is found.
		
		// there is another of your piece at this location.
		if (Reg._playerMoving == 0 && Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11 
		 || Reg._playerMoving == 1 && Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] >= 11) 
		{				
			if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] != 17)
				{
					Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] = 1;
					
					if (Reg._gamePointValueForPiece[cy][cx] > 0	
					&&  Reg._gamePointValueForPiece[cy][cx] < 11)
						Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][i][yy][xx] += 1;
				}
			
			_found = true;
		}
		
		// other player's pieces that is not moving.
		else if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[cy][cx] >= 11 
			  || Reg._playerMoving == 1 && Reg._gamePointValueForPiece[cy][cx] > 0 && Reg._gamePointValueForPiece[cy][cx] < 11)
		{
			if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] != 17)
			{
				
				Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] = 1;
				
				if (Reg._gamePointValueForPiece[cy][cx] > 0	
				&&  Reg._gamePointValueForPiece[cy][cx] < 11)
					Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][i][yy][xx] += 1;
			}
			
			_found = true;
		}
		
		else 
		{
			if (Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] != 17) 
			{
				
				Reg._futureCapturingUnitsForPiece[Reg._playerMoving][_p][i][cy][cx] = 1;
				
				if (Reg._gamePointValueForPiece[cy][cx] > 0	
				&&  Reg._gamePointValueForPiece[cy][cx] < 11)
					Reg._futureCapturesFromPieceLocation[Reg._playerMoving][_p][i][yy][xx] += 1;
			}
		}
	}
	
	/**
	 * this function finds capturing units by going to the other players functions at this class.
	 */
	public static function capturingUnits(_reverse:Bool = false, clear_vars:Bool = true):Void
	{
		if (clear_vars == true) GameClearVars.clearVarsOnMoveUpdate();
		
		RegFunctions.is_player_attacker(true);
		populateCaptures(Reg._playerMoving); 

		// this is now the king's value. we use these values to check if there is a check beside the king.
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		var cy:Int = yy;
		var cx:Int = xx;
			
		ChessCheckOrCheckmate.isKingsLocationInCheck(yy, xx);		
		ChessCheckOrCheckmate.isUnitBesideKingInCheck(yy, xx);					
		ChessCheckOrCheckmate.isKingInCheckFromHorse();
		ChessCheckOrCheckmate.canKingInCheckTakeThatPiece();		
		ChessCheckOrCheckmate.canPieceTakeKingOutOfCkeck();		
		
		RegFunctions.is_player_attacker(false);
		populateCaptures(Reg._playerMoving);

		// this is now the king's value. we use these values to check if there is a check beside the king.
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		var cy:Int = yy;
		var cx:Int = xx;
			
		ChessCheckOrCheckmate.isKingsLocationInCheck(yy, xx);		
		ChessCheckOrCheckmate.isUnitBesideKingInCheck(yy, xx);					
		ChessCheckOrCheckmate.isKingInCheckFromHorse();
		ChessCheckOrCheckmate.canKingInCheckTakeThatPiece();		
		ChessCheckOrCheckmate.canPieceTakeKingOutOfCkeck();		
			
		if (_reverse == true) RegFunctions.is_player_attacker(false);
	}
	
	public static function populateCaptures(_playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		var yy:Int = 0;
		var xx:Int = 0;
		
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				if (Reg._playerMoving == 0 && Reg._gameUniqueValueForPiece[cy][cx] == 50 && Reg._gamePointValueForPiece[cy][cx] == 6)
				{
					Reg._chessKingYcoordinate[Reg._playerMoving] = cy;
					Reg._chessKingXcoordinate[Reg._playerMoving] = cx;
					break;
				}
				
				if (Reg._playerMoving == 1 && Reg._gameUniqueValueForPiece[cy][cx] == 50 && Reg._gamePointValueForPiece[cy][cx] == 16)
				{
					Reg._chessKingYcoordinate[Reg._playerMoving] = cy;
					Reg._chessKingXcoordinate[Reg._playerMoving] = cx;
					break;
				}
			}
		}
		
		// this is now the king's value. we use these values to check if there is a check beside the king.
		yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		var cy:Int = yy;
		var cx:Int = xx;
		
		_found = false;
		
		locationsPieceCanMove(Reg._pieceNumber, Reg._playerMoving, 6, 0); // the player moving.
		
		_found = false;
	
		
		
		//RegFunctions.is_player_attacker(false); // set back to default.
		//setForPiecesVar(Reg._playerMoving);
	}
	
	//##########################  LOCATIONS PIECE CAN MOVE ###########################
	public static function locationsPieceCanMove(_pieceNumber:Int, _playerMoving:Int, _type:Int, _funcNumber:Int):Void
	{
		Reg._playerMoving = _playerMoving;
		
		/*
		Reg._playerNotMoving = 0;
		if (Reg._playerMoving == 0) Reg._playerNotMoving = 1;
		
		Reg._pieceNumber = _pieceNumber;
		*/
	
		//############################# POPULATE PIECE LOCATIONS
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// this a king?
				if (Reg._gamePointValueForPiece[cy][cx] == (6 + Reg._pieceNumber))
				{
					Reg._chessKing[Reg._playerMoving][cy][cx] = 17; //location of piece.	
					Reg._chessKingCapturingUnitAsQueen[Reg._playerMoving][cy][cx] = 17;
					Reg._chessKingAsQueen[Reg._playerMoving][cy][cx] = 17; 
				}
						
				// this a queen?
				if (Reg._gamePointValueForPiece[cy][cx] == (5 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 30 to 39 are queens
					if (Reg._gameUniqueValueForPiece[cy][cx] > 39 && Reg._gameUniqueValueForPiece[cy][cx] < 50)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 40;
			
						Reg._chessQueen[Reg._playerMoving][_instance][cy][cx] = 17; //location of piece.		
						Reg._chessQueenDefenderKing[Reg._playerMoving][_instance][cy][cx] = 17;
						Reg._chessQueenAttackerKing[Reg._playerMoving][_instance][cy][cx] = 17;
					}
				}
				
				// this a rook?
				if (Reg._gamePointValueForPiece[cy][cx] == (4 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 30 to 39 are rooks
					if (Reg._gameUniqueValueForPiece[cy][cx] > 29 && Reg._gameUniqueValueForPiece[cy][cx] < 40)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 30;
			
						Reg._chessRook[Reg._playerMoving][_instance][cy][cx] = 17; //location of piece.		
						Reg._chessRookDefenderKing[Reg._playerMoving][_instance][cy][cx] = 17;
						Reg._chessRookAttackerKing[Reg._playerMoving][_instance][cy][cx] = 17;
					}
				}
	
				// this a horse?
				if (Reg._gamePointValueForPiece[cy][cx] == (3 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 20 to 29 are horses
					if (Reg._gameUniqueValueForPiece[cy][cx] > 19 && Reg._gameUniqueValueForPiece[cy][cx] < 30)
					{
						// var _instance needs to be 0 or 1 because these values are read from Reg._chessHorse[_otherPlayerNumber][_instance]. if this line is read then _instance equals 0 or 1. 0 is the first horse starting from the top-left of the grid.
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 20;
						
						Reg._chessHorse[Reg._playerMoving][_instance][cy][cx] = 17; //location of piece.		
					}
				}
	
				// this a bishop?
				if (Reg._gamePointValueForPiece[cy][cx] == (2 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 10 to 19 are bishop
					if (Reg._gameUniqueValueForPiece[cy][cx] > 9 && Reg._gameUniqueValueForPiece[cy][cx] < 20)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 10;
			
						Reg._chessBishop[Reg._playerMoving][_instance][cy][cx] = 17; //location of piece.		
						Reg._chessBishopDefenderKing[Reg._playerMoving][_instance][cy][cx] = 17;
						Reg._chessBishopAttackerKing[Reg._playerMoving][_instance][cy][cx] = 17;
					}
				}

				// this a pawn?
				if (Reg._gamePointValueForPiece[cy][cx] == (1 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 1 to 7 are pawns
					if (Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gameUniqueValueForPiece[cy][cx] < 9)
					{
						// var _instance is now a unique pawn value.
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 1;
						
						// location of piece
						if (Reg._gamePointValueForPiece[cy][cx] == 11) 
							Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 1;
						else 
							Reg._chessPawn[Reg._playerMoving][_instance][cy][cx] = 5;
					}
				}
			}
		}
		
		//################# POPULATE CAPTURED UNITS. NOT PIECE LOCATIONS.
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// this a king?
				if (Reg._gamePointValueForPiece[cy][cx] == (6 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// make capture units that surround the king so that the other king cannot move close to king.
					// a value of 1000 is used so that it cannot be a captured unit.
					// top-left, top, top-right.
					if (cy > 0 && cx > 0) 
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx - 1] += 1;
						// this is a unit next to king. used vs computer. computer moves piece to capture a unit next to king.	
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy - 1][cx - 1] = true;	
					}
					
					if (cy > 0 )
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy - 1][cx] = true;	
		
					}
					
					if (cy > 0 && cx < 7) 
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy - 1][cx + 1] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy - 1][cx + 1] = true;	
					}
					
					// left, right.
					if (cx > 0) 
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx - 1] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy][cx - 1] = true;	
					}
					
					if (cx < 7) 
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy][cx + 1] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy][cx + 1] = true;	
					}
					
					// bottom-left, bottom, bottom-right.
					if (cy < 7 && cx > 0)
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx - 1] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy + 1][cx - 1] = true;	
					}
					
					if (cy < 7) 
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][cy + 1][cx] += 1;
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy + 1][cx] = true;	
					}
					
					if (cy < 7 && cx < 7) 
					{
						Reg._isThisUnitNextToKing[Reg._playerMoving][cy + 1][cx + 1] = true;	
					}
					
					BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, _type);
				
					var _instance:Int = 0;
					
					// the unique value of 50 is king
					if (Reg._gameUniqueValueForPiece[cy][cx] == 50)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 50;
			
						// this is a trick for the value field. this field is ignored for kings because there can only be on king per side. this _instance field can be used to select which var will be populated. 0 for Reg._kingCapturingUnitAsQueen and 1 for Reg._kingAsQueen
						
						// top-left, top, top-right.
						if (cy > 0 && cx > 0) 
						{
							BRQandKcapturingUnitsForPiece(cy-1, cx-1, _instance, Reg._playerMoving, 1);	
						}
						
						if (cy > 0 )
						{
							BRQandKcapturingUnitsForPiece(cy - 1, cx, _instance, Reg._playerMoving, 1);
						}
						
						if (cy > 0 && cx < 7) 
						{
							BRQandKcapturingUnitsForPiece(cy - 1, cx + 1, _instance, Reg._playerMoving, 1);
						}
						
						// left, right.
						if (cx > 0) 
						{
							BRQandKcapturingUnitsForPiece(cy, cx - 1, _instance, Reg._playerMoving, 1);
						}
						
						if (cx < 7) 
						{
							BRQandKcapturingUnitsForPiece(cy, cx + 1, _instance, Reg._playerMoving, 1);
						}
						
						// bottom-left, bottom, bottom-right.
						if (cy < 7 && cx > 0)
						{
							BRQandKcapturingUnitsForPiece(cy + 1, cx - 1, _instance, Reg._playerMoving, 1);
						}
						
						if (cy < 7) 
						{
							BRQandKcapturingUnitsForPiece(cy + 1, cx, _instance, Reg._playerMoving, 1);
						}
						
						if (cy < 7 && cx < 7) 
						{
							BRQandKcapturingUnitsForPiece(cy+1, cx+1, _instance, Reg._playerMoving, 1);
						}
					}	
				
					// piece location.
					/*var _instance:Int = 0;
					
					// the unique value of 50 is king
					if (Reg._gameUniqueValueForPiece[cy][cx] == 50)
					{
						// this is a trick for the value field. this field is ignored for kings because there can only be on king per side. this _instance field can be used to select which var will be populated. 0 for Reg._kingCapturingUnitAsQueen and 1 for Reg._kingAsQueen
						BRQandKcapturingUnitsForPiece(cy, cx, 1, Reg._playerMoving, 1);
					}*/
				}
					
				// this a queen?
				else if (Reg._gamePointValueForPiece[cy][cx] == (5 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 40 to 49 are queens
					if (Reg._gameUniqueValueForPiece[cy][cx] > 39 && Reg._gameUniqueValueForPiece[cy][cx] < 50)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 40;
			
						// this is the function that will set a value of 0 or 1, a highlighted unit where a rook can be moved to by setting that value, to the Reg._chessPawn[] var. in this function, the _type var is passed the value of 4 from this parameter and a value of 4 will be know as a queen piece.
						BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, 4);
					}
				}
			
				// this a rook?
				else if (Reg._gamePointValueForPiece[cy][cx] == (4 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 30 to 39 are rooks
					if (Reg._gameUniqueValueForPiece[cy][cx] > 29 && Reg._gameUniqueValueForPiece[cy][cx] < 40)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 30;
			
					// this is the function that will set a value of 0 or 1, a highlighted unit where a rook can be moved to by setting that value, to the Reg._chessPawn[] var. in this function, the _type var is passed the value of 3 from this parameter and a value of 3 will be know as a rook piece.
						BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, 3);
					}
				}
			
				// this a horse?
				else if (Reg._gamePointValueForPiece[cy][cx] == (3 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 20 to 29 are horses
					if (Reg._gameUniqueValueForPiece[cy][cx] > 19 && Reg._gameUniqueValueForPiece[cy][cx] < 30)
					{
						// var _instance needs to be 0 or 1 because these values are read from Reg._chessHorse[_otherPlayerNumber][_instance]. if this line is read then _instance equals 0 or 1. 0 is the first horse starting from the top-left of the grid.
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 20;
						
						horseCapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving);
					}
				}
			
				// this a bishop?
				else if (Reg._gamePointValueForPiece[cy][cx] == (2 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 10 to 19 are bishop
					if (Reg._gameUniqueValueForPiece[cy][cx] > 9 && Reg._gameUniqueValueForPiece[cy][cx] < 20)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 10;
			
						BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, 2);
					}
				}
			
				// this a pawn?
				else if (Reg._gamePointValueForPiece[cy][cx] == (1 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 1 to 7 are pawns
					if (Reg._gameUniqueValueForPiece[cy][cx] > 0 && Reg._gameUniqueValueForPiece[cy][cx] < 9)
					{
						// var _instance is now a unique pawn value.
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 1;
						
						// this is the function that will set a value of 1, a highlighted unit where a pawn can be moved to by setting that value, to the Reg._chessPawn[] var.
						pawnCapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving);
					}
				}
			}
		}

		
		setForPiecesVar(Reg._playerMoving); // defender pieces can only move within the path when this is active.
		
		
		// 	HORSE. this horse is added to defender highlightUnitsGet function so that we know if a horse is protecting the king from check.
		for (cy in 0...8)
		{
			for (cx in 0...8)
			{
				// this a horse?
				if (Reg._gamePointValueForPiece[cy][cx] == (3 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 20 to 29 are horses
					if (Reg._gameUniqueValueForPiece[cy][cx] > 19 && Reg._gameUniqueValueForPiece[cy][cx] < 30)
					{
						_instance = Reg._gameUniqueValueForPiece[cy][cx] - 20;
						
						//location of piece.
						Reg._chessHorse[Reg._playerMoving][_instance][cy][cx] = 17; 
						Reg._chessHorseDefenderKing[Reg._playerMoving][_instance][cy][cx] = 17;
						
						BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, 1);
					}
				}
		
				// this a pawn? this pawn is added to defender highlightUnitsGet function so that we know if a pawn is protecting the king from check.
				if (Reg._gamePointValueForPiece[cy][cx] == (1 + Reg._pieceNumber))
				{
					var _instance:Int = 0;
					
					// the unique value of 1 to 8 are pawns
					_instance = Reg._gamePointValueForPiece[cy][cx] + Reg._pieceNumber;

					if (_instance == 11) _instance = 1;
					else _instance = 0; // array element starts at 0 not 1.
					
					//location of piece.		
					Reg._chessPawnDefenderKing[Reg._playerMoving][_instance][cy][cx] = 17;
					
					//#############################
					// create pawn path if pawn puts king in check.
					if (Reg._playerMoving == 0 && cy > 0 && cx > 0)
					{
						if (Reg._gamePointValueForPiece[cy - 1][cx - 1] == 16)
						Reg._chessPawnAttackerKing[Reg._playerMoving][_instance][cy -1][cx -1] = 100;			
					}
					
					if (Reg._playerMoving == 0 && cy > 0 && cx < 7)
					{
						if (Reg._gamePointValueForPiece[cy - 1][cx + 1] == 16)
						Reg._chessPawnAttackerKing[Reg._playerMoving][_instance][cy -1][cx + 1] = 100;			
					}
					
					if (Reg._playerMoving == 1 && cy < 7 && cx > 0)
					{
						if (Reg._gamePointValueForPiece[cy + 1][cx - 1] == 6)
						Reg._chessPawnAttackerKing[Reg._playerMoving][_instance][cy + 1][cx - 1] = 100; 					
					}
					
					if (Reg._playerMoving == 1 && cy < 7 && cx < 7)
					{
						if (Reg._gamePointValueForPiece[cy + 1][cx + 1] == 6)
						Reg._chessPawnAttackerKing[Reg._playerMoving][_instance][cy + 1][cx + 1] = 100; 					
					}
					//#############################
					//BRQandKcapturingUnitsForPiece(cy, cx, _instance, Reg._playerMoving, 0); // not sure why this is here but leave it here for a while to see if any errors happen from commenting this out.
				}
			}
		}
		
	}
	
	// returns true if piece exists at that unit. creates the forPiece capturing units.
	public static function setForPiecesVar(_playerMoving:Int):Void
	{
		Reg._playerMoving = _playerMoving;
	
		// clear the ChessImagesCapturingUnits highlighted units.
		if (Reg._chessStalemateBypassCheck == false) 
		{
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					Reg._capturingUnitsForImages[Reg._playerMoving][qy][qx] = 0;
					Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] = 0;
				}				
			}
		}
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				for (i in 0...10)
				{
			
					if (Reg._chessHorse[Reg._playerMoving][i][yy][xx] > 0 && Reg._chessHorse[Reg._playerMoving][i][yy][xx] != 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					else if (Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 && Reg._isThisUnitNextToKing[Reg._playerNotMoving][yy][xx] == false) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2;
					
					// this fixes a bug where somewhere in any hx file the horse next to king is given another value to its capturing unit.
					else if (Reg._chessHorse[Reg._playerMoving][i][yy][xx] == 17 && Reg._isThisUnitNextToKing[Reg._playerNotMoving][yy][xx] == true) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					if (Reg._chessBishop[Reg._playerMoving][i][yy][xx] > 0 && Reg._chessBishop[Reg._playerMoving][i][yy][xx] != 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					else if (Reg._chessBishop[Reg._playerMoving][i][yy][xx] == 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2;
										
					if (Reg._chessRook[Reg._playerMoving][i][yy][xx] > 0 && Reg._chessRook[Reg._playerMoving][i][yy][xx] != 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					else if (Reg._chessRook[Reg._playerMoving][i][yy][xx] == 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2;
								
					if (Reg._chessQueen[Reg._playerMoving][i][yy][xx] > 0 && Reg._chessQueen[Reg._playerMoving][i][yy][xx] != 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					else if (Reg._chessQueen[Reg._playerMoving][i][yy][xx] == 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2;

				}
				
				if (Reg._chessKing[Reg._playerMoving][yy][xx] > 0 && Reg._chessKing[Reg._playerMoving][yy][xx] != 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
				else 
				if (Reg._chessKing[Reg._playerMoving][yy][xx] == 17) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2;
				
				if (Reg._isThisUnitNextToKing[Reg._playerMoving][yy][xx] == true)
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;

				for (i in 0...8)
				{
					if (Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 1
					||	Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 5) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 2; // add again to 17 because forPieces should have a value of 2 not 1.
					
					// pawns can attack if there is a piece at an angle from that pawn.
					if (Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 6 && Reg._playerMoving == 1) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					if (Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 4 && Reg._playerMoving == 1) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					if (Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 8 && Reg._playerMoving == 0) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
					
					if (Reg._chessPawn[Reg._playerMoving][i][yy][xx] == 2 && Reg._playerMoving == 0) Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] += 1;
				}
			}
		}
		
	}
	
	public function destroy()
	{
		_found = false;
		_isKing = [false,false];
		_stopAtKing = false;
		_defenderUnits = false;
		_sameColoredPieceFound = false;
		_otherColoredPieceFound = false;
		_defenderPiece = false;
		_attackerPiece = false;
		_pieceFound = false;
	
	}
	
}// 