/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * NOTE this message box is not the same as the others. if (Reg._buttonCodeValues == "l1020") is added at the end of this file.
 * @author kboardgames.com
 */
class MessageBox extends FlxGroup
{
	/******************************
	 * used to deplay the display of the message box.
	 */
	private var _ticks:Float = 0;
	
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
	private var _button_x:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * the output message text. 
	 */
	private var _textMessage:FlxText;
	
	
	public var _textTimer:FlxText; // keep message box open for 30 sec. this is the text to show how much time is remaining.
		
	/******************************
	 * the OK button.
	 */
	private var _button_ok:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * yes button that is only used when the no button is displayed. 
	 */
	private var _button_yes:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * no button.
	 */
	private var _button_no:ButtonAlwaysActiveNetworkYes;
	
	/******************************
	 * time remaining before the message box closes.
	 */
	private var _timeRemaining:Int = 30;
	
	/******************************
	 * create the timer if timer does not exist. also used to run the timer.
	 */
	private var _timeDo:Timer;
	
	/******************************
	 * should the timer be used for this mesage box instance?
	 */
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
	
	/******************************
	 * instance id.
	 */
	private var _id:Int = 0;
	
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
		
		//SceneGameRoom.messageBoxMessageOrder();
		_ticks = 0;
		
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
		
		if (_button_x != null) _button_x.destroy();
		_button_x = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button_x_x, Reg2._messageBox_y + Reg2._button_x_y + 5, "X", 45, 35, 20, RegCustom._button_text_color[Reg._tn], 0, buttonX, 0xFFCC0000, false);
		_button_x.visible = false;
		_button_x.active = false;
		_button_x.scrollFactor.set(0, 0);
		_button_x.label.font = Reg._fontDefault;
		add(_button_x);
			
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
		
		if (_button_ok != null) _button_ok.destroy();
		_button_ok = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button_ok_x, Reg2._messageBox_y + Reg2._button_ok_y + 5, "OK", 160 + 15, 35, 20, 0xffffffff, 0, messageWasRead, RegCustom._button_color[Reg._tn]);
		_button_ok.label.font = Reg._fontDefault;
		_button_ok.visible = false;
		_button_ok.active = false;
		if (_setButtonActive == false) _button_ok.active = false;
		_button_ok.scrollFactor.set(0, 0);
		add(_button_ok);
		
		if (_button_yes != null) _button_yes.destroy();
		_button_yes = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button_yes_x, Reg2._messageBox_y + Reg2._button_yes_y + 5, _textForYesButton, 135 + 15, 35, 20, 0xffffffff, 0, messageWasRead, RegCustom._button_color[Reg._tn]);
		_button_yes.label.font = Reg._fontDefault;
		_button_yes.visible = false;
		_button_yes.active = false;
		if (_setButtonActive == false) _button_yes.active = false;
		_button_yes.scrollFactor.set(0, 0);
		add(_button_yes);	
		
		if (_button_no != null) _button_no.destroy();
		_button_no = new ButtonAlwaysActiveNetworkYes(Reg2._messageBox_x + Reg2._button_no_x, Reg2._messageBox_y + Reg2._button_no_y + 5, _textForNoButton, 135 + 15, 35, 20, 0xffffffff, 0, cancelWasPressed, RegCustom._button_color[Reg._tn]);
		_button_no.label.font = Reg._fontDefault;
		_button_no.visible = false;
		_button_no.active = false;
		if (_setButtonActive == false) _button_no.active = false;
		_button_no.scrollFactor.set(0, 0);
		add(_button_no);
		
		_timeRemaining = 30;		
				
		// message.	
		_title.text = title; // if changing the default title text.
		_textMessage.text = message;
		
		popupMessageShow();
	}
	
	private function hideButtons():Void
	{
		_messageBox.visible = false;
		
		// account.
		_title.visible = false;
		_button_x.visible = false;
		_button_x.active = false;
		
		// message.
		_textMessage.visible = false;
		_button_ok.visible = false;
		_button_ok.active = false;
		_button_yes.visible = false;
		_button_yes.active = false;
		_button_no.visible = false;
		_button_no.active = false;
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
			_ticks = 0;
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
			
			popupMessageHide();
		}
	}
	
	private function buttonX():Void
	{	
		if (Reg._messageId == _id)
		{
			if (_useYesNoButtons == true) Reg._yesNoKeyPressValueAtMessage = 3;
			else Reg._yesNoKeyPressValueAtMessage = 1;
			
			popupMessageHide();
		}	
		
	}
	
	public function popupMessageShow():Void
	{			
		if (Reg._messageId == _id)
		{
			RegTriggers._buttons_set_not_active = false;
			
			if (_ticks < 4)
			{
				return;
			}	
			
			_ticks = 6;
			
			hideButtons();

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
			
			_messageBox.visible = true;
			_title.visible = true;
			_button_x.active = true;
			_button_x.visible = true;
			
			// if true then show the message, such as, an error or a login message attempt.
			if (_displayMessage == true)
			{
				_textMessage.visible = true;			
				
				if (_useYesNoButtons == true)
				{
					_button_yes.active = true;
					_button_yes.visible = true;
					_button_no.active = true;
					_button_no.visible = true;
				}	
				
				else 
				{
					_button_ok.active = true;
					_button_ok.visible = true;						
				}
			}				
		}  							 
	}
	
	public function popupMessageHide():Void
	{			
		if (Reg._messageId == _id)
		{
			_ticks = 0;
			Reg2._message_box_just_closed = true;
			
			// make lobby active after kick/ban message box is mouse clicked.
			if (Reg._buttonCodeValues == "l1020")
			{
				Reg._buttonCodeValues = "";
				RegTriggers._lobby = true;
			}
			
			Reg._message_id_temp = 0;
			
			Reg._messageFocusId.pop();
			if (Reg._messageFocusId[Reg._messageFocusId.length - 1] > 0)
			Reg._messageId = Reg._messageFocusId[Reg._messageFocusId.length-1];
			else Reg._messageId = 0;
			
			if (Reg._buttonCodeFocusValues[Reg._buttonCodeFocusValues.length - 1] != null)
			Reg._buttonCodeValues = Reg._buttonCodeFocusValues[Reg._buttonCodeFocusValues.length - 1];
			Reg._buttonCodeFocusValues.pop();
	
			
			// make lobby active after kick/ban message box is mouse clicked.
			/*if (Reg._buttonCodeValues == "l1020")
			{
				Reg._buttonCodeValues = "";
				RegTriggers._lobby = true;
			}*/
			
			hideButtons();	
			
			RegTriggers._buttons_set_not_active = false;
			
			for (i in 0...3)
			{
				Reg._ticks_button_100_percent_opacity[i] = 0;
			}
			
			Reg._buttonDown = false;
			Reg._button_clicked = false;
			
			destroy();		
		} 
	}	
	
	override public function destroy()
	{		
		_timeDo.stop();
		_ticks = 0;
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
			_title = null;
		}
		
		if (_messageBox != null)
		{
			remove(_messageBox);
			_messageBox.destroy();
			_messageBox = null;
		}
		
		if (_textMessage != null)
		{
			remove(_textMessage);
			_textMessage.destroy();
			_textMessage = null;
		}
	
		if (_button_ok != null)
		{
			remove(_button_ok);
			_button_ok.destroy();
		}
		
		if (_button_x != null)
		{
			remove(_button_x);
			_button_x.destroy();
			_button_x = null;
		}
		
		if (_button_yes != null)
		{
			remove(_button_yes);
			_button_yes.destroy();
			_button_yes = null;
		}
			
		if (_button_no != null)
		{
			remove(_button_no);
			_button_no.destroy();
			_button_no = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._messageId == _id)
		{
			_ticks = RegFunctions.incrementTicks(_ticks, 60 / Reg._framerate);
			
			if (_ticks < 6) 
			{
				popupMessageShow();
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
			
		}

		else
		{
			hideButtons();
			_ticks = 0;
		}
		
		if (Reg._messageFocusId.length == 0) 
		{
			Reg2.resetMessageBox();
			_ticks = 0;
		}
		
		super.update(elapsed);
	}
	
}//