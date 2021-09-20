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
class IdsMessageBox extends FlxGroup
{
	private var _msg:MessageBox;
	
	public function new() 
	{
		super();
		
		if (Reg._messageId > 0)
		{
			switch (Reg._messageId)
			{
				// MenuState, from case (1 to 999).
				case 1: _msg = new MessageBox(1, "Yes", "No", true, true, true, false, "Update Client Software.", 'A newer version of the client software is at the website. Install the client software?');
				
				case 2:
				{
					// messages when trying to connect to the server, either a message about software needs updating or server is offline.
					if (Reg2._messageFileExists != "" ) _msg = new MessageBox(2, "Yes", "No", true, true, false, false, "Notice.", Reg2._messageFileExists);
			
					// else website is offline or player is not online.
					else _msg = new MessageBox(2, "Yes", "No", true, true, false, false, "Update Client.", "You cannot play board games with others online because your computer or the website " + Reg._websiteHomeUrl + " is offline.");
				}
				
				case 3: _msg = new MessageBox(3, "Yes", "No", true, true, true, false, "", "Check for a newer version of this K board games client software?");
			
				case 4: _msg = new MessageBox(4, "Yes", "No", true, true, false, false, "", "You have the most recent version of the client software.");
						
				case 5: _msg = new MessageBox(5, "Yes", "No", true, true, false, false, "", "Cannot connect to the website. Check your internet connection.");
			
				case 6: // messages when trying to connect to the server, either a message about software needs updating or server is offline.
			_msg = new MessageBox(6, "Yes", "No", true, true, true, false, "", "Go to the " + Reg._websiteNameTitle + " website and view the client help file?");
			
				case 7: _msg = new MessageBox(7, "Profile", "Register", true, true, true, false, "", 'You need a username before playing games online. Click "Profile" to enter your username. Click "Register" to get a username at the website forum.');
				
				// messsages that return a player back to MenuState, such as a banned message or a server disconnected notice.	
				case 10: _msg = new MessageBox(10, "Yes", "No", true, true, false, false, "", MenuState._str);
				
				// PlayState, from case (1000-1999).
				// message that the room is locked.
				case 1002: _msg = new MessageBox(1002, "Yes", "No", true, true, false, false, "Room Locked", "Someone beat you to this room. This room is locked until server sends room data to that person.");
				
				// kicked or banned message.
				case 1003: _msg = new MessageBox(1003, "Yes", "No", true, true, false, false, "", Reg._actionMessage);
		
				// lobby, from case (2000-2999)
				case 2000:
				{
					if (SceneLobby._message == 0) _msg = new MessageBox(2000, "Yes", "No", true, true, false, false, "Notice!", "You cannot enter room " + Std.string(SceneLobby._number_room_full) + " because someone is creating a game.");
					
					if (SceneLobby._message == 1) _msg = new MessageBox(2000, "Yes", "No", true, true, false, false, "Notice!", "You cannot enter room " + Std.string(SceneLobby._number_room_full) + " because the amount of players needed to play a game has been reached.");
				}
				
				case 2003: _msg = new MessageBox(2003, "Yes", "No", true, true, true, false, "Invitation to join room.", RegTypedef._dataPlayers._usernameInvite + " invites you to play " + RegTypedef._dataPlayers._gameName + " at room " + Std.string(Reg._inviteRoomNumberToJoin) + ". Do you want to enter that room?");
				
				case 2010: _msg = new MessageBox(2010, "Yes", "No", true, true, false, false, "Notice!", "You cannot enter room " + Std.string(SceneLobby._number) + " because some of its data is not yet available.");
				
				// display a server message from "Message All By Server" event.
				case 2222: _msg = new MessageBox(2222, "Yes", "No", true, true, false, false, "Notice!", Reg._server_message);
				
				// waiting room. case, 4000-4999.
				case 4000: _msg = new MessageBox(4000, "Yes", "No", true, true, true, false, "Return to lobby.", "Would you like to go back to the lobby?");
				case 4002: _msg = new MessageBox(4002, "Yes", "No", true, true, true, false, "Game Room.", "Enter the game room where you can start a game for all players in this waiting room?");				
				
				// daily quests, case 5000-5999.
				case 5001: _msg = new MessageBox(5001, "Yes", "No", true, true, false, false, "", 'Your reward is 300 experience points. Your total experience points is now ' + Std.string(RegTypedef._dataStatistics._experiencePoints));
				
				case 5002: _msg = new MessageBox(5002, "Yes", "No", true, true, false, false, "", 'Your reward is 100 house coins. Your total house coins is now ' + Std.string(RegTypedef._dataStatistics._houseCoins));
				
				case 5003: _msg = new MessageBox(5003, "Yes", "No", true, true, false, false, "", 'Your reward is 50 credits. Your total credits is now ' + Std.string(RegTypedef._dataStatistics._creditsTotal));
				
				// house furniture get. 6000-6999.
				case 6001:
				{
					if (HouseFurnitureGet._haveEnoughHouseCoins == true)
					{
						_msg = new MessageBox(6001, "Yes", "No", true, true, true, false, "Notice!", "Would you like to buy " + Std.string(RegHouse._namesCanPurchase[HouseFurnitureGet._idCurrentItemPurchased]) + " for " + RegHouse._coins[HouseFurnitureGet._idCurrentItemPurchased] + " coins?");
					}
					
					else
					{
						_msg = new MessageBox(6001, "Yes", "No", true, true, false, false, "Notice!", "You do not have enough house coins to buy " + Std.string(RegHouse._namesCanPurchase[HouseFurnitureGet._idCurrentItemPurchased]) + ".");
					}
				}
				
				// house menu main 7000-7999.
				case 7001: _msg = new MessageBox(7001, "Yes", "No", true, true, true, false, "Save House.", "Would you like to save all furniture items and their positions in this house?");
				
				case 7002: _msg = new MessageBox(7002, "Yes", "No", true, true, false, false, "Notice!", "House saved.");
				
				// leaderboard 8000-8999.
				// messages when trying to connect to the server, either a message about software needs updating or server is offline.
				case 8001: _msg = new MessageBox(8001, "Yes", "No", true, true, true, false, "Website Credits.", "Redirect to the full credits page at " + Reg._websiteNameTitle + " website?");
			
				// menu configuration output. 9000-9999.
				// messages when trying to connect to the server, either a message about software needs updating or server is offline.
				case 9001:
				{
					if (Reg2._messageFileExists != "" ) _msg = new MessageBox(9001, "Yes", "No", true, true, false, false, "Notice.", Reg2._messageFileExists);
				
					// else website is offline or player is not online.
					else _msg = new MessageBox(9001, "Yes", "No", true, true, false, false, "", "Configurations saved.");
				}
				
				case 9010: _msg = new MessageBox(9010, "Yes", "No", true, true, false, false, "", "Theme saved.");
								
				// menu credits 10000-10999
				case 10001: _msg = new MessageBox(10001, "Yes", "No", true, true, true, false, "Website Credits.", "Display the full credits page at " + Reg._websiteNameTitle + " website?");
				
				// new account. 11000-11999.
				case 11001: 
				{
					#if !html5
						_msg = new MessageBox(11001, "Yes", "No", true, true, false, false, "", "Configuration saved.");
					#else
						_msg = new MessageBox(11001, "Yes", "No", true, true, false, false, "", "Configuration applied for this session.");
					#end
				}
				
				// online players list. 12000-12999
				case 12003: _msg = new MessageBox(12003, "Yes", "No", true, true, true, false, "Invite.", "Invite " + RegTypedef._dataPlayers._usernameInvite + " to this room?");
				
				// player kick or ban players. 13000-13999.
				case 13005: _msg = new MessageBox(13005, "Kick", "Ban", true, true, true, false, "Kick " + RegTypedef._dataPlayers._actionWho + "?", 'Select "kick" to stop this player from entering your room for 15 minutes or select "ban" to reject player from enter this room for this session.');
				
				// signature game. 14000-14999.
				case 14010: _msg = new MessageBox(14010, "Yes", "No", true, true, false, false, "Notice!.", 'You do not have enough cash to end turn. Total debt is $' + SignatureGameMain._totalDebtAmount + '. To pay the debt, select your unit to get cash then select from the buttons that appear.');
				
				case 14020: _msg = new MessageBox(14020, "Yes", "No", true, true, false, false, "Notice!.", "For a trade proposal, you need at minimum, the other player's unit selected, and either your unit selected or your cash value greater than zero.");
				
				case 14025: _msg = new MessageBox(14025, "Yes", "No", true, true, true, false, "Sell " + SignatureGameMain._string, "You have " + Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] + " " + SignatureGameMain._string + " worth $" + Std.int(SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1][SignatureGameMain._int]) + ". Sell all " + SignatureGameMain._string + " at $" + SignatureGameMain._sellAllServicesPrice + " which is 50% precent of total value?");
				
				case 14125: _msg = new MessageBox(14125, "Yes", "No", true, true, true, false, "Buy Land.", "Are you sure?");
				
				case 14200: _msg = new MessageBox(14200, "Yes", "No", true, true, false, false, "Notice!.", "You do not have enough cash to pay for " + SignatureGameMain._string + " Land lost.");
				
				case 14300: _msg = new MessageBox(14300, "Pay", "Lose land", true, true, true, false, "Pay Mortgage.", "Mortgage for " + SignatureGameMain._string + " is due. Pay " + Std.int(Math.fround(SignatureGameMain._mortgageLandPrice[Reg._move_number_next][SignatureGameMain._mortgageLandPriceCurrentUnitIndex])) + " or lose land?");
				
				case 14470: _msg = new MessageBox(14470, "Yes", "No", true, true, false, false, "Notice!.", 'You cannot mortgage a land without services.');
				
				case 14500: _msg = new MessageBox(14500, "Yes", "No", true, true, false, false, SignatureGameMain._unitTitle.text, "This land is already mortgaged.");
				
				case 14550: _msg = new MessageBox(14550, "Yes", "No", true, true, true, false, "Get Mortgage?", "You have a land cash worth $" + FlxMath.roundDecimal(SignatureGameMain._unitBuyingLandPrice[SignatureGameMain._int], 0) + " and " + Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] + " " + SignatureGameMain._string + " worth " + FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][SignatureGameMain._int], 0) + ". Total cash is " + SignatureGameMain._float+ ". After 90% total Cash ($" + SignatureGameMain._mortgagePrice + " - $" + SignatureGameMain._mortgageProcessingFee + " processing fee), you will receive $" + SignatureGameMain._float2 + ".");
				
				// Action commands. sysop menu. 15000-15999.
				case 15000: _msg = new MessageBox(15000, "Yes", "No", true, true, true, false, "Goodbye.", "Disconnect from server?");
				
				// for spectator watching. Did the player one lose or win or do something else? this is the message box message for player 1 that displays for all spectators that are watching that game.
				case 16000: _msg = new MessageBox(16000, "Yes", "No", true, true, true, false, "Notice!", RegTypedef._dataGameMessage._gameMessage);
				
				case 16005: _msg = new MessageBox(16005, "Yes", "No", true, true, true, false, "Notice!", RegTypedef._dataGameMessage._gameMessage);
				
				case 16010: _msg = new MessageBox(16010, "Yes", "No", true, true, true, false, "Notice!", RegTypedef._dataGameMessage._gameMessage);
				
				case 16015: _msg = new MessageBox(16015, "Yes", "No", true, true, true, false, "Notice!", RegTypedef._dataGameMessage._gameMessage);
				
				// game over message
				case 16050: _msg = new MessageBox(16050, "Yes", "No", true, true, false, false, "", RegTriggers._messageWin);
				
				case 16055: _msg = new MessageBox(16055, "Yes", "No", true, true, false, false, "", "You eliminated " + RegTypedef._dataTournaments._player2 + " from the tournament.");
				
				// player loss game message.
				case 16100: _msg = new MessageBox(16100, "Yes", "No", true, true, false, false, "", RegTriggers._messageLoss);
				
				case 16105: _msg = new MessageBox(16105, "Yes", "No", true, true, false, false, "", RegTriggers._messageLoss);
				
				case 16110: _msg = new MessageBox(16110, "Yes", "No", true, true, false, false, "", RegTriggers._messageLoss);
				
				case 16115: _msg = new MessageBox(16115, "Yes", "No", true, true, false, false, "", RegTriggers._messageLoss);
				
				case 16120: _msg = new MessageBox(16120, "Yes", "No", true, true, false, false, "", RegTriggers._messageLoss);
				
				case 16150: _msg = new MessageBox(16150, "Yes", "No", true, true, false, false, "", "You are eliminated from the tournament.");
				
				case 16200: _msg = new MessageBox(16200, "Yes", "No", true, true, false, false, "", RegTriggers._messageDraw);
				
				case 16210:
				{
					if (RegCustom._start_game_offline_confirmation[Reg._tn] == true
					&&  Reg._game_offline_vs_cpu == true 
					||  RegCustom._start_game_offline_confirmation[Reg._tn] == true
					&&  Reg._game_offline_vs_player == true
					){}
					
					else
					{
						var _str:String = "";		
						if (Reg._roomPlayerLimit > 2) _str = "s";
											
						if (Reg._game_offline_vs_cpu == true || Reg._game_offline_vs_player == true) _msg = new MessageBox(16210, "Yes", "No", true, true, true, false, "Start another game?", "Would You like to start another game?");
								
						else
						{
							_msg = new MessageBox(16210, "Yes", "No", true, true, true, false, "Start game?", "Would You like to start the game? The other player" + _str + " will need to agree to this request.");
						}						
					}					
				}
				
				case 16250:
				{
					if (RegCustom._to_title_from_game_room_confirmation[Reg._tn] == false)
					{}
					
					else
					{		
						if (Reg._gameOverForPlayer == false 
						&& Reg._game_offline_vs_cpu == false
						&& Reg._game_offline_vs_player == false
						&& Reg._game_online_vs_cpu == false)
							_msg = new MessageBox(16250, "Yes", "No", true, true, true, false, "", "Return to title screen? A loss will be added to your game stats.");
						else
							_msg = new MessageBox(16250, "Yes", "No", true, true, true, false, "", "Return to title screen?");
						
					}
				}
				
				case 16300:
				{
					if (RegCustom._to_lobby_from_game_room_confirmation[Reg._tn] == false)
					{}
					
					else
					{
						if (Reg._game_online_vs_cpu == true || Reg._gameOverForPlayer == true)
							_msg = new MessageBox(16300, "Yes", "No", true, true, true, false, "", "Return to lobby?");
						else
							_msg = new MessageBox(16300, "Yes", "No", true, true, true, false, "", "Return to lobby? A loss will be added to your game stats.");
					
					}
				}
				
				case 16350: 
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16350, "Yes", "No", true, true, true, false, "", "Would you like to quit this game?");
					else
						_msg = new MessageBox(16350, "Yes", "No", true, true, true, false, "", "Would you like to quit this game? A loss will be added to your game stats.");
				}
				
				case 16400: _msg = new MessageBox(16400, "Yes", "No", true, true, true, false, "Offer a draw.", "Would You like to offer a draw so that nobody wins?");
				
				
				case 16450: _msg = new MessageBox(16450, "Yes", "No", true, true, true, false, "Offered draw.", "The other player has offered a draw. Do you agree that nobody wins?");
				
				case 16500:
				{
					if (RegCustom._accept_automatic_start_game_request[Reg._tn] == true
					&&  Reg2._do_once_accept_game_start_request == false)
					{}
					
					else
					{			
						if (Reg._gameOverForPlayer == true)
						{
							_msg = new MessageBox(16500, "Yes", "No", true, true, true, false, "Start game.", 'A request has been made to start a game. Do you accept?');
						}
						
					}
				}
				
				case 16600:
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16600, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + " quit the game.");
					else
						_msg = new MessageBox(16600, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + " quit the game. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");
				}
				
				case 16700:
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16700, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " quit the game.");
					else
						_msg = new MessageBox(16700, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " quit the game. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");
				}
				
				case 16750:
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16750, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " left the game room.");
					else
						_msg = new MessageBox(16750, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + " left the game room. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");
				}
				
				case 16770:
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16770, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + " left the game room.");
					else
						_msg = new MessageBox(16770, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + " left the game room. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");
				}
				
				case 16800: 
				{	
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16800, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + "'s time expired.");
					else
						_msg = new MessageBox(16800, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + "'s time expired. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");	
				}
				
				case 16850:
				{
					if (Reg._game_online_vs_cpu == true)
						_msg = new MessageBox(16850, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + "'s time expired.");
					else
						_msg = new MessageBox(16850, "Yes", "No", true, true, false, false, "Notice!", "You are now player " + (Reg._move_number_current + 1) + " because " + Reg._playerLeftGameUsername + "'s time expired. A loss was saved to " + Reg._playerLeftGameUsername + "\'s stats.");
				}
				
				case 16900: _msg = new MessageBox(16900, "Yes", "No", true, true, false, false, "Notice!", Reg._playerLeftGameUsername + " left the game room.");
							
			}	
			
			if (_msg != null) add(_msg);
			RegTriggers._buttons_set_not_active = true;
		}
		
		
	}
			
	
}