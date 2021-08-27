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
	private var _border:Int = 2;

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

	private var _timer:FlxTimer;
	private var _timer2:FlxTimer;
	
	/******************************
	 * from waiting room.
	 */
	private var _refresh_online_list:Bool = false;
	private var _id_refresh:Int = 0; // used as the id of the refresh online list.
	
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
	public function new(x:Float = 0, y:Float = 0, ?text:String, button_width:Int = 80, button_height:Int = 40, textSize:Int = 20, textColor:FlxColor = 0xFFFFFFFF, textPadding:Int = 0, ?onClick:Void->Void, innerColor:FlxColor = 0xFF000044, use_down_click:Bool = false, id:Int = 0, refresh_online_list:Bool = false, id_refresh:Int = 0)
	{
		super(x, y-7, text, onClick, false);

		_startX = x;
		_startY = y;
		
		_refresh_online_list = refresh_online_list;
		_id_refresh = id_refresh;

		_id = ID = id;
		_use_down_click = use_down_click;

		_button_width = button_width;
		_button_height = button_height;

		_timer = new FlxTimer();
		_timer2 = new FlxTimer();
		
		button_height += 10;

		_scrollarea_offset_x = 0;
		_scrollarea_offset_y = 0;

		resize(button_width, button_height);
		setLabelFormat(Reg._fontDefault, (Reg._font_size-1), 0xFFFFFFFF, FlxTextAlign.CENTER);
		label.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		autoCenterLabel();

		color = innerColor;
		over_color = 0xFF00FF00;
		up_color = 0xFFFFFFFF;
		
		_timer = new FlxTimer().start(3, makeActive, 1); // message box was closed. now do timer to delay the display of this button.
		_timer.active = false;
		
		_timer2 = new FlxTimer().start(3, makeActive2, 1); // lobby buttons
		_timer2.active = false;
	}
	
	override public function draw():Void
	{
		// daily quest, misc, create room, etc buttons.
		if (FlxG.mouse.justPressed == true
		&&	justPressed == true && _id == 0)
		{
			alpha = 0.3;
			over_color = 0xFFFFFFFF;
			
			Reg2._boxScroller_is_scrolling = false;
		}
		
		// lobby buttons.
		if (FlxG.mouse.justPressed == true
		&&	justPressed == true && _id == 2)
		{
			alpha = 0.3;
			over_color = 0xFFFFFFFF;
			_timer2.active = true; // do this code block once.
			_timer2.reset();
			_timer2.update(1);
			
			Reg2._lobby_button_alpha = 0.3;
			RegTriggers._buttons_set_not_active = true;
			Reg2._boxScroller_is_scrolling = false;
		}
		
		if (justReleased == true && _id == 1)
		{
			alpha = 0.3;
			over_color = 0xFFFFFFFF;
			active = false;
		}
		
		// buggy. does a double fire every once in a while. tested in neko.
		if (Reg._messageId == 0
		&&	_timer.active == false
		&&	over_color == 0xFFFFFFFF
		&&  alpha == 0.3
		&&	_id != 2	
		)
		{		
			_timer.active = true; // do this code block once.
			_timer.reset();
			_timer.update(1);
			
			Reg2._lobby_button_alpha = 0.3;
			Reg2._boxScroller_is_scrolling = false;
		}
		
		super.draw();
	}
	
	// this function must not be removed. also stops double firing of button sound at ActionKeyboard.hx.
	override public function update(elapsed:Float):Void
	{
		if (ActionInput.overlaps(this, null)
		&&  FlxG.mouse.justPressed == true
		&&  FlxG.mouse.enabled == true
		&&	alpha == 1) 
		{
			if (GameChatter._input_chat != null) GameChatter._input_chat.hasFocus = false;
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
				
			if (_id == 1) FlxG.mouse.enabled = false;	
			
		}
		
		
		// when pressing the refresh online user list button, this code is needed so that it populates the table without creating text and buttons.
		if (_refresh_online_list == true)
		{
			for (i in 0...120)
			{
				// no username found, so make this button off screen so that user cannot click it and its not visible,
				if ((i + 1) == _id_refresh) 
				{
					if (RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "")
					{
						label.text = "";
						y = 2000;
						visible = false;
					}
					
					else if (Reg._move_number_current == 0 && GameChatter._chatterIsOpen == false)
					{
						label.text = "Send";
						y = _startY;
						visible = true;
					}
				}			
			}
		}	

		if (RegTriggers._buttons_set_not_active == false)
		{
			if (alpha == 1
			&& _id != 2)
				super.update(elapsed);
			else
				super.update(elapsed);
				
		}
	}
	
	private function makeActive(i:FlxTimer):Void
	{
		over_color = 0xFF00FF00;
			
		FlxG.mouse.enabled = true;
			
		active = true;
		alpha = 1;			
		
		Reg2._boxScroller_is_scrolling = false;
		Reg2._lobby_button_alpha = 0.3;
	}
	
	private function makeActive2(i:FlxTimer):Void
	{
		over_color = 0xFF00FF00;
			
		FlxG.mouse.enabled = true;
			
		active = true;
		alpha = 1;			
		
		Reg2._boxScroller_is_scrolling = false;
		Reg2._lobby_button_alpha = 0.3;
	}
}
