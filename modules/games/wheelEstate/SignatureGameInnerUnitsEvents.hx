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

package modules.games.wheelEstate;

/**
 * ...
 * @author kboardgames.com
 */
class SignatureGameInnerUnitsEvents extends SignatureGameMain
{
	/******************************
	* buy, sell, inner unit actions (pay, burnt house, etc. unit _buyPriceForHouseTaxiCafe with a value greater than -1 is a land that can be sold, or purchased etc. a unit with a value of -1, a player can do other things, such as rent increase or cash gain.
	*/
	public static function unitActionsForPlayer(_p):Void
	{		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_next > 0)
		{
			SignatureGameMain._buttonEndTurnOrPayNow.active = false;
		}
		
		
		switch(_p)
		{
			case 0:
			{
				SignatureGameMain._textGeneralMessage.text = "You receive bonus $500.";
				
				// plus 500 to player's cash.
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += 500;
			}
			
			case 6: SignatureGameMain._textGeneralMessage.text = "You lose a game turn";
			
			case 14: SignatureGameMain._textGeneralMessage.text = "You lose a game turn";
			
			case 19: SignatureGameMain._textGeneralMessage.text = "You lose a game turn";
			
			case 21: SignatureGameMain._textGeneralMessage.text = "Fork In The Road.";
			
			case 27: SignatureGameMain._textGeneralMessage.text = "You now have access to the inner units.";
			
			case 28: 
			{
				SignatureGameMain._textGeneralMessage.text = "You receive bonus $500.";
				
				// plus 500 to player's cash.
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += 500;
			}
			
			case 29: SignatureGameMain._textGeneralMessage.text = "You lose a game turn";
			
			case 30: 
			{
				SignatureGameMain._textGeneralMessage.text = "You received $1oo for each house that you own. ";
			
				var _count:Int = 0; // used to count how many houses, taxi cab and cafe store player has.
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1 && Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] == 1)
						{
							_count += Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x];
						}
					}
				}
				
				var _total:Int = 0; // total cash for every house plus taxi cab plus cafe store.
				_total = _count * 100;
				
				SignatureGameMain._textGeneralMessage.text += "Total of house, taxi cab and cafe store owned is " + _count + ". \n\n" + _count + " * 100 = " + _total + ".";
				
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _total;
			
			}
			
			case 31: SignatureGameMain._textGeneralMessage.text = "You lose a game turn";//"A none opponent's outer unit can now be selected. Only one unit can be selected for this player's game turn. Once selected, you can do any choice that the unit permits.";
			
			// destroyed by fire.
			case 32: 
			{
				var _count:Int = 0;
				var _type:Int = 0;
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1)
						{
							if (Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] > 0)
							{
								_type = Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x];
								
								Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] = 0;
								
								// this is needed or else the house, cab or cafe store will not be removed from scene.
								SignatureGameMain._houseTaxiCafeAmountY[_count] = y;
								SignatureGameMain._houseTaxiCafeAmountX[_count] = x;
								
								_count += 1;
								
								break;
							}
						}
					}
					
					if (_count > 0) break;
				}
				
				var _str:String = "things";
				
				if (_type == 1) _str = "house";
				if (_type == 2) _str = "taxi cab";
				if (_type == 3) _str = "cafe store";
				
				SignatureGameMain._textGeneralMessage.text = "You just had " + _count + " " + _str + " destroyed by fire.";
			}
			
			// Pay $100 for maintenance.
			case 33: 
			{
				SignatureGameMain._textGeneralMessage.text = "Pay $100 maintenance for each house, taxi cab or cafe store that you own. ";
				
				var _count:Int = 0; // used to count how many houses player has. the value will be math times 100 for combined total house, taxi cab and cafe store.
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_current + 1 
						&& Reg._move_number_current == Reg._move_number_next
						&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[y][x] > 0)
						{
							_count += Reg._gameHouseTaxiCabOrCafeStoreForPiece[y][x];
						}
					}
				}
				
				var _total:Int = 0; // holds total cash received.
				
				// the value of 100 should not be increased to beyond 400.
				_total = _count * 100; 
				
				SignatureGameMain._textGeneralMessage.text += "\n\nAmount of services: " + _count + " * 100 = " + _total + ".";
						
				// check if player has enough cash for purchase.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - (_count * 100) < 0)
				{
					SignatureGameMain._totalDebtAmount = _total;		
					RegTriggers._notEnoughCash = true;
				}
				else RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _total; // pay it.
			}

			case 34:
			{
				SignatureGameMain.giveRentBonus();
			}
			
			case 35:
			{
				var _ra = FlxG.random.int(30, 300);
				SignatureGameMain._textGeneralMessage.text = "You had a party and received $" + _ra + ".";
				
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _ra;
			}
			
			case 36: 
			{
				var _ra = FlxG.random.int(300, 500);
				SignatureGameMain._textGeneralMessage.text = "You receive $" + _ra + " cash for each cafe store you own.";
				
				var _count:Int = 0; // used to count how many houses player has. the value will be math times 100 for total cafe stores.
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1 && Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] == 3)
						{
							_count += Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x];
						}
					}
				}
				
				// total cash for cafe stores.
				var _total:Int = _count * _ra;
				
				SignatureGameMain._textGeneralMessage.text += " Total cafe stores owned is " + _count + ". \n\n" + _count + " * " + _ra + 
				" = " + _total + ".";
						
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _ra;
			}
			
			case 37: 
			{
				SignatureGameMain._textGeneralMessage.text = "The total land cash value increased by 15%.";
				
				var _value:Float = 0;
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						_p = Reg._gamePointValueForPiece[y][x] - 1;
						
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1)
						{
							_value += SignatureGameMain._unitBuyingLandPrice[_p];
						}
					}
				}
				
				var _total:Float = _value * .15;
				
				SignatureGameMain._textGeneralMessage.text += "\n\n15% worth of land cash gains is $" + Std.string(_total);
				
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _total;				
			}
			
			case 38:
			{
				SignatureGameMain._textGeneralMessage.text = "The total land cash decreased by 15%";
				
				var _value:Float = 0;
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						_p = Reg._gamePointValueForPiece[y][x] - 1;
						
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1)
						{
							_value += SignatureGameMain._unitBuyingLandPrice[_p];
						}
					}
				}
				
				var _total:Float = Math.round(_value * .15);
				
				SignatureGameMain._textGeneralMessage.text += "\n\n15% worth of land cash losses is $" + Std.string(_total);
				
				// check if player has enough cash for loss.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _total < 0)
				{
					SignatureGameMain._totalDebtAmount = _total;
					RegTriggers._notEnoughCash = true;
				}
				else RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _total; // pay it.
			}
			
			case 39:
			{					
				var _ra = FlxG.random.int(200, 400);
				SignatureGameMain._textGeneralMessage.text = "You receive $" + _ra + " cash for each taxi cab you own.";
				
				var _count:Int = 0; // used to count how many taxi cabs player has.
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						// if player owns land...
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1 && Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] == 2)
						{
							_count += Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x];
						}
					}
				}
				
				// total cash for cabs.
				var _total:Int = _count * _ra;
				
				SignatureGameMain._textGeneralMessage.text += " Total taxi cabs owned is " + _count + ". \n\n" + _count + " * " + _ra + 
				" = " + _total + ".";
						
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _ra;
			}
			
			case 40: 
			{					
				var _ra = FlxG.random.int(500, 750);
				SignatureGameMain._textGeneralMessage.text = "You pay the bug exterminator $" + _ra + ".";
				
				// check if player has enough cash for loss.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _ra < 0)
				{
					SignatureGameMain._totalDebtAmount = _ra;
					RegTriggers._notEnoughCash = true;
				}
				else RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _ra; // pay it.				
			}
			
			case 41: SignatureGameMain._textGeneralMessage.text = "You lose a game turn"; //"A none opponent's outer unit can now be selected. Only one unit can be selected for this player's game turn. Once selected, you can do any choice that the unit permits.";

			case 42: SignatureGameMain._textGeneralMessage.text = "Under Construction.";
			
			case 43:
			{
				var _ra = FlxG.random.int(100, 300);
				SignatureGameMain._textGeneralMessage.text = "$" + _ra + " worth of food was delivered to you.";
				
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _ra;
			}
			
			case 44: 
			{
				// total house, taxi cab and cafe store to take away.
				var _ra = FlxG.random.int(1, 4);					
				var _count:Int = 0; // increments until _ra is reached.
				
				// get player's total amount of house plus cabs plus store.
				var _total:Int = 0;
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1)
						{
							_total += Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x];
						}
					}
				}
				
				// if player does not have enough house, taxi or store to take away then make that amount equal total amount to take away or 0 total of houses, cabs and stores to take away
				if (_ra > _total) _ra = Math.round(_total);
				
				// remove houses, cabs and stores until loop is finished.
				for (i in 0...28)
				{
					for (y in 0...8)
					{
						for (x in 0...8)
						{
							// if player owns land...
							if (Reg._gameUniqueValueForPiece[y][x] == Reg._move_number_next + 1)
							{
								if (Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] > 0)
								{
									Reg._gameHouseTaxiCabOrCafeStoreTypePiece[y][x] -= 1;
									
									SignatureGameMain._houseTaxiCafeAmountY[_count] = y;
									SignatureGameMain._houseTaxiCafeAmountX[_count] = x;
										
									_count += 1;
									
									
									
									if (_count >= _ra) break;
								}
							}
						}
						
						if (_count >= _ra) break;
					}
					
					if (_count >= _ra) break;
				}
				
				SignatureGameMain._textGeneralMessage.text = "You lost " + _ra + " from houses, taxi cabs or cafe stores and 33% of your cash.";
				
				var _cash:Float =  RegTypedef._dataPlayers._cash[Reg._move_number_next] * .667;
				
				// check if player has enough cash for loss.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _cash < 0)
				{
					SignatureGameMain._totalDebtAmount = _cash;
					RegTriggers._notEnoughCash = true;
				}
				else RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _cash; // pay it.				
			}
			
			case 45: 
			{
				var _ra = FlxG.random.int(20, 1000);
				SignatureGameMain._textGeneralMessage.text = "You won $" + _ra + " at a casino.";
			
				RegTypedef._dataPlayers._cash[Reg._move_number_next] += _ra;
			}
			
			case 46: 
			{
				SignatureGameMain.giveRentBonus();
			}
			
			case 47: SignatureGameMain._textGeneralMessage.text = "You lose a game turn"; //"A none opponent's outer unit can now be selected. Only one unit can be selected for this player's game turn. Once selected, you can do any choice that the unit permits.";
			
		}
		
	}
	
}