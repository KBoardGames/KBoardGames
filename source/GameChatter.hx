package;

/**
 * chat window called chatter.
 * @author kboardgames.com
 */
class GameChatter extends FlxGroup
{
	/******************************
	 * background of chatter.
	 */
	public static var _title_background:FlxSprite;
	
	/******************************
	 * after typing in a message at chatter this button can be used instead of the return key to output that text.
	 */
	public static var _chatInputButton:ButtonGeneralNetworkYes;
	
	/******************************
	 * widget where user types in chat text.
	 */
	public static var _input_chat:FlxInputText;
	
	/******************************
	 * this is used to move the chatter text down and the chatter input field up.
	 */
	public static var _chatter_offset_y:Int = 0;
	
	/******************************
	 * used to display the not hosting username of the once.
	 */
	public var _displayPlayer2NameOnce:Bool = false;
	
	/******************************
	 * chatter __boxScroller text.
	 */
	private var _group_text:Array<FlxText> = []; // access members here.
	
	/******************************
	 * currently holds 100 lines of chatter __boxScroller text.
	 */
	private var _group_text_member_total:Int = 100;
	
	/******************************
	 * used to hide or make read only, everything in chatter.
	 */
	public var _group:FlxSpriteGroup;
	
	/******************************
	 * all chatter elements are added to this group so that everything can scroll off screen at the same time then the close chatter button is clicked.
	 */
	public static var _groupChatterScroller:FlxSpriteGroup;
	
	/******************************
	 * if true then this chatter should be scrolled on or off screen.
	 */
	public var _scrollTheGroupChatter:Bool = false;
	
	/******************************
	 * chatter open/close button.
	 */
	public static var _chatterOpenCloseButton:ButtonGeneralNetworkNo;
	
	/******************************
	 * should the chatter scroll left?
	 */
	public static var _scrollLeft:Bool = false;
	
	/******************************
	 * should the chatter scroll right?
	 */
	public static var _scrollRight:Bool = false;
		
	/******************************
	 * used to disable the players online scroll box at __scene_waiting_room when chat window is open.
	 */
	public static var _chatterIsOpen:Bool = false; 
	
	/******************************
	 * used to grab buttons from the game room class.
	 */
	private var __scene_game_room:SceneGameRoom;	
	
	/******************************
	 * the menu bar at the button of the scene.
	 */
	private	var __menu_bar:MenuBar;
	
	/******************************
	 * lobby
	 */
	public static var __boxscroller2:FlxScrollableArea; 
	
	/******************************
	 * waiting room.
	 */
	public static var __boxscroller3:FlxScrollableArea;
	
	/******************************
	 * game room.
	 */
	public static var __boxscroller4:FlxScrollableArea;
	
	/******************************
	 * the boxScroller would not work without at least one sprite added to the boxScrollerGroup.
	 */
	private var _box:FlxSprite;
	
	/******************************
	 * when this class is created the id at the constructor is passed to a function and at that function depending on this value, a __boxScroller for lobby, or waiting... will be used.
	 */
	private var _id:Int = 0;
	
	/******************************
	 * needed to move the cursor of the inputText because a var can get the value of a caret but cannot for some reason set the value to the caret index.
	 */
	private var _caretIndex:Int = 0;
	
	public function new(id:Int = 0, scene_game_room:SceneGameRoom = null) 
	{
		super();
		
		__scene_game_room = scene_game_room;
		_scrollTheGroupChatter = false;
		_scrollLeft = false;
		_scrollRight = false;
		_chatterIsOpen = false; 
	
		_id = ID = id;		
		RegFunctions.fontsSharpen();
				
		Reg._keyOrButtonDown = false;
		Reg._offsetScreenBG = 101;
		Reg._offsetScreenY = 101;
		
		_group = cast add(new FlxSpriteGroup());
		
		_groupChatterScroller = new FlxSpriteGroup(0, 0);		
		_groupChatterScroller.scrollFactor.set();
		
		// background. DO NOT change the x position of this var without also changing its x value at SceneGameRoom.toggleButtonsAsChatterScrolls();
		_title_background = new FlxSprite(0, 0);
		_title_background.setPosition(FlxG.width - 375, 0);
		_title_background.makeGraphic(375, FlxG.height - 50, 0xFF000000);
		add(_title_background);		
		_groupChatterScroller.add(_title_background);
		
		//if (RegTypedef._dataMisc._userLocation == 0) Reg._rememberChatterIsOpen = true;
		
		//if (Reg._rememberChatterIsOpen == true && Reg._gameRoom == false) _groupChatterScroller.x = 0;
		//else _groupChatterScroller.x = 375; // if you want chatter open by default change the value to 0;
		
			
		// the boxScroller would not work without at least one sprite added to the boxScrollerGroup.
		_box = new FlxSprite();
		_box.makeGraphic(1, 1, FlxColor.BLACK);
		_box.setPosition(1045, 0);
		add(_box);
		_group.add(_box);

		// this text is needed to fix a bug. it shows a scroll bar by feeding new lines to the FlxScrollableArea. this scrollbar move up until its bottom edge reaches the bottom of the FlxScrollableArea.
		var _text = new FlxText(1045, FlxG.height - Reg._offsetScreenY, 0, "");
		_text.setFormat(null, 17, FlxColor.WHITE, LEFT);
		_text.offset.set(0, 10);
		_text.font = Reg._fontDefault;
		_text.text = "this will fix\n a display\n bug. \n by making new lines. \n";
		_text.visible = false; // the bug will still be fixed.
		add(_text);
		_group.add(_text);
		
		//############################# CHAT TEXT
		// the chat text displayed at the output text box.
		// the user that joined the chatroom.
		
		var _idSprite:Int = 1;
	
		_group_text.splice(0, _group_text.length);
		
		for (i in 0..._group_text_member_total + 1)
		{
			var _text = new FlxText(0, 0, 0, "");
			_text.visible = false;
			add(_text);
						
			_group_text.push(_text);				
			_group_text[i].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_group_text[i].fieldWidth = 345;
			_group_text[i].visible = true;
			
			if (i == 0) _group_text[i].setPosition(1400, 100);
			else 
			{
				_group_text[i].y = _group_text[i-1].y + _group_text[(i-1)].frameHeight + 40;
				_group_text[i].setPosition(1400, _group_text[i].y);
			}
			
			// give this member an id. this id is used to move members in z-order.
			_group_text[i].ID = _idSprite;
			_group.add(_group_text[i]);
			
			_idSprite += 1;
		}
		_group.y += _chatter_offset_y;		
				
		createInputChat(); // deals with typing in text at chatter. there is a bug where this UI needs to be destroyed then recreated after every output of text.
		
		// chatter open/close button.
		_chatterOpenCloseButton = new ButtonGeneralNetworkNo(FlxG.width - 183, FlxG.height - 137, "", 160 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, openCloseChatter);
		_chatterOpenCloseButton.label.font = Reg._fontDefault;
		_chatterOpenCloseButton.scrollFactor.set(0, 0);
		
		if (RegTypedef._dataPlayers._spectatorWatching == true || RegTypedef._dataMisc._userLocation != 3)
		{
			_chatterOpenCloseButton.visible = false;
			_chatterOpenCloseButton.active = false;
		}
		
		if (_groupChatterScroller.x == 0) _chatterOpenCloseButton.label.text = "Open Chat";
		else _chatterOpenCloseButton.label.text = "Close Chat";				
		add(_chatterOpenCloseButton);		
		
		boxScroller();
		//-----------------------------------
		
		// the chatter output button that is beside the _input_chat.
		_chatInputButton = new ButtonGeneralNetworkYes(FlxG.width - 363, FlxG.height - 137, "Send", 175, 35, Reg._font_size, 0xFFCCFF33, 0, chatInputFromButton, 0xFF000044, true);
		_chatInputButton.visible = false;
		_chatInputButton.active = false;
		_chatInputButton.label.font = Reg._fontDefault;
		add(_chatInputButton);
		_groupChatterScroller.add(_chatInputButton);
			
		canTypeInChatter();
		
	}
	
	private function canTypeInChatter():Void
	{
		if (_id != ID) return;
		
		if (_groupChatterScroller.x == 0)
		{
			_input_chat.active = true;
			_input_chat.visible = true;
			
			_chatInputButton.active = true;
			_chatInputButton.visible = true;
		}
		
		else
		{
			_input_chat.text = "";
			_input_chat.caretIndex = _input_chat.text.length;
			_input_chat.hasFocus = false;
			
			_input_chat.visible = false;
			_input_chat.active = false;
			
			_chatInputButton.visible = false;
			_chatInputButton.active = false;
		}
		
		
	}
	
	public function options():Void
	{
		if (_id != ID) return;
		
		if (Reg._rememberChatterIsOpen == true) 
		{
			_groupChatterScroller.x = 0;
			_chatterOpenCloseButton.label.text = "Close Chat";
		}
		else
		{
			_groupChatterScroller.x = 375; // if you want chatter open by default change the value to 0;
			_chatterOpenCloseButton.label.text = "Open Chat";
		}
		
		
		createInputChat();
		
	
	}
	
	private function chatInputFromButton():Void
	{
		if (_id != ID) return;
		
		if (_input_chat.active == true && _input_chat.text != "")
		{		
			RegTypedef._dataMisc._chat = _input_chat.text;
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
			{
				PlayState.clientSocket.send("Chat Send", RegTypedef._dataMisc);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			_input_chat.hasFocus = true;
			_input_chat.text = "";
			RegTypedef._dataMisc._chat = "";
			_input_chat.hasFocus = true;			
			
			#if mobile
				RegTriggers._keyboard_close = true;
			#end
		}
	}
	
	private function createInputChat()
	{
		if (_id != ID) return;
		
		// widget where user types in chat text.
		if (_input_chat != null)
		{
			remove(_input_chat);
			_group.remove(_input_chat);
			_groupChatterScroller.remove(_input_chat);

			_input_chat.destroy();
		}
		
		_input_chat = new FlxInputText(FlxG.width - 370, FlxG.height - 182 - _chatter_offset_y, 350, "", 12, FlxColor.BLACK);
		_input_chat.hasFocus = false; // address bug when false.
		_input_chat.setFormat(Reg._fontDefault, 22, FlxColor.BLACK, FlxTextAlign.RIGHT);
		_input_chat.fieldBorderColor = FlxColor.BLUE;
		_input_chat.maxLength = 70;
		
		_input_chat.text = "";
		_input_chat.forceCase = 2;	
		_input_chat.visible = true;
		_input_chat.caretIndex = _input_chat.text.length; // this fixes a bug where the caret does not reset back to 0 when the send button is pressed. p1 side is fine. p2 and computer is no longer buggy.
		
		/*
		_input_chat.callback = function (text, action)
		{
			if (text != "" && action == "enter") 
			{
				chatInputFromButton();
				text = "";
				
				_input_chat.caretIndex = _input_chat.text.length; // this fixes a bug where the caret does not reset back to 0 when the enter key is pressed. p1 side is fine. p2 and computer is no longer buggy.
				
				#if mobile
					RegTriggers._keyboard_close = true;
				#end
			}			
		}*/
		
		add(_input_chat);
		_group.add(_input_chat);
		_groupChatterScroller.add(_input_chat);
	
	}
	
	override public function destroy()
	{
		if (_id != ID) return;
		
		_scrollLeft = false;
		_scrollRight = false;
		_chatterIsOpen = false;

		if (__boxscroller2 != null
		&&  RegTypedef._dataMisc._userLocation == 0)
		{
			__boxscroller2.destroy();
			cameras.remove( __boxscroller2 );
			__boxscroller2 = null;
		}
		
		if (__boxscroller3 != null
		&&  RegTypedef._dataMisc._userLocation > 0
		&&  RegTypedef._dataMisc._userLocation < 3)
		{
			__boxscroller3.destroy();
			cameras.remove( __boxscroller3 );
			__boxscroller3 = null;
		}
		
		if (__boxscroller4 != null
		&&  RegTypedef._dataMisc._userLocation == 3)
		{
			__boxscroller4.destroy();
			cameras.remove( __boxscroller4 );
			__boxscroller4 = null;
		}
		
		super.destroy();
	}
		
	override public function update(elapsed:Float):Void 
	{
		if (_id != ID) return;
		
		// this fixes a bug where the chat input element is not seen when returning to the lobby from the waiting room. Its not really a bug. it is just that two scenes are sharing the same class, no id is used and no id is needed.
		if (RegTriggers._recreate_chatter_input_chat == true)
		{
			RegTriggers._recreate_chatter_input_chat = false;
			createInputChat();
		}
				
		//----------------------------------------------------------------------
		// scrolls the chatter to off screen.
		if (_chatterOpenCloseButton.active == false && _scrollRight == true)
		{
			if (_groupChatterScroller.x < 375) _groupChatterScroller.x += 375;
			else 
			{
				_chatterOpenCloseButton.active = active;
								
				_chatterOpenCloseButton.label.text = "Open Chat";
				Reg._rememberChatterIsOpen = false;
				_scrollRight = false;	
				Reg._buttonCodeValues = "c10000";
				
				if (__boxscroller2 != null 
				&& RegTypedef._dataMisc._userLocation == 0)
				{
					__boxscroller2.visible = false;
				}
				
				else if (__boxscroller3 != null
				&& 		 RegTypedef._dataMisc._userLocation > 0
				&& 		 RegTypedef._dataMisc._userLocation < 3)
						__boxscroller3.visible = false;
				
				else if (__boxscroller4 != null)
				{					
					__boxscroller4.visible = false;
					__scene_game_room.buttonShowAll();
				}
				
				_input_chat.visible = false;
			}
		}
		
		else if (_chatterOpenCloseButton.active == false && _scrollLeft == true)
		{
			if (_groupChatterScroller.x > 0) _groupChatterScroller.x -= 375;
			else 
			{
				_chatterOpenCloseButton.active = active;
				
				_chatterOpenCloseButton.label.text = "Close Chat";
				Reg._rememberChatterIsOpen = true;				
				_scrollLeft = false;	
				Reg._buttonCodeValues = "c10000";
				
				if (__boxscroller2 != null 
				&& RegTypedef._dataMisc._userLocation == 0)
					__boxscroller2.visible = true;
				
				else if (__boxscroller3 != null
				&& 		 RegTypedef._dataMisc._userLocation > 0
				&& 		 RegTypedef._dataMisc._userLocation < 3)
					__boxscroller3.visible = true;
				
				else if (__boxscroller4 != null)
				{
					__boxscroller4.visible = true;
					__scene_game_room.buttonHideAll();
				}
				
				_input_chat.visible = true;
			}
		}
		
		// this is needed or else when other player sends a message and our chat is closed, the boxScroller will display.
		if (__boxscroller4 != null)
		{
			if (_chatterOpenCloseButton.label.text == "Open Chat")
				__boxscroller4.visible = false;
					
			else
				__boxscroller4.visible = true;
		}
		
		//---------------------------------------------------------------------
		canTypeInChatter();
		
		//#############################
		// chatter input field.
		if (_input_chat.hasFocus == true) 
		{
			if (_input_chat.text == "") _input_chat.caretIndex = 0;
			
			// these are needed so that the input field can be set back to focused after a keyboard button press.
			Reg2._input_field_caret_location = _input_chat.caretIndex;
			Reg2._input_field_number = 1;
		}
		
		if (ActionInput.justPressed() == true
		&&  ActionInput.overlaps(_input_chat) == true)
		{
			#if mobile
				RegTriggers._keyboard_open = true;
			#end
		}
		
		// if input field was in focus and a keyboard key was pressed...
		if (Reg2._input_field_number == 1
		&& Reg2._key_output != "")
		{
			_input_chat.hasFocus = true; // set the field back to focus.
			
			if (Reg2._key_output == "FORWARDS")
			{
				Reg2._key_output = "";
				
				if (_caretIndex > 0) 
				{
					_caretIndex -= 1;
					_input_chat.caretIndex = _caretIndex;
				}
				
				else _input_chat.caretIndex = 0;
			}
			
			else if (Reg2._key_output == "BACKWARDS")
			{
				Reg2._key_output = "";
				
				if (_caretIndex < _input_chat.text.length) 
				{
					_caretIndex += 1;
					_input_chat.caretIndex = _caretIndex;
				}
				
				else _input_chat.caretIndex = _input_chat.text.length;
			}
			
			else if (Reg2._key_output == "DELETE")
			{
				_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
				
				// get from start of text to cursor.
				var _str_start = _input_chat.text.substr(0, _input_chat.caretIndex);
				
				// and the end.
				var _str_end = _input_chat.text.substr(_str_start.length, _input_chat.text.length);
				
				// then delete one character at the cursor.
				_input_chat.text = _str_start.substr(0, _str_start.length - 1) + _str_end;
				
				// this is needed because we are removing a character therefore the position of the caret should change.
				if (_input_chat.caretIndex > 0)
				{
					_input_chat.caretIndex -= 1;
					_caretIndex -= 1;
				}
				
				Reg2._key_output = "";
			}
			
			else // add a letter.
			{
				// if cursor is at the end of the line.
				if (_input_chat.text.length-1 == _input_chat.caretIndex)
				{
					_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					
					if (Reg2._key_output == "SPACE") _input_chat.text += " ";
					else _input_chat.text += Reg2._key_output;
					
					Reg2._key_output = "";
				}
				
				else
				{
					_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					// get from start of text to cursor.
					var _str_start = _input_chat.text.substr(0, _input_chat.caretIndex);
					// and the end.
					var _str_end = _input_chat.text.substr(_input_chat.caretIndex, _input_chat.text.length);
					
					// output the text of the input field from the value set with the keyboard.
					if (Reg2._key_output == "SPACE")
					{
						_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						_input_chat.text = _str_start + " " + _str_end;
					
						// this is needed because we are removing a character therefore the position of the caret should change.
						_input_chat.caretIndex += 1;
					}
									
					else 
					{
						_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
						
						// at one character at cursor.
						_input_chat.text = _str_start + Reg2._key_output + _str_end;
						// this is needed because we are removing a character therefore the position of the caret should change.
						_input_chat.caretIndex += 1;
						_caretIndex += 1;
					}
					
					Reg2._key_output = "";
				}
			}
			
		}
		
		super.update(elapsed);
	}

	/******************************
	 * this function is called from the PlayState event "Chat Send".
	 * @param	name	the player sending the data.
	 * @param	txt		the data the player sent.
	 */
	public function chatSent(name:String, txt:String):Void
	{
		if (_id != ID) return;
		
		// the text of i is now the next text in the list. do this for every member in the list but that the text used for the input text.
		for (i in 0... _group_text_member_total - 1)
		{
			_group_text[i].text = _group_text[(i + 1)].text;
			_group_text[i].updateHitbox();
				
		}
		
		// this is the sent text.
		_group_text[(_group_text_member_total-1)].text = name + txt;
		_group_text[(_group_text_member_total)].updateHitbox();
		
		//  if user typed in a long text then the field height will be greater than normal. the previous text in the list will need to be placed correctly before that text. this recalculates the text field height for every member in the group.
		for (i in 1... _group_text_member_total)
		{
			_group_text[i].y = _group_text[(i - 1)].y + _group_text[(i - 1)].textField.height + 22;
			// hack to make the height between lines the same size when elements might have a different height.
			_group_text[i].y -= _group_text[(i - 1)].textField.height / 9;
			_group_text[i].setPosition(1400, _group_text[i].y);
			_group_text[i].updateHitbox();
			
		}
		
		boxScroller();
	}
	
	/**
	 * if adding more __boxScrollers here, remember to see MenuBar.hx disconnect function and add __boxscroller code there. See that function for the example.
	 */
	private function boxScroller():Void
	{
		if (_id != ID) return;
		
		if (Reg._game_offline_vs_player == false 
		&&  Reg._game_offline_vs_cpu == false
		&&  Reg._game_online_vs_cpu == false)
		{
			// lobby.		
			if (RegTypedef._dataMisc._userLocation == 0 
			&&  RegCustom._chat_turn_off_for_lobby == false
			&&  _id == 2 && _id == ID)
			{
				// cannot check for camera instance here if not null because it is static and doing so will give an error when you re-enter this scene from title.
				if (__boxscroller2 != null) FlxG.cameras.remove(__boxscroller2);
				__boxscroller2 = new FlxScrollableArea( new FlxRect( 1040, 0, 360, FlxG.height - 200), new FlxRect( 1040, 0, 360, _group.height), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 1, false, true); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
				
				FlxG.cameras.add( __boxscroller2 );
				__boxscroller2.antialiasing = true;
				__boxscroller2.pixelPerfectRender = true;
			}
			
			// waiting room.
			else if (RegTypedef._dataMisc._userLocation > 0
			&&  	 RegTypedef._dataMisc._userLocation < 3
			&&		 _id == 3 && _id == ID)
			{
				if (__boxscroller3 != null) FlxG.cameras.remove(__boxscroller3);
				__boxscroller3 = new FlxScrollableArea( new FlxRect( 1040, 0, 360, FlxG.height - 200), new FlxRect( 1040, 0, 360, _group.height), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 2, false, true); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
				
				FlxG.cameras.add( __boxscroller3 );
				__boxscroller3.antialiasing = true;
				__boxscroller3.pixelPerfectRender = true;
			}
			
			// game room.
			else if (RegTypedef._dataMisc._userLocation == 3
			&& 		_id == 4 && _id == ID)
			{	
				if (__boxscroller4 != null) FlxG.cameras.remove(__boxscroller4);
				__boxscroller4 = new FlxScrollableArea( new FlxRect( 1040, 0, 360, FlxG.height - 200), new FlxRect( 1040, 0, 360, _group.height), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 3, false, true); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
				
				if (_chatterOpenCloseButton.label.text == "Open Chat")
					__boxscroller4.visible = false;
				
				FlxG.cameras.add( __boxscroller4 );
				__boxscroller4.antialiasing = true;
				__boxscroller4.pixelPerfectRender = true; 
									
			}
						
			
		}	
	}
	
	/******************************
	 * clear the chatter output text.
	 */
	public function clearText():Void
	{
		for (i in 0..._group_text_member_total + 1)
		{
			_group_text[i].text = "";
		}
	}

	private function openCloseChatter():Void
	{
		if (_id != ID) return;
		
		// if chatter is displayed then prepare to scroll it off the screen.
		if (_groupChatterScroller.x == 0 && _chatterOpenCloseButton.active == true)
		{
			_chatterOpenCloseButton.active = false;
			_scrollRight = true;
			_scrollLeft = false;
			_chatterIsOpen = false;
			
			_input_chat.visible = false;
			_input_chat.active = false;
			
			_chatInputButton.visible = false;
			_chatInputButton.active = false;
			
			if (RegTypedef._dataMisc._userLocation == 3)
			{
				GameChatter.__boxscroller4.visible = false;
				GameChatter.__boxscroller4.active = false;
			}
					
		}
		
		// open it.
		if (_groupChatterScroller.x > 0 && _chatterOpenCloseButton.active == true)
		{
			_chatterOpenCloseButton.active = false;
			_scrollRight = false;
			_scrollLeft = true;
			
			var _count:Int = 0;
			
			if (RegTypedef._dataPlayers._usernamesDynamic[0] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[1] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[2] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[3] == "") _count += 1;
			
			if (RegTypedef._dataMisc._userLocation == 3)
			{
				GameChatter.__boxscroller4.active = true;
				GameChatter.__boxscroller4.visible = true;				
			}
			
			_chatterIsOpen = true;
		}
	}
	
	/******************************
	 * change the chatter button label text.
	 */
	public static function changeButtonLabel():Void
	{
		if (_groupChatterScroller != null && Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false )
		{
			if (_chatterOpenCloseButton.label != null)
			{
				if (_groupChatterScroller.x == 0) _chatterOpenCloseButton.label.text = "Close Chat";
				else _chatterOpenCloseButton.label.text = "Open Chat";
				
			}
		}
	}
}//