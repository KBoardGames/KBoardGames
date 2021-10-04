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
 * use this button when no data at anytime will be sent to server or when player cannot click anything else to trigger an overload at server. The ButtonGeneralNetworkYes class is used to stop server floods. if flooding is not possible with the feature being clicked then use this class.
 * @author kboardgames.com
 */
class ButtonGeneralNetworkNo extends FlxUIButton
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
	private var _border:Int = 2;

	/******************************
	 *if id is needed then it is passed to this class constructor then this id is assigned to that parameter so that this id can be used at update() and at update only the code for a button with this id will be executed.
	 * if id = 0, button will not be alpha.
	 * if id = 1, button will stay alpha until message box is closed.
	 * if id = 2, button will alpha and stay alpha until timer has ended.
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
	 * @param	_innerColor		The color behind the text.
	 */
	public function new(x:Float = 0, y:Float = 0, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF000066, use_down_click:Bool = false, id:Int = 0)
	{
		super(x, y-7, text, onClick, false, false, RegCustom._button_color[Reg._tn]);

		_startX = x;
		_startY = y;
		
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
		
		var _lineStyle = { thickness: 8.0, color: RegCustom._button_border_color[Reg._tn]};
		FlxSpriteUtil.drawRect(this, 0, 0, _button_width, _button_height + 10, innerColor, _lineStyle);
		
		_timer = new FlxTimer().start(3, makeActive, 1);
		_timer.active = false;
	}
	
	/******************************
	 * function used to set the button back to alpha 1 after time expires.
	 */
	private function makeActive(i:FlxTimer):Void
	{
		if (_id == 2)
		{
			active = true;
			alpha = 1;
			
			Reg2._scrollable_area_is_scrolling = false;
		}
	}
	
	override public function draw():Void
	{
		// if a button has an id greater then 0 then make alpha for only 1 second. message box with an id of 1 will be set to alpha 1 after a message box has closed.
		if (justReleased == true && _id > 0)
		{
			_timer.update(1);
			
			alpha = 0.3;
			active = false;
			
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		// continues to check button that has an id of 1 and if no message box is open than set to alpha 1.
		if (Reg._messageId == 0 && _id == 1
		)
		{
			active = true;
			alpha = 1;	
			
			FlxG.mouse.enabled = true;
			Reg2._scrollable_area_is_scrolling = false;
		}
		
		super.draw();
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void
	{				
		if (alpha == 1 && _id == ID
		&&	RegTriggers._buttons_set_not_active == false)
		{
			if (justPressed == true)
			{
				// this button has been pressed. remove focus from the chatter input box.
				if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
				
				if (RegCustom._sound_enabled[Reg._tn] == true)
				{				
					if (Reg2._scrollable_area_is_scrolling == false
					&&	Reg._tn > 0
					||	Reg2._scrollable_area_is_scrolling == false
					&&	Reg._tn == 0 // theme named default.
					&&	FlxG.mouse.y <= 50
					&&  Reg2._scrollable_area_is_scrolling == false
					||	Reg._tn == 0 // theme named default.
					&&	FlxG.mouse.y >= FlxG.height - 50
					&&  Reg2._scrollable_area_is_scrolling == false
					||	Reg._at_configuration_menu == false)
						FlxG.sound.play("click", 1, false);
						
					else if (Reg2._scrollable_area_is_scrolling == false)
						FlxG.sound.play("buzz", 1, false);
					
				}
			}
			
			super.update(elapsed);
		}
	}
	
}//