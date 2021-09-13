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

#if !MOBILE
	import flixel.input.keyboard.FlxKey;
#end

/**
 * NOTE this message box is not the same as the others. if (Reg._buttonCodeValues == "l1020") is added at the end of this file.
 * @author kboardgames.com
 */
class MessageBox extends FlxGroup
{	
	/******************************
	 * when true, the message box will follow the cursor until the mouse button is released.
	 */
	private var _messageBoxFollowCursor:Bool = false;
	
	/******************************
	* This sprite is the background of a message box.
	*/ 
    private var _messageBox:FlxSprite;
	
	/******************************
	 * the title text of the title box.
	 */
	private var _title:FlxText;	
	
	/******************************
	 * "x" button. top right corner on this message box image.
	 */
	private var _button1:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * the output message text. 
	 */
	public static var _textMessage:FlxText;
	
	
	public var _textTimer:FlxText; // keep message box open for 30 sec. this is the text to show how much time is remaining.
		
	/******************************
	 * the output message OK button.
	 */
	public var _buttonMessageOK:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * ok button that is only used when the cancel button is displayed. this is needed because this button's width is smaller than the other button that has the ok text.
	 */
	public var _button5:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * cancel button.
	 */
	public var _button6:ButtonAlwaysActiveNetworkYes;
	
	private var _timeRemaining:Int = 30;
	private var _timeDo:Timer;
	private var _useTimer:Bool = false;	
	
	/******************************
	* used to delay the display of a message.
	*/ 
	private var _keyPressed:Bool = false;
	
	/******************************
	 * what type of message is open. 2 = normal message.
	 */
	private var _messageBoxNumber:Int;
	
	/******************************
	 * this var is true if at the output message;
	 */
	public static var _displayMessage:Bool = false;
	
	/******************************
	 * used to determine what input field has focus.
	 */
	private var _tab:Int = 0;
		
	/******************************
	 * when false, it might be the computer's turn to move and if computer triggered this message box, the buttons should not be mouse clicked by player.
	 */	
	public var _setButtonActive:Bool = true;
	
	private var _id:Int = 0;
	private var _jumpToOldPositions:Bool = false;
	
	/******************************
	 * constructor.
	 * @param	_textForYesButton		the text instead of "Yes" for that button.
	 * @param	_textForNoButton		the text instead of "No" for that button.
	 * @param	setButtonActive			can the mouse be clickable or the 
	 keyboard used for those buttons.
	 */
	public function new(id:Int, _textForYesButton:String = "Yes", _textForNoButton:String = "No", setButtonActive:Bool = true, displayMessage:Bool = true, useYesNoButtons:Bool = false, useTimer:Bool = false, title:String = "", message:String = "") 
	{
		super();
		
		ID = _id = id;
		
		_displayMessage = displayMessage;
		_useYesNoButtons = useYesNoButtons;
		_useTimer = useTimer;

		_displayMessage = true;
					
		_setButtonActive = setButtonActive;
		
		// the popup message box image.
		_messageBox = new FlxSprite(Reg2._messageBox_x, Reg2._messageBox_y);
		_messageBox.loadGraphic("assets/images/messageBox.png", false);		
		_messageBox.scrollFactor.set(0, 0);
		_messageBox.visible = false;
		add(_messageBox);
		
		//#############################
		// the first popup message to display.
		_title = new FlxText(0, 0, 0, "Message.");
		_title.setFormat(Reg._fontDefault, 26, FlxColor.WHITE);
		_title.scrollFactor.set(0, 0);
		_title.setPosition(Reg2._messageBox_x + Reg2._title_x, Reg2._messageBox_y + Reg2._title_y);
		_title.visible = false;
		_title.scrollFactor.set(0, 0);
		add(_title);
		
		if (_button1 != null) _button1.destroy();
		_button1 = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button1_x, Reg2._messageBox_y + Reg2._button1_y + 5, "X", 45, 35, 20, RegCustom._button_text_color, 0, buttonX, 0xFFCC0000, false);
		_button1.visible = false;
		_button1.scrollFactor.set(0, 0);
		_button1.label.font = Reg._fontDefault;
		add(_button1);
			
		//#############################
		// a popup message that has a general message. not a log in or register message.
		_textMessage = new FlxText(0, 0, 580, "", 25);
		_textMessage.setFormat(Reg._fontDefault, 25, FlxColor.BLACK);
		_textMessage.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.PURPLE, 1);
		_textMessage.setPosition(Reg2._messageBox_x + Reg2._textMessage_x, Reg2._messageBox_y + Reg2._textMessage_y);	
		_textMessage.text = "";
		_textMessage.visible = false;
		_textMessage.scrollFactor.set(0, 0);
		add(_textMessage);		
		
		// time remaining before message box closes.
		_textTimer = new FlxText(0, 0, 0, "", 26);
		_textTimer.setFormat(Reg._fontDefault, 26, FlxColor.WHITE);
		_textTimer.text = "";
		_textTimer.setPosition(Reg2._messageBox_x + Reg2._textTimer_x, Reg2._messageBox_y + Reg2._textTimer_y);
		_textTimer.scrollFactor.set(0, 0);
		add(_textTimer);
		
		if (_timeDo == null)
		_timeDo = new Timer(1000); // fire every second.
		
		if (_buttonMessageOK != null) _buttonMessageOK.destroy();
		_buttonMessageOK = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._buttonMessageOK_x, Reg2._messageBox_y + Reg2._buttonMessageOK_y + 5, "OK", 160 + 15, 35, 20, 0xffffffff, 0, messageWasRead, RegCustom._button_color);
		_buttonMessageOK.label.font = Reg._fontDefault;
		_buttonMessageOK.visible = false;
		if (_setButtonActive == false) _buttonMessageOK.active = false;
		_buttonMessageOK.scrollFactor.set(0, 0);
		add(_buttonMessageOK);
		
		if (_button5 != null) _button5.destroy();
		_button5 = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button5_x, Reg2._messageBox_y + Reg2._button5_y + 5, _textForYesButton, 135 + 15, 35, 20, 0xffffffff, 0, messageWasRead, RegCustom._button_color);
		_button5.label.font = Reg._fontDefault;
		_button5.visible = false;
		if (_setButtonActive == false) _button5.active = false;
		_button5.scrollFactor.set(0, 0);
		add(_button5);	
		
		if (_button6 != null) _button6.destroy();
		_button6 = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button6_x, Reg2._messageBox_y + Reg2._button6_y + 5, _textForNoButton, 135 + 15, 35, 20, 0xffffffff, 0, cancelWasPressed, RegCustom._button_color);
		_button6.label.font = Reg._fontDefault;
		_button6.visible = false;
		if (_setButtonActive == false) _button6.active = false;
		_button6.scrollFactor.set(0, 0);
		add(_button6);
		
		_timeRemaining = 30;		
				
		// message.	
		_title.text = title; // if changing the default title text.
		_textMessage.text = message;
		
		popupMessageShow();
	}
	
	override public function destroy()
	{		
		_timeDo.stop();
		
		if (_buttonMessageOK != null)
		{
			remove(_buttonMessageOK);
			_buttonMessageOK.destroy();
		}
		
		if (_button1 != null)
		{
			remove(_button1);
			_button1.destroy();
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
		if (Reg._messageId == _id)
		{
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
			
		}

		super.update(elapsed);
	}
	
	private function hideButtons():Void
	{
		_messageBox.visible = false;
		
		// account.
		_title.visible = false;
		_button1.visible = false;
		
		// message.
		_textMessage.visible = false;
		_buttonMessageOK.visible = false;
		_button5.visible = false;
		_button6.visible = false;
		_textTimer.visible = false;
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
		Reg._yesNoKeyPressValueAtTrade = 2; // cancel key was pressed.
		popupMessageHide();	
	}	
	
		
	private function messageWasRead():Void
	{
		if (Reg._messageId == _id)
		{
			Reg._yesNoKeyPressValueAtMessage = 1; // ok key was pressed.
			
			// button does not fire when this code is in the button class.
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
				
			popupMessageHide();
		}
	}
	
	/******************************
	 * this function is called when the user submits a request to either login or register.
	 */
	public function output():Void
	{		
		if (Reg._messageId == _id)
		{
			var str:String = "";		
			
			display("", str);
		}
	}
	
	public function display(str2:String, str1:String):Void
	{		
		if (Reg._messageId == _id)
		{
			Reg._keyOrButtonDown = false;
			
			// disable title of dialog.
			str2 = "";
			
			// message.	
			_title.text = str2; // if changing the default title text.
			_textMessage.text = str1;
			
			_displayMessage = true;
		}
	}
	
	/******************************
	 * this var is needed when only a dialog ok button is displayed. closing a dialog box using the "X" will have a Reg._yesNoKeyPressValueAtMessage of value 3 but this sets it to 1. the reason is because while playing a game of chess for example, and the game ends in checkmate, the exit and restart buttons are hidden until a dialog button is clicked, but if pressing the "x" then those exit and restart buttons will remain hidden because its looking for a Reg._yesNoKeyPressValueAtMessage value of 1.
	 * look at function buttonX() for how this var is used.
	 */
	private var _useYesNoButtons:Bool;
	
	/******************************
	 * a different kind of message box will be displayed depending on what vars are passed to this function.
	 * @param	tabPara					0 and 1 = inoutTextField. 2 = output button.					
	 * @param	messageBoxNumberPara	0=login and register buttons. 1 = login or register popup message. 2 = output popup message.
	 * @param	displayMessagePara		if false then the message will be hidden.
	 * @param	useYesNoButtons			the cancel button will be displayed when this value is false.
	 */
	public function createMessage(tabPara:Int, messageBoxNumberPara:Int, displayMessagePara:Bool, useYesNoButtons:Bool = false, useTimer:Bool = false):Void
	{
		if (Reg._messageId == _id)
		{
			_tab = tabPara; 
			_messageBoxNumber = messageBoxNumberPara;		
			_displayMessage = displayMessagePara;
			_useYesNoButtons = useYesNoButtons;
			_useTimer = useTimer;
		}
	}

	public function cancelWasPressed():Void
	{	
		if (Reg._messageId == _id)
		{
			Reg._yesNoKeyPressValueAtMessage = 2; // cancel key was pressed.
			//Reg._buttonCodeValues = "";
			
			// button does not fire when this code is in the button class.
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
				
			popupMessageHide();
		}
	}
	
	private function buttonX():Void
	{	
		if (Reg._messageId == _id)
		{
			if (_useYesNoButtons == true) Reg._yesNoKeyPressValueAtMessage = 3;
			else Reg._yesNoKeyPressValueAtMessage = 1;
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			
			// button does not fire when this code is in the button class.
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
				
			popupMessageHide();
		}	
		
	}
	
	public function popupMessageShow():Void
	{			
		if (Reg._messageId == _id)
		{			
			// this stops a bug where another message of the same title is seen when pressing the ok button when changing states. hence, return to lobby button was clicked and two message boxes boxes displayed one after another.
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
			_button1.visible = true;
			
			// if true then show the message, such as, an error or a login message attempt.
			if (_displayMessage == true)
			{
				FlxG.mouse.reset();
				FlxG.mouse.enabled = true;
				
				_textMessage.visible = true;			
				
				if (_useYesNoButtons == true)
				{
					_button5.visible = true;
					_button6.visible = true;
				}	
				
				else _buttonMessageOK.visible = true;						
			}				
		}  							 
	}
	
	
	public function popupMessageHide():Void
	{			
		if (Reg._messageId == _id)
		{
			FlxG.mouse.enabled = true;
			Reg2._message_box_just_closed = true;
			
			// make lobby active after kick/ban message box is mouse clicked.
			if (Reg._buttonCodeValues == "l1020")
			{
				Reg._buttonCodeValues = "";
				RegTriggers._lobby = true;
			}
			
			Reg._messageFocusId.pop();
			if (Reg._messageFocusId[Reg._messageFocusId.length - 1] > 0)
			Reg._messageId = Reg._messageFocusId[Reg._messageFocusId.length-1];
			else Reg._messageId = 0;
			
			if (Reg._buttonCodeFocusValues[Reg._buttonCodeFocusValues.length - 1] != null)
			Reg._buttonCodeValues = Reg._buttonCodeFocusValues[Reg._buttonCodeFocusValues.length - 1];
			Reg._buttonCodeFocusValues.pop();
			
			hideButtons();	
			
			RegTriggers._buttons_set_not_active = false;
			
			destroy();			
			
			
		} 
	}
}//