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
 * ...
 * @author kboardgames.com
 */
class SceneLobby extends FlxState
{
	/******************************
	 * button total displayed. also change this value at server.
	 */
	private var _button_total:Int = 24;
	
	/******************************
	 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
	 */
	private var _tracker:FlxSprite;
	
	private var __miscellaneous_menu:MiscellaneousMenu;
	private var __daily_quests:DailyQuests;
	private var __new_account:NewAccount;
	
	public var group2:FlxSpriteGroup;		
	
	/******************************
	* anything added to this group will be placed inside of the boxScroller field. 
	*/
	public var group:FlxSpriteGroup;	
	public var __boxscroller:FlxScrollableArea;	
	
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
	
	private var _group_button:Array<ButtonGeneralNetworkYes> = []; // access members here.
	
	/******************************
	* host of the room directly at right side of room buttons.
	*/
	private var __scene_lobby_room_host_username_text:SceneLobbyRoomHostUsernameText;
	
	/******************************
	* room game title directly at right side of host text.
	*/
	private var __scene_lobby_game_title_text:SceneLobbyGameTitleText;
	
	/******************************
	* the total player limit permitted for that room.
	*/
	private var __scene_lobby_room_player_limit_text:SceneLobbyRoomPlayerLimitText;
		
	/******************************
	* the total player limit permitted for that room.
	*/
	private var __scene_lobby_game_against_text:SceneLobbyGameAgainstText;
	
	/******************************
	* outputs true or false if spectators are allowed for that room.
	*/
	private var __scene_lobby_game_spectators_text:SceneLobbyGameSpectatorsText;
	
	/******************************
	* the number of the room that was selected.
	*/
	public static var _number:Int = 0;
	
	/******************************
	* do not new FlxText or button the second time. only one field at a coordinate permitted.
	*/
	public static var _didPopulateList:Bool = false;
	
	private var _buttonMiscMenu:ButtonGeneralNetworkYes;
	private var _buttonHouse:ButtonGeneralNetworkYes;
	private var _button_daily_quests:ButtonGeneralNetworkYes;
	private var _button_tournaments:ButtonGeneralNetworkYes;	
	private var _tournaments:Tournaments;
	private var _button_leaderboards:ButtonGeneralNetworkYes;
	private var _leaderboards:Leaderboards;
	private var _button_lobby_refresh:ButtonGeneralNetworkYes;
	
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offset_x:Int = 50;
	
	/******************************
	 * moves all row data, excluding the button row. to the left side.
	 */
	private var _offset2_x:Int = 43;
	
	/******************************
	 * moves everything up by these many pixels.
	 */
	private var _offset_y:Int = 20;
	
	public var __house:House;
	
	/******************************
	 * white bar with text such as host, game title, spectators, overtop of it.
	 */
	private var _title_sub_background:FlxSprite;
	
	/******************************
	 * Header columns text for the data rows.	
	*/
	public var _t1:FlxText;
	public var _t2:FlxText;
	public var _t3:FlxText;
	public var _t4:FlxText;
	public var _t5:FlxText;
	public var _t6:FlxText;
	
	/******************************
	 * to center the button's text at menuBar to button's height, those buttons need more than one update() call. when this var is not 0 then these buttons will be visible to scene, since the buttons text is now centered. without this var, the buttons text will be displayed at top of buttons for a brief second, showing what appears to be a display bug.
	 */
	private var _ticks_buttons_menuBar:Int = 0;
		
	public static var __game_chatter:GameChatter;
	
	public static var _message:Int = 0; // message number used to display message box about cannot enter room message.
	
	public static var _number_room_full:Int = 0; // room number.
	
	override public function new():Void
	{
		super();
		
		//FlxG.worldDivisions = 1;
		//FlxG.worldBounds.set(0);
		
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
		_number = 0;
		_didPopulateList = false;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		
		// for the user kicking or banning message box see "Is Action Needed For Player" event. that event calls RegTriggers._actionMessage which displays the message at platState.hx
	}
	
	public function display():Void
	{	
		RegFunctions.fontsSharpen();		
				
		if (RegCustom._config_house_feature_enabled == true)
		{
			RegHouse.resetHouseAtLobby();
		}
		
		RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = RegTypedef._dataMovement._gid = RegTypedef._dataMisc.id;
		
		var background = new FlxSprite();
		background.makeGraphic(FlxG.width,FlxG.height-50,FlxColor.WHITE);
		background.color = FlxColor.BLACK;
		background.scrollFactor.set(0, 0);
		add(background);
		
		group = cast add(new FlxSpriteGroup());
		
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width - 40, 50, 0xFF440000); 
		_title_background.scrollFactor.set(1,1);
		add(_title_background);
		
		_title = new FlxText(15, 0, 0, "Lobby");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_title.scrollFactor.set(1,1);
		_title.visible = true;
		add(_title);
		
		// 360 is the chat width. 215 is this button with. 15 is the default space from the edge. 20 is the width of the scrollbar. 10 is the extra space needed to make it look nice,
		_button_lobby_refresh = new ButtonGeneralNetworkYes(FlxG.width + -360 + -215 + -15 - 20 - 10, 10, "Lobby Refresh", 215, 35, Reg._font_size, 0xFFCCFF33, 0, button_refresh, 0xFF000044, false);		
		_button_lobby_refresh.label.font = Reg._fontDefault;
		_button_lobby_refresh.scrollFactor.set(0, 0);
		add(_button_lobby_refresh);
				
		// see populateRoomList() for table rows
		//---------------------------------------------- End of header columns text
		_buttonState[0] = "Empty";
		_buttonState[1] = "Computer";
		_buttonState[2] = "Creating";
		_buttonState[3] = "Join";
		_buttonState[4] = "Join";
		_buttonState[5] = "Join";
		_buttonState[6] = "join";
		_buttonState[7] = "Full";
		_buttonState[8] = "Watch";
		
		var _color_table_rows = FlxColor.fromHSB(FlxG.random.int(1, 360), 0.8, 0.15);
		
		// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 26 loops will be made. 
		for (i in 1...27)
		{
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(FlxG.width - 60, 55, _color_table_rows);		
			slotBox.setPosition(20, 120 - _offset_y + (i * 70)); 
			slotBox.scrollFactor.set(0, 0);
			group.add(slotBox);
		}		
		
		//.....................................
		// a black bar between table rows.
		// first column border. columns are minus 30 from Header column text.
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (26 * 70), 0xFF000000);		
		slotBox.setPosition(370 - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (26 * 70), 0xFF000000);		
		slotBox.setPosition(600 - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (26 * 70), 0xFF000000);		
		slotBox.setPosition(855 - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70));
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (26 * 70), 0xFF000000);		
		slotBox.setPosition(1025 - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70));
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0); // before the spectators text.
		slotBox.makeGraphic(10, 120 + (26 * 70), 0xFF000000);		
		slotBox.setPosition(1195 - _offset_x - _offset2_x, 120 - _offset_y + (1 * 70));
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		//--------------------------
		
		var _idSprite:Int = 0;
	
		_group_button.splice(0, _group_button.length);
		
		for (i in 0... _button_total) // change this value if increasing the button number.
		{
			// buttons displayed overtop of a text box. Positioned at the right side of the screen.
			var _button = new ButtonGeneralNetworkYes(100 - _offset_x, 125 - _offset_y + ((i + 1) * 70), "3: " + _buttonState[RegTypedef._dataMisc._roomState[(i + 1)]], 215, 35, Reg._font_size, 0xFFCCFF33, 0, null, 0xff000044, false, 2 );
			_button.over_color = 0xFFFFFFFF;
			_button.visible = false;
			_button.active = false;
									
			_group_button.push(_button);				
			_group_button[i].visible = true;
			
			#if html5
				if (i >= 2)
				{
					_group_button[i].label.color = FlxColor.WHITE;
					_group_button[i].active = false;
				}
			#end
						
			_group_button[i].setPosition(100 - _offset_x, 125 - _offset_y + ((i+1) * 70));
			
			
			_group_button[i].ID = 2;
			group.add(_group_button[i]);
					
			_idSprite += 1;
		}
				
		//populateRoomList(); // table data such as playing game text beside room buttons.
				
		//---------------------------------------------- Header title and columns text for the data rows.		
		var _count = group.members.length-1;
		
		_title_sub_background = new FlxSprite(0, 110);
		_title_sub_background.makeGraphic(FlxG.width - 40, 50, FlxColor.WHITE); 
		_title_sub_background.scrollFactor.set(1, 0);
		group.add(_title_sub_background);
		group.members[(_count+1)].scrollFactor.set(1, 0);
		
		_t1 = new FlxText(100 - _offset_x, 120, 0, "Room State");
		_t1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		group.add(_t1);
		group.members[(_count+2)].scrollFactor.set(1, 0);
		
		_t2 = new FlxText(390 - _offset_x - _offset2_x, 120, 0, "Room Host");
		_t2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		_t2.scrollFactor.set(0, 0);
		group.add(_t2);
		group.members[(_count+3)].scrollFactor.set(1, 0);
		
		_t3 = new FlxText(620 - _offset_x - _offset2_x, 120, 0, "Game");
		_t3.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		_t3.scrollFactor.set(0, 0);
		group.add(_t3);
		group.members[(_count+4)].scrollFactor.set(1, 0);
		
		_t4 = new FlxText(876 - _offset_x - _offset2_x, 120, 0, "Players");
		_t4.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		_t4.scrollFactor.set(0, 0);
		group.add(_t4);
		group.members[(_count+5)].scrollFactor.set(1, 0);
		
		_t5 = new FlxText(1045 - _offset_x - _offset2_x, 120, 0, "Against");
		_t5.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		_t5.scrollFactor.set(0, 0);
		group.add(_t5);
		group.members[(_count+6)].scrollFactor.set(1, 0);
		
		_t6 = new FlxText(1225 - _offset_x - _offset2_x, 120, 0, "Spectators");
		_t6.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.BLACK);
		_t6.scrollFactor.set(0, 0);
		group.add(_t6);
		group.members[(_count+7)].scrollFactor.set(1, 0);
		
		if (RegCustom._chat_turn_off_for_lobby == false)
		{
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)
			if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
			__boxscroller = new FlxScrollableArea( new FlxRect(0, 0, 1390-360, FlxG.height - 50), new FlxRect(0, 0, 1390, 1950), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, true);
			
			FlxG.cameras.add( __boxscroller );
			__boxscroller.antialiasing = true;
			__boxscroller.pixelPerfectRender = true;
			
			__game_chatter = new GameChatter(2);
			__game_chatter.visible = true;
			
			if (GameChatter.__boxscroller2 != null)	
			{
				GameChatter.__boxscroller2.active = true;
				GameChatter.__boxscroller2.visible = true;
			}
			
			GameChatter._groupChatterScroller.x = 0; // value of 375 work with below var to hide,
			
			add(__game_chatter);
		}
		
		else
		{
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)
			if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
			__boxscroller = new FlxScrollableArea( new FlxRect(0, 0, 1400, FlxG.height - 50), new FlxRect(0, 0, 1400, 1950), ResizeMode.FIT_WIDTH, 0, 100, -1, FlxColor.LIME, null, 0, true);
			
			FlxG.cameras.add( __boxscroller );
			__boxscroller.antialiasing = true;
			__boxscroller.pixelPerfectRender = true;
			
		}
		
		var __menu_bar = new MenuBar();
		add(__menu_bar);
		
		// this button is not visible. it is placed under the house button and is used by other buttons, in case the house feature is disabled, so they can still be horizontally positioned on the menu bar.
		var _buttonHouse_under = new ButtonGeneralNetworkYes(100 - _offset_x, FlxG.height - 40, "", 215, 35, Reg._font_size, 0xFFCCFF33, 0, null, 0xFF000044, false);		
		_buttonHouse_under.label.font = Reg._fontDefault;
		_buttonHouse_under.visible = false;
		_buttonHouse_under.scrollFactor.set(0, 0);
		add(_buttonHouse_under);
		
		if (RegCustom._config_house_feature_enabled == true)
		{
			_buttonHouse = new ButtonGeneralNetworkYes(100 - _offset_x, FlxG.height - 40, "House", 215, 35, Reg._font_size, 0xFFCCFF33, 0, house, 0xFF000044, false);		
			_buttonHouse.label.font = Reg._fontDefault;
			_buttonHouse.visible = false;
			_buttonHouse.scrollFactor.set(0, 0);
			add(_buttonHouse);
		}
		
		// game instructions, stats.
		_buttonMiscMenu = new ButtonGeneralNetworkYes(_buttonHouse_under.x + 230, FlxG.height - 40, "Misc Menu", 215, 35, Reg._font_size, 0xFFCCFF33, 0, miscMenu, 0xFF000044, false);		
		_buttonMiscMenu.label.font = Reg._fontDefault;
		_buttonMiscMenu.visible = false;
		_buttonMiscMenu.scrollFactor.set(0, 0);
		add(_buttonMiscMenu);
		
		// daily quests
		_button_daily_quests = new ButtonGeneralNetworkYes(_buttonMiscMenu.x + 230, FlxG.height - 40, "Daily Quests", 215, 35, Reg._font_size, 0xFFCCFF33, 0, dailyQuests, 0xFF000044, false);		
		_button_daily_quests.label.font = Reg._fontDefault;
		_button_daily_quests.scrollFactor.set(0, 0);
		_button_daily_quests.visible = false;
		add(_button_daily_quests);
		
		// tournaments
		_button_tournaments = new ButtonGeneralNetworkYes(_button_daily_quests.x + 230, FlxG.height - 40, "Tournaments", 215, 35, Reg._font_size, 0xFFCCFF33, 0, tournaments, 0xFF000044, false);		
		_button_tournaments.label.font = Reg._fontDefault;
		_button_tournaments.scrollFactor.set(0, 0);
		_button_tournaments.visible = false;
		add(_button_tournaments);
		
		// leaderboards.
		if (RegCustom._config_leaderboard_enabled == true)
		{
			_button_leaderboards = new ButtonGeneralNetworkYes(_button_tournaments.x + 230, FlxG.height - 40, "Leaderboards", 215, 35, Reg._font_size, 0xFFCCFF33, 0, leaderboards, 0xFF000044, false);		
			_button_leaderboards.label.font = Reg._fontDefault;
			_button_leaderboards.scrollFactor.set(0, 0);
			_button_leaderboards.visible = false;
			add(_button_leaderboards);
		}
				
		setNotActiveForButtons();
		options();
		
	}
	
	override public function destroy()
	{
		if (_title != null) 
		{	
			_title.destroy();
			_title_background.destroy();			
		}	
		
		if (__boxscroller != null && RegTypedef._dataMisc._userLocation == 0)
		{
			cameras.remove( __boxscroller );
			__boxscroller.destroy();
			__boxscroller = null;
		}
		
				
		if (group != null) group.destroy();
		
		if (__house != null)
		{
			remove(__house);
			__house.destroy();
		}
		
		if (__miscellaneous_menu != null)
		{
			remove(__miscellaneous_menu);
			__miscellaneous_menu.destroy();
		}
		
		_number = 0;
		_didPopulateList = false;
	
		super.destroy();
	}
	
	public function requestLobbyData():Void
	{
		RegTypedef._dataMisc._room = 0;
		
		// player is at lobby, so a check for room lock is not needed to be sent to this event.
		RegTypedef._dataMisc._roomCheckForLock[0] = 0;
		
		// used for bug tracking. see function receive() at TcpClient.
		RegTypedef._dataMisc._triggerEvent = "foo"; // anything can be used here.
		PlayState.clientSocket.send("Get Room Data", RegTypedef._dataMisc);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
		RegTypedef._dataMisc._triggerEvent = "";
	}
	
	public function populateRoomList():Void
	{		
		//....................... host Title data at lobby boxScroller.
		if (_didPopulateList == false)
		{
			for (i in 0...27)
			{
			
				var _gameName = Std.string(RegTypedef._dataMisc._roomHostUsername[i]);
				
				__scene_lobby_room_host_username_text = new SceneLobbyRoomHostUsernameText(390 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
								
				__scene_lobby_room_host_username_text.text = Std.string(_gameName);	
				__scene_lobby_room_host_username_text.font = Reg._fontDefault;
				group.add(__scene_lobby_room_host_username_text);
		
						
				var _host = RegFunctions.gameName(RegTypedef._dataMisc._roomGameIds[i]);
					
				__scene_lobby_game_title_text = new SceneLobbyGameTitleText(620 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, " ", Reg._font_size, i);
				__scene_lobby_game_title_text.fieldWidth = 220;
				__scene_lobby_game_title_text.wordWrap = false;
				__scene_lobby_game_title_text.text = " ";
				__scene_lobby_game_title_text.font = Reg._fontDefault;
				group.add(__scene_lobby_game_title_text);
		
		
				//....................... Room player limit data at lobby boxScroller.
				var _total = RegTypedef._dataMisc._roomPlayerCurrentTotal[i] + "/" + RegTypedef._dataMisc._roomPlayerLimit[i];
				
				__scene_lobby_room_player_limit_text = new SceneLobbyRoomPlayerLimitText(875 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
					
				__scene_lobby_room_player_limit_text.text = Std.string(_total);
				__scene_lobby_room_player_limit_text.font = Reg._fontDefault;
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] == 0) __scene_lobby_room_player_limit_text.text = "";
				
				group.add(__scene_lobby_room_player_limit_text);
				
				//----------------------- Is the player playing against humans or computers...
				var _vsComputer = RegTypedef._dataMisc._vsComputer[i];
				var _title:String = "Human";
			
				if (_vsComputer == 1) _title = "Computer";
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] == 0) _title = "";
					
				__scene_lobby_game_against_text = new SceneLobbyGameAgainstText(1045 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
				__scene_lobby_game_against_text.text = _title;
				__scene_lobby_game_against_text.font = Reg._fontDefault;
				group.add(__scene_lobby_game_against_text);
				
				//----------------------- spectators.
				__scene_lobby_game_spectators_text = new SceneLobbyGameSpectatorsText(1225 - _offset_x - _offset2_x, 130 - _offset_y + i * 70, 0, "", Reg._font_size, i);
				
				__scene_lobby_game_spectators_text.font = Reg._fontDefault;
				group.add(__scene_lobby_game_spectators_text);
				
			}
		}
				
		_didPopulateList = true; // if column text is still showing for a room then text = "" was not used at the class that display the row for that column. see GameLobbyGameSpectatorsText.hx for an example.
		
	}
	
	
	public function options():Void
	{
		_lobby_data_received = false;
		_lobby_data_received_do_once = true;
		_ticks_buttons_menuBar = 0;
		
		PlayState._text_logging_in.text = "";
		Reg._at_lobby = true;
		

		if (RegCustom._config_house_feature_enabled == true)
		{
			RegTypedef.resetHouseData(); // this is needed to avoid a crash.	
			RegHouse.resetHouseAtLobby();
			
			PlayState.clientSocket.send("House Load", RegTypedef._dataHouse);
			haxe.Timer.delay(function (){}, Reg2._event_sleep); 
		} else RegTriggers._returnToLobbyMakeButtonsActive = true;
		
		_didPopulateList = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._loggedIn == true && Reg._atRoom == false && Reg._atChat == false && Reg._at_lobby == true)
		{
			// _ticks_buttons_menuBar needs to be done this way so that when lobby first loads and mouse is at menuBar, the buttons' text is displayed centered to each button.
			if (_ticks_buttons_menuBar == 2)
			{
				_ticks_buttons_menuBar = 3;
				
				_buttonMiscMenu.active = true;
					if (_buttonHouse != null) _buttonHouse.active = true;
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
				
				group.active = true;
				__boxscroller.active = true;
			}
			
			// fix a camera display bug where the _button_daily_quests can also be clicked from the right side of the screen because of the chatter boxScroller scrolling part of the scene.
			if (_buttonMiscMenu.visible == true
			&&	_ticks_buttons_menuBar == 3)
			{
				if (FlxG.mouse.x > FlxG.width / 2
				&&  FlxG.mouse.y >= FlxG.height - 50) 
				{
					_buttonMiscMenu.over_color = 0xFFFFFFFF;
					_buttonMiscMenu.active = false;
					if (_buttonHouse != null) _buttonHouse.active = false;
				}
				else
				{
					_buttonMiscMenu.active = true;
					_buttonMiscMenu.over_color = 0xFF00FF00;
					if (_buttonHouse != null) _buttonHouse.active = true;
				}
			}
			
			for (i in 0... _button_total)
			{
				// if mouse is on the button plus any offset made by the box scroller and mouse is pressed...
				if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y >= _group_button[i]._startY &&  FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height + 7 && FlxG.mouse.y < FlxG.height - 50
				&& FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _group_button[i]._startX &&  FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width && FlxG.mouse.justPressed == true )
				{
					if (_group_button[i].alpha == 1)
					{
						if (RegCustom._enable_sound == true
						&&  Reg2._boxScroller_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
					
						_group_button[i].alpha = 0.3;
						Reg2._lobby_button_alpha = 0.3;
						buttonClicked((i + 1));					
						break;
					}
				}
				
				// is same as above but mouse is not pressed.
				else if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y >= _group_button[i]._startY && FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y <= _group_button[i]._startY + _group_button[i]._button_height + 7 
				&& FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _group_button[i]._startX && FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _group_button[i]._startX + _group_button[i]._button_width
				&& FlxG.mouse.enabled == true)
				{
					#if html5
						if (i < 2) 
						{
							_group_button[i].active = true; 
							_group_button[i].label.color = 0xFF00FF00;
						}
					#else
						_group_button[i].active = true;
						_group_button[i].label.color = 0xFF00FF00;
					#end
					
					break;
				}
				// if mouse is not at a button then set it not active.
				else if (FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y < _group_button[i]._startY 
				||  FlxG.mouse.y + ButtonGeneralNetworkYes._scrollarea_offset_y > _group_button[i]._startY + _group_button[i]._button_height + 7
				||  FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x < _group_button[i]._startX 
				||  FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x > _group_button[i]._startX + _group_button[i]._button_width)			
				{
					if (FlxG.mouse.enabled == true)
					{					
						if (_group_button[i].label.color == 0xFFFFFFFF) 
							_group_button[i].active = false;
						_group_button[i].label.color = 0xFFFFFFFF;
					
					}
				}
			
			}
	
			// send the offset of the boxScroller to the button class so that when scrolling the boxScroller, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
			ButtonGeneralNetworkYes._scrollarea_offset_x = __boxscroller.scroll.x;
			ButtonGeneralNetworkYes._scrollarea_offset_y = __boxscroller.scroll.y;
			
			if (RegCustom._config_house_feature_enabled == true)
			{
				if (RegTriggers._new_the_house == true)
				{
					RegTriggers._new_the_house = false;
					
					if (__house == null)
					{
						__house = new House();
						add(__house);
						
						RegTriggers._houseDrawSpritesDoNotEnter = true;
					}	
				}
			}
						
			//############################# BUTTON TEXT
			if (_didPopulateList == false)
			{
				populateRoomList();
			}
			
			if (_group_button[0] != null && RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] == 0) 
			{	
				// display room full text for lobby room button if max players are in that room.
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[1] >= RegTypedef._dataMisc._roomPlayerLimit[1] && RegTypedef._dataMisc._roomPlayerLimit[1] > 0 && RegTypedef._dataMisc._roomState[1] < 8
				|| Reg._gameId >= 2 
				&& RegTypedef._dataMisc._roomState[1] == 8)
				_group_button[0].label.text = "1: " + _buttonState[7];
				
				if (RegTypedef._dataMisc._roomPlayerCurrentTotal[2] >= RegTypedef._dataMisc._roomPlayerLimit[2] && RegTypedef._dataMisc._roomPlayerLimit[2] > 0 && RegTypedef._dataMisc._roomState[2] < 8
				|| Reg._gameId >= 2 
				&& RegTypedef._dataMisc._roomState[2] == 8)
				_group_button[1].label.text = "2: " + _buttonState[7];

				// display the player vs player room.
				for (i in 1... _button_total+1)	
				{
					// this is a room that is not full.
					_group_button[(i-1)].label.text = Std.string(i) + ": " + _buttonState[RegTypedef._dataMisc._roomState[i]];
				
					// output either a room full or watch game button label.
					if (RegTypedef._dataMisc._roomPlayerCurrentTotal[i] >= RegTypedef._dataMisc._roomPlayerLimit[i] && RegTypedef._dataMisc._roomPlayerLimit[i] > 0 && RegTypedef._dataMisc._roomState[i] > 1)
					{						
						if (RegTypedef._dataMisc._roomState[i] <= 7
						||  RegTypedef._dataMisc._allowSpectators[i] == 0)
							_group_button[(i-1)].label.text = Std.string(i)+ ": " + _buttonState[7];
						else if (RegTypedef._dataMisc._roomState[i] == 8
						||  RegTypedef._dataMisc._allowSpectators[i] == 1)
							_group_button[(i-1)].label.text = Std.string(i)+ ": " + _buttonState[8];
					}
				}
					
				populateRoomList();
				
					
				
			}
		}
		
		if (RegTriggers._makeMiscellaneousMenuClassActive == true)
		{			
			setNotActiveForButtons();
			
			RegTriggers._makeMiscellaneousMenuClassActive = false;
			
			if (__miscellaneous_menu != null)
			{
				__miscellaneous_menu.active = true;
				__miscellaneous_menu.visible = true;
			}
							
		}
		
		if (RegTriggers._makeMiscellaneousMenuClassNotActive == true)
		{
			RegTriggers._makeMiscellaneousMenuClassNotActive = false;
			
			if (__miscellaneous_menu != null)
				__miscellaneous_menu.active = false;
				
		}
		
		if (RegTriggers._miscellaneousMenuOutputClassActive == true)
		{
			RegTriggers._miscellaneousMenuOutputClassActive = false;
			
			setNotActiveForButtons();		
			var __miscellaneous_menu_output = new MiscellaneousMenuOutput(Reg2._miscMenuIparameter);
			add(__miscellaneous_menu_output);					
		}
		
		if (RegTriggers._returnToLobbyMakeButtonsActive == true)
		{
			RegTriggers._returnToLobbyMakeButtonsActive = false;
			setActiveForButtons();
			
			Reg._at_lobby = true;					
		}
		
		// invite to room, accept? ok button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "l1000")
		{
			group.active = true;
			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			gotoRoom(Reg._inviteRoomNumberToJoin);
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
			
		// invite to room,  cancel button pressed.
		// "Online Player Offer Invite" event.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "l1000")
		{			
			group.active = true;
			
			Reg._buttonCodeValues = "";
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
					dataNotYetReadyForWaitingRoom(_number);
					return;
				}
				
				// if true then the player clicked room a or b to play against the computer.
				if (RegTypedef._dataMisc._vsComputer[_number] == 1)
				{
					if (_number == 1) Reg._gameId = 4;
					else Reg._gameId = 1;
					
					RegTypedef._dataMisc._room = _number;
					
					Reg._getRoomData = true;
					setNotActiveForButtons();		
					
					Reg._game_online_vs_cpu = true;
					RegTypedef._dataPlayers._spectatorPlaying = true;
			
					//------------------------
					// playing against the computer. this is the computer name and avatar.	
					Reg2._offline_cpu_host_name2 = RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room];
					
					for (i in 0...5)
					{
						if (Reg2._offline_cpu_host_names[i] 
						==  Reg2._offline_cpu_host_name2)
							RegCustom._profile_avatar_number2 = Reg2._offline_cpu_avatar_number[i];
												
					}
		
					//------------------------
			
					SceneCreateRoom.createRoomOnlineAgainstCPU();
					
					return;
				}
				
								
				else if (RegTypedef._dataMisc._roomState[_number] == 1)
				{
					roomFull(0, _number); // message about a user already creating room.			
				}
				
				else if (RegTypedef._dataMisc._roomState[_number] == 8
				&& RegTypedef._dataMisc._allowSpectators[_number] == 1 ) // Reg._gameId <= 1 && 
				{
					watchGame(_number);
				}
				
				// cannot enter room.
				else if (RegTypedef._dataMisc._roomPlayerCurrentTotal[_number] >= RegTypedef._dataMisc._roomPlayerLimit[_number] && RegTypedef._dataMisc._roomPlayerLimit[_number] > 0) 
				{
					roomFull(1, _number); // a message about room full.
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
			group.active = true;
			active = true;
			group.visible = true;
			visible = true;				
			
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
		
		// room full, or room creating message.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l1030")
		{
			group.active = true;
			active = true;
			group.visible = true;
			visible = true;				
			
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
		}
		
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "l2222")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			Reg._server_message = "";
		}
		
		// if at SceneMenu then set __boxScroller active to false so that a mouse click at SceneMenu cannot trigger a button click at __boxScroller.
		if (FlxG.mouse.y >= FlxG.height - 50
		&&	_ticks_buttons_menuBar >= 3)
		{
			group.active = false;
			__boxscroller.active = false;
		}
		
		else
		{
			group.active = true;
			__boxscroller.active = true;
		}
		
		super.update(elapsed);	
	}
	
	private function buttonClicked(_num):Void
	{
		#if html5
			if (_num < 3) gotoRoom(_num);
		#else			
			gotoRoom(_num);
		#end
	}
		
	/******************************
	 * house.
	 */
	public function house():Void
	{		
		// this stop the clicking of this button when not at this buttons scene.
		if (RegTypedef._dataMisc._room > 0) return; 
		
		RegTypedef.resetHouseData(); // this is needed to avoid a crash.	
		Reg._at_lobby = true;
		RegHouse._at_House = true;
		
		if (RegTriggers._houseFirstPartComplete == true)
		{
			//RegHouse.resetHouseAtLobby();	
			__house.options_part2();
			
			RegTriggers._houseFirstPartComplete = false;
		}

		ButtonToggleHouse._id_selected = 1;
		__house.active = true;			
		__house.visible = true;
		
		if (RegHouse._at_House == true)
		{
			__house.optionsMakeActive();
			
			__house.activeFurnitureGetElements();
			__house._houseDataLoaded = true;

			FlxG.mouse.reset();
			FlxG.mouse.enabled = true;
			Reg2._lobby_button_alpha = 0.3;
		}

		_t2.visible = false; // hide a lobby text that the house scrollbar would should.
		
		setNotActiveForButtons();
		__house.buttonToFurnitureGetMenu();
	}
	
	public function returnToLobbyFromHouse():Void
	{
		FlxG.mouse.enabled = true;
		
		_t2.visible = true;		
		
		if (__house.__house_foundation_put != null)
		{
			__house.__house_foundation_put.visible = false;
			__house.__house_foundation_put.active = false;
		}
		
		if (__house.__house_furniture_get != null)
		{
			__house.__house_furniture_get.__boxscroller.visible = false;
			__house.__house_furniture_get.__boxscroller.active = false;
			__house.__house_furniture_get.visible = false;
			__house.__house_furniture_get.active = false;		
		}
		
		if (__house.__house_scroll_map != null)
		{
			__house.__house_scroll_map.visible = false;
			__house.__house_scroll_map.active = false;
		}
		
		__house.activeFurniturePutElements();
		//HouseFurniturePut.textAndspriteRefreshPanel();
		
		if (__house.__house_furniture_put != null)
		{
			__house.__house_furniture_put.__boxscroller.visible = false;
			__house.__house_furniture_put.__boxscroller.active = false;
			__house.__house_furniture_put.visible = false;
			__house.__house_furniture_put.active = false;
		}
		
		__house.visible = false;
		__house.active = false;	
		
		if (RegTypedef._dataStatistics._chess_elo_rating > 0) setActiveForButtons();
		RegHouse._at_House = false;
		
		if (_tracker != null) remove(_tracker);
		_tracker = new FlxSprite(0, 0);
		_tracker.loadGraphic("assets/images/tracker.png", false);
		_tracker.scrollFactor.set(1, 1);
		_tracker.screenCenter(XY);
		add(_tracker);
		
		// the tracker is centered to the screen, so that the camera will focus on the scene as if the scene had never had an offset that may have been created by house map which is where an furniture item can be placed onto and where the mouse can scroll to see more of a map. so when scrolling happens, the offset is created at every scene because camera focuses on all scenes. this command is the fix.
		FlxG.camera.follow(_tracker, FlxCameraFollowStyle.LOCKON);
		
		// is this a new user account. we are here because all server events have been complete after the login and this is the last of the login setup.
		if (Reg2._checked_for_new_account == false
		&&  RegTypedef._dataStatistics._chess_elo_rating == 0
		||  Reg2._checked_for_new_account == false
		&&	RegTypedef._dataAccount._username.substr(0, 5) == "guest")
		{
			Reg2._checked_for_new_account = true;
			
			setNotActiveForButtons();
		
			if (__new_account != null)
			{
				__new_account.destroy();
				__new_account = null;
			}
						
			__new_account = new NewAccount();
			add(__new_account);
			
		}
			
	}
		
	private function leaderboards():Void
	{
		_leaderboards = new Leaderboards();		
		add(_leaderboards);
		
		setNotActiveForButtons();
		_button_leaderboards.active = false;
	}
	
	public function returnToLobbyFromLeaderboards():Void
	{
		_leaderboards.__boxscroller.visible = false;
		_leaderboards.__boxscroller.active = false;
		
		remove(_leaderboards.__boxscroller);
		_leaderboards.__boxscroller = null;		
		
		remove(_leaderboards);
		_leaderboards = null;
		
		setActiveForButtons();
	}
	
	/******************************
	 * go to the room where the player waits for another player to play a game. else go to create room, Reg._getRoomData
	 */
	private function gotoRoom(_num:Int):Void
	{		
		_number = _num;
		
		// these are used to send a request to "get room data". at that event, _lobby_data_received is set to true then at this class that var is read along with _lobby_data_received_do_once to execute rather the player can enter the creating room or the waiting room. The vars also help to refresh the lobby with current data.
		_lobby_data_received = false; 
		_lobby_data_received_do_once = true;
		
		// go to create room.
		Reg._getRoomData = true;		
	}
	
	/******************************
	 * game instructions, stats.
	 */
	private function miscMenu():Void
	{
		// this stop the clicking of this button when not at this buttons scene.
		if (RegTypedef._dataMisc._room > 0) return; 
		
		setNotActiveForButtons();
		
		// we call the stats here because when entering the stats _boxscroller that scene might not have got the stats data. sometimes we need to call an event twice, especially important data as this. 
		Reg2._miscMenuIparameter = 0;
		PlayState.clientSocket.send("Get Statistics All", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		if (__miscellaneous_menu != null)
		{
			__miscellaneous_menu.destroy();
			__miscellaneous_menu = null;
		}
		
		Reg.at_scene_menu = true;
		
		__miscellaneous_menu = new MiscellaneousMenu();
		add(__miscellaneous_menu);
		
		//TODO instead of destroying a scene, the scene must be removed. hence, opposite of add();
	}
	
	
	/******************************
	 * daily quests.
	 */
	private function dailyQuests():Void
	{
		setNotActiveForButtons();
		
		if (__daily_quests != null)
		{
			//TODO all destroy code everywhere must use .remove
			//__daily_quests = null;
			__daily_quests.destroy();
			remove(__daily_quests);
		}
		
		__daily_quests = new DailyQuests();
		add(__daily_quests);
		
		//TODO instead of destroying a scene, the scene must be removed. hence, opposite of add();
	}
	
	private function tournaments():Void
	{
		if (_tournaments != null)
		{
			_tournaments.destroy();
			remove(_tournaments);
		}
		
		_tournaments = new Tournaments();		
		add(_tournaments);
		
		PlayState.clientSocket.send("Tournament Chess Standard 8 Get", RegTypedef._dataTournaments);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		setNotActiveForButtons();
		_button_tournaments.active = false;
	}
		
	private function roomFull(message:Int, number_room_full:Int):Void
	{
		_message = message;
		_number_room_full = number_room_full;
		
		//group.visible = false;
		group.active = false;		

		Reg._messageId = 2000;
		Reg._buttonCodeValues = "l1010";
		SceneGameRoom.messageBoxMessageOrder();
	
	}
	
	private function dataNotYetReadyForWaitingRoom(_number:Int):Void
	{
		_number_room_full = _number;
		
		//group.visible = false;
		group.active = false;		

		Reg._messageId = 2010;
		Reg._buttonCodeValues = "l1030";
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	
	private function watchGame(_number:Int):Void
	{		
		setNotActiveForButtons();
		
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
	public function setNotActiveForButtons():Void
	{
		Reg._at_lobby = false;
		HouseScrollMap._map_offset_x = 0;
		HouseScrollMap._map_offset_y = 0;
		
		if (group != null)
		{
			// put this group off screen so that elements such as lobby buttons cannot be clicked.
			group.setPosition(5000, 0);
			group.active = false;
		}
		
		if (_group_button != null)
		{
			for (i in 0... _group_button.length)
			{
				_group_button[i].active = false;
			}
		}
		
		if (__boxscroller != null)
		{
			__boxscroller.visible = false;
			__boxscroller.active = false;
		}
		
		if (GameChatter.__boxscroller2 != null)
		{
			GameChatter.__boxscroller2.visible = false;
			GameChatter.__boxscroller2.active = false;
		}
		
		if (GameChatter.__boxscroller3 != null)
		{
			GameChatter.__boxscroller3.visible = false;
			GameChatter.__boxscroller3.active = false;
		}
		
		if (RegCustom._chat_turn_off_for_lobby == false)
		{
			__game_chatter.visible = false;
			__game_chatter.active = false;
		}
		
		if (RegCustom._config_house_feature_enabled == true)
		{
			if (_buttonHouse != null) _buttonHouse.active = false;
		}
		
		if (_buttonMiscMenu != null) _buttonMiscMenu.active = false;
		if (_button_daily_quests != null) _button_daily_quests.active = false;
		if (_button_leaderboards != null) _button_leaderboards.active = false;
		if (_button_tournaments != null) _button_tournaments.active = false;
		
		if (_button_lobby_refresh != null)
		{
			_button_lobby_refresh.visible = false;
			_button_lobby_refresh.active = false;
		}
		
		_title_background.visible = false;
		_title.visible = false;
		
		_t1.visible = false;
		_t2.visible = false;
		_t3.visible = false;
		_t4.visible = false;
		_t5.visible = false;
		_t6.visible = false;
	}
	
	/******************************
	 * this function is called when returning from MiscellaneousMenu.hx or house.hx class.
	 */
	public function setActiveForButtons():Void
	{
		Reg._at_lobby = true;
		HouseScrollMap._map_offset_x = 0;
		HouseScrollMap._map_offset_y = 0;
		
		if (group != null)
		{
			group.active = true;
			group.setPosition(0, 0);
		}
		
		if (_group_button != null)
		{
			for (i in 0... _group_button.length)
			{
				#if html5
					if (i < 2)
					{
						_group_button[i].active = true;
						_group_button[i].label.color = 0xFF00FF00;
					}
				#else
					_group_button[i].active = true;
					//_group_button[i].label.color = 0xFF00FF00;
				#end
			}
		}
		
		if (__boxscroller != null) 
		{
			__boxscroller.active = true;
			__boxscroller.visible = true;
			
		}
		
		if (GameChatter.__boxscroller2 != null
		&& GameChatter._groupChatterScroller.x == 0)
		{
			GameChatter.__boxscroller2.active = true;
			GameChatter.__boxscroller2.visible = true;
		}
		
		if (GameChatter.__boxscroller3 != null
		&& GameChatter._groupChatterScroller.x == 0)
		{
			GameChatter.__boxscroller3.active = true;
		}
		
		if (RegCustom._chat_turn_off_for_lobby == false)
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
		
		_t1.visible = true;
		_t2.visible = true;
		_t3.visible = true;
		_t4.visible = true;
		_t5.visible = true;
		_t6.visible = true;
	}
	
	// this shows the menuBar buttons after a brief second.
	private function ticks_buttons_menuBar():Void
	{
		if (RegCustom._config_house_feature_enabled == true)
		{
			if (_buttonHouse != null) 
			{
				_buttonHouse.active = true;
				_buttonHouse.visible = true;
			}
		}
		
		if (_buttonMiscMenu != null) _buttonMiscMenu.active = true;
		if (_button_daily_quests != null) _button_daily_quests.active = true;
		if (_button_leaderboards != null) _button_leaderboards.active = true;
		if (_button_tournaments != null) _button_tournaments.active = true;
		
		if (_buttonMiscMenu != null) _buttonMiscMenu.visible = true;
		if (_button_daily_quests != null) _button_daily_quests.visible = true;
		if (_button_leaderboards != null) _button_leaderboards.visible = true;
		if (_button_tournaments != null) _button_tournaments.visible = true;
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
}
