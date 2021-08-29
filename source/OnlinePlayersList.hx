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

class OnlinePlayersList extends FlxState
{
	/******************************
	* the title of this state.
	*/
    public var _title:FlxText;
	public var _title_background:FlxSprite;
	
	/******************************
	 * moves everything up by these many pixels.
	 */
	private var _offset_y:Int = 35;
	
	// used at the invite table seen at __scene_waiting_room.
	public var _onlineUserListUsernames:OnlinePlayersText;
	public var _onlineUserListInvite:ButtonGeneralNetworkYes;
	public var _chess_elo:OnlinePlayersText;
	public var _textPoints:OnlinePlayersText;
	public var _textPercentage:OnlinePlayersText;
	public var _textWins:OnlinePlayersText;
	public var _textLosses:OnlinePlayersText;
	public var _textDraws:OnlinePlayersText;
		
	/******************************
	* anything added to this group will be placed inside of the scrollbar field. 
	*/
	public var group:FlxSpriteGroup;	
	
	
	public var __scene_waiting_room:SceneWaitingRoom; 
	
	public var _onlinePlayersListTicks:Int = 0;
	
	
	public static var _didPopulateList:Bool = false; // do not new FlxText or button the second time. only one field at a coordinate permitted.
	
	public static var _doOnce:Bool = false;
	
	public function new (scene_waiting_room:SceneWaitingRoom)
	{
		super();
		
		RegFunctions.fontsSharpen();
		
		_didPopulateList = false;
		_doOnce = false;
		
		__scene_waiting_room = scene_waiting_room;
		

		var _color_table_rows = FlxColor.fromHSB((__scene_waiting_room._color_ra+25), 0.8, 0.15);
		
		group = cast add(new FlxSpriteGroup());
				
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width - 50, 110);
		_title_background.color = __scene_waiting_room._color;
		add(_title_background);
		
		_title = new FlxText(0, 20, 0, "");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_title.screenCenter(X);
		_title.visible = true;
		add(_title);	
		
		// scroll area bg.
		var bg2 = new FlxSprite(0, 0);
		bg2.makeGraphic(FlxG.width - 80, 7100, 0xCC000000);		
		bg2.scrollFactor.set(0, 0);
		group.add(bg2);
			
		
		// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 120 loops will be made. 
		for (i in 1...121)
		{
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(FlxG.width - 90, 55, _color_table_rows);		
			slotBox.setPosition(20, 135 - _offset_y + (i * 70)); 
			slotBox.scrollFactor.set(0, 0);
			group.add(slotBox);
		}		
		
		// without this code the buttons A and B would not be seen and scrollbar cannot scroll them on screen.
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(FlxG.width - 80, 400, 0xFF000000);		
		slotBox.setPosition(20, 135 - _offset_y + (121 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		//.....................................
		// a black bar between table rows.
		// first column border. columns are minus 20 from Header column text.
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (121 * 70), 0xFF000000);		
		slotBox.setPosition(295, 85 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		// before chess Elo
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (121 * 70), 0xFF000000);		
		slotBox.setPosition(520, 85 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		// before points.
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (121 * 70), 0xFF000000);		
		slotBox.setPosition(700, 85 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		
		// before win percentage
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (121 * 70), 0xFF000000);		
		slotBox.setPosition(940, 85 - _offset_y + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		group.add(slotBox);
		//.....................................
	
	}
	
	public function populateOnlineList(i:Int):Void
	{
		//.......................
		if (_didPopulateList == false && RegTypedef._dataOnlinePlayers._usernamesOnline != null)
		{
			// TODO need to make these columns each into a sprite or text group because doing a destroy() here will only remove the element that was created before this one is make. the result will be an empty list or a list with only one row.
			_onlineUserListUsernames = new OnlinePlayersText(35, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
			// even thou _data._usernamesDynamic[i] is a string, we need to say it here again or else the program will crash.
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_onlineUserListUsernames.text = Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]);
			_onlineUserListUsernames.font = Reg._fontDefault;
			group.add(_onlineUserListUsernames);
			
			//.......................
			// invite button, each for an online user not in room.
			_onlineUserListInvite = new ButtonGeneralNetworkYes(325, 140 - _offset_y + ((i + 1) * 70), "", 160, 35, Reg._font_size, 0xFFCCFF33, 0, sendInviteConfirm.bind(i), 0xff000044, false, 1, true, (i + 1));
			_onlineUserListInvite.label.font = Reg._fontDefault;
			_onlineUserListInvite.visible = false;
			group.add(_onlineUserListInvite);
			
			//chess Elo
			_chess_elo = new OnlinePlayersText(540, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i + (Reg._maximum_server_connections + 1));
			if ( Std.string(RegTypedef._dataOnlinePlayers._chess_elo_rating[i]) != "0")
			_chess_elo.text = Std.string(RegTypedef._dataOnlinePlayers._chess_elo_rating[i]);
			_chess_elo.font = Reg._fontDefault;
			group.add(_chess_elo);
			
			//.....................
			// win, loss, draw points total.
			var _pointsGet:Float = (RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + (RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] * 0.5));
			var _points = FlxMath.roundDecimal(_pointsGet, 3);			
			
			_textPoints = new OnlinePlayersText(720, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i + ((Reg._maximum_server_connections + 1) * 2));
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_textPoints.text = Std.string(_points);
			_textPoints.font = Reg._fontDefault;
			group.add(_textPoints);
			
			//.....................
			// win percentage.
			var _totalGamesGet:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[i];
			var _winningPercentage:Float = _points / _totalGamesGet;				
			var _winnings:Float = FlxMath.roundDecimal(_winningPercentage * 100, 3);			
			
			_textPercentage = new OnlinePlayersText(960, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i + ((Reg._maximum_server_connections + 1) * 3));
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_textPercentage.text = Std.string(_winnings);
			_textPercentage.font = Reg._fontDefault;
			group.add(_textPercentage);
		}
		
		
		//------------------------------- Header columns for the data rows.	
		var _count = group.members.length-1;
		
		var _title_sub_background = new FlxSprite(0, 110);
		_title_sub_background.makeGraphic(FlxG.width - 40, 50, FlxColor.WHITE); 
		_title_sub_background.scrollFactor.set(1, 0);
		group.add(_title_sub_background);
		group.members[(_count + 1)].scrollFactor.set(1, 0);
					
		var _t1 = new FlxText(35, 120, 0, "Username");
		_t1.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		group.add(_t1);	
		group.members[(_count + 2)].scrollFactor.set(1, 0);
		
		var _t2 = new FlxText(315, 120, 0, "Invite");
		_t2.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		group.add(_t2);
		group.members[(_count + 3)].scrollFactor.set(1, 0);
		
		var _t3 = new FlxText(540, 120, 0, "Chess ELO");
		_t3.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		group.add(_t3);
		group.members[(_count + 4)].scrollFactor.set(1, 0);
		
		var _t4 = new FlxText(720, 120, 0, "Points");
		_t4.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		group.add(_t4);
		group.members[(_count + 5)].scrollFactor.set(1, 0);
		
		var _t5 = new FlxText(960, 120, 0, "Win Percentage");
		_t5.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		group.add(_t5);
		group.members[(_count + 6)].scrollFactor.set(1, 0);
		
		//--------------------------------------------------------------------
		
			
		if (i == 120)
		{
			_didPopulateList = true;
		}
	}
	
	public function sendInviteConfirm(_num:Int):Void
	{
		if (FlxG.mouse.y < FlxG.height - 50) // don't trigger mouse click when not at boxScroller. these values are from WaitingRoom _title_background and bodyBg. 
		{
			Reg._messageId = 12003;
			Reg._buttonCodeValues = "o1000";
			SceneGameRoom.messageBoxMessageOrder();		
			
			RegTypedef._dataPlayers._usernameInvite = RegTypedef._dataOnlinePlayers._usernamesOnline[_num];			
			
		}
	}

	
	override public function destroy():Void
	{	
		for (i in 0...121)
		{
			if (_onlineUserListUsernames != null) 
			{
				remove(_onlineUserListUsernames);
				_onlineUserListUsernames.destroy();
			}
			
			if (_onlineUserListInvite != null) 
			{
				remove(_onlineUserListInvite);
				_onlineUserListInvite.destroy();
			}
		}		
		
		_didPopulateList = false; // do not new FlxText or button the second time. only one field at a coordinate permitted.	
		_doOnce = false;
		
				
		super.destroy();
	}
		
	override public function update(elapsed:Float):Void 
	{	
		// this block of code is needed to make boxScroller not active when user clicks the chatter button. without this code, the chatter window would not be seen.
		if (GameChatter._chatterIsOpen == true)
		{
			__scene_waiting_room.__boxscroller.active = false; // remove from camera, so that the chatter can be seen.			
		} else __scene_waiting_room.__boxscroller.active = true;
		//...................................
		
		// invite player to room.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "o1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			PlayState.clientSocket.send("Online Player Offer Invite", RegTypedef._dataPlayers);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}

		if (RegTriggers._onlineList == true
		&&  RegTriggers._waiting_room_refresh_list == true
		&&  _onlinePlayersListTicks <= 120) 
		{
			RegTriggers._waiting_room_refresh_list = false;
			
			// this speeds up the displaying of the online users list. this code limits to a small amount of online update() ticks and keeps the program from changing cursor to the busy icon and from freezing the display.
			while (_onlinePlayersListTicks < 20 
			 || _onlinePlayersListTicks > 20 && _onlinePlayersListTicks < 40
			 || _onlinePlayersListTicks > 40 && _onlinePlayersListTicks < 60
			 || _onlinePlayersListTicks > 60 && _onlinePlayersListTicks < 80
			 || _onlinePlayersListTicks > 80 && _onlinePlayersListTicks < 100
			 || _onlinePlayersListTicks > 100 && _onlinePlayersListTicks < 120)
			{
				populateOnlineList(_onlinePlayersListTicks);
				_onlinePlayersListTicks += 1;
			}			
			
			if (_onlinePlayersListTicks >= 120) FlxG.mouse.enabled = true;
			
			populateOnlineList(_onlinePlayersListTicks);
			_onlinePlayersListTicks += 1;
		}
		
		// enable the room buttons because the online user list has been created.
		var _count:Int = 0;
	
		// only the first player that entered the room can start a game.
		for (i in 0...4)
		{
			if (RegTypedef._dataPlayers._usernamesDynamic[i] != "") _count += 1;
		}
	
		if (_count == 1 && SceneWaitingRoom._textPlayer1Stats.text != ""
		||  _count == 2 && SceneWaitingRoom._textPlayer2Stats.text != ""
		||  _count == 3 && SceneWaitingRoom._textPlayer3Stats.text != ""
		||  _count == 4 && SceneWaitingRoom._textPlayer4Stats.text != "")
		{
			// fix a camera display bug where the return to lobby an invite buttons can also be clicked from the right side of the screen because of the chatter boxScroller scrolling part of the scene.
			if (FlxG.mouse.x > FlxG.width / 2
			&&  FlxG.mouse.y >= FlxG.height - 50
			&&  __scene_waiting_room.buttonReturnToLobby.visible == true
			&&  __scene_waiting_room.buttonRefreshList.visible == true) 
			{
				__scene_waiting_room.buttonReturnToLobby.label.color = 0xFFFFFFFF;
				__scene_waiting_room.buttonRefreshList.label.color = 0xFFFFFFFF;
				
				__scene_waiting_room.buttonReturnToLobby.active = false;
				__scene_waiting_room.buttonRefreshList.active = false;
			}
			
			else
			
			{
				__scene_waiting_room.buttonReturnToLobby.active = true;
				__scene_waiting_room.buttonRefreshList.active = true;
			}
			
		}
		
		super.update(elapsed);
	}
}
