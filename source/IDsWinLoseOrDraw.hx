/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if checkers
	import modules.games.checkers.*;
#end

#if chess
	import modules.games.chess.*;
#end

/**
 * functions to determine if game is over.
 * @author kboardgames.com
 */

class IDsWinLoseOrDraw extends FlxState 
{
	private var _doOnce:Bool = false;
	
	/******************************
	 * AFTER A MOVE IS MADE. function called from or near an event. outside of game filenames such as CheckersCapturingUnits.
	 */
	public function canPlayerMove1():Void 
	{
		if (Reg._createGameRoom == true) return;
		
		
		if (Reg._gameHost == false) Reg._playerMoving = 1;
		else Reg._playerMoving = 0;
		
		// checkers. search for no places to move and no places to jump.
		#if checkers
			if (Reg._gameId == 0)
			{
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// search for capturing units.
						CheckersCapturingUnits.capturingUnitsForPiece(yy, xx, Reg._playerMoving);
						CheckersCapturingUnits.jumpCapturingUnitsForPiece(yy, xx, Reg._playerMoving);
							
					}
				}
				
				// using not equal for both vars will not work when comparing two or more var. not sure why that is. you need to trap the vars with {}.
				if (Reg._gameYYnew2 == -1 && Reg._gameXXnew2 == -1) {}
				else
				{
					Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = 0;
					Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = 0;
				}
				
				// by default, a capturing units is not found for checkers.
				var _found:Bool = false;
				var _count:Int = 0;
				
				// loop thru the game board, every unit...
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// searching if this array refers to a capturing unit.
						if (Reg._gamePointValueForPiece[yy][xx] == 1
						&&  Reg._playerMoving == 0
						||  Reg._gamePointValueForPiece[yy][xx] == 11
						&&  Reg._playerMoving == 1
						||  Reg._gamePointValueForPiece[yy][xx] == 2
						&&  Reg._playerMoving == 0
						||  Reg._gamePointValueForPiece[yy][xx] == 12
						&&  Reg._playerMoving == 1
						)
						{
							_found = true;
						}
					}
				}
				
				// clear vars that were used to find capturing units.
				Reg._checkersFoundPieceToJumpOver = false;
				
				// clear the var.
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;
					}
				}
				
				// determine if user cannot move. if _found = false then player cannot move. send message to everyone, letting them know this.
				if (_found == false)
				{
					Reg._gameMessage = RegTypedef._dataPlayers._usernamesDynamic[Reg._move_number_next];
					
					Reg._gameMessage += " cannot move.";
					RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
					
					if (Reg._game_offline_vs_cpu == false 
					&&  Reg._game_offline_vs_player == false 
					&& RegTypedef._dataTournaments._move_piece == false) 
					{
						PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);
						
						if (RegTypedef._dataPlayers._spectatorWatching == false)
						{
							RegTypedef._dataPlayers._gameMessage = "You lose.";
							PlayState.send("Game Lose Then Win For Other", RegTypedef._dataPlayers);		
						}
						
						RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						PlayState.send("Game Players Values", RegTypedef._dataPlayers);						
						
						RegTypedef._dataGameMessage._gameMessage = "";
						RegTypedef._dataPlayers._gameMessage = "";
						
					}
						
					if (Reg._game_offline_vs_cpu == true 
					||  Reg._game_offline_vs_player == true
					||  RegTypedef._dataTournaments._move_piece == true)
					{
						if (Reg._playerMoving == 1)
						{
							RegTriggers._messageWin = "You win.";
							RegTriggers._win = true;
							RegTypedef._dataTournaments._game_over = 1;
							RegTypedef._dataTournaments._won_game = 1;
						}
						
						else 
						{
							RegTriggers._messageLoss = "You lose.";
							RegTriggers._loss = true;
						}
					}
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					Reg._outputMessage = true;
					Reg._playerCanMovePiece = false;
				}
			}
		#end
		
		#if chess
			if (Reg._gameId == 1)
			{
				//if (Reg._game_offline_vs_cpu == true && Reg._playerMoving == 1) return; // we do not want to go to canPlayerMove1 when it is computer's turn to move because that will enable the stalemate var and stop pawn protecting a piece from working. the result is when computer is moving, the other players pawn will not protect a piece in an angle. uncommented, king cannot move when in check sometimes.
				
				for (qy in 0...8)
				{
					for (qx in 0...8)
					{
						Reg._capturingUnitsForImages[Reg._playerMoving][qy][qx] = 0;
						Reg._capturingUnitsForPieces[Reg._playerMoving][qy][qx] = 0;
					}				
				}
			
				Reg._chessStalemateBypassCheck = true;
				ChessCapturingUnits.capturingUnits();
				Reg._chessStalemateBypassCheck = false;
		
				Reg._chessStalemate = true;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// can player move piece...
						if ( Reg._playerMoving == 0 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 &&Reg._gamePointValueForPiece[yy][xx] > 10 
						 || Reg._playerMoving == 1 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 11 
						 || Reg._playerMoving == 0 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 && Reg._gameUniqueValueForPiece[yy][xx] == 0
						 || Reg._playerMoving == 1 && Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] > 0 && Reg._gameUniqueValueForPiece[yy][xx] == 0)
						{
							Reg._chessStalemate = false;
						}
					}
				}
					
				// if count = 0 then there is no moves for that player.
				if (Reg._chessStalemate == true && Reg._gameMessage == "")
				{
					Reg._gameMessage = "Draw. Stalemate.";
					RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
					
					// send message to server then server to other client.
					if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
					{
						if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
						{
							PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);			
						}
						
						RegTypedef._dataPlayers._gameMessage = "Game ended in a draw.";
						PlayState.send("Game Draw", RegTypedef._dataPlayers);						
						
						RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						PlayState.send("Game Players Values", RegTypedef._dataPlayers); 					
							
						RegTypedef._dataGameMessage._gameMessage = "";	
						RegTypedef._dataPlayers._gameMessage = "";
						
					}
					
					else
					{
						RegTriggers._messageDraw = "Game ended in a draw.";
						RegTriggers._draw = true;
					}
					
					Reg._outputMessage = true;
					Reg._playerCanMovePiece = false; // highlighted units are no longer active.
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					RegFunctions.playerAllStop();
									
					Reg._chessStalemate = false;
				}
			
			}
			
			if (Reg._gameId == 1)
			{
				// for a checkmate both parties must have not enough pieces on board  for the below message to trigger.
				
				// by default we set draw to true for both players. then we search to determine if there are enough piece, such a pawn or 3 horses, that are enough to checkmate a king. if there is enough pieces that set draw for that player to false. if both players do not have enough pieces to checkmate then the game will end in a draw.
				
				// these are needed to checkmate a king, 1 pawn, 1 queen. 1 rook. 3 horses. 1 bishop + 1 horse. 2 bishops on different coloured units. 
				
				//-1 PAWN------------------------------------------
			
				var _whitePawnDraw:Bool = true;
				var _blackPawnDraw:Bool = true;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found a pawn then no draw. 1 pawn can promote to queen and a queen plus a king can checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 1) _whitePawnDraw = false;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 11) _blackPawnDraw = false;
					}
				}
				
				//-1 QUEEN-----------------------------------
				
				var _whiteQueenDraw:Bool = true;
				var _blackQueenDraw:Bool = true;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found a queen then no draw. a queen plus king can checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 5) _whiteQueenDraw = false;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 15) _blackQueenDraw = false;
					}
				}
				
				//-1 ROOK-----------------------------------
				
				var _whiteRookDraw:Bool = true;
				var _blackRookDraw:Bool = true;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found a rook then no draw. a rook plus king can checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 4) _whiteRookDraw = false;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 14) _blackRookDraw = false;
					}
				}
				
				
				//-3 HORSE-----------------------------------
				
				var _whiteHorseDraw:Bool = true;
				var _blackHorseDraw:Bool = true;
				
				var _whiteHorseTotal:Int = 0;
				var _blackHorseTotal:Int = 0;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found three horses then no draw. In the unlikely event that a pawn is promoted to a knight, then three knights and its king can work together to checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 3) _whiteHorseTotal += 1;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 13) _blackHorseTotal += 1;
					}
				}
				
				if (_whiteHorseTotal == 3) _whiteHorseDraw = false;
				if (_blackHorseTotal == 3) _blackHorseDraw = false;
				
				//-1 BISHOP, 1 HORSE-----------------------------------
				
				var _whiteBishopHorseDraw:Bool = true;
				var _blackBishopHorseDraw:Bool = true;
				
				var _found1a:Bool = false;
				var _found1b:Bool = false;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found a queen then no draw. a queen plus king can checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 2) _found1a = true;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 12) _found1b = true;
					}
				}
				
				var _found2a:Bool = false;
				var _found2b:Bool = false;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found a queen then no draw. a queen plus king can checkmate a lone king.
						if (Reg._gamePointValueForPiece[yy][xx] == 3) _found2a = true;
						
						if (Reg._gamePointValueForPiece[yy][xx] == 13) _found2b = true;
					}
				}
				
				if (_found1a == true && _found2a == true) _whiteBishopHorseDraw = false;
				if (_found1b == true && _found2b == true) _blackBishopHorseDraw = false;

				
				//-2 BISHOPS, ALTERNATING UNIT COLORS----------------
				
				var _whiteBishopsDraw:Bool = true;
				var _blackBishopsDraw:Bool = true;
				
				var _whiteBishopTotal:Int = 0;
				var _blackBishopTotal:Int = 0;
				
				var _whiteBishopUnitYYandXXtotal:Array<Int> = [];
				var _blackBishopUnitYYandXXtotal:Array<Int> = [];
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// if found two bishop on alternating unit colors then no draw.
						if (Reg._gamePointValueForPiece[yy][xx] == 2)
						{
							// at start of game, one bishop will be on a light colored unit while the other on a dark unit. no matter where a bishop moves, it will land on either a even or odd unit. this is determined by adding yy plus xx.
							_whiteBishopUnitYYandXXtotal.push(0);
							_whiteBishopUnitYYandXXtotal[_whiteBishopUnitYYandXXtotal.length -1] = yy + xx;
							_whiteBishopTotal += 1;
						}
						
						if (Reg._gamePointValueForPiece[yy][xx] == 12)
						{
							_blackBishopUnitYYandXXtotal.push(0);
							_blackBishopUnitYYandXXtotal[_blackBishopUnitYYandXXtotal.length - 1] = yy + xx;
							_blackBishopTotal += 1;
						}
					}
				}
				
				if (_whiteBishopTotal == 2) 
				{
					var _found1:Bool = false;
					
					for (i in 0..._whiteBishopUnitYYandXXtotal.length)
					{
						// is this an odd unit bishop.
						if (FlxMath.isOdd(_whiteBishopUnitYYandXXtotal[i]) == true)
						_found1 = true;
					}
					
					var _found2:Bool = false;
					
					for (i in 0..._whiteBishopUnitYYandXXtotal.length)
					{
						if (FlxMath.isEven(_whiteBishopUnitYYandXXtotal[i]) == true)
						_found2 = true;
					}
					
					// if player has both an odd and even bishop then draw is false.
					if (_found1 == true && _found2 == true) _whiteBishopsDraw = false;
				}
				
				if (_blackBishopTotal == 2) 
				{
					var _found1:Bool = false;
					
					for (i in 0..._blackBishopUnitYYandXXtotal.length)
					{
						// is this an odd unit bishop.
						if (FlxMath.isOdd(_blackBishopUnitYYandXXtotal[i]) == true)
						_found1 = true;
					}
					
					var _found2:Bool = false;
					
					for (i in 0..._blackBishopUnitYYandXXtotal.length)
					{
						if (FlxMath.isEven(_blackBishopUnitYYandXXtotal[i]) == true)
						_found2 = true;
					}
					
					// if player has both an odd and even bishop then draw is false.
					if (_found1 == true && _found2 == true) _blackBishopsDraw = false;
				}
				
				_whiteBishopUnitYYandXXtotal.splice(0, _whiteBishopUnitYYandXXtotal.length);
				_blackBishopUnitYYandXXtotal.splice(0, _blackBishopUnitYYandXXtotal.length);
				
			
				if (_whitePawnDraw == true && _whiteQueenDraw == true && _whiteRookDraw == true && _whiteHorseDraw == true && _whiteBishopHorseDraw == true && _whiteBishopsDraw == true && 
				   _blackPawnDraw == true && _blackQueenDraw == true && _blackRookDraw == true && _blackHorseDraw == true && _blackBishopHorseDraw == true && _blackBishopsDraw == true )
				{
					// if here then there is not enough pieces on board for a checkmate. display the game over message to both players.
					Reg._gameMessage = "Draw. Insufficient material";
					RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
					
					// send message to server then server to other client.
					if (Reg._game_online_vs_cpu == true || Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
					{
						if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
						{
							PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);			
						}
						
						RegTypedef._dataPlayers._gameMessage = "Draw. Insufficient material";
						PlayState.send("Game Draw", RegTypedef._dataPlayers);						
						
						RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						PlayState.send("Game Players Values", RegTypedef._dataPlayers); 			
						
						RegTypedef._dataGameMessage._gameMessage = "";
						RegTypedef._dataPlayers._gameMessage = "";
						
						
					}
					
					if (Reg._gameOverForPlayer == false) Reg._outputMessage = true;
					
					Reg._playerCanMovePiece = false; // highlighted units are no longer active.
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					
					RegFunctions.playerAllStop();
								
				}
				
			}
		#end
		
	}	
	
	/******************************
	 * BEFOR A MOVE IS MADE. called from somewhere within a game file such as CheckersCapturingInits. not called from PlayState and not called from an event.
	 */
	public function canPlayerMove2():Void
	{
		if (Reg._createGameRoom == true) return;
		
		//-----------------------------------------------------------------------------
		// is there a checkers piece left on board?
		
		if (Reg._gameId == 0)
		{		
			// by default with this var no capturing units are found for checkers.
			var _found:Bool = false;
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// this _found var will be true is there is a player's checkers piece on board.
					if (Reg._playerMoving == 1 && Reg._gamePointValueForPiece[yy][xx] > 0 && Reg._gamePointValueForPiece[yy][xx] < 3
					 || Reg._playerMoving == 0 && Reg._gamePointValueForPiece[yy][xx] > 10 && Reg._gamePointValueForPiece[yy][xx] < 13)
					{
						_found = true;
					}
				}
			}
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// TODO is this line needed?
					Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] = 0;		
				}
			}
			
			if (_found == false)
			{				
				// if _found is false then no piece exists on board for player. display the game over message to both players.
				Reg._gameMessage = "Game Over.";
				RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
				
				// send message to server then server to other client.
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);					
					
					RegTypedef._dataPlayers._gameMessage = "You win.";
				
					// this win and lose for this game is given at canPlayerMove1() function. do not need "Game Players Values" event here,
										
					RegTypedef._dataGameMessage._gameMessage = "";
					RegTypedef._dataPlayers._gameMessage = "";
					
					Reg._outputMessage = true;
				}
				
				Reg._playerCanMovePiece = false; // highlighted units are no longer active.
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
				RegFunctions.playerAllStop();
				
			}
		}
		
		var _found:Bool = false;		
		
		// chess. if we are here then game was checkmated.
		if (Reg._gameId == 1 && RegTriggers._chessCheckmateEvent == true)
		{
			RegTriggers._chessCheckmateEvent = false;
			
			Reg._playerCanMovePiece = false;
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
			RegFunctions.playerAllStop();
			
			var _piecesWhite:Int = 0;
			var _piecesBlack:Int = 0;
			
			// origin of check is the unit that places the king in check or checkmate. this code block deals with checkmate. get the piece color of the piece that put the king in check. that is needed so we know what game message text to send.
			if (Reg._gamePointValueForPiece[Reg._chessOriginOfCheckY[Reg._playerMoving]][Reg._chessOriginOfCheckX[Reg._playerMoving]] < 10) _piecesWhite = 1;
			if (Reg._gamePointValueForPiece[Reg._chessOriginOfCheckY[Reg._playerMoving]][Reg._chessOriginOfCheckX[Reg._playerMoving]] > 10) _piecesBlack = 1;
				
			if (Reg._game_online_vs_cpu == true
			||  Reg._game_offline_vs_cpu == false 
			&&  Reg._game_offline_vs_player == false
			&& RegTypedef._dataTournaments._move_piece == false) 
			{
				if (RegTypedef._dataPlayers._gameMessage == "")
				{
					if (RegTypedef._dataPlayers._spectatorWatching == false)
					{
						RegTypedef._dataPlayers._gameMessage = "You lose.";
						PlayState.send("Game Lose Then Win For Other", RegTypedef._dataPlayers);			
					}
					
					RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
					PlayState.send("Game Players Values", RegTypedef._dataPlayers); 					
					
					Reg._outputMessage = true;
				}
				
				return;
			}
			
			Reg._playerCanMovePiece = false;
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
			RegFunctions.playerAllStop();
						
			// if local player which lost the game...
			if (RegTypedef._dataPlayers._moveNumberDynamic[Reg._move_number_current] == Reg._move_number_current)	
			{
				if (Reg._game_offline_vs_cpu == true 
				||  Reg._game_offline_vs_player == true
				||  RegTypedef._dataTournaments._move_piece == true)
				{
					Reg._playerCanMovePiece = false;
					RegTriggers._messageWin = "Checkmate.";
					RegTriggers._win = true;
					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 1;
					
					Reg._gameOverForPlayer = true;
					Reg._gameOverForAllPlayers = true;
					RegFunctions.playerAllStop();				
					
					if (_piecesWhite < _piecesBlack) 
					{
						Reg._gameMessage = "Black piece wins."; // if message does not display then search for "Black piece wins." at PlayState.hx and add it where the message box is called to display.
					}
										
					if (_piecesWhite > _piecesBlack) 
					{
						Reg._gameMessage = "White piece wins.";	
					}
					
					Reg._outputMessage = true;
					return;
				}				
			}
				
		}
		
			
		// Reversi. is there an empty piece on board?
		if (Reg._gameId == 2)
		{			
			_found = false;
		
			// this is the piece total count on board when game ends.
			var _piecesWhite:Int = 0;
			var _piecesBlack:Int = 0;
				
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// empty piece found.
					if (Reg._gamePointValueForPiece[yy][xx] == 0) _found = true;
				}
			}
			
			// if there is no empty units on the game board then _found will be false.
			if (_found == false)
			{
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// get the total count of white and black pieces.
						if (Reg._gamePointValueForPiece[yy][xx] == 1) _piecesWhite += 1;
						if (Reg._gamePointValueForPiece[yy][xx] == 11) _piecesBlack += 1;
					}
				}
				
				// display a game over message to all players.
				Reg._gameMessage = "Game Over.";
				RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
								
				if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
				{
					PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);					
					
					if (_piecesWhite < _piecesBlack)
					{
						RegTypedef._dataPlayers._piece_total_for_winner = _piecesBlack;
						if (RegTypedef._dataPlayers._spectatorWatching == false)
						{
							RegTypedef._dataPlayers._gameMessage = "You lose.";
							PlayState.send("Game Lose Then Win For Other", RegTypedef._dataPlayers);		
						}
					}
					
					if (_piecesWhite > _piecesBlack) 
					{
						RegTypedef._dataPlayers._piece_total_for_winner = _piecesWhite;
						RegTypedef._dataPlayers._gameMessage = "You win.";
						PlayState.send("Game Win Then Lose For Other", RegTypedef._dataPlayers);			
					}
					
					if (_piecesWhite == _piecesBlack) 
					{
						RegTypedef._dataPlayers._gameMessage = "Game ended in a draw.";
						PlayState.send("Game Draw", RegTypedef._dataPlayers);						
					}
					
					RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
					PlayState.send("Game Players Values", RegTypedef._dataPlayers); 				
				}
				
				Reg._playerCanMovePiece = false;
				
				Reg._gameOverForPlayer = true;
				Reg._gameOverForAllPlayers = true;
				RegFunctions.playerAllStop();
								
				Reg._outputMessage = true;	
				
				// the last person that moved.
				if (RegTypedef._dataPlayers._moveNumberDynamic[Reg._move_number_current] == Reg._move_number_current)	
				{
					// display message of which player won for offline play.
					if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
					{
						if (_piecesWhite > _piecesBlack) 
						{
							RegTriggers._messageWin = "White piece wins.";
							RegTriggers._win = true;
							RegTypedef._dataTournaments._game_over = 1;
							RegTypedef._dataTournaments._won_game = 1;
						}
											
						if (_piecesWhite < _piecesBlack) 
						{
							RegTriggers._messageLoss = "Black piece wins.";
							RegTriggers._loss = true;
							
						}
						
						if (_piecesWhite == _piecesBlack)
						{
							RegTriggers._messageDraw = "Game ended in a draw.";
							RegTriggers._draw = true;
							
						}
						
						return;
					}					
				}				
							
			}
				
		
			// sometimes it is possible to not be able to move a Reversi piece when there are lots of game board units still empty.
			if (_found == true)
			{
				var _found2:Bool = false;
				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						// is there a capturing unit for this player.
						if (Reg._capturingUnitsForPieces[Reg._playerMoving][yy][xx] == 1 && Reg._gamePointValueForPiece[yy][xx] == 0 || Reg._triggerNextStuffToDo <= 3)
						_found2 = true;
					}
				}		
			
				// if there is no capturing units on the game board then _found will be false.
				if (_found2 == false)
				{	
					if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
					{
						var _piecesWhite2:Int = 0;
						var _piecesBlack2:Int = 0;
						
						// get the last player that was able to move. get the piece color of that player so that we know the other color that cannot move.
						if (Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] == 11) _piecesBlack2 = 1;
						if (Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] == 1)  _piecesWhite2 = 1;
						
						// if this value is 0 then this piece cannot move.
						if (_piecesWhite == 0) Reg._gameMessage = "White piece cannot move.";
						else Reg._gameMessage = "Black piece cannot move.";
										
						RegTriggers._win = true;
						RegTypedef._dataTournaments._game_over = 1;
						RegTypedef._dataTournaments._won_game = 1;
						
						if (_piecesWhite == 0)						
							RegTriggers._messageWin = "Black piece wins.";
						else
							RegTriggers._messageWin = "White piece wins.";
						
						Reg._outputMessage = true;
						Reg._playerCanMovePiece = false;
						
						Reg._gameOverForPlayer = true;
						Reg._gameOverForAllPlayers = true;
						RegFunctions.playerAllStop();
						
					}
					
					else 
					{
						// get piece count on board for daily quest.
						if (_piecesWhite < _piecesBlack)
							RegTypedef._dataPlayers._piece_total_for_winner = _piecesBlack;
					
						if (_piecesWhite > _piecesBlack) 
							RegTypedef._dataPlayers._piece_total_for_winner = _piecesWhite;
						//===============================
						
						// player cannot move message.
						Reg._gameMessage = RegTypedef._dataPlayers._username;
						Reg._gameMessage += " cannot move.";
				
						// prepare to send message to server so that the other player can see it.
						RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
						
						PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);		
						
						// since we entered a loop from a player that cannot move, the other player will win the game.
						RegTypedef._dataPlayers._gameMessage = "You lose.";
						
						if (RegTypedef._dataPlayers._spectatorWatching == false)
						{
							PlayState.send("Game Lose Then Win For Other", RegTypedef._dataPlayers);		
						}
						
						RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						PlayState.send("Game Players Values", RegTypedef._dataPlayers);						
						
						RegTypedef._dataGameMessage._gameMessage = "";
						RegTypedef._dataPlayers._gameMessage = "";
						
						Reg._outputMessage = true;
						Reg._playerCanMovePiece = false;					
					}
					
				}
			}
		}
		
		if (Reg._gameId == 3)
		{			
			if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true)
			{
				if (Reg._gameDiceMaximumIndex[0] < Reg._gameDiceMaximumIndex[1]) 
				{
					RegTriggers._messageWin = "Player 2 wins.";
					RegTriggers._win = true;
					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 1;
				}
									
				else 
				{
					RegTriggers._messageLoss = "Player 1 wins.";
					RegTriggers._loss = true;
					
				}
			}	
			
			Reg._gameMessage = "Game over.";
			
			if (Reg._game_offline_vs_player == false && Reg._isThisPieceAtBackdoor == false)
			{				
				RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
				PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);						

				RegTypedef._dataPlayers._gameMessage = "You win.";
				PlayState.send("Game Win Then Lose For Other", RegTypedef._dataPlayers);				
				
				RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
				PlayState.send("Game Players Values", RegTypedef._dataPlayers); 
				
			}		
			
				
			Reg._outputMessage = true;
			Reg._playerCanMovePiece = false;
			
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
			RegFunctions.playerAllStop();
			
		}
		
		
		if (Reg._gameId == 4)
		{
			var _canMove = false;		
			
			if (Reg._isThisPieceAtBackdoor == false)
			{				
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						if (yy == 7 && xx == 0
						||  yy == 7 && xx == 6 
						||  yy == 7 && xx == 7
						||  yy == 0 && xx == 7
						||  yy == 0 && xx == 2
						||  yy == 0 && xx == 0) {} // trap some outer units players do not use.
						else if (yy > 0 && yy < 7 && xx > 0 && xx < 7) {} // trap inner unit.
						else
						{
							if (Reg._gameUniqueValueForPiece[yy][xx] == 0)
							{
								_canMove = true;
							}
							
							if (Reg._gameUniqueValueForPiece[yy][xx] - 1 == Reg._move_number_next)
							{
								_canMove = true;
							}						
							
							
						}
					}
				}				
				
			}	
			
			if (Reg._game_offline_vs_cpu == true && _canMove == false
			||  Reg._game_offline_vs_player == true && _canMove == false) 
			{
				if (Reg._move_number_current > 0)
				{
					RegTriggers._messageWin = "You win.";
					RegTriggers._win = true;
					RegTypedef._dataTournaments._game_over = 1;
					RegTypedef._dataTournaments._won_game = 1;
				}
				else
				{
					RegTriggers._messageLoss = "You lose.";
					RegTriggers._loss = true;
				}
			}
			
			if (_canMove == false) 
			{
				Reg._gameMessage = "Game over.";
			}
			
			if (_canMove == false && Reg._game_offline_vs_cpu == false && Reg._isThisPieceAtBackdoor == false)
			{				
				RegTypedef._dataGameMessage._gameMessage = Reg._gameMessage;
				PlayState.send("Game Message Not Sender", RegTypedef._dataGameMessage);				

				RegTypedef._dataPlayers._gameMessage = "You lose.";
				PlayState.send("Game Lose", RegTypedef._dataPlayers);
				
			}		
			
			if (_canMove == false)
			{
				Reg._outputMessage = true;
				Reg._playerCanMovePiece = false;
				
				if ( Reg._roomPlayerLimit - Reg._playerOffset <= 2 )
				{
					RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
					
					if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
					{
						PlayState.send("Game Players Values", RegTypedef._dataPlayers); 
					}
					
					
					Reg._gameOverForPlayer = true;
					RegFunctions.playerAllStop();
				
				}
				
			}
		}

		
	}
}
