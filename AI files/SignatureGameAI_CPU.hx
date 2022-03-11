/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.games.wheelEstate;

/**
 * the bar displayed behind the quest description and total daily quest value completed.
 * author: kboardgames.com.
 */
class SignatureGameAI_CPU extends FlxState
{
	/******************************
	 * used to delay computer from doing things.
	 */
	public var _cpu_ticks_delay:Float = 0;
	
	/******************************
	 * the computer will determine if an option should be done by using a random value ay movePiece function. the computer will then determine if something should be done or do another _shouldEndTurn random value. if the computer sets this _shouldEndTurn as true then the next time entering the movePiece function this var will end turn. false, and the computer will do another random value to do something else at options.
	 *
	 */
	private var _shouldEndTurn:Bool = false;
	 
	/******************************
	 * use a _randon var to decide which option to do at the options menu.
	 */
	private var _random:Int = 0;
	 
	/******************************
	 * when computer is moving, bypass the send trade units message box, seen when the trade proposal button is mouse clicked, and just display the 30 second message box for other player to decide if a trade should be made.
	 */
	public var _cpuSendTradeProposalMessageBoxBypass:Bool = false;
	
	/******************************
	 * if this var and unitOtherImageUnitTemp not equal 0 then a trade will be made.
	 * unitYourImageUnitTemp is your land while unitOtherImageUnitTemp is the other player's land. at first the _CPUlistUnitsToTradeSend and _CPUlistUnitsToTradeGet vars search for units that the computer can take. to determine if both those vars are used, meaning that the computer found a computer and a other piece to trade, then this var will get the worst of a land while unitOtherImageUnitTemp will get the best land to trade.
	 */
	public var _unitYourImageTemp:Int = 0;
	public var _unitOtherImageTemp:Int = 0;
	
	/******************************
	 * when this value is false, the computer will end turn. at the start of the computer's turn, SignatureGameAI_CPU._CPUthingsToDo is set to true.
	 */
	public static var _CPUthingsToDo:Bool = false;
	
	/******************************
	 * when this value is of a set value, and the _CPUthingsToDo = false, the computer will end turn.
	 */
	public static var _CPUticks:Float = 0;
	
	/******************************
	 * when at a set value the units and any cash that the computer would like to trade will be displayed.
	 */
	public static var _CPUticksDisplayTrade:Float = 0;
	public static var _CPUticksReplyTrade:Float = 0;
	public static var _CPUticksDisplayBuyService:Float = 0;
	
	
	public static var _tradeStuffDisplayThem:Bool = false;
	
	/******************************
	 * set random value for next computer turn.
	 */	 
	public static var _CPUrandomExitOptions:Float = 100;
	
	/******************************
	 * set random value for next computer turn.
	 */
	public static var _CPUrandomBuyLand:Float = 0;
	
	public static var _CPUisBuyingLand:Bool = false;
	
	//############################# START
	/******************************
	 * when at buying services, this var is used to stop re-entering the code block the second time.
	 */
	public static var _CPUisBuyingServices:Bool = false;
	/******************************
	 * when at selling services, this var is used to stop re-entering the code block the second time.
	 */
	public static var _CPUisSellingServices:Bool = false;
	/******************************
	 * when at trading land, this var is used to stop re-entering the code block the second time.
	 */
	public static var _CPUisTradingLand:Bool = false;
	/******************************
	 * when at mortgage, this var is used to stop re-entering the code block the second time.
	 */
	public static var _CPUisGettingMortgage:Bool = false;
	
	/******************************
	 * a computer is trying to get out of debt and this var is used when computer needs to mortgage another land. it is used to trigger delay ticks.
	 */
	public static var _doAnotherMortgage:Bool = false;
	
	/******************************
	 * used to delay the mortgage code so that the previous mortgage message can be read.
	*/
	public static var _ticksMortgage:Float = 0;
	
	//############################# END
	
	//############################# START
	/******************************
	 * at movePiece(), this var stops the _random from triggering an event to re-enter the buying services because when this var is true that menu option has already been code executed.
	 */
	public static var _beenHereBuyingServices:Bool = false;
	/******************************
	 * at movePiece(), this var stops the _random from triggering an event to re-enter the selling services because when this var is true that menu option has already been code executed.
	 */
	public static var _beenHereSellingServices:Bool = false;
	/******************************
	 * at movePiece(), this var stops the _random from triggering an event to re-enter the trading land because when this var is true that menu option has already been code executed.
	 */
	public static var _beenHereTradingLand:Bool = false;
	/******************************
	 * at movePiece(), this var stops the _random from triggering an event to re-enter the getting mortgage because when this var is true that menu option has already been code executed.
	 */
	public static var _beenHereGettingMortgage:Bool = false;
	//############################# END
	
	/******************************
	 * stores the units that the computer would like to get from player.
	 * b: building group number. the value will be the unit number.
	 */
	public static var _CPUlistUnitsToTradeGet:Array<Int> = [0,0,0,0,0,0,0];
	
	/******************************
	 * stores the units that the computer would like to send to player.
	 * b: building group number. the value will be the unit number.
	 */
	public static var _CPUlistUnitsToTradeSend:Array<Int> = [0,0,0,0,0,0,0];
	
	public var __signature_game_main:SignatureGameMain;
	
	public function new(signature_game_main):Void
	{
		super();			
		
		__signature_game_main = signature_game_main;

	}
	
	public function options():Void
	{
		 _cpu_ticks_delay = 0;
		_shouldEndTurn = false;
		_random = 0;
		_cpuSendTradeProposalMessageBoxBypass = false;
		_unitYourImageTemp = 0;
		_unitOtherImageTemp = 0;
		_CPUthingsToDo = false;
		_CPUticks = 0;
		_CPUticksDisplayTrade = 0;
		_CPUticksReplyTrade = 0;
		_CPUticksDisplayBuyService = 0;
		_tradeStuffDisplayThem = false;
		_CPUrandomExitOptions = 100;
		_CPUrandomBuyLand = 0;
		_CPUisBuyingLand = false;
		_CPUisBuyingServices = false;
		_CPUisSellingServices = false;
		_CPUisTradingLand = false;
		_CPUisGettingMortgage = false;
		_doAnotherMortgage = false;
		_ticksMortgage = 0;
		_beenHereBuyingServices = false;
		_beenHereSellingServices = false;
		_beenHereTradingLand = false;
		_beenHereGettingMortgage = false;
		_CPUlistUnitsToTradeGet = [0,0,0,0,0,0,0];
		_CPUlistUnitsToTradeSend = [0,0,0,0,0,0,0];
			
		movePiece();
	}
	
	/******************************
	 * this function uses a random var of _shouldEndTurn to do things at options. at the end of that loop, the computer will determine if that option should be done. if that is true then the _shouldEndTurn will be true, so if that var is true the next time entering this function that var will end turn.
	 */
	private function movePiece():Void
	{
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0 
		 && Reg._move_number_current == Reg._move_number_next
		 && Reg._isThisPieceAtBackdoor == false)
		{
			if (_beenHereBuyingServices == true 
			&&  _beenHereSellingServices == true
			&&  _beenHereGettingMortgage == true
			&&  _beenHereTradingLand == true
			)
				_CPUthingsToDo = false;
			
			if (RegTriggers._tradeProposalOffer == true)
				_CPUthingsToDo = true;
				
				
			if (_shouldEndTurn == true) return;
			
			if (Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0)
			{
				// buy service. do trade.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_current] > 800)
				{
					_random = FlxG.random.int(1, 70);
				}
				// sell service. get mortgage.
				else 
				{
					_random = FlxG.random.int(71, 100);
				}
			}
			
			if (Reg._gameDiceMaximumIndex[Reg._move_number_next] < 28)
			{
				if (_random > 30 && _random < 51 && _beenHereBuyingServices == false)
				{
					_beenHereBuyingServices = true; _CPUisBuyingServices = true;	
				}
				
				else if (_random > 50 && _random < 71 && _beenHereTradingLand == false)
				{
					_beenHereTradingLand = true; _CPUisTradingLand = true; 
					
				}
				
				else if (_random > 70 && _random < 85 && _beenHereGettingMortgage == false)
				{
					_beenHereGettingMortgage = true; _CPUisGettingMortgage = true; 					
				}
			
				else if (_random > 84 && _random < 101 && _beenHereSellingServices == false)
				{
					_beenHereSellingServices = true; _CPUisSellingServices = true; 					
				}
				
			}
			// might be in debt at inner units so go to "get mortgage".
			else if (Reg._move_number_current > 0)
			{
				if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == 33
				||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 38
				||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 40
				||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 44
				
				)
				{
					_beenHereGettingMortgage = true; _CPUisGettingMortgage = true; 			
				}
			}
			
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0 && Reg._move_number_current == Reg._move_number_next && Reg._isThisPieceAtBackdoor == false
		||  RegTriggers._tradeProposalOffer == true)
		{
			_cpu_ticks_delay = RegFunctions.incrementTicks(_cpu_ticks_delay, 60 / Reg._framerate);
			
			if (_cpu_ticks_delay < 300) return;
			
			// can the computer moving piece or is there nothing to do for the computer. 
			if (_CPUisBuyingLand == false && _CPUisBuyingServices == false 		&& _CPUisSellingServices == false && _CPUisGettingMortgage == false && _CPUisTradingLand == false)
			{
				_CPUthingsToDo = false; 
			}
			
			// if there is nothing to do for the computer then do the ticks until ticks reaches the random value. when that happens, the computer will close options.
			if (SignatureGameMain.background != null)
			{
				if (Reg._game_offline_vs_cpu == true 
					&&  Reg._move_number_current > 0 
					&& _CPUthingsToDo == false
					&& SignatureGameMain.background.visible == true
					&& __signature_game_main._buttonGoBack.visible == false
					&& RegTypedef._dataPlayers._cash[Reg._move_number_next] >= SignatureGameMain._totalDebtAmount
				)
				{
					_CPUticks = RegFunctions.incrementTicks(_CPUticks, 60 / Reg._framerate);
					if (_CPUticks >= _CPUrandomExitOptions) _CPUticks = 0;		
					if (_CPUticks == 0)
					{
						__signature_game_main.buttonOK();
						_cpu_ticks_delay = 0;
					}
				}
			}
			
			if (__signature_game_main._ticksStartForPayMortgageMessageBox == false
			&&  SignatureGameMain._buttonEndTurnOrPayNow != null
			&&  SignatureGameMain._buttonEndTurnOrPayNow.visible == true
			||  RegTriggers._tradeProposalOffer == true)
			{
				if (RegTriggers._tradeProposalOffer == false)
				{
					// determine if computer can by land. if true then buy land.
					if (_CPUisBuyingLand == true) buyLand();	
					
					// buy a service such as a house, cab or cafe.
					if (_CPUisBuyingServices == true) buyService();
					
					// sell all services for that land.
					if (_CPUisSellingServices == true) sellServices();
					
					// sell all services for that land.
					if (_CPUisGettingMortgage == true) getMortgage();
					
					// computer is sending a trade proposal.
					if (_CPUisTradingLand == true) doTrade();
				}	
				// computer is replying to a trade proposal.
				else 
				{
					replyToTrade(); 
				}	
			
				//############################# TRADE DISPLAY
				
				// if here, then there is a trade. display the units and any cash to the other player.
				if (_tradeStuffDisplayThem == true)
				{
					_CPUticksDisplayTrade = RegFunctions.incrementTicks(_CPUticksDisplayTrade, 60 / Reg._framerate);
						
					if (_CPUticksDisplayTrade >= 160) 
					{
						_CPUticksDisplayTrade = 0;
						
						__signature_game_main.tradeSelectPlayer();
						__signature_game_main.buttonsTradeInactive();
						
						// user to information.
						Reg._gameYYnew2 = RegFunctions.getPfindYY(_unitYourImageTemp);
						Reg._gameXXnew2 = RegFunctions.getPfindXX(_unitYourImageTemp);
						Reg._gameYYold2 = RegFunctions.getPfindYY(_unitOtherImageTemp);
						Reg._gameXXold2 = RegFunctions.getPfindXX(_unitOtherImageTemp);
						
						SignatureGameMain._unitYoursButton.label.text = "";
						Reg._signatureGameUnitNumberTrade[0] = _unitYourImageTemp;
						SignatureGameMain._unitYoursText.text = "Unit #" + _unitYourImageTemp;
						SignatureGameMain._unitYoursImage.loadGraphic("assets/images/signatureGame/" + _unitYourImageTemp +".png", false);
						
						
										
						SignatureGameMain._unitOthersButton.label.text = ""; // removes "others" text.
						Reg._signatureGameUnitNumberTrade[1] = _unitOtherImageTemp;
						SignatureGameMain._unitOthersText.text = "Unit #" + _unitOtherImageTemp;
						SignatureGameMain._unitOthersImage.loadGraphic("assets/images/signatureGame/" + _unitOtherImageTemp +".png", false);
						
						_tradeStuffDisplayThem = false;
						
						__signature_game_main.buttonTradeProposal(); // send trade request to player.
						
						_cpuSendTradeProposalMessageBoxBypass = true;
						_beenHereTradingLand = true;
						
					}
				}
			}
			
			if (_doAnotherMortgage == true)
			{
				_ticksMortgage = RegFunctions.incrementTicks(_ticksMortgage, 60 / Reg._framerate);
					
				if (_ticksMortgage >= 80) 
				{
					_ticksMortgage = 0;
					
					_doAnotherMortgage = false;
					_CPUisGettingMortgage = true;
				}
			}
			
			super.update(elapsed);
		}
	}
	
	/******************************
	 * buy land.
	 */
	private function buyLand():Void
	{
		// buy land.
		if (Reg._game_offline_vs_cpu == true 
			&&  Reg._move_number_current > 0 
			&& _CPUthingsToDo == true
			&& _CPUisBuyingLand == true
			&& SignatureGameMain.background.visible == true
			&& SignatureGameMain._priceOfLand > -1
		)
		{
			// do the ticks until ticks reaches the random value. when that happens, the computer will buy the land.
			_CPUticks = RegFunctions.incrementTicks(_CPUticks, 60 / Reg._framerate);
			if (_CPUticks >= _CPUrandomBuyLand) _CPUticks = 0;		
			if (_CPUticks == 0) Reg._buttonCodeValues = "s1000";
		}
	}
	
	/******************************
	 * buy a service such as a house, cab or cafe.
	 */
	private function buyService():Void
	{
		// computer doing a buy service.
		if (__signature_game_main._buttonBuyHouseTaxiCabOrCafeStores != null && Reg._move_number_current > 0
		&& _CPUisBuyingServices == true
		)
		{			
			if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0 
		&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 4)
			{
				if (__signature_game_main._buttonBuyHouseTaxiCabOrCafeStores.visible == true)
				{
					// check if computer has enough cash to buy house, taxi cab or cafe store.
					if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]][Reg._gameDiceMaximumIndex[Reg._move_number_next]] < 1500)
					{
						_CPUisBuyingServices == false;
						_beenHereBuyingServices = true;
						
						movePiece();
					}
					
					_CPUticksDisplayBuyService = RegFunctions.incrementTicks(_CPUticksDisplayBuyService, 60 / Reg._framerate);
						
					if (_CPUticksDisplayBuyService >= 35 && _CPUisBuyingServices == true) 
					{
						_CPUticksDisplayBuyService = 0;
						
						_beenHereBuyingServices = true;
						_CPUisBuyingServices = false;
						_CPUthingsToDo = false;
						
						// player bought house, taxi cab or cafe store.
						Std.string(RegTypedef._dataPlayers._cash[Reg._move_number_next] -= SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]][Reg._gameDiceMaximumIndex[Reg._move_number_next]]);
						
						var _count:Int = 0;
				
						// this var holds all the houses, cabs and stores for the outer units.
						Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] + 1);
						
						// the first house sometimes should start at 0 not 1...
						_count = Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1;
						
						// ...this starts at 0. this is needed or else the house, cab or cafe store will not be shown.
						SignatureGameMain._houseTaxiCafeAmountY[_count] = Reg._gameYYnew2;
						SignatureGameMain._houseTaxiCafeAmountX[_count] = Reg._gameXXnew2;
						
						var _str:String;
						var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
	
						if (_p == 4 || _p == 8 || _p == 18 || _p == 23) _str = "a taxi cab";		
						else if (_p == 5 || _p == 11 || _p == 17 || _p == 22)	_str = "a cafe store";	
						else _str = "a house";
						
						Reg._messageBoxNoUserInput = "Computer bought " + _str + " for $" + Std.int(Math.fround(SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][Reg._gameDiceMaximumIndex[Reg._move_number_next]]));
						Reg._outputMessage = true;
							
					}
				}
			}
			
			else
			{
				_CPUisBuyingServices == false;
				_beenHereBuyingServices = true;
				
				movePiece();
			}
		}
		
		else
		{
			_CPUisBuyingServices == false;
			_beenHereBuyingServices = true;
			
			movePiece();
		}
	}
	
	/******************************
	 * sell all services for that land.
	 */
	private function sellServices():Void
	{
		// computer doing a sell service.
		if (__signature_game_main._buttonBuyHouseTaxiCabOrCafeStores != null && Reg._move_number_current > 0
		&& _CPUisSellingServices == true
		)
		{
			if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0 && RegTypedef._dataPlayers._cash[Reg._move_number_next] < 700
			&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0
			&& Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1 == Reg._move_number_current)
			{			
				// gets the value of the last service divided by 2.
				__signature_game_main._sellAllServicesPrice = Std.int(FlxMath.roundDecimal((SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1][Reg._gameDiceMaximumIndex[Reg._move_number_next]]) / 2, 0));
				
				Reg._messageBoxNoUserInput += "Computer sells all services for $" + __signature_game_main._sellAllServicesPrice + ".";
				Reg._outputMessage = true;
				
				// get cash for selling the houses.
				RegTypedef._dataPlayers
	._cash[Reg._move_number_next] += __signature_game_main._sellAllServicesPrice;

				// set services back to nobody.	
				Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[Reg._gameDiceMaximumIndex[Reg._move_number_next]] = 0;
				Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = 0;
				
				// ...this starts at 0. this is needed or else the house, cab or cafe store will not be shown.
				SignatureGameMain._houseTaxiCafeAmountY[0] = Reg._gameYYnew2;
				SignatureGameMain._houseTaxiCafeAmountX[0] = Reg._gameXXnew2;
				
				for (p in 1...28)
				{
					SignatureGameMain._houseTaxiCafeAmountY[p] = 0;
					SignatureGameMain._houseTaxiCafeAmountX[p] = 0;
				}
				
				_CPUisSellingServices == false;
				_beenHereSellingServices = true;
				_CPUthingsToDo = false;
			}
			
			else
			{
				_CPUisSellingServices == false;
				_beenHereSellingServices = true;
				_CPUthingsToDo = false;
			}
		}
		
		else 
		{
			_CPUisSellingServices == false;
			_beenHereSellingServices = true;
			
			movePiece();
		}
	}
	
	/******************************
	 * get mortgage.
	 */
	private function getMortgage():Void
	{
		var _p:Int = 0; // unit number.
		var _unitNumber:Int = 28; // also unit number used only within this function.	
		var _stop:Bool = false; // break out of loop with var is true.
		var _triggerTicksMortgage:Bool = false; // used to trigger the _ticksMortgage var which is used to delay the code before another mortgage message is displayed.
			
			
		//############################# HIGH TO LOW
		// this finds the first occurrence of a unit that is greater or equal in cash value to the value of the debt. if a unit cannot take computer out of debt then see the next root loop below.
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > 27)
		{					
			// search the board in reverse order, so that the computer will always have an upper hand with trading.
			while (--_unitNumber >= 1)
			{
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{							
						if (Reg._gamePointValueForPiece[yy][xx] - 1 == _unitNumber
						&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] > 0
						&& Reg._gameUniqueValueForPiece[yy][xx] - 1 == Reg._move_number_current 
						&& Reg._move_number_current == Reg._move_number_next
						&& Reg._move_number_current > 0
						&& SignatureGameMain._mortgageLandPrice[Reg._move_number_next][_unitNumber] == -1)
						{
							if (SignatureGameMain._totalDebtAmount <= RegTypedef._dataPlayers._cash[Reg._move_number_next] + ((FlxMath.roundDecimal((SignatureGameMain._unitBuyingLandPrice[_unitNumber] + SignatureGameMain._buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] - 1][_unitNumber]) / 1.111, 0)) - __signature_game_main._mortgageProcessingFee))
							{
								__signature_game_main._gameYYnew2Temp = Reg._gameYYnew2 = yy;
								__signature_game_main._gameXXnew2Temp = Reg._gameXXnew2 = xx;
								
								_p = Reg._gamePointValueForPiece[yy][xx] - 1;
								_stop = true;
								
								break;
							}
						}
						if (_stop == true) break;
					}
					if (_stop == true) break;
				}
				
				if (_stop == true) break;
			}
		}
		
		//#############################
		// the _stop var will be false and used to get the very first unit in an increased order that the computer owns and then minus the debt then re-enter this function for another run.
		if (_stop == false)
		{
			if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > 27)
			{
				// search the board in reverse order, so that the computer will always have an upper hand with trading.
				for (_unitNumber in 1...28)
				{
					for (yy in 0...8)
					{
						for (xx in 0...8)
						{							
							if (Reg._gamePointValueForPiece[yy][xx] - 1 == _unitNumber
							&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[yy][xx] > 0
							&& Reg._gameUniqueValueForPiece[yy][xx] - 1 == Reg._move_number_current 
							&& Reg._move_number_current == Reg._move_number_next
							&& Reg._move_number_current > 0
							&& SignatureGameMain._mortgageLandPrice[Reg._move_number_next][_unitNumber] == -1)
							{
								__signature_game_main._gameYYnew2Temp = Reg._gameYYnew2 = yy;
								__signature_game_main._gameXXnew2Temp = Reg._gameXXnew2 = xx;
								 _triggerTicksMortgage = true;
								_p = Reg._gamePointValueForPiece[yy][xx] - 1;
								_stop = true;
								
								break;
							}
							if (_stop == true) break;
						}
						if (_stop == true) break;
					}
					
					if (_stop == true) break;
				}
			}
		}
		
		
		if (SignatureGameMain._isInDebt == true
		&&  RegTypedef._dataPlayers._cash[Reg._move_number_next] < SignatureGameMain._totalDebtAmount)
		{
			// computer getting a mortgage. everything here is needed.
			if (SignatureGameMain._buttonEndTurnOrPayNow != null
			&& SignatureGameMain._buttonEndTurnOrPayNow.visible == true && Reg._move_number_current > 0 
			&& Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0
			&& Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1 == Reg._move_number_current
			&& Reg._move_number_current == Reg._move_number_next
			&& _CPUisGettingMortgage == true
			)
			{
				_CPUisGettingMortgage = false;
				
				if (Reg._gameDiceMaximumIndex[Reg._move_number_next] < 28)
				{
					_p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
				}
				
				// don't get mortgage if this land is already mortgaged,
				if (SignatureGameMain._mortgageLandPrice[Reg._move_number_next][_p] == -1)
				{
					__signature_game_main.getMortgage();
					__signature_game_main._unitTitleTemp = SignatureGameMain._unitTitlesArray[_p];
				
					if (_triggerTicksMortgage == true)
					{		
						_doAnotherMortgage = true;
					}
				}
			
				_CPUisGettingMortgage == false;
				_beenHereGettingMortgage = true;
				_CPUthingsToDo = false;
				
			}
			else 
			{
				_CPUisGettingMortgage == false;
				_beenHereGettingMortgage = true;
				
				movePiece();
			}
		}
		
		else 
		{
			_CPUisGettingMortgage == false;
			_beenHereGettingMortgage = true;
			
			movePiece();
		}
		
	}	
	
	/******************************
	 * computer is sending a trade proposal.
	 */
	private function doTrade():Void
	{
		// go to trade a land menu.
		if (__signature_game_main._buttonTradeProposal != null && Reg._move_number_current > 0)
		{
			var _buildingNumberToUseInTradeSend:Int = 0;
			var _buildingNumberToUseInTradeGet:Int = 0;
			
			if (SignatureGameMain._tradeWith.visible == true && _CPUisTradingLand == true)
			{
				_CPUisTradingLand = false;
				
				for (_buildingGroupNumber in 1...7)
				{
					// get the single unit beside the CPUs building. This function searches, for example, for 2 building out of 3 that the computer owns in a group, then stores the other piece that could make a group into a var. 
					if (_buildingGroupNumber != 5) UnitsToTradeGetFromPlayer(_buildingGroupNumber);
				}
				
				var _buildingGroupNumber:Int = 7;
		
				// search the board in reverse order, so that the computer will always have an upper hand with trading.
				while (--_buildingGroupNumber >= 1)
				{
					if (_buildingGroupNumber != 5) 
					{
						var _ra = FlxG.random.int(1, 2);
						//if (_ra == 2) 
						UnitsToTradeSendMyCPU(_buildingGroupNumber);
					}
				}
				
				//---------------------------
				//gets the first unit in the array. that unit will be displayed to the other player.
				_unitYourImageTemp = 0;
				var _buildingGroupNumber:Int = 7;
				
				while (--_buildingGroupNumber >= 1)
				{
					if (_CPUlistUnitsToTradeSend[_buildingGroupNumber] > 0 && _unitYourImageTemp == 0)
					{
						_unitYourImageTemp = _CPUlistUnitsToTradeSend[_buildingGroupNumber];
						_buildingNumberToUseInTradeSend = _buildingGroupNumber;
					}
				}
				
				
				_unitOtherImageTemp = 0;
				
				for (_buildingGroupNumber in 1...7)
				{
					if (_CPUlistUnitsToTradeGet[_buildingGroupNumber] > 0 && _unitOtherImageTemp == 0)
					{
						_unitOtherImageTemp = _CPUlistUnitsToTradeGet[_buildingGroupNumber];
						_buildingNumberToUseInTradeGet = _buildingGroupNumber;
					}
				}
				
				// had both your and the other player;s units been selected?
				if (_unitOtherImageTemp > 0 && _unitOtherImageTemp > 0
				&& _buildingNumberToUseInTradeSend > _buildingNumberToUseInTradeGet)
				{
					// give other player a 500 cash bonus for each building group away from the other player's building group. for example, if computer selected building group 6 to send to player, and computer selected building group 1 to get from player, then 6 - 1 = 5 * 500 = 2500 cash bonus to send to player to make the trade more fair.
					var _cash:Int = (_buildingNumberToUseInTradeSend - _buildingNumberToUseInTradeGet) * 500;
					
					if (RegTypedef._dataPlayers._cash[Reg._move_number_current] >= _cash)
					{
						__signature_game_main._cashValueYoursText.text = "$" + Std.string(_cash);
						SignatureGameMain.tradingCashValue[0] = _cash;
						_tradeStuffDisplayThem = true;
							
						
					} 
					
					else 
					{
						_CPUisTradingLand == false;
						_beenHereTradingLand = true;
						
						movePiece();
					}
					
				}
				
				else 
				{
					_CPUisTradingLand == false;
					_beenHereTradingLand = true;
					
					movePiece();
				}
			}
			
			else 
			{
				_CPUisTradingLand == false;
				_beenHereTradingLand = true;
				
				movePiece();
			}
		}

		else 
		{
			_CPUisTradingLand == false;
			_beenHereTradingLand = true;
			
			movePiece();
		}
	}
	
	private function replyToTrade():Void
	{
		// computer is replying to a trade proposal.
		if (Reg._gameId == 4 && RegTriggers._tradeProposalOffer == true
		 && SignatureGameMain._replyTradeProposal._setButtonActive == false)
		{
			_CPUthingsToDo = true;
			_CPUticks = 0;
			
			_CPUticksReplyTrade = RegFunctions.incrementTicks(_CPUticksReplyTrade, 60 / Reg._framerate);
				
			if (_CPUticksReplyTrade > 60 && Reg._gameYYnew2 != -1 && Reg._gameXXnew2 != -1) 
			{
				_CPUticksReplyTrade = 0;
				//RegTriggers._tradeProposalOffer = false;
				
				// other
				_unitOtherImageTemp = Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1; // unit number.
				
				// get a unit from player or another computer.
				var _groupSend = Reg._gameUnitGroupsForPiece[Reg._gameYYnew2][Reg._gameXXnew2];
				UnitsToTradeSendMyCPU(_groupSend);
								
				// computer's unit.
				_unitYourImageTemp = Reg._gamePointValueForPiece[Reg._gameYYold2][Reg._gameXXold2] - 1; // unit number. 
				
				// computer's unit. gets the building group to send.
				var _groupGet = Reg._gameUnitGroupsForPiece[Reg._gameYYold2][Reg._gameXXold2];
				UnitsToTradeGetFromPlayer(_groupGet);
								
				// had both your and the other player's units been selected?
				if (_unitYourImageTemp > 0 && _unitOtherImageTemp > 0
				 && _unitYourImageTemp > _unitOtherImageTemp
				 && _CPUlistUnitsToTradeGet[_groupGet] > 0 
				 && _CPUlistUnitsToTradeSend[_groupSend] == 0) // zero value because computer player is getting a great deal.
				{
					// this is the cash that the computer needs to get. the math formula is computer group - other group times 1000.
					var _cash:Int = (_groupGet - _groupSend) * 1000;
					
					if (SignatureGameMain.tradingCashValue[0] >= _cash)
					{
						Reg._yesNoKeyPressValueAtTrade = 1;
					}
					
					else
					{
						RegTriggers._tradeWasAnswered = false;
						Reg._yesNoKeyPressValueAtTrade = 2;
					}
					
				}
				
				else 
				{
					RegTriggers._tradeWasAnswered = false;
					Reg._yesNoKeyPressValueAtTrade = 2; 
					
				}
				
				var _count:Int = 0;
		
				for (i in 0...4)
				{
					if (RegTypedef._dataPlayers._usernamesDynamic[i] == RegTypedef._dataGameMessage._userFrom)
					{
						_count = i;
					}
				}
				
				Reg._move_number_next = _count;
				Reg._move_number_current = _count;
		
			}
		}
	}
	
	public function UnitsToTradeGetFromPlayer(_buildingGroupNumber:Int):Void
	{
		// get how many building are in a group. if only 1 build is found then that building will be ignored.
		var _howManyBuildingsInGroup:Int = 0;
		
		// for example, if there is a total of 3 units in a group and this var is 1 then a trade can be made since only 1 other player owns a land at that group.
		var _howManyOfOtherPlayerLandAtGroup:Int = 0;
		var _howManyOfYourLandAtGroup:Int = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// search the array that holds the group numbers. group 1 has 3 building while group 2 has a total of 2 building.
				if (Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{
					_howManyBuildingsInGroup += 1;
				}
			}
		}
		
		
		// search to see if the computer is missing only one land from the group. for example, if computer is missing two out of three land in the group then it is not good practice to do a trade.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gameUniqueValueForPiece[yy][xx] != Reg._move_number_current + 1
				&&  Reg._gameUniqueValueForPiece[yy][xx] > 0
				&&  Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{					
					_howManyOfOtherPlayerLandAtGroup += 1;
					_CPUlistUnitsToTradeGet[_buildingGroupNumber] = Reg._gamePointValueForPiece[yy][xx] - 1;					
				}
			}
		}


		
		// how many lands do you the computer own at this group.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gameUniqueValueForPiece[yy][xx] == Reg._move_number_current + 1
				&&  Reg._gameUniqueValueForPiece[yy][xx] > 0
				&& _CPUlistUnitsToTradeSend[_buildingGroupNumber] == 0
				&&  Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{					
					_howManyOfYourLandAtGroup += 1;
				}
			}
		}
		
		// if true then there is only one building in a group that the computer should get.
		if (_buildingGroupNumber == 1 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 1 && _howManyOfOtherPlayerLandAtGroup == 1
		||  _buildingGroupNumber == 6 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 1 && _howManyOfOtherPlayerLandAtGroup == 1
		||  _buildingGroupNumber > 1 && _buildingGroupNumber < 5 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 1 && _howManyOfOtherPlayerLandAtGroup == 1)
		{}
		else
		{
			// if here then the trade should not be made for this building group. there might not be a other unit to trade with, so reset this var back to default because it should not be used.
			_CPUlistUnitsToTradeGet[_buildingGroupNumber] = 0;
		}
		
	
	}
	
	// find all units that computer would like to trade.
	public function UnitsToTradeSendMyCPU(_buildingGroupNumber:Int):Void
	{
		// send how many building are in a group. if only 1 build is found then that building will be ignored.
		var _howManyBuildingsInGroup:Int = 0;
		
		// for example, if there is a total of 3 units in a group and this var is 1 then a trade can be made since only 1 other player owns a land at that group.
		var _howManyOfOtherPlayerLandAtGroup:Int = 0;
		var _howManyOfYourLandAtGroup:Int = 0;
		
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				// search the array that holds the group numbers. group 1 has 3 building while group 2 has a total of 2 building.
				if (Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{
					_howManyBuildingsInGroup += 1;
				}
			}
		}
		
		// search to see if the computer is missing only one land from the group. for example, if computer is missing two out of three land in the group then it is not good practice to do a trade.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gameUniqueValueForPiece[yy][xx] != Reg._move_number_current + 1
				&&  Reg._gameUniqueValueForPiece[yy][xx] > 0
				&&  Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{					
					_howManyOfOtherPlayerLandAtGroup += 1;					
				}
			}
		}

		// how many lands do you the computer own at this group.
		for (yy in 0...8)
		{
			for (xx in 0...8)
			{
				if (Reg._gameUniqueValueForPiece[yy][xx] == Reg._move_number_current + 1
				&&  Reg._gameUniqueValueForPiece[yy][xx] > 0
				&& _CPUlistUnitsToTradeSend[_buildingGroupNumber] == 0
				&&  Reg._gameUnitGroupsForPiece[yy][xx] == _buildingGroupNumber)
				{					
					_howManyOfYourLandAtGroup += 1;
					_CPUlistUnitsToTradeSend[_buildingGroupNumber] = Reg._gamePointValueForPiece[yy][xx] - 1;
				}
			}
		}
		
		// if true then the computer should send that unit as trade.
		if (_buildingGroupNumber == 1 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 2 && _howManyOfOtherPlayerLandAtGroup == 2
		||  _buildingGroupNumber == 6 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 3 && _howManyOfOtherPlayerLandAtGroup == 3
		||  _buildingGroupNumber > 1 && _buildingGroupNumber < 5 && _howManyBuildingsInGroup - _howManyOfYourLandAtGroup == 1 && _howManyOfOtherPlayerLandAtGroup == 1)
		{}
		else
		{
			// if here then there are more than 1 other unit owned at this building group or there is no other unit, so reset this var back to default because it should not be used.
			_CPUlistUnitsToTradeSend[_buildingGroupNumber] = 0;
		}
		

	}
}