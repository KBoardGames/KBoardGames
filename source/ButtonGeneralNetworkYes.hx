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

package;
import openfl.geom.ColorTransform;

/**
 * use this button when at anytime after a button click there will be data sent to the server, such as restarting a game or returning to lobby. if an exit button is clicked then use the ButtonGeneral class. the reason is that no other buttons can be triggered. there is no way to overload the server.

 * @author kboardgames.com
 */
class ButtonGeneralNetworkYes extends FlxUIButton
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var.
	 */
	public var _startX:Float = 0;

	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var.
	 */
	public var _startY:Float = 0;

	/******************************
	 * Thickness of the buttons border
	 */
	private var _border:Float = 2;

	/******************************
	 *if id is needed then it is passed to this class constructor then this id is assigned to that parameter so that this id can be used at update() and at update only the code for a button with this id will be executed.
	 * if _id = 1, do the display 2 seconds after message box was closed,
	 */
	private var _id:Int = 0;

	/******************************
	 * at the constructor when a down click is set, as soon as the user input is pressed this class instance will fire.
	 */
	private var _use_down_click:Bool = true;

	/******************************
	 * used at __scrollable_area to offset the mouse x/y coordinates when the __scrollable_area is scrolled. without these vars when the __scrollable_area is scrolled stage buttons underneath the __scrollable_area will fire.
	 * remember, a group is added to the stage and the group is added to the __scrollable_area. So the two buttons, one not seen because it is behind the __scrollable_area camera, will fire unless these vars are used.
	 */
	public static var _scrollarea_offset_x:Float;

	/******************************
	 * used at __scrollable_area to offset the mouse x/y coordinates when the __scrollable_area is scrolled. without these vars when the __scrollable_area is scrolled stage buttons underneath the __scrollable_area will fire.
	 * remember, a group is added to the stage and the group is added to the __scrollable_area. So the two buttons, one not seen because it is behind the __scrollable_area camera, will fire unless these vars are used.
	 */
	public static var _scrollarea_offset_y:Float;

	/******************************
	 * width of the button.
	 */
	public var _button_width:Int = 0;

	/******************************
	 * height of the button.
	 */
	public var _button_height:Int = 0;

	private var _timer:FlxTimer;
	private var _timer2:FlxTimer;
	private var _timer3:FlxTimer;
	
	/******************************
	 * from waiting room.
	 */
	private var _refresh_online_list:Bool = false;
	private var _id_refresh:Int = 0; // used as the id of the refresh online list.
	
	private var _colorTransform:ColorTransform;
	private var _innerColor:FlxColor;
	private var _text:String;
	
	/**
	 * @param	x				The x location of the button on the screen.
	 * @param	y				The y location of the button on the screen.
	 * @param	text			The button's text.
	 * @param	button_width		Width of the button.
	 * @param	button_height	Height of the button.
	 * @param	textSize		Font size of the text.
	 * @param	textColor		The color of the text.
	 * @param	textPadding		The padding between the button and the text.
	 * @param	onClick			When button is clicked this is the function to go to. The function name without the ()?
	 * @param	innerColor		The color behind the text.
	 */
	public function new(x:Float = 0, y:Float = 0, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF000066, use_down_click:Bool = false, id:Int = 0, refresh_online_list:Bool = false, id_refresh:Int = 0)
	{
		super(x, y-7, text, onClick, false, false, RegCustom._button_color[Reg._tn]);

		_startX = x;
		_startY = y;
	
		_text = text;
		
		_refresh_online_list = refresh_online_list;
		_id_refresh = id_refresh;

		_id = ID = id;
		_use_down_click = use_down_click;

		_button_width = button_width;
		_button_height = button_height;
				
		_timer = new FlxTimer();
		_timer2 = new FlxTimer();
		_timer3 = new FlxTimer();
		
		button_height += 10;

		_scrollarea_offset_x = 0;
		_scrollarea_offset_y = 0;
		
		resize(button_width, button_height);
		
		// sets the label color and centers the text. the label color is the color of the button.
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), RegCustom._button_text_color[Reg._tn], FlxTextAlign.CENTER);
		
		// this is the shadow underneath the text.
		label.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		autoCenterLabel();
		
		_innerColor = innerColor;
		var _lineStyle = { thickness: 8.0, color: RegCustom._button_border_color[Reg._tn]};
		FlxSpriteUtil.drawRect(this, 0, 0, _button_width, _button_height + 10, _innerColor, _lineStyle);
		
		_timer = new FlxTimer().start(2, makeActive, 1); // not lobby button id of 2
		_timer.active = false;
		
		_timer2 = new FlxTimer().start(3, makeActive, 1); // id 2, lobby buttons. used when entering a room.
		_timer2.active = false;
		
		_timer3 = new FlxTimer().start(1.2, makeActive, 1); // lobby buttons after message box closes. boxes such as, room full or someone beat you to the room message.
		_timer3.active = false;
		
		//colorTransform = new ColorTransform(0, 0, 0.3);
	}
	
	private function makeActive(i:FlxTimer):Void
	{
		FlxG.mouse.enabled = true;
		active = true;
		alpha = 1;			
		
		Reg2._scrollable_area_is_scrolling = false;
		Reg2._lobby_button_alpha = 0.3;
	}
	
	override public function draw():Void
	{
		// daily quest, misc, create room, online list, etc buttons.
		if (FlxG.mouse.justPressed == true
		&&	justPressed == true && _id <= 200
		&&	Reg2._message_box_just_closed == false
		&& _id == ID
		||	FlxG.mouse.justPressed == true
		&&	justPressed == true 
		&&	_id >= 7000
		&&	_id <= 8000
		&&	Reg2._message_box_just_closed == false
		&& _id == ID)
		{
			alpha = 0.3;			
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		if (FlxG.mouse.justPressed == true
		&&	justPressed == true && _id == 2
		&&	Reg._buttonCodeValues != "")
		{
			alpha = 0.3;
			_timer2.active = true; // do this code block once.
			_timer2.reset();
			_timer2.update(1);
			
			Reg2._lobby_button_alpha = 0.3;
			RegTriggers._buttons_set_not_active = true;
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		if (justReleased == true && _id >= 1000 && _id <= 2000
		||	Reg._buttonCodeValues != "" && _id < 1000
		&&	MessageBox._displayMessage == true
		&& _id == ID)
		{
			alpha = 0.3;
			
			_timer.active = true; // do this code block once.
			_timer.reset();
			_timer.update(1);
			
			Reg2._scrollable_area_is_scrolling = false;
			
		}
		
		if (Reg._messageId == 0
		&&	_timer.active == false
		&&  alpha == 0.3
		&&	Reg._buttonCodeValues == ""
		&& _id == ID
		)
		{		
			_timer.active = true; // do this code block once.
			_timer.reset();
			_timer.update(1);
			
			Reg2._lobby_button_alpha = 0.3;
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		// make alpha 1 for lobby buttons but after message box closes.
		if (_timer3.active == false
		&&  alpha == 0.3
		&&	Reg._buttonCodeValues != ""
		)
		{
			_timer3.active = true; // do this code block once.
			_timer3.reset();
			_timer3.update(1);
			
			Reg2._lobby_button_alpha = 0.3;
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		super.draw();
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void
	{
		if (RegTriggers._buttons_set_not_active == false
		&& _id == ID)
		{		
			if (ActionInput.overlaps(this, null)
			&&  FlxG.mouse.justPressed == true
			&&  FlxG.mouse.enabled == true
			&&	alpha == 1) 
			{
				// this button has been pressed. remove focus from the chatter input box.
				if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
				
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&  Reg2._scrollable_area_is_scrolling == false)
					FlxG.sound.play("click", 1, false);
					
				if (_id == 1
				||	_id >= 1000
				&&	_id <= 2000) FlxG.mouse.enabled = false;	
				
			}		
		}
		
		// when pressing the refresh online user list button, this code is needed so that it populates the table without creating text and buttons.
		if (_refresh_online_list == true)
		{
			for (i in 0...120)
			{
				// no username found, so make this button off screen so that user cannot click it and its not visible,
				if ((i + 7000) == _id_refresh) 
				{
					if (RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "")
					{
						label.text = "";
						y = 2000;
						visible = false;
					}
					
					else //if (Reg._move_number_current == 0 && GameChatter._chatterIsOpen == false)
					{
						label.text = "Send";
						y = _startY;
						visible = true;
					}
				}			
			}
		}	
		
		if (alpha == 1 && _id == ID) super.update(elapsed);
				
		if (Reg._at_lobby == true
		&&	Reg._buttonCodeValues != ""
		&&	Reg2._message_box_just_closed == true)
		{
			Reg2._message_box_just_closed = false;
			RegTypedef._dataMisc._room = 0;
			Reg._buttonCodeValues = "";
			alpha = 1;
			Reg2._lobby_button_alpha = 0.3;
			Reg2._scrollable_area_is_scrolling = false;
		}
		
	}
	
}
