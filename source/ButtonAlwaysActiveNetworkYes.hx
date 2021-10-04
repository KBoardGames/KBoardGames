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
 * the buttons in this class is displayed always overtop of any other button or image on a scene. the reason is because these buttons are called from a sub state. these buttons that can be created at this class are only created at the MessageBox.hx class. then that class displays the message box with a yes/no or ok button, all other buttons on the scene cannot be clicked. when that message box first displays, it calls a trigger which stops the other buttons from updating. see super.update in these button class.

 * @author kboardgames.com
 */
class ButtonAlwaysActiveNetworkYes extends FlxUIButton
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
	
	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * Thickness of the buttons border
	 */
	private var _border:Int = 2;
	
	/******************************
	 *if id is needed then it is passed to this class constructor then this id is assigned to that parameter so that this id can be used at update() and at update only the code for a button with this id will be executed.
	 */
	private var _id:Int = 0;
	
	/******************************
	 * at the constructor when a down click is set, as soon as the user input is pressed this class instance will fire.
	 */	 
	private var _use_down_click:Bool = true;
	
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
	public function new(x:Float = 0, y:Float = 0, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF000066, use_down_click:Bool = false, id:Int = 0)	
	{	
		super(x, y-5, text, onClick, false, false, RegCustom._button_color[Reg._tn]);
		
		_startX = x;
		_startY = y;
		_use_down_click = use_down_click;
		
		button_height += 10;
		
		resize(button_width, button_height);
		
		// sets the label color and centers the text. the label color is the color of the button.
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), RegCustom._button_text_color[Reg._tn], FlxTextAlign.CENTER);
		
		// this is the shadow underneath the text.
		label.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		autoCenterLabel();
		
		var _lineStyle = { thickness: 8.0, color: RegCustom._button_border_color[Reg._tn]};
		FlxSpriteUtil.drawRect(this, 0, 0, button_width, button_height, innerColor, _lineStyle);
		
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void 
	{
		if (ActionInput.overlaps(this, null)
		&&  FlxG.mouse.justPressed == true
		&&  FlxG.mouse.enabled == true)
		{
			// this button has been pressed. remove focus from the chatter input box.
			if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
		}
		
		super.update(elapsed);

	}
}