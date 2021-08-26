package;
import flixel.FlxObject;

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
	 * used at __boxScroller to offset the mouse x/y coordinates when the __boxScroller is scrolled. without these vars when the __boxScroller is scrolled stage buttons underneath the __boxscroller will fire.
	 * remember, a group is added to the stage and the group is added to the __boxScroller. So the two buttons, one not seen because it is behind the __boxscroller camera, will fire unless these vars are used.
	 */
	public static var _scrollarea_offset_x:Float;
	
	/******************************
	 * used at __boxScroller to offset the mouse x/y coordinates when the __boxScroller is scrolled. without these vars when the __boxScroller is scrolled stage buttons underneath the __boxscroller will fire.
	 * remember, a group is added to the stage and the group is added to the __boxScroller. So the two buttons, one not seen because it is behind the __boxscroller camera, will fire unless these vars are used.
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
	public function new(x:Float = 0, y:Float = 0, id:Int, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, _innerColor:FlxColor = 0xFF550000, use_down_click:Bool = false)	
	{	
		super(x, y - 5, text, onClick, false);
		
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
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), 0xFFffffff, FlxTextAlign.CENTER);
		label.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		autoCenterLabel();
		
		// sets the first button as toggled.
		if (_id == 1)
		{
			color = 0xFF005500; // green
			_id_selected = 1;			
		}
			
		else color = _innerColor; // red

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
}
