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
class MessageBoxTradeProposal extends FlxGroup
{		
	/******************************
	* This sprite is the background of a message box.
	*/ 
    private var _messageBox:FlxSprite;
	
	public var _textTimer:FlxText; // keep message box open for 30 sec. this is the text to show how much time is remaining.
	
	private var _timeRemaining:Int = 30;
	private var _timeDo:Timer;
	private var _useTimer:Bool = false;
	
	/******************************
	 * the title text of the title box.
	 */
	private var _title:FlxText;
	
	/******************************
	* used to delay the display of a message.
	*/ 
	private var _keyPressed:Bool = false;
	
	/******************************
	* used to start the delay the display of a message.
	*/ 
	private var _startKeyPress:Bool = false;
	
	/******************************
	 * OK button.
	 */
	public var _button4:ButtonUnique;
	
	/******************************
	 * ok button that is only used when the cancel button is displayed. this is needed because this button's width is smaller than the other button that has the ok text.
	 */
	public var _button5:ButtonUnique;
	
	/******************************
	 * cancel button.
	 */
	public var _button6:ButtonUnique;
	
	/******************************
	 * the output message text. 
	 */
	public var _textMessage:FlxText;
	
	/******************************
	 * the output message OK button.
	 */
	public static var _buttonMessageOK:ButtonUnique;
	
	/******************************
	 * what type of message is open. 2 = normal message.
	 */
	private var _messageBoxNumber:Int;
	
	/******************************
	 * this var is true if at the output message;
	 */
	private var _displayMessage:Bool = false;
	
	/******************************
	 * used to determine what input field has focus.
	 */
	private var _tab:Int = 0;
	
	/******************************
	 * used to delay the display of the message box.
	 */
	private var _ticks:Float = 0;	
	
	/******************************
	 * when false, it might be the computer's turn to move and if computer triggered this message box, the buttons should not be mouse clicked by player.
	 */	
	public var _setButtonActive:Bool = true;
	
	/******************************
	 * if true, the _ticks var will be used to delay the display of the message box.
	 */
	private var _delayDisplayMessageBox:Bool = false;
	
	/******************************
	 * constructor.
	 * @param	_textForYesButton		the text instead of "Yes" for that button.
	 * @param	_textForNoButton		the text instead of "No" for that button.
	 * @param	setButtonActive			can the mouse be clickable or the 
	 keyboard used for those buttons.
	 * @param	_delayDisplayMessageBox	_ticks will be used to delay display of message box.
	 */
	public function new(_textForYesButton:String = "Yes", _textForNoButton:String = "No", setButtonActive:Bool = true, delayDisplayMessageBox = false) 
	{
		super();

		_setButtonActive = setButtonActive;
		_delayDisplayMessageBox = delayDisplayMessageBox;
		
		// the popup message box image.
		_messageBox = new FlxSprite(21, 16);
		_messageBox.loadGraphic("assets/images/signatureGame/unitInformation.png", true, 330);
		
		_messageBox.animation.add("tradeProposal", [1], 30, true);
		_messageBox.animation.play("tradeProposal");	

		_messageBox.scrollFactor.set(0, 0);
		_messageBox.visible = false;
		add(_messageBox);

		//#############################
		
		// the first popup message to display.
		_title = new FlxText(0, 0, 0, "Message.");
		_title.setFormat(Reg._fontDefault, 26, FlxColor.WHITE);
		_title.scrollFactor.set(0, 0);
		_title.setPosition(44, 33);
		_title.visible = false;
		add(_title);
				
		_button4 = new ButtonUnique((FlxG.width - 180) / 2 + 10, (FlxG.height - 343) / 2 + 249, "OK. ", 160 + 15, 35, 20, RegCustom._button_color, 0, output);
		_button4.label.font = Reg._fontDefault;
		_button4.visible = false;
		if (_setButtonActive == false) _button4.active = false;
		_button4.scrollFactor.set(0, 0);
		add(_button4);	
		
		//#############################
		// the text for this popup message. its a general trade unit message. not a log in or register message.
		_textMessage = new FlxText(0, 0, 295, "", 25);
		_textMessage.setFormat(Reg._fontDefault, 25, FlxColor.BLACK);
		_textMessage.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.PURPLE, 1);
		_textMessage.setPosition(44, 91);	
		_textMessage.text = "";
		_textMessage.visible = false;
		_textMessage.scrollFactor.set(0, 0);
		add(_textMessage);		
				
		// time remaining before message box closes.
		_textTimer = new FlxText(0, 0, 0, "", 26);
		_textTimer.setFormat(Reg._fontDefault, 26, FlxColor.WHITE);
		_textTimer.text = "";
		_textTimer.visible = true;
		_textTimer.setPosition(275, 33);
		_textTimer.scrollFactor.set(0, 0);
		add(_textTimer);
		
		if (_timeDo == null)
		_timeDo = new Timer(1000); // fire every second.
		
		_buttonMessageOK = new ButtonUnique((FlxG.width - 1204) / 2 + 10, (FlxG.height - 727) / 2 + 252, "OK. ", 160 + 15, 35, 20, RegCustom._button_color, 0, messageWasRead);
		_buttonMessageOK.label.font = Reg._fontDefault;
		_buttonMessageOK.visible = false;
		if (_setButtonActive == false) _buttonMessageOK.active = false;
		_buttonMessageOK.scrollFactor.set(0, 0);
		add(_buttonMessageOK);
		
		_button5 = new ButtonUnique((FlxG.width - 1204) / 2 - 60, (FlxG.height - 727) / 2 + 252, "D: " + _textForYesButton + ". ", 135 + 15, 35, 20, RegCustom._button_color, 0, messageWasRead);
		_button5.label.font = Reg._fontDefault;
		_button5.visible = false;
		if (_setButtonActive == false) _button5.active = false;
		_button5.scrollFactor.set(0, 0);
		add(_button5);	
		
		_button6 = new ButtonUnique((FlxG.width - 1204) / 2 + 105, (FlxG.height - 727) / 2 + 252, "F: " + _textForNoButton + ". ", 135 + 15, 35, 20, RegCustom._button_color, 0, cancelWasPressed);
		_button6.label.font = Reg._fontDefault;
		_button6.visible = false;
		if (_setButtonActive == false) _button6.active = false;
		_button6.scrollFactor.set(0, 0);
		add(_button6);
		
		_timeRemaining = 30;
		
	}
	
	override public function destroy()
	{
		FlxG.mouse.enabled = false;
		_timeDo.stop();
		
		if (_buttonMessageOK != null)
		{
			remove(_buttonMessageOK);
			_buttonMessageOK.destroy();
		}
		
		if (_button4 != null)
		{
			remove(_button4);
			_button4.destroy();
		}
		
		if (_button5 != null)
		{
			remove(_button5);
			_button5.destroy();
		}
			
		if (_button6 != null)
		{
			remove(_button6);
			_button6.destroy();
		}
		
		super.destroy();
		
	}
	
	override public function update(elapsed:Float):Void 
	{			
		// show the message box with this var is true.
		if (_delayDisplayMessageBox == true)
		{
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
					
			if (_ticks >= 15) 
			{
				popupMessageShow();
			}
		}
		
		if (_useTimer == true)
		{
			_timeDo.run = function() 
			{
				// minus 1 from total move var.
				if (_timeRemaining > 0)	_timeRemaining -= 1;

				_textTimer.text = formatTime(_timeRemaining);			
				if (_timeRemaining <= 0) moveZeroReached();
			}
		}
		
		if (GameChatter._input_chat != null)
		{
			if (GameChatter._input_chat.hasFocus == true)
			{
				return;
			}
		}
		
				
		super.update(elapsed);
	}	
	
	private function formatTime(_time:Int):String
	{
		// to get the number of full minutes, divide the number of total seconds by 60 (60 seconds / minute):
		var _minutes = Math.floor(_time / 60);
		
		// And to get the remaining seconds, multiply the full minutes with 60 and subtract from the total seconds:
		var _seconds = _time - _minutes * 60;
		
		if (_seconds < 10) return _minutes + ":0" + _seconds;
		else return _minutes + ":" + _seconds;
	}
	

	private function moveZeroReached():Void
	{
		_timeDo.stop();
		Reg._yesNoKeyPressValueAtTrade = 2; // cancel key was pressed.
		popupMessageHide();				
	}	
	
	private function messageWasRead():Void
	{
		_timeDo.stop();
		Reg._yesNoKeyPressValueAtTrade = 1; // ok key was pressed.
		popupMessageHide();			
	}
	
	/******************************
	 * this function is called when the user submits a request to either login or register.
	 */
	public function output():Void
	{		
		var str:String = "";		
		
		display("", str);
	
	}
	
	public function display(str2:String = "Message.", str1:String):Void
	{		
		Reg._keyOrButtonDown = false;
		
		// message.	
		_textMessage.text = str1;
		_title.text = str2; // if changing the default title text.
		
		_displayMessage = true;
		_startKeyPress = true;	
	}
	
	/******************************
	 * a different kind of message box will be displayed depending on what vars are passed to this function.
	 * @param	tabPara					0 and 1 = inoutTextField. 2 = output button.					
	 * @param	messageBoxNumberPara	0=login and register buttons. 1 = login or register popup message. 2 = output popup message.
	 * @param	displayMessagePara		if false then the message will be hidden.
	 * @param	useYesNoButtons			should the cancel button be displayed?
	 */
	public function createMessage(tabPara:Int, messageBoxNumberPara:Int, displayMessagePara:Bool, useYesNoButtons:Bool, useTimer:Bool = false):Void
	{
		_tab = tabPara; 
		_messageBoxNumber = messageBoxNumberPara;		
		_displayMessage = displayMessagePara;
		
		Reg._popupMessageUseYesNoButtons.push(true);
		Reg._popupMessageUseYesNoButtons[Reg._popupMessageUseYesNoButtons.length - 1] = useYesNoButtons;
		
		_useTimer = useTimer;
	}

	public function cancelWasPressed():Void
	{	
		_timeDo.stop();
		Reg._yesNoKeyPressValueAtTrade = 2; // cancel key was pressed.
		popupMessageHide();
	}
	
		
	public function popupMessageShow():Void
	{
		if (_delayDisplayMessageBox == true && _ticks < 15)
		{
			return;
		}	
		
		_ticks = 0;
		
		// this stops a bug where another message of the same title is seen when pressing the ok button when changing states. hence, return to lobby button was clicked and two message boxes displayed one after another.
		if (Reg._clearDoubleMessage == true)
		{
			Reg._clearDoubleMessage = false;
			_displayMessage = false;
		}
		
		
		#if neko
			for (i in 0...3333333){} // used to delay the display of this message box.
		#end
		
		#if cpp
			for (i in 0...3333333){}
		#end	
		
		
		
		if (Reg._doUpdate == false && Reg._buttonCodeValues == "" && _displayMessage == false || Reg._loginSuccessfulWasRead == true && Reg._buttonCodeValues == "") 
		{
			//Reg._loginSuccessfulWasRead = true; 
			return;		
		} 
	
		_messageBox.visible = true;
		_title.visible = true;
		
		// if true then show the message, such as, an error or a login message attempt.
		if (_displayMessage == true)
		{
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			
			_textMessage.visible = true;			
			
			if (Reg._popupMessageUseYesNoButtons[Reg._popupMessageUseYesNoButtons.length - 1] == true)
			{
				_button5.visible = true;
				_button6.visible = true;
			} else _buttonMessageOK.visible = true;
		}	
		
		// _messageBoxNumber is normal message.
		else if (_messageBoxNumber == 2 && _displayMessage == false)
		{
			_button4.visible = true;
			_messageBox.visible = true;
		}
	}							 
	
	public function popupMessageHide():Void
	{
		FlxG.mouse.enabled = false;
		Reg._popupMessageUseYesNoButtons.pop();

		_messageBox.visible = false;
		_textTimer.visible = false;
		
		// account.
		_title.visible = false;
		_button4.visible = false;
		
		// message.
		_textMessage.visible = false;
		_buttonMessageOK.visible = false;
		_button5.visible = false;
		_button6.visible = false;		
	}
}