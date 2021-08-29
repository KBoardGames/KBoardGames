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
 * buttons used within the signature game such as trade button or buy button.
 * @author kboardgames.com
 */
class ButtonToggleSignatureGame extends FlxUIButton
{
	/******************************
	 * Thickness of the buttons border
	 */
	private var _border:Int = 2;
	
	/******************************
	 *if id is needed then it is passed to this class constructor then this id is assigned to that parameter so that this id can be used at update() and at update only the code for a button with this id will be executed.
	 */
	private var _id:Int = 0;
	
	/******************************
	 * the id of the selected button.
	 */
	private static var _id_selected:Int = 0;
	
	/******************************
	 * at the constructor when a down click is set, as soon as the user input is pressed this class instance will fire.
	 */	 
	private var _use_down_click:Bool = true;
	
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
	 * @param	innerColor		The color behind the text?
	 */
	public function new(x:Float = 0, y:Float = 0, id:Int, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF550000, use_down_click:Bool = false)	
	{	
		super(x, y-5, text, onClick, false);
	
		_id = ID = id;
		_use_down_click = use_down_click;
		
		button_height += 10;
				
		resize(button_width, button_height);
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), 0xFFffffff, FlxTextAlign.CENTER);
		label.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		autoCenterLabel();
		
		// sets the first button as toggled.
		if (_id == 1)
		{
			color = 0xFF005500; // yellow
			_id_selected = 1;			
		}
			
		else color = innerColor; // red
		
		over_color = 0xFFFFFFFF;
		up_color = 0xFFFFFFFF;
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void 
	{	
		if (ActionInput.overlaps(this, null)
		&&  FlxG.mouse.justPressed == true)
		{
			if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
			
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
		}
		
		if (RegTriggers._buttons_set_not_active == false) super.update(elapsed);
	}
}// 