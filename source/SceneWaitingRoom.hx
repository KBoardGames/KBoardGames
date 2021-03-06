/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * invite, start game, chat.
 * @author kboardgames.com
 */

// RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room], // 0 = empty, 1 computer game, 2 creating room, 3 = firth player waiting to play game. 4 = second player in waiting room. 5 third player in waiting room if any. 6 - forth player in waiting room if any. 7 - room full, 8 - playing game / waiting game.
class SceneWaitingRoom extends FlxState 
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar; 
	
	private var __player_kick_or_ban_players:PlayerKickOrBanPlayers;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	/******************************
	 * moves everything up by these many pixels.
	 */
	private var _offset_y:Int = -770;
	
	public var _invite_table:InviteTable;
	private var _ticksOnlineList:Float = 0;
		
	/******************************
	 * player 1 is the user that created the room. player 2-4 is the user that joined the waiting room.
	 */
	public static var _text_player_stats:Array<FlxText> = [];
	
	/******************************
	 * compare this array with Reg.usernames. it false then usernames has changed. this var is used to get stats when false.
	 */
	private var _usernamesDynamic:Array<String> = ["", "", "", ""];
	
	/******************************
	 * instance of GameChatter.
	 */
	public static var __game_chatter:GameChatter;	
	
	// background underneath the stats.
	private var bodyBg:FlxSprite;
	public var __scrollable_area:FlxScrollableArea;
	
	/******************************
	 * scene color
	 */
	public var _color:FlxColor;
	
	/******************************
	 * random value for scene color.
	 */
	public var _color_ra:Int = 0;
	
	public function new() 
	{
		super();
		
		RegFunctions.fontsSharpen();
		
		_color_ra = FlxG.random.int(1, 335);
		_color = FlxColor.fromHSB(_color_ra, 0.75, RegCustom._client_background_brightness[Reg._tn]);
		
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			_color = FlxColor.fromHSB(RegCustomColors.color_client_background().hue, RegCustom._client_background_saturation[Reg._tn], RegCustom._client_background_brightness[Reg._tn]);
		}
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		__scene_background = new SceneBackground();
		add(__scene_background);
		
		// creates the invite table and also sends the invite request to the server.
		if (_invite_table != null)
		{
			remove(_invite_table);
			_invite_table.destroy();
		}
		
		_invite_table = new InviteTable(this);
		add(_invite_table);
		
		// background underneath the stats.
		if (bodyBg != null)
		{
			remove(bodyBg);
			bodyBg.destroy();
		}
		
		bodyBg = new FlxSprite(0, FlxG.height / 1.65 + 85);
		bodyBg.makeGraphic(FlxG.width - 370 - 20, FlxG.height);
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
			bodyBg.makeGraphic(FlxG.width, FlxG.height);
		
		bodyBg.scrollFactor.set(0, 0);
		bodyBg.color = _color;
		bodyBg.alpha = 0.9;
		add(bodyBg);
		
		Reg._buttonCodeValues = "";
		Reg._yesNoKeyPressValueAtMessage = 0;
					
		Reg._keyOrButtonDown = false;
		Reg._gameHost = true;
		
		__player_kick_or_ban_players = new PlayerKickOrBanPlayers();
		add(__player_kick_or_ban_players);
		
		// the user that created the chat. displayed at the bottom of the user list.
		for (i in 0... 4)
		{
			if (_text_player_stats[i] != null)
			{
				remove(_text_player_stats[i]);
				_text_player_stats[i].destroy();
			}
			
			if (i == 0) _text_player_stats[i] = new FlxText(60, 603, 0, "", 24);
			if (i == 1) _text_player_stats[i] = new FlxText(280, 603, 0, "", 24);
			if (i == 2) _text_player_stats[i] = new FlxText(500, 603, 0, "", 24);
			if (i == 3) _text_player_stats[i] = new FlxText(720, 603, 0, "", 24);
			
			_text_player_stats[i].setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
			if (RegCustom._chat_when_at_room_enabled[Reg._tn] == false)
				_text_player_stats[i].x += 180; // half of 360 is the width of chatter. half is used to center it to scene.
			_text_player_stats[i].scrollFactor.set(0, 0);
			add(_text_player_stats[i]);
		}
		
	}
	
	public function initialize():Void
	{
		Reg._at_waiting_room = true;
		scrollable_area();
		
		_invite_table._title_background_large.color = _color;
		bodyBg.color = _color;
		
		if (RegTypedef._dataTournaments._move_piece == false)
			Reg._move_number_next = 0;
		
		Reg._currentRoomState = RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room];
		Reg._gameId = RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room];
				
		var _gameName = RegFunctions.gameName(RegTypedef._dataMisc._roomGameIds[RegTypedef._dataMisc._room]);
		RegTypedef._dataPlayers._gameName = _gameName;	
		
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Room " + Std.string(RegTypedef._dataMisc._room ) + " - " + _gameName);
		add(__title_bar);
		
		if (__menu_bar != null) 
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar(false, false, null, null);
		add(__menu_bar);
		
		// computer resources are at a maximum when populating the user online list. clicking these buttons at that time would not trigger an event. so hide them until all fields are populated.
		__menu_bar._button_return_to_lobby_from_waiting_room.visible = false;
		__menu_bar._button_return_to_lobby_from_waiting_room.active = false;
		
		__menu_bar._button_refresh_list.visible = false;	
		__menu_bar._button_refresh_list.active = false;
		
		__menu_bar._buttonGameRoom.visible = false;
		__menu_bar._buttonGameRoom.active = false; 
		
		RegTypedef._dataPlayers._username = RegTypedef._dataAccount._username;
	
		addRemovePlayerCheck(); 
		
		PlayState.allTypedefRoomUpdate(RegTypedef._dataMisc._room);
		
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
		{
			if (__game_chatter != null) 
			{
				remove(__game_chatter);
				__game_chatter.destroy();
			}
			
			__game_chatter = new GameChatter(5);
			__game_chatter.visible = false;
			GameChatter.__scrollable_area3.visible = false;
			GameChatter.__scrollable_area3.active = false;
			GameChatter._groupChatterScroller.x = 0;
			add(__game_chatter);
		}
		
		RegTriggers._jump_waiting_room = false;
	}
		
	public function scrollable_area():Void
	{
		if (RegCustom._chat_when_at_room_enabled[Reg._tn] == true)
		{
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)	
			if (__scrollable_area != null) 
			{
				FlxG.cameras.remove(__scrollable_area);
				__scrollable_area.destroy();
			}
			
			__scrollable_area = new FlxScrollableArea( new FlxRect(0, 0, 1410-370, FlxG.height - 50), new FlxRect(0, 0, 1410, 8800), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0);	
		}
		
		else
		{
			if (__scrollable_area != null)
			{
				FlxG.cameras.remove(__scrollable_area);
				__scrollable_area.destroy();
			}
			
			__scrollable_area = new FlxScrollableArea( new FlxRect(0, 0, 1400, FlxG.height - 50), new FlxRect(0, 0, 1400, 8800), ResizeMode.FIT_WIDTH, 0, 100, -1, FlxColor.LIME, null, 0);	
		}
	
		FlxG.cameras.add( __scrollable_area );
		__scrollable_area.antialiasing = true;
		__scrollable_area.pixelPerfectRender = true;
		
		__scrollable_area.content.y = 770;
	}
	
	public function addRemovePlayerCheck():Void
	{	
		RegTypedef._dataPlayers._usernamesDynamic[0] = "";
		RegTypedef._dataPlayers._usernamesDynamic[1] = "";
		RegTypedef._dataPlayers._usernamesDynamic[2] = "";
		RegTypedef._dataPlayers._usernamesDynamic[3] = "";
		
		PlayState.allTypedefRoomUpdate(RegTypedef._dataMisc._room);

		PlayState.send("Get Room Players", RegTypedef._dataMisc);		
	}
	
	/******************************
	 * if player left a game and there is still enough players to continue playing the game, then a username was removed from RegTypedef._dataPlayers._usernamesDynamic. the stats for the other players will be reloaded the next time server is called to update them.
	 */
	public static function updateUsersInRoom():Void
	{
		var _count:Array<String> = [""];
		_count.pop();
		
		for (i in 0...RegTypedef._dataPlayers._moveTimeRemaining.length)
		{
			if (RegTypedef._dataPlayers._moveTimeRemaining[i] == 0)
			{
				RegTypedef._dataPlayers._moveTimeRemaining.pop();
			}
		}
	
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "")
				_count.push(RegTypedef._dataPlayers._usernamesDynamic[i]);
				
			if (RegTypedef._dataPlayers._moveTimeRemaining.length-1 < i)
				RegTypedef._dataPlayers._moveTimeRemaining.push(0);
		}
			
		for (i in 0..._count.length)
		{
			if (_count[i] == Std.string(RegTypedef._dataMisc._username)) // username found
			{
				Reg._move_number_current = i; // a value of 0 means this player moves first where as a value of 1 means this player moves after the first player moves.
				RegTypedef._dataPlayers._moveNumberDynamic[i] = i;
				
				if (Reg._gameHost == true
				&&	Reg._move_number_current == 0
				&&	_count.length > 1
				&&	RegCustom._pager_enabled[Reg._tn] == true)
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._scrollable_area_is_scrolling == false)
						FlxG.sound.playMusic("pager", 1, true);
				}
			}
		}
	}
	
	/******************************
	 * display the usernames, stats and all buttons
	 */
	public function mainButtonsAndTexts():Void
	{
		// set the roomState based on how many players are in the room.
		var _count2:Int = 0;
		
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "" && RegTypedef._dataPlayers._actionWho == "") _count2 += 1;
		}
		
		if (_count2 > 0)
		{
			RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room] = _count2 + 1;
			Reg._currentRoomState = RegTypedef._dataMisc._roomState[RegTypedef._dataMisc._room];
		}
		
		var _count:Int = 0;
		
		// only the first player that entered the room can start a game.
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "") _count += 1;
		}		
		
		// display the username at the room.
		if (RegTypedef._dataPlayers._usernamesDynamic[0] != "")
		{
			// this var will be used to determine when its a different users turn to move. this var is in reference to, _move_number_next.
			RegTypedef._dataPlayers._moveNumberDynamic[0] = 0;
			
			_text_player_stats[0].text = "Wins " + RegTypedef._dataPlayers._gamesAllTotalWins[0] + "\nLosses " + RegTypedef._dataPlayers._gamesAllTotalLosses[0] + "\nDraws " + RegTypedef._dataPlayers._gamesAllTotalDraws[0];
			
			Reg._totalPlayersInRoom = 0;
			//Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._currentRoomState = 2;
			
			// this block will save the host to database.
			var _tempUser:String = RegTypedef._dataMisc._username;
			RegTypedef._dataMisc._username = RegTypedef._dataPlayers._usernamesDynamic[0];
			
			if (RegTypedef._dataPlayers._username == RegTypedef._dataPlayers._usernamesDynamic[0])
				PlayState.send("Is Host", RegTypedef._dataMisc);
			
			RegTypedef._dataMisc._username = _tempUser;
			
		} else if (RegTypedef._dataPlayers._usernamesDynamic[0] == "" && Reg._buttonCodeValues != "p1000") // player does not exist so delete button.
		_text_player_stats[0].text = "";
		
		// draw player 2-4 stats to scene.
		for (i in 1... 4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "" && RegTypedef._dataPlayers._actionWho != RegTypedef._dataPlayers._usernamesDynamic[i])
			{
				RegTypedef._dataPlayers._moveNumberDynamic[i] = i;
				
				_text_player_stats[i].text = "Wins " + RegTypedef._dataPlayers._gamesAllTotalWins[i] + "\nLosses " + RegTypedef._dataPlayers._gamesAllTotalLosses[i] + "\nDraws " + RegTypedef._dataPlayers._gamesAllTotalDraws[i];
				
				Reg._totalPlayersInRoom = i;
				Reg._currentRoomState = (i + 2);
			} 
			
			// player does not exist so delete button.
			else if (RegTypedef._dataPlayers._usernamesDynamic[i] == "" && Reg._buttonCodeValues != "p1000") 			
				_text_player_stats[i].text = "";
		}

		if (_count > 1) // if there are more than one player in room then make start game visible
		{
			if (Reg._currentRoomState > 2 && Std.string(RegTypedef._dataAccount._username) == Std.string(RegTypedef._dataPlayers._usernamesDynamic[0])
			&& RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] == _count) // actionNumber is 0 if nobody in room is kicked or banned, etc.
			{	
				if (Reg._currentRoomState == 3 && _text_player_stats[0].text != ""
				||  Reg._currentRoomState == 4 && _text_player_stats[1].text != ""
				||  Reg._currentRoomState == 5 && _text_player_stats[2].text != ""
				||  Reg._currentRoomState == 6 && _text_player_stats[3].text != "")
				{
					__menu_bar._buttonGameRoom.active = true;
					__menu_bar._buttonGameRoom.visible = true;
					
					if (RegTriggers._jump_game_room == true)
					{
						RegTriggers._jump_game_room = false;
						Reg._buttonCodeValues = "r1001";
						Reg._yesNoKeyPressValueAtMessage = 1;
					}
				}
			}
			
			else if (Reg._buttonCodeValues != "p1000") // player does not exist so delete button.
			{
				__menu_bar._buttonGameRoom.visible = false;
				__menu_bar._buttonGameRoom.active = false;
			}
				
						
			if (Reg._currentRoomState >= 2 && Std.string(RegTypedef._dataAccount._username) != Std.string(RegTypedef._dataPlayers._usernamesDynamic[0]) && RegTypedef._dataPlayers._actionWho == "")
			{
				__menu_bar._buttonGameRoom.visible = false;
				__menu_bar._buttonGameRoom.active = false;	
			}
			
		}
		else
		{		
			// only one player is in room.
			__menu_bar._buttonGameRoom.visible = false;					
			__menu_bar._buttonGameRoom.active = false;	
		}

	}
	
	private function buttonCodeValues():Void
	{
			
		// did user confirm the enter game room at the message popup. if so then run this code.
		if (Reg._yesNoKeyPressValueAtMessage == 1 &&  Reg._buttonCodeValues == "r1001")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._gameOverForPlayer = true;
			Reg._gameOverForAllPlayers = true;
			Reg._gameHost = true;
			
			RegTypedef._dataMisc._gameRoom = true;
			
			RegTypedef._dataMisc._roomCheckForLock[RegTypedef._dataMisc._room] = 0;
			
			PlayState.send("Greater RoomState Value", RegTypedef._dataMisc); 			
			
			__scrollable_area.visible = false;
			__scrollable_area.active = false;
			
			Reg._totalPlayersInRoom = RegTypedef._dataMisc._roomPlayerLimit[RegTypedef._dataMisc._room] - 1;
			
			PlayState.send("Enter Game Room", RegTypedef._dataMisc); // pass the start game var to this event since this event gives the data to the other user at this chat.			
			
			RegTypedef._dataPlayers._gamePlayersValues = [0, 0, 0, 0];
						
			// stop any sound playing.			
			//if (FlxG.sound.music != null && FlxG.sound.music.playing == true) FlxG.sound.music.stop();
			
			for (i in 0... 4)
			{
				_text_player_stats[i].text = "";
			}
			
			Reg._createGameRoom = true;
		}
		
		// start game canceled.
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "r1001")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		}
		
		
		// leave __scene_waiting_room
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "r1004")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			__scrollable_area.visible = false;
			__scrollable_area.active = false;
			
			PlayState.send("Lesser RoomState Value", RegTypedef._dataMisc);
			
			//addRemovePlayerCheck();
			
			Reg._at_create_room = false;
			Reg._at_waiting_room = false;
			Reg._gameRoom = false;
			Reg._rememberChatterIsOpen = false;
			Reg._lobbyDisplay = false;
			
			for (i in 0... 4)
			{
				_text_player_stats[i].text = "";
			}
			
			Reg._gameHost = true;
			
			RegTypedef._dataPlayers._room = 0;
			
			if (Reg._displayActionMessage == true)
			{	
			// go to PlayState to display the action message.
				Reg._displayActionMessage = false;
				RegTriggers._actionMessage = true;
			}
			
			RegTriggers._lobby = true;
			
		}
		
		// leave room cancelled. game has not been started yet. 
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "r1004")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		}

		
	}
		
	override public function destroy()
	{
		if (__player_kick_or_ban_players != null)
		{
			remove(__player_kick_or_ban_players);
			__player_kick_or_ban_players.destroy();
			__player_kick_or_ban_players = null;
		}
			
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
			__scene_background = null;
		}
		
		for (i in 0... 4)
		{
			if (_text_player_stats[i] != null) 
			{
				remove(_text_player_stats[i]);
				_text_player_stats[i].destroy();
				_text_player_stats[i]= null;
			}
		}
		
		if (bodyBg != null) 
		{
			remove(bodyBg);
			bodyBg.destroy();
			bodyBg = null;
		}
		
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
			__title_bar = null;
		}
		
		if (__menu_bar != null) 
		{
			remove(__menu_bar);
			__menu_bar.destroy();
			__menu_bar = null;
		}
		
		if (_invite_table != null)
		{
			remove(_invite_table);
			_invite_table.destroy();
		}
		
		if (__game_chatter != null)
		{
			remove(__game_chatter);
			__game_chatter.destroy();
		}
		
		if (__scrollable_area != null)
		{
			cameras.remove( __scrollable_area );
			__scrollable_area.destroy();			
			__scrollable_area = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._at_waiting_room == false) return; 
		
		// send the offset of the scrollable area to the button class so that when scrolling the scrollable area, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
			ButtonGeneralNetworkYes._scrollarea_offset_x = __scrollable_area.scroll.x;
			ButtonGeneralNetworkYes._scrollarea_offset_y = __scrollable_area.scroll.y;
		
		// TODO make this code everywhere that's needed, such as at SceneGameRoom.hx.
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		super.update(elapsed);
	}
}