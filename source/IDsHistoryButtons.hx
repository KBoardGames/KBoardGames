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
class IDsHistoryButtons extends FlxSprite {

	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	/*****************************
	 * 
	 */
	public static var _history_moving_forward:Bool = false;
	
	/*****************************
	 * when this is true, a function will be called. that function will forward the history to the very end.
	 */	
	public static var _triggerFastForward:Bool = false; 
	
	private static var _triggerRewind:Bool = false;
	
	// used to delay the display of this move history. this is needed for spectator watching. this stops a quick display then hide of these history buttons because the spectator might not be waiting in the game room for the game to be played. instead, the game might be in progress and therefore these buttons need to stay hidden. a few ticks at this update() function is all that is needed until the game can finish a event such as the "Spectator Watching" event that triggers the start of the game for spectator. 
	private var _ticks:Int = 0;
	
	public function new (y:Float, x:Float, id:Int)
	{
		super(y, x);		
			
		_ticks = 0;
		visible = false;
		_id = id;
		
		_history_moving_forward = false;
		_triggerFastForward = false;
		_triggerRewind = false;
		
		if (id == 1 || id == 4) loadGraphic("assets/images/1.png", true);
		else loadGraphic("assets/images/2.png", true);
	
		options();
	}
	
	override public function update (elapsed:Float)
	{
		if (visible == true
		|| RegTypedef._dataMisc._spectatorWatching == true)
		{
			if (Reg._gameId <= 1 && Reg._gameOverForPlayer == true
			||  Reg._gameId <= 1 && RegTypedef._dataMisc._spectatorWatching == true)
			{
				if (ActionInput.overlaps(this, null))
				{
					if (_id == 1) animation.add("hover", [1], 1, true, false);
					if (_id == 2) animation.add("hover", [1], 1, true, false);
					if (_id == 3) animation.add("hover", [1], 1, true, true);
					if (_id == 4) animation.add("hover", [1], 1, true, true);
					
					animation.play("hover", false);
					
					if (ActionInput.justPressed() == true)
					{
						if (_id == 1)
						{
							if (_triggerRewind == false) _triggerRewind = true;
							else _triggerRewind = false;
						}
						if (_id == 2) historyBackward();
						if (_id == 3) historyForward();
						if (_id == 4) 
						{
							if (_triggerFastForward == false) _triggerFastForward = true;
							else  _triggerFastForward = false;
						}
						
						options();
					}
					
					
				}			
				
				else options();
			}
		}
	
		if (visible == true && Reg._gameOverForPlayer == false) 
		{
			_ticks = 0;
			visible = false; 
		}
		
		if (visible == false && Reg._gameOverForPlayer == true
		&&  _ticks >= 5) 
		{
			visible = true;
		}
		
		if (_ticks >= 10) _ticks = 9;
		
		_ticks += 1;
		
		// start the loop for either fast forward or rewind. 
		if (visible == true || RegTypedef._dataPlayers._spectatorWatching == true)
		{
			if (Reg._gameOverForPlayer == true
			||  Reg._gameOverForPlayer == false
			&&  RegTypedef._dataMovement._history_get_all == 2)
			{
				if (_triggerFastForward == true 
				&&   Reg._step < Reg._moveHistoryPieceLocationOld1.length
				||   Reg._gameOverForPlayer == false
				&&   RegTypedef._dataMovement._history_get_all == 2
				)
				{
					historyFastForward();
				}
				
				else if (_triggerRewind == true && Reg._step > 0)
				{
					RegTypedef._dataMovement._moveHistoryTotalCount = 0;
					historyRewind();
				}
				
				else 
				{
					_triggerFastForward = false;
					_triggerRewind = false;
				}
			}
			
			// when _triggerFastForward or historyRewind is true then this is automatic. historyRewind is set to true as soon as a spectator watching enters the game room and a game is being played.
			if (RegTypedef._dataPlayers._spectatorWatching == true
			&&  RegTypedef._dataTournaments._move_piece == false
			&&  Reg._gameOverForPlayer == false
			&&  RegTypedef._dataMovement._history_get_all != 2)
			{
				// this code will always fast forward to the most current move for spectator watching but after playing history is rewind.
				if (_triggerFastForward == true 
				//&&   Reg._step < Reg._moveHistoryPieceLocationOld1.length 
				&&   RegTypedef._dataMovement._moveHistoryTotalCount == -1
				&&   RegTriggers._historyFastForwardSpectatorWatching == true) 
					historyFastForward();
				
				// for spectator watching, when first entered the game room and game is playing, and a player then did a move, this code will rewind that move then set vars so what a fast forward of move history can be done.
				if (_triggerRewind == true && Reg._step > 0
				&&  RegTypedef._dataMovement._moveHistoryTotalCount > -1
				&&  RegTriggers._historyFastForwardSpectatorWatching == false)
				{				
					historyRewind();
				
					RegTriggers._historyFastForwardSpectatorWatching = true;
					RegTypedef._dataMovement._moveHistoryTotalCount = -1;
					Reg._step = 0;
				}
				else _triggerRewind = false;
			}
			
			
		}
		
		// fast forwards the history for the spectator but only when game is not over.
		if (Reg._gameOverForPlayer == false 
		&&  RegTypedef._dataPlayers._spectatorWatching == true 
		&&  RegTypedef._dataTournaments._move_piece == false
		||  Reg._gameOverForPlayer == false 
		&&  RegTypedef._dataPlayers._spectatorWatching == true 
		&&  RegTypedef._dataTournaments._move_piece == true
		) 
		{
			_triggerFastForward = true;
			historyFastForward();
			
			// we need this block of code here and again at the bottom of this function.
			if (Reg._gameDidFirstMove == false && Reg._moveHistoryPieceLocationNew1.length > 0)
			{
				Reg._gameYYnewB = RegFunctions.getPfindYY2(Reg._moveHistoryPieceLocationNew1[Reg._moveHistoryPieceLocationNew1.length - 1]);
				Reg._gameXXnewB = RegFunctions.getPfindXX2(Reg._moveHistoryPieceLocationNew1[Reg._moveHistoryPieceLocationNew1.length - 1]);
			}
			
		}
				
		super.update(elapsed);
		
	}
	
	
	public static function historyFastForward():Void
	{
		_history_moving_forward = true;
		
		if (Reg._gameId == 0)
		{
			if (CheckersMovePlayersPiece._triggerMovePiece1a == false
			&&  CheckersMovePlayersPiece._triggerMovePiece1b == false
			&&  CheckersMovePlayersPiece._triggerMovePiece2a == false)
			{
				if (Reg._step < Reg._moveHistoryPieceLocationOld1.length) 
				{
					Reg._step += 1;
					CheckersMovePlayersPiece.historyMovePieceForwards();
				}
				
				// tournament is now over for this player. we place the code here so that the history is shown when entering the room from the preview button.
				else if (RegTypedef._dataTournaments._game_over == 1)
				{
					Reg._gameOverForAllPlayers = true;
					Reg._gameOverForPlayer = true;
				}
			}
		}
		
		if (Reg._gameId == 1)
		{
			if (ChessMovePlayersPiece._triggerMovePiece1a == false
			&&  ChessMovePlayersPiece._triggerMovePiece1b == false
			&&  ChessMovePlayersPiece._triggerMovePiece2a == false
			&&  ChessMovePlayersPiece._triggerMovePiece2b == false)
			{
				if (Reg._step < Reg._moveHistoryPieceLocationOld1.length) 
				{
					Reg._step += 1;
					ChessMovePlayersPiece.historyMovePieceForwards();
				}
				
				// tournament is now over for this player. we place the code here so that the history is shown when entering the room from the preview button.
				else if (RegTypedef._dataTournaments._game_over == 1)
				{
					Reg._gameOverForAllPlayers = true;
					Reg._gameOverForPlayer = true;
				}
			}
		}
		
	}
		
	private function historyForward():Void
	{
		_history_moving_forward = true;
		
		if (Reg._gameId == 0)
		{
			if (Reg._step == 0) Reg._step;
			
			if (Reg._step < Reg._moveHistoryPieceLocationOld1.length) 
			{
				Reg._step += 1;
				CheckersMovePlayersPiece.historyMovePieceForwards();
			}
		}
		
		if (Reg._gameId == 1)
		{
			if (Reg._step < Reg._moveHistoryPieceLocationOld1.length) 
			{
				Reg._step += 1;
				ChessMovePlayersPiece.historyMovePieceForwards();	
			}
		}
	}

	public static function historyBackward():Void
	{
		_history_moving_forward = false;
		
		if (Reg._gameId == 0)
		{
			if (Reg._step > 0 )
			{
				Reg._step -= 1;
				CheckersMovePlayersPiece.historyMovePieceBackwards();
			}
		}
		
		if (Reg._gameId == 1)
		{
			if (Reg._step > 0 ) 
			{
				Reg._step -= 1;
				ChessMovePlayersPiece.historyMovePieceBackwards();
			}
		}
	}
	
	private function historyRewind():Void
	{
		_history_moving_forward = false;
		
		if (Reg._gameId == 0)
		{
			if (CheckersMovePlayersPiece._triggerMovePiece1a == false
			&&  CheckersMovePlayersPiece._triggerMovePiece1b == false
			&&  CheckersMovePlayersPiece._triggerMovePiece2a == false)
			{
				if (Reg._step > 0 )
				{
					Reg._step -= 1;
					CheckersMovePlayersPiece.historyMovePieceBackwards();
				}
				
				
			}
		}
		
		if (Reg._gameId == 1)
		{
			if (ChessMovePlayersPiece._triggerMovePiece1a == false
			&&  ChessMovePlayersPiece._triggerMovePiece1b == false
			&&  ChessMovePlayersPiece._triggerMovePiece2a == false
			&&  ChessMovePlayersPiece._triggerMovePiece2b == false)
			{
				if (Reg._step > 0 ) 
				{
					Reg._step -= 1;
					ChessMovePlayersPiece.historyMovePieceBackwards();
				}
			}
		}
	}
	
	private function options():Void
	{
		if (_id == 1) animation.add("default", [0,0,0], 1, true, false);
		if (_id == 2) animation.add("default", [0,0,0], 1, true, false);
		if (_id == 3) animation.add("default", [0,0,0], 1, true, true);
		if (_id == 4) animation.add("default", [0,0,0], 1, true, true);
		
		animation.play("default", false);
	}
}
