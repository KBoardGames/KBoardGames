/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * use these toggle buttons when changed to a new FlxState. if using more than one FlxGroup in the FlxState then use a different class. the reason is that the buttons in this class are created with a different id and if using two FlxGroup that call the same class then there could be two id with the same value. The problem would be that at the second FlxGroup could not use the id of 1 because the first FlxGroup used it and that button could not be set as toggled by default.
 * @author kboardgames.com
 */
class ButtonToggleFlxState extends FlxUIButton
{
	/******************************
	 * Thickness of the buttons border
	 */
	private var _border:Int = 2;
	
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	public var _startX:Float = 0;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	public var _startY:Float = 0;
	
	/******************************
	 *if id is needed then it is passed to this class constructor then this id is assigned to that parameter so that this id can be used at update() and at update only the code for a button with this id will be executed.
	 */
	private var _id:Int = 0;
	
	/******************************
	 * the id of the selected button.
	 */
	public static var _id_selected:Int = 0;
	
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
	
	/** 
	 * @param	x				The x location of the button on the screen?
	 * @param	y				The y location of the button on the screen?
	 * @param	text			The button's text?
	 * @param	button_width		Width of the button?
	 * @param	button_height	Height of the button?	
	 * @param	textSize		Font size of the text?
	 * @param	textColor		The color of the text?
	 * @param	textPadding		The padding between the button and the text?
	 * @param	onClick			When button is clicked this is the function to go to. The function name without the ()?
	 * @param	_innerColor		The color behind the text?
	 */
	public function new(x:Float = 0, y:Float = 0, id:Int, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, _innerColor:FlxColor = 0xFF000066, use_down_click:Bool = false)	
	{	
		super(x, y - 5, text, onClick, false, false, RegCustom._button_color[Reg._tn]);
		
		_startX = x;
		_startY = y;
		
		_id = ID = id;
		_use_down_click = use_down_click;
		
		button_height += 10;
		
		_button_width = button_width;
		_button_height = button_height;
		
		_scrollarea_offset_x = 0;
		_scrollarea_offset_y = 0;
		
		resize(button_width, button_height);
		
		// sets the label color and centers the text. the label color is the color of the button.
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), RegCustom._button_text_color[Reg._tn], FlxTextAlign.CENTER);
		
		// this is the shadow underneath the text.
		label.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		autoCenterLabel();
		
		// sets the first button as toggled.
		if (_id == 1) _id_selected = 1;			
		
		var _lineStyle = { thickness: 8.0, color: RegCustom._button_border_color[Reg._tn]};
		FlxSpriteUtil.drawRect(this, 0, 0, _button_width, _button_height, _innerColor, _lineStyle);

		
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void 
	{
		if (ActionInput.overlaps(this, null)
		&&  FlxG.mouse.justPressed == true)
		{
			// this button has been pressed. remove focus from the chatter input box.
			if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
			
			if (RegCustom._sound_enabled[Reg._tn] == true
			&&  Reg2._scrollable_area_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
		}
		
		if (Reg._buttonCodeValues == "")
		{
			Reg2._lobby_button_alpha = 1;
			alpha = 1;
		}
		
		else if (Reg._buttonCodeValues != ""
		&&	Reg._disconnectNow == false)
		{
			alpha = 0.3;
		}
		
		if (alpha == 1 && _id == ID) super.update(elapsed);
		
	}
}
