package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
 * @author kboardgames.com
 */
class MenuConfigurationsProfile extends FlxGroup
{
	private var __action_keyboard:ActionKeyboard;
	
	private var _offset_x:Int = -50;
	private var _offset_y:Int = 50;
	private var _offset:Int = 30;	
	
	/******************************
	 * when this button is pressed, at the avatar scene, name field and profile avatar changes to display player 1's data.
	 */
	public var _button_p1:ButtonToggleFlxState;
	public var _button_p2:ButtonToggleFlxState;
	
	/******************************
	 * this holds the avatars. value starts at 0. access members here.
	 */
	private var _group_sprite:Array<FlxSprite> = [];
	
	/******************************
	 * this is the image of the avatar for profile.
	 */
	public var _image_profile_avatar:FlxSprite;
	
	/******************************
	 * this image will highlight an avatar when a touch input (mouse, finger) is located at an avatar.
	 */
	private var _image_avatar_highlighted:FlxSprite;
		
	/******************************
	* anything added to this group will be placed inside of the boxScroller field. 
	*/
	public var _group:FlxSpriteGroup;	
	
	/******************************
	 * value starts at 0. access members here.
	 */
	private var _group_button:Array<ButtonGeneralNetworkNo> = [];
	
	/******************************
	 * profile instructions at top of scene.
	 */
	private var _profile_general_instructions:FlxText;
	
	/******************************
	 * type in the login username.
	 */
	public var _usernameInput:FlxInputText;
	
	private var _profile_avatar_notice:FlxText; // the text for this ui is from the _text_current_avatar_for_player var.
	
	/******************************
	 * this var changed as the player 1 and player 2 buttons are toggled.
	 */
	private var _text_current_avatar_for_player:String = "This is the current avatar for player ";
	
	private var __menu_configurations_output:MenuConfigurationsOutput;
	
	/******************************
	 * needed to move the cursor of the inputText because a var can get the value of a caret but cannot for some reason set the value to the caret index.
	 */
	private var _caretIndex:Int = 0;
	
	override public function new(menu_configurations_output:MenuConfigurationsOutput):Void
	{
		super();
		__menu_configurations_output = menu_configurations_output;
		
		sceneProfile();
	}
		
	private function sceneProfile():Void
	{
		__menu_configurations_output._title.screenCenter(X); // needed again because we changed the text length.
		
		_group = cast add(new FlxSpriteGroup());
		_group_button.splice(0, _group_button.length);
		
		var _text_title_player = new FlxText(0, 100, 0, "Player username and avatar");
		_text_title_player.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_text_title_player.screenCenter(X);
		_group.add(_text_title_player);
		
		_profile_general_instructions = new FlxText(15, 0, 0, "1: Select either player 1 or player 2 button below.\n2: Type in a username. If you want to play online then use the username you signed up with at the website forum.\n3: Select an avatar you would like to use while playing a game.");
		_profile_general_instructions.setFormat(Reg._fontDefault, Reg._font_size);
		_profile_general_instructions.fieldWidth = FlxG.width - 90;
		_profile_general_instructions.y = _text_title_player.y + 50;
		_group.add(_profile_general_instructions);
		
		_button_p1 = new ButtonToggleFlxState(0, 0, 1, "Player 1", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buttonP1);
		_button_p1.screenCenter(X);
		_button_p1.x -= 97;
		_button_p1.color = 0xFF005500;
		// TODO set_toggled must be before has_toggle or the save will not work when click event has not fired somewhere other than this input widget.
		_button_p1.set_toggled(true);
		_button_p1.has_toggle = true;
		_button_p1.y = _profile_general_instructions.y + _profile_general_instructions.height + 15;
		_group.add(_button_p1);
		
		_button_p2 = new ButtonToggleFlxState(_button_p1.x + 180 + 15, 200, 1, "Player 2", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buttonP2);
		_button_p2.color = 0xFF550000;
		_button_p2.set_toggled(false);
		_button_p2.has_toggle = false;
		_button_p2.y = _button_p1.y;
		_group.add(_button_p2);
		
		var _text_username = new FlxText(15, 0, 0, "Username");
		_text_username.setFormat(Reg._fontDefault, Reg._font_size);
		_text_username.y = _button_p1.y + 65;
		_group.add(_text_username);	
		
		// type username here.
		_usernameInput = new FlxInputText(15, 0, 152, "", 22);
		_usernameInput.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
		_usernameInput.x += _text_username.textField.width + 15;
		_usernameInput.y = _button_p1.y + 65;
		if (RegCustom._profile_username_p1 != "Guest 1")
			_usernameInput.text = RegCustom._profile_username_p1;
		_group.add(_usernameInput);
		
		// fix a bug where typing in the username input field puts the second character before the first character.
		_usernameInput.caretIndex = _usernameInput.text.length;
		
		var _text_title_avatar = new FlxText(0, 100, 0, "Avatar");
		_text_title_avatar.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.ORANGE);
		_text_title_avatar.screenCenter(X);
		_text_title_avatar.y = _usernameInput.y + 65;
		_group.add(_text_title_avatar);
		
		_profile_avatar_notice = new FlxText(15, 250, 0, _text_current_avatar_for_player + "1");
		_profile_avatar_notice.setFormat(Reg._fontDefault, Reg._font_size);
		_profile_avatar_notice.fieldWidth = FlxG.width - 90;
		_profile_avatar_notice.y = _text_title_avatar.y + 55;
		_group.add(_profile_avatar_notice);
		
		_image_profile_avatar = new FlxSprite(15, 300);
		_image_profile_avatar.loadGraphic("multiavatar/"+ RegCustom._profile_avatar_number1);
		_image_profile_avatar.y = _profile_avatar_notice.y + 50;
		_group.add(_image_profile_avatar);		
		
		var _avatar_notice = new FlxText(15, 0, 0, "Select an avatar that you would like to use while playing games in offline mode. That means you are not playing a game with players around the world. Select the avatar then click the save button to save that avatar to your offline profile. Selecting the first avatar will not hide that avatar when playing a game.");
		_avatar_notice.setFormat(Reg._fontDefault, Reg._font_size);
		_avatar_notice.fieldWidth = FlxG.width - 90;
		_avatar_notice.y = _image_profile_avatar.y + 100;
		_group.add(_avatar_notice);
		
		_group_sprite.splice(0, _group_sprite.length);
		
		// used to position the avatars on rows.
		var _y:Float = 0;
		var _x:Float = 0;
		
		for (i in 0... Reg._avatar_total)
		{			
			var _image_avatar = new FlxSprite(0, 0);
			_image_avatar.loadGraphic("multiavatar/"+ i +".png");
			_image_avatar.visible = false;
			_group.add(_image_avatar);
			
			_group_sprite.push(_image_avatar);
			
			// this number refers to how many avatars on displayed on a row.
			if (_x > 10)
			{
				_y += 100; // when the amount of avatars on a row is reached then..
				_x = 0; // .. set x back to default and increase y so that the avatars will display on the next row.
			}
			
			_group_sprite[i].setPosition(15 + (102 * _x), _avatar_notice.y + _avatar_notice.height + 15 + _y + 2);
				
			_x += 1;	
			
			_group_sprite[i].visible = true;
			_group.add(_group_sprite[i]);
		}
		
		// when clicking on a game image, this image has a border that highlighted it.
		// all gameboards images are stored in frames.
		_image_avatar_highlighted = new FlxSprite(0, 0);
		_image_avatar_highlighted.setPosition(15, _avatar_notice.y + _avatar_notice.height + 15 + 2);
		_image_avatar_highlighted.loadGraphic("assets/images/avatarBorder.png", true, 75, 75); // height is the same value as width.
		_image_avatar_highlighted.animation.add("play", [0, 1], 10, true);
		_image_avatar_highlighted.animation.play("play");
		_image_avatar_highlighted.updateHitbox();
		_group.add(_image_avatar_highlighted);
		
		var _text_empty = new ButtonGeneralNetworkNo(0, _group_sprite[Reg._avatar_total-1].y + 300, "", 100, 35, Reg._font_size, 0xFFCCFF33, 0, null);
		_text_empty.visible = false;
		_group.add(_text_empty);
	}
	
	/******************************
	 * this function is called when a button at this class is clicked.
	 */
	private function buttonNumber(_num:Int):Void
	{
		switch (_num)
		{
			case 0: //
		}
	}
	
	private function buttonP1():Void
	{
		_profile_avatar_notice.text = _text_current_avatar_for_player + "1";
				
		if (_button_p1.has_toggle == false)
		{
			RegCustom._profile_username_p2 = _usernameInput.text;
			
			if (RegCustom._profile_username_p1 == "Guest 1") _usernameInput.text = "";
			else _usernameInput.text = RegCustom._profile_username_p1;
		}
		
		_image_profile_avatar.loadGraphic("multiavatar/" + RegCustom._profile_avatar_number1);
		
		_button_p1.color = 0xFF005500;
		_button_p1.set_toggled(true);
		_button_p1.has_toggle = true;
		
		_button_p2.color = 0xFF550000;
		_button_p2.set_toggled(false);
		_button_p2.has_toggle = false;
	}
	
	private function buttonP2():Void
	{
		_profile_avatar_notice.text = _text_current_avatar_for_player + "2";
		
		if (_button_p2.has_toggle == false)
		{
			RegCustom._profile_username_p1 = _usernameInput.text;
		
			if (RegCustom._profile_username_p2 == "Guest 2") _usernameInput.text = "";
			else _usernameInput.text = RegCustom._profile_username_p2;
		}
		
		_image_profile_avatar.loadGraphic("multiavatar/" + RegCustom._profile_avatar_number2);
		
		_button_p2.set_toggled(true);
		_button_p2.color = 0xFF005500;
		_button_p2.has_toggle = true;
		
		_button_p1.color = 0xFF550000;
		_button_p1.set_toggled(false);
		_button_p1.has_toggle = false;
	}
	
	override public function update(elapsed:Float):Void
	{
		// if keyboard is open then set some stuff as not active.
		if (RegTriggers._keyboard_opened == true)
		{
			_group.active = false;
			
			// username field was clicked.
			if (Reg2._input_field_number == 1)
			{
				_usernameInput.active = true;
			}
			
		}
		
		else
		{
			_group.active = true;
		}
		
		//----------------------------
		if (_group.visible == true
		&&  RegTriggers._keyboard_opened == false)
		{
			_image_avatar_highlighted.visible = false;
			
			for (i in 0... Reg._avatar_total)
			{
				// __boxscroller.scroll.y is needed so that when the boxScroller has been scrolled that var is used to offset the mouse.y value. it is needed to highlight avatars that are outside of the normal scene y coordinates
				if (FlxG.mouse.x > _group_sprite[i].x
				&&  FlxG.mouse.x < _group_sprite[i].x + 75
				&&  FlxG.mouse.y + __menu_configurations_output.__boxscroller.scroll.y > _group_sprite[i].y
				&&  FlxG.mouse.y + __menu_configurations_output.__boxscroller.scroll.y < _group_sprite[i].y + 75
				&&  FlxG.mouse.y < FlxG.height - 50)
				{					
					_image_avatar_highlighted.x = 
						_group_sprite[i].x;
					_image_avatar_highlighted.y = 
						_group_sprite[i].y;
					
					_image_avatar_highlighted.visible = true;
					
					if (ActionInput.justPressed() == true)
					{
						if (RegCustom._enable_sound == true
						&&  Reg2._boxScroller_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
						
						if (_button_p1.has_toggle == true)
							RegCustom._profile_avatar_number1 = Std.string(i) + ".png";
						else 
							RegCustom._profile_avatar_number2 = Std.string(i) + ".png";
							
						_image_profile_avatar.loadGraphic("multiavatar/" + i +".png");
					}
				} 
			}
		}
		
		//#############################
		// username input field.
		// if mouse click then a widget will have focus.
		if (_usernameInput.hasFocus == true) 
		{
			if (_usernameInput.text == "") _usernameInput.caretIndex = 0;
			
			// these are needed so that the input field can be set back to focused after a keyboard button press.
			Reg2._input_field_caret_location = _usernameInput.caretIndex;
			Reg2._input_field_number = 1;
		}
				
		// if input field was in focus and a keyboard key was pressed...
		if (Reg2._input_field_number == 1
		&& Reg2._key_output != "")
		{
			_usernameInput.hasFocus = true; // set the field back to focus.
						
			if (Reg2._key_output == "FORWARDS")
			{
				Reg2._key_output = "";
				
				if (_caretIndex > 0) 
				{
					_caretIndex -= 1;
					_usernameInput.caretIndex = _caretIndex;
				}
				
				else _usernameInput.caretIndex = 0;
			}
			
			else if (Reg2._key_output == "BACKWARDS")
			{
				Reg2._key_output = "";
				
				if (_caretIndex < _usernameInput.text.length) 
				{
					_caretIndex += 1;
					_usernameInput.caretIndex = _caretIndex;
				}
				
				else _usernameInput.caretIndex = _usernameInput.text.length;
			}
			
			else if (Reg2._key_output == "DELETE")
			{
				_usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
				
				// get from start of text to cursor.
				var _str_start = _usernameInput.text.substr(0, _usernameInput.caretIndex);
				
				// and the end.
				var _str_end = _usernameInput.text.substr(_str_start.length, _usernameInput.text.length);
				
				// then delete one character at the cursor.
				_usernameInput.text = _str_start.substr(0, _str_start.length - 1) + _str_end;
				
				// this is needed because we are removing a character therefore the position of the caret should change.
				if (_usernameInput.caretIndex > 0) 
				{
					_usernameInput.caretIndex -= 1;
					_caretIndex -= 1;
				}
				
				Reg2._key_output = "";
			}
			
			else // add a letter.
			{
				// if cursor is at the end of the line.
				if (_usernameInput.text.length-1 == _usernameInput.caretIndex)
				{
					_usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					
					if (Reg2._key_output == "SPACE") _usernameInput.text += " ";
					else _usernameInput.text += Reg2._key_output;
					
					Reg2._key_output = "";
				}
				
				else
				{
					_usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					// get from start of text to cursor.
					var _str_start = _usernameInput.text.substr(0, _usernameInput.caretIndex);
					// and the end.
					var _str_end = _usernameInput.text.substr(_usernameInput.caretIndex, _usernameInput.text.length);
					
					// output the text of the input field from the value set with the keyboard.
					if (Reg2._key_output == "SPACE")
					{
						_usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						_usernameInput.text = _str_start + " " + _str_end;
					
						// this is needed because we are removing a character therefore the position of the caret should change.
						_usernameInput.caretIndex += 1;
					}
									
					else 
					{
						_usernameInput.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						// at one character at cursor.
						_usernameInput.text = _str_start + Reg2._key_output + _str_end;
						// this is needed because we are removing a character therefore the position of the caret should change.
						_usernameInput.caretIndex += 1;
						_caretIndex += 1;
					}
					
					Reg2._key_output = "";
				}
			}
			
		}
		
				
		if (RegTriggers._keyboard_open == true)
		{
			RegTriggers._keyboard_open = false;
			RegTriggers._keyboard_opened = true;

			#if mobile
				if (__action_keyboard != null)
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
				
				if (__action_keyboard == null)
				{
					__action_keyboard = new ActionKeyboard();
					add(__action_keyboard);
				}
				
				__action_keyboard.drawButtons();
			#end
		}
		
		if (RegTriggers._keyboard_close == true)
		{
			RegTriggers._keyboard_close = false;

			#if mobile
				if (__action_keyboard != null) 
				{
					__action_keyboard.close();
					remove(__action_keyboard);
					__action_keyboard = null;
				}
			#end
		}
		
		if (_usernameInput.hasFocus == true)
		{
			_usernameInput.fieldBorderColor = FlxColor.RED;			
			_usernameInput.fieldBorderThickness = 3;
		}
		else
		{
			_usernameInput.fieldBorderColor = FlxColor.BLACK;			
			_usernameInput.fieldBorderThickness = 1;
				
		}
		
		//------------------------------
		if (_button_p1.has_toggle == true) 
			RegCustom._profile_username_p1 = _usernameInput.text;
		
		if (_button_p2.has_toggle == true) 
			RegCustom._profile_username_p2 = _usernameInput.text;
				
		//-------------------------------
		
		for (i in 0... _group_button.length)
		{
			// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
			if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width && FlxG.mouse.justPressed == true )
			{
				buttonNumber(i);
				
				break;
			}
			
			// if same as above but mouse is not pressed.
			else if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height 
			&& FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width)
			{
				_group_button[i].active = true;
				_group_button[i].label.color = 0xFF00FF00;
				
				break;
			}
			// if mouse is not at a button that set it not active.
			else if (FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y < _group_button[i]._startY 
			||  FlxG.mouse.y + ButtonGeneralNetworkNo._scrollarea_offset_y > _group_button[i]._startY + _group_button[i]._button_height
			||  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x < _group_button[i]._startX 
			||  FlxG.mouse.x + ButtonGeneralNetworkNo._scrollarea_offset_x > _group_button[i]._startX + _group_button[i]._button_width)			
			{
				if (_group_button[i].label.color == 0xFFFFFFFF) 
					_group_button[i].active = false;
				_group_button[i].label.color = 0xFFFFFFFF;
				
			}
		}
		
		super.update(elapsed);		
		
		if (ActionInput.justPressed() == true
		&&  FlxG.mouse.x > _usernameInput.x
		&&  FlxG.mouse.x < _usernameInput.x + _usernameInput.width
		&&  FlxG.mouse.y + __menu_configurations_output.__boxscroller.scroll.y > _usernameInput.y
		&&  FlxG.mouse.y + __menu_configurations_output.__boxscroller.scroll.y < _usernameInput.y + _usernameInput.height
		&&  FlxG.mouse.y < FlxG.height - 50)
		{
			_usernameInput.hasFocus = true;
			
			if (RegCustom._enable_sound == true
			&&  Reg2._boxScroller_is_scrolling == false)
				FlxG.sound.play("click", 1, false);
							
			#if mobile
				RegTriggers._keyboard_open = true;
			#end
		}
		
	}
}//