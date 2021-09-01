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
 * buy, sell, trade or pay rent. main game loop.
 * @author kboardgames.com
 */
class SignatureGameMain extends FlxState
{
	public static var _mortgagePrice:Float = 0; // current mortgage price.
	public static var _mortgageProcessingFee:Int = 500;
	
	/******************************
	 * if somewhere at an inner unit, based on conditions, the text will either be the inner title or the outer title. if at the outer units then the outer unit title will be displayed.
	 */
	public var _unitTitleTemp:String = "";
	
	/******************************
	 * used when computer moves. if at an inner unit where computer has a debt, this var is passed to Reg._gameYYnew2 so that the Reg._gameYYnew2 will have the correct coordinates. without this var, the Reg._gameYYnew2 will be set to a different value before a mortgage can be finished.
	 */
	public var _gameYYnew2Temp:Int = -1;
	
	/******************************
	 * used when computer moves. if at an inner unit where computer has a debt, this var is passed to Reg._gameXXnew2 so that the Reg._gameXXnew2 will have the correct coordinates. without this var, the Reg._gameXXnew2 will be set to a different value before a mortgage can be finished.
	 */
	public var _gameXXnew2Temp:Int = -1;
	
	public var _ticksStartForPayMortgageMessageBox:Bool = false;
	public var _ticksPayMortgage:Float = 0; // used to delay the close of a message box for the computer when computer is paying mortgage.
	
	/******************************
	 * _str is the message of not enough cash for a unit event at an inner units.
	 */
	public var _stringNotEnoughCash:String = "";
	
	/******************************
	 * used to update the information cards only once after a dice click. helps to display the data correctly because another card data can display regardless of GameImageCurrentUnit is not visible.
	 */
	public static var _displayCardDataOnceAfterDiceRoll:Bool = true;
	
	private var _dontBuyLandIfCashIsLessThan:Int = 0;
	
	/******************************
	* a square box where the parameter of it covers the under units.
	*/
	public static var background:FlxSprite;
	
	/******************************
	* a square box where the parameter of it covers the under units. in computer game, this background hides the buttons at center of screen when player is replying to trade.
	*/
	public static var background2:FlxSprite;
	
	/******************************
	* the background behind the unit's image and unit's text. also, displayed at the header of the background that overlaps the inner units.
	*/
	public var _unitBG:FlxSprite;
	
	/******************************
	* unit title displayed beside the unit text.
	*/
	public static var _unitTitle:FlxText;
	
	/******************************
	 * this is the text displayed of a unit when player is in debt and selects a unit to get cash from.
	 */
	public var _unitTitleDebt:FlxText;
	
	/******************************
	* an image of the unit where the player is at. Displayed in front of all background. Positioned at the header background.
	*/
	public var _unitImage:FlxSprite;
	
	/******************************
	 * true if player's piece is located at the board parameter.
	 */
	public var _pieceAtBoardParameter:Array<Bool> = [true, true, true, true];
	
	/******************************
	 * this is the image displayed of a unit when player is in debt and selects a unit to get cash from.
	 */
	public var _unitImageDebt:FlxSprite;
	
	/******************************
	* pay rent text to the landlord.
	*/
	public var _payRent:FlxText;
	
	/******************************
	* excluding land that can be bought, this is information about the land, such as, you won this or you pay so much to....
	*/
	public static var _textGeneralMessage:FlxText;
	
	/******************************
	* used for trading icons.
	*/
	public var _textGeneralMessage2:FlxText;
	public var _textGeneralMessage3:FlxText; // displayed on background2. text about no cancelling.
	
	/******************************
	 * the price of all services at the unit you would like to sell.
	 */
	public static var _sellAllServicesPrice:Float = 0;
	
	/******************************
	* Text about "would you like to buy land for..."
	*/
	private var _textBuyLand:FlxText;
	
	/******************************
	*  buy first house, first cab or first store.
	*/
	public var _buttonBuyHouseTaxiCabOrCafeStore1:ButtonUnique; 
	
	/******************************
	*  buy second house, second cab or second store.
	*/
	public var _buttonBuyHouseTaxiCabOrCafeStore2:ButtonUnique; 
	
	/******************************
	*  buy third house, third cab or third store.
	*/
	public var _buttonBuyHouseTaxiCabOrCafeStore3:ButtonUnique; 
	
	/******************************
	*  buy forth house, forth cab or forth store.
	*/
	public var _buttonBuyHouseTaxiCabOrCafeStore4:ButtonUnique; 
	
	/******************************
	* go back to the previous screen.
	*/
	public var _buttonGoBack:ButtonUnique; 
	
	/******************************
	* buy a land.
	*/
	private var _buttonBuyLand:ButtonUnique;
	
	/******************************
	* buy house, buy taxi or buy store.
	*/
	public var _buttonBuyHouseTaxiCabOrCafeStores:ButtonUnique;
	
	/******************************
	* buy mortgage.
	*/
	public var _buttonBuyMortgage:ButtonUnique;
	
	public var _buttonSellHouse:ButtonUnique;
	
	/******************************
	* trade with...
	*/
	public static var _tradeWith:ButtonUnique;
	
	/******************************
	* at the trading scene, this is the background just underneath your buttons, texts and image elements.
	*/
	public var _tradingYourBG:FlxSprite;
	public var _tradingOtherBG:FlxSprite;
	
	/******************************
	* the land that you would like to trade.
	*/
	public static var _unitYoursButton:ButtonToggleSignatureGame;// button to display image.
	public static var _unitYoursImage:FlxSprite; // image of unit on button.
	public static var _unitYoursText:FlxText; // text of what unit is selected.
	public var _cashSendText:FlxText; // text that says send.
	public var _cashMinus500YoursButton:ButtonUnique;// minus total. give to others.
	public var _cashPlus500YoursButton:ButtonUnique; // plus total. give to other.
	public var _cashValueYoursText:FlxText; // total cash to give to others.
	
	/******************************
	* the land that you would like to trade.
	*/
	public static var _unitOthersButton:ButtonToggleSignatureGame; 
	public static var _unitOthersImage:FlxSprite; 
	public static var _unitOthersText:FlxText; 	
	public var _cashGetText:FlxText; // text that says get.
	public var _cashMinus500OthersButton:ButtonUnique;//minus total.get from others.
	public var _cashPlus500OthersButton:ButtonUnique; // plus total. get from other.
	public var _cashValueOthersText:FlxText; // total cash to get from others.
	
	public static var _tradeAnsweredAs:Bool = false; // true, if trade was accepted.
	
	private var _tradeSuccessfulDoOnce:Bool = false; // only do one successful trade per turn.
	
	/******************************
	* when you are ready to trade, click this trade proposal button.
	*/
	public var _buttonTradeProposal:ButtonUnique;
	public var _buttonResetTradeProposal:ButtonUnique;
	
	public var _stringTradeProposal:String = "";
	public var _stringReplyTradeProposal:String = "";
	
	/******************************
	 * use this for anything.
	 */
	public static var _string:String;
	public static var _string2:String;
	public static var _string3:String;
	
	/******************************
	 * use this int for anything
	 */
	public static var _int:Int;
	
	/******************************
	 * use this float for anything.
	 */
	public static var _float:Float;
	public static var _float2:Float;
	
	/******************************
	 * this holds that total cash value while trading. 0 = yours, sending cash value. 1 = others, getting cash value. player is at trading options. using the plus/minus button to increase the sending and getting cash values. how much the player would like to send and get from other player. 
	 */
	public static var tradingCashValue:Array<Float> = [0, 0];
	
	/******************************
	* close this hx file and end turn.
	*/
	public static var _buttonEndTurnOrPayNow:ButtonUnique;
	
	public static var _tradeProposal:MessageBoxTradeProposal;
	public static var _replyTradeProposal:MessageBoxTradeProposal;
	
	/******************************
	* at SignatureGameReferenceImages.hx these vars are read and if not a value of -1 then then houseTaxiCafe image for that unit will change to its new value _pValue.
	*/
	public static var _houseTaxiCafeAmountY:Array<Int> = [for (p in 0...28) 0];
	
	/******************************
	* at SignatureGameReferenceImages.hx these vars are read and if not a value of -1 then then houseTaxiCafe image for that unit will change to this new value. see also _pValue.
	*/
	public static var _houseTaxiCafeAmountX:Array<Int> = [for (p in 0...28) 0];
	
	/******************************
	* current price of the land the player is at.
	*/
	public static var _priceOfLand:Int = 0;
	
	/******************************
	* unit number. starting at start unit and going counter clockwise. Reg._gameDiceMaximumIndex is used for player's movements while this var is used to trigger a unit for player nobody.
	*/
	public var _p:Int = -1;
	
	/******************************
	 * used with _isInDebt var to display the unit debt image and unit description.
	 */
	public static var _p2 = -1;
	
	/******************************
	* this var handles the price of a house. every additional house added to the land will be house value times this vars element.The second element of this array will be a bit more than double the value of the first house. 
	*/
	public var _houseTaxiCabOrCafeStorePriceMultiplier:Array<Float> = [1.45, 2.1, 3.2, 4.7];
	
	/******************************
	* player _num = service number. the amount of services at land. price = value * unit price.
	*/
	public static var _buyPriceForHouseTaxiCafe:Array<Array<Float>> = 
	[for (p in 0...4) [for (x in 0...48) 0]];
	
	/******************************
	* at unit number, start the element to minus count if not -1 for that mortgage unit number. if not < zero at array element means that there is a mortgage at that unit value. 
	* at the move function, this var array element will minus by the total dice rolled at every turn the player finishes. when mortgage, the default value will be _isMortgageCouldLoseUnitAfterThisValue. when < -1 is reached then the player must pay back or lose the unit.
	*/
	public static var _isMortgage:Array<Array<Float>> = 
	[for (p in 0...4) [for (x in 0...28) -1]];
	
	public static var _isMortgageTitle:Array<Array<String>> = 
	[for (p in 0...4) [for (x in 0...28) ""]];
	
	/******************************
	* when value is not -1 then there is a mortgage. this var holds the price of the mortgage that will be paid to the player, after the player moves so many units.
	*/
	public static var _mortgageLandPrice:Array<Array<Float>> = 
	[for (p in 0...4) [for (x in 0...28) -1]];
	
	/******************************
	* original location of mortgage. _p value.
	*/
	public static var _mortgageLandPriceCurrentUnitIndex:Int = -1;
	
	/******************************
	* original location of mortgage. _gameYYnew2 value.
	*/
	public static var _mortgageLandPriceCurrentUnitY:Int = -1;
	
	/******************************
	* original location of mortgage. _gameXXnew2 value.
	*/
	public static var _mortgageLandPriceCurrentUnitX:Int = -1;
	
	/******************************
	* if unit is in mortgage, each time the player rolls the dice, the move total increases. when that value reaches this vars value then a message box will display, asking if the player should either pay the mortgage or lose the unit.
	*/
	public static var _isMortgageCouldLoseUnitAfterThisValue:Int = 2;
	
	/******************************
	 * is stops the player from ending a turn before a debt is paid.
	 */
	public static var _isInDebt:Bool = false;
	
	/******************************
	 * the total amount of debt that needs to be paid.
	 */
	public static var _totalDebtAmount:Float = 0;
	
	/******************************
	 * add a rent bonus to the current rent of a service. the first element is player. the second element is the units. the rent bonus increases when landing on that unit. the bonus is timed by 50 for the final value.
	 * can only get a rent bonus if you own a building group.
	 */
	public static var _rentBonus:Array<Array<Float>> = 
	[for (p in 0...4) [for (x in 0...28) 0.01]];
	
	public static var _groupBonus:Array<Array<Float>> = 
	[for (p in 0...4) [for (x in 0...28) 0]];
	
	/******************************
	 * used for the buy button to disable it for human when computer turn but after an update() so to center the text on the button.
	 */
	private var _ticks_button:Int = 0;
	
	/******************************
	* this is the title of each unit.
	*/
	public static  var _unitTitlesArray:Array<String> = [
	"Stop Sign #1",
	"Calgary St",
	"Edmonton St",
	"Oshawa St",
	"Taxi Company #1",
	"Cafe #1",
	"End Turn",
	"Road Fork",
	"Taxi Company #2",
	"Saskatoon Ave",
	"Gatineau  Ave",
	"Cafe #2",
	"Guelph Ave",
	"Barrie Ave",
	"End Turn",
	"St. John's St",
	"Toronto St",
	"Cafe #3",
	"Taxi Company #3",
	"End Turn",
	"Kitchener St",
	"Road Fork",
	"Cafe #4",	
	"Taxi Company #4",
	"Hamilton Ave",
	"Lethbridge Ave",
	"Abbotsford Ave",
	"Vancouver Ave",	
	"Stop Sign #2",
	"End Turn",	
	"Painting",
	"End Turn",
	"Fire Damage",
	"Dry Weather",
	"Rent Bonus",
	"Party",
	"Free Space",
	"Stocks Gain",
	"Stocks Loss",
	"Prestige Gain",
	"Damages",
	"End Turn",
	"Free Space",	
	"Taxi Service",
	"A misfortune",	
	"Coins #1",
	"Rent Bonus",
	"End Turn"
	];
	
	/******************************
	*  This is the body of each unit.
	*/
	public static  var _unitBody:Array<String> = [
	"You could have bonus $500.",
	"",
	"",
	"",
	"",
	"",
	"You could lose a game turn.",
	"You could have access to the inner units.",
	"",
	"",
	"",
	"",
	"",
	"",
	"You could lose a game turn.",
	"",
	"",
	"",
	"",
	"You could lose a game turn.",
	"",
	"You could have access to the inner units.",
	"",	
	"",	
	"",
	"",
	"",
	"",
	"You could have bonus $500.",	
	"You could lose a game turn.",	
	"You could get $1oo for each house that you own.",
	"You could lose a game turn.", //"A none opponent's outer unit could be selected. Only one unit can be selected for a player's game turn. Once selected, you can do any choice that the unit permits.",
	"You could have a house, taxi cab or cafe store burn to the ground.",
	"You could pay $100 maintenance for each house, taxi cab or cafe store that you own.",
	"You could increase all your house, taxi cab or cafe store rent by 3%.",
	"You could have a party and receive (30-300) cash.",
	"You could receive (300-500) cash per cafe store you own.",
	"You could have the total cash value, of land you own, increase by 15%.",
	"You could have the total cash value, of land you own, decrease by 15%",
	"You could receive (200-400) cash per taxi cab you own.",
	"You could pay the bug exterminator (500-750) cash.",
	"You could lose a game turn.", //"A none opponent's outer unit could be selected. Only one unit can be selected for a player's game turn. Once selected, you can do any choice that the unit permits.",
	"Under Construction.",
	"You could pay (100-300) worth of food that will be delivered to you.",
	"You could lose 1 to 4 of any house, taxi cab or cafe store that you own and lose 33% of your cash.",
	"You could win (20-1000) at a casino.",
	"You could increase all your house, taxi cab or cafe store rent by 3%.",
	"You could lose a game turn." //"A none opponent's outer unit could be selected. Only one unit can be selected for a player's game turn. Once selected, you can do any choice that the unit permits."
	];
	
	/******************************
	* price of a unit. -1 means price is not needed.
	*/
	public static var _unitBuyingLandPrice:Array<Float> = [
	-1,
	1200,
	1150,
	1100,
	700,
	500,
	-1,
	-1,
	650,
	1050,
	1000,
	450,
	950,
	900,
	-1,
	850,
	800,
	400,
	600,
	-1,
	750,
	-1,
	350,	
	550,	
	700,
	650,
	600,
	550,	
	-1,	
	-1,	
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,
	-1
	];
	
	public function new():Void
	{
		super();			
				
		// TODO delete...
		//RegTypedef._dataPlayers._cash[0] = 30;
		//RegTypedef._dataPlayers._cash[1] = 30;
		// end of delete.			
		
		persistentDraw = true;
		persistentUpdate = true;
		
		_mortgagePrice = 0;
		_mortgageProcessingFee = 500;
		_unitTitleTemp = "";
		_gameYYnew2Temp = -1;
		_gameXXnew2Temp = -1;
		_ticksStartForPayMortgageMessageBox = false;
		_ticksPayMortgage = 0;
		_stringNotEnoughCash = "";
		_displayCardDataOnceAfterDiceRoll = true;
		_dontBuyLandIfCashIsLessThan = 0;
		_pieceAtBoardParameter = [true, true, true, true];
		_sellAllServicesPrice = 0;
		_tradeAnsweredAs = false;
		_tradeSuccessfulDoOnce = false;
		_stringTradeProposal = "";
		_stringReplyTradeProposal = "";
		tradingCashValue = [0, 0];
		_houseTaxiCafeAmountY = [for (p in 0...28) 0];
		_houseTaxiCafeAmountX = [for (p in 0...28) 0];
		_priceOfLand = 0;
		_p = -1;
		_p2 = -1;
		_houseTaxiCabOrCafeStorePriceMultiplier = [1.45, 2.1, 3.2, 4.7];
		_buyPriceForHouseTaxiCafe = [for (p in 0...4) [for (x in 0...48) 0]];
		_isMortgage =	[for (p in 0...4) [for (x in 0...28) -1]];
		_isMortgageTitle = [for (p in 0...4) [for (x in 0...28) ""]];
		_mortgageLandPrice =	[for (p in 0...4) [for (x in 0...28) -1]];
		_mortgageLandPriceCurrentUnitIndex = -1;
		_mortgageLandPriceCurrentUnitY = -1;
		_mortgageLandPriceCurrentUnitX = -1;
		_isMortgageCouldLoseUnitAfterThisValue = 2;
		_isInDebt = false;
		_totalDebtAmount = 0;	
		_rentBonus = [for (p in 0...4) [for (x in 0...28) 0.01]];
		_groupBonus =	[for (p in 0...4) [for (x in 0...28) 0]];

		// this creates the house, cab, store prices with rent bonus.
		houseTaxiCabAndCafeStorePrices(0, _houseTaxiCabOrCafeStorePriceMultiplier[0]);
		houseTaxiCabAndCafeStorePrices(1, _houseTaxiCabOrCafeStorePriceMultiplier[1]);
		houseTaxiCabAndCafeStorePrices(2, _houseTaxiCabOrCafeStorePriceMultiplier[2]);
		houseTaxiCabAndCafeStorePrices(3, _houseTaxiCabOrCafeStorePriceMultiplier[3]);
		
		//RegTypedef._dataGame4._rentBonus[1] = 5550.70;
		//RegTypedef._dataGame4._rentBonus[0] = 0.70;
		callRentBonusAndBuildingGroups();
	}

	/******************************
	 * the second time entering this class, instead of renewing the class, this options function will be used. 
	 */
	public function options():Void
	{
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
		{
			_dontBuyLandIfCashIsLessThan = FlxG.random.int(1500, 2500);
		}
		else 
		{
			_dontBuyLandIfCashIsLessThan = 0;
		}
		
		RegTriggers._signatureGameUnitImage = true;
		RegTriggers._highlightOnlyOuterUnits = false;
		
		tradingCashValue = [0, 0];
		_tradeAnsweredAs = false;
		_stringTradeProposal = "";
		_stringReplyTradeProposal = "";
		_tradeSuccessfulDoOnce = false;
		_isInDebt = false;
		_stringNotEnoughCash = "";
		_displayCardDataOnceAfterDiceRoll = true;
		_p2 = -1;
		_totalDebtAmount = 0;
		RegTriggers._tradeWasAnswered = false;
		_gameYYnew2Temp = -1;
		_gameXXnew2Temp = -1;
		_ticksStartForPayMortgageMessageBox = false;
		_ticksPayMortgage = 0;
		_mortgagePrice = 0;
		
		// reset vars back to default.
		for (i in 0...28)
		{
			_houseTaxiCafeAmountY[i] = -1;
			_houseTaxiCafeAmountX[i] = -1;
		}
		
		_priceOfLand = 0; // current price of the last player landed on land.
		var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
	
		_houseTaxiCabOrCafeStorePriceMultiplier = [1.5, 2.6, 3.7, 4.8];
		_buyPriceForHouseTaxiCafe = [for (p in 0...4) [for (x in 0...48) 0]];
		_buyPriceForHouseTaxiCafe = [for (p in 0...4) [for (x in 0...48) 0]];
		
		
		// if unit is in mortgage, each time the player rolls the dice, the move total increases. when that value reaches this vars value then a message box will display, asking if the player should either pay the mortgage or lose the unit.
		_isMortgageCouldLoseUnitAfterThisValue = 2;

		// ##################### END OF RESET VARS ##########################
				
		// this creates the house, cab, store prices with rent bonus.
		houseTaxiCabAndCafeStorePrices(0, _houseTaxiCabOrCafeStorePriceMultiplier[0]);
		houseTaxiCabAndCafeStorePrices(1, _houseTaxiCabOrCafeStorePriceMultiplier[1]);
		houseTaxiCabAndCafeStorePrices(2, _houseTaxiCabOrCafeStorePriceMultiplier[2]);
		houseTaxiCabAndCafeStorePrices(3, _houseTaxiCabOrCafeStorePriceMultiplier[3]);
		
		callRentBonusAndBuildingGroups();
		
		RegTriggers._signatureGameUnitImage = false;
		
		if (Reg._gameYYnew2 == 6 && Reg._gameXXnew2 == 0) 
		{
			Reg._gameDiceMaximumIndex[Reg._move_number_next] = 27;
			Reg._gameDiceCurrentIndex[Reg._move_number_next] = 27;
		}
		
		// a square box where the parameter of it covers the under units.
		if (background != null) remove(background);
		background = new FlxSprite(0, (Reg._unitYgameBoardLocation[0]) + 75);
		background.makeGraphic(450, 450, Reg._game_piece_color2[Reg._move_number_current]);
		//background.scrollFactor.set(0, 0);	
		background.screenCenter(X);
		add(background);	
		
		// the background behind the unit's image and unit's text. also, displayed at the header of the background that overlaps the inner units.
		if (_unitBG != null) remove(_unitBG);
		_unitBG = new FlxSprite(0, (Reg._unitYgameBoardLocation[0]) + 100);
		_unitBG.makeGraphic(450, 113, 0xFF002200);
		//_unitBG.scrollFactor.set(0, 0);	
		_unitBG.screenCenter(X);
		add(_unitBG);
		
		// ####################### UNIT IMAGE / TITLE #######################
				
		if (_unitTitle != null) remove(_unitTitle);
		_unitTitle = new FlxText(0, Reg._unitYgameBoardLocation[0] + 178, 0, "", 20);
		_unitTitle.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		
		// this addresses a bug where if player is at one of the "fork in the road, such as _p value of 8/unit 7, the SignatureGameInformationCards.hx would populate data from unit 27.
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7
		||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0)
		_unitTitle.text = Std.string( _unitTitlesArray[7]) + ".";		
		
		else _unitTitle.text = Std.string( _unitTitlesArray[Reg._gameDiceMaximumIndex[Reg._move_number_next]]) + ".";			
		
		// this aligns the text to the right side of the _unitBG. 
		_unitTitle.x = (_unitBG.x + (_unitBG.width / 4)) - (_unitTitle.fieldWidth / 2);
		add(_unitTitle);
				
		// an image of the unit where the player is at. Displayed in front of all background. Positioned at the header background.
		if (_unitImage != null) remove(_unitImage);
		_unitImage = new FlxSprite(0, Reg._unitYgameBoardLocation[0] + 109);
				
		// this addresses a bug where if player is at one of the "fork in the road, such as _p value of 8/unit 7, the SignatureGameInformationCards.hx would populate data from unit 27.
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7
		||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0)
		_unitImage.loadGraphic("assets/images/signatureGame/7.png", false);
		else _unitImage.loadGraphic("assets/images/signatureGame/"+(Reg._gameDiceMaximumIndex[Reg._move_number_next])+".png", false);
		
		// this aligns the image to the right side of the _unitBG. 
		_unitImage.x = _unitTitle.x + (_unitTitle.fieldWidth / 2) - (_unitImage.width / 2);
		//_unitImage.scrollFactor.set(0, 0);	
		add(_unitImage);
		
		// #################### END OF UNIT IMAGE / TITLE ####################
		
		
		
		// #################### UNIT DEBT IMAGE / TITLE ######################
		
		if (_unitTitleDebt != null) remove(_unitTitleDebt);
		_unitTitleDebt = new FlxText(0, Reg._unitYgameBoardLocation[0] + 178, 0, "", 20);
		_unitTitleDebt.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		
		// this addresses a bug where if player is at one of the "fork in the road, such as _p value of 8/unit 7, the SignatureGameInformationCards.hx would populate data from unit 27.
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7
		||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0)
		_unitTitleDebt.text = Std.string( _unitTitlesArray[7]);		
		
		else _unitTitleDebt.text = Std.string( _unitTitlesArray[Reg._gameDiceMaximumIndex[Reg._move_number_next]]);		
		
		// this aligns the text to the right side of the _unitBG. 
		_unitTitleDebt.x = (_unitBG.x + (_unitBG.width / 1.3335)) - (_unitTitleDebt.fieldWidth / 2);
		_unitTitleDebt.visible = false;
		add(_unitTitleDebt);
		
		
		// an image of the unit where the player is at. Displayed in front of all background. Positioned at the header background.
		if (_unitImageDebt != null) remove(_unitImageDebt);
		_unitImageDebt = new FlxSprite(0, Reg._unitYgameBoardLocation[0] + 109);
				
		// this addresses a bug where if player is at one of the "Road Fork", such as _p value of 8/unit 7, the SignatureGameInformationCards.hx would populate data from unit 27.
		if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7
		||  Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0)
		_unitImageDebt.loadGraphic("assets/images/signatureGame/7.png", false);
		else _unitImageDebt.loadGraphic("assets/images/signatureGame/"+(Reg._gameDiceMaximumIndex[Reg._move_number_next])+".png", false);
		
		// this aligns the image to the right side of the _unitBG. 
		_unitImageDebt.x = _unitTitleDebt.x + (_unitTitleDebt.fieldWidth / 2) - (_unitImageDebt.width / 2);
		//_unitImageDebt.scrollFactor.set(0, 0);
		_unitImageDebt.visible = false;
		add(_unitImageDebt);
		
		// ################## END OF UNIT DEBT IMAGE / TITLE #################
		
		
		
		
		
		
		if (_textGeneralMessage != null) remove(_textGeneralMessage);
		_textGeneralMessage = new FlxText(Reg._unitXgameBoardLocation[0] + 90, Reg._unitYgameBoardLocation[0] + 230, 0, "", 20);
		_textGeneralMessage.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_textGeneralMessage.scrollFactor.set(0, 0);
		_textGeneralMessage.fieldWidth = 404;
		add(_textGeneralMessage);
		
		if (_textGeneralMessage2 != null) remove(_textGeneralMessage2);
		_textGeneralMessage2 = new FlxText(Reg._unitXgameBoardLocation[0] + 90, Reg._unitYgameBoardLocation[0] + 80, 0, "", Reg._font_size);
		_textGeneralMessage2.setFormat(Reg._fontDefault, (Reg._font_size-3), FlxColor.WHITE);
		//_textGeneralMessage2.scrollFactor.set(0, 0);
		_textGeneralMessage2.fieldWidth = 416;
		add(_textGeneralMessage2);
				
		
		if (_buttonSellHouse != null) remove(_buttonSellHouse);
		_buttonSellHouse = new ButtonUnique((FlxG.width / 2) - 160 - 33, FlxG.height - 257 - 45 - 45, "", 180, 35, Reg._font_size, 0xFFCCFF33, 0, sellAllHousesForLand);
		_buttonSellHouse.label.text = "Sell All";			
		_buttonSellHouse.label.font = Reg._fontDefault;
		_buttonSellHouse.visible = false;
		_buttonSellHouse.active = false;
		add(_buttonSellHouse);
		
		if (_buttonBuyMortgage != null) remove(_buttonBuyMortgage);
		_buttonBuyMortgage = new ButtonUnique((FlxG.width / 2) + 13, FlxG.height - 257 - 45 - 45, "Mortgage", 180, 35, Reg._font_size, 0xFFCCFF33, 0, getMortgage);
		_buttonBuyMortgage.label.font = Reg._fontDefault;
		_buttonBuyMortgage.visible = false;
		_buttonBuyMortgage.active = false;
		add(_buttonBuyMortgage);
		
		if (_buttonBuyHouseTaxiCabOrCafeStores != null)
			remove(_buttonBuyHouseTaxiCabOrCafeStores);
		
		// at options menu. this is the buy house, cab or store.
		_buttonBuyHouseTaxiCabOrCafeStores = new ButtonUnique((FlxG.width / 2) - 160 - 33, FlxG.height - 257 - 45, "", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buyHouseTaxiCabOrCafeStore);
		_buttonBuyHouseTaxiCabOrCafeStores.label.font = Reg._fontDefault;
		_buttonBuyHouseTaxiCabOrCafeStores.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStores.active = false;
		
			if (_p == 4 || _p == 8 || _p == 18 || _p == 23) 
			_buttonBuyHouseTaxiCabOrCafeStores.label.text = "Buy Taxi Cabs";		
			else if (_p == 5 || _p == 11 || _p == 17 || _p == 22) 
			_buttonBuyHouseTaxiCabOrCafeStores.label.text = "Buy Cafe store";			
			else _buttonBuyHouseTaxiCabOrCafeStores.label.text = "Buy House";
			
		add(_buttonBuyHouseTaxiCabOrCafeStores);
		
		if (_tradeWith != null) remove(_tradeWith);
		_tradeWith = new ButtonUnique((FlxG.width / 2) + 13, FlxG.height - 257 - 45, "Trade with", 180, 35, Reg._font_size, 0xFFCCFF33, 0, tradeSelectPlayer);
		_tradeWith.label.font = Reg._fontDefault;
		_tradeWith.visible = false;
		_tradeWith.active = false;
		add(_tradeWith);		
		
		optionsTrade();
		
		// #############################################################
		
		if (_buttonGoBack != null) remove(_buttonGoBack);
		_buttonGoBack = new ButtonUnique((FlxG.width / 2) - 190 - 15, FlxG.height - 257, "Go Back", 190, 35, Reg._font_size, 0xFFCCFF33, 0, buttonGoBackOK);
		_buttonGoBack.label.font = Reg._fontDefault;
		_buttonGoBack.screenCenter(X);
		_buttonGoBack.visible = false;
		_buttonGoBack.active = false;
		add(_buttonGoBack);
		
		_buttonEndTurnOrPayNow = new ButtonUnique(0, FlxG.height - 257, "End turn", 190, 35, Reg._font_size, 0xFFCCFF33, 0, buttonOK);
		_buttonEndTurnOrPayNow.label.font = Reg._fontDefault;
		_buttonEndTurnOrPayNow.screenCenter(X);		
		add(_buttonEndTurnOrPayNow);
		
		// ########################################################
		
		// buy first house, first cab or first store.
		if (_buttonBuyHouseTaxiCabOrCafeStore1 != null) remove(_buttonBuyHouseTaxiCabOrCafeStore1);
		_buttonBuyHouseTaxiCabOrCafeStore1 = new ButtonUnique((FlxG.width / 2) - 190 - 13, Reg._unitYgameBoardLocation[0] + 230 + 45, "", 405, 35, Reg._font_size, 0xFFCCFF33, 0, boughtHouseTaxiCabOrCafeStore.bind(0));
		_buttonBuyHouseTaxiCabOrCafeStore1.label.font = Reg._fontDefault;
		_buttonBuyHouseTaxiCabOrCafeStore1.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore1.active = false;
		_buttonBuyHouseTaxiCabOrCafeStore1.screenCenter(X);
		_buttonBuyHouseTaxiCabOrCafeStore1.label.text = setHouseTaxiCabCafeStoreTextFromP(_p, "One", "", 0);
		add(_buttonBuyHouseTaxiCabOrCafeStore1);
				
		if (_buttonBuyHouseTaxiCabOrCafeStore2 != null) remove(_buttonBuyHouseTaxiCabOrCafeStore2);
		_buttonBuyHouseTaxiCabOrCafeStore2 = new ButtonUnique((FlxG.width / 2) - 190 - 13, Reg._unitYgameBoardLocation[0] + 230 + 45, "", 405, 35, Reg._font_size, 0xFFCCFF33, 0, boughtHouseTaxiCabOrCafeStore.bind(1));
		_buttonBuyHouseTaxiCabOrCafeStore2.label.font = Reg._fontDefault;
		_buttonBuyHouseTaxiCabOrCafeStore2.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore2.active = false;
		_buttonBuyHouseTaxiCabOrCafeStore2.screenCenter(X);
		_buttonBuyHouseTaxiCabOrCafeStore2.label.text = setHouseTaxiCabCafeStoreTextFromP(_p, "Two", "s", 1);
		add(_buttonBuyHouseTaxiCabOrCafeStore2);
				
		if (_buttonBuyHouseTaxiCabOrCafeStore3 != null) remove(_buttonBuyHouseTaxiCabOrCafeStore3);
		_buttonBuyHouseTaxiCabOrCafeStore3 = new ButtonUnique((FlxG.width / 2) - 190 - 13, Reg._unitYgameBoardLocation[0] + 230 + 45 + 45, "", 405, 35, Reg._font_size, 0xFFCCFF33, 0, boughtHouseTaxiCabOrCafeStore.bind(2));
		_buttonBuyHouseTaxiCabOrCafeStore3.label.font = Reg._fontDefault;
		_buttonBuyHouseTaxiCabOrCafeStore3.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore3.active = false;
		_buttonBuyHouseTaxiCabOrCafeStore3.screenCenter(X);
		_buttonBuyHouseTaxiCabOrCafeStore3.label.text = setHouseTaxiCabCafeStoreTextFromP(_p, "Three", "s", 2);
		add(_buttonBuyHouseTaxiCabOrCafeStore3);
		
		if (_buttonBuyHouseTaxiCabOrCafeStore4 != null) remove(_buttonBuyHouseTaxiCabOrCafeStore4);
		_buttonBuyHouseTaxiCabOrCafeStore4 = new ButtonUnique((FlxG.width / 2) - 190 - 13, Reg._unitYgameBoardLocation[0] + 230 + 45 + 45, "", 405, 35, Reg._font_size, 0xFFCCFF33, 0, boughtHouseTaxiCabOrCafeStore.bind(3));
		_buttonBuyHouseTaxiCabOrCafeStore4.label.font = Reg._fontDefault;
		_buttonBuyHouseTaxiCabOrCafeStore4.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore4.active = false;	
		_buttonBuyHouseTaxiCabOrCafeStore4.screenCenter(X);
		_buttonBuyHouseTaxiCabOrCafeStore4.label.text = setHouseTaxiCabCafeStoreTextFromP(_p, "Four", "s", 3);
		add(_buttonBuyHouseTaxiCabOrCafeStore4);
		
		var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];

		// none land units
		if (Reg._gameUndevelopedValueOfUnit[_p] == 0 && _p == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7 && SignatureGameMain._buyPriceForHouseTaxiCafe[0][Reg._gameDiceMaximumIndex[Reg._move_number_next]] != -1
		||  Reg._gameUndevelopedValueOfUnit[_p] == 0 && _p == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0 && SignatureGameMain._buyPriceForHouseTaxiCafe[0][Reg._gameDiceMaximumIndex[Reg._move_number_next]] != -1
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] > 27
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 0
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 6
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 7
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 14
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 19
		|| Reg._gameDiceMaximumIndex[Reg._move_number_next] == 21)
		{
		
			SignatureGameInnerUnitsEvents.unitActionsForPlayer(_p); // buy, sell, inner unit actions (pay, burn house, etc. unit _buyPriceForHouseTaxiCafe with a value greater than -1 is a land that can be sold, or purchased etc. a unit with a value of -1, a player can do other things, such as rent increase or cash gain.
		}
		
		else
		{
			// buy land, pay rend or display the options menu. ##########################
			if (Reg._gameYYnew2 != -1 && Reg._gameXXnew2 != -1)
			{
				_p = Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1;
			
				// can player buy unit. if p value of _unitBuyingLandPrice has a greater than > 0, and Reg._gameUniqueValueForPiece has a value of 0, meaning nobody owns it, then player can buy unit.
				if (_unitBuyingLandPrice[_p] > 0 && Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] == 0) buyLand(_p);
				
				else if (_unitBuyingLandPrice[_p] > 0 
				&&  Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] != (Reg._move_number_next + 1))
				payRent(_p);
				
				else
				{
					showOptionButtons();	
				}
			}
		}
		
		Reg._gameMovePiece = false;
		
			
		var _stop:Bool = false;
		
		for (i in 0...28)
		{			
			// ask for mortgage after these many unit moves. before the || code, the mortgage will be payable if the unit in mortgage is less than the unit that will ask for payment, while the code after the || will ask if the unit in mortgage, is for example, unit 26 and player rolled a 5, that unit to move to will be lower than the unit in mortgage. that code handles higher to lower data.
			if (_isMortgage[Reg._move_number_next][i]
			>= _isMortgageCouldLoseUnitAfterThisValue 
			+ _isMortgageCouldLoseUnitAfterThisValue
			&& _mortgageLandPrice[Reg._move_number_next][i] > -1
			&& Reg._gameDiceMaximumIndex[Reg._move_number_next] > i
			|| _isMortgage[Reg._move_number_next][i] 
			>= _isMortgageCouldLoseUnitAfterThisValue
			+ _isMortgageCouldLoseUnitAfterThisValue
			&& _mortgageLandPrice[Reg._move_number_next][i] > -1
			&& Reg._gameDiceMaximumIndex[Reg._move_number_next] <= i) 
			{
				// lower unit in mortgage then payment unit. unit that will ask for payment has a higher unit number..
				if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > i)
				{
					_isMortgage[Reg._move_number_next][i] -= Reg._gameDiceCurrentIndex[Reg._move_number_next];
				}
				// higher unit in mortgage then payment unit. unit that will ask for payment has a lower unit number..
				else
				{
					_isMortgage[Reg._move_number_next][i] = Reg._gameDiceCurrentIndex[Reg._move_number_next] + 28 + _isMortgage[Reg._move_number_next][i];
				}
				
				for (y in 0...8)
				{
					for (x in 0...8)
					{
						if (Reg._gamePointValueForPiece[y][x] - 1 == i)
						{
							// y and x refer to Reg._gameYYnew2 and Reg._gameXXnew2. pass these to this function so that we later know where the original location of the land in mortgage is.
							payMortgage(_unitTitlesArray[i], i, y, x); 
							
							_stop = true;
						}
						if (_stop == true) break;
					}
					if (_stop == true) break;
				}	
				if (_stop == true) break;
			}
			if (_stop == true) break;
			
		}
		
		_stop = false;
		
		// a square box where the parameter of it covers the under units. in computer game, this background hides the buttons at center of screen when player is replying to trade.
		// a square box where the parameter of it covers the under units.
		if (background2 != null) remove(background2);
		background2 = new FlxSprite(0, (Reg._unitYgameBoardLocation[0]) + 75);
		background2.makeGraphic(450, 450, Reg._game_piece_color2[Reg._move_number_current]);
		//background2.scrollFactor.set(0, 0);	
		background2.screenCenter(X);
		background2.visible = false;
		add(background2); // THIS MUST BE THE SECOND LAST IN FUNCTION.
		
		if (_textGeneralMessage3 != null) remove(_textGeneralMessage3);
		_textGeneralMessage3 = new FlxText(Reg._unitXgameBoardLocation[0] + 90, Reg._unitYgameBoardLocation[0] + 100, 0, "", 20);
		_textGeneralMessage3.setFormat(Reg._fontDefault, 20, FlxColor.WHITE);
		//_textGeneralMessage3.scrollFactor.set(0, 0);
		_textGeneralMessage3.fieldWidth = 416;
		add(_textGeneralMessage3);
	}
	
	public function optionsTrade():Void
	{		
		
		if (_buttonResetTradeProposal != null) remove(_buttonResetTradeProposal);
		_buttonResetTradeProposal = new ButtonUnique((FlxG.width / 2) - 190 - 7, FlxG.height - 257 - 45, "Reset Trade", 190, 35, Reg._font_size, 0xFFCCFF33, 0, buttonResetTradeProposal);
		_buttonResetTradeProposal.label.font = Reg._fontDefault;
		_buttonResetTradeProposal.visible = false;
		_buttonResetTradeProposal.active = false;
		add(_buttonResetTradeProposal);
		
		if (_buttonTradeProposal != null) remove(_buttonTradeProposal);
		_buttonTradeProposal = new ButtonUnique((FlxG.width / 2) + 7, FlxG.height - 257 - 45, "Trade", 190, 35, Reg._font_size, 0xFFCCFF33, 0, buttonTradeProposal);
		_buttonTradeProposal.label.font = Reg._fontDefault;
		_buttonTradeProposal.visible = false;
		_buttonTradeProposal.active = false;
		add(_buttonTradeProposal);
		
		if (_tradingYourBG != null) remove(_tradingYourBG);
		_tradingYourBG = new FlxSprite(0, (Reg._unitYgameBoardLocation[0] + 130) + 35);
		_tradingYourBG.makeGraphic(450, 107, 0xFF002222);
		//_tradingYourBG.scrollFactor.set(0, 0);
		_tradingYourBG.visible = false;
		_tradingYourBG.screenCenter(X);
		add(_tradingYourBG);
		
		if (_unitYoursButton != null) remove(_unitYoursButton);
		_unitYoursButton = new ButtonToggleSignatureGame(Reg._unitXgameBoardLocation[0] + 198, (Reg._unitYgameBoardLocation[0] + 140) + 35, 1, "Yours", 87, 87, 16, 0xFFCCFF33, 0, buttonUnitYours);
		_unitYoursButton.label.font = Reg._fontDefault;
		_unitYoursButton.has_toggle = false;
		_unitYoursButton.set_toggled(false);
		_unitYoursButton.visible = false;
		_unitYoursButton.active = false;
		add(_unitYoursButton);
		
		if (_unitYoursImage != null) remove(_unitYoursImage);
		_unitYoursImage = new FlxSprite(Reg._unitXgameBoardLocation[0] + 209, (Reg._unitYgameBoardLocation[0] + 151) + 35, "assets/images/signatureGame/empty.png");
		//_unitYoursImage.scrollFactor.set(0, 0);	
		add(_unitYoursImage);
		
		if (_unitYoursText != null) remove(_unitYoursText);
		_unitYoursText = new FlxText(Reg._unitXgameBoardLocation[0] + 105, (Reg._unitYgameBoardLocation[0] + 140) + 48, 0, "", Reg._font_size);
		_unitYoursText.fieldWidth = 100;
		_unitYoursText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_unitYoursText.scrollFactor.set(0, 0);
		_unitYoursText.visible = false;
		add(_unitYoursText);
		
		if (_cashSendText != null) remove(_cashSendText);
		_cashSendText = new FlxText(Reg._unitXgameBoardLocation[0] + 320, (Reg._unitYgameBoardLocation[0] + 135) + 70, 0, "Send", Reg._font_size);
		_cashSendText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_cashSendText.scrollFactor.set(0, 0);
		_cashSendText.visible = false;
		add(_cashSendText);
				
		if (_cashMinus500YoursButton != null) remove(_cashMinus500YoursButton);
		_cashMinus500YoursButton = new ButtonUnique(Reg._unitXgameBoardLocation[0] + 406, (Reg._unitYgameBoardLocation[0] + 140) + 43, "-", 45, 35, Reg._font_size, 0xFFCCFF33, 0, cashMinus500Yours);		
		_cashMinus500YoursButton.label.font = Reg._fontDefault;
		_cashMinus500YoursButton.label.bold = true;
		_cashMinus500YoursButton.visible = false;
		_cashMinus500YoursButton.active = false;
		add(_cashMinus500YoursButton);
		
		if (_cashPlus500YoursButton != null) remove(_cashPlus500YoursButton);
		_cashPlus500YoursButton = new ButtonUnique(Reg._unitXgameBoardLocation[0] + 461, (Reg._unitYgameBoardLocation[0] + 140) + 43, "+", 45, 35, Reg._font_size, 0xFFCCFF33, 0, cashPlus500Yours);		
		_cashPlus500YoursButton.label.font = Reg._fontDefault;	
		_cashPlus500YoursButton.label.bold = true;
		_cashPlus500YoursButton.visible = false;
		_cashPlus500YoursButton.active = false;
		add(_cashPlus500YoursButton);
		
		if (_cashValueYoursText != null) remove(_cashValueYoursText);
		_cashValueYoursText = new FlxText(Reg._unitXgameBoardLocation[0] + 406, (Reg._unitYgameBoardLocation[0] + 232), 0, "$0", 20);
		_cashValueYoursText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_cashValueYoursText.scrollFactor.set(0, 0);
		_cashValueYoursText.visible = false;
		add(_cashValueYoursText);
		
		// ------------------------------------ other player.
		
		if (_tradingOtherBG != null) remove(_tradingOtherBG);
		_tradingOtherBG = new FlxSprite(0, (Reg._unitYgameBoardLocation[0] + 253) + 35);
		_tradingOtherBG.makeGraphic(450, 107, 0xFF002222);
		//_tradingOtherBG.scrollFactor.set(0, 0);	
		_tradingOtherBG.visible = false;
		_tradingOtherBG.screenCenter(X);
		add(_tradingOtherBG);
		
		if (_unitOthersButton != null) remove(_unitOthersButton);
		_unitOthersButton = new ButtonToggleSignatureGame(Reg._unitXgameBoardLocation[0] + 198, (Reg._unitYgameBoardLocation[0] + 263) + 35, 2, "Other", 87, 87, 16, 0xFFCCFF33, 0, buttonUnitOthers);
		_unitOthersButton.label.font = Reg._fontDefault;
		_unitOthersButton.has_toggle = false;
		_unitOthersButton.set_toggled(false);
		_unitOthersButton.visible = false;
		_unitOthersButton.active = false;
		add(_unitOthersButton);
		
		if (_unitOthersImage != null) remove(_unitOthersImage);
		_unitOthersImage = new FlxSprite(Reg._unitXgameBoardLocation[0] + 209, (Reg._unitYgameBoardLocation[0] + 274) + 35, "assets/images/signatureGame/empty.png");
		//_unitOthersImage.scrollFactor.set(0, 0);	
		add(_unitOthersImage);
		
		if (_unitOthersText != null) remove(_unitOthersText);
		_unitOthersText = new FlxText(Reg._unitXgameBoardLocation[0] + 105, (Reg._unitYgameBoardLocation[0] + 263) + 48, 0, "", 20);
		_unitOthersText.fieldWidth = 100;
		_unitOthersText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_unitOthersText.scrollFactor.set(0, 0);
		_unitOthersText.visible = false;
		add(_unitOthersText);
		
		if (_cashGetText != null) remove(_cashGetText);
		_cashGetText = new FlxText(Reg._unitXgameBoardLocation[0] + 320, (Reg._unitYgameBoardLocation[0] + 258) + 70, 0, "Get", Reg._font_size);
		_cashGetText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_cashGetText.scrollFactor.set(0, 0);
		_cashGetText.visible = false;
		add(_cashGetText);
		
		if (_cashMinus500OthersButton != null) remove(_cashMinus500OthersButton);
		_cashMinus500OthersButton = new ButtonUnique(Reg._unitXgameBoardLocation[0] + 406, (Reg._unitYgameBoardLocation[0] + 263) + 43, "-", 45, 35, Reg._font_size, 0xFFCCFF33, 0, cashMinus500Others);		
		_cashMinus500OthersButton.label.font = Reg._fontDefault;
		_cashMinus500OthersButton.label.bold = true;
		_cashMinus500OthersButton.visible = false;
		_cashMinus500OthersButton.active = false;
		add(_cashMinus500OthersButton);
		
		if (_cashPlus500OthersButton != null) remove(_cashPlus500OthersButton);
		_cashPlus500OthersButton = new ButtonUnique(Reg._unitXgameBoardLocation[0] + 461, (Reg._unitYgameBoardLocation[0] + 263) + 43, "+", 45, 35, Reg._font_size, 0xFFCCFF33, 0, cashPlus500Others);		
		_cashPlus500OthersButton.label.font = Reg._fontDefault;	
		_cashPlus500OthersButton.label.bold = true;
		_cashPlus500OthersButton.visible = false;
		_cashPlus500OthersButton.active = false;
		add(_cashPlus500OthersButton);
		
		if (_cashValueOthersText != null) remove(_cashValueOthersText);
		_cashValueOthersText = new FlxText(Reg._unitXgameBoardLocation[0] + 406, (Reg._unitYgameBoardLocation[0] + 355), 0, "$0", 20);
		_cashValueOthersText.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		//_cashValueOthersText.scrollFactor.set(0, 0);
		_cashValueOthersText.visible = false;
		add(_cashValueOthersText);
		
	}
		
	/******************************
	 * gets a random value for the computer. to get its value, use var = this function().
	 */
	private function CPUgetRandomValue():Float
	{
		// set random tick value for next computer turn.		
		return FlxG.random.float(20, 90);
	}
	
	/******************************
	* _p			unit number.
	* _amount		how many.
	* _plural		for example, used to display "houses", instead of "house".
	* _value		price of house/service.
	*/
	public function setHouseTaxiCabCafeStoreTextFromP(_p:Int, _amount:String, _plural:String = "", _value:Int = 0):String
	{
		var _str:String = "";
		_value = Std.int(Math.fround(_buyPriceForHouseTaxiCafe[_value][Reg._gameDiceMaximumIndex[Reg._move_number_next]]));
		
		if (_p == 4 || _p == 8 || _p == 18 || _p == 23) 
		_str = _amount + " taxi cab"+ _plural +", $"+ _value;
		
		else if (_p == 5 || _p == 11 || _p == 17 || _p == 22) 
		_str = _amount + " cafe store"+ _plural +", $"+ _value;
		
		else _str = _amount + " house"+ _plural +", $"+ _value;

		return _str;
	}
	
	public static function giveRentBonus():Void
	{
		if (RegTypedef._dataGame4._rentBonus[Reg._move_number_next] + 0.03 > 0.50)
		{
			_textGeneralMessage.text = "Your rent/service bonus is at its maximum. You cannot increase your rent bonus.";
		}
		
		else
		{
			// if player does not own a group, display a message that rent bonus will not be given to player.
			if (_groupBonus[Reg._move_number_next][1] == 0
			&& _groupBonus[Reg._move_number_next][9]  == 0
			&& _groupBonus[Reg._move_number_next][12] == 0
			&& _groupBonus[Reg._move_number_next][15] == 0
			&& _groupBonus[Reg._move_number_next][20] == 0
			&& _groupBonus[Reg._move_number_next][24] == 0
			)
			{
				_textGeneralMessage.text = "Could not give you a rent bonus because you do not own a building group.";
			}
			else
			{
				_textGeneralMessage.text = "You increased all rent/service bonus at all units by 3%.";
				
				// the default value cannot start at zero or else there will be a game crash. so at the rent bonus, take away the first value to make the value correct.
				if (RegTypedef._dataGame4._rentBonus[Reg._move_number_next] == 0.01)
				{
					RegTypedef._dataGame4._rentBonus[Reg._move_number_next] = 0.03;
				}
				else
				{
					RegTypedef._dataGame4._rentBonus[Reg._move_number_next] += 0.03;
				}
				_textGeneralMessage.text += "Your rent bonus is now " +RegTypedef._dataGame4._rentBonus[Reg._move_number_next] + ".";
				
				callRentBonusAndBuildingGroups();
			}	
		}
	}
	
	public static function callRentBonusAndBuildingGroups():Void
	{
		SignatureGameServicesCircleImages.setRentBonusAndBuildingGroups(0);
		SignatureGameServicesCircleImages.setRentBonusAndBuildingGroups(1);
		SignatureGameServicesCircleImages.setRentBonusAndBuildingGroups(2);
		SignatureGameServicesCircleImages.setRentBonusAndBuildingGroups(3);
	}
	
	override public function update(elapsed:Float):Void 
	{
		// computer is moving and a pay message box is open. this delays the box from closing.
		if (_ticksStartForPayMortgageMessageBox == true)
		{
			_ticksPayMortgage = RegFunctions.incrementTicks(_ticksPayMortgage, 60 / Reg._framerate);
			if (_ticksPayMortgage >= 100) _ticksPayMortgage = 0;		
			if (_ticksPayMortgage == 0) 
			{
				// if can pay the mortgage.
				if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _mortgageLandPrice[Reg._move_number_next][_mortgageLandPriceCurrentUnitIndex] >= 0)
				{
					Reg._yesNoKeyPressValueAtMessage = 1;
				}
				
				else
				{
					Reg._yesNoKeyPressValueAtMessage = 2;
				}				
				
				_ticksStartForPayMortgageMessageBox = false;
			}
		}
		
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		// a not enough cash was triggered at SignatureGameInnerUnitsEvents class. this code block changes the end turn button into a pay now. player needs to select a unit where the cash can be taken from. so some vars are set to make those units mouse clickable. 
		if (RegTriggers._notEnoughCash == true)
		{
			RegTriggers._notEnoughCash = false;			
			
			_isInDebt = true;
			_buttonEndTurnOrPayNow.label.text = "Pay Now"; // this stops the end turn event. now player can only end turn after clicking this button when player has enough cash to pay the debt.
			
			RegTriggers._highlightOnlyOuterUnits = true;
			RegTriggers._signatureGameUnitImage = true;
			
			// this is the message what will be displayed when the player does not have enough cash to pay the debt and the player mouse clicks the "Pay Now" button.
			_stringNotEnoughCash = Std.string( SignatureGameMain._unitTitlesArray[Reg._gameDiceMaximumIndex[Reg._move_number_next]]);
			
		}
		
		// _displayDebtStuff is set to true when _isInDebt is true at SignatureGameInnerUnitsEvents.hx. this code block displays the buttons needed to take the player out of debt but only if the total cash value for that player is less than the debt to be paid.
		if (RegTriggers._signatureGameUnitImage == true 
		&& 	RegTriggers._highlightOnlyOuterUnits == true
		&&  RegTriggers._displayDebtStuff == true)
		{
			RegTriggers._displayDebtStuff = false;
			
			// enter loop only if the total cash for that player is less then the debt needed to be paid.
			if (Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] - 1 == Reg._move_number_current && RegTypedef._dataPlayers._cash[Reg._move_number_current] < _totalDebtAmount)
			{
				_buttonSellHouse.active = true;
				_buttonSellHouse.visible = true;
				
				_buttonBuyMortgage.active = true;
				_buttonBuyMortgage.visible = true;
				
				shouldEndNowButtonBeActive();
				
				// displays the unit that might be able to take the player out of debt, at the right side of the background header.
				_unitImageDebt.loadGraphic("assets/images/signatureGame/"+_p2+".png", false);
				_unitImageDebt.visible = true;
				
				_unitTitleDebt.text = Std.string( _unitTitlesArray[_p2]);
				_unitTitleDebt.x = (_unitBG.x + (_unitBG.width / 1.3335)) - (_unitTitleDebt.fieldWidth / 2);
				_unitTitleDebt.visible = true;
			}
			
			else
			{
				// if here, then player is able to pay debt.
				_buttonSellHouse.visible = false;
				_buttonSellHouse.active = false;
				
				_buttonBuyMortgage.visible = false;
				_buttonBuyMortgage.active = false;
				
			}
		}
		
		// make sure that player's cash does not go into a negative value.
		if (RegTypedef._dataPlayers._cash[Reg._move_number_next] < 0)
			RegTypedef._dataPlayers._cash[Reg._move_number_next] = 0;
		
		// must make this null so that the check for is null can be correctly done. without this code the check for if (!= null) can have the correct outcome.
		if (RegTriggers._tradeProposalOffer == true && _replyTradeProposal == null)
		{
			if (Reg._game_offline_vs_cpu == true) buttonsTradeInactive();
		
			RegTriggers._signatureGameUnitImage = true;
			RegTriggers._highlightOnlyOuterUnits = true;
		
			if (_replyTradeProposal != null)
			{
				remove(_replyTradeProposal);
				_replyTradeProposal = null; // must make this null so that the check for is null can be correctly done. without this code the check for if (!= null) can have the correct outcome.
			}
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0) _replyTradeProposal = new MessageBoxTradeProposal("Yes", "No", false, true);
			else _replyTradeProposal = new MessageBoxTradeProposal("Yes", "No", true);
			
			add(_replyTradeProposal);
			_replyTradeProposal.createMessage(2, 2, true, true, true);

			_replyTradeProposal.display("Trade Proposal.", RegTypedef._dataGameMessage._gameMessage);
			_replyTradeProposal.popupMessageShow(); 
			
			if (Reg._game_offline_vs_cpu == true)
			{
				_unitYoursButton.set_toggled(false);
				_unitOthersButton.set_toggled(false);
				
				_unitYoursButton.active = false;
				_unitOthersButton.active = false;
			}
			
		}
		
		// finish the trade request. the other player has replied to the trade request. change the unit and cash values for the players.
		if (RegTriggers._tradeWasAnswered == true && _tradeSuccessfulDoOnce == false)
		{
			background2.visible = false;
			_textGeneralMessage3.visible = false;
			
			//buttonsTradeActive();
			
			
			_tradeSuccessfulDoOnce = true;

			_buttonTradeProposal.visible = false;
			_buttonTradeProposal.active = false;
			
			_buttonGoBack.visible = false;
			_buttonGoBack.active = false;
			
			_buttonResetTradeProposal.visible = false;
			_buttonResetTradeProposal.active = false;
	
			buttonsTradeInactive();

			// this function changes ownership of yours and other player's units.
			if (_tradeAnsweredAs == true) finishTradeingUnits();	
			
			shouldEndNowButtonBeActive();
			
			
		}
		
		super.update(elapsed);
	}	
	
	private function shouldEndNowButtonBeActive():Void
	{
		if (_buttonEndTurnOrPayNow != null)
		{
			_buttonEndTurnOrPayNow.active = true;
			_buttonEndTurnOrPayNow.visible = true;
		}
	}
	
	private function tradeWhosTurnToMove():Void
	{
		// set the player number to the player that the trade request was sent to.
		var _count:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] == RegTypedef._dataGameMessage._userTo)
			{
				_count = i;
			}
		}
		
		Reg._move_number_next = _count;
		Reg._move_number_current = _count;
		
	}
	
		
	public static function finishTradeingUnits():Void
	{
		// your player. find your player's turn location. for example. if your player is second, third or forth in turn to move piece. this is needed to get the player's cash location.
		var _yours:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] == RegTypedef._dataGameMessage._userTo)
			{
				// get cash from other player, if any.
				RegTypedef._dataPlayers._cash[i] += tradingCashValue[1];
				_yours = i;
				
				break;
			}
		}
		
		// the other player. find the player's turn location. for example, if the player is second, third or forth in turn to move piece. this is needed to get the player's cash location.
		var _other:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] == RegTypedef._dataGameMessage._userFrom)
			{
				RegTypedef._dataPlayers._cash[i] += tradingCashValue[0];
				_other = i;
				
				break;
			}
		}
		
		// remember to take away any cash if any.
		RegTypedef._dataPlayers._cash[_yours] -= tradingCashValue[0];
		RegTypedef._dataPlayers._cash[_other] -= tradingCashValue[1];
		
		// change others ownership to you,
		if (Reg._signatureGameUnitNumberTrade[1] > 0)
		{					
			if (Reg._gameYYold2 != -1) Reg._gameUniqueValueForPiece[Reg._gameYYold2][Reg._gameXXold2] = (_yours + 1);
			else Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = (_yours + 1);
		}	
		
		// change your ownership to others,
		if (Reg._signatureGameUnitNumberTrade[0] > 0)
		{
			if (Reg._gameYYnew2 != -1) Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = (_other + 1);
			
		}
	}
	
	/******************************
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	private function buttonCodeValues():Void
	{
		// buying land.
		if (Reg._yesNoKeyPressValueAtMessage == 1 
		&& Reg._buttonCodeValues == "s1000" 
		)
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			// check if player has enough cash to buy land.
			if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _unitBuyingLandPrice[_priceOfLand] < _dontBuyLandIfCashIsLessThan)
			{
				if (_dontBuyLandIfCashIsLessThan <= 0) 
				{
					_stringNotEnoughCash = Std.string( _unitTitlesArray[Reg._gameDiceMaximumIndex[Reg._move_number_next]]);
					buttonOK();
				}
			}
			else 
			{
				// if its the computer turn to move.				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				{
					if (RegTypedef._dataPlayers._cash[Reg._move_number_current] > _dontBuyLandIfCashIsLessThan)
					{
						if (Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0)
						{
							Reg._gameMessage = "Computer bought " + _unitTitle.text + ".";
						}
						
						else
						{
							Reg._gameMessage = "You bought " + _unitTitle.text + ".";
						}
						
						Reg._outputMessage = true;
						
						_textBuyLand.visible = false;
						_textBuyLand.active = false;
						_buttonBuyLand.visible = false;
						_buttonBuyLand.active = false;
					
					}
				}
				
				// player bought land.
				if (Reg._game_offline_vs_cpu == true)
				{
					Std.string(RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _unitBuyingLandPrice[_priceOfLand]);
					
					_textBuyLand.visible = false;
					_textBuyLand.active = false;
					_buttonBuyLand.visible = false;
					_buttonBuyLand.active = false;
				}
				
				// land bought if this button is false. so true then finish the buying data.
				if (_buttonBuyLand.visible == false)
				{
					var _p = RegFunctions.getP(Reg._gameYYnew2, Reg._gameXXnew2);
					Reg._gameUndevelopedValueOfUnit[_p] = 0;
					
					// set this value to the player who bought it, so that unit will be highlighted to match the same colour of the player's piece. so everyone else will know who bought the land.
					Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = Reg._move_number_next + 1;
					
					// at server, this code will be sent to the other player(s), so that all player in that room will have the same data.
					RegTypedef._dataGame4._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = Reg._move_number_next + 1;
				}	
			}
			
		}
		
		// buy land cancelled
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "s1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			_buttonBuyLand.active = true;
			_buttonBuyLand.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonBuyLand.active = false;
		
		}
		
		// not enough cash or no services
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1010")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		
		}
		
		// already mortgaged.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1015")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			_buttonBuyMortgage.visible = false;
			_buttonBuyMortgage.active = false;
		}
		
		// sell all services. yes selected.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1050")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			// get cash for selling the houses.
			RegTypedef._dataPlayers
._cash[Reg._move_number_next] += _sellAllServicesPrice;

			// set services back to nobody.	
			Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[Reg._gameDiceMaximumIndex[Reg._move_number_next]] = 0;
			Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = 0;
			
			// ...this starts at 0. this is needed or else the house, cab or cafe store will not be shown.
			_houseTaxiCafeAmountY[0] = Reg._gameYYnew2;
			_houseTaxiCafeAmountX[0] = Reg._gameXXnew2;
			
			for (p in 1...28)
			{
				_houseTaxiCafeAmountY[p] = 0;
				_houseTaxiCafeAmountX[p] = 0;
			}
			
			showOptionButtons();
		}
		
		// sell all services. no selected.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "s1050")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			showOptionButtons();
		}
		
		// get mortgage.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1020"
		|| Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0
		&& Reg._buttonCodeValues == "s1020")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
			
			// player has already moved, so we need to keep those vars. also, some vars do not work anymore as they have been cleared at the final unit move that the piece did. therefore, get these new vars to use for debt.
			if (_isInDebt == true) 
			{
				_p = _p2;
				
				Reg._gameYYnew2 = RegFunctions.getPfindYY(_p);
				Reg._gameXXnew2 = RegFunctions.getPfindXX(_p);
			}
				
			// if unit is not in mortgage.
			if (_isMortgage[Reg._move_number_next][_p] <= -1 || Reg._game_offline_vs_cpu == true && Reg._move_number_next > 0)
			{
				_isMortgage[Reg._move_number_next][_p] = _isMortgageCouldLoseUnitAfterThisValue; // start the mortgage for this unit.
				_isMortgageTitle[Reg._move_number_next][_p] = _unitTitlesArray[_p]; 
				
				_mortgageLandPrice[Reg._move_number_next][_p] = _mortgagePrice;
				
				Std.string(RegTypedef._dataPlayers._cash[Reg._move_number_next] = RegTypedef._dataPlayers._cash[Reg._move_number_next] + _mortgageLandPrice[Reg._move_number_next][_p] - _mortgageProcessingFee); 
				
				Reg._gameMessage = _unitTitleTemp + " is now mortgaged.";
				Reg._outputMessage = true;
			}	
			
			// this needs to stay outside of "if" condition statement.
			

			_buttonSellHouse.visible = false;
			_buttonSellHouse.active = false;
			
			_buttonBuyMortgage.visible = false;
			_buttonBuyMortgage.active = false;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0)
			{}
			else 
			{
				showOptionButtons();
			}
		}
		
		// get mortgage canceled.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "s1020")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			showOptionButtons();
		}
		
		// pay mortgage. yes.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1030")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _mortgageLandPrice[Reg._move_number_next][_mortgageLandPriceCurrentUnitIndex];
						
			_mortgageLandPrice[Reg._move_number_next][_mortgageLandPriceCurrentUnitIndex] = -1;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0 )
			{}
			else { showOptionButtons(); }
		}
		
		// pay mortgage. no
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "s1030"
		||  Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1035")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			payMortgageNoSelected();	
		}
		
		// player is replying to a trade proposal. yes selected.
		if (Reg._gameId == 4 && Reg._yesNoKeyPressValueAtTrade == 1 && RegTriggers._tradeProposalOffer == true)// && Reg._gameYYold2 != -1 && Reg._gameYYnew2 != -1 && Reg._gameXXold2 != -1 && Reg._gameXXnew2 != -1)
		{
			Reg._yesNoKeyPressValueAtTrade = 0;
			RegTriggers._signatureGameUnitImage = true;
			
			if (Reg._game_offline_vs_cpu == true)
			{
				buttonResetTradeProposal();
				buttonsTradeInactive();
			}
						
			if (Reg._game_offline_vs_cpu == true) buttonsTradeActive();
			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtTrade = 0;
			
			//if (Reg._game_offline_vs_cpu == false || Reg._move_number_current == 0 && SignatureGameAI_CPU._CPUthingsToDo == false)
			RegTriggers._tradeProposalOffer = false;
			
			if (_replyTradeProposal != null)
			{
				remove(_replyTradeProposal);
				_replyTradeProposal = null; // must make this null so that the check for is null can be correctly done. without this code the check for if (!= null) can have the correct outcome.
			}
			
			if (Reg._game_offline_vs_cpu == true) 
			{
				background2.visible = false;
				_textGeneralMessage3.visible = false;
			}
			
			RegTypedef._dataGameMessage._questionAnsweredAs = true;
			
			// send general message that a trade request has been answered.
			Reg._gameMessage = "Trade request accepted.";
			
			if (Reg._game_offline_vs_cpu == true)
			{
				var _temp:String = RegTypedef._dataGameMessage._userTo;
				RegTypedef._dataGameMessage._userTo = RegTypedef._dataGameMessage._userFrom;
				RegTypedef._dataGameMessage._userFrom = _temp;
				
				_tradeAnsweredAs = true;
				RegTriggers._tradeWasAnswered = true;
			}	
			
			else
			{			
				RegTypedef._dataGameMessage._gameMessage = "Trade request accepted.";
				PlayState.clientSocket.send("Game Message Not Sender", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
				PlayState.clientSocket.send("Trade Proposal Answered As", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			} 
			
			Reg._outputMessage = true;
			
			if (Reg._game_offline_vs_cpu == true)
			{
				// set the player number to the player that the trade request was sent to.
				tradeWhosTurnToMove();
			}
		}
		
		// player is replying to a trade proposal. no selected.
		else if (Reg._gameId == 4 && Reg._yesNoKeyPressValueAtTrade == 2 && RegTriggers._tradeProposalOffer == true)// && Reg._gameYYold2 != -1 && Reg._gameYYnew2 != -1 && Reg._gameXXold2 != -1 && Reg._gameXXnew2 != -1)
		{
			
			RegTriggers._signatureGameUnitImage = true;
			
			if (Reg._game_offline_vs_cpu == true)
			{
				buttonResetTradeProposal();
				buttonsTradeInactive();
			}
			
			Reg._yesNoKeyPressValueAtTrade = 0;
			
			if (Reg._game_offline_vs_cpu == true) buttonsTradeActive();
			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtTrade = 0;
			
			//if (Reg._game_offline_vs_cpu == false || Reg._move_number_current == 0 && SignatureGameAI_CPU._CPUthingsToDo == false)
			RegTriggers._tradeProposalOffer = false;
			
			if (_replyTradeProposal != null)
			{
				remove(_replyTradeProposal);
				_replyTradeProposal = null; // must make this null so that the check for is null can be correctly done. without this code the check for if (!= null) can have the correct outcome.
			}
			
			if (Reg._game_offline_vs_cpu == true)
			{
				background2.visible = false;
				_textGeneralMessage3.visible = false;
			}
			
			RegTypedef._dataGameMessage._questionAnsweredAs = false;
			
			// send general message that a trade proposal has been answered.
			Reg._gameMessage = "Trade proposal rejected.";
			
			if (Reg._game_offline_vs_cpu == true)
			{
				var _temp:String = RegTypedef._dataGameMessage._userTo;
				RegTypedef._dataGameMessage._userTo = RegTypedef._dataGameMessage._userFrom;
				RegTypedef._dataGameMessage._userFrom = _temp;
				
				_tradeAnsweredAs = false;
				RegTriggers._tradeWasAnswered = true;
			}	
			
			else
			{			
				RegTypedef._dataGameMessage._gameMessage = "Trade request rejected.";
				PlayState.clientSocket.send("Game Message Not Sender", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				PlayState.clientSocket.send("Trade Proposal Answered As", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			} 
				
			Reg._outputMessage = true;
			
			if (Reg._game_offline_vs_cpu == true)
			{
				// set the player number to the player that the trade request was sent to.
				tradeWhosTurnToMove();
			}
		}
		
		// player is creating a trade proposal. yes selected.
		else if (Reg._gameId == 4 && Reg._yesNoKeyPressValueAtTrade == 1 && RegTriggers._tradeProposalOffer == false)
		{			
			Reg._yesNoKeyPressValueAtTrade = 0;
			Reg._buttonCodeValues = "";

			if (_tradeProposal != null) 
				remove(_tradeProposal);
			
			if (Reg._game_offline_vs_cpu == true) buttonsTradeActive();
			else
			{
				background2.visible = true;	
				
				// get the other player that will receive the message.
				var _str:String = "";
				_str = " You must wait at maximum 30 seconds for " + RegTypedef._dataPlayers._usernamesDynamic[Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1] + " to reply. This trade proposal cannot be cancelled."; 
				
				_textGeneralMessage3.text = _str;
			}
			
			RegTriggers._signatureGameUnitImage = true;
			RegTriggers._highlightOnlyOuterUnits = true;
			
			// user to... TODO usernamesDynamic has an array element total of 4 yet we use Reg.YYold2? we need a trace here to determine what is happening.
			RegTypedef._dataGameMessage._userTo = RegTypedef._dataPlayers._usernamesDynamic[Reg._gameUniqueValueForPiece[Reg._gameYYold2][Reg._gameXXold2] - 1];
				
			// user from...
			RegTypedef._dataGameMessage._userFrom = RegTypedef._dataPlayers._usernamesDynamic[Reg._move_number_next];
			
						
				RegTypedef._dataGameMessage._gameMessage = _stringReplyTradeProposal;
				
			if (Reg._game_offline_vs_cpu == false) 
			{				
				PlayState.clientSocket.send("Trade Proposal Offer", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
					
			else RegTriggers._tradeProposalOffer = true;
			
			// send general message that a trade request has been sent.
			Reg._gameMessage = "Trade request sent to " + RegTypedef._dataGameMessage._userTo;
			
			if (Reg._game_offline_vs_cpu == false)
			{				
				RegTypedef._dataGameMessage._gameMessage = "Trade request from " + RegTypedef._dataGameMessage._userFrom;
				PlayState.clientSocket.send("Game Message Not Sender", RegTypedef._dataGameMessage);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
				RegTriggers._signatureGameUnitImage = false;
				RegTriggers._highlightOnlyOuterUnits = true;
			}
			
			Reg._outputMessage = true;
			
			if (Reg._game_offline_vs_cpu == true)
			{
				tradeWhosTurnToMove();
			}
		}
		
		// player is creating a trade proposal. no selected.
		else if (Reg._gameId == 4 && Reg._yesNoKeyPressValueAtTrade == 2 && RegTriggers._tradeProposalOffer == false)
		{			
			Reg._yesNoKeyPressValueAtTrade = 0;
			Reg._buttonCodeValues = "";
			
			if (_tradeProposal != null) 
				remove(_tradeProposal);
			
			/*if (Reg._game_offline_vs_cpu == true)
			{
				buttonResetTradeProposal();
				buttonsTradeInactive();
			}*/
			
			shouldEndNowButtonBeActive();
			
			RegTriggers._signatureGameUnitImage = true;
			RegTriggers._highlightOnlyOuterUnits = true;
		}
		
		// not enough things selected to make a trade proposal.
		else if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "s1040")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			buttonsTradeActive();
			
			RegTriggers._signatureGameUnitImage = true;
			RegTriggers._highlightOnlyOuterUnits = true;
			
		}
	}
	
	private function payMortgageNoSelected():Void
	{
		// set land and property back to nobody.		
		Reg._gameUniqueValueOfUnit[_mortgageLandPriceCurrentUnitIndex] = 0;
		Reg._gameHouseTaxiCabOrCafeStoreValueOfUnit[_mortgageLandPriceCurrentUnitIndex] = 0;
		
		Reg._gameUniqueValueForPiece[_mortgageLandPriceCurrentUnitY][_mortgageLandPriceCurrentUnitX] = 0;
		Reg._gameHouseTaxiCabOrCafeStoreForPiece[_mortgageLandPriceCurrentUnitY][_mortgageLandPriceCurrentUnitX] = 0;
		
		
		// ...this starts at 0. this is needed or else the house, cab or cafe store will not be shown.
		_houseTaxiCafeAmountY[0] = _mortgageLandPriceCurrentUnitY;
		_houseTaxiCafeAmountX[0] = _mortgageLandPriceCurrentUnitX;
		
		for (p in 1...28)
		{
			_houseTaxiCafeAmountY[p] = 0;
			_houseTaxiCafeAmountX[p] = 0;
		}
		
		//Reg._gameDiceMaximumIndex[Reg._move_number_next]
		// set mortgage back to default for this unit.
		_mortgageLandPrice[Reg._move_number_next][_mortgageLandPriceCurrentUnitIndex] = -1;
		
	}
		
	/******************************
	* at root. this is the first buttons seen after clicking the number wheel.
	*/
	private function showOptionButtons():Void
	{	
		tradingCashValue = [0, 0];
		_cashValueYoursText.text = "$0";
		_cashValueOthersText.text = "$0";
		
		hideHouseTaxiOrStoreButtons();
		_textGeneralMessage2.visible = false;
		
		_buttonTradeProposal.visible = false;
		_buttonTradeProposal.active = false;
		
		_buttonResetTradeProposal.visible = false;
		_buttonResetTradeProposal.active = false;
		
		_unitYoursButton.visible = false;
		_unitYoursButton.active = false;
		
		_unitOthersButton.visible = false;
		_unitOthersButton.active = false;
		
		_unitYoursImage.visible = false;
		_unitYoursImage.active = false;
		
		_unitOthersImage.visible = false;
		_unitOthersImage.active = false;
		
		_unitYoursText.visible = false;
		_unitYoursText.active = false;
		
		_unitOthersText.visible = false;
		_unitOthersText.active = false;
		
		_cashSendText.visible = false;
		_cashGetText.visible = false;
		
		_cashMinus500YoursButton.visible = false;
		_cashPlus500YoursButton.visible = false;
		_cashValueYoursText.visible = false;
		_cashMinus500YoursButton.active = false;
		_cashPlus500YoursButton.active = false;
		_cashValueYoursText.active = false;
		
		_cashMinus500OthersButton.visible = false;
		_cashPlus500OthersButton.visible = false;
		_cashValueOthersText.visible = false;
		_cashMinus500OthersButton.active = false;
		_cashPlus500OthersButton.active = false;
		_cashValueOthersText.active = false;
				
		_tradingYourBG.visible = false;
		_tradingOtherBG.visible = false;
		
		_unitBG.visible = true;
		_unitImage.visible = true;
		_unitTitle.visible = true;
		
		var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
		Reg._gameYYnew2 = RegFunctions.getPfindYY(_p);
		Reg._gameXXnew2 = RegFunctions.getPfindXX(_p);
		
		if (_isInDebt == true && _p2 != -1)
		{
			Reg._gameYYnew2 = RegFunctions.getPfindYY(_p2);
			Reg._gameXXnew2 = RegFunctions.getPfindXX(_p2);		
		
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyHouseTaxiCabOrCafeStores.active = false;
			
			if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0)
			{
				if (RegTypedef._dataPlayers._cash[Reg._move_number_current] < _totalDebtAmount && _totalDebtAmount > 0)
				{
					_buttonSellHouse.active = true;
					_buttonSellHouse.visible = true;
				}
				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonSellHouse.active = false;
			}
			
			if (_isInDebt == false && _isMortgage[Reg._move_number_next][_p2] <= -1 
			||  _isInDebt == true && RegTypedef._dataPlayers._cash[Reg._move_number_current] < _totalDebtAmount)
			{
				if (RegTypedef._dataPlayers._cash[Reg._move_number_current] < _totalDebtAmount && _totalDebtAmount > 0)
				{
					_buttonBuyMortgage.active = true;
					_buttonBuyMortgage.visible = true;
				}
				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyMortgage.active = false;
			}
			
			shouldEndNowButtonBeActive();
		}
		
		else
		{
			_textGeneralMessage.visible = true;
			_textGeneralMessage.text = "Main menu.";			
			
			_buttonEndTurnOrPayNow.screenCenter(X); 
			
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			{
				_buttonBuyHouseTaxiCabOrCafeStores.visible = true;
				_buttonBuyHouseTaxiCabOrCafeStores.active = false;
			}
			else
			{
				_buttonBuyHouseTaxiCabOrCafeStores.active = true; 
				_buttonBuyHouseTaxiCabOrCafeStores.visible = true;
			}
			
			if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0)
			{
				_buttonSellHouse.active = true;
				_buttonSellHouse.visible = true;
				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonSellHouse.active = false;
			}
			
			if (_isMortgage[Reg._move_number_next][Reg._gameDiceMaximumIndex[Reg._move_number_next]] <= -1)
			{			
				// if no house.
				if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] == 0)
				{
					_buttonBuyMortgage.visible = false;
					_buttonBuyMortgage.active = false;
				}
				
				else
				{
					_buttonBuyMortgage.active = true;
					_buttonBuyMortgage.visible = true;
				}
				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyMortgage.active = false;
			}
			
			_tradeWith.active = true;
			_tradeWith.visible = true;	
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_tradeWith.active = false;
					
			RegTriggers._signatureGameUnitImage = false;
			RegTriggers._highlightOnlyOuterUnits = false;
			
			_buttonGoBack.visible = false;
			_buttonGoBack.active = false;
			
			//if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			
			shouldEndNowButtonBeActive();
		}
	}
	
	// when clicking these buttons, this function is called then other buttons can then be displayed on a blank BG sometimes where these buttons were located at.
	private function hideOptionButtons():Void
	{
		_buttonBuyHouseTaxiCabOrCafeStores.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStores.active = false; 
		
		_buttonSellHouse.visible = false;
		_buttonSellHouse.active = false;
		
		_buttonBuyMortgage.visible = false;
		_buttonBuyMortgage.active = false;
		
		_tradeWith.visible = false;
		_tradeWith.active = false;
		
		_buttonGoBack.active = false;
		_buttonEndTurnOrPayNow.active = false;
				
	}
	
	public function buttonsTradeActive():Void
	{
		
		_unitYoursButton.active = true;
		_unitYoursButton.visible = true;
		
		_cashMinus500YoursButton.active = true;
		_cashMinus500YoursButton.visible = true;
		
		_cashPlus500YoursButton.active = true;
		_cashPlus500YoursButton.visible = true;
		
		_unitOthersButton.active = true;
		_unitOthersButton.visible = true;
		
		_cashMinus500OthersButton.active = true;
		_cashMinus500OthersButton.visible = true;
		
		_cashPlus500OthersButton.active = true;
		_cashPlus500OthersButton.visible = true;
		
		shouldEndNowButtonBeActive();
			
		if (_tradeSuccessfulDoOnce == false)
		{
			_buttonTradeProposal.active = true;
			_buttonTradeProposal.visible = true;
			
			_buttonResetTradeProposal.active = true;
			_buttonResetTradeProposal.visible = true;
			
			_buttonGoBack.active = true;
			_buttonGoBack.visible = true;
		}
	}
	
	public function buttonsTradeInactive():Void
	{
		_unitYoursButton.has_toggle = false;
		_unitYoursButton.active = false;
		
		//tradingCashValue = [0, 0];
		//_cashValueYoursText.text = "$0";
		//_cashValueOthersText.text = "$0";
			
		_cashMinus500YoursButton.visible = false;
		_cashPlus500YoursButton.visible = false;
		_cashMinus500YoursButton.active = false;
		_cashPlus500YoursButton.active = false;
		
		_unitOthersButton.has_toggle = false;
		_unitOthersButton.active = false;
		
		_cashMinus500OthersButton.visible = false;
		_cashPlus500OthersButton.visible = false;
		_cashMinus500OthersButton.active = false;
		_cashPlus500OthersButton.active = false;
		
		_buttonEndTurnOrPayNow.visible = false;
		_buttonGoBack.visible = false;
		_buttonTradeProposal.visible = false;
		_buttonResetTradeProposal.visible = false;
		_buttonEndTurnOrPayNow.active = false;
		_buttonGoBack.active = false;
		_buttonTradeProposal.active = false;
		_buttonResetTradeProposal.active = false;
		
		_buttonTradeProposal.visible = false;
		_buttonTradeProposal.active = false;
			
		_buttonResetTradeProposal.visible = false;	
		_buttonResetTradeProposal.active = false;
			
		_buttonGoBack.visible = false;	
		_buttonGoBack.active = false;
			
		
		RegTriggers._signatureGameUnitImage = false;
	}
	
	
	public function tradeSelectPlayer():Void
	{
		hideOptionButtons();
		
		_unitBG.visible = false;
		_unitImage.visible = false;
		_unitTitle.visible = false;
		_textGeneralMessage.visible = false;
		_textGeneralMessage2.visible = true;
		
		_textGeneralMessage2.text = 'Click "Your" button then select a unit at the parameter of the game board.';

		RegTriggers._signatureGameUnitImage = false;
		RegTriggers._highlightOnlyOuterUnits = false;
		
		
		if (_tradeSuccessfulDoOnce == false)
		{
			_buttonTradeProposal.visible = true;
			_buttonTradeProposal.active = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonTradeProposal.active = false;
		}
		
		if (_tradeSuccessfulDoOnce == false)
		{
			_buttonResetTradeProposal.visible = true;
			_buttonResetTradeProposal.active = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonResetTradeProposal.active = false;
		}
		
		_unitYoursButton.active = true;
		_unitYoursButton.visible = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_unitYoursButton.active = false;
			
		_unitOthersButton.active = true;
		_unitOthersButton.visible = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_unitOthersButton.active = false;
			
		_unitYoursImage.active = true;
		_unitYoursImage.visible = true;
		_unitOthersImage.active = true;
		_unitOthersImage.visible = true;
		
		_unitYoursText.active = true;
		_unitYoursText.visible = true;
		_unitOthersText.active = true;
		_unitOthersText.visible = true;
		
		_cashSendText.visible = true;
		_cashGetText.visible = true;
		
		_cashMinus500YoursButton.visible = true;
		_cashPlus500YoursButton.visible = true;
		_cashValueYoursText.visible = true;
		
		_cashMinus500YoursButton.active = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_cashMinus500YoursButton.active = false;
			
		_cashPlus500YoursButton.active = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_cashPlus500YoursButton.active = false;
			
		_cashValueYoursText.active = true;
		
		_cashMinus500OthersButton.visible = true;
		_cashPlus500OthersButton.visible = true;
		_cashValueOthersText.visible = true;
		
		_cashMinus500OthersButton.active = true;		
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_cashMinus500OthersButton.active = false;
		
		_cashPlus500OthersButton.active = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_cashPlus500OthersButton.active = false;
			
		_cashValueOthersText.active = true;
		
		_tradingYourBG.visible = true;
		_tradingOtherBG.visible = true;
		
		if (_tradeSuccessfulDoOnce == false)
		{
			_buttonGoBack.x = (FlxG.width / 2) - _buttonGoBack.width - 7;
			_buttonGoBack.active = true;
			_buttonGoBack.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonGoBack.active = false;
		}
		
		// go to this function.
			
		shouldEndNowButtonBeActive();
		_buttonGoBack.onUp.callback = buttonGoBackOK;
		
		if (_buttonEndTurnOrPayNow != null)
		{
			_buttonEndTurnOrPayNow.x = (FlxG.width / 2) + 7;
		}
		
	}
	
		
	private function buttonUnitYours():Void
	{
		if (_buttonGoBack.visible == false) return;
		
		_unitOthersButton.color = 0xFF550000;
		_unitYoursButton.color = 0xFF005500;		
		
		_unitYoursButton.has_toggle = true;
		_unitYoursButton.set_toggled(true);
		
		_unitOthersButton.has_toggle = false;
		_unitOthersButton.set_toggled(false);
		
		RegTriggers._signatureGameUnitImage = true;
		RegTriggers._highlightOnlyOuterUnits = true;
		
	}
	
	private function buttonUnitOthers():Void
	{
		if (_buttonGoBack.visible == false) return;
		
		_unitYoursButton.color = 0xFF550000;
		_unitOthersButton.color = 0xFF005500;	
		
		_unitOthersButton.has_toggle = true;
		_unitOthersButton.set_toggled(true);
		
		_unitYoursButton.has_toggle = false;
		_unitYoursButton.set_toggled(false);
		
		RegTriggers._signatureGameUnitImage = true;
		RegTriggers._highlightOnlyOuterUnits = true;
	}
	
	public function cashMinus500Yours():Void
	{
		if (tradingCashValue[0] - 500 >= 0)
		{
			tradingCashValue[0] -= 500;			
			_cashValueYoursText.text = "$" + Std.string(tradingCashValue[0]);	
		}
	}
	
	
	private function cashPlus500Yours():Void
	{
		if (tradingCashValue[0] + 500 <= RegTypedef._dataPlayers._cash[Reg._move_number_next])
		{
			tradingCashValue[0] += 500;			
			_cashValueYoursText.text = "$" + Std.string(tradingCashValue[0]);
		}
	}
	
	public function cashMinus500Others():Void
	{
		if (tradingCashValue[1] - 500 >= 0)
		{
			tradingCashValue[1] -= 500;			
			_cashValueOthersText.text = "$" + Std.string(tradingCashValue[1]);	
		}
	}
	
	
	private function cashPlus500Others():Void
	{
		if (tradingCashValue[1] + 500 <= RegTypedef._dataPlayers._cash[Reg._move_number_next])
		{
			tradingCashValue[1] += 500;			
			_cashValueOthersText.text = "$" + Std.string(tradingCashValue[1]);
		}
	}
	
	
	/******************************
	* @param	_num		how many houses, taxi cabs or cafe stores.
	* @param	_value		this value will times an extra value to current land price. its a multiplier. this sets extra cash value to a house, cab or store. the higher the amount of places then the more expensive this value becomes.
	*/	
	public function houseTaxiCabAndCafeStorePrices(_num:Int, _value:Float):Void
	{

		// player _num = unit 0-48. price = value * unit price.
		_buyPriceForHouseTaxiCafe[_num][0] = -1;

		// group 1.
		_buyPriceForHouseTaxiCafe[_num][1] = _value * 1200;		
		_buyPriceForHouseTaxiCafe[_num][2] = _value * 1150;		
		_buyPriceForHouseTaxiCafe[_num][3] = _value * 1100;		
				
		_buyPriceForHouseTaxiCafe[_num][4] = _value * 700;
		_buyPriceForHouseTaxiCafe[_num][5] = _value * 500;
		
		_buyPriceForHouseTaxiCafe[_num][6] = -1;
		_buyPriceForHouseTaxiCafe[_num][7] = -1;
		
		_buyPriceForHouseTaxiCafe[_num][8] = _value * 650;
		
		// group 2.
		_buyPriceForHouseTaxiCafe[_num][9] = _value * 1050;		
		_buyPriceForHouseTaxiCafe[_num][10] = _value * 1000;
				
		_buyPriceForHouseTaxiCafe[_num][11] = _value * 450;
				
		// group 3.
		_buyPriceForHouseTaxiCafe[_num][12] = _value * 950;
		_buyPriceForHouseTaxiCafe[_num][13] = _value * 900;
				
		_buyPriceForHouseTaxiCafe[_num][14] = -1;
		
		// group 4.
		_buyPriceForHouseTaxiCafe[_num][15] = _value * 850;		
		_buyPriceForHouseTaxiCafe[_num][16] = _value * 800;
				
		_buyPriceForHouseTaxiCafe[_num][17] = _value * 600;		
		_buyPriceForHouseTaxiCafe[_num][18] = _value * 400;
		
		_buyPriceForHouseTaxiCafe[_num][19] = -1;
				
		// group 5.
		_buyPriceForHouseTaxiCafe[_num][20] = _value * 750;				
		
		_buyPriceForHouseTaxiCafe[_num][21] = -1;
		
		_buyPriceForHouseTaxiCafe[_num][22] = _value * 350;		
		_buyPriceForHouseTaxiCafe[_num][23] = _value * 550;		
		
		// group 6.
		_buyPriceForHouseTaxiCafe[_num][24] = _value * 700;		
		_buyPriceForHouseTaxiCafe[_num][25] = _value * 650;		
		_buyPriceForHouseTaxiCafe[_num][26] = _value * 600;		
		_buyPriceForHouseTaxiCafe[_num][27] = _value * 550;	
		
		_buyPriceForHouseTaxiCafe[_num][29] = -1;
		_buyPriceForHouseTaxiCafe[_num][30] = -1;
		_buyPriceForHouseTaxiCafe[_num][31] = -1;
		_buyPriceForHouseTaxiCafe[_num][32] = -1;
		_buyPriceForHouseTaxiCafe[_num][33] = -1;
		_buyPriceForHouseTaxiCafe[_num][34] = -1;
		_buyPriceForHouseTaxiCafe[_num][35] = -1;
		_buyPriceForHouseTaxiCafe[_num][36] = -1;
		_buyPriceForHouseTaxiCafe[_num][37] = -1;
		_buyPriceForHouseTaxiCafe[_num][38] = -1;
		_buyPriceForHouseTaxiCafe[_num][39] = -1;
		_buyPriceForHouseTaxiCafe[_num][40] = -1;
		_buyPriceForHouseTaxiCafe[_num][41] = -1;
		_buyPriceForHouseTaxiCafe[_num][42] = -1;	
		_buyPriceForHouseTaxiCafe[_num][43] = -1;
		_buyPriceForHouseTaxiCafe[_num][44] = -1;
		_buyPriceForHouseTaxiCafe[_num][45] = -1;
		_buyPriceForHouseTaxiCafe[_num][46] = -1;
		_buyPriceForHouseTaxiCafe[_num][47] = -1;
		_buyPriceForHouseTaxiCafe[_num][48] = -1;
	}
	
	/******************************
	* 1: buttons to buy houses, cabs or stores. also, the go back button is displayed beside the end turn button since we are 1 deep inside of root. root is the first screen displayed that gives options such as buy house.
	*/
	private function buyHouseTaxiCabOrCafeStore():Void
	{
		hideOptionButtons();
		_textGeneralMessage.text = "Buy property.";
		
		var _offset:Int = 45; // used to position these buttons underneath the other.
		
		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 1)
		{
			_buttonBuyHouseTaxiCabOrCafeStore1.active = true;	
			_buttonBuyHouseTaxiCabOrCafeStore1.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyHouseTaxiCabOrCafeStore1.active = false;
			
			_offset += 45;
			
		}

		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 2)
		{
			_buttonBuyHouseTaxiCabOrCafeStore2.y = Reg._unitYgameBoardLocation[0] + 230 + _offset;
			
			_buttonBuyHouseTaxiCabOrCafeStore2.active = true;	
			_buttonBuyHouseTaxiCabOrCafeStore2.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyHouseTaxiCabOrCafeStore2.active = false;
			
			_offset += 45;
			
		}
		
		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 3)
		{
			_buttonBuyHouseTaxiCabOrCafeStore3.y = Reg._unitYgameBoardLocation[0] + 230 + _offset;
			
			_buttonBuyHouseTaxiCabOrCafeStore3.active = true;	
			_buttonBuyHouseTaxiCabOrCafeStore3.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyHouseTaxiCabOrCafeStore3.active = false;
			
			_offset += 45;
			
		}
		
		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] < 4)
		{
			_buttonBuyHouseTaxiCabOrCafeStore4.y = Reg._unitYgameBoardLocation[0] + 230 + _offset;
			
			_buttonBuyHouseTaxiCabOrCafeStore4.active = true;	
			_buttonBuyHouseTaxiCabOrCafeStore4.visible = true;
			
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
				_buttonBuyHouseTaxiCabOrCafeStore4.active = false;
			
			_offset += 45;
			
		}
		
		_buttonGoBack.x = (FlxG.width / 2) - _buttonGoBack.width - 7;
		_buttonGoBack.active = true;
		_buttonGoBack.visible = true;
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonGoBack.active = false;
		
		_buttonEndTurnOrPayNow.x = (FlxG.width / 2) + 7;
		
		shouldEndNowButtonBeActive();
			
		// go to this function.
		_buttonGoBack.onUp.callback = buttonGoBackOK;
		
	}
	
	/******************************
	 * just bought land property.
	 * @param	_num	current house, or taxi, or store.
	 */
	private function boughtHouseTaxiCabOrCafeStore(_num:Int):Void
	{
		// check if player has enough cash to buy house, taxi cab or cafe store.
		if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _buyPriceForHouseTaxiCafe[_num][Reg._gameDiceMaximumIndex[Reg._move_number_next]] < 0)
		{
			_stringNotEnoughCash = Std.string( _unitTitlesArray[Reg._gameDiceMaximumIndex[Reg._move_number_next]]);
			buttonOK();
		}
		else 
		{	// player bought house, taxi cab or cafe store.
			Std.string(RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _buyPriceForHouseTaxiCafe[_num][Reg._gameDiceMaximumIndex[Reg._move_number_next]]);
			
			var _count:Int = 0;
	
			// this var holds all the houses, cabs and stores for the outer units.
			Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] = (_num + 1);
			
			// the first house sometimes should start at 0 not 1...
			_count = Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1;
			
			// ...this starts at 0. this is needed or else the house, cab or cafe store will not be shown.
			_houseTaxiCafeAmountY[_count] = Reg._gameYYnew2;
			_houseTaxiCafeAmountX[_count] = Reg._gameXXnew2;
			
			hideHouseTaxiOrStoreButtons();
			
			var _str:String;
			if (_p == 4 || _p == 8 || _p == 18 || _p == 23) _str = "a taxi cab";		
			else if (_p == 5 || _p == 11 || _p == 17 || _p == 22)	_str = "a cafe store";	
			else _str = "a house";
			
			Reg._gameMessage = "You bought " + _str + " for $" + Std.int(Math.fround(_buyPriceForHouseTaxiCafe[_num][Reg._gameDiceMaximumIndex[Reg._move_number_next]]));
			Reg._outputMessage = true;
			
			showOptionButtons();
		}
	}
	
	/******************************
	 * message box with a message that player does not have enough cash.
	 */
	public function notEnoughCash():Void
	{
		Reg._messageId = 14010;
		Reg._buttonCodeValues = "s1010";
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	

	private function sellAllHousesForLand():Void
	{	
		hideOptionButtons();
		
		Reg._messageId = 14025; // this ID refers to the active message box. most functions at each message box class check its ID before reading code. if no match then the code is not read.
		Reg._buttonCodeValues = "s1050";
		SceneGameRoom.messageBoxMessageOrder();
			//_buyPriceForHouseTaxiCafe[0][Reg._gameDiceMaximumIndex[Reg._move_number_next]] == -1)
		var _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
		
		// player has already moved, so we need to keep those vars. also, some vars do not work anymore as they have been cleared at the final unit move that the piece did. therefore, get these new vars to use for debt.
		if (_isInDebt == true) 
		{
			_p = _p2;
			
			Reg._gameYYnew2 = RegFunctions.getPfindYY(_p);
			Reg._gameXXnew2 = RegFunctions.getPfindXX(_p);
		}
		
		if (_p == 4 || _p == 8 || _p == 18 || _p == 23) _string = "taxi cab";		
		else if (_p == 5 || _p == 11 || _p == 17 || _p == 22)	_string = "cafe store";	
		else _string = "house";
		
		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 1) _string += "s";
		
		// gets the value of the last service divided by 2.
		_sellAllServicesPrice = Std.int(FlxMath.roundDecimal((_buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][_p]) / 2, 0));
		
		_int = _p;
		
	}
	
	/******************************
	}
	* get money from a mortgage.
	*/
	public function getMortgage():Void
	{
		// player has already moved, so we need to keep those vars. also, some vars do not work anymore as they have been cleared at the final unit move that the piece did. therefore, get these new vars to use for debt.
		if (_isInDebt == true) 
		{
			_p = _p2;
			
			Reg._gameYYnew2 = RegFunctions.getPfindYY(_p);
			Reg._gameXXnew2 = RegFunctions.getPfindXX(_p);
		}
	
		
		if (_gameYYnew2Temp != -1 && _gameXXnew2Temp != -1 && Reg._move_number_current > 0)
		{
			Reg._gameYYnew2 = Reg._gameYYold = _gameYYnew2Temp;
			Reg._gameXXnew2 = Reg._gameXXold = _gameXXnew2Temp;
		
			_p = _p2 = Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1;
			//RegTriggers._displayDebtStuff = true;
			
			_gameYYnew2Temp = -1;
			_gameXXnew2Temp = -1;

		}
			
		if (_p == -1) _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
		
		// if no house.
		if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] == 0) 
		{
			Reg._messageId = 14470;
			Reg._buttonCodeValues = "s1010";
			SceneGameRoom.messageBoxMessageOrder();
			
		}
		
		else
		{
			hideOptionButtons();
			_int = _p;
			
			if (_mortgageLandPrice[Reg._move_number_next][_int] != -1)
			{
				Reg._messageId = 14500;
				Reg._buttonCodeValues = "s1015";
				SceneGameRoom.messageBoxMessageOrder();
			
			}				
				
			else
			{
				// player has already moved, so we need to keep those vars. also, some vars do not work anymore as they have been cleared at the final unit move that the piece did. therefore, get these new vars to use for debt.
				if (_isInDebt == true) 	_p = _p2;
								
				var _str:String;
				if (_p == 4 || _p == 8 || _p == 18 || _p == 23) _str = "taxi cab";		
				else if (_p == 5 || _p == 11 || _p == 17 || _p == 22)	_str = "cafe store";	
				else _str = "house";
				
				if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 1) _str += "s";
				
				// gets the mortgage price from unit price + amount of house divided by 1.111.
				_mortgagePrice = Std.int(FlxMath.roundDecimal((_unitBuyingLandPrice[_p] + _buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][_p]) / 1.111, 2));
							
				// this is the total mortgage price without dividing it.
				var _totalPrice:Float = FlxMath.roundDecimal(_unitBuyingLandPrice[_p] + _buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] - 1][_p], 0);
				
				var _total = _mortgagePrice - _mortgageProcessingFee;
				
				if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > 27)
				{
					_unitTitleTemp = _unitTitleDebt.text;
				}
				
				else
				{
					_unitTitleTemp = _unitTitle.text;
				}
				
				if (Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0)
				{
					_mortgageLandPrice[Reg._move_number_next][_p] = _mortgagePrice;		
				}
				
				else
				{
					Reg._messageId = 14550; // this ID refers to the active message box. most functions at each message box class check its ID before reading code. if no match then the code is not read.
					Reg._buttonCodeValues = "s1020";
					SceneGameRoom.messageBoxMessageOrder();
					
					_string = _str;
					_int = _p;
					_float = _totalPrice;
					_float2 = _total;
				}
			}
		}
		
	}	
	
	/******************************
	 * pay back the mortgage.
	 * @param	_str	unit title under mortgage.
	 * @param	i		current unit value of the land under mortgage. also known as _p value.
	 * @param	y		current units y coordinate. the place where the mortgage was bought. 
	 * @param	x		current units x coordinate.
	 */
	private function payMortgage(_str:String, i:Int, y:Int, x:Int):Void
	{
		_mortgageLandPriceCurrentUnitIndex = i;
		_mortgageLandPriceCurrentUnitY = y;
		_mortgageLandPriceCurrentUnitX = x;
		_string = _str;
		
		// check if player does not have enough cash for mortgage.
		if (RegTypedef._dataPlayers._cash[Reg._move_number_next] - _mortgageLandPrice[Reg._move_number_next][_mortgageLandPriceCurrentUnitIndex] < 0)
		{
			Reg._messageId = 14200;
			Reg._buttonCodeValues = "s1035";
			SceneGameRoom.messageBoxMessageOrder();
		
		}

		else
		{		
			Reg._messageId = 14300; // this ID refers to the active message box. most functions at each message box class check its ID before reading code. if no match then the code is not read.
			Reg._buttonCodeValues = "s1030";
			SceneGameRoom.messageBoxMessageOrder();
				
			// stop player from clicking a message box button when its the computer's turn to move.
			if (Reg._game_offline_vs_cpu == true && Reg._move_number_current == Reg._move_number_next && Reg._move_number_current > 0)
			{
				_ticksStartForPayMortgageMessageBox = true;
				
			}
			
			_string = _str;
			
		}
	
		if (_buttonBuyLand != null)
		{
			_buttonBuyLand.visible = false;
			_buttonBuyLand.active = false;
		}
		
	}
	
	/******************************
	 *	the index value of a unit. see Reg._gamePointValueOfUnit at SceneGameRoom.hx
	 */
	private function buyLand(_p:Int):Void
	{
		_textBuyLand = new FlxText(Reg._unitXgameBoardLocation[0] + 100, Reg._unitYgameBoardLocation[0] + 236, 0, "Buy land for $" + _unitBuyingLandPrice[_p] + "?");
		_textBuyLand.setFormat(Reg._fontDefault, 24, FlxColor.WHITE);
		//_textBuyLand.scrollFactor.set();
		_textBuyLand.fieldWidth = 404;
		add(_textBuyLand);
		
		_buttonBuyLand = new ButtonUnique(0, 0, "Buy", 190, 35, Reg._font_size, 0xFFCCFF33, 0, buyLandConfirm);
		_buttonBuyLand.label.font = Reg._fontDefault;
		_buttonBuyLand.screenCenter(XY);
		_buttonBuyLand.y += 97;
		_buttonBuyLand.active = true;
		_buttonBuyLand.visible = true;
		add(_buttonBuyLand);
		
		if (Reg._game_offline_vs_cpu == true && Reg._move_number_current > 0)
			_buttonBuyLand.active = false;
		
		_priceOfLand = _p;
	}
	
	private function buyLandConfirm():Void
	{
		Reg._messageId = 14125; // this ID refers to the active message box. most functions at each message box class check its ID before reading code. if no match then the code is not read.
		Reg._buttonCodeValues = "s1000";
		SceneGameRoom.messageBoxMessageOrder();
		
		_buttonBuyLand.visible = false;
		_buttonBuyLand.active = false;			
	}
	
	private function payRent(_p:Int):Void
	{
		var _rent:Float = 0;
				
		// the code that comes to this function will not work if the player owns the land.  enter condition only if player is standing _gameDiceMaximumIndex. so this will be true only if standing (_gameDiceMaximumIndex) at the unit that has the same value.
		if ((Reg._gameDiceMaximumIndex[Reg._move_number_next] + 1) == (Reg._gamePointValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2]))
		{
			// gets the total houses for unit the current player is at. if this is true then rent will be greater than 0.
			if (Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2] > 0)
			{
				// current rent.
				_rent = FlxMath.roundDecimal(_buyPriceForHouseTaxiCafe[Reg._gameHouseTaxiCabOrCafeStoreForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][_p] / 6 
			+ _groupBonus[Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][_p]
				+ _rentBonus[Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1][_p], 0);
			
			
				
			
			}
			
		}
			
		if (_rent > 0) 
		{			
			//_rent = Math.fround(_rent /6);
			
			// give the rent money to the landlord.
			RegTypedef._dataPlayers._cash[Reg._gameUniqueValueForPiece[Reg._gameYYnew2][Reg._gameXXnew2]-1] += _rent;
			
			// will take the money from the player currently moving piece.
			RegTypedef._dataPlayers._cash[Reg._move_number_next] -= _rent;
			
			// pay rent text to the landlord.
			if (_payRent != null) remove(_payRent);
			_payRent = new FlxText(Reg._unitXgameBoardLocation[0] + 90, Reg._unitYgameBoardLocation[0] + 230, 0, "You paid $" + _rent + " rent to the landlord.");
			_payRent.setFormat(Reg._fontDefault, 24, FlxColor.WHITE);
			//_payRent.scrollFactor.set();
			_payRent.fieldWidth = 404;
			add(_payRent);
		}
		else
		{	
			var _obj:String = ""; var _obj2:String = "";
			
			if (_p == 4 || _p == 8 || _p == 18 || _p == 23) 
			{ _obj = "taxi cabs"; _obj2 = "a service"; }
		
			else if (_p == 5 || _p == 11 || _p == 17 || _p == 22) 
			{ _obj = "cafe store";  _obj2 = "a service"; }
			
			else { _obj = "house"; _obj2 = "rent"; }
		
			// if we are here then there is no house / service for that unit.
			if (_payRent != null) remove(_payRent);
			_payRent = new FlxText(Reg._unitXgameBoardLocation[0] + 90, Reg._unitYgameBoardLocation[0] + 230, 0, "No " + _obj + " for you to pay " + _obj2 + ".");
			_payRent.setFormat(Reg._fontDefault, 24, FlxColor.WHITE);
			//_payRent.scrollFactor.set();
			_payRent.fieldWidth = 404;
			add(_payRent);
		}
	}
	
	private function hideHouseTaxiOrStoreButtons():Void
	{
		_buttonBuyHouseTaxiCabOrCafeStore1.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore1.active = false;
		
		_buttonBuyHouseTaxiCabOrCafeStore2.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore2.active = false;
		
		_buttonBuyHouseTaxiCabOrCafeStore3.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore3.active = false;
		
		_buttonBuyHouseTaxiCabOrCafeStore4.visible = false;
		_buttonBuyHouseTaxiCabOrCafeStore4.active = false;
	}	

	/******************************
	 *  for example, when at buying house, there is a go back button. when that button is clicked, it will hide the buy house buttons and will go back to the previous screen.
	 */
	private function buttonGoBackOK():Void
	{
		hideHouseTaxiOrStoreButtons();		
		
		_buttonGoBack.active = false;
		_buttonGoBack.visible = false;
		
		_buttonEndTurnOrPayNow.screenCenter(X); 
		_textGeneralMessage.text = "";
		
		showOptionButtons();
	}
	
	private function buttonResetTradeProposal():Void
	{
		if (Reg._game_offline_vs_cpu == true)
		{
			//_unitYoursImage.loadGraphic("assets/images/signatureGame/empty.png", false);
			//_unitOthersImage.loadGraphic("assets/images/signatureGame/empty.png", false);
		}
		
		//_unitYoursText.text = "";
		//_unitOthersText.text = "";
		
		//tradingCashValue = [0, 0];
		
		tradeSelectPlayer();
		
		Reg._yesNoKeyPressValueAtTrade = 0;
		
		_cashMinus500YoursButton.active = true;
		_cashMinus500YoursButton.active = true;
		
		_cashMinus500OthersButton.active = true;
		_cashPlus500OthersButton.active = true;
		
		if (_unitYoursButton.has_toggle == true) _unitYoursButton.set_toggled(false);
		if (_unitOthersButton.has_toggle == true) _unitOthersButton.set_toggled(false);
	}
	
	/******************************
	 * trade proposal button was pressed and now a message box is displayed asking if you want to send the trade proposal.
	 */
	public function buttonTradeProposal():Void
	{
		RegTriggers._signatureGameUnitImage = false;
		RegTriggers._highlightOnlyOuterUnits = false;
		
		// your trading land but the other player's land was not selected or you did select the other player's land but you have nothing selected.
		if (_unitOthersText.text == "" || _unitOthersText.text != "" && _unitYoursText.text == "" && tradingCashValue[0] == 0)
		{
			buttonsTradeInactive();
			
			Reg._messageId = 14020;
			Reg._buttonCodeValues = "s1040";
			SceneGameRoom.messageBoxMessageOrder();
		}
		
		else
		{
			if (_tradeProposal != null) 
			{
				remove(_tradeProposal);
				_tradeProposal = null;
			}
			
			_tradeProposal = new MessageBoxTradeProposal();
			add(_tradeProposal);
			_tradeProposal.createMessage(2, 2, true, true);

			var _str:String = "";
			_stringTradeProposal = "Trade ";
			if (_unitYoursText.text != "")
			{
				_stringTradeProposal += _unitYoursText.text;
				if (tradingCashValue[0] > 0) _stringTradeProposal += " plus $" + tradingCashValue[0];
			}
			else if (tradingCashValue[0] > 0) _stringTradeProposal = "Trade your $" + tradingCashValue[0];
			
			_stringTradeProposal += ", for ";
			
			if (_unitOthersText.text != "") _stringTradeProposal += _unitOthersText.text;
			if (tradingCashValue[1] > 0) _stringTradeProposal += " plus $" + tradingCashValue[1];
			_stringTradeProposal += "?";
			
			_tradeProposal.display("Send Trade Proposal.", _stringTradeProposal);
			_tradeProposal.popupMessageShow(); 
			
			// ################### Reply to trade message. #################
		
			_stringReplyTradeProposal = "Trade ";
			
			if (_unitOthersText.text != "") _stringReplyTradeProposal += _unitOthersText.text;
			if (tradingCashValue[1] > 0) _stringReplyTradeProposal += " plus $" + tradingCashValue[1];
			
			_stringReplyTradeProposal += ", for ";
			
			if (_unitYoursText.text != "")
			{
				_stringReplyTradeProposal += _unitYoursText.text;
				if (tradingCashValue[0] > 0) _stringReplyTradeProposal += " plus $" + tradingCashValue[0];
			}
			else if (tradingCashValue[0] > 0) _stringReplyTradeProposal += "$" + tradingCashValue[0];
			_stringReplyTradeProposal += "?";
		}
	}
	
	/******************************
	* exit the options screen. this is where you do the options for the icon. buy house button and mortgage button is removed when ending a turn.
	*/
	public function buttonOK():Void
	{
		// can player pay debt. if so then pay the debt and reset the vars that trigger debt. the end turn button will then show.
		if (RegTypedef._dataPlayers._cash[Reg._move_number_current] >= _totalDebtAmount && _totalDebtAmount > 0)
		{
			RegTypedef._dataPlayers._cash[Reg._move_number_current] = RegTypedef._dataPlayers._cash[Reg._move_number_current] - _totalDebtAmount;
			
			_stringNotEnoughCash = "";
			_isInDebt = false;
		}
		
		// _str is the message of not enough cash for a unit event at an inner units.
		if (_stringNotEnoughCash != "" || _isInDebt == true)
		{
			notEnoughCash();
		}
		
		else
		{
			tradingCashValue = [0, 0];
			_cashValueYoursText.text = "$0";
			_cashValueOthersText.text = "$0";
			
			background.visible = false;
			remove(background);
			background = null; // this is needed to stop a bug where clicking the units directly after the number wheel is clicked will result in a client freeze.
			
			_unitBG.visible = false;
			remove(_unitBG);
			
			_unitImage.visible = false;
			remove(_unitImage);
			
			_unitTitle.visible = false;
			remove(_unitTitle);
			
			_unitImageDebt.visible = false;
			remove(_unitImageDebt);
			
			_unitTitleDebt.visible = false;
			remove(_unitTitleDebt);
			
			if (_payRent != null)
			{
				_payRent.visible = false;
				remove(_payRent);
			}
			
			if (_buttonBuyHouseTaxiCabOrCafeStores != null)
			{
				_buttonBuyHouseTaxiCabOrCafeStores.visible = false;
				remove(_buttonBuyHouseTaxiCabOrCafeStores);
			}
			
			if (_buttonSellHouse != null)
			{
				_buttonSellHouse.visible = false;
				remove(_buttonSellHouse);
			}
			
			if (_buttonBuyMortgage != null)
			{
				_buttonBuyMortgage.visible = false;
				remove(_buttonBuyMortgage);
			}
			
			if (_tradeWith != null)
			{
				_tradeWith.visible = false;
				remove(_tradeWith);
			}
			
			if (_buttonGoBack != null)
			{
				_buttonGoBack.visible = false;
				remove(_buttonGoBack);
			}
			
			if (_buttonGoBack != null)
			{
				_buttonEndTurnOrPayNow.visible = false;
				remove(_buttonEndTurnOrPayNow);
			}
			
			if (_textGeneralMessage != null)
			{
				_textGeneralMessage.visible = false;
				_textGeneralMessage2.visible = false;
				
				remove(_textGeneralMessage);
				remove(_textGeneralMessage2);
			}
			
			if (_textBuyLand != null)
			{
				remove(_textBuyLand);
				remove(_buttonBuyLand);
			}
			
			if (_buttonBuyHouseTaxiCabOrCafeStore1 != null)
			{
				hideHouseTaxiOrStoreButtons();
				
				remove(_buttonBuyHouseTaxiCabOrCafeStore1);
				remove(_buttonBuyHouseTaxiCabOrCafeStore2);
				remove(_buttonBuyHouseTaxiCabOrCafeStore3);
				remove(_buttonBuyHouseTaxiCabOrCafeStore4);
			}
			
			
			_buttonTradeProposal.visible = false;
			_buttonTradeProposal.active = false;		
			remove(_buttonTradeProposal);
			
			_buttonResetTradeProposal.visible = false;
			_buttonResetTradeProposal.active = false;		
			remove(_buttonResetTradeProposal);
					
			_unitYoursButton.visible = false;
			remove(_unitYoursButton);
			
			_unitOthersButton.visible = false;
			remove(_unitOthersButton);
			
			_unitYoursImage.visible = false;
			remove(_unitYoursImage);
			
			_unitOthersImage.visible = false;
			remove(_unitOthersImage);
			
			_unitYoursText.visible = false;
			remove(_unitYoursText);
			
			_unitOthersText.visible = false;
			remove(_unitOthersText);
			
			_cashSendText.visible = false;
			_cashGetText.visible = false;		
			remove(_cashSendText);
			remove(_cashGetText);
			
			_cashMinus500YoursButton.visible = false;
			_cashPlus500YoursButton.visible = false;
			_cashValueYoursText.visible = false;
			remove(_cashMinus500YoursButton);
			remove(_cashPlus500YoursButton);
			remove(_cashValueYoursText);
			
			_cashMinus500OthersButton.visible = false;
			_cashPlus500OthersButton.visible = false;
			_cashValueOthersText.visible = false;
			remove(_cashMinus500OthersButton);
			remove(_cashPlus500OthersButton);
			remove(_cashValueOthersText);
			
			_tradingYourBG.visible = false;
			_tradingOtherBG.visible = false;		
			remove(_tradingYourBG);
			remove(_tradingOtherBG);
			
			RegTriggers._signatureGame = false;
			 
			// update data for all other players.
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false)
			{
				PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
				
			/*// outer movement if you are currently at unit 27 and you have exited from the options screen when we need to make the value -1 since that will be the next unit to move to. see SignatureGameMovePlayersPiece.hx. 
			if (_pieceAtBoardParameter[Reg._move_number_next] == true
			 && Reg._gameDiceCurrentIndex[Reg._move_number_next] == 27 && Reg._gameDiceMaximumIndex[Reg._move_number_next] == 27) 
			{
				Reg._gameDiceMaximumIndex[Reg._move_number_next] = -1;
				Reg._gameDiceCurrentIndex[Reg._move_number_next] = -1; 
			}*/
			
			Reg._playerCanMovePiece = true;
			Reg._gameMovePiece = false;
			
			SignatureGameMovePlayersPiece.changePlayer();
			
			Reg._gameYYnew2 = -1;
			Reg._gameXXnew2 = -1;
			Reg._gameYYold = -1;
			Reg._gameXXold = -1;
			Reg._gameYYold2 = -1;
			Reg._gameXXold2 = -1;
			
			Reg._signatureGameUnitNumberTrade = [0, 0];
			Reg._isThisPieceAtBackdoor = false;
			Reg._backdoorMoveValue = -1;
			
			RegTriggers._signatureGameUnitImage = true;
			RegTriggers._highlightOnlyOuterUnits = false;
			
		}
	}
}//