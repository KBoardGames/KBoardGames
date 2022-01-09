/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.checkers;

/**
 * ...move a piece or jump over an opponents piece.
 * @author kboardgames.com
 */
class CheckersMovePlayersPiece extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0;
	
	/******************************
	* at history button class, a move value is stored in this var so that we know what piece to display.  
	*/
	public static var _triggerImageValueOld:Int = -1;
	
	/******************************
	* image of the second piece such as the jumped over piece.	
	*/
	public static var _triggerImageValueOld2:Int = -1;
	
	/******************************
	* the moved to. the current piece new location.  
	*/
	public static var _triggerImageValueNew:Int = -1;
	
	/******************************
	* the middle jumped over piece that will either, depending on what direction the history is moving, be an empty unit or the middle piece placed at that unit.
	*/
	public static var _triggerImageValueNew2:Int = -1;
	
	/******************************
	* when this id value matches the instance id of this class, this ID will be used to change the display of that unit.
	*/
	public static var _triggerIdValueOld:Int = -1;

	/******************************
	* when this id value matches the instance id of this class, this ID will be used to change the display of that unit.
	*/
	public static var _triggerIdValueOld2:Int = -1;
		
	/******************************
	* when this value matches an ID, then that class instance will be used to change the display of that unit.
	*/
	public static var _triggerIdValueNew:Int = -1;
	
	/******************************
	* when this value matches an ID, then that class instance will be used to change the display of that unit.
	*/
	public static var _triggerIdValueNew2:Int = -1;
	
	/******************************
	* history button was pressed and this trigger an event to change image at unit. the mouse clicked image.
	*/
	public static var _triggerMovePiece1a:Bool = false;
	
	/******************************
	* history button was pressed and this trigger an event to change image at unit. the moved to unit of the mouse clicked image that was selected.
	*/
	public static var _triggerMovePiece1b:Bool = false;
	
	/******************************
	* history button was pressed and this trigger an event to change image at unit. the piece that was jumped over.
	*/
	public static var _triggerMovePiece2a:Bool = false;
	
	/******************************
	 * this class determines if a game has ended naturally, such as no move units to move to, or no more pieces for that player on board, etc.
	 */
	private var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (y:Float, x:Float, pieceValue:Int, id:Int, ids_win_lose_or_draw:IDsWinLoseOrDraw)
	{
		super(y, x);
	
		_id = id;

		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		_triggerImageValueOld = -1;
		_triggerImageValueOld2 = -1;
		_triggerImageValueNew = -1;
		_triggerImageValueNew2 = -1;
		_triggerIdValueOld = -1;
		_triggerIdValueOld2 = -1;
		_triggerIdValueNew = -1;
		_triggerIdValueNew2 = -1;
		_triggerMovePiece1a = false;
		_triggerMovePiece1b = false;
		_triggerMovePiece2a = false;
				
		if (pieceValue == 0) loadGraphic("assets/images/0.png", false);
		else loadGraphic("modules/games/checkers/assets/images/" + pieceValue + ".png", false); // load the different game pieces.

	}
	
	private function histroyChangeImage():Void
	{		
		if (_triggerMovePiece1a == true && _id == _triggerIdValueOld - 1)
		{
			_triggerMovePiece1a = false;
			_triggerIdValueOld = -1;
			
			if (_triggerImageValueOld == 0)	loadGraphic("assets/images/0.png", false);
			else loadGraphic("modules/games/checkers/assets/images/" + _triggerImageValueOld + ".png", false);
			
		}
		
		if (_triggerMovePiece1b == true && _id == _triggerIdValueNew - 1)
		{
			_triggerMovePiece1b = false;
			_triggerIdValueNew = -1;
			
			if (_triggerImageValueNew == 0)	loadGraphic("assets/images/0.png", false);
			else loadGraphic("modules/games/checkers/assets/images/" + _triggerImageValueNew + ".png", false);
			
		}
		
		if (_triggerMovePiece2a == true && _id == _triggerIdValueOld2 - 1)
		{
			_triggerMovePiece2a = false;
			_triggerIdValueOld2 = -1;
			
			if (_triggerImageValueOld2 == 0) loadGraphic("assets/images/0.png", false);
			else loadGraphic("modules/games/checkers/assets/images/" + _triggerImageValueOld2 + ".png", false);
						
		}
	}
		
	private function groupPlayer():Void
	{
		// since this unit now has an image, add it to a group. if this unit already had an image of the other player's piece then that image will be removed from its group. see below.
		if (Reg._groupPlayer1 != null && Reg._groupPlayer2 != null)
		{
			// here is a complicated loop that adds groups so that moved or jumped pieces are owned by the correct player. this code works so there is no need to understand it.
			if (Reg._otherPlayer == false)
			{
				if (Reg._gameHost == false ) Reg._groupPlayer2.add(this);				
				else Reg._groupPlayer1.add(this);
			}
			else
			{
				if (Reg._gameHost == false ) Reg._groupPlayer1.add(this);				
				else Reg._groupPlayer2.add(this);
			}
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
			_triggerImageValueNew = Reg._moveHistoryPieceValueNew1[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld = Reg._moveHistoryPieceLocationOld1[Reg._step];
			
			_triggerMovePiece1a = true; // trigger the event so that move is moved.
			_triggerMovePiece1b = true;
			
			Reg._gameYYold = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			Reg._gameXXold = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationOld1[Reg._step]);
			
			Reg._gameYYnew = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
			Reg._gameXXnew = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[Reg._step]);
		}
		
		// Middle piece.
		// if these values are true then there is a second piece to move.
		if (Reg._moveHistoryPieceLocationOld2[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew2[Reg._step])
		{
			// set the image value for the second piece.
			_triggerImageValueOld2 = Reg._moveHistoryPieceValueNew2[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld2 = Reg._moveHistoryPieceLocationOld2[Reg._step];
			
			_triggerMovePiece2a = true; // trigger the event so that move is moved.

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
		
		// Middle piece.
		// if these values are true then there is a second piece to move.
		if (Reg._moveHistoryPieceLocationOld2[Reg._step] !=
		    Reg._moveHistoryPieceLocationNew2[Reg._step])
		{
			// set the image value for the second piece.
			_triggerImageValueOld2 = Reg._moveHistoryPieceValueOld2[Reg._step];
			
			// get this id of this piece so that piece can be moved.
			_triggerIdValueOld2 = Reg._moveHistoryPieceLocationOld2[Reg._step];
			
			_triggerMovePiece2a = true; // trigger the event so that move is moved.
		}		

	}	
	
	override public function update (elapsed:Float)
	{	
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
				
		// ######### MOVE PIECE TO UNIT ############################################
		// this loop moves a piece that was clicked to the empty unit selected.
		if (Reg._gameMovePiece == true && Reg._gameId == 0) // _gameId with a value of 0 is checkers.
		{			
			// true if this instance matches the unit number that the player would like to move to. Reg._hasPieceMovedFinished with a value of 0 refers to the instance of the empty unit that the piece to be moved to. we start in reverse, not the clicked piece but the empty unit because we cannot clear vars that are needed to move the piece.
			if (_id == Reg._gameUnitNumberNew && Reg._hasPieceMovedFinished == 0)
			{			
				// save the image value for history.
				Reg._imageValueOfUnitNew1 = Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew];
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
				{
					// if true then this is an empty unit.
					if (Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 0)
						loadGraphic("assets/images/0.png", false);
					// else place the image of the piece on that unit.
					else loadGraphic("modules/games/checkers/assets/images/" + Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] + ".png", false);
				}
				
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYnew][Reg._gameXXnew] = 1;	
				
				// here if the normal piece has made it to the other side of the board then we make it into a king.
				if (Reg._gameYYnew == 0 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 1)
				{
					var _kingImage = 2;	
					Reg._checkersKingThePiece = true;					
					Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 2; // king. 	
					// decrease game turns for the player moving only.
					if (Reg._isThisPieceAtBackdoor == false)
					{
						RegTypedef._dataPlayers._checkers_king_total += 1;
						Reg._checkersKingThePiece = true;	
					}
					
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&&  RegTypedef._dataTournaments._move_piece == false)
						loadGraphic("modules/games/checkers/assets/images/" + _kingImage + ".png", false);
					
				}
				
				if (Reg._gameYYnew == 7 && Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] == 11)
				{
					
					var _kingImage = 12;
					Reg._checkersKingThePiece = true;
					Reg._gamePointValueForPiece[Reg._gameYYnew][Reg._gameXXnew] = 12;	// king. 		

					// decrease game turns for the player moving only.
					if (Reg._isThisPieceAtBackdoor == false)
					{
						RegTypedef._dataPlayers._checkers_king_total += 1;
						Reg._checkersKingThePiece = true;	
					}
										
					if (Reg._gameOverForPlayer == true 
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == false
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataTournaments._move_piece == true
					||	Reg._gameOverForPlayer == false
					&&  RegTypedef._dataPlayers._spectatorWatching == true
					&&  RegTypedef._dataMovement._moveHistoryTotalCount == -1
					&&  RegTypedef._dataTournaments._move_piece == false)
						loadGraphic("modules/games/checkers/assets/images/" + _kingImage + ".png", false);
					
					
				}
				
				groupPlayer(); // this deal with two groups. each player cannot click on the other player's pieces. 
				
				// when this var = 2 then moving the piece will be finished. see near the end of this function.
				Reg._hasPieceMovedFinished = 1;
			}
						
			// ######### MOVE PIECE FROM. ############################################
			//this is the piece that was clicked. here we make this unit an empty unit since we just moved that piece.
			
			// _gameMovePiece is true. therefore, make this image display as empty.
			if (_id == Reg._gameUnitNumberOld && Reg._hasPieceMovedFinished ==  1) 
			{	
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
				
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold][Reg._gameXXold] = 0;

				Reg._groupPlayer1.remove(this);
				Reg._groupPlayer2.remove(this);
							
				Reg._hasPieceMovedFinished = 2;	
			}
		}
	
		
		if (Reg._gameMovePiece == true)
		{
			Reg._notation_output = false;
			
			// piece has moved. therefore, stop the instances from running the _gameMovePiece code.
			if (Reg._hasPieceMovedFinished == 2)
			{
				// determine if this is a checkers jump over the other players piece.
				// jumping NE.
				if (Reg._gameUnitNumberOld - 14 == Reg._gameUnitNumberNew) // Reg._gameUnitNumberNew is the unit number of the yy/xx location the piece was moved to.
				{
					Reg._jumpingWhatDirection = 1; // NE
					Reg._gameUnitNumberMiddle = Reg._gameUnitNumberOld - 7; // Reg._gameUnitNumberMiddle refers to a p unit number. At Reg class, see the p function. basically, the units start at the top-left corner with a value of 0 and increments moving right.
				}
				
				// jumping SE.
				else if (Reg._gameUnitNumberOld + 18 == Reg._gameUnitNumberNew)
				{
					Reg._jumpingWhatDirection = 2; // SE
					Reg._gameUnitNumberMiddle = Reg._gameUnitNumberOld + 9;
				}
								
				// jumping SW.
				else if (Reg._gameUnitNumberOld + 14 == Reg._gameUnitNumberNew)
				{
					Reg._jumpingWhatDirection = 3;
					Reg._gameUnitNumberMiddle = Reg._gameUnitNumberOld + 7;
				}
				
				// jumping NW.
				else if (Reg._gameUnitNumberOld - 18 == Reg._gameUnitNumberNew)
				{
					Reg._jumpingWhatDirection = 4;
					Reg._gameUnitNumberMiddle = Reg._gameUnitNumberOld - 9;
				}
				
				// if we are here then piece is not jumping but moving.				
				else if (Reg._jumpingWhatDirection == -1)
				{
					if (Reg._isThisPieceAtBackdoor == false) HUD.gameTurns(Reg._gameYYnew, Reg._gameXXnew); // each player has 50 turns at start of game. when a player has no more turns then the game is a draw.
					
					if (Reg._isThisPieceAtBackdoor == false) RegTriggers._notationPrint = true;
			
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
					else Reg._playerCanMovePiece = true;
					
					Reg._hasPieceMovedFinished = 0; // the other player must not continue moving. must reset this so the other player can begin to move piece.	
					
					Reg._gameDidFirstMove = false;		
					Reg._gameMovePiece = false;	
					
					if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
					{
						if (Reg._gameHost == false) Reg._gameHost = true;
						else if (Reg._gameHost == true) Reg._gameHost = false;
					
						Reg._playerCanMovePiece = true;
						Reg._checkersShouldKeepJumping = false;

					}
					
					if (Reg._gameOverForAllPlayers == false)
						__ids_win_lose_or_draw.canPlayerMove1();
				}
				
			}
			
		}
		
		// remove the piece that had been jumped over.
		if (_id == Reg._gameUnitNumberMiddle && Reg._gameUnitNumberMiddle > -1 && Reg._hasPieceMovedFinished == 2)
		{
			Reg._gameUnitNumberMiddle  = -1; // make this var so that it does not trigger a class update().
			
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
	
			// jumping piece in direction of NE.
			if (Reg._jumpingWhatDirection == 1)
			{
				// this is for Reg._imageValueOfUnit such as this the jumped over piece.
				Reg._gameYYold2 = Reg._gameYYold - 1;
				Reg._gameXXold2 = Reg._gameXXold + 1;
				
				// store the image value in this var so to use later with history button class.
				Reg._imageValueOfUnitOld2 = Reg._gamePointValueForPiece[Reg._gameYYold-1][Reg._gameXXold+1];
				Reg._imageValueOfUnitNew2 = 0;
				
				// this is the piece that had been jumped over. not the jumping piece. this is the middle unit. the unit between the piece clicked and the empty unit. 
				//clear the vars of the middle unit.
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold - 1][Reg._gameXXold + 1] = 0;
				Reg._capturingUnitsForPieces[Reg._playerNotMoving][Reg._gameYYold-1][Reg._gameXXold+1] = 0;
				Reg._gameUniqueValueForPiece[Reg._gameYYold-1][Reg._gameXXold+1] = 0;
				Reg._gamePointValueForPiece[Reg._gameYYold-1][Reg._gameXXold+1] = 0;
			}
				
			// jumping piece NW.
			else if (Reg._jumpingWhatDirection == 4)
			{
				Reg._gameYYold2 = Reg._gameYYold - 1;
				Reg._gameXXold2 = Reg._gameXXold - 1;
				
				Reg._imageValueOfUnitOld2 = Reg._gamePointValueForPiece[Reg._gameYYold-1][Reg._gameXXold-1];
				Reg._imageValueOfUnitNew2 = 0;
				
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold - 1][Reg._gameXXold - 1] = 0;
				Reg._capturingUnitsForPieces[Reg._playerNotMoving][Reg._gameYYold-1][Reg._gameXXold-1] = 0;
				Reg._gameUniqueValueForPiece[Reg._gameYYold - 1][Reg._gameXXold- 1] = 0;
				Reg._gamePointValueForPiece[Reg._gameYYold - 1][Reg._gameXXold- 1] = 0;
			}
			
			// jumping piece SE.
			else if (Reg._jumpingWhatDirection == 2)
			{
				Reg._gameYYold2 = Reg._gameYYold + 1;
				Reg._gameXXold2 = Reg._gameXXold + 1;
				
				Reg._imageValueOfUnitOld2 = Reg._gamePointValueForPiece[Reg._gameYYold+1][Reg._gameXXold+1];
				Reg._imageValueOfUnitNew2 = 0;
				
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold + 1][Reg._gameXXold + 1] = 0;
				Reg._capturingUnitsForPieces[Reg._playerNotMoving][Reg._gameYYold+1][Reg._gameXXold+1] = 0;
				Reg._gameUniqueValueForPiece[Reg._gameYYold + 1][Reg._gameXXold+ 1] = 0;
				Reg._gamePointValueForPiece[Reg._gameYYold + 1][Reg._gameXXold+ 1] = 0;
			}
			
			// jumping piece SW.
			else if (Reg._jumpingWhatDirection == 3)
			{
				Reg._gameYYold2 = Reg._gameYYold + 1;
				Reg._gameXXold2 = Reg._gameXXold - 1;
				
				Reg._imageValueOfUnitOld2 = Reg._gamePointValueForPiece[Reg._gameYYold+1][Reg._gameXXold-1];
				Reg._imageValueOfUnitNew2 = 0;
				
				Reg._capturingUnitsForPieces[Reg._playerMoving][Reg._gameYYold + 1][Reg._gameXXold - 1] = 0;
				Reg._capturingUnitsForPieces[Reg._playerNotMoving][Reg._gameYYold+1][Reg._gameXXold-1] = 0;
				Reg._gameUniqueValueForPiece[Reg._gameYYold + 1][Reg._gameXXold- 1] = 0;
				Reg._gamePointValueForPiece[Reg._gameYYold + 1][Reg._gameXXold- 1] = 0;
			}
			
			if (Reg._isThisPieceAtBackdoor == false) RegTriggers._notationPrint = true;
			
			if (Reg._isThisPieceAtBackdoor == false) HUD.gameTurns(Reg._gameYYnew, Reg._gameXXnew); // each player has 50 turns at start of game. when a player has no more turns then the game is a draw.
			
			Reg._jumpingWhatDirection = -1;
						
			Reg._groupPlayer1.members.remove(this); // remove the jumped over piece.
			Reg._groupPlayer2.members.remove(this);
				
			// set some vars for the next move in that same turn if any.
			Reg._checkersFoundPieceToJumpOver = false;
			Reg._checkersShouldKeepJumping = true;
			Reg._checkersIsThisFirstMove = false;
			Reg._checkersUniquePieceValue[Reg._gameYYnew][Reg._gameXXnew] = 2;		
			// not needed.
			// this holds the value of the unit that the piece jumped over. This is needed for a offline game so that the unit can later be set to zero if these vars have a value not equal -1.
			//Reg._gameYYnew2 = Reg._gameYYold2;
			//Reg._gameXXnew2 = Reg._gameXXold2;
			
			// search again for another jump. here we use the backdoor var. notice the Reg._playerNotMoving, at that line the backdoor is true. the other player is simply searching for any capturing units that we may move to or jump over. we use this backdoor because without it, that player's next turn may be trigged early if searching for his/hers capturing unit. 
			if (Reg._isThisPieceAtBackdoor == false)
			CheckersCapturingUnits.jumpCapturingUnitsForPiece(Reg._gameYYnew, Reg._gameXXnew, Reg._playerMoving);
			else CheckersCapturingUnits.jumpCapturingUnitsForPiece(Reg._gameYYnew, Reg._gameXXnew, Reg._playerNotMoving);
			
			// clear some vars to trigger events at updates().
			Reg._isThisPieceAtBackdoor = false;			
			Reg._hasPieceMovedFinished = 0;
			Reg._gameDidFirstMove = false;		
			Reg._gameMovePiece = false;
			
			if (Reg._checkersFoundPieceToJumpOver == false)
			{			
				Reg._checkersShouldKeepJumping = false;
				Reg._checkersIsThisFirstMove = true;
				//Reg._checkersUniquePieceValue[Reg._gameYYnew][Reg._gameXXnew] = 0;
				
				for (qy in 0...8)
				{
					for (qx in 0...8)
					{
						Reg._checkersUniquePieceValue[qy][qx] = 0;
						Reg._capturingUnitsForPieces[0][qy][qx] = 0;
						Reg._capturingUnitsForPieces[1][qy][qx] = 0;
					}				
				}	

				if (Reg._playerCanMovePiece == true) 
				{
					Reg._playerCanMovePiece = false;
				
					// this is needed for basic notation buttons use.
					Reg._moveNumberCurrentForNotation = Reg._move_number_next;
						
					Reg._move_number_next += 1;
														
					// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
					if (Reg._move_number_next >= 2)
					Reg._move_number_next = 0;
					
					if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
					{
						if (Reg._gameHost == false) Reg._gameHost = true;
						else if (Reg._gameHost == true) Reg._gameHost = false;
						
						 Reg._playerCanMovePiece = true;
					}
				}
				else Reg._playerCanMovePiece = true;				
			}
			
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
				Reg._isThisPieceAtBackdoor = false;			
				Reg._hasPieceMovedFinished = 0;
				Reg._gameDidFirstMove = false;		
				Reg._gameMovePiece = false;
				Reg._checkersShouldKeepJumping = false;
				Reg._checkersIsThisFirstMove = true;
				
				for (qy in 0...8)
				{
					for (qx in 0...8)
					{
						Reg._checkersUniquePieceValue[qy][qx] = 0;
						Reg._capturingUnitsForPieces[0][qy][qx] = 0;
						Reg._capturingUnitsForPieces[1][qy][qx] = 0;
					}				
				}
			}
			
			__ids_win_lose_or_draw.canPlayerMove1();
						
		} 
				
		histroyChangeImage();
		
		super.update(elapsed);		
	}
	
}