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

/**
 * Currently the menu bar only has the disconnect button. most class new this class so to get the disconnect button on their scenes.
 * @author kboardgames.com
 */
class MenuBar extends FlxGroup
{
	/******************************
	 * menuBar background.
	 */
	public var _background:FlxSprite;
	
	/******************************
	 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
	 */
	private var _tracker:FlxSprite;
	
	public var __house:House;
	public var __miscellaneous_menu:MiscellaneousMenu;
	public var __daily_quests:DailyQuests;
	public var __tournaments:Tournaments;
	public var __leaderboards:Leaderboards;
	public var __scene_create_room:SceneCreateRoom;
	public var __new_account:NewAccount;
	public var __scene_waiting_room:SceneWaitingRoom;
	
	// this button is not visible. it is placed under the house button and is used by other buttons, in case the house feature is disabled, so they can still be horizontally positioned on the menu bar.
	private	var _buttonHouse_under:ButtonGeneralNetworkYes;
	public var _buttonMiscMenu:ButtonGeneralNetworkYes;
	public var _buttonHouse:ButtonGeneralNetworkYes;
	public var _button_daily_quests:ButtonGeneralNetworkYes;
	public var _button_tournaments:ButtonGeneralNetworkYes;	
	public var _button_leaderboards:ButtonGeneralNetworkYes;
	
	
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offset_x:Int = 50;
	
	//####################### house
	/******************************
	 * hides the grid that would be shown underneath the lobby and disconnect buttons and also displays another horizontal bar at the top of the scene.
	 */
	private	var _bgHorizontal:FlxSprite;	
	private var _to_lobby:ButtonGeneralNetworkYes;
	
		/******************************
	 * HouseFurnitureItemsFront instance.
	*/
	private var _items:HouseFurnitureItemsFront;
	
	public var _buttonToFoundationPutMenu:ButtonToggleHouse;
	public var _buttonToFurnitureGetMenu:ButtonToggleHouse;
	public var _buttonToFurniturePutMenu:ButtonToggleHouse;
	
	private var _save:ButtonGeneralNetworkYes;
	
	
	//####################end house
	//##################create room	
	public var _buttonCreateRoom:ButtonGeneralNetworkYes;
	
	/******************************
	 * button that returns user to the lobby.
	 */
	public var _buttonReturnToLobby:ButtonGeneralNetworkYes;
	//##############end create room
	
	//#################waiting room
	/******************************
	 * start playing the multi games after this button is pressed.
	 */
	public var _buttonGameRoom:ButtonGeneralNetworkYes;
	
	/******************************
	 * button that returns user to the lobby.
	 */
	public var _button_return_to_lobby_from_waiting_room:ButtonGeneralNetworkYes;
		
	public var _button_refresh_list:ButtonGeneralNetworkYes; // refresh online players list.
	
	//#############end waiting room
	
	//###################misc scene
	public var _misc_menu_exit:ButtonGeneralNetworkYes;
	//###############end misc scene
	
	//#################daily quests
	private var _scene_daily_quests_exit:ButtonGeneralNetworkYes;
	private var _button_claim_reward:ButtonGeneralNetworkYes;
	
	/******************************
	 * daily quests rewards.
	 */
	public var _rewards:Array<String> = ["0", "0", "0"];
	//#############end daily quests
	
	//##################tournaments
	
	/******************************
	 * return to lobby.
	 */
	public var _scene_tournaments_exit:ButtonGeneralNetworkYes;
	//##############end tournaments
	
	//#################leaderboards
	public var _scene_leaderboards_exit:ButtonGeneralNetworkYes;
	//#############end leaderboards
	
	/******************************
	 * 
	 * @param	_from_menuState		true if somewhere at the menu state. The player has not connected yet and might be at the help scene or credits scene. this is needed because if at playState then the disconnect button will trigger a close but if not connected then this is used to return to menu state.
	 * @param	_at_chatter			is player at the chatter. This is used to create a small red bar underneath the chatter background. this is needed because at waiting room this red bar will not go in front of the chatter background, so another new to this class is needed at chatter.
	 */
	override public function new(_from_menuState:Bool = false, _at_chatter:Bool = false, house:House = null, items:HouseFurnitureItemsFront = null, scene_create_room:SceneCreateRoom = null, scene_waiting_room:SceneWaitingRoom = null):Void
	{
		super();
		
		if (scene_create_room != null)
			__scene_create_room = scene_create_room;
		
		if (scene_waiting_room != null)
			__scene_waiting_room = scene_waiting_room;
			
		if (house != null)
		{
			__house = house;
			_items = items;
		}
		
		var _color = RegCustomColors.menu_bar_background_color();
		
		if (_at_chatter == false) 
		{
			_background = new FlxSprite(0, FlxG.height - 50);
			_background.makeGraphic(FlxG.width, 50, _color);
			
		}
		else 
		{
			_background = new FlxSprite(FlxG.width-373, FlxG.height - 50);
			_background.makeGraphic(FlxG.width-373, 50, _color);
		}
		
		_background.alpha = 1;
		_background.scrollFactor.set(0, 0);	
		add(_background);
			
		// width is 35 + 15 extra pixels for the space between the button at the edge of screen.
		var _button_disconnect = new ButtonGeneralNetworkYes(FlxG.width - 60, FlxG.height - 40, "X", 45, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, disconnect.bind(_from_menuState), 0xFFCC0000, false, 9999);
		_button_disconnect.scrollFactor.set(0, 0);
		_button_disconnect.label.font = Reg._fontDefault;
		add(_button_disconnect);
		
		set_all_menu_bar_elements_not_active();
		
		// lobby menu bar.
		if (Reg._at_lobby == true)
			menu_lobby();
		
		if (Reg._at_house == true)
			menu_house();
		
		if (Reg._hasUserConnectedToServer == false || Reg._at_create_room == true)
			menu_create_room();
			
		if (Reg._hasUserConnectedToServer == false || Reg._at_waiting_room == true)
			menu_waiting_room();
		
		if (Reg._at_misc == true) menu_misc();
		if (Reg._at_daily_quests == true) menu_daily_quests();
		if (Reg._at_tournaments == true) menu_tournaments();
		if (Reg._at_leaderboards == true) menu_leaderboards();
	}
	
	public function initialize():Void
	{
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
		{
			RegHouse.resetHouseAtLobby();
		}
		
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
		{
			RegTypedef.resetHouseData(); // this is needed to avoid a crash.	
			RegHouse.resetHouseAtLobby();
			
			PlayState.clientSocket.send("House Load", RegTypedef._dataHouse);
			haxe.Timer.delay(function (){}, Reg2._event_sleep); 
		} else RegTriggers._returnToLobbyMakeButtonsActive = true;
	}
	
	private function menu_lobby():Void
	{
		// this button is not visible. it is placed under the house button and is used by other buttons, in case the house feature is disabled, so they can still be horizontally positioned on the menu bar.
		if (_buttonHouse_under == null)
		{
			_buttonHouse_under = new ButtonGeneralNetworkYes(100 - _offset_x, FlxG.height - 40, "", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn], false, 101);		
			_buttonHouse_under.label.font = Reg._fontDefault;
			_buttonHouse_under.visible = false;
			_buttonHouse_under.active = false;
			_buttonHouse_under.scrollFactor.set(0, 0);
			add(_buttonHouse_under);
		}
		
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
		{
			if (_buttonHouse == null)
			{
				_buttonHouse = new ButtonGeneralNetworkYes(100 - _offset_x, FlxG.height - 40, "House", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_house, RegCustom._button_color[Reg._tn], false, 102);		
				_buttonHouse.label.font = Reg._fontDefault;
				_buttonHouse.visible = false;
				_buttonHouse.active = false;
				_buttonHouse.scrollFactor.set(0, 0);
				add(_buttonHouse);
			}
		}
		
		// game instructions, stats.
		if (_buttonMiscMenu == null)
		{
			_buttonMiscMenu = new ButtonGeneralNetworkYes(_buttonHouse_under.x + 230, FlxG.height - 40, "Misc Menu", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_lobby_miscMenu, RegCustom._button_color[Reg._tn], false, 103);		
			_buttonMiscMenu.label.font = Reg._fontDefault;
			_buttonMiscMenu.visible = false;
			_buttonMiscMenu.active = false;
			_buttonMiscMenu.scrollFactor.set(0, 0);
			add(_buttonMiscMenu);
		}
		
		// daily quests
		if (_button_daily_quests == null)
		{
			_button_daily_quests = new ButtonGeneralNetworkYes(_buttonMiscMenu.x + 230, FlxG.height - 40, "Daily Quests", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_lobby_daily_quests, RegCustom._button_color[Reg._tn], false, 104);		
			_button_daily_quests.label.font = Reg._fontDefault;
			_button_daily_quests.scrollFactor.set(0, 0);
			_button_daily_quests.visible = false;
			_button_daily_quests.active = false;
			add(_button_daily_quests);
		}
		
		// tournaments
		if (_button_tournaments == null)
		{
			_button_tournaments = new ButtonGeneralNetworkYes(_button_daily_quests.x + 230, FlxG.height - 40, "Tournaments", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_lobby_tournaments, RegCustom._button_color[Reg._tn], false, 105);		
			_button_tournaments.label.font = Reg._fontDefault;
			_button_tournaments.scrollFactor.set(0, 0);
			_button_tournaments.visible = false;
			_button_tournaments.active = false;
			add(_button_tournaments);
		}
		
		// leaderboards.
		if (RegCustom._leaderboard_enabled[Reg._tn] == true)
		{
			if (_button_leaderboards == null)
			{
				_button_leaderboards = new ButtonGeneralNetworkYes(_button_tournaments.x + 230, FlxG.height - 40, "Leaderboards", 215, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_lobby_leaderboards, RegCustom._button_color[Reg._tn], false, 106);		
				_button_leaderboards.label.font = Reg._fontDefault;
				_button_leaderboards.scrollFactor.set(0, 0);
				_button_leaderboards.visible = false;
				_button_leaderboards.active = false;
				add(_button_leaderboards);
			}
		}
		
	}
	
	private function menu_house():Void
	{
		if (__house != null)
		{
			if (_to_lobby == null)
			{
				_to_lobby = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_house_return_to_lobby, RegCustom._button_color[Reg._tn], false, 3000);		
				_to_lobby.label.font = Reg._fontDefault;
				_to_lobby.screenCenter(X);
				_to_lobby.x += 200;
				add(_to_lobby);
			}
			
			if (_buttonToFurnitureGetMenu == null)
			{
				_buttonToFurnitureGetMenu = new ButtonToggleHouse(_to_lobby.x - 800, FlxG.height - 40, 1, "Item Get", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, __house.buttonToFurnitureGetMenu, 0xFF001100);
				_buttonToFurnitureGetMenu.label.font = Reg._fontDefault;
				add(_buttonToFurnitureGetMenu);
			}
			
			if (_buttonToFurniturePutMenu == null)
			{
				_buttonToFurniturePutMenu = new ButtonToggleHouse(_to_lobby.x - 600, FlxG.height - 40, 2, "Item Put", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, __house.buttonToFurniturePutMenu, 0xFF001100);
				_buttonToFurniturePutMenu.label.font = Reg._fontDefault;
				add(_buttonToFurniturePutMenu);
			}
			
			if (_buttonToFoundationPutMenu == null)
			{
				_buttonToFoundationPutMenu = new ButtonToggleHouse(_to_lobby.x - 400, FlxG.height - 40, 3, "Build", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, __house.buttonToFoundationPutMenu, 0xFF001100);
				_buttonToFoundationPutMenu.label.font = Reg._fontDefault;
				add(_buttonToFoundationPutMenu);
			}
			
			if (_save == null)
			{
				_save = new ButtonGeneralNetworkYes(_to_lobby.x + 200, FlxG.height - 40, "Save", 175, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_house_save, RegCustom._button_color[Reg._tn], false, 3001);
				_save.label.font = Reg._fontDefault;
				
				#if html5
					_save.alpha = 0.25;
				#end
				
				add(_save);
			}
		}
		
	}

	/******************************
	 * menu bar buttons that SceneCreateRoom uses.
	 */
	private function menu_create_room():Void
	{
		if (_buttonCreateRoom == null)
		{
			_buttonCreateRoom = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "Enter Room", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_create_room_goto_waiting_room, RegCustom._button_color[Reg._tn], false, 107);		
			_buttonCreateRoom.label.font = Reg._fontDefault;
			if (Reg._at_create_room == false)
			{
				_buttonCreateRoom.visible = false;
				_buttonCreateRoom.active = false;
			}
			_buttonCreateRoom.screenCenter(X);
			add(_buttonCreateRoom);
		}
		
		if (_buttonReturnToLobby == null)
		{
			_buttonReturnToLobby = new ButtonGeneralNetworkYes(_buttonCreateRoom.x - 200, FlxG.height - 40, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_create_room_return_to_lobby, RegCustom._button_color[Reg._tn], false, 108);
			_buttonReturnToLobby.label.font = Reg._fontDefault;
			if (Reg._at_create_room == false)
			{
				_buttonReturnToLobby.visible = false;
				_buttonReturnToLobby.active = false;
			}
			add(_buttonReturnToLobby);
		}
	}
	
	/******************************
	 * menu bar buttons for waiting room
	 */
	private function menu_waiting_room():Void
	{
		var _offset:Int = 20;
		
		_button_return_to_lobby_from_waiting_room = new ButtonGeneralNetworkYes(40 + _offset, FlxG.height-40, "To Lobby", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_return_to_lobby, RegCustom._button_color[Reg._tn], false, 109);
		_button_return_to_lobby_from_waiting_room.label.font = Reg._fontDefault;
		_button_return_to_lobby_from_waiting_room.visible = false;
		_button_return_to_lobby_from_waiting_room.active = false;
		add(_button_return_to_lobby_from_waiting_room);
				
		_button_refresh_list = new ButtonGeneralNetworkYes(260 + _offset, FlxG.height-40, "Update List", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_refresh_online_list, RegCustom._button_color[Reg._tn], false, 110);		
		_button_refresh_list.label.font = Reg._fontDefault;
		_button_refresh_list.scrollFactor.set(0, 0);
		_button_refresh_list.visible = false;
		_button_refresh_list.active = false;
		add(_button_refresh_list);				
		
		_buttonGameRoom = new ButtonGeneralNetworkYes(700 + _offset, FlxG.height-40, "Game Room", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_goto_game_room, RegCustom._button_color[Reg._tn], false, 111);
		_buttonGameRoom.label.font = Reg._fontDefault;
		_buttonGameRoom.visible = false;
		_buttonGameRoom.active = false;
		add(_buttonGameRoom);		
	}
	
	/******************************
	 * menu bar buttons for misc scene
	 */
	private function menu_misc():Void
	{
		_misc_menu_exit = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_misc_exit, RegCustom._button_color[Reg._tn], true, 112);
		_misc_menu_exit.label.font = Reg._fontDefault;
		_misc_menu_exit.screenCenter(X);
		_misc_menu_exit.x += 400;
		add(_misc_menu_exit);
	}
	
	/******************************
	 * menu bar buttons for daily quests scene
	 */
	private function menu_daily_quests():Void
	{
		_scene_daily_quests_exit = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_daily_quests_exit, RegCustom._button_color[Reg._tn], true, 113);
		_scene_daily_quests_exit.label.font = Reg._fontDefault;
		_scene_daily_quests_exit.screenCenter(X);
		_scene_daily_quests_exit.x += 400;
		_scene_daily_quests_exit.alpha = 1;
		add(_scene_daily_quests_exit);
		
		_rewards.splice(3, 0);
		_rewards = RegTypedef._dataDailyQuests._rewards.split(",");
		
		var _stop:Bool = false; // used to break out of the following loop if that condition is true.
		
		for (i in 0...3)
		{
			if (_rewards[i] == "1")
			{
				_button_claim_reward = new ButtonGeneralNetworkYes(_scene_daily_quests_exit.x-200, FlxG.height - 40, "Claim", 185, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_daily_quests_claim_reward, RegCustom._button_color[Reg._tn], false, 114);
				_button_claim_reward.label.font = Reg._fontDefault;
				add(_button_claim_reward);
				
				_stop = true;
				break;
			}
			
			if (_stop == true) break;
		}
		
	}
	
	/******************************
	 * menu bar buttons for touny scene
	 */
	private function menu_tournaments():Void
	{
		_scene_tournaments_exit = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_tournaments_exit, RegCustom._button_color[Reg._tn], true, 115);
		_scene_tournaments_exit.label.font = Reg._fontDefault;
		_scene_tournaments_exit.screenCenter(X);
		_scene_tournaments_exit.x += 400;
		add(_scene_tournaments_exit);
	}
	
	/******************************
	 * menu bar buttons for leaderboards scene
	 */
	private function menu_leaderboards():Void
	{
		_scene_leaderboards_exit = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_leaderboard_return_to_lobby , RegCustom._button_color[Reg._tn], true, 116);		
		_scene_leaderboards_exit.label.font = Reg._fontDefault;
		_scene_leaderboards_exit.screenCenter(X);
		_scene_leaderboards_exit.x += 400;
		add(_scene_leaderboards_exit);
	}
	
	/******************************
	 * "X" button on this menu bar.
	 */
	private function disconnect(_from_menuState:Bool = false):Void
	{
		Reg2._miscMenuIparameter = 0;
		
		if (GameChatter.__scrollable_area2 != null)	GameChatter.__scrollable_area2 = null;
		if (GameChatter.__scrollable_area3 != null)	GameChatter.__scrollable_area3 = null;
		if (GameChatter.__scrollable_area4 != null)	GameChatter.__scrollable_area4 = null;
		
		if (_from_menuState == false) PlayState.prepareToDisconnect(); //Reg._disconnectNow = true;
		else FlxG.switchState(new MenuState());
	}
	
	private function set_all_menu_bar_elements_not_active():Void
	{
		if (_buttonHouse_under != null)
		{
			_buttonHouse_under.visible = false;
			_buttonHouse_under.active = false;
		}
		
		if (_buttonHouse != null)
		{
			_buttonHouse.visible = false;
			_buttonHouse.active = false;
		}
		
		if (_buttonMiscMenu != null)
		{
			_buttonMiscMenu.visible = false;
			_buttonMiscMenu.active = false;
		}
			
		if (__daily_quests != null)
		{
			if (__daily_quests.__scrollable_area != null)
			{
				__daily_quests.__scrollable_area.visible = false;
				__daily_quests.__scrollable_area.active = false;
			}	
		}
		
		if (_button_daily_quests != null)
		{
			_button_daily_quests.visible = false;
			_button_daily_quests.active = false;
		}
		
		if (_button_tournaments != null)
		{
			_button_tournaments.visible = false;
			_button_tournaments.active = false;
		}

		if (__leaderboards != null)
		{
			if (__leaderboards.__scrollable_area != null)
			{
				__leaderboards.__scrollable_area.visible = false;
				__leaderboards.__scrollable_area.active = false;
				
			}
		}
		
		if (_button_leaderboards != null)
		{
			_button_leaderboards.visible = false;
			_button_leaderboards.active = false;
		}
		
		if (_to_lobby != null)
		{
			_to_lobby.visible = false;
			_to_lobby.active = false;
		}
		
		if (_buttonToFurnitureGetMenu != null)
		{
			_buttonToFurnitureGetMenu.visible = false;
			_buttonToFurnitureGetMenu.active = false;
		}
		
		if (_buttonToFurniturePutMenu != null)
		{
			_buttonToFurniturePutMenu.visible = false;
			_buttonToFurniturePutMenu.active = false;
		}
		
		if (_buttonToFoundationPutMenu != null)
		{
			_buttonToFoundationPutMenu.visible = false;
			_buttonToFoundationPutMenu.active = false;
		}
		
		if (_save != null)
		{
			_save.visible = false;
			_save.active = false;
		}
		
		if (_buttonCreateRoom != null)
		{
			_buttonCreateRoom.visible = false;
			_buttonCreateRoom.active = false;
		}
		
		if (_buttonReturnToLobby != null)
		{
			_buttonReturnToLobby.visible = false;
			_buttonReturnToLobby.active = false;
		}
		
		if (_button_return_to_lobby_from_waiting_room != null)
		{
			_button_return_to_lobby_from_waiting_room.visible = false;
			_button_return_to_lobby_from_waiting_room.active = false;
		}
		
		if (_button_refresh_list != null)
		{
			_button_refresh_list.visible = false;
			_button_refresh_list.active = false;
		}
		
		if (_buttonGameRoom != null)
		{
			_buttonGameRoom.visible = false;
			_buttonGameRoom.active = false;
		}
		
		if (_misc_menu_exit != null)
		{
			_misc_menu_exit.visible = false;
			_misc_menu_exit.active = false;
		}
		
		if (_scene_daily_quests_exit != null)
		{
			_scene_daily_quests_exit.visible = false;
			_scene_daily_quests_exit.active = false;
		}
		
		if (_button_claim_reward != null)
		{
			_button_claim_reward.visible = false;
			_button_claim_reward.active = false;
		}
		
		if (_scene_tournaments_exit != null)
		{
			_scene_tournaments_exit.visible = false;
			_scene_tournaments_exit.active = false;
		}
		
		if (_scene_leaderboards_exit != null)
		{
			_scene_leaderboards_exit.visible = false;
			_scene_leaderboards_exit.active = false;
		}
	}
	
	/******************************
	 * function that house uses.
	 */
	public function scene_house():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
				
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		// this stop the clicking of this button when not at this buttons scene.
		if (RegTypedef._dataMisc._room > 0) return; 
		
		RegTypedef.resetHouseData(); // this is needed to avoid a crash.	
		//Reg._at_lobby = true;
		Reg._at_house = true;
		
		if (RegTriggers._houseFirstPartComplete == true)
		{
			__house.initialize2();
			
			RegTriggers._houseFirstPartComplete = false;
		}

		ButtonToggleHouse._id_selected = 1;
		__house.active = true;			
		__house.visible = true;
		__house.optionsMakeActive();
		__house.activeFurnitureGetElements();
		__house._houseDataLoaded = true;

		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		Reg2._lobby_button_alpha = 0.3;
		//}
		
		PlayState.__scene_lobby.set_not_active_for_buttons();
		__house.buttonToFurnitureGetMenu();
	}
	
	/*****************************
	 * function that house uses.
	 */
	public function scene_house_return_to_lobby():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		if (__house.__house_foundation_put != null)
		{
			__house.__house_foundation_put.visible = false;
			__house.__house_foundation_put.active = false;
		}
		
		if (__house.__house_furniture_get != null)
		{
			__house.__house_furniture_get.__scrollable_area.visible = false;
			__house.__house_furniture_get.__scrollable_area.active = false;
			__house.__house_furniture_get.visible = false;
			__house.__house_furniture_get.active = false;		
		}
		
		if (__house.__house_scroll_map != null)
		{
			__house.__house_scroll_map.visible = false;
			__house.__house_scroll_map.active = false;
		}
		
		__house.activeFurniturePutElements();
		
		if (__house.__house_furniture_put != null)
		{
			__house.__house_furniture_put.__scrollable_area.visible = false;
			__house.__house_furniture_put.__scrollable_area.active = false;
			__house.__house_furniture_put.visible = false;
			__house.__house_furniture_put.active = false;
		}
		
		__house.visible = false;
		__house.active = false;	
		
		if (RegTypedef._dataStatistics._chess_elo_rating > 0) PlayState.__scene_lobby.set_active_for_buttons();
		Reg._at_house = false;
		
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
			
			PlayState.__scene_lobby.set_not_active_for_buttons();
			
			if (__new_account != null)
			{
				__new_account.destroy();
				__new_account = null;
			}
						
			__new_account = new NewAccount();
			add(__new_account);
			
		}
			
	}
	
	/******************************
	 * function that house uses.
	 */
	private function scene_house_save():Void
	{
		Reg._messageId = 7001;
		Reg._buttonCodeValues = "h1000";
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	
	/******************************
	 * shared menu buttons from all states that use a menu bar.
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		// save house.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "h1000")
		{
			Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
			Reg._yesNoKeyPressValueAtMessage = 0; // no button is clicked.
			
			//---------------------------
			Reg._messageId = 7002;
			Reg._buttonCodeValues = "h1010";
			SceneGameRoom.messageBoxMessageOrder();
			
			//---------------------------
			
			// clear these array because they will be populated with new data below these code.
			RegTypedef._dataHouse._sprite_number = "";
			RegTypedef._dataHouse._sprite_name = "";
			RegTypedef._dataHouse._items_x = "";
			RegTypedef._dataHouse._items_y = "";			
			RegTypedef._dataHouse._map_x = "";
			RegTypedef._dataHouse._map_y = "";			
			RegTypedef._dataHouse._is_item_purchased = "";
			RegTypedef._dataHouse._item_direction_facing = "";
			RegTypedef._dataHouse._map_offset_x = "";
			RegTypedef._dataHouse._map_offset_y = "";			
			RegTypedef._dataHouse._item_is_hidden = "";
			RegTypedef._dataHouse._item_order = "";
			RegTypedef._dataHouse._item_behind_walls = "";
			RegTypedef._dataHouse._floor = "";
			RegTypedef._dataHouse._wall_left = "";
			RegTypedef._dataHouse._wall_left_is_hidden = "";
			RegTypedef._dataHouse._wall_up_behind = "";
			RegTypedef._dataHouse._wall_up_behind_is_hidden = "";
			RegTypedef._dataHouse._wall_up_in_front = "";
			RegTypedef._dataHouse._wall_up_in_front_is_hidden = "";
			
			for (i in 0...RegHouse._totalPurchased + 1)
			{
				RegTypedef._dataHouse._sprite_number += RegHouse._sprite_number[i] + ",";
				// this is needed to remove the "No item selected" text because if only one item is bought then only one element will be saved in these array. if this is not removed then two elements in this example will never be saved.
				RegHouse._namesPurchased.remove("No item selected.");
				
				RegTypedef._dataHouse._sprite_name += RegHouse._namesPurchased[i] + ",";
				
				RegTypedef._dataHouse._items_x += RegHouse._items_x[i] + ",";
				RegTypedef._dataHouse._items_y += RegHouse._items_y[i] + ",";
				
				RegTypedef._dataHouse._map_x += RegHouse._map_x[i] + ",";
				RegTypedef._dataHouse._map_y += RegHouse._map_y[i] + ",";
				
				RegTypedef._dataHouse._is_item_purchased += RegHouse._is_item_purchased[i] + ",";
				RegTypedef._dataHouse._item_direction_facing += RegHouse._item_direction_facing[i] + ",";
				RegTypedef._dataHouse._map_offset_x += RegHouse._map_offset_x[i] + ",";
				RegTypedef._dataHouse._map_offset_y += RegHouse._map_offset_y[i] + ",";
				
				RegTypedef._dataHouse._item_is_hidden += RegHouse._item_is_hidden[i] + ",";
				RegTypedef._dataHouse._item_order += RegHouse._item_order[i] + ",";
				RegTypedef._dataHouse._item_behind_walls += RegHouse._item_behind_walls[i] + ",";				
				
			}			
			
			
			for (x in 0...11)
			{
				for (y in 0...22)
				{
					RegTypedef._dataHouse._floor += RegHouse._floor[x][y] + ",";
					RegTypedef._dataHouse._wall_left += RegHouse._wall_left[x][y]+ ",";
					RegTypedef._dataHouse._wall_left_is_hidden += RegHouse._wall_left_is_hidden[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_behind += RegHouse._wall_up_behind[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_behind_is_hidden += RegHouse._wall_up_is_hidden[1][x][y]+ ",";
					RegTypedef._dataHouse._wall_up_in_front += RegHouse._wall_up_in_front[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_in_front_is_hidden += RegHouse._wall_up_is_hidden[0][x][y]+ ",";
				}
			}
			
			RegHouse._namesPurchased.unshift("No item selected.");
			PlayState.clientSocket.send("House Save", RegTypedef._dataHouse);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			PlayState.clientSocket.send("Daily Reward Save", RegTypedef._dataStatistics);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}
		
		if (Reg._yesNoKeyPressValueAtMessage > 1 && Reg._buttonCodeValues == "h1000")
		{
			Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
			Reg._yesNoKeyPressValueAtMessage = 0; // no button is clicked.
			
		}
		
		// message box saying that the house was saved.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "h1010")
		{
			Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
			Reg._yesNoKeyPressValueAtMessage = 0; // no button is clicked.
		}
	}
	
	/******************************
	 * lobby menu button
	 */
	private function scene_lobby_leaderboards():Void
	{
		// this stops a double fire of a button click. for example, if clicked the leaderboard button then exited that scene to return to lobby, when clicking any other button at the menu bar, when exiting that scene and the leaderboard button's alpha was when set to 1, the user will enter the leaderboard scene to see two scenes in one. the reason is the exit button of one scene shares the same space as this leaderboard button.
		if (Reg._at_house == true 
		||	Reg._at_misc == true
		||	Reg._at_daily_quests == true
		||	Reg._at_tournaments == true
		||	Reg._at_create_room == true
		||	Reg._at_waiting_room == true) return;
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		Reg._at_leaderboards = true;
		PlayState.__scene_lobby.set_not_active_for_buttons();
		
		__leaderboards = new Leaderboards();		
		add(__leaderboards);
		
		_button_leaderboards.active = false;
	}
		
	/******************************
	 * lobby menu button
	 * game instructions, stats.
	 */
	private function scene_lobby_miscMenu():Void
	{
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		// this stop the clicking of this button when not at this buttons scene.
		if (RegTypedef._dataMisc._room > 0) return; 
		
		PlayState.__scene_lobby.set_not_active_for_buttons();
		
		// we call the stats here because when entering the stats _scrollable area that scene might not have got the stats data. sometimes we need to call an event twice, especially important data as this. 
		Reg2._miscMenuIparameter = 0;
		PlayState.clientSocket.send("Get Statistics All", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		if (__miscellaneous_menu != null)
		{
			__miscellaneous_menu.visible = false;
			__miscellaneous_menu.destroy();
			__miscellaneous_menu = null;
		}
		
		Reg._at_misc = true;
		
		__miscellaneous_menu = new MiscellaneousMenu();
		add(__miscellaneous_menu);
	}
	
	
	/******************************
	 * lobby menu button
	 * daily quests.
	 */
	private function scene_lobby_daily_quests():Void
	{
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		PlayState.__scene_lobby.set_not_active_for_buttons();
		
		if (__daily_quests != null)
		{
			//TODO all destroy code everywhere must use .remove
			__daily_quests.destroy();
			remove(__daily_quests);
		}
		
		Reg._at_daily_quests = true;
		
		__daily_quests = new DailyQuests();
		add(__daily_quests);
		
		//TODO instead of destroying a scene, the scene must be removed. hence, opposite of add();
	}
	
	/******************************
	 * lobby menu button
	 */
	private function scene_lobby_tournaments():Void
	{
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		if (__tournaments != null)
		{
			__tournaments.destroy();
			remove(__tournaments);
		}
		
		Reg._at_tournaments = true;
		
		__tournaments = new Tournaments();		
		add(__tournaments);
		
		PlayState.clientSocket.send("Tournament Chess Standard 8 Get", RegTypedef._dataTournaments);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		PlayState.__scene_lobby.set_not_active_for_buttons();
		_button_tournaments.active = false;
	}

	/******************************
	 * SceneCreateRoom menu buttons.
	 * go to GameWaitingRoom class
	 */
	public function scene_create_room_goto_waiting_room():Void
	{
		// if image selected. id == 1
		if (SceneCreateRoom._buttonHumanOrComputerGame.label.text == "Computer"
		) 
		{
			Reg._game_online_vs_cpu = true;
			SceneCreateRoom.createRoomOnlineAgainstCPU();
			
			visible = false;
			active = false;
		}
		
		// entering the waiting room.
		else if (Reg._at_waiting_room == false)
		{
			// this line is needed.
			if (Reg._roomPlayerLimit == 0) Reg._roomPlayerLimit = 2;
			
			Reg._currentRoomState = 2;
			
			// is this a game where host can change the amount of players for a game?
			if (Reg._gameId == 4) Reg._roomPlayerLimit = Std.parseInt(SceneCreateRoom._textMaximumPlayersForGame.text);
			
			RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] = Reg._roomPlayerLimit;
			
			RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] = Reg._gameId;
			
			// never get a value of -1 or there will be a server error when saving stats.
			if (RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room] > -1)
				RegTypedef._dataPlayers._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
			
			RegTypedef._dataMisc._userLocation = 2;
			RegTypedef._dataMisc._roomHostUsername[RegTypedef._dataMisc._room] = RegTypedef._dataMisc._username;
			RegTypedef._dataMisc._gid[RegTypedef._dataMisc._room] = RegTypedef._dataMisc.id;
			RegTypedef._dataPlayers._usernamesDynamic[0] = RegTypedef._dataMisc._username;
			RegTypedef._dataPlayers._usernamesStatic[0] = RegTypedef._dataMisc._username;
			Reg._gameHost = true;
			
			Reg._at_create_room = false;
			Reg._at_waiting_room = true;
			Reg._game_online_vs_cpu = false;
			
			RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 0;	
			RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 1;
			
					
			// when returning to the lobby from this room, since this value it was never saved to the database, it will be set back to 0 when the "set room data" event is called. 
			if (SceneCreateRoom._buttonAllowSpectatorsGame.label.text == "Yes")
				RegTypedef._dataMisc._allowSpectators[RegTypedef._dataMisc._room] = 1;
			else
				RegTypedef._dataMisc._allowSpectators[RegTypedef._dataMisc._room] = 0;
			
			PlayState.clientSocket.send("Is Room Locked", RegTypedef._dataMisc);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}
		

	}
	
	/******************************
	 * SceneCreateRoom menu buttons.
	 */	
	private function scene_create_room_return_to_lobby():Void
	{		
		//ActionInput.enable();
		
		RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 0;
					 
		PlayState.clientSocket.send("Lesser RoomState Value", RegTypedef._dataMisc);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
		
		Reg._at_create_room = false;
		Reg._at_waiting_room = false;
				
		visible = false;		
		Reg._currentRoomState = 0;
		
		// display the lobby.
		Reg._loginSuccessfulWasRead = true;
		Reg._doOnce = true;
		
		RegTriggers._lobby = true;
	}
	
	private function scene_waiting_room_return_to_lobby():Void
	{			
		Reg._buttonCodeValues = "r1004";
		
		if (RegCustom._to_lobby_from_waiting_room_confirmation[Reg._tn] == false)
		{
			Reg._yesNoKeyPressValueAtMessage = 1;
		}
		
		else 
		{
			Reg._messageId = 4000;
			SceneGameRoom.messageBoxMessageOrder();
		}
	}
		
	private function scene_waiting_room_goto_game_room():Void
	{		
		Reg._buttonCodeValues = "r1001";

		if (RegCustom._to_game_room_from_waiting_room_confirmation[Reg._tn] == false)
		{
			Reg._yesNoKeyPressValueAtMessage = 1;
		}
		
		else
		{
			Reg._messageId = 4002;
			SceneGameRoom.messageBoxMessageOrder();
		}
	}	
	
	// refresh a list, a scrollable area with users that can be invited to the room.
	public function scene_waiting_room_refresh_online_list():Void
	{
		for (i in 0...121)
		{
			// clear list so that old data will not be displayed. a user may not be online since last update.
			RegTypedef._dataOnlinePlayers._usernamesOnline[i] = "";
			RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] = 0;
			RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] = 0;
			RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[i] = 0;	
			RegTypedef._dataOnlinePlayers._chess_elo_rating[i] = 0;
			
		}
		
		PlayState.clientSocket.send("Logged In Users", RegTypedef._dataOnlinePlayers);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
				
		_button_refresh_list.active = false;
		
		RegTriggers._waiting_room_refresh_list = true;
	}
	
	/******************************
	 * misc menu. first level.
	 */
	private function scene_misc_exit():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		if (Reg._at_misc == false)
		{
			Reg._at_misc = true;
			return;
		}
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._makeMiscellaneousMenuClassNotActive = true;
		
		Reg._at_misc = false;
		
		visible = false;
		destroy();
		
	}
	
	private function scene_daily_quests_exit():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
				
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._make_daily_quests_not_active = true;
		
		Reg._at_daily_quests = false;
		
		visible = false;
		destroy();
	}
	
	private function scene_daily_quests_claim_reward():Void
	{
		_rewards.splice(3, 0);
		_rewards =  RegTypedef._dataDailyQuests._rewards.split(",");
		
		if (_rewards[2] == "1")
		{
			_rewards[2] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			__daily_quests.messageRewardGiven3();
		}
				
		if (_rewards[1] == "1")
		{
			_rewards[1] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			__daily_quests.messageRewardGiven2();
		}
		
		if (_rewards[0] == "1")
		{
			_rewards[0] = "2";
			RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
			__daily_quests.messageRewardGiven1();
		}
		
		_button_claim_reward.visible = false;
		_button_claim_reward.active = false;		
	}
	
	private function scene_tournaments_exit():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
				
		_scene_tournaments_exit.active = false;
		
		if (__tournaments != null) __tournaments._button_move_piece.active = false;
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._make_tournaments_not_active = true;
		
		Reg._at_tournaments = false;
		
		visible = false;
		destroy();
	}
	/******************************
	 * button was pressed. at leaderboard, returning to lobby.
	 */	
	private function scene_leaderboard_return_to_lobby():Void
	{		
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		Reg._at_leaderboards = false;
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._make_leaderboards_not_active = true;
		
		visible = false;
		destroy();
	}
		
	override public function destroy()
	{
		if (__miscellaneous_menu != null)
		{
			__miscellaneous_menu.visible = false;
			remove(__miscellaneous_menu);
			__miscellaneous_menu.destroy();
		}

		if (_bgHorizontal != null)
		{
			_bgHorizontal.destroy();
			_bgHorizontal = null;
		}
		
		if (_to_lobby != null)
		{
			_to_lobby.destroy();
			_to_lobby = null;
		}
		
		if (_buttonToFurniturePutMenu != null)
		{
			_buttonToFurniturePutMenu.destroy();
			_buttonToFurniturePutMenu = null;
		}
		
		if (_buttonToFoundationPutMenu != null)
		{
			_buttonToFoundationPutMenu.destroy();
			_buttonToFoundationPutMenu = null;
		}
	
		if (_save != null)
		{
			_save.destroy();
			_save = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (RegCustom._house_feature_enabled[Reg._tn] == true)
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
		
		//######################## house
		if (Reg._at_house == true)
		{
			FlxG.mouse.enabled = true;
			active = true;
			
			// fix a camera display bug where the _buttonToFurnitureGetMenu can also be clicked from the right side of the screen because of the map scrolling part of the scene. setting this to active in an else statement is not needed because they are set active elsewhere in the code.
			if (FlxG.mouse.x > FlxG.width / 2
			&&  FlxG.mouse.y >= FlxG.height - 50) 
			{
				if (_buttonToFurnitureGetMenu != null)
					_buttonToFurnitureGetMenu.active = false;
				if (_buttonToFurniturePutMenu != null)
					_buttonToFurniturePutMenu.active = false;
			}
							
			if (Reg._buttonCodeValues != "") buttonCodeValues();
			
			#if html5
				_save.active = false;
			#end
		}
		// end house
		//#############################
		
		
		super.update(elapsed);
	}
	
}//