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
 * ...this class holds all gameboard pieces for both players.
 * @author kboardgames.com
 */
class ChessMovePlayersPiece extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	/******************************
	 * unit number that starts from the top-left corner (0) and ends at the bottom-right corner (63).
	 */
	private var _p:Int = -1;
	
	private var _doOnce:Int = 0; // TODO verify if this var is still needed.
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. image old move value.
	 */
	public static var _triggerImageValueOld:Int = -1;
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. second image old move value such as in castling.
	 */
	public static var _triggerImageValueOld2:Int = -1;
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. value of first piece selected before move. if moving piece backwards then this piece will get the new value, the moved to value.
	 */
	public static var _triggerIdValueOld:Int = -1;
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. value of other piece selected such as castling before move happens. if moving piece backwards then this piece will get the new value, the moved to value.
	 */
	public static var _triggerIdValueOld2:Int = -1;
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. normal piece movement. piece is moved to this location.
	 */
	public static var _triggerImageValueNew:Int = -1;
	
	/******************************
	 * at history button class, a move value is stored in this var so that we know what piece to display. if two pieces are moved at the same time then this is the second piece end move location.
	 */
	public static var _triggerImageValueNew2:Int = -1;
	
	/******************************
	 * at history button class, the end of a move value is stored in this var so that we know what piece to display. this is where the piece moves to. if moving piece forward in history then this piece will get the old value, the moved from value.
	 */
	public static var _triggerIdValueNew:Int = -1;
	
	/******************************
	 * at history button class, the end of a move value is stored in this var so that we know what piece to display. this is where the piece moves to. this is the second piece such as when castling if moving piece forward in history then this piece will get the old value, the moved from value.
	 */
	public static var _triggerIdValueNew2:Int = -1;
	
	/******************************
	 * history button was pressed and this trigger an event to change image at unit. normal piece selected. move from location.
	 */
	public static var _triggerMovePiece1a:Bool = false;
	
	/******************************
	 * history button was pressed and this trigger an event to change image at unit. second piece move from location such as a rook in castling.
	 */
	public static var _triggerMovePiece1b:Bool = false;	
	
	/******************************
	 * history button was pressed and this trigger an event to change image at unit. this is the move to location in a normal move.
	 */
	public static var _triggerMovePiece2a:Bool = false;
	
	private static var _pieceValue:Int = 0;

	/******************************
	 * history button was pressed and this trigger an event to change image at unit. this is a move to location if a second piece is needed to be moved such as a rook in castling.
	 */
	public static var _triggerMovePiece2b:Bool = false;
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	str				the game board name and the folder to access. 
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (y:Float, x:Float, pieceValue:Int, id:Int)
	{
		super(y, x);
	
		_pieceValue = pieceValue;
		_id = id;
		 _triggerImageValueOld = -1;
		_triggerImageValueOld2 = -1;
		_triggerIdValueOld = -1;
		_triggerIdValueOld2 = -1;
		_triggerImageValueNew = -1;
		_triggerImageValueNew2 = -1;
		_triggerIdValueNew = -1;
		_triggerIdValueNew2 = -1;
		_triggerMovePiece1a = false;
		_triggerMovePiece1b = false;	
		_triggerMovePiece2a = false;
		_triggerMovePiece2b = false;

		if (_pieceValue == 0) loadGraphic("assets/images/0.png", false);
		else 
		{
			if (_pieceValue < 11)
				loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + _pieceValue + ".png", false);
			else
				loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + _pieceValue + ".png", false);
				
			if (_pieceValue < 11) color = RegFunctions.draw_update_board_p1_set_color();
			else color = RegFunctions.draw_update_board_p2_set_color();
		}		
		
	}

	override public function update (elapsed:Float)
	{
		
/*
trace("~~~~");
trace(_triggerImageValueOld + " _triggerImageValueOld");
trace(_triggerImageValueOld2 + " _triggerImageValueOld2");
trace(_triggerImageValueNew + " _triggerImageValueNew");
trace(_triggerImageValueNew2 + " _triggerImageValueNew2");
trace("~~~~");
*/
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
			
		if (Reg._gameMovePiece == true && Reg._gameId == 1)
		{			
			// true if this instance that refers to p, the unit number, matches the unit number that the player would like to move to.
			if (_id == Reg._gameUnitNumberNew || _id == Reg._gameUnitNumberNew2)
			{				
				// change the image of this unit, regardless if it be empty or not, to the new image,
				if (_id == Reg._gameUnitNumberNew)
				{
					// save the image value for history.
					Reg._imageValueOfUnitNew1 = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
					
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&&  RegTypedef._dataTournaments._move_piece == false)
					{
						if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 11)
							loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] + ".png", false);
						else
							loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] + ".png", false);
							
						if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 11)
							color = RegFunctions.draw_update_board_p1_set_color();
						else
							color = RegFunctions.draw_update_board_p2_set_color();
					}
					
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1;	// 1 is needed so to highlight the players move for the other player.
					Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1;	
				}				
					
				if (_id == Reg._gameUnitNumberNew2) 
				{
					// save the image value for history.
					Reg._imageValueOfUnitNew2 = Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2];
					
					Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = Reg._pointValue2;
					Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = Reg._uniqueValue2;
					
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&& RegTypedef._dataTournaments._move_piece == false)
					{
						if (Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 11)
							loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] + ".png", false);
						else
							loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] + ".png", false);
							
						if (Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 11)
							color = RegFunctions.draw_update_board_p1_set_color();
						else 
							color = RegFunctions.draw_update_board_p2_set_color();
					}
					
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew2][Reg._gameXXnew2] = 1;
				}			
				
				groupPlayer();
				
				_doOnce = 0;
				
				
				// when this var = 2 then moving the piece will be finished. see near the end of this function.
				Reg._hasPieceMovedFinished += 1;
			}
						
			// this is the moved from. not the ChessImagesCapturingUnits but the image that was clicked before the highlighted unit was clicked.
			if (_id == Reg._gameUnitNumberOld || _id == Reg._gameUnitNumberOld2)
			{	
				// _gameMovePiece is true. therefore, make this image display as empty.
				if (_id == Reg._gameUnitNumberOld) 
				{
					// save the image value for history.
					Reg._imageValueOfUnitOld1 = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold];
					
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&&  RegTypedef._dataTournaments._move_piece == false)
						loadGraphic("assets/images/0.png", false);
					
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 1;
					Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
					Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] = 0;
				}
				
				if (_id == Reg._gameUnitNumberOld2) 
				{
					// save the image value for history.
					Reg._imageValueOfUnitOld2 = Reg._gamePointValueForPiece[Reg._gameYYold2][Reg._gameXXold2];
					
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&&  RegTypedef._dataTournaments._move_piece == false)
						loadGraphic("assets/images/0.png", false);
					
					Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYold2][Reg._gameXXold2] = 0;
					Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold2][Reg._gameXXold2] = 0;
					Reg._gameUniqueValueForPiece[Reg._gameYYold2][Reg._gameXXold2] = 0;
					Reg._gamePointValueForPiece[Reg._gameYYold2][Reg._gameXXold2] = 0;
				}

				Reg._groupPlayer1.remove(this);
				Reg._groupPlayer2.remove(this);
								
				Reg._hasPieceMovedFinished += 1;			
				
			}
			
		}		
		
		if (Reg._gameId == 1)
		{
			// the _id refers to a unit number. if you want to do something to unit 5 then pass that value such as if _id == 5. if the value is unknown but that unit xx and yy coordinates are known then pass the coordinates to this function and p will be that unit value. then all that is needed is if p = _id then we will be at that class instance.
			if (Reg._gameYYnew == 2) _p = RegFunctions.getP(Reg._gameOtherPlayerYnew + 1, Reg._gameXXnew);
			else if (Reg._gameYYnew == 5) _p = RegFunctions.getP(Reg._gameOtherPlayerYnew - 1, Reg._gameXXnew);
				

			// the first two paragraphs deal with the white pawn moving up if the conditions are true then that pawn can do a En passant. _doOnce is used so that this block is read only once pre move. Reg.isEnPassant means that the pawn which is selected can move En passant. Reg._playerMoving is the host. p = the pawn which has don't the En passant so the values here are used to enter the block to remove the defenders piece.
			if (_doOnce == 0 && Reg._isEnPassant == true && Reg._playerMoving == 0 && _p == _id && Reg._gameOtherPlayerYnew + 1 == 3 && Reg._chessEnPassantPawnLocationY == Reg._gameYYnew + 1 && Reg._chessEnPassantPawnLocationX == Reg._gameXXnew && Reg._gameOtherPlayerYnew == Reg._gameYYnew && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] < 9
			
			||  _doOnce == 0 && Reg._isEnPassant == true && Reg._playerMoving == 1 && _p == _id && Reg._gameOtherPlayerYnew + 1 == 3 && Reg._gameOtherPlayerYnew == Reg._gameYYnew && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] < 9
			
			// these two blocks are the black piece moving down to do a En passant. if p = _id and then conditions are true then enter into the block and remove the defenders piece. we remove it here for the attacker, the black piece and below for the host, the white piece to be removed.
			|| _doOnce == 0 && Reg._isEnPassant == true && Reg._playerMoving == 1 && _p == _id && Reg._gameOtherPlayerYnew - 1 == 4 && Reg._chessEnPassantPawnLocationY == Reg._gameYYnew - 1 && Reg._chessEnPassantPawnLocationX == Reg._gameXXnew && Reg._gameOtherPlayerYnew == Reg._gameYYnew && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] < 9
			
			|| _doOnce == 0 && Reg._isEnPassant == true && Reg._playerMoving == 0 && _p == _id && Reg._gameOtherPlayerYnew - 1 == 4 && Reg._gameOtherPlayerYnew == Reg._gameYYnew && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameXXnew] < 9)
			{
				//_doOnce = 1;
				
				if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1)
				{
					if (Reg._gameOtherPlayerYnew + 1 == 3 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew + 1][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew + 1][Reg._gameXXnew] < 9)
					{
						// _gameMovePiece is true. therefore, make this image display as empty.
						if (Reg._gameOverForPlayer == true 
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataPlayers._spectatorWatching == false
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataTournaments._move_piece == true
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataPlayers._spectatorWatching == true
						&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
						&&  RegTypedef._dataTournaments._move_piece == false)
							loadGraphic("assets/images/0.png", false);
						
						// now these lines will make it so that this unit can be captured. without these lines this unit would still act as a black piece that cannot be captured by its other pieces.
						Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew + 1][Reg._gameXXnew] = 0;
						Reg._gamePointValueForPiece[Reg._gameOtherPlayerYnew + 1][Reg._gameXXnew] = 0;
						
						// these lines are needed so that when one En passant has been done and this one is very close beside that move, then this second En passant would not have a correct movement value. resulting in an En passant that cannot be made.
						Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameOtherPlayerXnew]] = 0;
						Reg._triggerNextStuffToDo = 0;
						
						if (Reg._playerMoving == 1) Reg._isEnPassant = false;
					
					}
				}
				
				else if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11)
				{
					if (Reg._gameOtherPlayerYnew - 1 == 4 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew - 1][Reg._gameXXnew] > 0 && Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew - 1][Reg._gameXXnew] < 9)
					{
						// _gameMovePiece is true. therefore, make this image display as empty.
						if (Reg._gameOverForPlayer == true 
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataPlayers._spectatorWatching == false
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataTournaments._move_piece == true
						||	Reg._gameOverForPlayer == false
						&&  RegTypedef._dataPlayers._spectatorWatching == true
						&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
						&&  RegTypedef._dataTournaments._move_piece == false)
							loadGraphic("assets/images/0.png", false);
						
						Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew - 1][Reg._gameXXnew] = 0;
						Reg._gamePointValueForPiece[Reg._gameOtherPlayerYnew - 1][Reg._gameXXnew] = 0;
						
						Reg._chessPawnMovementTotalSet[Reg._playerMoving][Reg._gameUniqueValueForPiece[Reg._gameOtherPlayerYnew][Reg._gameOtherPlayerXnew]] = 0;
						Reg._triggerNextStuffToDo = 0;
						
						if (Reg._playerMoving == 0) Reg._isEnPassant = false;
					}
				}
				
				// a defender piece has been removed when an En passant was made. now we need to remove that unit's piece from the group.
				Reg._groupPlayer1.remove(this);
				Reg._groupPlayer2.remove(this);
				
				ChessEnPassant.doneEnPassant();
			}
				
			
				
			//############################# PAWN PROMOTED
			if (Reg._chessPawnIsPromoted == true && _id == Reg._gameUnitNumberNew)
			{					
				
				// save the image value for history.
				Reg._step -= 1;
				
				Reg._imageValueOfUnitNew1 = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
	
				Reg._historyImageChessPromotion[Reg._step] = Reg._imageValueOfUnitNew1;
				
				Reg._step += 1;
				
				if (Reg._gameOverForPlayer == true 
				||	Reg._gameOverForPlayer == false
				&&  RegTypedef._dataPlayers._spectatorWatching == false
				||	Reg._gameOverForPlayer == false
				&&  RegTypedef._dataTournaments._move_piece == true
				||	Reg._gameOverForPlayer == false
				&&  RegTypedef._dataPlayers._spectatorWatching == true
				&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
				&&  RegTypedef._dataTournaments._move_piece == false)
				{
					if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 11)
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] + ".png", false);
					else
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] + ".png", false);
					
					if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] < 11)
						color = RegFunctions.draw_update_board_p1_set_color();
					else
						color = RegFunctions.draw_update_board_p2_set_color();
				}
				
				Reg._capturingUnitsForImages[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 0;
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 0;
				
				if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false) groupPlayer();
				else 
				{
					if (Reg._gameHost == true )
					{
						Reg._groupPlayer2.add(this);
						Reg._groupPlayer1.remove(this);
					}
					else
					{
						Reg._groupPlayer1.add(this);
						Reg._groupPlayer2.remove(this);
					}
				}
				
				Reg._chessUnitsInCheckTotal[Reg._playerMoving] = 0;
				Reg._chessPawnIsPromoted = false;
				Reg._pieceMovedUpdateServer = true;
			}
			
			if (Reg._gameMovePiece == true)
			{
				if (Reg._gameUnitNumberNew2 != -1 && Reg._gameUnitNumberOld2 != -1) Reg._castlingSoAddToTotal = 2;
				else Reg._castlingSoAddToTotal = 0;
				
				// piece has moved. therefore, stop the instances from running the _gameMovePiece code.
				if (Reg._hasPieceMovedFinished == (2 + Reg._castlingSoAddToTotal))
				{
					if (Reg._game_offline_vs_player == false && Reg._game_offline_vs_cpu == false)
					{
						if (Reg._playerCanMovePiece == true)
						{
							Reg._playerCanMovePiece = false;
							
							// this is needed for basic notation buttons use.
							Reg._moveNumberCurrentForNotation = Reg._move_number_next;
					
							Reg._move_number_next += 1;
															
							// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
							if (Reg._move_number_next >= 2)
							Reg._move_number_next = 0;
						}
						
						else 
						{
							Reg._playerCanMovePiece = true;
						
							
						}
						
						//if (Reg._gameMessage == "") GameHistoryAndNotations.notationPrint();
					}
					
					else
					{ 		
						// this is needed for basic notation buttons use.
						Reg._moveNumberCurrentForNotation = Reg._move_number_next;
						
						Reg._move_number_next += 1;
															
						// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
						if (Reg._move_number_next >= 2)
						Reg._move_number_next = 0;
						
						// offline game.
						if (Reg._gameHost == false) Reg._gameHost = true;
						else if (Reg._gameHost == true) Reg._gameHost = false;
						
						Reg._messageId = 0; // this triggers an event to make the restart game and to title buttons active again.
						
						//if (Reg._gameMessage == "") GameHistoryAndNotations.notationPrint();
						FlxG.mouse.reset();
					}
								
					Reg._gameDidFirstMove = false;		
					Reg._hasPieceMovedFinished = 0;			
					Reg._gameMovePiece = false;	
					Reg2._updateNotation = true;
				}
			}

			

		}
		
		
		if (_triggerMovePiece1a == true && _id == _triggerIdValueOld - 1)
		{
			_triggerMovePiece1a = false;
			_triggerIdValueOld = -1;
			
			if (Reg._moveHistoryPieceValueOld3[Reg._step] > 0
			&& IDsHistoryButtons._history_moving_forward == false)
			{
				if (Reg._moveHistoryPieceValueOld3[Reg._step] < 11)
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + Reg._moveHistoryPieceValueOld3[Reg._step] + ".png", false);
					else
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + Reg._moveHistoryPieceValueOld3[Reg._step] + ".png", false);
						
					if (Reg._moveHistoryPieceValueOld3[Reg._step] < 11) color = RegFunctions.draw_update_board_p1_set_color();
					else color = RegFunctions.draw_update_board_p2_set_color();
			}
			
			else
			{
				if (_triggerImageValueOld == 0)
				loadGraphic("assets/images/0.png", false);
				else
				{
					if (_triggerImageValueOld < 11)
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + _triggerImageValueOld + ".png", false);
					else
						loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + _triggerImageValueOld + ".png", false);
						
					if (_triggerImageValueOld < 11) color = RegFunctions.draw_update_board_p1_set_color();
					else color = RegFunctions.draw_update_board_p2_set_color();
				}
			}
		}
		
		if (_triggerMovePiece1b == true && _id == _triggerIdValueNew - 1)
		{
			_triggerMovePiece1b = false;
			_triggerIdValueNew = -1;
			
			if (_triggerImageValueNew == 0)
			loadGraphic("assets/images/0.png", false);
			else 
			{
				if (_triggerImageValueNew < 11)
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + _triggerImageValueNew + ".png", false);
				else
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + _triggerImageValueNew + ".png", false);
					
				if (_triggerImageValueNew < 11) color = RegFunctions.draw_update_board_p1_set_color();
				else color = RegFunctions.draw_update_board_p2_set_color();
			}
		}
		
		if (_triggerMovePiece2a == true && _id == _triggerIdValueOld2 - 1)
		{
			_triggerMovePiece2a = false;
			_triggerIdValueOld2 = -1;
			
			if (_triggerImageValueOld2 == 0)
			loadGraphic("assets/images/0.png", false);
			else 
			{
				if (_triggerImageValueOld2 < 11)
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + _triggerImageValueOld2 + ".png", false);
				else
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + _triggerImageValueOld2 + ".png", false);
					
				if (_triggerImageValueOld2 < 11) color = RegFunctions.draw_update_board_p1_set_color();
				else color = RegFunctions.draw_update_board_p2_set_color();
			}
		}
		
		if (_triggerMovePiece2b == true && _id == _triggerIdValueNew2 - 1)
		{
			_triggerMovePiece2b = false;
			_triggerIdValueNew2 = -1;
			
			if (_triggerImageValueNew2 == 0)
			loadGraphic("assets/images/0.png", false);
			else 
			{
				if (_triggerImageValueNew2 < 11)
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p1_set + "/" + _triggerImageValueNew2 + ".png", false);
				else
					loadGraphic("assets/images/chess/set" + RegCustom._chess_current_piece_p2_set + "/" + _triggerImageValueNew2 + ".png", false);
					
				if (_triggerImageValueNew2 < 11) color = RegFunctions.draw_update_board_p1_set_color();
				else color = RegFunctions.draw_update_board_p2_set_color();
			}
		}
	
		super.update(elapsed);
	}
	
	private function groupPlayer():Void
	{
		Reg._groupPlayer1.remove(this); // these are needed.
		Reg._groupPlayer2.remove(this);
		
		// since this unit now has an image, add it to a group. if this unit already had an image of the other player's piece then that image will be removed from its group. see below.
		if (Reg._otherPlayer == false)
		{
			if (Reg._gameHost == false )
			Reg._groupPlayer2.add(this);				
			else Reg._groupPlayer1.add(this);
		}
		else
		{
			if (Reg._gameHost == false )
			Reg._groupPlayer1.add(this);				
			else Reg._groupPlayer2.add(this);
		}
		
		Reg._otherPlayer = false;
	}
	
	
	public static function historyMovePieceForwards():Void
	{	
		Reg._step -= 1;
	
		// moving piece normally or jumping over piece.
		// if these values are true then this piece should be moved.
		if (Reg._moveHistoryPieceLocationOld1[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew1[Reg._step])
		{
			// set the image value for the first piece.
			_triggerImageValueOld = Reg._moveHistoryPieceValueOld1[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueNew = Reg._moveHistoryPieceLocationNew1[Reg._step];
			
			// set the image value for the first piece.
			if (Reg._historyImageChessPromotion[Reg._step] > 0) _triggerImageValueNew = Reg._historyImageChessPromotion[Reg._step];
			else _triggerImageValueNew = Reg._moveHistoryPieceValueNew1[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld = Reg._moveHistoryPieceLocationOld1[Reg._step];
			
			_triggerMovePiece1a = true; // trigger the event so that move is made.
			_triggerMovePiece1b = true;
			
			Reg._gameYYold = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			Reg._gameXXold = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			
			Reg._gameYYnew = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
			Reg._gameXXnew = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
			
		}
		
		// if these values are true then there is a second piece to move.
		if (Reg._moveHistoryPieceLocationOld2[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew2[Reg._step])
		{
			// set the image value for the second piece.
			_triggerImageValueOld2 = Reg._moveHistoryPieceValueOld2[Reg._step];
			_triggerImageValueNew2 = Reg._moveHistoryPieceValueNew2[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld2 = Reg._moveHistoryPieceLocationOld2[Reg._step];
			_triggerIdValueNew2 = Reg._moveHistoryPieceLocationNew2[Reg._step];
			
			_triggerMovePiece2a = true; // trigger the event so that move is moved.
			_triggerMovePiece2b = true;
			
			Reg._gameYYold2 = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationOld2[Reg._step]);
			Reg._gameXXold2 = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationOld2[Reg._step]);
			
			Reg._gameYYnew2 = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew2[Reg._step]);
			Reg._gameXXnew2 = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew2[Reg._step]);
		}
		
		Reg._step += 1;
		
	}
	
	public static function historyMovePieceBackwards():Void
	{
		// moving piece normally or jumping over piece.
		// if these values are true then this piece should be moved.
		if (Reg._moveHistoryPieceLocationOld1[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew1[Reg._step])
		{
			// set the image value for the first piece.
			_triggerImageValueOld = Reg._moveHistoryPieceValueOld1[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueNew = Reg._moveHistoryPieceLocationOld1[Reg._step];
			
			// set the image value for the first piece.
			_triggerImageValueNew = Reg._moveHistoryPieceValueNew1[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld = Reg._moveHistoryPieceLocationNew1[Reg._step];
			
			_triggerMovePiece1a = true; // trigger the event so that move is moved.
			_triggerMovePiece1b = true;
			
			Reg._gameYYold = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			Reg._gameXXold = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			
			Reg._gameYYnew = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
			Reg._gameXXnew = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
		}
		
		// if these values are true then there is a second piece to move.
		if (Reg._moveHistoryPieceLocationOld2[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew2[Reg._step])
		{
			// set the image value for the second piece.
			_triggerImageValueOld2 = Reg._moveHistoryPieceValueOld2[Reg._step];
			_triggerImageValueNew2 = Reg._moveHistoryPieceValueNew2[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld2 = Reg._moveHistoryPieceLocationNew2[Reg._step];
			_triggerIdValueNew2 = Reg._moveHistoryPieceLocationOld2[Reg._step];
			
			// trigger the event so that piece is moved.
			_triggerMovePiece2a = true; 
			_triggerMovePiece2b = true;
			
			Reg._gameYYold2 = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationOld2[Reg._step]);
			Reg._gameXXold2 = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationOld2[Reg._step]);
			
			Reg._gameYYnew2 = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew2[Reg._step]);
			Reg._gameXXnew2 = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew2[Reg._step]);
		}
		
	/*	
		trace("1old"+_triggerIdValueOld);
		trace("1new"+_triggerIdValueNew);
		trace("2old"+_triggerIdValueOld2);
		trace("2new"+_triggerIdValueNew2);
		trace("image 1old"+_triggerImageValueOld);
		trace("image 1new"+_triggerImageValueNew);
		trace("image 2old"+_triggerImageValueOld2);
		trace("image 2new"+_triggerImageValueNew2);
		trace ("~~~~~~~~~~~~~~~~~~~~~~~");
		*/
	}
	
}//