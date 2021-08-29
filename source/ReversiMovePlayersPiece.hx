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
 * ...move a piece or jump over an opponents piece.
 * @author kboardgames.com
 */
class ReversiMovePlayersPiece extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
			
	/**
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	pieceValue		used to load an image of a gameboard piece.
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 */
	public function new (y:Float, x:Float, pieceValue:Int, id:Int)
	{
		super(y, x);
	
		_id = id;

		if (pieceValue == 0) loadGraphic("assets/images/0.png", false); // empty unit.
		else loadGraphic("assets/images/reversi/" + pieceValue + ".png", false); // load the different game pieces.

	}

	override public function update (elapsed:Float)
	{	
		RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.
			
		// ######### MOVE PIECE ############################################
		var _count:Int = 0;
			
		if (Reg._reversiReverseIt2 == true  && Reg._gameYYold != -1 && Reg._gameXXold != -1 && Reg._otherPlayer == true 
		|| Reg._gameDidFirstMove == true 
		|| Reg._game_offline_vs_cpu == false 
		&& Reg._otherPlayer == true 
		&& Reg._gameYYold != -1 
		&& Reg._gameXXold != -1
		|| Reg._game_offline_vs_player == false 
		&& Reg._otherPlayer == true 
		&& Reg._gameYYold != -1 
		&& Reg._gameXXold != -1 )
		{		
			Reg._gameMovePiece = true;
		
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	//get total value of this var. the count is then later used to change the player not moving piece to owns after a different var pluses a count at each _id.
					if (Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 2 || Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2)
					{
						_count += 1;
					}
					
					
				}
			}			
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					var p = RegFunctions.getP(yy, xx);
					
					// if ID = p then we are at the correct class instance. check if this instance also has a capturing value of 2.
					if (_id == p && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 2 || _id == p && Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] == 2) 
					{							
						// Reg._reversiProcessAllIdsTotal has only one instance at Reg and shares its data with this class.  when this var has the same total as _count then that means every ID that holds the other player's piece can be flipped.							
						Reg._reversiProcessAllIdsTotal += 1;
					
						// change the image of the unit...
						displayImage(yy, xx);
						
							
						//... and also its group. all piece within this group is now owned by the player.
						Reg._groupPlayer1.remove(this);	
						Reg._groupPlayer2.remove(this);	
						groupPlayer();
						
					//	Reg._otherPlayer = false;
					}
					
					if ( _id == p && Reg._gameYYold == yy && Reg._gameXXold == xx) 
					{							
						// change the image of the unit...
						displayImage(yy, xx);
						
						//... and also its group. all piece within this group is now owned by the player.
						Reg._groupPlayer1.remove(this);	
						Reg._groupPlayer2.remove(this);	
						groupPlayer();
						
					}
				}
			}	
			
		
		}
		
		//  || Reg._triggerNextStuffToDo <= 3 && Reg._gameDidFirstMove == true
		if (Reg._reversiProcessAllIdsTotal > 0 && Reg._reversiProcessAllIdsTotal == _count && Reg._gameDidFirstMove == true)
		{
			Reg._triggerNextStuffToDo += 1;
			
			// piece has moved. therefore, stop the instances from running the _gameMovePiece code.
			
			if (Reg._reversiReverseIt == true) 
			{
				Reg._reversiReverseIt = false;
			}
			
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				if (Reg._playerMoving == 1 && Reg._playerCanMovePiece == true)
				{
					// this is needed for basic notation buttons use.
					Reg._moveNumberCurrentForNotation = Reg._move_number_next;
					
					Reg._move_number_next += 1;
												
					// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
					if (Reg._move_number_next >= 2)
					Reg._move_number_next = 0;
				
					Reg._playerCanMovePiece = false;
					Reg._reversiMovePiece = false;
					Reg._pieceMovedUpdateServer = true;
					
				}
				else if (Reg._playerMoving == 0 && Reg._playerCanMovePiece == true)
				{
					// this is needed for basic notation buttons use.
					Reg._moveNumberCurrentForNotation = Reg._move_number_next;
					
					Reg._move_number_next += 1;
												
					// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
					if (Reg._move_number_next >= 2)
					Reg._move_number_next = 0;
					
					Reg._playerCanMovePiece = false;
					Reg._reversiMovePiece = false;
					Reg._pieceMovedUpdateServer = true;
				}
				
				Reg._hasPieceMovedFinished = 0; // the other player must not continue moving. must reset this so the other player can begin to move piece.	
				
				//... and set all important data.
				_count = 0;
				Reg._reversiProcessAllIdsTotal = 0;
				Reg._gameMovePiece = false;	
				Reg._reversiReverseIt2 = false;
			}
			
			else if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
				// this is needed for basic notation buttons use.
				Reg._moveNumberCurrentForNotation = Reg._move_number_next;
				
				Reg._move_number_next += 1;
												
				// what player moves next. a value of 3 means its the third player. eg, Reg._gameDiceCurrentIndex[2] stores the location of the third player's piece.
				if (Reg._move_number_next >= 2)
				Reg._move_number_next = 0;
				
				if (Reg._gameHost == false) Reg._gameHost = true;
				else if (Reg._gameHost == true) Reg._gameHost = false;
				
				Reg._pieceMovedUpdateServer = true;
				Reg._playerCanMovePiece = true;
							
				_count = 0;
				Reg._reversiProcessAllIdsTotal = 0;
				Reg._reversiMovePiece = false;
				Reg._gameDidFirstMove = false;		
				Reg._gameMovePiece = false;	
				Reg._otherPlayer = false;
				
				Reg._reversiReverseIt2 = false;
			}
		
		
			for (p in 0...8)
			{
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						Reg._reversiGamePointValueForPiece[p][yy][xx] = 0;
						Reg._reversiCapturingUnitsForPieces[p][yy][xx] = 0;
						Reg._capturingUnitsForPieces[0][yy][xx] = 0;
						Reg._capturingUnitsForPieces[1][yy][xx] = 0;
					}
				}
				
			}			
			
		}
			
		

		 
		super.update(elapsed);		
	}
	
	private function displayImage(yy:Int, xx:Int):Void
	{
		if (Reg._otherPlayer == false)
		{
			if (Reg._playerMoving == 0)
			{
				loadGraphic("assets/images/reversi/1.png", false);
				Reg._gamePointValueForPiece[yy][xx] = 1;
			}
			else
			{
				loadGraphic("assets/images/reversi/11.png", false);
				Reg._gamePointValueForPiece[yy][xx] = 11;	
			}
		}
		
		else
		{
			if (Reg._playerMoving == 0)
			{
				loadGraphic("assets/images/reversi/11.png", false);
				Reg._gamePointValueForPiece[yy][xx] = 11;
			}
			else
			{
				loadGraphic("assets/images/reversi/1.png", false);
				Reg._gamePointValueForPiece[yy][xx] = 1;	
			}
		}
	}
	
	private function groupPlayer():Void
	{
		// since this unit now has an image, add it to a group. if this unit already had an image of the other player's piece then that image will be removed from its group. see below.
		if (Reg._groupPlayer1 != null && Reg._groupPlayer2 != null)
		{
			// here is a complicated loop that adds groups so that moved or jumped pieces are owned by the correct player. this code works so there is no need to understand it.
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
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
			else
			{
				if (Reg._playerMoving == 0 ) Reg._groupPlayer1.add(this);				
				else Reg._groupPlayer2.add(this);
				
			}
		}
	
		
	}
	
	
}
