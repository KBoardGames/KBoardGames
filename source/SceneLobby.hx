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
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;
import flixel.math.FlxPoint;
import flixel.ui.FlxVirtualPad.FlxActionMode;

/**
 * ...
 * @author kboardgames.com
 */
class SceneLobby extends FlxState
{	
	/******************************
	* host of the room directly at right side of room buttons.
	*/
	private var __scene_lobby_room_host_username_text:Array<SceneLobbyRoomHostUsernameText> = [for (i in 0...24) new SceneLobbyRoomHostUsernameText(0, 0, 0, "", 0)]; 
	
	/******************************
	* room game title directly at right side of host text.
	*/
	private var __scene_lobby_game_title_text:Array<SceneLobbyGameTitleText> = [for (i in 0...24) new SceneLobbyGameTitleText(0, 0, 0, "", 0)]; 
	
	/******************************
	* the total player limit permitted for that room.
	*/
	private var __scene_lobby_room_player_limit_text:Array<SceneLobbyRoomPlayerLimitText> = [for (i in 0...24) new SceneLobbyRoomPlayerLimitText(0, 0, 0, "", 0)];
	
	/******************************
	* the total player limit permitted for that room.
	*/
	private var __scene_lobby_game_against_text:Array<SceneLobbyGameAgainstText> = [for (i in 0...24) new SceneLobbyGameAgainstText(0, 0, 0, "", 0)];
	
	/******************************
	* outputs true or false if spectators are allowed for that room.
	*/
	private var __scene_lobby_game_spectators_text:Array<SceneLobbyGameSpectatorsText> = [for (i in 0...24) new SceneLobbyGameSpectatorsText(0, 0, 0, "", 0)];
	
	public static var __game_chatter:GameChatter;
	private var __miscellaneous_menu_output:MiscellaneousMenuOutput;
	public var __menu_bar:MenuBar;
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
	* the title of this state.
	*/
	private var _title:FlxText;	
	private var _title_background:FlxSprite; // background for title.
	
	/******************************
	 * scene background
	 */
	private var _background:FlxSprite;
		
	/******************************
	 * button total displayed. also change this value at server.
	 */
	private var _room_total:Int = 24;
	
	/******************************
	 * access members here.
	 */
	private var _group_button_for_room:Array<ButtonGeneralNetworkYes> = [for (i in 0...24) new ButtonGeneralNetworkYes(0,0,"",0,0,0,0xfffffff,0,null)]; 
		
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
	 * to center the button's text at menuBar to button's height, those buttons need more than one update() call. when this var is not 0 then these buttons will be visible to scene, since the buttons text is now centered. without this var, the buttons text will be displayed at top of buttons for a brief second, showing what appears to be a display bug.
	 */
	private var _ticks_buttons_menuBar:Int = 0;
		
	/******************************
	 * message number used to display message box about cannot enter room message.
	 */
	public static var _message:Int = 0; 
	
	/******************************
	 *  // room number variable used in a message saying that the room is full.
	 */
	public static var _number_room_full:Int = 0;
		
	/******************************
	 * solid table rows.
	 */
	private var _table_rows:Array<FlxSprite> = [for (i in 0...26) new FlxSprite(0, 0)]; 
	
	private var _table_rows_color:FlxColor;
	
	/******************************
	 * we need different column separators for memory cleanup. this is a black bar between table rows.
	 */
	private var _column_separator:Array<FlxSprite> = [for (i in 0...5) new FlxSprite(0,0)]; 
	
	/******************************
	 * table column text.
	*/
	public var _table_column_text:Array<FlxText> = [for (i in 0...6) new FlxText(0,0,0,"",0)]; 
	
	override public function new():Void
	{
		super();
		
		Reg._at_game_room = false;
		Reg._at_lobby = true;
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
		_number = 0;
		_populate_table_body = false;
		_ticks_buttons_menuBar = 1;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		
		// for the user kicking or banning message box see "Is Action Needed For Player" event. that event calls RegTriggers._actionMessage which displays the message at platState.hx
	}
		
	public function initialize():Void
	{
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
				
		PlayState._text_logging_in.text = "";
		Reg._at_lobby = true;
		
		_populate_table_body = false;
		
		__menu_bar.initialize();
	}
		
	public function display():Void
	{	
		RegFunctions.fontsSharpen();		
				
		RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = RegTypedef._dataMovement._gid = RegTypedef._dataMisc.id;
		
		// lobby scene background. 
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
		}
		
		_background = new FlxSprite(0, 55);
		_background.makeGraphic(FlxG.width, FlxG.height-50);
		
		// changing this color value will also change lobby's chatter background.
		_background.color = FlxColor.BLACK;
		_background.scrollFactor.set(0, 0);
		add(_background);
		
		if (_group_scrollable_area != null)
		{
			remove(_group_scrollable_area);
			_group_scrollable_area.destroy();			
		}
		_group_scrollable_area = cast add(new FlxSpriteGroup());
		
		if (_title_background != null)
		{
			remove(_title_background);
			_title_background.destroy();			
		}
		
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width, 55, Reg._title_bar_background_enabled); 
		_title_background.scrollFactor.set(1,0);
		add(_title_background);
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();			
		}
		
		_title = new FlxText(15, 4, 0, "Lobby");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		_title.scrollFactor.set(1,0);
		_title.visible = true;
		add(_title);
		
		if (_button_lobby_refresh != null)
		{
			remove(_button_lobby_refresh);
			_button_lobby_refresh.destroy();			
		}
		
		// 360 is the chat width. 215 is this button with. 15 is the default space from the edge. 20 is the width of the scrollbar. 10 is the extra space needed to make it look nice,		
		_button_lobby_refresh = new ButtonGeneralNetworkYes(FlxG.width + -360 + -215 + -15 - 20 - 10, 12, "Lobby Refresh", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_refresh, RegCustom._button_color[Reg._tn], false);		
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
		draw_table_column();
		
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
			__game_chatter = new GameChatter(2);
			__game_chatter.visible = true;
			
			if (GameChatter.__scrollable_area2 != null)	
			{
				GameChatter.__scrollable_area2.active = true;
				GameChatter.__scrollable_area2.visible = true;
			}
			
			GameChatter._groupChatterScroller.x = 0; // value of 375 work with below var to hide,
			
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
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		// __menu_bar needs to remain local. do not use Reg.__menu_bar
		__menu_bar = new MenuBar();
		add(__menu_bar);
				
		set_not_active_for_buttons();
		initialize();
	
	}	
	
	private function draw_table_empty():Void
	{
		_table_rows_color = FlxColor.fromHSB(FlxG.random.int(1, 360), RegCustom._client_background_saturation[Reg._tn], (RegCustom._client_background_brightness[Reg._tn]-0.10));
		
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			_table_rows_color = RegCustomColors.color_client_background();
			_table_rows_color.alphaFloat = 0.15;
		}
		
		// Note that the last count ends before another loop, so only 26 loops will be made. 
		for (i in 1...26)
		{
			if (_table_rows[i] != null)
			{
				_group_scrollable_area.remove(_table_rows[i]);
				_table_rows[i].destroy();
			}
			
			// soild table rows
			_table_rows[i] = new FlxSprite(0, 0);
			_table_rows[i].makeGraphic(FlxG.width - 60, 55, _table_rows_color);		
			_table_rows[i].setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_rows[i].scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_rows[i]);
		}		
		
		//.....................................
		var _arr = [370, 600, 855, 1025, 1195];
		
		for (i in 0...5)
		{
			if (_column_separator[i] != null)
			{			
				_group_scrollable_area.remove(_column_separator[i]);
				_column_separator[i].destroy();
			}
			
			// we need different column separators for memory cleanup. this is a black bar between table rows.
			// first column separator.
			_column_separator[i] = new FlxSprite(0, 0);
			_column_separator[i].makeGraphic(10, 120 + (26 * 70), 0xFF000000);	
			_column_separator[i].setPosition(_arr[i] - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70)); 
			_column_separator[i].scrollFactor.set(0, 0);
			_group_scrollable_area.add(_column_separator[i]);
		
		}
				
	}
	
	/******************************
	 * Header title and columns text for the data rows.
	 */
	private function draw_table_column():Void
	{	
		var _count = _group_scrollable_area.members.length;
		var _column_name = ["Room State", "Room Host", "Game", "Players", "Against", "Spectators"];
		var _column_x = [143, 390, 620, 876, 1045, 1225];
		
		if (_table_header_background != null)
		{
			_group_scrollable_area.remove(_table_header_background);
			_table_header_background.destroy();
		}
		
		_table_header_background = new FlxSprite(0, 110);
		_table_header_background.makeGraphic(FlxG.width-10, 50, FlxColor.WHITE); 
		_table_header_background.scrollFactor.set(1, 0);
		_group_scrollable_area.add(_table_header_background);
		_group_scrollable_area.members[(_count)].scrollFactor.set(1, 0);
	
		
		for (i in 0...6)
		{
			if (_table_column_text[i] != null)
			{ 
				_group_scrollable_area.remove(_table_column_text[i]);
				_table_column_text[i].destroy();
			}		
			
			// table calumn text.
			_table_column_text[i] = new FlxText(_column_x[i] - _offset_x - _offset2_x, 120, 0, _column_name[i]);
			_table_column_text[i].setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
			_table_column_text[i].scrollFactor.set(0, 0);
			_group_scrollable_area.add(_table_column_text[i]);
			_group_scrollable_area.members[(_count+(i+1))].scrollFactor.set(1, 0);
		}
		
	}
	
	private function draw_table_all_body_buttons():Void
	{
		var _id:Int = 2;
	
		//_group_button_for_room.splice(0, _group_button_for_room.length);
		
		for (i in 0... _room_total) // change this value if increasing the button number.
		{
			// Positioned at the right side of the screen.
			if (_group_button_for_room[i] != null)
			{
				_group_scrollable_area.remove(_group_button_for_room[i]);
				_group_button_for_room[i].destroy();
			}
			
			_group_button_for_room[i] = new ButtonGeneralNetworkYes(100 - _offset_x, 125 - _offset_y + ((i + 1) * 70), Std.string(i) + ": " + _buttonState[RegTypedef._dataMisc._roomState[(i + 1)]], 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn], false, _id);
			
			#if html5
				if (i >= 2)
				{
					_group_button_for_room[i].label.color = FlxColor.WHITE;
				}
			#end
						
			_group_button_for_room[i].setPosition(100 - _offset_x, 125 - _offset_y + ((i+1) * 70));
			
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
		
						
				var _host = RegFunctions.gameName(RegTypedef._dataMisc._roomGameIds[i]);
				
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
				
				//----------------------- Is the player playing against humans or computers...
				var _vsComputer = RegTypedef._dataMisc._vsComputer[i];
				var _title:String = "Human";
			
				if (_vsComputer == 1) _title = "Computer";
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] == 0) _title = "";
				
				if (__scene_lobby_game_against_text[i] != null)
				{
					remove(__scene_lobby_game_title_text[i]);
					remove(__scene_lobby_game_against_text[i]);
					__scene_lobby_game_against_text[i].destroy();
				}
				
				__scene_lobby_game_against_text[i] = new SceneLobbyGameAgainstText(1045 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
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
				
				__scene_lobby_game_spectators_text[i] = new SceneLobbyGameSpectatorsText(1225 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
				__scene_lobby_game_spectators_text[i].font = Reg._fontDefault;
				_group_scrollable_area.add(__scene_lobby_game_spectators_text[i]);
				
			}
		}
				
		_populate_table_body = true; // if column text is still showing for a room then text = "" was not used at the class that display the row for that column. see GameLobbyGameSpectatorsText.hx for an example.
		
	}
	
	private function button_clicked(_num):Void
	{
		#if html5
			if (_num < 3) goto_room(_num);
		#else			
			goto_room(_num);
		#end
	}
		
	/******************************
	 * go to the room where the player waits for another player to play a game. else go to create room, Reg._getRoomData
	 */
	private function goto_room(_num:Int):Void
	{		
		_number = _num;
		
		// these are used to send a request to "get room data". at that event, _lobby_data_received is set to true then at this class that var is read along with _lobby_data_received_do_once to execute rather the player can enter the creating room or the waiting room. The vars also help to refresh the lobby with current data.
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
		
		PlayState.clientSocket.send("Get Statistics Win Loss Draw", RegTypedef._dataPlayers); 	
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		PlayState.clientSocket.send("Greater RoomState Value", RegTypedef._dataMisc); 
		haxe.Timer.delay(function (){}, Reg2._event_sleep);

	}
	
	/******************************
	 * this function is called when going to MiscellaneousMenu.hx, Leaderboards.hx or house.hx class.
	 */
	public function set_not_active_for_buttons():Void
	{
		Reg._at_lobby = false;
		HouseScrollMap._map_offset_x = 0;
		HouseScrollMap._map_offset_y = 0;
		
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
		
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
		{
			if (__menu_bar._buttonHouse != null) __menu_bar._buttonHouse.active = false;
		}
		
		if (__menu_bar._buttonMiscMenu != null) 
			__menu_bar._buttonMiscMenu.active = false;
		if (__menu_bar._button_daily_quests != null) 
			__menu_bar._button_daily_quests.active = false;
		if (__menu_bar._button_leaderboards != null) 
			__menu_bar._button_leaderboards.active = false;
		if (__menu_bar._button_tournaments != null) 
			__menu_bar._button_tournaments.active = false;
		
		if (_button_lobby_refresh != null)
		{
			_button_lobby_refresh.visible = false;
			_button_lobby_refresh.active = false;
		}
		
		_title_background.visible = false;
		_title.visible = false;
		
		for (i in 0... _table_column_text.length)
		{
			_table_column_text[i].visible = false;
		}
	}
	
	/******************************
	 * this function is called when returning from MiscellaneousMenu.hx or house.hx class.
	 */
	public function set_active_for_buttons():Void
	{
		Reg._at_lobby = true;
		HouseScrollMap._map_offset_x = 0;
		HouseScrollMap._map_offset_y = 0;
		
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
		
		_title_background.visible = true;
		_title.visible = true;
		
		for (i in 0... _table_column_text.length)
		{
			_table_column_text[i].visible = true;
		}
	}
	
	// this shows the menuBar buttons after a brief second.
	private function ticks_buttons_menuBar():Void
	{
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
		{
			if (__menu_bar._buttonHouse != null) 
			{
				__menu_bar._buttonHouse.active = true;
				__menu_bar._buttonHouse.visible = true;
			}
		}
		
		if (__menu_bar._buttonMiscMenu != null) 
			__menu_bar._buttonMiscMenu.active = true;
		if (__menu_bar._button_daily_quests != null) 
			__menu_bar._button_daily_quests.active = true;
		if (__menu_bar._button_leaderboards != null) 
			__menu_bar._button_leaderboards.active = true;
		if (__menu_bar._button_tournaments != null) 
			__menu_bar._button_tournaments.active = true;
		
		if (__menu_bar._buttonMiscMenu != null) 
			__menu_bar._buttonMiscMenu.visible = true;
		if (__menu_bar._button_daily_quests != null) 
			__menu_bar._button_daily_quests.visible = true;
		if (__menu_bar._button_leaderboards != null) 
			__menu_bar._button_leaderboards.visible = true;
		if (__menu_bar._button_tournaments != null) 
			__menu_bar._button_tournaments.visible = true;
		
		
	}

	private function button_refresh():Void
	{
		// player is at lobby, so a check for room lock is not needed to be sent to this event.
		RegTypedef._dataMisc._roomCheckForLock[0] = 0;
		
		// used for bug tracking. see function receive() at TcpClient.
		RegTypedef._dataMisc._triggerEvent = "foo"; // anything can be used here.
		
		PlayState.clientSocket.send("Get Room Data", RegTypedef._dataMisc);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
	override public function destroy()
	{
		if (_title != null) 
		{	
			_title_background.destroy();
			_title.destroy();			
		}	
		
		if (__scrollable_area != null && RegTypedef._dataMisc._userLocation == 0)
		{
			cameras.remove( __scrollable_area );
			__scrollable_area.destroy();
		}
		
				
		if (_group_scrollable_area != null)
		{
			remove(_group_scrollable_area);
			_group_scrollable_area.destroy();
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
		
		_number = 0;
		_populate_table_body = false;
	
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._loggedIn == true && Reg._at_create_room == false && Reg._at_waiting_room == false && Reg._at_lobby == true)
		{
			// _ticks_buttons_menuBar needs to be done this way so that when lobby first loads and mouse is at menuBar, the buttons' text is displayed centered to each button.
			if (_ticks_buttons_menuBar == 2)
			{
				FlxG.mouse.reset();
				FlxG.mouse.enabled = true;
		
				_ticks_buttons_menuBar = 3;
				
				__menu_bar._buttonMiscMenu.active = true;
					if (__menu_bar._buttonHouse != null) __menu_bar._buttonHouse.active = true;
			}
			
			if (_ticks_buttons_menuBar == 1)
			{
				_ticks_buttons_menuBar = 2;				
				
				ticks_buttons_menuBar();
			}
			
			if (RegTriggers._ticks_buttons_menuBar == true)
			{
				RegTriggers._ticks_buttons_menuBar = false;
				_ticks_buttons_menuBar = 1;
				
				_group_scrollable_area.active = true;
				__scrollable_area.active = true;
			}
			
			// fix a camera display bug where the _button_daily_quests can also be clicked from the right side of the screen because of the chatter scrollable area scrolling part of the scene.
			if (__menu_bar._buttonMiscMenu.visible == true
			&&	_ticks_buttons_menuBar == 3)
			{
				if (FlxG.mouse.x > FlxG.width / 2
				&&  FlxG.mouse.y >= FlxG.height - 50) 
				{
					__menu_bar._buttonMiscMenu.active = false;
					if (__menu_bar._buttonHouse != null) __menu_bar._buttonHouse.active = false;
				}
				else
				{
					__menu_bar._buttonMiscMenu.active = true;
					if (__menu_bar._buttonHouse != null) __menu_bar._buttonHouse.active = true;
				}
			}
			
			for (i in 0... _room_total)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y >= _group_button_for_room[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y <= _group_button_for_room[i]._startY + _group_button_for_room[i]._button_height + 7 && FlxG.mouse.y < FlxG.height - 50
				&& FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _group_button_for_room[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _group_button_for_room[i]._startX + _group_button_for_room[i]._button_width && FlxG.mouse.justPressed == true )
				{
					if (_group_button_for_room[i].alpha == 1)
					{
						if (RegCustom._sound_enabled[Reg._tn] == true
						&&  Reg2._scrollable_area_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
					
						_group_button_for_room[i].alpha = 0.3;
						Reg2._lobby_button_alpha = 0.3;
						button_clicked((i + 1));					
						break;
					}
				}
				
				// is same as above but mouse is not pressed.
				else if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y >= _group_button_for_room[i]._startY && FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y <= _group_button_for_room[i]._startY + _group_button_for_room[i]._button_height + 7 
				&& FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _group_button_for_room[i]._startX && FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _group_button_for_room[i]._startX + _group_button_for_room[i]._button_width
				&& FlxG.mouse.enabled == true)
				{
					#if html5
						if (i < 2) 
						{
							_group_button_for_room[i].active = true; 
						}
					#end
					
					break;
				}
				
			
			}
	
			// send the offset of the scrollable area to the button class so that when scrolling the scrollable area, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
			ButtonGeneralNetworkYes._scrollarea_offset_x = __scrollable_area.scroll.x;
			ButtonGeneralNetworkYes._scrollarea_offset_y = __scrollable_area.scroll.y;
									
			//############################# BUTTON TEXT
			if (_populate_table_body == false)
			{
				draw_table_all_body_text();
			}
			
			if (_group_button_for_room[0] != null && RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] == 0) 
			{	
				// display room full text for lobby room button if max players are in that room.
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[1] >= RegTypedef._dataMisc._roomPlayerLimit[1] && RegTypedef._dataMisc._roomPlayerLimit[1] > 0 && RegTypedef._dataMisc._roomState[1] < 8
				|| Reg._gameId >= 2 
				&& RegTypedef._dataMisc._roomState[1] == 8)
				_group_button_for_room[0].label.text = "1: " + _buttonState[7];
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[2] >= RegTypedef._dataMisc._roomPlayerLimit[2] && RegTypedef._dataMisc._roomPlayerLimit[2] > 0 && RegTypedef._dataMisc._roomState[2] < 8
				|| Reg._gameId >= 2 
				&& RegTypedef._dataMisc._roomState[2] == 8)
				_group_button_for_room[1].label.text = "2: " + _buttonState[7];

				// display the player vs player room.
				for (i in 1... _room_total+1)	
				{
					// this is a room that is not full.
					_group_button_for_room[(i-1)].label.text = Std.string(i) + ": " + _buttonState[RegTypedef._dataMisc._roomState[i]];
				
					// output either a room full or watch game button label.
					if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] >= RegTypedef._dataMisc._roomPlayerLimit[i] && RegTypedef._dataMisc._roomPlayerLimit[i] > 0 && RegTypedef._dataMisc._roomState[i] > 1)
					{						
						if (RegTypedef._dataMisc._roomState[i] <= 7
						||  RegTypedef._dataMisc._allowSpectators[i] == 0)
							_group_button_for_room[(i-1)].label.text = Std.string(i)+ ": " + _buttonState[7];
						else if (RegTypedef._dataMisc._roomState[i] == 8
						||  RegTypedef._dataMisc._allowSpectators[i] == 1)
							_group_button_for_room[(i-1)].label.text = Std.string(i)+ ": " + _buttonState[8];
					}
				}
					
				draw_table_all_body_text();
				
			}
		}
		
		if (RegTriggers._makeMiscellaneousMenuClassActive == true)
		{			
			set_not_active_for_buttons();
			
			RegTriggers._makeMiscellaneousMenuClassActive = false;
			
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
		
		if (RegTriggers._make_daily_quests_not_active == true)
		{
			RegTriggers._make_daily_quests_not_active = false;
			
			__menu_bar.__daily_quests.__scrollable_area.visible = false;
			__menu_bar.__daily_quests.__scrollable_area.active = false;
			__menu_bar.__daily_quests.visible = false;
			__menu_bar.__daily_quests.active = false;				
		}
		
		if (RegTriggers._make_tournaments_not_active == true)
		{
			RegTriggers._make_tournaments_not_active = false;
			
			__menu_bar.__tournaments.visible = false;
			__menu_bar.__tournaments.active = false;				
		}
		
		if (RegTriggers._make_leaderboards_not_active == true)
		{
			RegTriggers._make_leaderboards_not_active = false;
			
			__menu_bar.__leaderboards.__scrollable_area.visible = false;
			__menu_bar.__leaderboards.__scrollable_area.active = false;
			__menu_bar.__leaderboards.visible = false;
			__menu_bar.__leaderboards.active = false;				
		}
				
		if (RegTriggers._returnToLobbyMakeButtonsActive == true)
		{
			RegTriggers._returnToLobbyMakeButtonsActive = false;
			set_active_for_buttons();
			
			Reg._at_lobby = true;					
		}
		
		// invite to room, accept? ok button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "l1000")
		{
			_group_scrollable_area.active = true;
			
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			goto_room(Reg._inviteRoomNumberToJoin);
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
			
		// invite to room,  cancel button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "l1000")
		{			
			_group_scrollable_area.active = true;
			
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
		
		if (Reg._getRoomData == true)
		{
			if (_lobby_data_received == false 
			&& _lobby_data_received_do_once == true)
			{
				_lobby_data_received_do_once = false;
				
				// used to display a message is the room is locked. when getting this event, the _userLocation is set to a greater value. the next time to this code a message about a locked room cannot be given if this value is not 0.
				RegTypedef._dataMisc._userLocation = 0;
				PlayState.clientSocket.send("Get Room Data", RegTypedef._dataMisc);
				haxe.Timer.delay(function (){}, Reg2._event_sleep);
			}
			
			if (_lobby_data_received == true)
			{
				_lobby_data_received = false;
				
				// do not re-enter this function. instead, do to create room or waiting room.
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
				
				// if true then the player clicked room a or b to play against the computer.
				if (RegTypedef._dataMisc._vsComputer[_number] == 1)
				{
					if (_number == 1) Reg._gameId = 4;
					else Reg._gameId = 1;
					
					RegTypedef._dataMisc._room = _number;
					
					Reg._getRoomData = true;
					set_not_active_for_buttons();		
					
					Reg._game_online_vs_cpu = true;
					RegTypedef._dataPlayers._spectatorPlaying = true;
			
					//------------------------
					// playing against the computer. this is the computer name and avatar.	
					Reg2._offline_cpu_host_name2 = RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room];
					
					for (i in 0...5)
					{
						if (Reg2._offline_cpu_host_names[i] 
						==  Reg2._offline_cpu_host_name2)
							RegCustom._profile_avatar_number2[Reg._tn] = Reg2._offline_cpu_avatar_number[i];
												
					}
		
					//------------------------
			
					SceneCreateRoom.createRoomOnlineAgainstCPU();
					
					return;
				}
				
								
				else if (RegTypedef._dataMisc._roomState[_number] == 1)
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
						PlayState.clientSocket.send("Is Room Locked", RegTypedef._dataMisc);
						haxe.Timer.delay(function (){}, Reg2._event_sleep);						
					}
					
					// waiting room.
					else if (RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] < RegTypedef._dataMisc._roomPlayerLimit[_number] && RegTypedef._dataMisc._roomPlayerLimit[_number] > 0)
					{
						RegTypedef._dataMisc._userLocation = 2;
						RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 1;
						PlayState.clientSocket.send("Is Room Locked", RegTypedef._dataMisc);		
						haxe.Timer.delay(function (){}, Reg2._event_sleep);
					}
					
					// set invite var back to 0.
					Reg._inviteRoomNumberToJoin = 0;
				}
			}				
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
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
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
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
		
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l2222")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			//Reg._buttonCodeValues = ""; this var is cleared at ButtonGeneralNetworkYes class
			Reg._server_message = "";
		}
		
		// if at SceneMenu then set __scrollable_area active to false so that a mouse click at SceneMenu cannot trigger a button click at __scrollable_area.
		if (FlxG.mouse.y >= FlxG.height - 50
		&&	_ticks_buttons_menuBar >= 3)
		{
			_group_scrollable_area.active = false;
			__scrollable_area.active = false;
		}
		
		else
		{
			_group_scrollable_area.active = true;
			__scrollable_area.active = true;
		}
		
		super.update(elapsed);
	}
	
}//