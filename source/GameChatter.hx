/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
	 * displayed underneath the _input_chat.
	 * this var is needed because a _input_chat background will create a null error in html5. haxe bug.
	 */
	public static var _sprite_input_chat_border:FlxSprite;
	
	/******************************
	 * displayed underneath the _input_chat.
	 * this var is needed because a _input_chat background will create a null error in html5. haxe bug.
	 */
	public static var _sprite_input_chat_background:FlxSprite;
	
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
	 * chatter __scrollable_area text.
	 */
	private static var _group_text:FlxText; // access members here.
	
	/******************************
	 * currently holds 100 lines of chatter __scrollable_area text.
	 */
	private var _group_text_member_total:Int = 100;
	
	/******************************
	 * used to hide or make read only, everything in chatter.
	 */
	public static var _group:FlxSpriteGroup;
	
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
	 * used to disable the players online scroll box at __scene_waiting_room when chat window is open.
	 */
	public static var _chatterIsOpen:Bool = false; 
	
	/******************************
	 * used to grab buttons from the game room class.
	 */
	private var __scene_game_room:SceneGameRoom;	
		
	/******************************
	 * lobby
	 */
	public static var __scrollable_area2:FlxScrollableArea; 
	
	/******************************
	 * waiting room.
	 */
	public static var __scrollable_area3:FlxScrollableArea;
	
	/******************************
	 * game room.
	 */
	public static var __scrollable_area4:FlxScrollableArea;
	
	/******************************
	 * the scrollable area would not work without at least one sprite added to the scrollable areaGroup.
	 */
	private var _box:FlxSprite;
	
	/******************************
	 * when this class is created the id at the constructor is passed to a function and at that function depending on this value, a __scrollable_area for lobby, or waiting... will be used.
	 */
	private var _id:Int = 0;
	
	/******************************
	 * needed to move the cursor of the inputText because a var can get the value of a caret but cannot for some reason set the value to the caret index.
	 */
	private var _caretIndex:Int = 0;
	
	/******************************
	 * this text is needed to fix a bug. it shows a scroll bar by feeding new lines to the FlxScrollableArea. this scrollbar move up until its bottom edge reaches the bottom of the FlxScrollableArea.
	 */
	private	var _text:FlxText;
	
	public function new(id:Int = 0, scene_game_room:SceneGameRoom = null) 
	{
		super();
		
		__scene_game_room = scene_game_room;
		_scrollTheGroupChatter = false;
		RegTriggers._scrollRight = false;
		
		toggle_chatter_open_close();
		
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
		_title_background.setPosition(FlxG.width - 385, 0);
		_title_background.makeGraphic(385, FlxG.height - 50, 0xFF000000);
		add(_title_background);		
		_groupChatterScroller.add(_title_background);
		
		//if (RegTypedef._dataMisc._userLocation == 0) Reg._rememberChatterIsOpen = true;
		
		//if (Reg._rememberChatterIsOpen == true && Reg._gameRoom == false) _groupChatterScroller.x = 0;
		//else _groupChatterScroller.x = 385; // if you want chatter open by default change the value to 0;
		
			
		// the scrollable area would not work without at least one sprite added to the scrollable areaGroup.
		_box = new FlxSprite();
		_box.makeGraphic(1, 1, FlxColor.BLACK);
		_box.setPosition(1045, 0);
		add(_box);
		_group.add(_box);

		// this text is needed to fix a bug. it shows a scroll bar by feeding new lines to the FlxScrollableArea. this scrollbar move up until its bottom edge reaches the bottom of the FlxScrollableArea.
		_text = new FlxText(1045, FlxG.height - Reg._offsetScreenY, 0, "");
		_text.setFormat(null, 17, RegCustomColors.client_text_color(), LEFT);
		_text.offset.set(0, 10);
		_text.font = Reg._fontDefault;
		_text.text = "this will fix\n a display\n bug. \n by making new lines. \n";
		_text.visible = false; // the bug will still be fixed.
		add(_text);
		_group.add(_text);
		
		
		chat_text();
		createInputChat(); // deals with typing in text at chatter. there is a bug where this UI needs to be destroyed then recreated after every output of text.
		
		// chatter open/close button.
		if (_chatterOpenCloseButton != null)
		{
			remove(_chatterOpenCloseButton);
			_chatterOpenCloseButton.destroy();
		}
		
		_chatterOpenCloseButton = new ButtonGeneralNetworkNo(FlxG.width - 183, FlxG.height - 137, "", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, openCloseChatter);
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
		
		scrollable_area();
		//-----------------------------------
		
		// the chatter output button that is beside the _input_chat.
		_chatInputButton = new ButtonGeneralNetworkYes(FlxG.width - 363, FlxG.height - 137, "Send", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chat_input_from_button, RegCustom._button_color[Reg._tn], true);
		_chatInputButton.visible = false;
		_chatInputButton.active = false;
		_chatInputButton.label.font = Reg._fontDefault;
		add(_chatInputButton);
		_groupChatterScroller.add(_chatInputButton);
			
		canTypeInChatter();
		
	}
	
	/******************************
	 * CHAT TEXT
	 * the chat text displayed at the output text box.
	 * the user that joined the chatroom.
	 * clearing a scrollable area is needed or else this text will not be seen when returning to lobby. the reason is waiting room scrollable area creates a new instance of both this text and scrollable area. it is those instances that stop this text from displaying at lobby.
	 * NOTE: lobby cannot remember chat history unless another var is created to store it.
	 */		
	private function chat_text():Void
	{
		var _idSprite:Int = 1;
	
		if (_group_text != null)
		{
			_group_text.visible = false;
			remove(_group_text);
			_group_text.destroy();			
		}
		
		_group_text = new FlxText(0, 0, 0, "");
		_group_text.visible = false;
		add(_group_text);
		
		_group_text.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_group_text.fieldWidth = 325;
		_group_text.visible = true;
		
		_group_text.setPosition(Reg._client_width, 100);
		_group_text.ID = _idSprite;
		_group.add(_group_text);
		
		_idSprite = 1;
		_group.y = _chatter_offset_y;		
		
	}
	
	public function initialize():Void
	{
		if (_id != ID) return;
		
		createInputChat();
	}
	
	private function canTypeInChatter():Void
	{
		if (_id != ID) return;
		
		if (_groupChatterScroller.x == 0)
		{
			_sprite_input_chat_border.active = true;
			_sprite_input_chat_border.visible = true;
			_sprite_input_chat_background.active = true;	
			_sprite_input_chat_background.visible = true;
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
			
			_sprite_input_chat_border.visible = false;
			_sprite_input_chat_border.active = false;	
			_sprite_input_chat_background.visible = false;
			_sprite_input_chat_background.active = false;				
			_input_chat.visible = false;
			_input_chat.active = false;
			
			_chatInputButton.visible = false;
			_chatInputButton.active = false;
		}		
		
	}
		
	private function chat_input_from_button():Void
	{
		//if (_id != ID) return;
		
		if (_input_chat.text != "")
		{		
			RegTypedef._dataMisc._chat = _input_chat.text;
			
			if (Reg._game_offline_vs_cpu == false && Reg._game_offline_vs_player == false) 
			{
				//tid-i (typedef id followed for an i in a for loop). replace them all with **** because tid is used to get/send event name to the server/client.
				StringTools.replace(RegTypedef._dataMisc._chat, "tidi", "****");
				
				RegTypedef._dataMisc._chat = RegTypedef._dataMisc._chat.substr(0, 200);
				
				PlayState.send("Chat Send", RegTypedef._dataMisc);				
			}
			
			_input_chat.hasFocus = true;
			RegTypedef._dataMisc._chat = _input_chat.text = "";
			
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
			_group.remove(_input_chat);
			_groupChatterScroller.remove(_input_chat);
			
			_input_chat.active = true;
			_input_chat.visible = false;
			remove(_input_chat);
			_input_chat.destroy();
		}
		
		_sprite_input_chat_border = new FlxSprite(FlxG.width - 360, FlxG.height - 194 - _chatter_offset_y);
		_sprite_input_chat_border.makeGraphic(354, 35, FlxColor.WHITE);
		_sprite_input_chat_border.visible = true;
		add(_sprite_input_chat_border);	
		_group.add(_sprite_input_chat_border);
		_groupChatterScroller.add(_sprite_input_chat_border);
		
		_sprite_input_chat_background = new FlxSprite(FlxG.width - 362, FlxG.height - 192 - _chatter_offset_y);
		_sprite_input_chat_background.makeGraphic(350, 31, FlxColor.WHITE);
		_sprite_input_chat_background.visible = true;
		add(_sprite_input_chat_background);	
		_group.add(_sprite_input_chat_background);
		_groupChatterScroller.add(_sprite_input_chat_background);
		
		_input_chat = new FlxInputText(FlxG.width - 362, FlxG.height - 192 - _chatter_offset_y, 350, "", Reg._font_size-2, FlxColor.BLACK, FlxColor.TRANSPARENT);
		_input_chat.hasFocus = false; // address bug when false.
		_input_chat.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK, FlxTextAlign.RIGHT);
		_input_chat.fieldBorderColor = FlxColor.BLUE;
		_input_chat.maxLength = 70;
		_input_chat.forceCase = 2;	
		_input_chat.visible = true;
		_input_chat.caretIndex = _input_chat.text.length; // this fixes a bug where the caret does not reset back to 0 when the send button is pressed. p1 side is fine. p2 and computer is no longer buggy.
		
		if (_group_text.text == "") chatSent("", "Chatter.\n\r");
		
		_input_chat.callback = function (text, action)
		{
			if (text != "" && action == "enter") 
			{
				//chatSent(" ", " ");
				chat_input_from_button();
				text = "";
				
				_input_chat.caretIndex = _input_chat.text.length; // this fixes a bug where the caret does not reset back to 0 when the enter key is pressed. p1 side is fine. p2 and computer is no longer buggy.
				
				#if mobile
					RegTriggers._keyboard_close = true;
				#end
			}			
		}
		
		add(_input_chat);
		_groupChatterScroller.add(_input_chat);
	
	}
	
	/******************************
	 * this function is called from the PlayState event "Chat Send".
	 * @param	name	the player sending the data.
	 * @param	txt		the data the player sent.
	 */
	public static function chatSent(name:String, txt:String):Void
	{
		// this is the sent text.
		_group_text.text = name + txt + "\n\r" + _group_text.text;
		_group_text.text = _group_text.text.substr(0, 20000); // limit how much text can be outputted to the scrollable_area.
		
		//  if user typed in a long text then the field height will be greater than normal. the previous text in the list will need to be placed correctly before that text. this recalculates the text field height for every member in the group.
		_group_text.y = 22;
		
		_group_text.setPosition(Reg._client_width + 10, _group_text.y);
		
	}
	
	/**
	 * if adding more __scrollable_areas here, remember to see MenuBar.hx disconnect function and add __scrollable_area code there. See that function for the example.
	 */
	private static function scrollable_area():Void
	{
		
		if (Reg._game_offline_vs_player == false
		&&  Reg._game_offline_vs_cpu == false
		&&  Reg._game_online_vs_cpu == false
		)
		{
			// lobby.		
			if (RegTypedef._dataMisc._userLocation == 0 
			&&  RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true
			)
			{
				// cannot check for camera instance here if not null because it is static and doing so will give an error when you re-enter this scene from title.
				
				if (__scrollable_area2 == null)
				{
					__scrollable_area2 = new FlxScrollableArea( new FlxRect( 1047, 0, 360, FlxG.height - 200), new FlxRect(1047, 0, 360, 4000), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 4, true, false); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
					
					FlxG.cameras.add( __scrollable_area2 );
					__scrollable_area2.antialiasing = true;
					__scrollable_area2.pixelPerfectRender = true;
				}
			}
			
			// waiting room.
			else	 if (RegTypedef._dataMisc._userLocation > 0
			&&  	 RegTypedef._dataMisc._userLocation < 3
			)
			{
				if (__scrollable_area3 == null)
				{
					__scrollable_area3 = new FlxScrollableArea( new FlxRect( 1047, 0, 360, FlxG.height - 200), new FlxRect(1047, 0, 360, 4000), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 5, true, false); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
					
					FlxG.cameras.add( __scrollable_area3 );
					__scrollable_area3.antialiasing = true;
					__scrollable_area3.pixelPerfectRender = true;
				}
			}
			
			// game room.
			else if (RegTypedef._dataMisc._userLocation == 3
			)
			{	
				if (__scrollable_area4 == null)
				{					
					__scrollable_area4 = new FlxScrollableArea( new FlxRect( 1047, 0, 356, FlxG.height - 200), new FlxRect(1047, 0, 356, 4000), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 6, true, false); // _scrollbar_offset_y = 175(height)-50(-50 from y value). eg, 175-50.
					//if (_chatterOpenCloseButton.label.text == "Open Chat")
					//	__scrollable_area4.visible = false;
					
					FlxG.cameras.add( __scrollable_area4 );
					__scrollable_area4.antialiasing = true;
					__scrollable_area4.pixelPerfectRender = true; 
				}									
			}			
		}	
	}
	
	/******************************
	 * clear the chatter output text.
	 */
	public function clearText():Void
	{
		_group_text.text = "";
	}

	private function openCloseChatter():Void
	{
		if (_id != ID) return;
		
		// if chatter is displayed then prepare to scroll it off the screen.
		if (_groupChatterScroller.x == 0 && _chatterOpenCloseButton.active == true)
		{
			_chatterOpenCloseButton.active = false;
			RegTriggers._scrollRight = true;
			
			_chatterIsOpen = false;
			
			_sprite_input_chat_border.visible = false;
			_sprite_input_chat_border.active = false;	
			_sprite_input_chat_background.visible = false;
			_sprite_input_chat_background.active = false;
			_input_chat.visible = false;
			_input_chat.active = false;
			
			_chatInputButton.visible = false;
			_chatInputButton.active = false;
			
			/*if (RegTypedef._dataMisc._userLocation == 3)
			{
				GameChatter.__scrollable_area4.visible = false;
				GameChatter.__scrollable_area4.active = false;
			}*/
		}		
		
		// open it.
		if (_groupChatterScroller.x > 0 && _chatterOpenCloseButton.active == true)
		{
			_chatterOpenCloseButton.active = false;
			RegTriggers._scrollRight = true;
			
			var _count:Int = 0;
			
			if (RegTypedef._dataPlayers._usernamesDynamic[0] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[1] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[2] == "") _count += 1;
			if (RegTypedef._dataPlayers._usernamesDynamic[3] == "") _count += 1;
			
			if (RegTypedef._dataMisc._userLocation == 3)
			{
				GameChatter.__scrollable_area4.active = true;
				GameChatter.__scrollable_area4.visible = true;				
			}
			
			_chatterIsOpen = true;
		}
		
		toggle_chatter_open_close();
	}
		
	private function toggle_chatter_open_close():Void
	{
		// scrolls the chatter to off screen.
		if (_chatterOpenCloseButton != null
		&&	_chatterOpenCloseButton.label.text == "Close Chat"
		&&	RegTriggers._scrollRight == true)
		{
			RegTriggers._scrollRight = false;
			
			if (_groupChatterScroller.x < 385) _groupChatterScroller.x += 385;
			
			_chatterOpenCloseButton.active = active;
			_chatterOpenCloseButton.label.text = "Open Chat";
			
			Reg._rememberChatterIsOpen = false;
			Reg._buttonCodeValues = "c10000";
			
			if (__scrollable_area2 != null 
			&& RegTypedef._dataMisc._userLocation == 0)
			{
				__scrollable_area2.visible = false;
			}
			
			else if (__scrollable_area3 != null
			&& 		 RegTypedef._dataMisc._userLocation > 0
			&& 		 RegTypedef._dataMisc._userLocation < 3)
					__scrollable_area3.visible = false;
			
			else if (__scrollable_area4 != null)
			{					
				__scrollable_area4.visible = false;
				__scrollable_area4.x = 1040;
				__scene_game_room.buttonShowAll();
			}
			
			_sprite_input_chat_border.visible = false;
			_sprite_input_chat_background.visible = false;
			_input_chat.visible = false;
			
		}
		
		else if (_chatterOpenCloseButton != null
		&&		 _chatterOpenCloseButton.label.text == "Open Chat"
		&&		 RegTriggers._scrollRight == true)
		{
			RegTriggers._scrollRight = false;
			
			if (_groupChatterScroller.x > 0) _groupChatterScroller.x -= 385;
			
			_chatterOpenCloseButton.active = active;
			
			_chatterOpenCloseButton.label.text = "Close Chat";
			Reg._rememberChatterIsOpen = true;				
			Reg._buttonCodeValues = "c10000";
			
			if (__scrollable_area2 != null 
			&& RegTypedef._dataMisc._userLocation == 0)
				__scrollable_area2.visible = true;
			
			else if (__scrollable_area3 != null
			&& 		 RegTypedef._dataMisc._userLocation > 0
			&& 		 RegTypedef._dataMisc._userLocation < 3)
				__scrollable_area3.visible = true;
			
			else if (__scrollable_area4 != null)
			{
				__scrollable_area4.visible = true;
				__scrollable_area4.x = - 1040;
				_input_chat.active = true;
				_input_chat.visible = true;
				_chatInputButton.active = true;
				_chatInputButton.visible = true;
				__scene_game_room.buttonHideAll();
			}
			
			_sprite_input_chat_border.visible = true;
			_sprite_input_chat_background.visible = true;
			_input_chat.visible = true;
		}
		
	}
	
	private function keyboard_pressed():Void 
	{
		// if input field was in focus and a keyboard key was pressed...
		if (Reg2._input_field_number == 1
		&& Reg2._key_output != "")
		{
			_input_chat.hasFocus = true; // set the field back to focus.
			
			if (Reg2._key_output == "FORWARDS")
			{				
				if (_caretIndex > 0) 
				{
					_caretIndex -= 1;
					_input_chat.caretIndex = _caretIndex;
				}
				
				else _input_chat.caretIndex = 0;
			}
			
			else if (Reg2._key_output == "BACKWARDS")
			{
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
			}
			
			else // add a letter.
			{
				// if cursor is at the end of the line.
				if (_input_chat.text.length-1 == _input_chat.caretIndex)
				{
					_input_chat.caretIndex = Reg2._input_field_caret_location; // since the field is once again in focus, we need to update the caret.
					
					if (Reg2._key_output == "SPACE") _input_chat.text += " ";
					else _input_chat.text += Reg2._key_output;
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
				}				
			}
			
			Reg2._key_output = "";
		}
	}
	
	override public function destroy()
	{
		if (_id != ID) return;
		
		RegTriggers._scrollRight = false;
		_chatterIsOpen = false;

		if (__scrollable_area2 != null
		&&  RegTypedef._dataMisc._userLocation == 0)
		{
			__scrollable_area2.destroy();
			cameras.remove( __scrollable_area2 );
			__scrollable_area2 = null;
		}
		
		if (__scrollable_area3 != null
		&&  RegTypedef._dataMisc._userLocation > 0
		&&  RegTypedef._dataMisc._userLocation < 3)
		{
			__scrollable_area3.destroy();
			cameras.remove( __scrollable_area3 );
			__scrollable_area3 = null;
		}
		
		if (__scrollable_area4 != null
		&&  RegTypedef._dataMisc._userLocation == 3)
		{
			__scrollable_area4.destroy();
			cameras.remove( __scrollable_area4 );
			__scrollable_area4 = null;
		}
		
		if (_chatterOpenCloseButton != null)
		{
			// TODO verify... is this block needed?
			if (_chatterOpenCloseButton.label != null)
			{
				remove(_chatterOpenCloseButton.label);
				_chatterOpenCloseButton.label.destroy();
				_chatterOpenCloseButton.label = null;
			}
			
			remove(_chatterOpenCloseButton);
			_chatterOpenCloseButton.destroy();
			_chatterOpenCloseButton = null;
		}
		
		if (_title_background != null)
		{
			_groupChatterScroller.remove(_title_background);
			_group.remove(_title_background);
			remove(_title_background);
			_title_background.destroy();
			_title_background = null;
		}
		
		if (_chatInputButton != null)
		{
			_groupChatterScroller.remove(_chatInputButton);
			_group.remove(_chatInputButton);
			remove(_chatInputButton);
			_chatInputButton.destroy();
			_chatInputButton = null;
		}
		
		if (_sprite_input_chat_border != null)
		{
			_groupChatterScroller.remove(_sprite_input_chat_border);
			_group.remove(_sprite_input_chat_border);
			remove(_sprite_input_chat_border);
			_sprite_input_chat_border.destroy();
			_sprite_input_chat_border = null;
		}
		
		if (_sprite_input_chat_background != null)
		{
			_groupChatterScroller.remove(_sprite_input_chat_background);
			_group.remove(_sprite_input_chat_background);
			remove(_sprite_input_chat_background);
			_sprite_input_chat_background.destroy();
			_sprite_input_chat_background = null;
		}			 
		
		if (_input_chat != null)
		{
			_groupChatterScroller.remove(_input_chat);
			_group.remove(_input_chat);
			remove(_input_chat);
			_input_chat.destroy();
			_input_chat = null;
		}		
		
		if (_group_text != null)
		{
			_group.remove(_group_text);
			remove(_group_text);
			_group_text.destroy();
			_group_text = null;
		}		
		
		if (_box != null)
		{
			_group.remove(_box);
			remove(_box);
			_box.destroy();
			_box = null;
		}
		
		if (_text != null)
		{
			_group.remove(_text);
			remove(_text);
			_text.destroy();
			_text = null;
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
			
			chat_text();
			createInputChat();
		}
		
		
		// this is needed or else when other player sends a message and our chat is closed, the scrollable area will display.
		if (__scrollable_area4 != null)
		{
			if (_chatterOpenCloseButton.label.text == "Open Chat"
			&&	__scrollable_area4.visible == true)
			{
				__scrollable_area4.visible = false;
				__scrollable_area4.active = false;
			}
					
			else if (_chatterOpenCloseButton.label.text == "Close Chat"
			&&	__scrollable_area4.visible == false)
			{
				__scrollable_area4.active = true;
				__scrollable_area4.visible = true;
			}
		}
		
		//canTypeInChatter();
		
		// chatter input field.
		if (_input_chat.hasFocus == true) 
		{
			if (_input_chat.text == "") _input_chat.caretIndex = 0;
		}
		
		/*
			// these are needed so that the input field can be set back to focused after a keyboard button press.
			Reg2._input_field_caret_location = _input_chat.caretIndex;
			Reg2._input_field_number = 1;
		}*/
		
		if (ActionInput.justPressed() == true
		&&  ActionInput.overlaps(_input_chat) == true)
		{
			#if mobile
				RegTriggers._keyboard_open = true;
			#end
		}
		
		//if (Reg2._key_output != "")	keyboard_pressed(); 
		
		super.update(elapsed);
	}
	
}//