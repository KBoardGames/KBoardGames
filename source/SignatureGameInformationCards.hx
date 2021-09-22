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
 * information about a unit such as the price and rent of that unit.
 * @author kboardgames.com
 */
class SignatureGameInformationCards extends FlxState
{	
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
		
	private var _textUnitTitle:FlxText; // this is the title of the information cards.
	private var _textUnitBody:FlxText; // land price or information text about the unit.
	
	private var _tableColumnHeader1:FlxText;
	private var _tableColumnHeader2:FlxText;
	private var _tableColumnHeader3:FlxText;
	
	private var _tableColumn1Row1:FlxText;
	private var _tableColumn1Row2:FlxText;
	private var _tableColumn1Row3:FlxText;
	private var _tableColumn1Row4:FlxText;
	
	private var _tableColumn2Row1:FlxText;
	private var _tableColumn2Row2:FlxText;
	private var _tableColumn2Row3:FlxText;
	private var _tableColumn2Row4:FlxText;
	
	private var _tableColumn3Row1:FlxText;
	private var _tableColumn3Row2:FlxText;
	private var _tableColumn3Row3:FlxText;
	private var _tableColumn3Row4:FlxText;
	
	private var _offsetY:Int = 159; // if this class image, its Y value is changed, all elements displayed on top of the image needs to be changed to. this var changes the title y value.
	private var _offsetY2:Int = 210; // this changes all text y value displayed on top of this class image.
	
	private var _p:Int = -1; // used to find piece number or unit number.
	private var _unitImage:FlxSprite;
	
	/******************************
	 * this var is used when it another players move turn, the same unit for that player will be displayed that way it was when it was clicked by that player. if this var does not match the value of Reg._signatureGameUnitNumberSelect, this var will be updated to the same value.
	 */
	public static var _signatureGameUnitNumberCurrent:Array<Int> = [0, 0, 0, 0];
	
	/******************************
	 * holds the mouse clicked on unit value. when clicked on the Reg._signatureGameUnitNumberCurrent var will be updated to this value.
	 */
	public static var _signatureGameUnitNumberSelect:Array<Int> = [0, 0, 0, 0];
	
	public function new(y:Float, x:Float):Void
	{
		super();	
					
		_startX = x; // top-left corner...
		_startY = y; // of gameboard.
		
		_signatureGameUnitNumberCurrent = [0, 0, 0, 0];
		_signatureGameUnitNumberSelect = [0, 0, 0, 0];
		
		persistentDraw = true;
		persistentUpdate = true;
		
		_unitImage = new FlxSprite(21, FlxG.height - 572 + _offsetY);
		_unitImage.loadGraphic("assets/images/signatureGame/unitInformation.png", true, 330);
		
		_unitImage.animation.add("frameOuterUnits", [0], 30, true);
		_unitImage.animation.add("frameInnerUnits", [1], 30, true);
		_unitImage.animation.play("frameInnerUnits");	
		
		//_unitImage.scrollFactor.set(0, 0);	
		add(_unitImage);
		
		// this is the title of the information cards.
		_textUnitTitle = new FlxText(44, 212 + _offsetY + 6, 0, "", 22);
		_textUnitTitle.setFormat(Reg._fontDefault, 22, FlxColor.WHITE);
		//_textUnitTitle.scrollFactor.set(0, 0);
		add(_textUnitTitle);
		
		_textUnitBody = new FlxText(44, 268 + _offsetY + 6, 0, "", 22);
		_textUnitBody.setFormat(Reg._fontDefault, 22, FlxColor.BLACK);
		//_textUnitBody.scrollFactor.set(0, 0);
		_textUnitBody.fieldWidth = 285;
		add(_textUnitBody);
		
		// table column 1. House
		_tableColumnHeader1 = new FlxText(50, 269 + _offsetY2, 0, "", 20);
		_tableColumnHeader1.setFormat(Reg._fontDefault, 20, FlxColor.WHITE);
		//_tableColumnHeader1.scrollFactor.set(0, 0);
		add(_tableColumnHeader1);
		
		// table column 2. value.
		_tableColumnHeader2 = new FlxText(151, 269 + _offsetY2, 0, "", 20);
		_tableColumnHeader2.setFormat(Reg._fontDefault, 20, FlxColor.WHITE);
		//_tableColumnHeader2.scrollFactor.set(0, 0);
		add(_tableColumnHeader2);
		
		// table column 3. rent.
		_tableColumnHeader3 = new FlxText(255, 269 + _offsetY2, 0, "", 20);
		_tableColumnHeader3.setFormat(Reg._fontDefault, 20, FlxColor.WHITE);
		//_tableColumnHeader3.scrollFactor.set(0, 0);
		add(_tableColumnHeader3);
		
		//############################# FIRST ROW. FIRST COLUMN ##########
		_tableColumn1Row1 = new FlxText(50, 307 + _offsetY2, 0, "", 20);
		_tableColumn1Row1.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn1Row1.scrollFactor.set(0, 0);
		add(_tableColumn1Row1);
		
		_tableColumn1Row2 = new FlxText(50, 344 + _offsetY2, 0, "", 20);
		_tableColumn1Row2.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn1Row2.scrollFactor.set(0, 0);
		add(_tableColumn1Row2);
		
		_tableColumn1Row3 = new FlxText(50, 381 + _offsetY2, 0, "", 20);
		_tableColumn1Row3.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn1Row3.scrollFactor.set(0, 0);
		add(_tableColumn1Row3);
		
		_tableColumn1Row4 = new FlxText(50, 418 + _offsetY2, 0, "", 20);
		_tableColumn1Row4.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn1Row4.scrollFactor.set(0, 0);
		add(_tableColumn1Row4);		
		
		//############################# ROWS AT SECOND COLUMN ##########
		_tableColumn2Row1 = new FlxText(151, 307 + _offsetY2, 0, "", 20);
		_tableColumn2Row1.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn2Row1.scrollFactor.set(0, 0);
		add(_tableColumn2Row1);
		
		_tableColumn2Row2 = new FlxText(151, 344 + _offsetY2, 0, "", 20);
		_tableColumn2Row2.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn2Row2.scrollFactor.set(0, 0);
		add(_tableColumn2Row2);
		
		_tableColumn2Row3 = new FlxText(151, 381 + _offsetY2, 0, "", 20);
		_tableColumn2Row3.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn2Row3.scrollFactor.set(0, 0);
		add(_tableColumn2Row3);
		
		_tableColumn2Row4 = new FlxText(151, 418 + _offsetY2, 0, "", 20);
		_tableColumn2Row4.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn2Row4.scrollFactor.set(0, 0);
		add(_tableColumn2Row4);		
		
		//############################# ROWS AT THIRD COLUMN ##########
		_tableColumn3Row1 = new FlxText(255, 307 + _offsetY2, 0, "", 20);
		_tableColumn3Row1.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn3Row1.scrollFactor.set(0, 0);
		add(_tableColumn3Row1);
		
		_tableColumn3Row2 = new FlxText(255, 344 + _offsetY2, 0, "", 20);
		_tableColumn3Row2.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn3Row2.scrollFactor.set(0, 0);
		add(_tableColumn3Row2);
		
		_tableColumn3Row3 = new FlxText(255, 381 + _offsetY2, 0, "", 20);
		_tableColumn3Row3.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn3Row3.scrollFactor.set(0, 0);
		add(_tableColumn3Row3);
		
		_tableColumn3Row4 = new FlxText(255, 418 + _offsetY2, 0, "", 20);
		_tableColumn3Row4.setFormat(Reg._fontDefault, 20, FlxColor.BLACK);
		//_tableColumn3Row4.scrollFactor.set(0, 0);
		add(_tableColumn3Row4);
		
	}	
	
	/******************************
	* this function deals with updating the information card, this data at the far left side of the screen. this function is entered when a mouse click on a unit or the player moves to a unit.
	*/
	private function useSwutchJumpTo(_p:Int = -1):Void
	{
		if (_p == -1) _p = Reg._gameDiceMaximumIndex[Reg._move_number_next];
		
		if (RegTriggers._highlightOnlyOuterUnits == true && _p > 27) return;

		if (RegTriggers._signatureGameUnitImage == true
		||  SignatureGameMain.background.visible == true 
		&& SignatureGameMain._displayCardDataOnceAfterDiceRoll == true
		|| SignatureGameMain._isInDebt == true)
		{
			//clear these text, because the next mouse click might be at a unit that does not need a table to populate its data.
			_tableColumnHeader1.text = "";
			_tableColumnHeader2.text = "";
			_tableColumnHeader3.text = "";			
			_tableColumn1Row1.text = "";
			_tableColumn1Row2.text = "";
			_tableColumn1Row3.text = "";
			_tableColumn1Row4.text = "";
			_tableColumn2Row1.text = "";
			_tableColumn2Row2.text = "";
			_tableColumn2Row3.text = "";
			_tableColumn2Row4.text = "";
			_tableColumn3Row1.text = "";
			_tableColumn3Row2.text = "";
			_tableColumn3Row3.text = "";		
			_tableColumn3Row4.text = "";
			
			// clear this information card because player has moved and player is doing option such as buying a land.  
			if (SignatureGameMain._buttonEndTurnOrPayNow != null && SignatureGameMain._unitBody[_p] != ""
			|| SignatureGameMain._isInDebt == true)
			{
				if (SignatureGameMain._buttonEndTurnOrPayNow.visible == true)
				{
					_unitImage.animation.stop();
					_unitImage.animation.play("frameInnerUnits");
					
					_textUnitTitle.text = "";
					_textUnitBody.text = "";
					
					//return;
				}
			}
			
			// this triggers an event at SignatureGameSelect, to display the unit image and title text of the unit selected to get out of debt with.
			if (SignatureGameMain._isInDebt == true) 
			{
				if (Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] - 1 != Reg._move_number_current)
				{
					// player does not own this land.
					SignatureGameMain._p2 = _p = -1;
					RegTriggers._displayDebtStuff = true;
					
					return;
				}
				else
				{
					SignatureGameMain._p2 = _p;
					RegTriggers._displayDebtStuff = true;
				}
			}
				
			unitInformation(_p);	
					
			_p = -1;
		}
	}
	
	
	public function unitInformation(_p:Int):Void
	{
		// this addresses a bug where if player is at one of the "fork in the road", such as _p value of 8, unit 7, the SignatureGameInformationCards.hx would populate data from unit 27.
		if (_p == 27 && Reg._gameYYnew2 == 7 && Reg._gameXXnew2 == 7
		||  _p == 27 && Reg._gameYYnew2 == 0 && Reg._gameXXnew2 == 0)
		{			
			_unitImage.animation.stop();
			_unitImage.animation.play("frameInnerUnits");
			
			_textUnitTitle.text = "Road Fork";
			_textUnitBody.text = "You could have access to the inner units.";
			return;
		}
		
		
		_textUnitTitle.text = _p + ": " + Std.string( SignatureGameMain._unitTitlesArray[_p]) + "."; // "unit
		
		if (SignatureGameMain._isMortgage[Reg._move_number_next][_p] > -1)
		{
			_unitImage.animation.stop();
			_unitImage.animation.play("frameInnerUnits");
			
			var _count:Int = 0;
	
			for (i in 0...28)
			{
				if (SignatureGameMain._isMortgageTitle[Reg._move_number_next][i] == SignatureGameMain._unitTitlesArray[_p])
				{
					// current unit in mortgage plus unit that asks for mortgage payment minus current location of piece.
					if (Reg._gameDiceMaximumIndex[Reg._move_number_next] > i)
					{
						_count = i + SignatureGameMain._isMortgageCouldLoseUnitAfterThisValue - Reg._gameDiceMaximumIndex[Reg._move_number_next];
					}
					// pay mortgage if unit has a lesser unit number then unit in mortgage.
					else if (Reg._gameDiceMaximumIndex[Reg._move_number_next] <= i)
					{
						// player just got mortgage. player is still at that unit. this code is needed. without it, the distance to the pay mortgage will be zero.
						if (Reg._gameDiceMaximumIndex[Reg._move_number_next] == i)
							_count = SignatureGameMain._isMortgageCouldLoseUnitAfterThisValue;
						// player is not at the unit in mortgage but has clicked on a unit in mortgage. this displays how much more to move piece until mortgage for that unit needs to be paid.							
						else _count = (i + SignatureGameMain._isMortgageCouldLoseUnitAfterThisValue - 28) - (Reg._gameDiceMaximumIndex[Reg._move_number_next]);
					}
				}
			}
						
			var _due:Float = 0;
			_due = _count;
			
			var _unit:String = "s";
			
			if (_due == 1) _unit = "";
			if (_due < 0) _due = 0;
			
			if (Reg._gameDiceMaximumIndex[Reg._move_number_next] < 28)
			{
				_textUnitBody.text = "This unit is mortgaged.\n\nMortgage will be due after you move to " + _due + " more unit" + _unit + ".";
			}
			
			else
			{
				_textUnitBody.text = "This unit is mortgaged.\n\nMortgage will be due after you move to " + SignatureGameMain._isMortgageCouldLoseUnitAfterThisValue + " more unit" + _unit + "."; 
			}
			
			return;
		}
		
		else if (SignatureGameMain._unitBody[_p] != "")
		{
			_unitImage.animation.stop();
			_unitImage.animation.play("frameInnerUnits");
						
			_textUnitBody.text = Std.string( SignatureGameMain._unitBody[_p]);
		}
		
		// displays the price of the unit currently selected.
		else if (SignatureGameMain._unitBuyingLandPrice[_p] > -1)
		{
			_unitImage.animation.stop();
			_unitImage.animation.play("frameOuterUnits");
		
			_textUnitBody.text = "Land Price: " + Std.string(Math.fround(SignatureGameMain._unitBuyingLandPrice[_p]));
			
			
			// if at these units, change the information box, the column at the table.
			if (_p == 4 || _p == 8 || _p == 18 || _p == 23) 
			_tableColumnHeader1.text = "Cab.";
			
			else if (_p == 5 || _p == 11 || _p == 17 || _p == 22) 
			_tableColumnHeader1.text = "Store.";
			
			else _tableColumnHeader1.text = "House.";
			
			
			_tableColumnHeader2.text = "Value.";
			
			if (_p == 4 || _p == 8 || _p == 18 || _p == 23) 
			_tableColumnHeader3.text = "Service.";
			
			else if (_p == 5 || _p == 11 || _p == 17 || _p == 22) 
			_tableColumnHeader3.text = "Service.";
			
			else _tableColumnHeader3.text = "Rent.";
			
			_tableColumn1Row1.text = "One";
			_tableColumn1Row2.text = "Two";
			_tableColumn1Row3.text = "Three";
			_tableColumn1Row4.text = "Four";
			
			// this gets _buyPriceForHouseTaxiCafe array from SignatureGameSelect.hx and then displays the cash value for the player Reg._move_number_next. _buyPriceForHouseTaxiCafe[0] array element is 1.4 more than the land value of that unit.
			
			// service price.
			_tableColumn2Row1.text = Std.string(Math.fround(SignatureGameMain._buyPriceForHouseTaxiCafe[0][_p]));
			_tableColumn2Row2.text = Std.string(Math.fround(SignatureGameMain._buyPriceForHouseTaxiCafe[1][_p]));
			_tableColumn2Row3.text = Std.string(Math.fround(SignatureGameMain._buyPriceForHouseTaxiCafe[2][_p]));
			_tableColumn2Row4.text = Std.string(Math.fround(SignatureGameMain._buyPriceForHouseTaxiCafe[3][_p]));
		
			// rent house price / 6.
			
			var _p2 = RegFunctions.getP(Reg._gameYYold, Reg._gameXXold);
			
			// is displaying a card after a dice room.
			if (Reg._gameYYold == -1 && Reg._gameXXold == -1)
			{
				for (yy in 0...8)
				{
					for (xx in 0...8)
					{
						if (Reg._gameDiceMaximumIndex[Reg._move_number_current] == Reg._gamePointValueForPiece[yy][xx] - 1)
						{
							// the player is able to click on a card to display it. when mouse click, these vars are set at a different class, but they are not set when the player's move ends. therefore we need to set the vars here to stop a crash.
							Reg._gameYYold = yy;
							Reg._gameXXold = xx;
							
							
						}
					}
				}
		
			}
			
			if (Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold] == 0)
			{
				_tableColumn3Row1.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[0][_p] / 6, 0));
				
				_tableColumn3Row2.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[1][_p] / 6, 0));
				
				_tableColumn3Row3.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[2][_p] / 6, 0));
				
				_tableColumn3Row4.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[3][_p] / 6, 0));
				
			}
			
			else
			{
				_tableColumn3Row1.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[0][_p] / 6 
				+ SignatureGameMain._groupBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p]
				+ SignatureGameMain._rentBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p], 0));
				
				_tableColumn3Row2.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[1][_p] / 6 
				+ SignatureGameMain._groupBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p]
				+ SignatureGameMain._rentBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p], 0));
				
				_tableColumn3Row3.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[2][_p] / 6 
				+ SignatureGameMain._groupBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p]
				+ SignatureGameMain._rentBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p], 0));
				
				_tableColumn3Row4.text = Std.string(FlxMath.roundDecimal(SignatureGameMain._buyPriceForHouseTaxiCafe[3][_p] / 6 
				+ SignatureGameMain._groupBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p]
				+ SignatureGameMain._rentBonus[Reg._gameUniqueValueForPiece[Reg._gameYYold][Reg._gameXXold]-1][_p], 0));
			}
		}
			
				
		SignatureGameMain._displayCardDataOnceAfterDiceRoll = false;
	}
	
	override public function update(elapsed:Float):Void 
	{				
		super.update(elapsed);
		
		if (Reg._gameOverForPlayer == false && Reg._gameId == 4
		|| RegTypedef._dataPlayers._spectatorPlaying == true && Reg._gameId == 4)
		{
			// remember the unit where you were at last move. that information card will be displayed next move.
			if (_signatureGameUnitNumberCurrent[Reg._move_number_next]
			!= _signatureGameUnitNumberSelect[Reg._move_number_next] && _signatureGameUnitNumberSelect[Reg._move_number_next] != -1)
			{
				_signatureGameUnitNumberCurrent[Reg._move_number_next]
			= _signatureGameUnitNumberSelect[Reg._move_number_next];
				
				useSwutchJumpTo(_signatureGameUnitNumberCurrent[Reg._move_number_next]);
			}
			
			// display the signature game card that has rent and houses, taxi or cafe information.
			if (RegTriggers._signatureGameUnitImage == false && Reg._gameDiceCurrentIndex[Reg._move_number_next] == Reg._gameDiceMaximumIndex[Reg._move_number_next]
			)
			{
				_p = -1;
				
				useSwutchJumpTo(_p);
				//TODO is this needed. RegTriggers._signatureGame = false;
			}
			
			// mouse click a unit not the number wheel.
			else if (ActionInput.justPressed() == true && RegTriggers._signatureGameUnitImage == true)
			{	
				// current mouse click values are stored in these Reg vars.
				var yy:Int = Reg._gameYYold;
				var xx:Int = Reg._gameXXold;
			
				if (ActionInput.coordinateX() > _startX + (xx * 75) 
				&& ActionInput.coordinateX() < _startX + 75 + (xx * 75) 
				&& ActionInput.coordinateY() > _startY + (yy * 75)
				&& ActionInput.coordinateY() < _startY + 75 + (yy * 75)
				)
				{				
					if (RegTriggers._signatureGameUnitImage == true)
						_p = Reg._gamePointValueForPiece[Reg._gameYYold][Reg._gameXXold] - 1;
								
					useSwutchJumpTo(_p);
					RegTriggers._signatureGame = false;
				}
			}
		}
	}

}