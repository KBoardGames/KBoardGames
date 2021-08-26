package;

/**
 * this button must be used only within a game such as a buy button or a trade button, also use this button for message boxes.
 * this class is created because triggering a button click when mouse is "pressed" also triggers a message box button. in short, when creating a button at the location of where a message box will be at, this class should be used.
 * @author kboardgames.com
 */
class ButtonUnique extends FlxUIButton
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
	public function new(x:Float = 0, y:Float = 0, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF000044, use_down_click:Bool = false, id:Int = 0)	
	{	
		super(x, y-5, text, onClick, false);
		
		_startX = x;
		_startY = y;
		_use_down_click = use_down_click;
		
		button_height += 10;
				
		resize(button_width, button_height);
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), 0xFFFFFFFF, FlxTextAlign.CENTER);
		label.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		autoCenterLabel();
		
		color = innerColor;
		if (id == 0) over_color = 0xFF00FF00;
		else 
		{
			color = 0xFF550000;
			over_color = 0xFFFFFFFF;
		}
		
		up_color = 0xFFFFFFFF;
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void 
	{		
		if (ActionInput.overlaps(this, null)
		&&  FlxG.mouse.justPressed == true
		&&  FlxG.mouse.enabled == true)
		{
			if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
			
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
				
		}
		
		if (RegTriggers._buttons_set_not_active == false) super.update(elapsed);

	}
}
