/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if house
	import modules.house.*;
#end

#if miscellaneous
	import modules.miscellaneous.*;
#end

#if dailyQuests
	import modules.dailyQuests.DailyQuests;
#end

#if leaderboards
	import modules.leaderboards.Leaderboards;
#end

/**
 * ...
 * @author kboardgames.com
 */
class SceneLobby extends FlxState
{
	public var __title_bar:TitleBar;
	public var __menu_bar:MenuBar;
	
	/******************************
	 * button total displayed. also change this value at server events.
	 */
	public static var _room_total:Int = 24;
	
	private var _table_horizontal_cell_padding:FlxSprite;
	private var _table_horizontal_bottom_cell_padding:FlxSprite;
			
	/******************************
	 * access members here.
	 */
	public static var _group_button_for_room:Array<ButtonGeneralNetworkYes> = []; 
	
	/******************************
	* host of the room directly at right side of room buttons.
	*/
	public static var __scene_lobby_room_host_username_text:Array<SceneLobbyRoomHostUsernameText> = []; 
	
	/******************************
	* room game title directly at right side of host text.
	*/
	public static var __scene_lobby_game_title_text:Array<SceneLobbyGameTitleText> = []; 
	
	/******************************
	* the total player limit permitted for that room.
	*/
	public static var __scene_lobby_room_player_limit_text:Array<SceneLobbyRoomPlayerLimitText> = [];
	
	/******************************
	* the total player limit permitted for that room.
	*/
	public static var __scene_lobby_game_against_text:Array<SceneLobbyGameRatedText> = [];
	
	/******************************
	* outputs true or false if spectators are allowed for that room.
	*/
	public static var __scene_lobby_game_spectators_text:Array<SceneLobbyGameSpectatorsText> = [];
	
	// make a double copy of all lobby table columns.
	public static var _column1:Array<ButtonGeneralNetworkYes> = [];
	public static var _column2:Array<Dynamic> = [];
	public static var _column3:Array<Dynamic> = [];
	public static var _column4:Array<Dynamic> = [];
	public static var _column5:Array<Dynamic> = [];
	public static var _column6:Array<Dynamic> = [];
	
	private var _column_x:Array<Int> = [143, 390, 620, 876, 1045, 1260, 1490];
	
	/******************************
	 * table sort arrows and functions to sort tables.
	 */
	private var _table_column_sort1:TableColumnSort;
	private var _table_column_sort2:TableColumnSort;
	private var _table_column_sort3:TableColumnSort;
	private var _table_column_sort4:TableColumnSort;
	private var _table_column_sort5:TableColumnSort;
	private var _table_column_sort6:TableColumnSort;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	public static var __game_chatter:GameChatter;
	
	/******************************
	 * without this var, user can click then hold button at lobby scrollable area to drag the window. releasing the mouse button at a _lobby_sprite would trigger one of those icons.
	 */
	public var _lobby_sprite_mouse_just_pressed:Bool = false;
	
	#if miscellaneous
		private var __miscellaneous_menu_output:MiscellaneousMenuOutput;
	#end
	public var __scrollable_area:FlxScrollableArea;	
	
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offset_x:Int = 50;
			
	/******************************
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public var _group_scrollable_area:FlxSpriteGroup;	
	
	/******************************
	* The current state of the room. a value of 0 and the room text will be empty, 1 and someone is waiting in a room to play the game and 2 means that a game is in progress.
	*/
	public var _buttonState:Array<String> = [];	
	
	/******************************
	 * When entering the lobby a player can quickly click a room button before lobby data is received, corrupting the room data. this var is used to set lobby buttons active only when "get room data" event is received.
	 */
	public static var _lobby_data_received:Bool = false;
	
	/******************************
	 * when true this stops the _lobby_data_received from setting the room buttons to active at each update() call.
	 */
	private var _lobby_data_received_do_once:Bool = true;
	
	/******************************
	* the number of the room that was selected.
	*/
	public static var _number:Int = 0;
	
	/******************************
	* do not new FlxText or button the second time. only one field at a coordinate permitted.
	*/
	public static var _populate_table_body:Bool = false;
	private var _button_lobby_refresh:ButtonGeneralNetworkYes;
		
	/******************************
	 * moves all row data, excluding the button row. to the left side.
	 */
	private var _offset2_x:Int = 43;
	
	/******************************
	 * moves everything up by these many pixels.
	 */
	private var _offset_y:Int = -770;
	
	/******************************
	 * white bar with text such as host, game title, spectators, overtop of it.
	 */
	private var _table_header_background:FlxSprite;
		
	/******************************
	 * message number used to display message box about cannot enter room message.
	 */
	public static var _message:Int = 0; 
	
	/******************************
	 *  // room number variable used in a message saying that the room is full.
	 */
	public static var _number_room_full:Int = 0;
		
	/******************************
	 * table rows.
	 */
	private var _table_rows:Array<FlxSprite> = []; 
		
	/******************************
	 * we need different column separators for memory cleanup. this is a black bar between table rows.
	 */
	private var _table_vertical_cell_padding:Array<FlxSprite> = []; 
	
	/******************************
	 * table column text.
	*/
	public var _table_column_text:Array<FlxText> = []; 
	
	/******************************
	 * call update only once then call it after user input.
	 */
	public static var _do_once:Bool = true;
	
	override public function new():Void
	{
		super();
		
		// for the user kicking or banning message box see "Is Action Needed For Player" event. that event calls RegTriggers._actionMessage which displays the message at platState.hx
		
		Reg._at_game_room = false;
		Reg._at_lobby = true;
		
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
		_number = 0;
		_populate_table_body = false;
		
		_group_button_for_room = [for (i in 0... _room_total) new ButtonGeneralNetworkYes(0, 0, "", 0, 0, 0, 0xfffffff, 0, null)];
		
		__scene_lobby_room_host_username_text = [for (i in 0... _room_total) new SceneLobbyRoomHostUsernameText(0, 0, 0, "", 0)]; 
		
		__scene_lobby_game_title_text = [for (i in 0... _room_total) new SceneLobbyGameTitleText(0, 0, 0, "", 0)]; 
		
		__scene_lobby_room_player_limit_text = [for (i in 0... _room_total) new SceneLobbyRoomPlayerLimitText(0, 0, 0, "", 0)];
		
		__scene_lobby_game_against_text = [for (i in 0... _room_total) new SceneLobbyGameRatedText(0, 0, 0, "", 0)];
		
		__scene_lobby_game_spectators_text = [for (i in 0... _room_total) new SceneLobbyGameSpectatorsText(0, 0, 0, "", 0)];
		
		// the other columns do not need to be placed here because they are either string or int converted to string.
		_column1 = [for (i in 0... _room_total) new ButtonGeneralNetworkYes(0, 0, "", 0, 0, 0, 0xfffffff, 0, null)];
		
		_table_rows = [for (i in 0... _room_total + 1) new FlxSprite(0, 0)]; 
		
		FlxG.autoPause = false;
		
		if (__scene_background != null) remove(__scene_background);	
			__scene_background = new SceneBackground();
		add(__scene_background);		
	}
		
	public function initialize():Void
	{
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
		_lobby_sprite_mouse_just_pressed = false;
		
		MessageBoxNoUserInput._ticks_close = false;
		PlayState._text_logging_in.text = "";
		Reg._at_lobby = true;
		Reg._table_column_sort_do_once = false;
		
		_populate_table_body = false;
		
		__menu_bar.initialize();
		
	}
		
	public function display():Void
	{
		RegFunctions.fontsSharpen();		
		
		RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = RegTypedef._dataMovement._gid = RegTypedef._dataMisc.id;
		
		if (_group_scrollable_area != null)
		{
			remove(_group_scrollable_area);
			_group_scrollable_area.destroy();			
		}
		_group_scrollable_area = cast add(new FlxSpriteGroup());
		
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Lobby");
		add(__title_bar);
		
		if (_button_lobby_refresh != null)
		{
			remove(_button_lobby_refresh);
			_button_lobby_refresh.destroy();			
		}
		
		// 360 is the chat width. 215 is this button with. 15 is the default space from the edge. 20 is the width of the scrollbar. 10 is the extra space needed to make it look nice,		
		_button_lobby_refresh = new ButtonGeneralNetworkYes(FlxG.width + -360 + -215 + -15 - 20 - 10, 12 + Reg.__title_bar_offset_y, "Lobby Refresh", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_refresh, RegCustom._button_color[Reg._tn], false);		
		_button_lobby_refresh.label.font = Reg._fontDefault;
		_button_lobby_refresh.scrollFactor.set(0, 0);
		button_refresh();
		add(_button_lobby_refresh);
				
		_buttonState[0] = "Empty";
		_buttonState[1] = "Computer";
		_buttonState[2] = "Creating";
		_buttonState[3] = "Join";
		_buttonState[4] = "Join";
		_buttonState[5] = "Join";
		_buttonState[6] = "join";
		_buttonState[7] = "Full";
		_buttonState[8] = "Watch";
		
		// see draw_table_all_body_text() for table row text data
		draw_table_empty();
		draw_table_all_body_buttons();
		
		if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
		{
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)
			if (__scrollable_area != null)
			{
				FlxG.cameras.remove(__scrollable_area);
				__scrollable_area.destroy();
			}
			__scrollable_area = new FlxScrollableArea( new FlxRect(0, 0, 1400-370, FlxG.height - 50), new FlxRect(0, 0, 1400, 1950), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, true);
			
			FlxG.cameras.add( __scrollable_area );
			__scrollable_area.antialiasing = true;
			__scrollable_area.pixelPerfectRender = true;
			
			if (__game_chatter != null) 
			{
				remove(__game_chatter);
				__game_chatter.destroy();
			}
			__game_chatter = new GameChatter(4);
			__game_chatter.visible = true;
			
			if (GameChatter.__scrollable_area2 != null)	
			{
				GameChatter.__scrollable_area2.active = true;
				GameChatter.__scrollable_area2.visible = true;
			}
			
			GameChatter._groupChatterScroller.x = 0;
			
			add(__game_chatter);
		}
		
		else
		{
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)
			if (__scrollable_area != null)
			{
				FlxG.cameras.remove(__scrollable_area);
				__scrollable_area.destroy();
			}
			
			__scrollable_area = new FlxScrollableArea( new FlxRect(0, 0, Reg._client_width, FlxG.height - 50), new FlxRect(0, 0, Reg._client_width, 1950), ResizeMode.FIT_WIDTH, 0, 100, -1, FlxColor.LIME, null, 0, true);
			
			FlxG.cameras.add( __scrollable_area );
			__scrollable_area.antialiasing = true;
			__scrollable_area.pixelPerfectRender = true;
			
		}
		
		__scrollable_area.content.y = 770;
		
		menu_bar();
		
		set_not_active_for_buttons();
		initialize();
		
	}	
	
	private function draw_table_empty():Void
	{
		/*
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			_table_rows_color = RegCustomColors.color_client_background();
			_table_rows_color.alphaFloat = 0.15;
		}
		*/
		
		// Note that the last count ends before another loop, so only _room_total + 1 loops will be made. 
		for (i in 1... _room_total + 1)
		{
			if (_table_rows[i] != null)
			{
				_group_scrollable_area.remove(_table_rows[i]);
				_table_rows[i].destroy();
			}
			
			// soild table rows
			_table_rows[i] = new FlxSprite(0, 0);
			_table_rows[i].makeGraphic(FlxG.width - 60, 55, RegCustomColors.color_table_body_background());		
			_table_rows[i].setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_rows[i].scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_rows[i]);
			
			_table_horizontal_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_cell_padding.makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_cell_padding.setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_horizontal_cell_padding.scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_horizontal_cell_padding);
			
			_table_horizontal_bottom_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_bottom_cell_padding.makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_bottom_cell_padding.setPosition(20, 120 - _offset_y + (i * 70) - 15 + 70); 
			_table_horizontal_bottom_cell_padding.scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_horizontal_bottom_cell_padding);
		}		
		
		//-----------------------------
		var _arr = [370, 600, 855, 1025, 1240];
		
		for (ii in 1... _room_total + 1)
		{
			for (i in 0...5)
			{
				// we need different column separators for memory cleanup. this is a black bar between table rows.
				// first column separator.
				_table_vertical_cell_padding[i] = new FlxSprite(0, 0);
				_table_vertical_cell_padding[i].makeGraphic(2, 55, 0xFF000000);	
				_table_vertical_cell_padding[i].setPosition(_arr[i] - _offset_x - _offset2_x, 120 - _offset_y + (ii * 70) + 1); 
				_table_vertical_cell_padding[i].scrollFactor.set(0, 0);
				_group_scrollable_area.add(_table_vertical_cell_padding[i]);
			}
		}
		
	}
	
	/******************************
	 * Header title and columns text for the data rows.
	 */
	private function draw_table_column():Void
	{
		var _count = _group_scrollable_area.members.length;
		var _column_name = ["Room State", "Room Host", "Game", "Players", "Rated Game", "Spectators"];
	
		if (_table_header_background != null)
		{
			remove(_table_header_background);
			_table_header_background.destroy();
		}
		
		_table_header_background = new FlxSprite(0, 110);
		_table_header_background.makeGraphic(FlxG.width - 10, 50, FlxColor.WHITE); 
		_table_header_background.scrollFactor.set(1, 0);
		_group_scrollable_area.add(_table_header_background);
		_group_scrollable_area.members[(_count)].scrollFactor.set(1, 0);
		
		for (i in 0...6)
		{
			if (_table_column_text == null)
			{
				if (_table_column_text[i] == null)
				{
					remove(_table_column_text[i]);
					_table_column_text[i].destroy();
				}
			}
			// table column text.
			_table_column_text[i] = new FlxText(_column_x[i] - _offset_x - _offset2_x, 121, 0, _column_name[i]);
			_table_column_text[i].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
			_table_column_text[i].scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_column_text[i]);
			_group_scrollable_area.members[(_count + (i + 1))].scrollFactor.set(1, 0);
		}
	}
	
	private function draw_table_all_body_buttons():Void
	{
		var _id:Int = 2;
		
		for (i in 0... _room_total - 1) // change this value if increasing the button number.
		{
			// Positioned at the right side of the screen.
			if (_group_button_for_room[i] != null)
			{
				_group_scrollable_area.remove(_group_button_for_room[i]);
				_group_button_for_room[i].destroy();
			}
			
			_group_button_for_room[i] = new ButtonGeneralNetworkYes(100 - _offset_x, 126 - _offset_y + ((i + 1) * 70), Std.string((i + 1)) + ": " + _buttonState[RegTypedef._dataMisc._roomState[(i + 1)]], 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn], false, _id);
			
			_group_button_for_room[i].setPosition(100 - _offset_x, 126 - _offset_y + ((i+1) * 70));
			
			_group_button_for_room[i].ID = _id;
			_group_scrollable_area.add(_group_button_for_room[i]);

		}
	}
	
	private function draw_table_all_body_text():Void
	{		
		//....................... host Title data at lobby scrollable area.
		if (_populate_table_body == false)
		{
			for (i in 0... _room_total)
			{
			
				var _gameName = Std.string(RegTypedef._dataMisc._roomHostUsername[i]);
				
				if (__scene_lobby_room_host_username_text[i] != null)
				{
					_group_scrollable_area.remove(__scene_lobby_room_host_username_text[i]);
					__scene_lobby_room_host_username_text[i].destroy();
					
				}
				
				__scene_lobby_room_host_username_text[i] = new SceneLobbyRoomHostUsernameText(390 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
								
				__scene_lobby_room_host_username_text[i].text = Std.string(_gameName);	
				__scene_lobby_room_host_username_text[i].font = Reg._fontDefault;
				_group_scrollable_area.add(__scene_lobby_room_host_username_text[i]);
		
				if (__scene_lobby_game_title_text[i] != null)
				{
					remove(__scene_lobby_game_title_text[i]);
					__scene_lobby_game_title_text[i].destroy();
				}
				
				__scene_lobby_game_title_text[i] = new SceneLobbyGameTitleText(620 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, " ", Reg._font_size, i);
				__scene_lobby_game_title_text[i].fieldWidth = 220;
				__scene_lobby_game_title_text[i].wordWrap = false;
				__scene_lobby_game_title_text[i].text = " ";
				__scene_lobby_game_title_text[i].font = Reg._fontDefault;
				_group_scrollable_area.add(__scene_lobby_game_title_text[i]);
		
		
				//....................... Room player limit data at lobby scrollable area.
				var _total = RegTypedef._dataMisc._roomPlayerCurrentTotal[i] + "/" + RegTypedef._dataMisc._roomPlayerLimit[i];
				
				if (__scene_lobby_room_player_limit_text[i] != null)
				{
					remove(__scene_lobby_game_title_text[i]);
					remove(__scene_lobby_room_player_limit_text[i]);
					__scene_lobby_room_player_limit_text[i].destroy();
				}
				
				__scene_lobby_room_player_limit_text[i] = new SceneLobbyRoomPlayerLimitText(875 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
					
				__scene_lobby_room_player_limit_text[i].text = Std.string(_total);
				__scene_lobby_room_player_limit_text[i].font = Reg._fontDefault;
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] == 0) __scene_lobby_room_player_limit_text[i].text = "";
				
				_group_scrollable_area.add(__scene_lobby_room_player_limit_text[i]);
				
				//----------------------- will player be in a rated game?
				var _rated_game = RegTypedef._dataMisc._rated_game[i];
				var _title:String = "False";
			
				if (_rated_game == 1) _title = "True";
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] == 0) _title = "";
				
				if (__scene_lobby_game_against_text[i] != null)
				{
					remove(__scene_lobby_game_title_text[i]);
					remove(__scene_lobby_game_against_text[i]);
					__scene_lobby_game_against_text[i].destroy();
				}
				
				__scene_lobby_game_against_text[i] = new SceneLobbyGameRatedText(1045 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
				__scene_lobby_game_against_text[i].text = _title;
				__scene_lobby_game_against_text[i].font = Reg._fontDefault;
				
				_group_scrollable_area.add(__scene_lobby_game_against_text[i]);
				
				//----------------------- spectators.
				if (__scene_lobby_game_spectators_text[i] != null)
				{
					remove(__scene_lobby_game_title_text[i]);
					remove(__scene_lobby_game_spectators_text[i]);
					__scene_lobby_game_spectators_text[i].destroy();
				}
				
				__scene_lobby_game_spectators_text[i] = new SceneLobbyGameSpectatorsText(1260 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
				__scene_lobby_game_spectators_text[i].font = Reg._fontDefault;
				
				_group_scrollable_area.add(__scene_lobby_game_spectators_text[i]);
				
			}
		}
				
		_populate_table_body = true; // if column text is still showing for a room then text = "" was not used at the class that display the row for that column. see GameLobbyGameSpectatorsText.hx for an example.
		
	}
	
	private function button_clicked(_num):Void
	{
		goto_room(_num);
	}
		
	/******************************
	 * go to the room where the player waits for another player to play a game. else go to create room, Reg._getRoomData
	 */
	public function goto_room(_num:Int):Void
	{
		// get the number of the button from the button text.
		var _str = _group_button_for_room[_num].label.text;
		var _val = _str.split(":");
		
		if (RegTriggers._jump_creating_room == false)
			_number = Std.parseInt(_val[0]);
		else
			_number = 1;
		
		// these are used to send a request to "get room data". at that event the _lobby_data_received is set to true. at this class that var is read along with _lobby_data_received_do_once to execute either the creating room or the waiting room event. The vars also helps to refresh the lobby with current data.
		_lobby_data_received = false; 
		_lobby_data_received_do_once = true;
		
		// go to create room.
		Reg._getRoomData = true;		
	}
	
	private function room_full(message:Int, number_room_full:Int):Void
	{
		_message = message;
		_number_room_full = number_room_full;
		
		_group_scrollable_area.active = false;		

		Reg._messageId = 2000;
		Reg._buttonCodeValues = "l1010";
		SceneGameRoom.messageBoxMessageOrder();
	
	}
	
	private function data_not_ready_for_waitingRoom(_number:Int):Void
	{
		_number_room_full = _number;
		
		_group_scrollable_area.active = false;		

		Reg._messageId = 2010;
		Reg._buttonCodeValues = "l1030";
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	
	private function watch_game(_number:Int):Void
	{		
		set_not_active_for_buttons();
		
		RegTypedef._dataMisc._spectatorWatching = true;
		RegTypedef._dataPlayers._spectatorPlaying = false;
		RegTypedef._dataPlayers._spectatorWatching = true;
		
		Reg._gameId = RegTypedef._dataMisc._roomGameIds[_number];
		RegTypedef._dataMisc._room = _number;
		PlayState.allTypedefRoomUpdate(_number);
		
		Reg._move_number_next = 0;
		RegTypedef._dataPlayers._moveNumberDynamic[0] = 0;
		RegTypedef._dataMisc._roomState[_number] = 8;
		RegTypedef._dataMisc._userLocation = 3;
		RegTypedef._dataMovement._username_room_host = RegTypedef._dataMisc._roomHostUsername[_number];
		RegTypedef._dataMovement._gid = RegTypedef._dataMisc._gid[_number];
		RegTypedef._dataMovement._spectatorWatching = 1;
		
		PlayState.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers);	
		PlayState.send("Greater RoomState Value", RegTypedef._dataMisc); 
	}
	
	/******************************
	 * this function is called when going to MiscellaneousMenu.hx, Leaderboards.hx or house.hx class.
	 */
	public function set_not_active_for_buttons():Void
	{
		Reg._at_lobby = false;
		__title_bar._title.visible = false;
		
		#if house
			HouseScrollMap._map_offset_x = 0;
			HouseScrollMap._map_offset_y = 0;
		#end
		
		if (_group_scrollable_area != null)
		{
			// put this group off screen so that elements such as lobby buttons cannot be clicked.
			_group_scrollable_area.setPosition(5000, 0);
			_group_scrollable_area.active = false;
		}
		
		if (_group_button_for_room != null)
		{
			for (i in 0... _group_button_for_room.length)
			{
				_group_button_for_room[i].active = false;
			}
		}
		
		if (__scrollable_area != null)
		{
			__scrollable_area.visible = false;
			__scrollable_area.active = false;
		}
		
		if (GameChatter.__scrollable_area2 != null)
		{
			GameChatter.__scrollable_area2.visible = false;
			GameChatter.__scrollable_area2.active = false;
		}
		
		if (GameChatter.__scrollable_area3 != null)
		{
			GameChatter.__scrollable_area3.visible = false;
			GameChatter.__scrollable_area3.active = false;
		}
		
		if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
		{
			__game_chatter.visible = false;
			__game_chatter.active = false;
		}
		
		if (_button_lobby_refresh != null)
		{
			_button_lobby_refresh.visible = false;
			_button_lobby_refresh.active = false;
		}
		
		__title_bar.visible = false;
		
		for (i in 0... _table_column_text.length)
		{
			_table_column_text[i].visible = false;
		}		
		
		if (_table_column_sort1 != null)
		{
			_table_column_sort1.visible = false;
			_table_column_sort1.active = false;
		}
		
		if (_table_column_sort2 != null)
		{
			_table_column_sort2.visible = false;
			_table_column_sort2.active = false;
		}
		
		if (_table_column_sort3 != null)
		{
			_table_column_sort3.visible = false;
			_table_column_sort3.active = false;
		}
		
		if (_table_column_sort4 != null)
		{
			_table_column_sort4.visible = false;
			_table_column_sort4.active = false;
		}
		
		if (_table_column_sort5 != null)
		{
			_table_column_sort5.visible = false;
			_table_column_sort5.active = false;
		}
		
		if (_table_column_sort6 != null)
		{
			_table_column_sort6.visible = false;
			_table_column_sort6.active = false;
		}
		
	}
	
	/******************************
	 * this function is called when returning from MiscellaneousMenu.hx or house.hx class.
	 */
	public function set_active_for_buttons():Void
	{
		__title_bar._title.visible = true;
		
		#if house
			HouseScrollMap._map_offset_x = 0;
			HouseScrollMap._map_offset_y = 0;
		#end
		
		if (_group_scrollable_area != null)
		{
			_group_scrollable_area.active = true;
			_group_scrollable_area.setPosition(0, 0);
		}
		
		if (_group_button_for_room != null)
		{
			for (i in 0... _group_button_for_room.length)
			{
				_group_button_for_room[i].active = true;
			}
		}
		
		if (__scrollable_area != null) 
		{
			__scrollable_area.active = true;
			__scrollable_area.visible = true;
			
		}
		
		if (GameChatter.__scrollable_area2 != null
		&& GameChatter._groupChatterScroller.x == 0)
		{
			GameChatter.__scrollable_area2.active = true;
			GameChatter.__scrollable_area2.visible = true;
		}
		
		if (GameChatter.__scrollable_area3 != null
		&& GameChatter._groupChatterScroller.x == 0)
		{
			GameChatter.__scrollable_area3.active = true;
		}
		
		if (RegCustom._chat_when_at_lobby_enabled[Reg._tn] == true)
		{
			SceneLobby.__game_chatter.active = true;
			SceneLobby.__game_chatter.visible = true;
		}
		
		RegTriggers._ticks_buttons_menuBar = true;
		
		if (_button_lobby_refresh != null)
		{
			_button_lobby_refresh.active = true;
			_button_lobby_refresh.visible = true;
		}
		
		__title_bar.visible = true;
		
		for (i in 0... _table_column_text.length)
		{
			_table_column_text[i].visible = true;
		}
		
		if (_table_column_sort1 != null)
		{
			_table_column_sort1.active = true;
			_table_column_sort1.visible = true;
		}
		
		if (_table_column_sort2 != null)
		{
			_table_column_sort2.active = true;
			_table_column_sort2.visible = true;
		}
		
		if (_table_column_sort3 != null)
		{
			_table_column_sort3.active = true;
			_table_column_sort3.visible = true;
		}
		
		if (_table_column_sort4 != null)
		{
			_table_column_sort4.active = true;
			_table_column_sort4.visible = true;
		}
		
		if (_table_column_sort5 != null)
		{
			_table_column_sort5.active = true;
			_table_column_sort5.visible = true;
		}
		
		if (_table_column_sort6 != null)
		{
			_table_column_sort6.active = true;
			_table_column_sort6.visible = true;
		}
		
		if (Reg._at_lobby == false)
		{
			var _state = FlxG.state;
			_state.openSubState(new SceneTransition());
		}
		
		Reg._at_lobby = true;
		
	}
	
	private function button_refresh():Void
	{
		// player is at lobby, so a check for room lock is not needed to be sent to this event.
		RegTypedef._dataMisc._roomCheckForLock[0] = 0;
		
		PlayState.send("Get Room Data", RegTypedef._dataMisc);		
	}
	
	private function button_code_values():Void
	{
		// invite to room, accept? ok button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "l1000")
		{
			_group_scrollable_area.active = true;
			
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			goto_room((Reg._inviteRoomNumberToJoin - 1));
		}
			
		// invite to room,  cancel button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "l1000")
		{			
			_group_scrollable_area.active = true;
			
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._yesNoKeyPressValueAtMessage = 0;
		}
		
		// room full, or room creating message.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l1010")
		{
			_group_scrollable_area.active = true;
			active = true;
			_group_scrollable_area.visible = true;
			visible = true;				
			
			Reg._yesNoKeyPressValueAtMessage = 0;
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
		}
		
		// room not ready. someone is in that room.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l1030")
		{
			_group_scrollable_area.active = true;
			active = true;
			_group_scrollable_area.visible = true;
			visible = true;				
			
			Reg._yesNoKeyPressValueAtMessage = 0;
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
		}
		
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l2222")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._server_message = "";
			
			
		}
	}
	
	private function menu_bar():Void
	{
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		// __menu_bar needs to remain local. do not use Reg.__menu_bar
		__menu_bar = new MenuBar(false, false, null, null);
		add(__menu_bar);
	}
	
	private function triggers():Void
	{		
		if (RegTriggers._returnToLobbyMakeButtonsActive == true)
		{
			RegTriggers._returnToLobbyMakeButtonsActive = false;
			set_active_for_buttons();
			
			Reg._at_lobby = true;			
		}
		
		if (RegTriggers._ticks_buttons_menuBar == true)
		{
			RegTriggers._ticks_buttons_menuBar = false;
			
			_group_scrollable_area.active = true;
			__scrollable_area.active = true;			
		}
		
		#if miscellaneous
			if (RegTriggers._makeMiscellaneousMenuClassActive == true)
			{			
				set_not_active_for_buttons();
				
				if (__menu_bar.__miscellaneous_menu != null)
				{
					__menu_bar.__miscellaneous_menu.active = true;
					__menu_bar.__miscellaneous_menu.visible = true;
				}
			}
			
			if (RegTriggers._makeMiscellaneousMenuClassNotActive == true)
			{
				RegTriggers._makeMiscellaneousMenuClassNotActive = false;
				
				if (__menu_bar.__miscellaneous_menu != null)
				{
					__menu_bar.__miscellaneous_menu.visible = false;
					__menu_bar.__miscellaneous_menu.active = false;
				}
			}
			
			if (RegTriggers._miscellaneousMenuOutputClassActive == true)
			{
				RegTriggers._miscellaneousMenuOutputClassActive = false;
				
				set_not_active_for_buttons();	
				
				if (__miscellaneous_menu_output != null)
				{
					remove(__miscellaneous_menu_output);
					__miscellaneous_menu_output.destroy();
				}
				
				__miscellaneous_menu_output = new MiscellaneousMenuOutput(Reg2._miscMenuIparameter);
				add(__miscellaneous_menu_output);
			}
		#end
		
		#if dailyQuests
			if (RegTriggers._make_daily_quests_not_active == true)
			{
				RegTriggers._make_daily_quests_not_active = false;
				
				__menu_bar.__daily_quests.__scrollable_area.visible = false;
				__menu_bar.__daily_quests.__scrollable_area.active = false;
				__menu_bar.__daily_quests.visible = false;
				__menu_bar.__daily_quests.active = false;
				
				
			}
		#end
		
		#if tournaments
			if (RegTriggers._make_tournaments_not_active == true)
			{
				RegTriggers._make_tournaments_not_active = false;
				
				__menu_bar.__tournaments.visible = false;
				__menu_bar.__tournaments.active = false;				
			}
		#end
		
		#if leaderboards
			if (RegTriggers._make_leaderboards_not_active == true)
			{
				RegTriggers._make_leaderboards_not_active = false;
				//RegTriggers._returnToLobbyMakeButtonsActive = true;
				
				__menu_bar.__leaderboards.__scrollable_area.visible = false;
				__menu_bar.__leaderboards.__scrollable_area.active = false;
				
				__menu_bar.__leaderboards.visible = false;
				__menu_bar.__leaderboards.active = false;
			}
		#end
		
	}
	
	private function get_room_data():Void
	{
		if (_lobby_data_received == false 
		&& _lobby_data_received_do_once == true)
		{
			_lobby_data_received_do_once = false;
			
			// used to display a message if the room is locked. when getting this event, the _userLocation is set to a greater value. the next time at this code a message about a locked room cannot be given if this value is not 0.
			RegTypedef._dataMisc._userLocation = 0;
			PlayState.send("Get Room Data", RegTypedef._dataMisc);					
		}
		
		if (_lobby_data_received == true)
		{
			_lobby_data_received = false;
			
			// do not re-enter this function. instead, go to create room or waiting room.
			Reg._getRoomData = false;
			
			// first player can enter __scene_waiting_room but the next player cannot enter that same room until these room descriptions are displayed beside the room button.
			if (RegTypedef._dataMisc._roomHostUsername[_number] == "" && RegTypedef._dataMisc._roomGameIds[_number] == -1 &&
	RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] == 0 && RegTypedef._dataMisc._roomState[_number] == 0)
			{ }
			else if (RegTypedef._dataMisc._roomHostUsername[_number] == "" || RegTypedef._dataMisc._roomGameIds[_number] == -1 ||
	RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] == 0)
			{
				data_not_ready_for_waitingRoom(_number);
				return;
			}
			
			if (RegTypedef._dataMisc._roomState[_number] == 1)
			{
				room_full(0, _number); // message about a user already creating room.			
			}
			
			else if (RegTypedef._dataMisc._roomState[_number] == 8
			&& RegTypedef._dataMisc._allowSpectators[_number] == 1 ) // Reg._gameId <= 1 && 
			{
				watch_game(_number);
			}
			
			// cannot enter room.
			else if (RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] >= RegTypedef._dataMisc._roomPlayerLimit[_number] && RegTypedef._dataMisc._roomPlayerLimit[_number] > 0) 
			{
				room_full(1, _number); // a message about room full.
			}
			
			else
			{
				//GameChatter.clearText();
				Reg._playerLeftGame = false;
				
				RegTypedef._dataMisc._room = _number;
				
				//ActionInput.enable();				
				
				Reg._currentRoomState = RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room];
				
				// creating room.
				if (RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] == 0 && Reg._inviteRoomNumberToJoin == 0)	
				{
					RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 1;
					PlayState.send("Is Room Locked", RegTypedef._dataMisc);
				}
				
				// waiting room.
				else if (RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] < RegTypedef._dataMisc._roomPlayerLimit[_number] && RegTypedef._dataMisc._roomPlayerLimit[_number] > 0)
				{
					RegTypedef._dataMisc._userLocation = 2;
					RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 1;
					PlayState.send("Is Room Locked", RegTypedef._dataMisc);		
					
				}
				
				// set invite var back to 0.
				Reg._inviteRoomNumberToJoin = 0;
			}
		}

	}
	
	private function user_input():Void
	{
		//############################# BUTTON TEXT
		if (_group_button_for_room[0] != null && RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] == 0 ) 
		{
			// display the player vs player rooms.
				for (i in 1... _room_total)	
				{
					// output either a room full or watch game button label.
					// this is a room that is not full. using   will stop button highlight. remember that button needs an update to work correctly.
						_group_button_for_room[(i - 1)].label.text = Std.string(i) + ": " + _buttonState[RegTypedef._dataMisc._roomState[i]];	
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] >= RegTypedef._dataMisc._roomPlayerLimit[i] && RegTypedef._dataMisc._roomPlayerLimit[i] > 0 && RegTypedef._dataMisc._roomState[i] > 1)
				{
					if (RegTypedef._dataMisc._roomState[i] <= 7
					||  RegTypedef._dataMisc._allowSpectators[i] == 0)
					{
						_group_button_for_room[(i - 1)].label.text = Std.string(i) + ": " + _buttonState[7];
						
					}
					else if (RegTypedef._dataMisc._roomState[i] == 8
					||  RegTypedef._dataMisc._allowSpectators[i] == 1)
					{
						_group_button_for_room[(i - 1)].label.text = Std.string(i) + ": " + _buttonState[8];
					}
				}
				
			}
				
			if (_populate_table_body == false)
				draw_table_all_body_text();
			
			// make a double copy of all lobby columns.
			for (i in 0... _room_total)	
			{
				_column1[i].label.text = _group_button_for_room[i].label.text;
				_column2[i] = RegTypedef._dataMisc._roomHostUsername[i];
				_column3[i] = RegTypedef._dataMisc._roomGameIds[i];
				
				var _str:String = "";
				
				_column4[i] = Std.string(RegTypedef._dataMisc._roomPlayerCurrentTotal[i] + "/" + RegTypedef._dataMisc._roomPlayerLimit[i]);
				
				// this column is a string a not a int becuase string.sort is used. also, numbers do not sort well. for example, numbers would be sorted in the order of 1, 3, 33, 4... instead of 1,, 3, 4, 33.
				_column5[i] = Std.string(RegTypedef._dataMisc._rated_game[i]);
				_column6[i] = Std.string(RegTypedef._dataMisc._allowSpectators[i]);
			}
			
			// this is needed for the refresh button or when returning to lobby.
			TableColumnSort.sort(Reg._tc);
			
			// create the arrows and pass the columns' data to the class.
			// start table column id at 0. id 100-199 is used for InviteTable.hx class.
			if (_table_column_sort1 == null)
			{
				_table_column_sort1 = new TableColumnSort(_column_x[1] - _offset_x - _offset2_x - 55, 121, 0, _group_button_for_room, this);
				_table_column_sort1.scrollFactor.set(1, 0);
				_table_column_sort1.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort1);
			}
			
			if (_table_column_sort2 == null)
			{
				_table_column_sort2 = new TableColumnSort(_column_x[2] - _offset_x - _offset2_x - 55, 121, 1, RegTypedef._dataMisc._roomHostUsername, this);
				_table_column_sort2.scrollFactor.set(1, 0);
				_table_column_sort2.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort2);
			}
			
			if (_table_column_sort3 == null)
			{
				_table_column_sort3 = new TableColumnSort(_column_x[3] - _offset_x - _offset2_x - 55, 121, 2, RegTypedef._dataMisc._roomGameIds, this);
				_table_column_sort3.scrollFactor.set(1, 0);
				_table_column_sort3.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort3);
			}
			
			if (_table_column_sort4 == null)
			{
				var _str:Array<Dynamic> = [];
				
				for (i in 0... _room_total)
				{
					_str[i] = RegTypedef._dataMisc._roomPlayerCurrentTotal[i] + "/" + RegTypedef._dataMisc._roomPlayerLimit[i];
				}
				
				_table_column_sort4 = new TableColumnSort(_column_x[4] - _offset_x - _offset2_x - 55, 121, 3, _str, this);
				_table_column_sort4.scrollFactor.set(1, 0);
				_table_column_sort4.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort4);
			}
			
			if (_table_column_sort5 == null)
			{
				_table_column_sort5 = new TableColumnSort(_column_x[5] - _offset_x - _offset2_x - 55, 121, 4, RegTypedef._dataMisc._rated_game, this);
				_table_column_sort5.scrollFactor.set(1, 0);
				_table_column_sort5.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort5);
			}
			
			if (_table_column_sort6 == null)
			{
				_table_column_sort6 = new TableColumnSort(_column_x[6] - _offset_x - _offset2_x - 55, 121, 5, RegTypedef._dataMisc._allowSpectators, this);
				_table_column_sort6.scrollFactor.set(1, 0);
				_table_column_sort6.color = RegCustom._client_text_color_number[Reg._tn];
				add(_table_column_sort6);
			}
			
			if (_do_once == true) draw_table_column();
		}
		
		_do_once = false;
	}
	
	override public function destroy()
	{
		if (_group_scrollable_area != null)
		{
			if (_group_button_for_room != null)
			{
				for (i in 0... _group_button_for_room.length)
				{
					_group_scrollable_area.remove(_group_button_for_room[i]);
					_group_button_for_room[i].destroy();
					_group_button_for_room[i] = null;
				}
			}
			
			if (__scene_lobby_room_host_username_text != null)
			{
				for (i in 0... __scene_lobby_room_host_username_text.length)
				{
					_group_scrollable_area.remove(__scene_lobby_room_host_username_text[i]);
					__scene_lobby_room_host_username_text[i].destroy();
					__scene_lobby_room_host_username_text[i] = null;
				}	
			}
			
			if (__scene_lobby_game_title_text != null)
			{
				for (i in 0... __scene_lobby_game_title_text.length)
				{
					_group_scrollable_area.remove(__scene_lobby_game_title_text[i]);
					__scene_lobby_game_title_text[i].destroy();
					__scene_lobby_game_title_text[i] = null;
				}
			}
			
			if (__scene_lobby_room_player_limit_text != null)
			{
				for (i in 0... __scene_lobby_room_player_limit_text.length)
				{
					_group_scrollable_area.remove(__scene_lobby_room_player_limit_text[i]);
					__scene_lobby_room_player_limit_text[i].destroy();
					__scene_lobby_room_player_limit_text[i] = null;
				}
			}
			
			if (__scene_lobby_game_against_text != null)
			{
				for (i in 0... __scene_lobby_game_against_text.length)
				{
					_group_scrollable_area.remove(__scene_lobby_game_against_text[i]);
					__scene_lobby_game_against_text[i].destroy();
					__scene_lobby_game_against_text[i] = null;
				}
			}

			if (__scene_lobby_game_spectators_text != null)
			{
				for (i in 0... __scene_lobby_game_spectators_text.length)
				{
					_group_scrollable_area.remove(__scene_lobby_game_spectators_text[i]);
					__scene_lobby_game_spectators_text[i].destroy();
					__scene_lobby_game_spectators_text[i] = null;
				}
			}
			
			if (_table_rows != null)
			{
				for (i in 0... _table_rows.length)
				{
					_group_scrollable_area.remove(_table_rows[i]);
					_table_rows[i].destroy();
					_table_rows[i] = null;
				}
			}
			
			if (_table_horizontal_cell_padding != null)
			{
				_group_scrollable_area.remove(_table_horizontal_cell_padding);
				_table_horizontal_cell_padding.destroy();
				_table_horizontal_cell_padding = null;
			}
			
			if (_table_horizontal_bottom_cell_padding != null)
			{
				_group_scrollable_area.remove(_table_horizontal_bottom_cell_padding);
				_table_horizontal_bottom_cell_padding.destroy();
				_table_horizontal_bottom_cell_padding = null;
			}
			
			if (_table_vertical_cell_padding != null)
			{
				for (i in 0... _table_vertical_cell_padding.length)
				{
					_group_scrollable_area.remove(_table_vertical_cell_padding[i]);
					_table_vertical_cell_padding[i].destroy();
					_table_vertical_cell_padding[i] = null;
				}
			}
			
			if (_table_column_text != null)
			{
				for (i in 0... _table_column_text.length)
				{
					_group_scrollable_area.remove(_table_column_text[i]);
					_table_column_text[i].destroy();
					_table_column_text[i] = null;
				}
			}

			remove(_group_scrollable_area);
			_group_scrollable_area.destroy();
			_group_scrollable_area = null;
		}

		if (__scrollable_area != null && RegTypedef._dataMisc._userLocation == 0)
		{
			cameras.remove( __scrollable_area );
			__scrollable_area.destroy();
			__scrollable_area = null;
		}
				
		#if miscellaneous
			if (__miscellaneous_menu_output != null)
			{
				remove(__miscellaneous_menu_output);
				__miscellaneous_menu_output.destroy();
				__miscellaneous_menu_output = null;
			}
	

			if (__menu_bar != null)
			{
				if (__menu_bar.__miscellaneous_menu != null)
				{
					__menu_bar.__miscellaneous_menu.visible = false;
					remove(__menu_bar.__miscellaneous_menu);
					__menu_bar.__miscellaneous_menu.destroy();
				}
			}
		#end
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
			__scene_background = null;
		}
		
		if (_button_lobby_refresh != null)
		{
			remove(_button_lobby_refresh);
			_button_lobby_refresh.destroy();
			_button_lobby_refresh = null;
		}

		if (__menu_bar != null)
		{
			__menu_bar.visible = false;
			remove(__menu_bar);
			__menu_bar.destroy();
			__menu_bar = null;
		}
		
		_number = 0;
		_populate_table_body = false;
		
		_column1.splice(0, _column1.length);
		_column2.splice(0, _column2.length);
		_column3.splice(0, _column3.length);
		_column4.splice(0, _column4.length);
		_column5.splice(0, _column5.length);
		_column6.splice(0, _column6.length);
		
		if (__game_chatter != null) 
		{
			remove(__game_chatter);
			__game_chatter.destroy();
			__game_chatter = null;
		}
		
		if (_table_column_sort1 != null)
		{
			remove(_table_column_sort1);
			_table_column_sort1.destroy();
			_table_column_sort1 = null;
		}
		
		if (_table_column_sort2 != null)
		{
			remove(_table_column_sort2);
			_table_column_sort2.destroy();
			_table_column_sort2 = null;
		}
		
		if (_table_column_sort3 != null)
		{
			remove(_table_column_sort3);
			_table_column_sort3.destroy();
			_table_column_sort3 = null;
		}
		
		if (_table_column_sort4 != null)
		{
			remove(_table_column_sort4);
			_table_column_sort4.destroy();
			_table_column_sort4 = null;
		}
		
		if (_table_column_sort5 != null)
		{
			remove(_table_column_sort5);
			_table_column_sort5.destroy();
			_table_column_sort5 = null;
		}
		
		if (_table_column_sort6 != null)
		{
			remove(_table_column_sort6);
			_table_column_sort6.destroy();
			_table_column_sort6 = null;
		}		
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		// never use FlxG.mouse.setGlobalScreenPositionUnsafe(0, 0) because there is a bug where some message boxes, their buttons, will not fire;
		
		if (Reg._loggedIn == true && Reg._at_create_room == false && Reg._at_waiting_room == false && Reg._at_lobby == true)
		{
			// send the offset of the scrollable area to the button class so that when scrolling the scrollable area, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
			ButtonGeneralNetworkYes._scrollarea_offset_x = __scrollable_area.scroll.x;
			ButtonGeneralNetworkYes._scrollarea_offset_y = __scrollable_area.scroll.y;
			
			for (i in 0... _room_total - 1)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y >= _group_button_for_room[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y <= _group_button_for_room[i]._startY + _group_button_for_room[i]._button_height + 7 && FlxG.mouse.y < FlxG.height - 50
				&& FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _group_button_for_room[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _group_button_for_room[i]._startX + _group_button_for_room[i]._button_width && FlxG.mouse.justReleased == true )
				{
					if (Reg._ticks_button_100_percent_opacity[1] == 0
					&&	Reg._buttonCodeValues == "")
					{
						button_clicked(i);
						break;
					}
				}				
			
			}
			
			if (FlxG.keys.pressed.ANY
			&&	Reg._table_column_sort_do_once == true
			||	FlxG.mouse.justPressed == true
			&&	Reg._table_column_sort_do_once == true
			||	FlxG.mouse.justPressedMiddle == true
			&&	Reg._table_column_sort_do_once == true
			||	FlxG.mouse.justPressedRight == true
			&&	Reg._table_column_sort_do_once == true
			||	_do_once == true)
			{
				user_input();
			}
		}

		triggers();
		
		if (Reg._at_lobby == true) 
		{
			if (Reg._getRoomData == true)
				get_room_data();
			
			if (Reg._yesNoKeyPressValueAtMessage > 0) 
				button_code_values();
		}
		
		// if at SceneMenu then set __scrollable_area active to false so that a mouse click at SceneMenu cannot trigger a button click at __scrollable_area.
		if (FlxG.mouse.y >= FlxG.height - 50
		&&	__scrollable_area.active == true)
		{
			_group_scrollable_area.active = false;
			__scrollable_area.active = false;
		}
		
		else if (_group_scrollable_area.active == false
		||		 __scrollable_area.active == false)
		{
			_group_scrollable_area.active = true;
			__scrollable_area.active = true;					
		}
		
		Reg._table_column_sort_do_once = false;
		
		super.update(elapsed);
	
	}
	
}//