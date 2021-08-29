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
 * ...
 * @author kboardgames.com
 */
class ChessPieceAtPath extends FlxSprite {

	/******************************
	 * location of unit.
	 */
	private var _xID:Int = 0;
	
	/******************************
	 * location of unit.
	 */
	private var _yID:Int = 0;
		
	public static function pathConditions(y:Int, x:Int, _reverse:Bool = false):Int
	{
		if (_reverse == false) RegFunctions.is_player_attacker(false); // a value of false then the player hosts a game known as the defender. true, if being hosted. eg, array[Reg._playerMoving][value][yy][xx]. playerAttacker is the opposite of the defender. so if Reg._playerMoving = 0 then its the player hosting the game while Reg._playerNotMoving which has a value of 1 had accepted the game at the chatroom.	
		else RegFunctions.is_player_attacker(true);
		
		//if (Reg._gameDidFirstMove == false) return 0; // we need a user mouse click. not an automatic function.
		
		// if the king is in check then see if another piece can take king out of check by moving to that unit.
		var _count:Int = 0;
		Reg._chessPathNumberOfKingInCheck = 0;
		
		// step in reverse order of array s.
		var s:Array<Int> = [0,1,2,3,4,5,6,7];
		var yy = s.length;
		var xx = s.length;
		
		pathNumberWithoutDefenders(); // gets the check with no defenders protecting at that path.
		_count = howManyDefendersOnCurrentPathSet(); // how many defender pieces are standing between the king and the attacker piece.
		removeHighlights(_count);
		
		return _count;
	}
		
	public static function pathNumberWithoutDefenders():Void
	{ 
		// this function is called when there is no defender between the king and the attackers piece.
		
		//############################# UP		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (--yy >= 0)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 1;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
		}
		
		//############################# UP-RIGHT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (--yy >= 0 && ++xx <= 7)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 2;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
		
		//############################# RIGHT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (++xx <= 7)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 3;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
		
		//############################# DOWN-RIGHT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (++yy <= 7 && ++xx <= 7)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 4;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
		
		//############################# DOWN		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (++yy <= 7)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 5;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
		}
		
		//############################# DOWN-LEFT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (++yy <= 7 && --xx >= 0)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 6;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
		
		//############################# LEFT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (--xx >= 0)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 7;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
		
		//############################# UP-LEFT		
		
		var _count:Int = 0;
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
	
		// king found. now search for a defender piece and if found then plus 1 to count...
		while (--yy >= 0 && --xx >= 0)
		{
			if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
			{
				_count += 1;
			}
			
			// if an attacker is found then exit this loop.
			if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
			||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
			||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
			{
				if (_count == 0) Reg._chessPathNumberOfKingInCheck = 8;	
				break;
			}
			
			else if (Reg._gamePointValueForPiece[yy][xx] != 0) break;
			
		}
	
	}
	
	
	/******************************
	 * how many defender pieces are standing between the king and the attacker piece.
	 */
	public static function howManyDefendersOnCurrentPathSet():Int
	{
		if (Reg._gameYYold == -1) return 0;
		
		// is this selected piece on a path that is not a path in check? if there is a check and this piece is already protecting a check then keep this piece still so it does not move to a place in check by creating a discovered check.
		for (i in 1...9)
		{
			if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][i][Reg._gameYYold][Reg._gameXXold] == i)
			{
				Reg._chessKeepPieceDefendingAtPath = i;
				break;
			}
		}

		var _count:Int = 0;
		var _count2:Int = 0;
		var _attackerFound:Bool = false; // if this is false then _count will be set to 0 since there is no attacker piece found.
		
		for (i in 0...2)
		{
			for (qy in 0...8)
			{
				for (qx in 0...8)
				{
					Reg._chessFuturePathToKing[i][qy][qx] = 0;
				}
			}
		}
		
		//############################# UP		
		
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
				
		if (Reg._gameDidFirstMove == false && Reg._gameHost == true
		||  Reg._chessKeepPieceDefendingAtPath == 1)
		{
			_count = 0; // how many defenders are on path.
			_count2 = 0; // how many attackers are on path.
			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];			
			
			Reg._chessTotalDefendersOnPath[1] = 0;
				
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (--yy >= 0)
			{
				Reg._chessPathCoordinates[1][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1)
							{
								_piece_found_at_coordinates_yy = yy;
							}
							
							// a capturing path of king can be unit highlighted without any defenders on it yet we cannot use a value of zero or else all paths would be highlighted regardless of if an attacker was on it or not. so we plus 1 here and then use > 0 in the code where needed.
							Reg._chessTotalDefendersOnPath[1] = _count + 1;
						}
						
						// break loop because other colored piece found and we do not need to go any farther. if this break happens before a same colored piece is found then we can move an attacker to this path.
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn. if here then player needs to first move piece. This code is therefore not to highlight units that could be in jeopardy for beginner but instead this code is used to keep defender on path if king is being attacked and defender. it two defenders are on path then defender can move away from path. so the _count var refers to how many defenders are on path.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					// attacker is found and since no defenders are on path there is a check against the king.
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 1;									
					_attackerFound = true;				
					break;
				}
			}			
						
		}
		
		// search for future places that could place king in check or checkmate.
		// this code is for the beginner. it highlight units that could be in jeopardy if an attack piece moves to this path.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{				
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
			
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true
			)
			{
				while (--yy >= 0)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessRook[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
									
								}
							}
				
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
									
								}
							}
							
							if (_found == true)
							{
								var yy3 = yy2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (yy3 > yy)
								{
									yy3 -= 1;
									if (Reg._gamePointValueForPiece[yy3][xx] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 > yy)
								{
									yy2 -= 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
							
		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (--yy >= 0)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//############################# UP-RIGHT		
				
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
		var _piece_found_at_coordinates_xx = -1;
			
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 2)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			Reg._chessTotalDefendersOnPath[2] = 0;
										
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (--yy >= 0 && ++xx <= 7)
			{			
				Reg._chessPathCoordinates[2][yy][xx] = 1;
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1) 
							{
								_piece_found_at_coordinates_xx = xx;
								_piece_found_at_coordinates_yy = yy;
							}
							
							Reg._chessTotalDefendersOnPath[2] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 2;	
					
					_attackerFound = true;
					break;
				}
			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
			
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (--yy >= 0 && ++xx <= 7)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessBishop[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{										 
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{										 
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								var yy3 = yy2;
								var xx3 = xx2;
								
								while (yy3 > yy && xx3 < xx)
								{
									yy3 -= 1; xx3 += 1;
									if (Reg._gamePointValueForPiece[yy3][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 > yy && xx2 < xx)
								{
									yy2 -= 1; xx2 += 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx2] = 1;			
								}
								
								_found = false;
							}
							
						}
					}
				}
			}
		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (--yy >= 0 && ++xx <= 7)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//############################# RIGHT		
			
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_xx = -1;
		
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 3)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			Reg._chessTotalDefendersOnPath[3] = 0;
			
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (++xx <= 7)
			{			
				Reg._chessPathCoordinates[3][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1) 
							{ 
								_piece_found_at_coordinates_xx = xx;				
							}
							
							Reg._chessTotalDefendersOnPath[3] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 3;	
					
					_attackerFound = true;
					break;
				}
			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
			
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (++xx <= 7)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessRook[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var xx3 = xx2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (xx3 < xx)
								{
									xx3 += 1;
									if (Reg._gamePointValueForPiece[yy][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (xx2 < xx)
								{
									xx2 += 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy][xx2] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			

		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (++xx <= 7)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;		
			}
		}
		
		//############################# DOWN-RIGHT		
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
		var _piece_found_at_coordinates_xx = -1;
			
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 4)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];			
			
			Reg._chessTotalDefendersOnPath[4] = 0;
						
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (++yy <= 7 && ++xx <= 7)
			{			
				Reg._chessPathCoordinates[4][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1) 
							{
								_piece_found_at_coordinates_xx = xx;
								_piece_found_at_coordinates_yy = yy;
							}
							
							Reg._chessTotalDefendersOnPath[4] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
					if (Reg._playerMoving == 1)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count += 1;
							if (_count == 1) 
							{
								_piece_found_at_coordinates_xx = xx;
								_piece_found_at_coordinates_yy = yy;
							}
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count2 += 1;
						}
					}
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 4;	
					
					_attackerFound = true;
					break;
				}
			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
				
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (++yy <= 7 && ++xx <= 7)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{	
									if (Reg._chessBishop[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{	
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx > xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var yy3 = yy2;
								var xx3 = xx2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (yy3 < yy && xx3 < xx)
								{
									yy3 += 1; xx3 += 1;
									if (Reg._gamePointValueForPiece[yy3][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 < yy && xx2 < xx)
								{
									yy2 += 1; xx2 += 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx2] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			

		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (++yy <= 7 && ++xx <= 7)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//############################# DOWN		
				
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
		
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 5)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];

			Reg._chessTotalDefendersOnPath[5] = 0;
						
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (++yy <= 7)
			{			
				Reg._chessPathCoordinates[5][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1)
							{
								_piece_found_at_coordinates_yy = yy;
							}
							
							Reg._chessTotalDefendersOnPath[5] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 5;	
					
					_attackerFound = true;
					break;
				}
			}			
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
				
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (++yy <= 7)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessRook[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if ( Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var yy3 = yy2;
													
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (yy3 < yy)
								{
									yy3 += 1;
									if (Reg._gamePointValueForPiece[yy3][xx] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 < yy)
								{
									yy2 += 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			
		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (++yy <= 7)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}

		//############################# DOWN-LEFT		
				
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
		var _piece_found_at_coordinates_xx = -1;
			
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 6)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];			
			
			Reg._chessTotalDefendersOnPath[6] = 0;
			
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (++yy <= 7 && --xx >= 0)
			{			
				Reg._chessPathCoordinates[6][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1) 
							{
								_piece_found_at_coordinates_xx = xx;
								_piece_found_at_coordinates_yy = yy;
							}
							
							Reg._chessTotalDefendersOnPath[6] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 6;	
					
					_attackerFound = true;
					break;
				}
			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
				
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (++yy <= 7 && --xx >= 0)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessBishop[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy > yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var yy3 = yy2;
								var xx3 = xx2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (yy3 < yy && xx3 > xx)
								{
									yy3 += 1; xx3 -= 1;
									if (Reg._gamePointValueForPiece[yy3][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 < yy && xx2 > xx)
								{
									yy2 += 1; xx2 -= 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx2] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			

		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (++yy <= 7 && --xx >= 0)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//############################# LEFT		
				
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_xx = -1;
		
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 7)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];			
			
			Reg._chessTotalDefendersOnPath[7] = 0;
			
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (--xx >= 0)
			{			
				Reg._chessPathCoordinates[7][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1)
							{
								_piece_found_at_coordinates_xx = xx;
							}
							
							Reg._chessTotalDefendersOnPath[7] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 14
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 4 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 7;	
					
					_attackerFound = true;
					break;
				}

			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
				
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (--xx >= 0)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessRook[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessRook[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var xx3 = xx2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (xx3 > xx)
								{
									xx3 -= 1;
									if (Reg._gamePointValueForPiece[yy][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (xx2 > xx)
								{
									xx2 -= 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy][xx2] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			

		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (--xx >= 0)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//############################# UP-LEFT		
				
		// this is used to display the beginner help units. if a same colored piece is found then the opposite colored piece will use this var to determine if it can still move to the path.
		var _piece_found_at_coordinates_yy = -1;
		var _piece_found_at_coordinates_xx = -1;
			
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath == 8)
		{
			_count = 0;
			_count2 = 0;
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];			
			
			Reg._chessTotalDefendersOnPath[8] = 0;
			
			// king found. now search for a defender piece and if found then plus 1 to count...
			while (--yy >= 0 && --xx >= 0)
			{			
				Reg._chessPathCoordinates[8][yy][xx] = 1;
				
				if (Reg._gameDidFirstMove == false)
				{
					// find same colored pieces
					if (Reg._playerMoving == 0)
					{
						if (Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
						{
							_count += 1;
							if (_count == 1) 
							{
								_piece_found_at_coordinates_xx = xx;
								_piece_found_at_coordinates_yy = yy;
							}
							
							Reg._chessTotalDefendersOnPath[8] = _count + 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] > 10)
						{
							_count2 += 1;
						}
					}
					
				}
				
				// the value of Reg._playerMoving needs to be in reverse if at the beginning of the player's move turn.
				else
				{
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] >= 11
					||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11)
					{
						_count += 1;
					}
				}
				
				// if an attacker is found then exit this loop.
				if (Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 12
				||  Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] == 15
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 2 
				||  Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] == 5)
				{
					if (_count == 0) Reg._chessPathNumberOfKingInCheck = 8;	
					
					_attackerFound = true;
					break;
				}
			}
		}
		
		// search for future places that could place king in check or checkmate.
		if (Reg._playerMoving == 1 && Reg._game_offline_vs_cpu == true 
		||  Reg._playerMoving == 1 && Reg._game_online_vs_cpu == true) {}
		else
		{			
			var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
			var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
			
			var yy2 = yy;
			var xx2 = xx;
				
			// found the future capturing piece on the path.
			var _found = false;
			
			if (Reg._gameHost == true)
			{
				while (--yy >= 0 && --xx >= 0)
				{
					for (i in 0...10) // all possible instances.
					{
						if (Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
						||  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
						)
						{
							// get the 17 value location of the piece that can put the king in check or checkmate.
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessBishop[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessBishop[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							for (cy in 0...8)
							{
								for (cx in 0...8)
								{
									if (Reg._chessQueen[Reg._playerNotMoving][i][cy][cx] == 17
									&&  Reg._chessQueen[Reg._playerNotMoving][i][yy][xx] == 1
									&&  Reg._gamePointValueForPiece[yy][xx] < 11
									)
									{
										if (Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy != -1
										&&  _piece_found_at_coordinates_yy < yy
										&&  _piece_found_at_coordinates_xx != -1
										&&  _piece_found_at_coordinates_xx < xx
										&&  _count2 == 0
										||  Reg._gamePointValueForPiece[yy][xx] > 0
										&&  _piece_found_at_coordinates_yy == yy
										&&  _piece_found_at_coordinates_xx == xx
										||  Reg._gamePointValueForPiece[yy][xx] == 0
										&&  _piece_found_at_coordinates_yy == -1
										&&  _piece_found_at_coordinates_xx == -1
										)
										{
											_found = true;
											Reg._chessFuturePathToKing[Reg._playerNotMoving][cy][cx] = 1;
											break;
										}
									}
								}
							}
							
							if (_found == true)
							{
								var yy3 = yy2;
								var xx3 = xx2;
								
								// check if there is another attacking piece. if there is then the future capturing path should not be set.
								while (yy3 > yy && xx3 > xx)
								{
									yy3 -= 1; xx3 -= 1;
									if (Reg._gamePointValueForPiece[yy3][xx3] > 10)
									{
										_found = false;
									}
								}
							}
							
							if (_found == true)
							{
								while (yy2 > yy && xx2 > xx)
								{
									yy2 -= 1; xx2 -= 1;
									Reg._chessFuturePathToKing[Reg._playerNotMoving][yy2][xx2] = 1;			
								}
								
								_found = false;
							}
						}
					}
				}
			}
			

		}
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
		
		while (--yy >= 0 && --xx >= 0)
		{
			if (_count > 0)
			{
				if (Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] > 0) Reg._capturingUnitsForPieces[Reg._playerNotMoving][yy][xx] -= 1;
			}
		}
		
		//-------------------------------
		
		var yy = Reg._chessKingYcoordinate[Reg._playerMoving];
		var xx = Reg._chessKingXcoordinate[Reg._playerMoving];
						
		// fix count total.
		if (_attackerFound == false) _count = 0;
		
		return _count;
	}	
	

	public static function removeHighlights(_count:Int):Void
	{
		//############################# IN CHECK - 1 DEFENDER - STAY AT PATH.
		
		if (Reg._chessKeepPieceDefendingAtPath != Reg._chessPathNumberOfKingInCheck && Reg._chessKeepPieceDefendingAtPath > 0 && Reg._chessPathNumberOfKingInCheck > 0 && _count == 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
					Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
				}
			}
		}
		
		//############################# IN CHECK - 2 OR MORE DEFENDERS - MOVE TO CHECK PATH.
				
		if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath != Reg._chessPathNumberOfKingInCheck && Reg._chessKeepPieceDefendingAtPath > 0 && Reg._chessPathNumberOfKingInCheck > 0 && _count > 0)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					if (Reg._chessPathCoordinates[Reg._chessKeepPieceDefendingAtPath][yy][xx] == 1)
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
						Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
					}
				}
			}
		}

		//#############################
		// NOT IN CHECK - 1 DEFENDER - STAY AT PATH.
		
		else if (Reg._gameDidFirstMove == false || Reg._chessKeepPieceDefendingAtPath > 0 && Reg._chessPathNumberOfKingInCheck == 0 && _count == 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					if (Reg._chessPathCoordinates[Reg._chessKeepPieceDefendingAtPath][yy][xx] != Reg._chessPathCoordinates[Reg._chessKeepPieceDefendingAtPath][Reg._gameYYold][Reg._gameXXold])
					{
						// this stops the a bug from happening if no block of code below existed.
						if (Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] == 0 && Reg._chessIsKingMoving == false)
						{
							Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
							Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
						}
						
						// this stops the above block of code from displaying a bug.
						else if (Reg._chessIsThisUnitInCheck[Reg._playerMoving][yy][xx] > 0 && Reg._chessIsKingMoving == true)
						{
							Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
							Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
						}
						
					}					
				}
			}
		}
		
		//############################# IN CHECK - DEFENDER NOT AT PATH.
		
		if (Reg._chessPathNumberOfKingInCheck > 0 && _count != 1)
		{
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{	
					if (Reg._chessCurrentPathToKing[Reg._playerNotMoving][Reg._chessPathNumberOfKingInCheck][Reg._gameYYold][Reg._gameXXold] != Reg._chessPathNumberOfKingInCheck 
					&&  Reg._chessCurrentPathToKing[Reg._playerNotMoving][Reg._chessPathNumberOfKingInCheck][yy][xx] != Reg._chessPathNumberOfKingInCheck
					&& _count != 1
					)
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
						Reg._capturingUnitsForImages[Reg._playerMoving][yy][xx] = 0;
						Reg._chessCapturingPathToKing[Reg._playerNotMoving][yy][xx] = 0;
					}
				}
			}
		}
		
		Reg._gameDidFirstMove = true;
	}
}
