/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

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

	/******************************
	 * from waiting room.
	 */
	private var _refresh_online_list:Bool = false;
	private var _id_refresh:Int = 0; // used as the id of the refresh online list.
	
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
		// do not use. this feature needs to remain hardcoded.
		use_down_click = false;
		
		super(x, y-7, text, onClick, false, false, RegCustom._button_color[Reg._tn]);

		_startX = x;
		_startY = y;
	
		_text = text;
		if (_text == "") visible = false;
		
		_refresh_online_list = refresh_online_list;
		_id_refresh = id_refresh;

		_id = ID = id;
		_use_down_click = use_down_click;

		_button_width = button_width;
		_button_height = button_height;
		
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
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}	
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void
	{
		if (_id == ID)
		{
			if (FlxG.mouse.pressed == false && justReleased == true && Reg._buttonDown == true)
			{
				// this button has been pressed. remove focus from the chatter input box.
				if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
				
				if (RegCustom._sound_enabled[Reg._tn] == true
				&&	Reg2._scrollable_area_is_scrolling == false
				&&	Reg._tn == 0)
				{
					FlxG.sound.play("error", 1, false);
				}	
			}
		}
		
		if (Reg._buttonCodeValues == "")
		{
			if (Reg._ticks_button_100_percent_opacity[0] == 0 
			&&	Reg._ticks_button_100_percent_opacity[1] == 0
			&&	Reg._ticks_button_100_percent_opacity[2] == 0
			&&	Reg._messageId == 0)
				alpha = 1;
			else
				alpha = 0.3;
		}
		
		else if (Reg._buttonCodeValues != ""
		&&	Reg._disconnectNow == false)
		{
			alpha = 0.3;
		}
		
		// when pressing the refresh online user list button, this code is needed so that it populates the table without creating text and buttons.
		if (Reg._at_waiting_room == true && _refresh_online_list == true)
		{
			// no username found, so make this button off screen so that user cannot click it and its not visible,
			if (_id_refresh >= 7000 && _id_refresh <= 8000) 
			{
				if (RegTriggers._waiting_room_refresh_invite_list == true 
				||	Reg._usernamesOnline[(_id_refresh - 7000)] == ""
				||	SceneWaitingRoom.__title_bar._spinner.visible == true)
				{
					label.text = "";
					y = 2000;
					visible = false;
					super.update(elapsed);
				}
				
				else
				{
					label.text = "Send";
					y = _startY - 14;
					visible = true;
					if (alpha == 1) super.update(elapsed);
				}
			}			
		
		}	
		
		if (Reg2._message_box_just_closed == true)
		{
			Reg2._message_box_just_closed = false;
			
			if (Reg._at_lobby == true) 
				RegTypedef._dataMisc._room = 0;
			
			// this creates a bug at NewAccount where two mouse clicks are needed to return to lobby.
			//if (RegTypedef._dataMisc._userLocation == 0
			//&&	Reg._buttonCodeValues != "s9") // esc hotkey.
			//	Reg._buttonCodeValues = "";
			
			Reg._ticks_button_100_percent_opacity[0] = 0; 
			Reg._ticks_button_100_percent_opacity[1] = 0;
			Reg._ticks_button_100_percent_opacity[2] = 0;
			
			if (Reg._messageId == 0) alpha = 1;
		}
		
		if (Reg._ticks_button_100_percent_opacity[0] == 0
		&&	Reg._ticks_button_100_percent_opacity[1] == 0
		&&	Reg._ticks_button_100_percent_opacity[2] == 0
		&&	alpha == 1 && _id == ID
		||	Reg._at_input_keyboard == true && _id == 10000 && _id == ID)
		{
			super.update(elapsed);
		}
	}
	
	override function onOverHandler():Void
	{
		Reg._buttonDown = true;
		super.onOverHandler();
	}
	
	override function onOutHandler():Void
	{
		Reg._buttonDown = false;
		super.onOutHandler();
	}
}
