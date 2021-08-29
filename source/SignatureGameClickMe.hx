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

class SignatureGameClickMe extends FlxSprite
{
	public var __number_wheel:NumberWheel;
	
	public static var _canMoveNow:Bool = false; // sometimes when clicking the number wheel, the move count will be out of sync with the number wheel index. the result will be the piece moves once but the image is highlighting 2. this var fixes that.

	/******************************
	 * used to delay selecting a value from the number wheel.
	 */	 
	private var _ticks:Float = 0;
		
	/******************************
	 * set random value for next computer turn.
	 */	 
	private var _ra:Float = 0;
	
	/******************************
	 * game message and message popups when that player wins, loses or draws.
	 */
	public var __ids_win_lose_or_draw:IDsWinLoseOrDraw;
	
	private var _playerPieces1:SignatureGameMovePlayersPiece;
	private var _playerPieces2:SignatureGameMovePlayersPiece;
	private var _playerPieces3:SignatureGameMovePlayersPiece;
	private var _playerPieces4:SignatureGameMovePlayersPiece;
	
	public function new(x:Float, y:Float, number_wheel:NumberWheel, ids_win_lose_or_draw:IDsWinLoseOrDraw,
	playerPieces1:SignatureGameMovePlayersPiece,
	playerPieces2:SignatureGameMovePlayersPiece,
	playerPieces3:SignatureGameMovePlayersPiece,
	playerPieces4:SignatureGameMovePlayersPiece)
	{
		super(x-2, y-7); // sometimes a class has these in reverse order which is ok.
		
		__ids_win_lose_or_draw = ids_win_lose_or_draw;
		
		__number_wheel = number_wheel;
		
		_canMoveNow = false;
		_ra = 0;
		
		_playerPieces1 = playerPieces1;
		_playerPieces2 = playerPieces2;
		_playerPieces3 = playerPieces3;
		_playerPieces4 = playerPieces4;
		
		loadGraphic("assets/images/clickMe.png", true, 198, 198);
		
		randomValue();	
	}
	
	override public function update(elapsed:Float):Void 
	{			
		if (Reg._gameId == 4 && Reg._gameOverForPlayer == false
		||  Reg._gameId == 4 && RegTypedef._dataPlayers._spectatorPlaying == true)
		{
			if (Reg._isThisPieceAtBackdoor == false)
			{
				__ids_win_lose_or_draw.canPlayerMove2();
			}
		
		
			// when its the computer player's turn to move, this give a random delay at clicking the number wheel.
			if (Reg._game_offline_vs_cpu == true 
			&&  Reg._move_number_current > 0
			&& __number_wheel.animation.paused == false)
			{
				_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
				if (_ticks >= _ra) _ticks = 0;
			}
			
			if (Reg._backdoorMoveValue != -1) RegFunctions.is_player_attacker(true);
					
			// move player's piece when this image is clicked
			if (Reg._game_offline_vs_cpu == true // if its the computer turn to move
			&& Reg._move_number_current > 0 
			&& _ticks == 0
			&& Reg._gameDidFirstMove == false 
			&& Reg._playerCanMovePiece == true 
			&& Reg._gameDidFirstMove == false 
			&& __number_wheel.animation.paused == false
			&& Reg._move_number_current == Reg._move_number_next			
			|| Reg._game_offline_vs_cpu == true // player's turn to move.
			&& Reg._move_number_current == 0 
			&& Reg._gameDidFirstMove == false 
			&& Reg._playerCanMovePiece == true 
			&& ActionInput.overlaps(this) 
			&& ActionInput.justPressed() == true 
			&& RegTypedef._dataMisc._spectatorWatching == false
			&& Reg._gameDidFirstMove == false 
			&& __number_wheel.animation.paused == false 
			&& Reg._move_number_current == Reg._move_number_next
			
			|| Reg._game_offline_vs_cpu == false // all players' turn.
			&& Reg._gameDidFirstMove == false
			&& Reg._playerCanMovePiece == true 
			&& ActionInput.overlaps(this) 
			&& ActionInput.justPressed() == true 
			&& RegTypedef._dataMisc._spectatorWatching == false
			&& Reg._gameDidFirstMove == false 
			&& __number_wheel.animation.paused == false 
			&& Reg._move_number_current == Reg._move_number_next
			&& Reg._at_input_keyboard == false
			
			|| Reg._triggerNextStuffToDo == 2 // update other clients.
			&& Reg._isThisPieceAtBackdoor == true 
			&& Reg._backdoorMoveValue != -1)
			{
				Reg._number_wheel_get_value = true;
				//Reg._number_wheel_ticks = 0;
				Reg._triggerNextStuffToDo = 0;
				__number_wheel.animation.pause();			
								
			}
			
			if (Reg._number_wheel_get_value == true)
			{
				if (Reg._number_wheel_ticks > 1)
				{
					Reg._number_wheel_get_value = false;
					Reg._number_wheel_ticks = 0;
					
					_canMoveNow = true;
				
					_playerPieces1.movePiece();
					_playerPieces2.movePiece();
					if (_playerPieces3 != null) _playerPieces3.movePiece();
					if (_playerPieces4 != null) _playerPieces4.movePiece();
				}
				
				if (Reg._number_wheel_ticks < 2)
					Reg._number_wheel_ticks += 1;
			}
			
			if (Reg._playerCanMovePiece == true && __number_wheel.animation.paused == false && _canMoveNow == false) 
			{			
				visible = true;
				Reg._gameDidFirstMove = false;
				
				// this is used to change the information card back to the way it was displayed when the player ended turn.
				SignatureGameInformationCards._signatureGameUnitNumberSelect[Reg._move_number_next] = Reg._gameDiceMaximumIndex[Reg._move_number_next];
			}

			if (_canMoveNow == true) shouldMoveNow();
			_canMoveNow = false;
			
		}
		
		if (visible == false && Reg._gameOverForPlayer == false) visible = true; 
		if (visible == true && Reg._gameOverForPlayer == true) visible = false;
			
		
		super.update(elapsed);
	}
	
	/******************************
	 * set random tick value for next computer turn.
	 */
	private function randomValue():Void
	{
		// set random tick value for next computer turn.
		_ra = FlxG.random.float(15, 80);
	}
	
	public function shouldMoveNow():Void
	{
		randomValue();		
		
		// backdoor. make the value of the dice equal the backdoor value.
		if (Reg._backdoorMoveValue != -1 && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._isThisPieceAtBackdoor == true && Reg._game_online_vs_cpu == false)
		{
			//Reg._move_number_next = Reg._gameXXold;
			
			Reg._gameDiceMaximumIndex[Reg._move_number_next] = Reg._backdoorMoveValue;
		}
		
		// the player using the number wheel.
		else
		{
			for (i in 0...28) // one time around the game board is 27. i in loop will stop before 28.
			{
				// if not in mortgage.
				if (SignatureGameMain._isMortgage[Reg._move_number_next][i] != -1)
				{
					SignatureGameMain._isMortgage[Reg._move_number_next][i] = SignatureGameMain._isMortgage[Reg._move_number_next][i] + __number_wheel.animation.curAnim.curIndex + 1; // this code is for mortgage.					
				}
			}
			
			if (Reg._gameXXnew == -1) Reg._gameXXnew = 0;			
			
			// add the dice value to this var, so that the var will later be used to move a piece. see SignatureGameMovePlayersPiece.hx
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false && Reg._game_online_vs_cpu == false)
			{
				Reg._move_number_next = Reg._gameXXnew;
				
				Reg._gameDiceMaximumIndex[Reg._move_number_next] = Reg._gameDiceMaximumIndex[Reg._move_number_next] + __number_wheel.animation.curAnim.curIndex + 1;
	
				// set backdoor value.
				Reg._backdoorMoveValue = Reg._gameDiceMaximumIndex[Reg._move_number_next];
				
				// send to other clients so that all client move piece at the same time.
				IDsCreateAndMain.setMovement();
				RegTriggers._signatureGame = true;
				
			}
			
			//TODO uncomment this now!!!
			else 
			{
				Reg._gameDiceMaximumIndex[Reg._move_number_next] = Reg._gameDiceMaximumIndex[Reg._move_number_next] + __number_wheel.animation.curAnim.curIndex + 1;
		
				
				// TODO delete
				//if (Reg._gameDiceMaximumIndex[Reg._move_number_next] <= 6)
				//{
					//Reg._gameDiceMaximumIndex[Reg._move_number_next] = 33;
					//Reg._gameDiceCurrentIndex[Reg._move_number_next] = 33;
				//}
				// end delete
			}
			
		}
		
		Reg._gameMovePiece = true;
		Reg._gameDidFirstMove = true;
				
		visible = false;
	}
	
}