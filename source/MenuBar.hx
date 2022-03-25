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

#if tournaments
	import modules.tournaments.Tournaments;
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
 * Currently the menu bar only has the disconnect button. most class new this class so to get the disconnect button on their scenes.
 * @author kboardgames.com
 */
class MenuBar extends FlxGroup
{
	/******************************
	 * the icons that can be selected such as house or leaderboards
	 */
	public var _lobby_sprite:Array<FlxSprite> = [];
	
	/******************************
	 * this is the name of the lobby icon that can be selected. each name is outputted at the far right side of the last lobby icon when the mouse cursor is on one of those icons at this MeunBar.hx.
	 */
	private var _lobby_icon_name:Array<String> = [];
	private var _lobby_icon_names:FlxText;
	
	private var _group_lobby_sprite_highlighted:FlxSprite;
	
	/******************************
	 * menuBar background.
	 */
	public var _background:FlxSprite;
	
	private var _button_disconnect:ButtonGeneralNetworkYes;
	
	//####################### house
	#if house
		/******************************
		 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
		 */
		private var _tracker:FlxSprite;
		
		public var __house:House;
		
		/******************************
		 * HouseFurnitureItemsFront instance.
		 */
		private var _items:HouseFurnitureItemsFront;
		
		public var _buttonToFoundationPutMenu:ButtonToggleHouse;
		public var _buttonToFurnitureGetMenu:ButtonToggleHouse;
		public var _buttonToFurniturePutMenu:ButtonToggleHouse;
		
		private var _save:ButtonGeneralNetworkYes;
	#end
	//####################end house
	#if miscellaneous	
		public var __miscellaneous_menu:MiscellaneousMenu;
	#end
	
	#if dailyQuests
		public var __daily_quests:DailyQuests;
	#end
	
	#if tournaments
		public var __tournaments:Tournaments;
		public var _button_tournaments_reminder_by_mail:ButtonGeneralNetworkYes;
		public var _button_tournament_participating:ButtonGeneralNetworkYes;
	#end
	
	#if leaderboards
		public var __leaderboards:Leaderboards;
		public var _scene_leaderboards_exit:ButtonGeneralNetworkYes;
	#end
	
	public var __new_account:NewAccount;
	
	 /* hides the grid that would be shown underneath the lobby and disconnect buttons and also displays another horizontal bar at the top of the scene.
	 */
	private	var _bgHorizontal:FlxSprite;	
	private var _to_lobby:ButtonGeneralNetworkYes;

	/******************************
	 * moves all row data to the left side.
	 */
	private var _offset_x:Int = 50;
	
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
	
	/******************************
	 * 
	 * @param	_from_menuState		true if somewhere at the menu state. The player has not connected yet and might be at the help scene or credits scene. this is needed because if at playState then the disconnect button will trigger a close but if not connected then this is used to return to menu state.
	 * @param	_at_chatter			is player at the chatter. This is used to create a small red bar underneath the chatter background. this is needed because at waiting room this red bar will not go in front of the chatter background, so another new to this class is needed at chatter.
	 */
	override public function new(_from_menuState:Bool = false, _at_chatter:Bool = false, house:Dynamic = null, items:Dynamic = null):Void
	{
		super();
		
		#if house
			if (house != null)
			{
				__house = house;
				_items = items;
			}
		#end
		
		var _color = FlxColor.fromHSB(RegCustomColors.menu_bar_background_color().hue, 1, RegCustom._menu_bar_background_brightness[Reg._tn]);
		
		// no saturation for gray color.
		if (RegCustom._menu_bar_background_number[Reg._tn] == 13)
			_color = FlxColor.fromHSB(_color.hue, 0, RegCustom._client_background_brightness[Reg._tn]);
		
		if (RegCustom._menu_bar_background_number[Reg._tn] == 1)
			_color = FlxColor.WHITE;
		else if (RegCustom._menu_bar_background_number[Reg._tn] == 12)
			_color = FlxColor.BLACK;
		
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
		}
			
		if(_at_chatter == false) 
		{
			_background = new FlxSprite(0, FlxG.height - 50);
			_background.makeGraphic(FlxG.width, 50, _color);
		}
		else 
		{
			_background = new FlxSprite(FlxG.width-373, FlxG.height - 50);
			_background.makeGraphic(FlxG.width - 373, 50, _color);
		}
				
		_background.scrollFactor.set(0, 0);	
		add(_background);
		
		// width is 35 + 15 extra pixels for the space between the button at the edge of screen.
		if (_button_disconnect != null)
		{
			remove(_button_disconnect);
			_button_disconnect.destroy();
		}
		
		_button_disconnect = new ButtonGeneralNetworkYes(FlxG.width - 60, FlxG.height - 40, "X", 45, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, disconnect.bind(_from_menuState), 0xFFCC0000, false, 9999);
		_button_disconnect.scrollFactor.set(0, 0);
		_button_disconnect.label.font = Reg._fontDefault;
		add(_button_disconnect);
		
		set_all_menu_bar_elements_not_active();
		
		// lobby menu bar.
		if (Reg._at_lobby == true)
			menu_lobby();
		
		#if house
			if (Reg._at_house == true)
				menu_house();
		#end
		
		// without Reg._hasUserConnectedToServer var create room cannot be entered.
		if (Reg._hasUserConnectedToServer == false
		&& Reg._at_lobby == true
		|| Reg._at_create_room == true)
			menu_create_room();
			
		if (Reg._hasUserConnectedToServer == false
		&&	Reg	._at_lobby == true
		||	Reg._at_waiting_room == true)
			menu_waiting_room();
		
		if (Reg._at_misc == true) 
			menu_misc();
		
		if (Reg._at_daily_quests == true)
			menu_daily_quests();
		
		if (Reg._at_tournaments == true) 
			menu_tournaments();
		
		#if flags
			if (Reg._at_leaderboards == true) menu_leaderboards();
		#end
	}
	
	public function initialize():Void
	{
		#if house
			if (RegCustom._house_feature_enabled[Reg._tn] == true)
			{
				RegHouse.resetHouseAtLobby();
			}
			
			if (RegCustom._house_feature_enabled[Reg._tn] == true)
			{
				RegTypedef.resetHouseData(); // this is needed to avoid a crash.	
				RegHouse.resetHouseAtLobby();
				
				PlayState.send("House Load", RegTypedef._dataHouse);
				
			} else RegTriggers._returnToLobbyMakeButtonsActive = true;
		#else
			RegTriggers._returnToLobbyMakeButtonsActive = true;
		#end
	}
	
	private function menu_lobby():Void
	{
		if (Reg._at_house == true
		||	Reg._at_daily_quests == true
		||	Reg._at_leaderboards == true
		||	Reg._at_tournaments == true
		||	Reg._at_misc == true
		||	Reg._at_waiting_room == true
		||	Reg._at_create_room == true
		||	Reg._at_game_room == true
		) return;
		
		Reg._group_lobby_sprite.splice(0, Reg._group_lobby_sprite.length);
		_lobby_icon_name.splice(1, _lobby_icon_name.length);
		
		// 0: house. 1:misc. 2: daily quests. 3: leaderboards. 4: tournaments,
		
		Reg._lobby_icon_number.splice(0, Reg._lobby_icon_number.length);
		//Reg._lobby_icon_number = [];
		
		Reg._lobby_icon_total = -1;
		
		#if house
			if (RegCustom._house_feature_enabled[Reg._tn] == true)
			{
				Reg._lobby_icon_total += 1;
				Reg._lobby_icon_number.push(0);
				_lobby_icon_name.push("House");
			}
		#end
		
		#if dailyQuests
			Reg._lobby_icon_total += 1;
			Reg._lobby_icon_number.push(1);
			_lobby_icon_name.push("Daily Quests");
		#end
				
		// leaderboards.
		#if flags
			#if leaderboards
				if (RegCustom._leaderboard_enabled[Reg._tn] == true
				&&	RegCustom._world_flags_number[Reg._tn] > 0)
				{
					Reg._lobby_icon_total += 1;
					Reg._lobby_icon_number.push(2);
					_lobby_icon_name.push("Leaderboards");
				}
			#end
		#end
		
		#if tournaments
			Reg._lobby_icon_total += 1;
			Reg._lobby_icon_number.push(3);
			_lobby_icon_name.push("Tournaments");
		#end		
		
		#if miscellaneous
			Reg._lobby_icon_total += 1;
			Reg._lobby_icon_number.push(4);
			_lobby_icon_name.push("Miscellaneous");
		#end
		
		for (i in 0...Reg._lobby_icon_total + 1)
		{
			// add title here by increase the max number then go to titleMenu then go to the bottom of update(). 
			// all gameboards images are stored in frames.
			if (_lobby_sprite != null)
			{
				if (_lobby_sprite[i] != null)
				{
					remove(_lobby_sprite[i]);
					_lobby_sprite[i].destroy();
				}
			}
			
			_lobby_sprite[i] = new FlxSprite(0, 0);
			_lobby_sprite[i].loadGraphic("assets/images/iconsLobby.png", true, 70, 44);
			_lobby_sprite[i].scrollFactor.set(0, 0);
			_lobby_sprite[i].color = RegCustomColors.client_text_color();
			_lobby_sprite[i].updateHitbox();
			_lobby_sprite[i].visible = false;
			add(_lobby_sprite[i]);	
			
			// add this member to Reg._group_lobby_sprite.			
			Reg._group_lobby_sprite.push(_lobby_sprite[i]);
			Reg._group_lobby_sprite[i].setPosition(500 - 14 + (i * 70), FlxG.height - _lobby_sprite[i].height - 3);
			Reg._group_lobby_sprite[i].animation.add(Std.string(Reg._lobby_icon_number[i]), [Reg._lobby_icon_number[i]], 30, false);
			Reg._group_lobby_sprite[i].animation.play(Std.string(Reg._lobby_icon_number[i]));
			Reg._group_lobby_sprite[i].visible = true;
			add(Reg._group_lobby_sprite[i]);
		}
		
		if (Reg._lobby_icon_total > -1)
		{
			if (_group_lobby_sprite_highlighted != null)
			{
				remove(_group_lobby_sprite_highlighted);
				_group_lobby_sprite_highlighted.destroy();
			}
			
			_group_lobby_sprite_highlighted = new FlxSprite(500 - 2, FlxG.height - _lobby_sprite[0].height - 3 - 2);
			_group_lobby_sprite_highlighted.loadGraphic("assets/images/iconsHoverLobby.png", true, 70, 48); // height is the same value as width.
			_group_lobby_sprite_highlighted.scrollFactor.set(0, 0);
			_group_lobby_sprite_highlighted.animation.add("play", [0, 1], 10, true);
			_group_lobby_sprite_highlighted.animation.play("play");
			_group_lobby_sprite_highlighted.updateHitbox();
			_group_lobby_sprite_highlighted.visible = false;
			add(_group_lobby_sprite_highlighted);
		}
		
		if (_lobby_icon_names != null)
		{
			remove(_lobby_icon_names);
			_lobby_icon_names.destroy();
		}
		
		_lobby_icon_names = new FlxText(500 - 14 + 95 + (Reg._lobby_icon_total * 70), FlxG.height - 35, 0, "");
		_lobby_icon_names.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		add(_lobby_icon_names);
		
		// from actionCommand.hx jump to creating room.
		if (RegTriggers._jump_creating_room == true
		&&	RegTypedef._dataMisc._room == 0)
		{
			RegTypedef._dataMisc._room = 1;
			PlayState.__scene_lobby.goto_room(1);
		}
		
	}
	
	private function menu_house():Void
	{
		#if house
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
		#end
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
			if (Reg._at_create_room == false
			||	Reg._total_games_in_release == 0)
			{
				_buttonCreateRoom.visible = false;
				_buttonCreateRoom.active = false;
			}
			_buttonCreateRoom.screenCenter(X);
			add(_buttonCreateRoom);
			
			RegTriggers._jump_creating_room = false;
			
			if (Reg._at_create_room == true
			&&	RegTriggers._jump_waiting_room == true)
			{
				Reg._gameId = Reg._jump_game_id;
				scene_create_room_goto_waiting_room();
			}
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
		
		if (_button_return_to_lobby_from_waiting_room != null)
		{
			remove(_button_return_to_lobby_from_waiting_room);
			_button_return_to_lobby_from_waiting_room.destroy();
		}
		
		_button_return_to_lobby_from_waiting_room = new ButtonGeneralNetworkYes(40 + _offset, FlxG.height-40, "To Lobby", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_return_to_lobby, RegCustom._button_color[Reg._tn], false, 109);
		_button_return_to_lobby_from_waiting_room.label.font = Reg._fontDefault;
		_button_return_to_lobby_from_waiting_room.visible = false;
		_button_return_to_lobby_from_waiting_room.active = false;
		add(_button_return_to_lobby_from_waiting_room);
		
		if (_button_refresh_list != null)
		{
			remove(_button_refresh_list);
			_button_refresh_list.destroy();
		}
		
		_button_refresh_list = new ButtonGeneralNetworkYes(260 + _offset, FlxG.height-40, "Update List", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_refresh_online_list, RegCustom._button_color[Reg._tn], false, 9999);		
		_button_refresh_list.label.font = Reg._fontDefault;
		_button_refresh_list.scrollFactor.set(0, 0);
		_button_refresh_list.visible = true;
		_button_refresh_list.active = true;
		add(_button_refresh_list);				
		
		if (_buttonGameRoom != null)
		{
			remove(_buttonGameRoom);
			_buttonGameRoom.destroy();
		}
		
		_buttonGameRoom = new ButtonGeneralNetworkYes(220 + 260 + _offset, FlxG.height-40, "Game Room", 205, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_waiting_room_goto_game_room, RegCustom._button_color[Reg._tn], false, 111);
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
		if (_misc_menu_exit != null)
		{
			remove(_misc_menu_exit);
			_misc_menu_exit.destroy();
		}
		
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
		if (_scene_daily_quests_exit != null)
		{
			remove(_scene_daily_quests_exit);
			_scene_daily_quests_exit.destroy();
		}
		
		_scene_daily_quests_exit = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_daily_quests_exit, RegCustom._button_color[Reg._tn], true, 113);
		_scene_daily_quests_exit.label.font = Reg._fontDefault;
		_scene_daily_quests_exit.screenCenter(X);
		_scene_daily_quests_exit.x += 400;
		add(_scene_daily_quests_exit);
		
		_rewards.splice(3, 0);
		_rewards = RegTypedef._dataDailyQuests._rewards.split(",");
		
		var _stop:Bool = false; // used to break out of the following loop if that condition is true.
		
		for (i in 0...3)
		{
			if (_rewards[i] == "1")
			{
				if (_button_claim_reward != null)
				{
					remove(_button_claim_reward);
					_button_claim_reward.destroy();
				}
				
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
		if (_scene_tournaments_exit != null)
		{
			remove(_scene_tournaments_exit);
			_scene_tournaments_exit.destroy();
		}
		
		_scene_tournaments_exit = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_tournaments_exit, RegCustom._button_color[Reg._tn], true, 115);
		_scene_tournaments_exit.label.font = Reg._fontDefault;
		_scene_tournaments_exit.screenCenter(X);
		_scene_tournaments_exit.visible = false;
		_scene_tournaments_exit.active = false;
		_scene_tournaments_exit.x += 400;
		add(_scene_tournaments_exit);
		
		#if tournaments
			if (_button_tournaments_reminder_by_mail != null)
			{
				remove(_button_tournaments_reminder_by_mail);
				_button_tournaments_reminder_by_mail.destroy();
			}
			
			_button_tournaments_reminder_by_mail = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "Unsubcribe Mail", 245, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, tournaments_reminder_by_mail, RegCustom._button_color[Reg._tn], false, 0);
			_button_tournaments_reminder_by_mail.scrollFactor.set(0, 0);
			_button_tournaments_reminder_by_mail.label.font = Reg._fontDefault;
			_button_tournaments_reminder_by_mail.screenCenter(X);
			_button_tournaments_reminder_by_mail.visible = false;
			_button_tournaments_reminder_by_mail.active = false;
			add(_button_tournaments_reminder_by_mail);

			if (_button_tournament_participating != null)
			{
				remove(_button_tournament_participating);
				_button_tournament_participating.destroy();
			}
			
			_button_tournament_participating = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "Leave Tournament", 245, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, tournaments_Participating, RegCustom._button_color[Reg._tn], false, 0);
			_button_tournament_participating.scrollFactor.set(0, 0);
			_button_tournament_participating.label.font = Reg._fontDefault;
			_button_tournament_participating.screenCenter(X);
			_button_tournament_participating.x -= 245 + 15;
			_button_tournament_participating.visible = false;
			_button_tournament_participating.active = false;
			add(_button_tournament_participating);
		#end
	}
	
	private function tournaments_reminder_by_mail():Void
	{		
		PlayState.send("Tournament Reminder By Mail", RegTypedef._dataTournaments);		
	}
	
	private function tournaments_Participating():Void
	{
		if (RegTypedef._dataTournaments._tournament_started == true)
		{
			Reg._messageId = 7100;
			Reg._buttonCodeValues = "h1100";
			SceneGameRoom.messageBoxMessageOrder();
		}
		
		else
		{
			PlayState.send("Tournament Participating", RegTypedef._dataTournaments);			
		}
	}
	
	/******************************
	 * menu bar buttons for leaderboards scene
	 */
	private function menu_leaderboards():Void
	{
		#if leaderboards
			if (_scene_leaderboards_exit != null)
			{
				remove(_scene_leaderboards_exit);
				_scene_leaderboards_exit.destroy();
			}
			
			_scene_leaderboards_exit = new ButtonGeneralNetworkYes(0, FlxG.height - 40, "To Lobby", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scene_leaderboard_return_to_lobby , RegCustom._button_color[Reg._tn], false, 116);		
			_scene_leaderboards_exit.label.font = Reg._fontDefault;
			_scene_leaderboards_exit.screenCenter(X);
			_scene_leaderboards_exit.x += 400;
			add(_scene_leaderboards_exit);
		#end
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
		
		if (_from_menuState == false) PlayState.prepareToDisconnect();
		else FlxG.switchState(new MenuState());
	}
	
	private function set_all_menu_bar_elements_not_active():Void
	{
		#if house
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
			
		#end
		
		#if dailyQuests
			if (__daily_quests != null)
			{
				if (__daily_quests.__scrollable_area != null)
				{
					__daily_quests.__scrollable_area.visible = false;
					__daily_quests.__scrollable_area.active = false;
				}	
			}
		#end
		
		#if leaderboards
			if (__leaderboards != null)
			{
				if (__leaderboards.__scrollable_area != null)
				{
					__leaderboards.__scrollable_area.visible = false;
					__leaderboards.__scrollable_area.active = false;
					
				}
			}
		#end
		
		if (_to_lobby != null)
		{
			_to_lobby.visible = false;
			_to_lobby.active = false;
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
		
		#if leaderboards
			if (_scene_leaderboards_exit != null)
			{
				_scene_leaderboards_exit.visible = false;
				_scene_leaderboards_exit.active = false;
			}
		#end
	}
	
	/*****************************
	 * function that house uses.
	 */
	public function scene_house_return_to_lobby():Void
	{
		#if house
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
			
			if (_tracker != null)
			{
				remove(_tracker);
				_tracker.destroy();
			}
			
			_tracker = new FlxSprite(0, 0);
			_tracker.loadGraphic("modules/house/assets/images/tracker.png", false);
			_tracker.scrollFactor.set(1, 1);
			_tracker.screenCenter(XY);
			add(_tracker);
			
			// the tracker is centered to the screen, so that the camera will focus on the scene as if the scene had never had an offset that may have been created by house map which is where an furniture item can be placed onto and where the mouse can scroll to see more of a map. so when scrolling happens, the offset is created at every scene because camera focuses on all scenes. this command is the fix.
			FlxG.camera.follow(_tracker, FlxCameraFollowStyle.LOCKON);
		
			// is this a new user account. we are here because all server events have been complete after the login and this is the last of the login setup.
			if (Reg2._checked_for_new_account == false
			&&  RegTypedef._dataStatistics._chess_elo_rating == 0
			||  Reg2._checked_for_new_account == false
			&&	RegTypedef._dataAccount._username.substr(0, 5) == "Guest")
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
		#end
	}
	
	/******************************
	 * function that house uses.
	 */
	private function scene_house_save():Void
	{
		#if house
			Reg._messageId = 7001;
			Reg._buttonCodeValues = "h1000";
			SceneGameRoom.messageBoxMessageOrder();
		#end
	}
	
	/******************************
	 * shared menu buttons from all states that use a menu bar.
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		#if house
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
				PlayState.send("House Save", RegTypedef._dataHouse);				
				PlayState.send("Daily Reward Save", RegTypedef._dataStatistics);				
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
		#end
		
		#if tournaments
			// message that player cannot leave tournament game when tournament is still active.
			if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "h1100")
			{
				Reg._yesNoKeyPressValueAtMessage = 0;
				Reg._buttonCodeValues = "";
			}
			
			// subscribe/unsubscribe from all tournament mail.
			if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "h1110")
			{
				Reg._yesNoKeyPressValueAtMessage = 0;
				Reg._buttonCodeValues = "";
			}
		#end
	}
	
	/******************************
	 * function that house uses.
	 */
	public function scene_lobby_house():Void
	{
		#if house
			set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
					
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

			//}
			
			PlayState.__scene_lobby.set_not_active_for_buttons();
			__house.buttonToFurnitureGetMenu();
			
			var _state = FlxG.state;
			_state.openSubState(new SceneTransition());
		#end
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
		
		Reg._at_leaderboards = true;
		PlayState.__scene_lobby.set_not_active_for_buttons();
		
		#if leaderboards
			if (__leaderboards != null)
			{
				remove(__leaderboards);
				__leaderboards.destroy();
			}
		
			__leaderboards = new Leaderboards();		
			add(__leaderboards);
		#end		
	}
		
	/******************************
	 * lobby menu button
	 * game instructions, stats.
	 */
	private function scene_lobby_miscMenu():Void
	{
		// this stop the clicking of this button when not at this buttons scene.
		if (RegTypedef._dataMisc._room > 0) return; 
		
		PlayState.__scene_lobby.set_not_active_for_buttons();
		
		#if miscellaneous
			// we call the stats here because when entering the miscellaneous menu, sometimes we need to call an event twice to get the data. 
			Reg2._miscMenuIparameter = 0;
			PlayState.send("Get Statistics All", RegTypedef._dataStatistics);			
			
			if (__miscellaneous_menu != null)
			{
				__miscellaneous_menu.visible = false;
				__miscellaneous_menu.destroy();
				__miscellaneous_menu = null;
			}
			
			Reg._at_misc = true;
			
			if (__miscellaneous_menu != null)
			{
				remove(__miscellaneous_menu);
				__miscellaneous_menu.destroy();
			}
			
			__miscellaneous_menu = new MiscellaneousMenu();
			add(__miscellaneous_menu);
			
			var _state = FlxG.state;
			_state.openSubState(new SceneTransition());
		#end
	}
	
	
	/******************************
	 * lobby menu button
	 * daily quests.
	 */
	private function scene_lobby_daily_quests():Void
	{
		#if dailyQuests
			PlayState.__scene_lobby.set_not_active_for_buttons();
			
			if (__daily_quests != null)
			{
				//TODO all destroy code everywhere must use .remove
				__daily_quests.destroy();
				remove(__daily_quests);
			}
			
			Reg._at_daily_quests = true;
			
			if (__daily_quests != null)
			{
				remove(__daily_quests);
				__daily_quests.destroy();
			}
			
			__daily_quests = new DailyQuests();
			add(__daily_quests);
			
		#end
	}
	
	/******************************
	 * lobby menu button
	 */
	private function scene_lobby_tournaments():Void
	{
		#if tournaments
			if (__tournaments != null)
			{
				__tournaments.destroy();
				remove(__tournaments);
			}
			
			Reg._at_tournaments = true;
			
			if (__tournaments != null)
			{
				remove(__tournaments);
				__tournaments.destroy();
			}
			
			__tournaments = new Tournaments();		
			add(__tournaments);
			
			PlayState.send("Tournament Chess Standard 8 Get", RegTypedef._dataTournaments);
			
			PlayState.__scene_lobby.set_not_active_for_buttons();
			
			var _state = FlxG.state;
			_state.openSubState(new SceneTransition());
		#end
	}

	/******************************
	 * SceneCreateRoom menu buttons.
	 * go to GameWaitingRoom class
	 */
	public function scene_create_room_goto_waiting_room():Void
	{
		// entering the waiting room.
		if (Reg._at_waiting_room == false)
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
			
			PlayState.send("Is Room Locked", RegTypedef._dataMisc);
			
			InviteTable._ticks_invite_list = 0;
			//InviteTable._populated_table_body = false;
			RegTriggers._waiting_room_refresh_invite_list = true;
			Reg2._scrollable_area_is_scrolling = false;
		}
	}
	
	/******************************
	 * SceneCreateRoom menu buttons.
	 */	
	private function scene_create_room_return_to_lobby():Void
	{		
		//ActionInput.enable();
		
		RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = 0;
					 
		PlayState.send("Lesser RoomState Value", RegTypedef._dataMisc);
		
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
		_button_refresh_list.active = false;
		
		for (i in 0... TableColumnSort._flipY.length)
		{
			TableColumnSort._flipY[i] = false;
		}	
		
		PlayState.send("Logged In Users", RegTypedef._dataOnlinePlayers);
	}
	
	/******************************
	 * misc menu. first level.
	 */
	private function scene_misc_exit():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		if (Reg._at_misc == false)
		{
			Reg._at_misc = true;
			return;
		}
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._makeMiscellaneousMenuClassNotActive = true;
		
		Reg._at_misc = false;
	}
	
	private function scene_daily_quests_exit():Void
	{
		set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		RegTriggers._make_daily_quests_not_active = true;
		
		Reg._at_daily_quests = false;
	}
	
	private function scene_daily_quests_claim_reward():Void
	{
		#if dailyQuests
			_rewards.splice(3, 0);
			_rewards =  RegTypedef._dataDailyQuests._rewards.split(",");
			
			if (_rewards[2] == "1")
			{
				_rewards[2] = "2";
				RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
				DailyQuests.messageRewardGiven3();
			}
					
			if (_rewards[1] == "1")
			{
				_rewards[1] = "2";
				RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
				DailyQuests.messageRewardGiven2();
			}
			
			if (_rewards[0] == "1")
			{
				_rewards[0] = "2";
				RegTypedef._dataDailyQuests._rewards = _rewards[0] + "," + _rewards[1] + "," + _rewards[2];
				DailyQuests.messageRewardGiven1();
			}
			
			_button_claim_reward.visible = false;
			_button_claim_reward.active = false;
		#end
	}
	
	private function scene_tournaments_exit():Void
	{
		#if tournaments
			set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
			
			_scene_tournaments_exit.active = false;
			
			if (__tournaments != null) __tournaments._button_move_piece.active = false;
			
			RegTriggers._returnToLobbyMakeButtonsActive = true;
			RegTriggers._make_tournaments_not_active = true;
			
			Reg._at_tournaments = false;
		#end
	}
	/******************************
	 * button was pressed. at leaderboard, returning to lobby.
	 */	
	private function scene_leaderboard_return_to_lobby():Void
	{
		haxe.Timer.delay(function ()
		{
			set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
		
			RegTriggers._returnToLobbyMakeButtonsActive = true;
			RegTriggers._make_leaderboards_not_active = true;
			
			Reg._at_leaderboards = false;
		}, 500); // milliseconds
	}
	
	override public function destroy()
	{
		if (_lobby_sprite != null)
		{
			for (i in 0... _lobby_sprite.length)
			{
				remove(_lobby_sprite[i]);
				_lobby_sprite[i].destroy();
				_lobby_sprite[i] = null;
			}
		}
	
		if (_lobby_icon_names != null)
		{
			remove(_lobby_icon_names);
			_lobby_icon_names.destroy();
			_lobby_icon_names = null;
		}
	
		if (_group_lobby_sprite_highlighted != null)
		{
			remove(_group_lobby_sprite_highlighted);
			_group_lobby_sprite_highlighted.destroy();
			_group_lobby_sprite_highlighted = null;
		}
	
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
	
		#if dailyQuests
			if (__daily_quests != null)
			{
				remove(__daily_quests);
				__daily_quests.destroy();
				__daily_quests = null;
			}
		#end
	
		if (__new_account != null)
		{
			remove(__new_account);
			__new_account.destroy();
			__new_account = null;
		}
		
		if (_buttonCreateRoom != null)
		{
			remove(_buttonCreateRoom);
			_buttonCreateRoom.destroy();
			_buttonCreateRoom = null;
		}
		
		if (_buttonReturnToLobby != null)
		{
			remove(_buttonReturnToLobby);
			_buttonReturnToLobby.destroy();
			_buttonReturnToLobby = null;
		}
		
		if (_buttonGameRoom != null)
		{
			remove(_buttonGameRoom);
			_buttonGameRoom.destroy();
			_buttonGameRoom = null;
		}
		
		if (_button_return_to_lobby_from_waiting_room != null)
		{
			remove(_button_return_to_lobby_from_waiting_room);
			_button_return_to_lobby_from_waiting_room.destroy();
			_button_return_to_lobby_from_waiting_room = null;
		}
		
		if (_button_refresh_list != null)
		{
			remove(_button_refresh_list);
			_button_refresh_list.destroy();
			_button_refresh_list = null;
		}
		
		if (_misc_menu_exit != null)
		{
			remove(_misc_menu_exit);
			_misc_menu_exit.destroy();
			_misc_menu_exit = null;
		}
		
		if (_scene_daily_quests_exit != null)
		{
			remove(_scene_daily_quests_exit);
			_scene_daily_quests_exit.destroy();
			_scene_daily_quests_exit = null;
		}
	
		if (_button_claim_reward != null)
		{
			remove(_button_claim_reward);
			_button_claim_reward.destroy();
			_button_claim_reward = null;
		}
	
		if (_scene_tournaments_exit != null)
		{
			remove(_scene_tournaments_exit);
			_scene_tournaments_exit.destroy();
			_scene_tournaments_exit = null;
		}
			
		#if tournaments
			if (__tournaments != null)
			{
				remove(__tournaments);
				__tournaments.destroy();
				__tournaments = null;
			}
			
			if (_button_tournaments_reminder_by_mail != null)
			{
				remove(_button_tournaments_reminder_by_mail);
				_button_tournaments_reminder_by_mail.destroy();
				_button_tournaments_reminder_by_mail = null;
			}
			
			if (_button_tournament_participating != null)
			{
				remove(_button_tournament_participating);
				_button_tournament_participating.destroy();
				_button_tournament_participating = null;
			}
		#end
		
		#if miscellaneous
			if (__miscellaneous_menu != null)
			{
				__miscellaneous_menu.visible = false;
				remove(__miscellaneous_menu);
				__miscellaneous_menu.destroy();
				__miscellaneous_menu = null;
			}
		#end
		
		if (_bgHorizontal != null)
		{
			remove(_bgHorizontal);
			_bgHorizontal.destroy();
			_bgHorizontal = null;
		}
		
		if (_to_lobby != null)
		{
			remove(_to_lobby);
			_to_lobby.destroy();
			_to_lobby = null;
		}

		#if house
			if (_tracker != null)
			{
				remove(_tracker);
				_tracker.destroy();
				_tracker = null;
			}
			
			if (__house != null)
			{
				__house = null;
				_items = null;
			}
		
			if (_buttonToFurnitureGetMenu != null)
			{
				remove(_buttonToFurnitureGetMenu);
				_buttonToFurnitureGetMenu.destroy();
				_buttonToFurnitureGetMenu = null;
			}
			
			if (_buttonToFurniturePutMenu != null)
			{
				remove(_buttonToFurniturePutMenu);
				_buttonToFurniturePutMenu.destroy();
				_buttonToFurniturePutMenu = null;
			}
			
			if (_buttonToFoundationPutMenu != null)
			{
				remove(_buttonToFoundationPutMenu);
				_buttonToFoundationPutMenu.destroy();
				_buttonToFoundationPutMenu = null;
			}
		
			if (_save != null)
			{
				remove(_save);
				_save.destroy();
				_save = null;
			}
		#end
		
		#if leaderboards
			if (_scene_leaderboards_exit != null)
			{
				remove(_scene_leaderboards_exit);
				_scene_leaderboards_exit.destroy();
				_scene_leaderboards_exit = null;
			}

			if (__leaderboards != null)
			{
				__leaderboards.destroy();
				
				__leaderboards.visible = false;
				__leaderboards.active = false;
				__leaderboards = null;
			}
		#end
		
		if (_button_disconnect != null)
		{
			remove(_button_disconnect);
			_button_disconnect.destroy();
			_button_disconnect = null;
		}
		visible = false;
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		RegFunctions.sound(2);
		
		// show foreground scene effects when return to misc scene from misc output scene.
		if (RegTriggers._makeMiscellaneousMenuClassActive == true
		&&	__miscellaneous_menu.active == true)
		{
			RegTriggers._makeMiscellaneousMenuClassActive = false;
			
			var _state = FlxG.state;
			_state.openSubState(new SceneTransition());
		}
		
		if (_group_lobby_sprite_highlighted != null 
		&&	Reg._at_lobby == true)
		{			
			_group_lobby_sprite_highlighted.visible = false;			
			_lobby_icon_names.text = "";
			
			for (i in 0... Reg._lobby_icon_total + 1)
			{
				Reg._group_lobby_sprite[i].visible = true;
					
				// stop player hammering.
				if (FlxG.mouse.y >= FlxG.height - 50 && Reg._buttonDown == true) 
					Reg._group_lobby_sprite[i].alpha = 0.3;
				else 
					Reg._group_lobby_sprite[i].alpha = 1;
				
				// is mouse at the lobby icon?
				if (FlxG.mouse.x >= Reg._group_lobby_sprite[i].x
				&&	FlxG.mouse.x <= Reg._group_lobby_sprite[i].x + 70
				&&	FlxG.mouse.y >= FlxG.height - 50
				)
				{
					_group_lobby_sprite_highlighted.visible = true;
					_group_lobby_sprite_highlighted.x = 502 - 15 + (i * 70); 
					_lobby_icon_names.text = _lobby_icon_name[i];
					
					if (FlxG.mouse.justPressed == true)
						PlayState.__scene_lobby._lobby_sprite_mouse_just_pressed = true;
						
					if (FlxG.mouse.justReleased == true
					&&	Reg._buttonDown == false
					&&	PlayState.__scene_lobby._lobby_sprite_mouse_just_pressed == true)
					{
						PlayState.__scene_lobby._lobby_sprite_mouse_just_pressed = false;
						
						if (RegCustom._sound_enabled[Reg._tn] == true)
							FlxG.sound.playMusic("click", 1, false);
						
						switch(Reg._lobby_icon_number[i])
						{
							case 0: scene_lobby_house();				
							case 1: scene_lobby_daily_quests();
							case 2: scene_lobby_leaderboards();
							case 3: scene_lobby_tournaments();
							case 4: scene_lobby_miscMenu();
						}
					}		
					
				}
			}
		}
		
		// hide the lobby buttons. no need to set active to false for those icons because if not at lobby then a check for a mouse click will not be made.
		else if (Reg._at_house == true
		||	Reg._at_daily_quests == true
		||	Reg._at_leaderboards == true
		||	Reg._at_tournaments == true
		||	Reg._at_misc == true
		||	Reg._at_waiting_room == true
		||	Reg._at_create_room == true
		||	Reg._at_game_room == true)
		{
			for (i in 0... Reg._lobby_icon_total + 1)
			{
				if (Reg._at_lobby == false) 
					Reg._group_lobby_sprite[i].visible = false;
			}
		}
		
		//######################## house
		#if house
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
			
			if (Reg._at_house == true)
			{
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
				
				#if html5
					_save.active = false;
				#end
			}
		
			// end house
			//#############################
		#end
		
		// not at house but this is needed to do a elo skill check.
			
		// is this a new user account. we are here because all server events have been complete after the login and this is the last of the login setup.
		if (PlayState.__scene_lobby != null
		&&	RegCustom._house_feature_enabled[Reg._tn] == false)
		{
			if (Reg2._checked_for_new_account == false
			&&  RegTypedef._dataStatistics._chess_elo_rating == 0
			||  Reg2._checked_for_new_account == false
			&&	RegTypedef._dataAccount._username.substr(0, 5) == "Guest")
			{
				set_all_menu_bar_elements_not_active(); // reset buttons to false because just after closing a dialog box, that class will reset state of buttons back to active.
				
				Reg2._checked_for_new_account = true;
				PlayState.__scene_lobby.set_not_active_for_buttons();
				
				if (__new_account == null)
				{
					__new_account = new NewAccount();
					add(__new_account);
				}
			}
		}
		
		#if tournaments
			if (_button_tournaments_reminder_by_mail != null)
			{
				// trigger is needed here not at top of block. by moving it, the subscribe button's text wont work.
				if (RegTypedef._dataTournaments._player1 != ""
				&&	RegTriggers._tournament_standard_chess_8_menubar == true)
				{					
					_button_tournaments_reminder_by_mail.active = true;
					_button_tournaments_reminder_by_mail.visible = true;
				}
				
				else if (RegTypedef._dataTournaments._player1 == "")
				{
					_button_tournaments_reminder_by_mail.visible = false;
					_button_tournaments_reminder_by_mail.active = false;
				}
				
				// display the exit button. the code is used here so that all buttons are displayed at the same time.
				if (RegTypedef._dataTournaments._reminder_by_mail == true)
				{
					_button_tournaments_reminder_by_mail.label.text = "Unsubscribe mail";
				}
				else
				{
					_button_tournaments_reminder_by_mail.label.text = "Subscribe mail";
				}
			}
			
			if (_button_tournament_participating != null)
			{
				// trigger is needed here not at top of block. by moving it, the subscribe button's text wont work.
				if (RegTriggers._tournament_standard_chess_8_menubar == true)
				{					
					_button_tournament_participating.active = true;
					_button_tournament_participating.visible = true;
				}
				
				// display the exit button. the code is used here so that all buttons are displayed at the same time.
				if (RegTriggers._tournament_standard_chess_8_menubar == true)
				{
					RegTriggers._tournament_standard_chess_8_menubar = false;
					_scene_tournaments_exit.active = true;
					_scene_tournaments_exit.visible = true;				
				}
				
				if (RegTypedef._dataTournaments._player1 != "")
					_button_tournament_participating.label.text = "Leave Tournament";
				else
					_button_tournament_participating.label.text = "Join Tournament";	
			}
		#end
		
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		super.update(elapsed);
	}
	
}//