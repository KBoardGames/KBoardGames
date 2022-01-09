/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// If the game crashes without an error then copy the music files to the bin folder.
package;

#if chess
	import modules.games.chess.*;
#end

#if flags
	import modules.worldFlags.WorldFlags;
#end 

#if house
	import modules.house.*;
#end

/**
 * ...
 * @author kboardgames.com
 */
class MenuState extends FlxState
{
	//public var _music:Sound;
	//public var _sound_channel:SoundChannel;
	
	public var __action_commands:ActionCommands;

	// chess skill level buttons.
	private var _button_b1:ButtonToggleFlxState;
	private var _button_b2:ButtonToggleFlxState;
	private var _button_b3:ButtonToggleFlxState;
	
	/******************************
	 * Toggles fullscreen mode off or on.
	 */
	private var _toggleFullscreen:ButtonGeneralNetworkNo;
	
	/******************************
	 * Saves the scale mode setting.
	 */
	private var _gameMenu:FlxSave;
	
	public static var _str:String = ""; // message box text.

	private var _software_new_check:ButtonGeneralNetworkNo;
	
	/******************************
		 * The scale modes. Changes the game's aspect ratio and/or size. Can maintain the aspect ratio of width and height and can windowbox the game if necessary.
	 */
	private var scaleModes:Array<ScaleMode> = [RELATIVE, RATIO_DEFAULT, RATIO_FILL_SCREEN, FILL];
	
	/******************************
	* Change the scale mode. The scale mode changes the width and height of the program's window settings.
	*/
	private var _button_scale_mode:ButtonGeneralNetworkNo;

	/******************************
	 * This holds the value of the scale mode selected.
	 */
	private var scaleModeIndex:Int = 0;
	
	/******************************
	 * when this value is true some elements at update() will be set active.
	 * when a dialog box is open, users are still able to click something underneath it. a function is called to set active to false for those elements but some will set back to true at update() without this code.
	 */
	private var _is_active:Bool = true;
		
	private var _offset_current_x:Int = 4;
	private var _offset_current_y:Int = 1;
	private var _offset_upcoming_x:Int = -3;
	private var _offset_upcoming_y:Int = 1;
	
	/******************************
	 * this moves everything. title and all text and sprite.
	 */
	private var _offset_icons_and__event_scheduler_y:Int = - 60;
	
	/******************************
	 * this is the event scheduler box. This shows the current and upcoming events.
	 */
	private var _eventSchedulerBackground:FlxSprite; // see calendar and events classes.
	private var _eventSchedulerHover:FlxSprite;
	
	/******************************
	 * reg_ipAddress changes at this state so we need to store the real IP address here.
	 */
	private var _ip:String = "";
	
	/******************************
	 * the icons that can be selected such as multiplayer online or player a 2 player game offline.
	 */
	public var _sprite:FlxSprite;
	
	/******************************
	 * when clicking on a title icon image, this image has a border that highlighted it.
	 */
	public var _game_highlighted:FlxSprite;
	
	/******************************
	 * this holds the title icons. value starts at 0. access members here.
	 */
	public var _group_sprite:Array<FlxSprite> = [];
	
	public var _icon_text_title_description:FlxText;
	
	/******************************
	 * display the version of the client on scene.
	 */
	private var _text_version_display:FlxText;
	
	/******************************
	 * the sound does not play for the icons the first time. this is the fix.
	 */
	private var _clicked:Bool = false;
	
	private var _client_online:Bool = false;
	
	/******************************
	 * this tick is used to do stuff when the menuState is first loaded at the update() instead of at the constructor because the constructor would give a white screen when trying to connect to the website.
	 */
	private var _ticks_startup:Float = 0;
	
	/******************************
	 * in html5 build the variable at the Internet.hx class function does not get populated before its return command. therefore this variable is used to delay code, which comes after the Internet.hx class function call, until the Internet.hx class function variable does get populated.
	 */
	private var _ticks_internet:Int = 0;
		 
	private var _bot_ben:ButtonToggleFlxState;
	private var _bot_tina:ButtonToggleFlxState;
	private var _bot_piper:ButtonToggleFlxState;
	private var _bot_amy:ButtonToggleFlxState;
	private var _bot_zak:ButtonToggleFlxState;
	private var _profile_username_p1:ButtonToggleFlxState;
	
	private var _icon_offset_x:Int = 0;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	private var _textEventSchedule:FlxText;
	
	override public function create():Void
	{
		persistentDraw = true;
		persistentUpdate = false;
		
		FlxG.scaleMode = new RatioScaleMode();
		Reg._at_game_room = false; // needed here since auto return after save options could be enabled.
		Reg._at_lobby = false;
		
		_is_active = true;
		_ip = Reg._ipAddress;
		
		// when returned to a state after mouse was set to not visible, system mouse will not show at that new state when mouse it set to visible.
		FlxG.mouse.useSystemCursor = false;		
		RegTypedef.resetTypedefData(); 
		
		#if house
			RegHouse.resetHouseAtLobby();
		#end
		
		// turn of chat for guests. we don't want guests swearing at everyone.
		#if html5
			RegCustom._chat_when_at_lobby_enabled[Reg._tn] = false;
			RegCustom._chat_when_at_room_enabled[Reg._tn] = false;
			RegCustom._timer_enabled[Reg._tn] = false;
		#end	
		
		// 886 = current first icon x position (multiplaer icon) for neko/cpp, times 79 which is 64 pixels for the icon plus 15 more for the space between the icons. 64 is the icon width / 2.
		_icon_offset_x = 886; // 886 * (79 * 2) + (64 / 2) 			
		
		RegTriggers.resetTriggers(); 		
		RegFunctions.fontsSharpen();
		
		Reg.resetRegVarsOnce();
		getIPaddressFromServerOrMain();
		
		#if !html5
			//------------------------------
			RegFunctions._gameMenu = new FlxSave(); // initialize		
			RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
			
			Reg._tn = -1; // this value will be loaded from hard drive.
			
			// we use true here so that some items are loaded. a value of false is the default for this function so that so items are only loaded when a condition is met.
			RegCustom.resetConfigurationVars();			
			
			// load data.
			RegCustom._chess_skill_level_offline = RegFunctions._gameMenu.data._chess_skill_level_offline;
			Reg2._menu_state_username_p1 = RegFunctions._gameMenu.data._menu_state_username_p1;
			
			if (RegFunctions._gameMenu.data.scaleModeIndex != null)
				scaleModeIndex = RegFunctions._gameMenu.data.scaleModeIndex;

			RegFunctions.loadConfig(true);
			
			if (Reg._tn == -1) Reg._tn = 0; // avoid a client crash by setting the selected theme to default.
			
			if (Reg._tn == 0) RegCustom.resetConfigurationVars2();			
			
			RegFunctions.themes_recursive_file_loop();
			
			RegCustom.assign_colors();
		
		#else
			Reg._tn = 0;
			RegCustom.resetConfigurationVars();	
			RegCustom.resetConfigurationVars2();			
			
			RegCustom.assign_colors();
			bgColor = RegCustomColors.color_client_background();
		#end
		
		Reg.resetRegVars(); 
		Reg2.resetRegVarsOnce();
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		
		#if flags
			WorldFlags.main();
		#end
		
		#if chess
			ChessECO.ECOlists();
		#end
		
		Reg._at_menu_state = true;
		
		RegCustom._chess_skill_level_online = RegCustom._chess_skill_level_offline;
				
		setExitHandler(function() 
		{
			// put any code here. it will be ran before client exits.
			RegFunctions._gameMenu.data._chess_skill_level_offline = RegCustom._chess_skill_level_offline;
			RegFunctions._gameMenu.data._menu_state_username_p1 = Reg2._menu_state_username_p1;
			
			// save data
			RegFunctions._gameMenu.flush();
			RegFunctions._gameMenu.close;
		});
		
		Reg2._scrollable_area_is_scrolling = false;
		
		//https://stackoverflow.com/questions/36822025/execute-url-path-in-external-program-in-haxe
		//case "Linux", "BSD", "Android": Sys.command("xdg-open", [url]);
		//case "Mac": Sys.command("open", [url]);
		//case "Windows": Sys.command("start", [url]);
		//Sys.command("start", ["https://localhost"]);
		//Sys.command("start", ["Games.exe"]);
		// Example, just use... Sys.command("batch.bat");
		
	}
	
	private function full_screen_toggle():Void
	{
		FlxG.fullscreen = !FlxG.fullscreen;
	}
	
	private function setScaleMode(scaleMode:ScaleMode)
	{
		_button_scale_mode.label.text = "Scale Mode: " + scaleMode;

		FlxG.scaleMode = switch (scaleMode)
		{			
			case ScaleMode.RELATIVE:
				new RelativeScaleMode(0.95, 0.95);
				
			case ScaleMode.RATIO_DEFAULT:
				new RatioScaleMode();

			case ScaleMode.RATIO_FILL_SCREEN:
				new RatioScaleMode(true);

			case ScaleMode.FILL:
				new FillScaleMode();

		}

	}
	
	private function chess_skill_level_setup():Void
	{
		var _gameOptions = new FlxText(30, 620, 0, "What is your chess skill level for offline play?");
		_gameOptions.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_gameOptions.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_gameOptions.scrollFactor.set();
		add(_gameOptions);
		
		_button_b1 = new ButtonToggleFlxState(_gameOptions.x + _gameOptions.textField.width + 15, 615, 1, "Beginner", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(0), RegCustom._button_color[Reg._tn], false);
		_button_b1.has_toggle = true;
		_button_b1.label.font = Reg._fontDefault;
		add(_button_b1);
		
		_button_b2 = new ButtonToggleFlxState(_button_b1.x + _button_b1.label.textField.width + 15, 615, 2, "Intermediate", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(1), RegCustom._button_color[Reg._tn], false);
		_button_b2.label.font = Reg._fontDefault;
		_button_b2.has_toggle = true;
		add(_button_b2);
		
		_button_b3 = new ButtonToggleFlxState(_button_b2.x + _button_b2.label.textField.width + 15, 615, 3, "Advance", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(2), RegCustom._button_color[Reg._tn], false);
		_button_b3.label.font = Reg._fontDefault;
		_button_b3.has_toggle = true;
		add(_button_b3);

		set_chess_elo_button_toggle();
		chess_skill_selected(RegCustom._chess_skill_level_online);
	}
	
	private function set_chess_elo_button_toggle():Void
	{
		_button_b1.set_toggled(false);
		_button_b1.has_toggle = false;
		
		_button_b2.set_toggled(false);
		_button_b2.has_toggle = false;
		
		_button_b3.set_toggled(false);
		_button_b3.has_toggle = false;
	}
	
	private function chess_skill_selected(_num:Int = 0):Void
	{
		RegCustom._chess_skill_level_online = RegCustom._chess_skill_level_offline = _num;
		set_chess_elo_button_toggle();
		
		switch (_num)
		{
			case 0:
			{
				_button_b1.set_toggled(true);
				_button_b1.has_toggle = true;
			}
			
			case 1:
			{
				_button_b2.set_toggled(true);
				_button_b2.has_toggle = true;
			}
			
			case 2:
			{
				_button_b3.set_toggled(true);
				_button_b3.has_toggle = true;
			}
				
		}	
		
	}	
	
	public function draw_event_scheduler():Void
	{
		if (_client_online == true)
		{		
			_eventSchedulerBackground = new FlxSprite(0, 0);
			_eventSchedulerBackground.loadGraphic("assets/images/eventSchedulerBackground.png", false);
			_eventSchedulerBackground.scrollFactor.set(0, 0);	
			_eventSchedulerBackground.scale.set(1.05, 1.05);
			_eventSchedulerBackground.setPosition(200 - 8, 440 - 8 + _offset_icons_and__event_scheduler_y);
			_eventSchedulerBackground.color = RegCustomColors.color_client_background();
			_eventSchedulerBackground.alpha = 0.50;
			add(_eventSchedulerBackground);
			
			var _event_scheduler_border = new FlxSprite(0, 0);
			_event_scheduler_border.loadGraphic("assets/images/eventSchedulerBorder.png", false);
			_event_scheduler_border.scrollFactor.set(0, 0);	
			_event_scheduler_border.scale.set(1.05, 1.05);
			_event_scheduler_border.setPosition(200 - 8, 440 - 8 + _offset_icons_and__event_scheduler_y);
			//_event_scheduler_border.color = FlxColor.RED;
			add(_event_scheduler_border);
			
			_eventSchedulerHover = new FlxSprite(0, 0);
			_eventSchedulerHover.loadGraphic("assets/images/eventSchedulerHover.png", false);
			_eventSchedulerHover.scrollFactor.set(0, 0);
			_eventSchedulerHover.scale.set(1.05, 1.05);
			_eventSchedulerHover.setPosition(200 - 8, 440 - 8 + _offset_icons_and__event_scheduler_y);
			_eventSchedulerHover.visible = false;
			add(_eventSchedulerHover);
			
			eventCurrentAndUpcoming();
		}
	}
	
	/******************************
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		// update client then exit program.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "z1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			#if android
				Internet.getAndroidAPKfile();
			#elseif html5
			#elseif desktop
				Sys.command("start", ["boardGamesUpdaterClient.bat"]);
				Sys.exit(0);
			#end
			
			buttonsIconsActive();

			Reg._at_menu_state = true;
		}
		
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "z1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			buttonsIconsActive();
		
			Reg._at_menu_state = true;
		}
		
		// answered yes when asked if should check for a newer version of a client software.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "z1020")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;				
			
			// get version number file from internet and compare it with this client's offline file, to determine if this client should shutdown for a software update.
			var _online = Internet.isWebsiteAvailable();
			if (_online == true)
			{
				Internet.webVersionFileExist();
						
				// if false then the version number from Internet.webVersionFileExist() function of the versionClient.txt at website passed the check An update was not needed. The value of Reg._doOnce is changed at Internet.webVersionFileExist().
				if (Reg._doOnce == false) 
				{
					canClientUpdate();
				}
				else
				{
					Reg._doOnce = false;
					noNewerSoftwareFoundMessages();
				}
			} 
			
			else 
			{
				// not connected to the internet message.
				cannotConnectToTheWebsite();
			}
			
			Reg._buttonCodeValues = "";
			buttonsIconsActive();
			
			Reg._at_menu_state = true;
		}
		
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "z1020")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
						
			buttonsIconsActive();
			
			Reg._at_menu_state = true;
		}
		
		// server connection error message.
		if (Reg._yesNoKeyPressValueAtMessage >= 1 && Reg._buttonCodeValues == "z1010")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			buttonsIconsActive();
			
			Reg._at_menu_state = true;
			Reg._at_menu_state = true;
		}
		
		// no recent version available when after clicking a button to check for an newer version of the software.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "z1030")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			buttonsIconsActive();
			
			Reg._at_menu_state = true;
		}
		
		// cannot message to the website. user closed this message box.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "z1040")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			buttonsIconsActive();
			
			Reg._at_menu_state = true;
		}
		
	}
	
	private function startupFunctions():Void
	{
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		if (__scene_background != null) remove(__scene_background);	
			__scene_background = new SceneBackground();
		add(__scene_background);
		
		if (Reg._at_menu_state_offline == true)
		{
			if (Reg.__menu_bar != null) remove(Reg.__menu_bar);
			Reg.__menu_bar = new MenuBar(true);
			add(Reg.__menu_bar);
		}
		
		// Get event data. only search the internet once, when event data is not populated.
		_client_online = Internet.isWebsiteAvailable();
		
		#if !html5	
			if (_client_online == true)
			{
				_software_new_check = new ButtonGeneralNetworkNo(15, FlxG.height - 40, "", 385, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, checkForNewSoftware, RegCustom._button_color[Reg._tn], false, 0);
				_software_new_check.label.text = "Check For New Software";
				_software_new_check.label.font = Reg._fontDefault;
				add(_software_new_check);
			}
			
			_button_scale_mode = new ButtonGeneralNetworkNo(_software_new_check.width + _software_new_check.x + 15, FlxG.height - 40, "Scale Mode", 360, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, scaleClicked, RegCustom._button_color[Reg._tn], false, 0);
			_button_scale_mode.label.font = Reg._fontDefault;
			add(_button_scale_mode);
			
			scaleModeLoad(); // change scale mode to the scale mode that was saved.
		#else
			_toggleFullscreen = new ButtonGeneralNetworkNo(15, FlxG.height - 40, "", 300, 35, Reg._font_size, 0xFFCCFF33, 0, full_screen_toggle, 0xFF000044, false);
			_toggleFullscreen.label.text = "Toggle Fullscreen";
			_toggleFullscreen.label.font = Reg._fontDefault;
			add(_toggleFullscreen);
		#end
	}
	
	public function scaleClicked():Void
	{
		scaleModeIndex = FlxMath.wrap(scaleModeIndex + 1, 0, scaleModes.length - 1);
		setScaleMode(scaleModes[scaleModeIndex]);

		RegFunctions._gameMenu.data.scaleModeIndex = scaleModeIndex - 1;

		// save data
		RegFunctions._gameMenu.flush();
		RegFunctions._gameMenu.close;
	}

	public function scaleModeLoad():Void
	{
		scaleModeIndex = FlxMath.wrap(scaleModeIndex + 1, 0, scaleModes.length - 1);
		setScaleMode(scaleModes[scaleModeIndex]);

		RegFunctions._gameMenu.data.scaleModeIndex = scaleModeIndex - 1;
		
		// save data
		RegFunctions._gameMenu.flush();
		RegFunctions._gameMenu.close;

	}
	
	private function checkForNewSoftware():Void
	{
		Reg._messageId = 3;
		Reg._buttonCodeValues = "z1020";		
		SceneGameRoom.messageBoxMessageOrder();
	}
	
	// try to connect to the server.
	public function tryToConnect():Void
	{
		#if html5
			RegCustom._profile_username_p1[CID3._CRN] = "Guest";
		
		#end
		
		Reg._alreadyOnlineHost = false;
		Reg._alreadyOnlineUser = false;
		RegTypedef.resetTypedefDataOnce(); RegTypedef.resetTypedefData();		
		RegTypedef.resetHouseData();
		Reg.system_reset(); 
		Reg2.system_reset();
		Reg.resetRegVarsOnce();
		Reg.resetRegVars();
		Reg2.resetRegVarsOnce();
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		RegTriggers.resetTriggers();
		Reg._game_offline_vs_cpu = false;
		Reg._game_offline_vs_player = false;
		Reg._gameId = -1;	 
	
		getIPaddressFromServerOrMain();
		
		#if !html5						
			// get version number file from internet and compare it with this client's offline file, to determine if this client should shutdown for a software update.
			var _online = Internet.isWebsiteAvailable();
			if (_online == true) Internet.webVersionFileExist();
			
			// if false then the version number from Internet.webVersionFileExist() function of the versionClient.txt at website passed the check An update was not needed. The value of Reg._doOnce is changed at Internet.webVersionFileExist().
		
			if (Reg._doOnce == false) 
			{
				canClientUpdate();
			}
			else
			{
				Reg._doOnce = false;
				
				serverConnectingErrorMessages();
								
			}
			
		#end
		
		#if html5
			RegTypedef._dataAccount._username = "bot ben";
			Reg._at_menu_state = false;
			FlxG.switchState(new PlayState());
				
		#end
	}

	private function getIPaddressFromServerOrMain():Void
	{
		Reg._ipAddress = Reg._ipAddressServerMain;
			
		#if html5
			Reg._useThirdPartyIpAddress = false;
		#elseif desktop
			if (Reg._useThirdPartyIpAddress == true && sys.FileSystem.exists(sys.FileSystem.absolutePath("config.txt")))
			{
				// if not using third party IP address then use main IP address.
				if (Reg._useThirdPartyIpAddress == true)
				{
					var temp = sys.io.File.getContent(sys.FileSystem.absolutePath("config.txt")).split(",");
					
					Reg._websiteNameTitle = temp[0];
					Reg._ipAddress = Reg._ipAddressServerOther = temp[1];
					Reg._port = Std.parseInt(temp[2]);
				}
			}
		#end
	}
	
	private function canClientUpdate():Void
	{
		// check to see if the IP address is paid because we may be using third party IP address. here we check the MySQL database table users for this IP address to see if it has a paid value.
		var _online = Internet.isWebsiteAvailable();
		if (_online == true)
		{
			var _bool = Internet.isServerDomainPaid(Reg._ipAddress);
						
			if (_bool == true)
			{
				// if we have the current version of the client software.
				if (Reg2._messageFileExists == Reg._version)
				{
					if (Reg._buttonCodeValues == "z1020")
						noNewerSoftwareFoundMessages();
					else
					{
						var _server_online = Internet.serverFileExist();
						
						#if !html5
							if (_server_online == true) 
							{
								Reg._at_menu_state = false;
								FlxG.switchState(new PlayState());
							}
							else
								serverConnectingErrorMessages();
						
						#else
							Reg._at_menu_state = false;
							FlxG.switchState(new PlayState());
						
						#end
						
					}
				}
				else clientUpdate();
			} 
			
			else return;
		}
	}
	
	private function clientUpdate():Void
	{	
		Reg._messageId = 1;
		Reg._buttonCodeValues = "z1000";
		SceneGameRoom.messageBoxMessageOrder();
				
		buttonsIconsNotActive();
	}
	
		
	private function serverConnectingErrorMessages():Void
	{
		Reg._messageId = 2;
		Reg._buttonCodeValues = "z1010";
		SceneGameRoom.messageBoxMessageOrder();
				
		buttonsIconsNotActive();
	}
	
	private function noNewerSoftwareFoundMessages():Void
	{
		Reg._messageId = 4;
		Reg._buttonCodeValues = "z1030";
		SceneGameRoom.messageBoxMessageOrder();
		
		buttonsIconsNotActive();
	}
	
	private function cannotConnectToTheWebsite():Void
	{
		Reg._messageId = 5;
		Reg._buttonCodeValues = "z1040";
		SceneGameRoom.messageBoxMessageOrder();
		
		buttonsIconsNotActive();
	}
	
	
	public function offlinePlayers():Void
	{
		RegTypedef.resetTypedefDataOnce();
		Reg.system_reset(); 
		Reg2.system_reset();
		Reg.resetRegVarsOnce(); 
		Reg.resetRegVars(); 
		Reg2.resetRegVarsOnce(); 
		Reg2.resetRegVars();
		RegCustom.resetRegVars();
		RegTriggers.resetTriggers();
		Reg._gameJumpTo = -1;
		Reg._game_offline_vs_player = false;
		Reg._at_menu_state = false;
		FlxG.switchState(new MenuStateOfflinePlayers());
	}
	
	public function gameHostFalse():Void
	{
		//############################# CODE BLOCK
		// remove this block of code when game is finished. also at PlayState, search for the keyword "finished" and remove the code blocks there.
		if (_str == "")
		{
			RegTypedef.resetTypedefDataOnce();
			Reg.resetRegVarsOnce();
			Reg.resetRegVars();
			Reg2.resetRegVarsOnce(); 
			Reg2.resetRegVars();
			RegCustom.resetRegVars();
			RegTriggers.resetTriggers();
			Reg._playerCanMovePiece = false;
			Reg._gameHost = false;
			Reg._game_offline_vs_cpu = false;
			Reg._game_offline_vs_player = false;
			Reg._gameId = -1;
			
			Reg._gameJumpTo = -1; 
			Reg._at_menu_state = false;
			FlxG.switchState(new PlayState());
		}
	}
	
	private function eventCurrentAndUpcoming():Void
	{
		var _offsetEventColumn1Y:Int = 29;
		var _offsetEventColumn2Y:Int = 54;
		var _offsetEventColumn3Y:Int = 79;
		
		// the background behind a calendar square. Each square can have three events on it. the location of the event text is called a column.
	 	var _bgEventColumn1Number:FlxSprite;
		var _bgEventColumn2Number:FlxSprite;
		var _bgEventColumn3Number:FlxSprite;
		
		// three events are displayed one after another on a event schedule current square.
		var _textEventColumn1Number:FlxText;
		var _textEventColumn2Number:FlxText;
		var _textEventColumn3Number:FlxText;
		
		// used to display the day number text and events text on the calendar.
		var _intCalendarCoordinateY:Float = _icon_text_title_description.y + 50;	 
		var _intCalendarCoordinateX:Float = _eventSchedulerBackground.x + 11;
	
		// calendar square event column 1 background offset.
	 	var _offsetBgColumnY:Int = 1;
		var _offsetBgColumnX:Int = -13;
		var _offsetUpcomingEventX:Int = 189; // this value moves the upcoming event text from the current column to the upcoming column.
	
		/******************************
		 * day starts at 1.
		 */
		var _intDay = Std.parseInt(DateTools.format(Date.now(), "%d"));
		
		/******************************
		 * month January starts at 0 not 1.
		 */
		var _intMonth = Std.parseInt(DateTools.format(Date.now(), "%m")) -1;	
		var _intYear = 	Std.parseInt(DateTools.format(Date.now(), "%Y"));
		
		var _textMonth:String = "";
		var _intDaysInMonth = EventSchedule.getDaysInMonth(_intMonth, _textMonth, _intYear);
		
		/******************************
		 * get only three events for the event schedule current position.
		 */
		var _eventNoMoreThanThree:Int = 0; 
				
		_textEventSchedule = new FlxText(0, 0, 0, "Event Schedule");
		_textEventSchedule.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_textEventSchedule.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textEventSchedule.setPosition(_intCalendarCoordinateX + _offsetBgColumnX + 72, 390 + _offset_icons_and__event_scheduler_y);
		_textEventSchedule.scrollFactor.set(0, 0);
		add(_textEventSchedule);
		
		var _textCurrent = new FlxText(0, 0, 0, "Current");
		_textCurrent.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_textCurrent.setPosition(225, 374 + 60 + _offset_icons_and__event_scheduler_y);
		_textCurrent.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textCurrent.scrollFactor.set();
		add(_textCurrent);
		
		var _textUpcoming = new FlxText(414, 374 + 60 + _offset_icons_and__event_scheduler_y, 0, "");
		_textUpcoming.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_textUpcoming.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_textUpcoming.scrollFactor.set();
		add(_textUpcoming);
		
		// find current event. 40 events are the max for this board game.
		for (i in 0...40) 
		{
			if (Reg2._eventDays[i][_intDay-1] == 1 && Reg2._eventMonths[i][_intMonth] == 1 && _eventNoMoreThanThree < 3)
			{
				if (_eventNoMoreThanThree == 0)
				{
					_bgEventColumn1Number = new FlxSprite(190 + _offset_current_x, 410 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y);
					_bgEventColumn1Number.makeGraphic(166, 25);
					_bgEventColumn1Number.scrollFactor.set(0, 0);	
					_bgEventColumn1Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
					add(_bgEventColumn1Number);
					
					_textEventColumn1Number = new FlxText(193 + _offset_current_x, 407 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y, 0, "");
					_textEventColumn1Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
					_textEventColumn1Number.scrollFactor.set();
					_textEventColumn1Number.fieldWidth = 152;
					_textEventColumn1Number.wordWrap = false;
					_textEventColumn1Number.text = Reg2._eventName[i];
					add(_textEventColumn1Number);
					_eventNoMoreThanThree += 1;
				}
				
				else if (_eventNoMoreThanThree == 1)
				{
					_bgEventColumn2Number = new FlxSprite(190 + _offset_current_x, 435 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y);
					_bgEventColumn2Number.makeGraphic(166, 25);
					_bgEventColumn2Number.scrollFactor.set(0, 0);	
					_bgEventColumn2Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
					add(_bgEventColumn2Number);
					
					_textEventColumn2Number = new FlxText(193 + _offset_current_x, 432 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y, 0, "");
					_textEventColumn2Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
					_textEventColumn2Number.scrollFactor.set();
					_textEventColumn2Number.fieldWidth = 152;
					_textEventColumn2Number.wordWrap = false;
					_textEventColumn2Number.text = Reg2._eventName[i];
					add(_textEventColumn2Number);
					
					_eventNoMoreThanThree += 1;
				}
				
				else if (_eventNoMoreThanThree == 2)
				{
					_bgEventColumn3Number = new FlxSprite(190 + _offset_current_x, 460 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y);
					_bgEventColumn3Number.makeGraphic(166, 25);
					_bgEventColumn3Number.scrollFactor.set(0, 0);	
					_bgEventColumn3Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
					add(_bgEventColumn3Number);
					
					_textEventColumn3Number = new FlxText(193 + _offset_current_x, 457 + 60 + _offset_current_y + _offset_icons_and__event_scheduler_y, 0, "");
					_textEventColumn3Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
					_textEventColumn3Number.scrollFactor.set();
					_textEventColumn3Number.fieldWidth = 152;
					_textEventColumn3Number.wordWrap = false;
					_textEventColumn3Number.text = Reg2._eventName[i];
					add(_textEventColumn3Number);
					
					_eventNoMoreThanThree += 1;
				}
			}
		}
		
		
		// reset var because we are doing a new search, this time for upcoming events.
		_eventNoMoreThanThree = 0;
		_intDay = Std.parseInt(DateTools.format(Date.now(), "%d")) + 1; // plus 1 because we are searching 1 day in the future.
		
		var _upcomingDay:Int = 0; // this is the upcoming day seen at program start.
		
		for (_month in 0...2) // search up to 6 months.)
		{
			// find upcoming event.
			for (ii in _intDay..._intDaysInMonth + 1)
			{
				for (i in 0...40) 
				{			
					if (Reg2._eventDays[i][ii-1] == 1 && Reg2._eventMonths[i][_intMonth] == 1 && _eventNoMoreThanThree < 3)
					{
						if (_eventNoMoreThanThree == 0)
						{
							_bgEventColumn1Number = new FlxSprite(379 + _offset_upcoming_x, 410 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y);
							_bgEventColumn1Number.makeGraphic(166, 25);
							_bgEventColumn1Number.scrollFactor.set(0, 0);	
							_bgEventColumn1Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
							add(_bgEventColumn1Number);
							
							_textEventColumn1Number = new FlxText(383 + _offset_upcoming_x, 407 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y, 0, "");
							_textEventColumn1Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
							_textEventColumn1Number.scrollFactor.set();
							
							_textEventColumn1Number.text = Reg2._eventName[i];
							_textEventColumn1Number.fieldWidth = 152;
							_textEventColumn1Number.wordWrap = false;
							add(_textEventColumn1Number);
							
							_eventNoMoreThanThree += 1;
							_upcomingDay = ii;
						}
						
						else if (_eventNoMoreThanThree == 1)
						{
							_bgEventColumn2Number = new FlxSprite(379 + _offset_upcoming_x, 435 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y);
							_bgEventColumn2Number.makeGraphic(166, 25);
							_bgEventColumn2Number.scrollFactor.set(0, 0);	
							_bgEventColumn2Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
							add(_bgEventColumn2Number);
							
							_textEventColumn2Number = new FlxText(383 + _offset_upcoming_x, 432 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y, 0, "");
							_textEventColumn2Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
							_textEventColumn2Number.scrollFactor.set();
							_textEventColumn2Number.text = Reg2._eventName[i];
							_textEventColumn2Number.fieldWidth = 152;
							_textEventColumn2Number.wordWrap = false;
							add(_textEventColumn2Number);
							
							_eventNoMoreThanThree += 1;
						}
						
						else if (_eventNoMoreThanThree == 2)
						{
							_bgEventColumn3Number = new FlxSprite(379 + _offset_upcoming_x, 460 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y);
							_bgEventColumn3Number.makeGraphic(166, 25);
							_bgEventColumn3Number.scrollFactor.set(0, 0);	
							_bgEventColumn3Number.color = EventSchedule.setBgRowColor(Reg2._eventBackgroundColour[i]);
							add(_bgEventColumn3Number);
							
							_textEventColumn3Number = new FlxText(383 + _offset_upcoming_x, 457 + 60 + _offset_upcoming_y + _offset_icons_and__event_scheduler_y, 0, "");
							_textEventColumn3Number.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
							_textEventColumn3Number.scrollFactor.set();			
							_textEventColumn3Number.text = Reg2._eventName[i];
							_textEventColumn3Number.fieldWidth = 152;
							_textEventColumn3Number.wordWrap = false;
							add(_textEventColumn3Number);
							_eventNoMoreThanThree += 1;
						}
						
						if (_eventNoMoreThanThree >= 3) break;
					}
					
					if (_eventNoMoreThanThree >= 3) break;
				}
				
				if (_eventNoMoreThanThree > 0) break;
			}
			
			if (_eventNoMoreThanThree > 0) break;
			
			_intDaysInMonth = EventSchedule.getDaysInMonth(_intMonth, _textMonth, _intYear);
			
			_intDay = 1; // if we are here then no event was found for this month. reset day back to 1 for the next month search.
			_intMonth += 1;
				
			if (_intMonth > 11) // value of 11 is December
			{
				_intMonth = 0;
				_intYear += 1;
			}			
			
		}	
		
		var _textMonth = EventSchedule.getMonthText(_intMonth, _textMonth);
		
		_textUpcoming.text = _textMonth + " " + _upcomingDay;
	}
	
	private function titleIcons():Void
	{
		_icon_text_title_description = new FlxText(0, 390 + _offset_icons_and__event_scheduler_y, 0, "Multiplayer Online. (World)");
				
		_icon_text_title_description.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_icon_text_title_description.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_icon_text_title_description.scrollFactor.set();
		add(_icon_text_title_description);	
		center_icon_text_to_icon_box();
		
		_group_sprite.splice(0, _group_sprite.length);
		
		// the icons background.
		var _icons_background = new FlxSprite(20, 120);
		_icons_background.loadGraphic("assets/images/iconsBackground.png");
		_icons_background.color = RegCustomColors.color_client_background();
		_icons_background.setPosition(_icon_offset_x - 11, 440 + _offset_icons_and__event_scheduler_y - 11);
		_icons_background.scrollFactor.set(0, 0);
		_icons_background.alpha = 0.50;
		add(_icons_background);
		
		var _icon_border_between_other_icons = new FlxSprite(_icons_background.x, _icons_background.y);
		_icon_border_between_other_icons.loadGraphic("assets/images/iconsBorder.png");
		//_icon_border_between_other_icons.color = FlxColor.RED;
		_icon_border_between_other_icons.scrollFactor.set(0, 0);
		add(_icon_border_between_other_icons);
				
		for (i in 0...6)
		{
			// add title here by increase the max number then go to titleMenu then go to the bottom of update(). 
			// all gameboards images are stored in frames.
			_sprite = new FlxSprite(20, 120);
			_sprite.loadGraphic("assets/images/icons.png", true, 64, 64);
			_sprite.color = RegCustomColors.client_text_color();
			_sprite.scrollFactor.set(0, 0);
			_sprite.updateHitbox();
			_sprite.visible = false;
			add(_sprite);	
			
			// add this member to _group_sprite.			
			_group_sprite.push(_sprite);
							
			// position this image on scene.
			var _y:Float = 0;
			var _x:Int = 0;
			
			if (i > 3 && i < 9)
			{
				_y = 79;
				_x = - 4;
			}
			
			_group_sprite[i].setPosition(_icon_offset_x - 2 + ((i + _x) * 79), 440 + _y - 2 + _offset_icons_and__event_scheduler_y);
			_group_sprite[i].animation.add(Std.string(i), [i], 30, false);
			_group_sprite[i].animation.play(Std.string(i));
			_group_sprite[i].visible = true;
			
			if (i == 2)
			{
				_group_sprite[2].alpha = 0.25;
			}			
			
			add(_group_sprite[i]);
		}
		
		// when clicking on a game image, this image has a border that highlighted it.
		// all gameboards images are stored in frames.
		_game_highlighted = new FlxSprite(_icon_offset_x - 2, 440 + _offset_icons_and__event_scheduler_y - 2);
		
		_game_highlighted.loadGraphic("assets/images/iconsHover.png", true, 66, 66); // height is the same value as width.
		_game_highlighted.scrollFactor.set(0, 0);
		_game_highlighted.animation.add("play", [0, 1], 10, true);
		_game_highlighted.animation.play("play");
		_game_highlighted.updateHitbox();
		add(_game_highlighted);
	}
	
	private function titleMenu(_num:Int):Void
	{		
		RegTriggers._buttons_set_not_active = false;
		
		if (_num == 0) tryToConnect();
		if (_num == 1) offlinePlayers();
		//if (_num == 2) TODO add something here;
		
		#if !html5
			if (_num == 3) 
			{
				Reg._at_menu_state = false;
				FlxG.switchState(new Configuration());
			}
		#end
		if (_num == 4) clientHelp();
		if (_num == 5) credits();
	}
	
	private function clientHelp():Void
	{
		Reg._messageId = 6;
		Reg._buttonCodeValues = "a1000";
		SceneGameRoom.messageBoxMessageOrder();
		
		buttonsIconsNotActive();
	}
	
	private function credits():Void
	{
		Reg._messageId = 20;
		Reg._buttonCodeValues = "a1100";
		SceneGameRoom.messageBoxMessageOrder();
		
		buttonsIconsNotActive();
	}
	
	// if client is not ready for release, at client title, buttons for BOT login are displayed. when clicking those buttons, the _data._username will be set to that button name. the reason for this is because when using fast login the IP address of the user is checked against the IP in the MySQL database, however, the BOT's all share the same IP. so logging in the second time cannot be achieved without those buttons at client. note that the buttons will not be display at release mode.
	
	// the above text is also at server.
	private function drawBOTbuttonsOnScene():Void	{		
		
		if (Reg._clientReadyForPublicRelease == false)
		{
			var _bot_text = new FlxText(15, 180, 0, "Click bot player button then click multiplayer online icon.");
			_bot_text.scrollFactor.set();
			_bot_text.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_bot_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
			add(_bot_text);	
			
			if (_bot_ben == null)
			{
				_bot_ben = new ButtonToggleFlxState(15, 230, 100, "Bot ben", 150, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, botUseBenOnline, RegCustom._button_color[Reg._tn], false);
				_bot_ben.label.font = Reg._fontDefault;
				add(_bot_ben);			
			}
			
			if (_bot_tina == null)
			{
				_bot_tina = new ButtonToggleFlxState(150+30, 230, 100, "Bot tina", 150, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, botUseTinaOnline, RegCustom._button_color[Reg._tn], false);
				_bot_tina.label.font = Reg._fontDefault;
				add(_bot_tina);		
			}
			
			if (_bot_piper == null)
			{
				_bot_piper = new ButtonToggleFlxState(300+45, 230, 100, "Bot piper", 150, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, botUsePiperOnline, RegCustom._button_color[Reg._tn], false);
				_bot_piper.label.font = Reg._fontDefault;
				add(_bot_piper);		
			}
			
			if (_bot_amy == null)
			{
				_bot_amy = new ButtonToggleFlxState(450+60, 230, 100, "Bot amy", 150, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, botUseAmyOnline, RegCustom._button_color[Reg._tn], false);
				_bot_amy.label.font = Reg._fontDefault;
				add(_bot_amy);			
			}
			
			if (_bot_zak == null)
			{
				_bot_zak = new ButtonToggleFlxState(600+75, 230, 100, "Bot zak", 150, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, botUseZakOnline, RegCustom._button_color[Reg._tn], false);
				_bot_zak.label.font = Reg._fontDefault;
				add(_bot_zak);
			}
			
			// add the none bot name as the last button displayed at this scene. the name is from the configuration menu. this list of names is only seen when application build is set to debug.
			if (RegCustom._profile_username_p1[CID3._CRN] != ""
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Guest2"
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot ben".toLowerCase()
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot tina".toLowerCase()
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot piper".toLowerCase()
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot amy".toLowerCase()
			&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot zak".toLowerCase()
			)
			{
				_profile_username_p1 = new ButtonToggleFlxState(750+90, 230, 100, RegCustom._profile_username_p1[CID3._CRN], 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, profile_username_p1, RegCustom._button_color[Reg._tn], false);
				_profile_username_p1.label.font = Reg._fontDefault;
				add(_profile_username_p1);
			}
			
			// this does the button toggle.
			if (Reg2._menu_state_username_p1 > -1)
			{
				switch (Reg2._menu_state_username_p1)
				{
					case 0: botUseBenOnline();
					case 1: botUseTinaOnline();
					case 2: botUsePiperOnline();
					case 3: botUseAmyOnline();
					case 4: botUseZakOnline();
					case 5: profile_username_p1();
				}
			}
			
			else
			{
				if (RegCustom._profile_username_p1[CID3._CRN] == "Bot ben".toLowerCase())
					botUseBenOnline();
				
				else if (RegCustom._profile_username_p1[CID3._CRN] == "Bot tina".toLowerCase())
					botUseTinaOnline();
				
				else if (RegCustom._profile_username_p1[CID3._CRN] == "Bot piper".toLowerCase())
					botUsePiperOnline();			
				
				else if (RegCustom._profile_username_p1[CID3._CRN] == "Bot amy".toLowerCase())
					botUseAmyOnline();
				
				else if (RegCustom._profile_username_p1[CID3._CRN] == "Bot zak".toLowerCase())
					botUseZakOnline();				
				
				else if (RegCustom._profile_username_p1[CID3._CRN] != ""
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Guest2"
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot ben".toLowerCase()
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot tina".toLowerCase()
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot piper".toLowerCase()
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot amy".toLowerCase()
				&&	RegCustom._profile_username_p1[CID3._CRN] != "Bot zak".toLowerCase()
				) 
					profile_username_p1();
				
			}
		}
	}
	
	private function bot_no_toggle():Void
	{		
		_bot_ben.has_toggle = false;
		_bot_ben.set_toggled(false);
		
		_bot_tina.has_toggle = false;
		_bot_tina.set_toggled(false);
		
		_bot_piper.has_toggle = false;
		_bot_piper.set_toggled(false);
		
		_bot_amy.has_toggle = false;
		_bot_amy.set_toggled(false);
		
		_bot_zak.has_toggle = false;
		_bot_zak.set_toggled(false);
		
		if (RegCustom._profile_username_p1[CID3._CRN] != ""
		&&	_profile_username_p1 != null)
		{
			_profile_username_p1.has_toggle = false;
			_profile_username_p1.set_toggled(false);
		}
	}
	
	private function botUseBenOnline():Void
	{		
		RegTypedef._dataAccount._username = "bot ben";
		Reg2._menu_state_username_p1 = 0;
		
		bot_no_toggle();
		_bot_ben.has_toggle = true;
		_bot_ben.set_toggled(true);
		
	}
	
	private function botUseTinaOnline():Void
	{
		RegTypedef._dataAccount._username = "bot tina";
		Reg2._menu_state_username_p1 = 1;
		
		bot_no_toggle();
		_bot_tina.has_toggle = true;
		_bot_tina.set_toggled(true);
		
	}
	
	private function botUsePiperOnline():Void
	{
		RegTypedef._dataAccount._username = "bot piper";
		Reg2._menu_state_username_p1 = 2;
		
		bot_no_toggle();
		_bot_piper.has_toggle = true;
		_bot_piper.set_toggled(true);
		
	}
	
	private function botUseAmyOnline():Void
	{
		RegTypedef._dataAccount._username = "bot amy";
		Reg2._menu_state_username_p1 = 3;
		
		bot_no_toggle();
		_bot_amy.has_toggle = true;
		_bot_amy.set_toggled(true);
		
	}
	
	private function botUseZakOnline():Void
	{
		RegTypedef._dataAccount._username = "bot zak";
		Reg2._menu_state_username_p1 = 4;
		
		bot_no_toggle();
		_bot_zak.has_toggle = true;
		_bot_zak.set_toggled(true);
		
	}
	
	private function profile_username_p1():Void
	{
		if (_profile_username_p1 != null)
		{
			RegTypedef._dataAccount._username = RegCustom._profile_username_p1[CID3._CRN];
			
			Reg2._menu_state_username_p1 = 5;
			
			bot_no_toggle();

			_profile_username_p1.has_toggle = true;
			_profile_username_p1.set_toggled(true);
		}
	}
	
	private function buttonsIconsActive():Void
	{
		_is_active = true;
		
		if (_eventSchedulerHover != null) _eventSchedulerHover.active = true;
		if (_game_highlighted != null) _game_highlighted.active = true;
		
		for (i in 0...6)
		{
			_group_sprite[i].active = true;
		}
		
	}
	
	private function buttonsIconsNotActive():Void
	{
		_is_active = false;
		
		if (_eventSchedulerHover != null) _eventSchedulerHover.active = false;
		if (_game_highlighted != null) _game_highlighted.active = false;
		
		for (i in 0...6)
		{
			_group_sprite[i].active = false;
		}
		
	}
	
	private function center_icon_text_to_icon_box():Void
	{
		_icon_text_title_description.screenCenter(X);
		_icon_text_title_description.x += 330;
	}
	
	static function setExitHandler(_exit:Void->Void):Void 
	{
		#if openfl_legacy
		openfl.Lib.current.stage.onQuit = function() {
			_exit();
			openfl.Lib.close();
		};
		#else
		openfl.Lib.current.stage.application.onExit.add(function(code) {
			_exit();
		});
		#end
	}	
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		//if (FlxG.mouse.justPressed == true) FlxG.fullscreen = true;
		
		if (_ticks_startup < 20) _ticks_startup += 1;
		
		if (_ticks_startup == 1)
		{
			startupFunctions();
			drawBOTbuttonsOnScene();
			chess_skill_level_setup();
			
			if (_client_online == true)
			{
				if (Reg2._eventName[0] == "") Internet.getAllEvents();
				if (Reg2._eventName[0] == "") Internet.getAllEvents();
				if (Reg2._eventName[0] == "") Internet.getAllEvents();	
			}
				
			Reg._hasUserConnectedToServer = false;
			Reg._notation_output = true;
			
			if (Reg.__title_bar != null) remove(Reg.__title_bar);
			Reg.__title_bar = new TitleBar(Reg._websiteNameTitle);
			add(Reg.__title_bar);
			
			_clicked = false; // the sound does not play for the icons the first time. this is the fix.
			
			titleIcons();
			
			if (_button_b1.has_toggle == true)
				RegCustom._chess_skill_level_online = 0;
			
			if (_button_b2.has_toggle == true)
				RegCustom._chess_skill_level_online = 1;
			
			if (_button_b3.has_toggle == true)
				RegCustom._chess_skill_level_online = 2;
			
			_text_version_display = new FlxText(0, 0, 0, "V" + Reg._version);
			_text_version_display.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			_text_version_display.scrollFactor.set();
						
			if (Reg._websiteNameTitle != Reg._websiteNameTitleCompare)
			{
				_text_version_display.text = "Powered by " + Reg._websiteNameTitleCompare + ". " + _text_version_display.text;				
			}
			
			_text_version_display.setPosition(FlxG.width - _text_version_display.fieldWidth - 15, FlxG.height - 40);
			add(_text_version_display);	
			
			if (Reg._clientReadyForPublicRelease == false)
			{
				__action_commands = new ActionCommands(); 
				add(__action_commands);
			} 
			
			Reg._gameJumpTo = 0;
			
			_ticks_startup = 30;
		}
		
		// normal update() stuff.
		if (_ticks_startup == 30)
		{			
			if (Reg2._eventName[0] != ""
			&&	_ticks_internet == 0
			&&	Reg._buttonCodeValues == "")
			{
				_ticks_internet = 1;
				draw_event_scheduler();
			}
			
			if (Reg._buttonCodeValues != "") buttonCodeValues();
		
			// every time a user connects to the server, the server create a file with the name of the users host name. If the host name matches the name of the file, in the host directory at server, then that means there is already a client opened at that device. Therefore do the following.
			if (Reg._clientDisconnected == true 
			||  Reg._displayOneDeviceErrorMessage == true
			||  Reg._cannotConnectToServer == true
			||  Reg._serverDisconnected == true 
			||  RegTriggers._kickOrBan == true 
			||  Reg._isThisServerPaidMember == false 
			||  Reg._hostname_message == true 
			||  Reg._ip_message == true 
			||  Reg._login_failed == true
			||	Reg._username_restricted == true)
			{

				if (Reg._clientDisconnected == true)
					_str = "Client disconnected from server because of player inactivity.";
				
				else if (Reg._cannotConnectToServer == true) 	
					_str = "Cannot connect to server. Check the website to see if the server is online. Are you in airplane mode?"; //"This server will shutdown after 30 minutes expires because of server and/or client maintenance. Check the website for more information.";// 

				else if (RegTriggers._kickOrBan == true)	
					_str = Reg._kickOrBanMessage;

				else if (Reg._serverDisconnected == true)	
					_str = "Server either disconnected or dropped client.";

				else if (Reg._alreadyOnlineUser == true)	
					_str = "You cannot log in twice using the same username.";
				
				else if (Reg._alreadyOnlineHost == true)	
					_str = "You cannot log in twice using the same device.";
				
				else if (Reg._isThisServerPaidMember == false)
					_str = "The server " + Reg._ipAddress + " is not active. Try a different server.";
				
				else if (Reg._hostname_message == true)
					_str = "Failed to get your hostname. Is the web server online?";
				
				else if (Reg._ip_message == true)
					_str = "Failed to get the ip from the website address. Is the website online?";
					
				else if (Reg._login_failed == true) 
					_str = "Login failed. Verify your username and password at the configuration menu. Note, your selected username could be restricted.";
					
				else if (Reg._username_restricted == true)
					_str = "Login rejected because your username has a bad word or a reserved word.";
				Reg._messageId = 10;
				Reg._buttonCodeValues = "m1000";
				SceneGameRoom.messageBoxMessageOrder();
				
				buttonsIconsNotActive();
				
				Reg._clientDisconnected = false;
				Reg._displayOneDeviceErrorMessage = false;
				Reg._cannotConnectToServer = false;
				Reg._serverDisconnected = false;
				Reg._alreadyOnlineHost = false;
				Reg._alreadyOnlineUser = false;
				Reg._isThisServerPaidMember = true;
				Reg._kickOrBanMessage = "";
				RegTriggers._kickOrBan = false;
				Reg._hostname_message = false;
				Reg._ip_message = false;
				Reg._login_failed = false;				
				Reg._username_restricted = false;
				RegTypedef._dataAccount._username_restricted = "";
			}

			// this block of code is needed so that the connect button will try to connect again.
			if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "m1000")
			{
				Reg._yesNoKeyPressValueAtMessage = 0;
				Reg._buttonCodeValues = "";
				
				buttonsIconsActive();
			}
			
			if (_eventSchedulerHover != null)
			{
				if (Reg._gameJumpTo == 0)
				{
					_eventSchedulerHover.visible = false;
					
					if (ActionInput.overlaps(_eventSchedulerHover)
					&&	_eventSchedulerHover.active == true)
					{			
						_eventSchedulerHover.visible = true;
					}
						
					if (ActionInput.overlaps(_eventSchedulerHover) 
					&& ActionInput.justPressed() == true
					&& _is_active == true
					)
					{
						if (RegCustom._sound_enabled[Reg._tn] == true
						&&	Reg2._scrollable_area_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
					
						if (_eventSchedulerHover != null) _eventSchedulerHover.active = false;					
							buttonsIconsNotActive();
						
						Reg._at_menu_state = false;
						FlxG.switchState(new EventSchedule());
					}
				}
			}
		
		
			
			if (RegTriggers._mainStateMakeActiveElements == true)
			{
				RegTriggers._mainStateMakeActiveElements = false;				
				buttonsIconsActive();
			}
							
			if (_group_sprite.length > 0)
			{
				for (i in 0... 6)
				{
					if (ActionInput.overlaps(_group_sprite[i]) == true
					&&  _group_sprite[i].active == true
					)
					{
						var _y:Float = 0;
						var _x:Int = 0;
						
						if (i > 3 && i < 9)
						{
							_y = 79;
							_x = - 4;
						}
						
						_group_sprite[i].setPosition(_icon_offset_x - 2 + ((i + _x) * 79), 440 + _y - 2 + _offset_icons_and__event_scheduler_y);
						_game_highlighted.setPosition(_icon_offset_x - 2 + ((i + _x) * 79), 440 + _y - 2 + _offset_icons_and__event_scheduler_y);
						_game_highlighted.visible = true;
							
						if (i == 0) 
							_icon_text_title_description.text = "Multiplayer Online. (World)";
						if (i == 1)
							_icon_text_title_description.text = "Offline (Player vs Player)";
						if (i == 2)
							_icon_text_title_description.text = "Nothing here yet.";
						if (i == 3)
							_icon_text_title_description.text = "Configuration Menu. (Gear)";
						if (i == 4)
							_icon_text_title_description.text = "Client Help. (Question)";
						if (i == 5)
							_icon_text_title_description.text = "Credits. (Attribution)";

						center_icon_text_to_icon_box();
						// next go to the next for() code block above this for() code.
					}
				}
			}			
			
			// hide the gear configuration icon if true.
			#if html5
				//_group_sprite[0].active = false;
				//_group_sprite[0].alpha = 0.25;
				
				_group_sprite[2].active = false;
				_group_sprite[2].alpha = 0.25;
				
				_group_sprite[3].active = false;
				_group_sprite[3].alpha = 0.25;
			#end
			
			if (ActionInput.justPressed() == true
			&& _group_sprite.length > 0)
			{		
				for (i in 0... 6)
				{
					if (ActionInput.overlaps(_group_sprite[i]) == true
					&&  _group_sprite[i].active == true
					&&	RegTriggers._buttons_set_not_active == false)
					{
						if (RegCustom._sound_enabled[Reg._tn] == true
						&&	Reg2._scrollable_area_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
					
						_clicked = true;
					}
				}
			}
			
			else if (ActionInput.justReleased() == true
			&&  _group_sprite.length > 0
			&&  _clicked == true)
			{
				for (i in 0... 6)
				{
					if (ActionInput.overlaps(_group_sprite[i]) == true
					&&  _group_sprite[i].active == true
					&&	RegTriggers._buttons_set_not_active == false)
						titleMenu(i);
				}
			}
		}
		
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "a1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			FlxG.openURL("https://kboardgames.com/index.php?p=30","_blank"); 
			
			buttonsIconsActive();
		}
	
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "a1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonsIconsActive();
		}
		
		// view the credits page.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "a1100")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			FlxG.openURL("https://kboardgames.com/index.php?p=31","_blank"); 
			
			buttonsIconsActive();
		}
		
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "a1100")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			buttonsIconsActive();
		}
		
		// should message box be displayed?
		if (Reg._messageId > 0 && Reg._messageId != 1000000
		&&	RegTriggers._buttons_set_not_active == false)
		{
			var _msg = new IdsMessageBox();
			add(_msg);
		}
		
		super.update(elapsed);
		
		/*
		#if !html5
			if (FlxG.mouse.justPressed == true)
			{
				if (_sound_channel != null)
					_sound_channel.stop();
			}
		#end
		*/
	}
}//

@:enum
abstract ScaleMode(String) to String
{
	var RELATIVE = "relative 95%";
	var RATIO_DEFAULT = "ratio";
	var RATIO_FILL_SCREEN = "screenfill)";
	var FILL = "fill";
}