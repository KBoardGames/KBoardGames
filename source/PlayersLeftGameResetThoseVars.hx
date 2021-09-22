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
 * reset the vars back to default for the player that left playing a game.
 * @author kboardgames.com
 */
class PlayersLeftGameResetThoseVars extends FlxText
{
	private var __scene_game_room:SceneGameRoom;
	
	public function new(scene_game_room:SceneGameRoom)	
	{	
		super();
		
		// get any class file from this instance. for example, __scene_game_room._iDsCreateAndMain.__game_house_taxi_cafe...
		__scene_game_room = scene_game_room;
	}
	
	/******************************
	 * get the user that had time expired or left the game room. this is needed so that when timer runs out for that player, the game will continue for the other players, but if that player then exits the room then the game will start the game for the other player the second time. this code is used so that the second time the players start playing will not happen.
	 */
	public function restartingTheGameForOthers():Bool
	{
		var _bool:Bool = false;
		
		for (i in 0...4)
		{
			if (Reg._playerLeftGameUsername == RegTypedef._dataPlayers._usernamesStatic[i] && RegTypedef._dataPlayers._gamePlayersValues[i] == 0
			||  Reg._playerLeftGameUsername == RegTypedef._dataPlayers._usernamesStatic[i] && RegTypedef._dataPlayers._gamePlayersValues[i] == 2
			||  Reg._playerLeftGameUsername == RegTypedef._dataPlayers._usernamesStatic[i] && RegTypedef._dataPlayers._gamePlayersValues[i] == 4)
			{
				_bool = true;
			}
		}
		
		return _bool;
	}
	
	
	/******************************
	 * remove players data then reorder other players data then continue the game.
	 */
	public function assignMoveNumberPlayerAndShowRotator():Void
	{
		var _totalPlayers:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._gamePlayersValues[i] == 1 
			&&  RegTypedef._dataPlayers._usernamesDynamic[i] != "")
			{
				_totalPlayers += 1;
			}
		}
			
		// player has left the game room, so remove player's data such as win, lose state, username, excreta, from other player's RegTypedef _dataPlayers data.
		if (Reg2._removePlayerFromTypedefPlayers == true && Reg._gameOverForAllPlayers == false)
		{
			Reg2._removePlayerFromTypedefPlayers = false;
			
			// remove players data then reorder other players data.
			playerRepopulateTypedefPlayers();
			playerDataClearPlaying();
			
		}	
		
		if (_totalPlayers > 1 && Reg._gameOverForAllPlayers == false)
		{
			PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			Reg._move_number_next = 0;
			
			SceneGameRoom.assignMoveNumberPlayer();			
			
			Reg._gameXXnew = 0;
			Reg._gameOverForPlayer = false;
			
			if (Reg._move_number_current == 0)
			{
				Reg._gameDidFirstMove = false;
				Reg._playerCanMovePiece = true; 
				Reg._triggerNextStuffToDo = 0; 
				Reg._isThisPieceAtBackdoor = false;	
			}
			
			else Reg._playerCanMovePiece = false;
		}
	}
	
	/******************************
	* when player leaves the game playing room, clear the following vars.
	*/
	public function playerDataClearPlaying():Void
	{	
		var _user = Reg._playerLeftGameUsername;
		
		// remove the player, that left the game, from other player's RegTypedef.
		if (_user == RegTypedef._dataPlayers._usernamesDynamic[0])
		{
			RegTypedef._dataPlayers._usernamesDynamic.splice(0, 1);
			RegTypedef._dataPlayers._cash.splice(0, 1);
			RegTypedef._dataPlayers._score.splice(0, 1);
			RegTypedef._dataPlayers._gamesAllTotalWins.splice(0, 1);
			RegTypedef._dataPlayers._gamesAllTotalLosses.splice(0, 1);
			RegTypedef._dataPlayers._gamesAllTotalDraws.splice(0, 1);
			RegTypedef._dataPlayers._moveTimeRemaining.splice(0, 1);
			RegTypedef._dataPlayers._moveNumberDynamic.splice(0, 1);
			
			Reg._gameDiceCurrentIndex.splice(0, 1);
			Reg._gameDiceCurrentIndex.push(0);
			Reg._gameDiceMaximumIndex.splice(0, 1);
			Reg._gameDiceMaximumIndex.push(0);
			Reg._game_piece_color1.splice(0, 1);
			Reg._game_piece_color2.splice(0, 1);
			
			// set player 1 land back to 0.
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gameUniqueValueForPiece[yy][xx] == 1)
					{
						Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] = 0;
						Reg._gameUniqueValueForPiece[yy][xx] = 0;
					}
				}
			}
			
			set_new_land_owndership();	
		}
			
		else if (_user == RegTypedef._dataPlayers._usernamesDynamic[1])
		{
			RegTypedef._dataPlayers._usernamesDynamic.splice(1, 1);
			RegTypedef._dataPlayers._cash.splice(1, 1);
			RegTypedef._dataPlayers._score.splice(1, 1);
			RegTypedef._dataPlayers._gamesAllTotalWins.splice(1, 1);
			RegTypedef._dataPlayers._gamesAllTotalLosses.splice(1, 1);
			RegTypedef._dataPlayers._gamesAllTotalDraws.splice(1, 1);
			RegTypedef._dataPlayers._moveTimeRemaining.splice(1, 1);
			RegTypedef._dataPlayers._moveNumberDynamic.splice(1, 1);
			
			Reg._gameDiceCurrentIndex.splice(1, 1);
			Reg._gameDiceCurrentIndex.push(0);
			Reg._gameDiceMaximumIndex.splice(1, 1);
			Reg._gameDiceMaximumIndex.push(0);
			Reg._game_piece_color1.splice(1, 1);
			Reg._game_piece_color2.splice(1, 1);
			
			// set player 2 land back to 0.
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gameUniqueValueForPiece[yy][xx] == 2)
					{
						Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] = 0;
						Reg._gameUniqueValueForPiece[yy][xx] = 0;
					}
				}
			}
			
			set_new_land_owndership();	
		}
		
		else if (_user == RegTypedef._dataPlayers._usernamesDynamic[2])
		{
			RegTypedef._dataPlayers._usernamesDynamic.splice(2, 1);
			RegTypedef._dataPlayers._cash.splice(2, 1);
			RegTypedef._dataPlayers._score.splice(2, 1);
			RegTypedef._dataPlayers._gamesAllTotalWins.splice(2, 1);
			RegTypedef._dataPlayers._gamesAllTotalLosses.splice(2, 1);
			RegTypedef._dataPlayers._gamesAllTotalDraws.splice(2, 1);
			RegTypedef._dataPlayers._moveTimeRemaining.splice(2, 1);
			RegTypedef._dataPlayers._moveNumberDynamic.splice(2, 1);
			
			Reg._gameDiceCurrentIndex.splice(2, 1);
			Reg._gameDiceCurrentIndex.push(0);
			Reg._gameDiceMaximumIndex.splice(2, 1);
			Reg._gameDiceMaximumIndex.push(0);
			Reg._game_piece_color1.splice(2, 1);
			Reg._game_piece_color2.splice(2, 1);
			
			// set player 3 land back to 0.
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gameUniqueValueForPiece[yy][xx] == 3)
					{
						Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] = 0;
						Reg._gameUniqueValueForPiece[yy][xx] = 0;
					}
				}
			}
			
			set_new_land_owndership();	
		}
		
		else if (_user == RegTypedef._dataPlayers._usernamesDynamic[3])
		{
			RegTypedef._dataPlayers._usernamesDynamic.splice(3, 1);
			RegTypedef._dataPlayers._cash.splice(3, 1);
			RegTypedef._dataPlayers._score.splice(3, 1);
			RegTypedef._dataPlayers._gamesAllTotalWins.splice(3, 1);
			RegTypedef._dataPlayers._gamesAllTotalLosses.splice(3, 1);
			RegTypedef._dataPlayers._gamesAllTotalDraws.splice(3, 1);
			RegTypedef._dataPlayers._moveTimeRemaining.splice(3, 1);
			RegTypedef._dataPlayers._moveNumberDynamic.splice(3, 1);
			
			Reg._gameDiceCurrentIndex.splice(3, 1);
			Reg._gameDiceCurrentIndex.push(0);
			Reg._gameDiceMaximumIndex.splice(3, 1);
			Reg._gameDiceMaximumIndex.push(0);
			Reg._game_piece_color1.splice(3, 1);
			Reg._game_piece_color2.splice(3, 1);
			
			// set player 4 land back to 0.
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					if (Reg._gameUniqueValueForPiece[yy][xx] == 4)
					{
						Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] = 0;
						Reg._gameUniqueValueForPiece[yy][xx] = 0;
					}
				}
			}
			
			set_new_land_owndership();	
			
		}
		
		if (Reg._move_number_next > 0) Reg._move_number_next -= 1;
		__scene_game_room.removePlayersDataFromStage();
		
	}
	
	private static function set_new_land_owndership():Void
	{
		// set the new land owndership for the remaining players. player 2 land ownership had a value of 2 but now its 1. we minus 1 for each player since we are now minus 1 in players.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gameUniqueValueForPiece[yy][xx] > 0)
					Reg._gameUniqueValueForPiece[yy][xx] -= 1;
			}
		}
	}
			
	/******************************
	 * when playing a game and then leave that game room while still playing, the other two or three player will .push that player's arrays so that the game can still be played with the remaining players in that room.
	 * j n the player who left game, the data was .pop() now those arrays need to be added again or else there will be errors later.
	 */
	public static function playerRepopulateTypedefPlayers():Void
	{		
		for (i in 0...4)
		{
			if (i > RegTypedef._dataPlayers._usernamesDynamic.length-1)
				RegTypedef._dataPlayers._usernamesDynamic.push("");
				
			if (i > RegTypedef._dataPlayers._cash.length-1)
				RegTypedef._dataPlayers._cash.push(7000);
				
			if (i > RegTypedef._dataPlayers._score.length-1)
				RegTypedef._dataPlayers._score.push(0);
			
			if (i > RegTypedef._dataPlayers._gamesAllTotalWins.length-1)
				RegTypedef._dataPlayers._gamesAllTotalWins.push(0);
				
			if (i > RegTypedef._dataPlayers._gamesAllTotalLosses.length-1)
				RegTypedef._dataPlayers._gamesAllTotalLosses.push(0);
				
			if (i > RegTypedef._dataPlayers._gamesAllTotalDraws.length-1)
				RegTypedef._dataPlayers._gamesAllTotalDraws.push(0);
				
			if (i > RegTypedef._dataPlayers._moveTimeRemaining.length-1)
				RegTypedef._dataPlayers._moveTimeRemaining.push(0);
			
			if (i > RegTypedef._dataPlayers._moveNumberDynamic.length-1)
				RegTypedef._dataPlayers._moveNumberDynamic.push(0);
		}
		
		
		var _totalPlayers:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "")
			{
				_totalPlayers += 1;
			}
		}
		
		// this is needed so that restart offer and draw offer will work again.
		Reg._totalPlayersInRoom = _totalPlayers - 2; // a value of 2 is needed here. a 1 because the user has not yet been removed from the usernamesDynamic var and another 1 because _totalPlayersInRoom starts at a value of 0 but _totalPlayers var starts at a value of 1.
	}
	
	override public function destroy()
	{
		
		super.destroy();
	}
	
}
