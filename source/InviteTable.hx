/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * main invite list class.
 * Draw the invite list background and table then calls the class that will populate the table.
 * @author kboardgames.com
 */

class InviteTable extends FlxState
{
	/******************************
	 * table rows.
	 */
	private var _table_rows:Array<FlxSprite> = [for (i in 0... Reg._maximum_server_connections) new FlxSprite(0, 0)];
	
	/******************************
	* the title of this state.
	*/
    public var _title:FlxText;
	public var _title_background_large:FlxSprite;
	
	/******************************
	 * moves everything up by these many pixels.
	 */
	private var _offset_y:Int = -770;
	
	// used at the invite table seen at __scene_waiting_room.
	public var _onlineUserListUsernames:Array<InviteUsername> = [for (i in 0... Reg._maximum_server_connections + 1) new InviteUsername(0,0, 0,"",0,0)]; 
	
	public var _onlineUserListInvite:Array<ButtonGeneralNetworkYes> = [for (i in 0...24) new ButtonGeneralNetworkYes(0,0,"",0,0,0,0xfffffff,0,null)]; 
	
	public var _chess_elo:Array<InviteELO> = [for (i in 0... Reg._maximum_server_connections + 1) new InviteELO(0,0, 0,"",0,0)];
	
	public var _textPoints:Array<InvitePoints> = [for (i in 0... Reg._maximum_server_connections + 1) new InvitePoints(0,0, 0,"",0,0)];
	
	public var _textPercentage:Array<InvitePercentage> = [for (i in 0... Reg._maximum_server_connections + 1) new InvitePercentage(0,0, 0,"",0,0)];
		
	/******************************
	* anything added to this group will be placed inside of the scrollbar field. 
	*/
	public var _group:FlxSpriteGroup;	
		
	public var __scene_waiting_room:SceneWaitingRoom; 
	
	public var _ticks_invite_list:Int = 0;
	
	
	public static var _populated_table_body:Bool = false; // do not new FlxText or button the second time. only one field at a coordinate permitted.
	
	public static var _doOnce:Bool = false;
	
	public function new (scene_waiting_room:SceneWaitingRoom)
	{
		super();
		
		RegFunctions.fontsSharpen();
		
		_populated_table_body = false;
		_doOnce = false;
		
		__scene_waiting_room = scene_waiting_room;
		

		var _color_table_rows = FlxColor.fromHSB((__scene_waiting_room._color_ra+25), 0.8, (RegCustom._client_background_brightness[Reg._tn]-0.10));
		
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			_color_table_rows = RegCustomColors.color_client_background();
			_color_table_rows.alphaFloat = 0.15;
		}
		
		_group = cast add(new FlxSpriteGroup());
				
		_title_background_large = new FlxSprite(0, 0);
		_title_background_large.makeGraphic(FlxG.width, 110);
		_title_background_large.color = __scene_waiting_room._color;
		add(_title_background_large);
		
		_title = new FlxText(15, 0, 0, "");
		_title.visible = true;
		add(_title);	

		// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only Reg._maximum_server_connections value of loops will be made. 
		for (i in 1... Reg._maximum_server_connections + 1)
		{
			if (_table_rows[i] != null)
			{
				_group.remove(_table_rows[i]);
				_table_rows[i].destroy();
			}
			
			// soild table rows
			_table_rows[i] = new FlxSprite(0, 0);
			_table_rows[i].makeGraphic(FlxG.width - 60, 55, RegCustomColors.color_table_body_background());		
			_table_rows[i].setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_rows[i].scrollFactor.set(0, 0);
			_group.add(_table_rows[i]);
			
			var _table_horizontal_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_cell_padding.makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_cell_padding.setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_horizontal_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_horizontal_cell_padding);
			
			var _table_horizontal_bottom_cell_padding = new FlxSprite(0, 0);
			_table_horizontal_bottom_cell_padding.makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_bottom_cell_padding.setPosition(20, 120 - _offset_y + (i * 70) - 15 + 70); 
			_table_horizontal_bottom_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_horizontal_bottom_cell_padding);
		}
		
		/*
		// without this code the buttons A and B would not be seen.
		var _table_row = new FlxSprite(0, 0);
		_table_row.makeGraphic(FlxG.width - 80, 400, 0xFF000000);		
		_table_row.setPosition(20, 135 - _offset_y + (121 * 70)); 
		_table_row.scrollFactor.set(0, 0);
		_group.add(_table_row);		
		*/
		table_columns();
		table_header();
		
	}
	
	private function table_columns():Void
	{
		// a black bar between table rows.
		// first column border. columns are minus 20 from Header column text.
		for (i in 1... Reg._maximum_server_connections + 1)
		{
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(295, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding);
			
			// before chess Elo
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(520, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding);
			
			// before points.
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(700, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding);
			
			// before win percentage
			var _table_vertical_cell_padding = new FlxSprite(0, 0);
			_table_vertical_cell_padding.makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding.setPosition(940, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding.scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding);
		}
	}
	
	private function table_header():Void
	{
		var _count = _group.members.length-1;
		
		var _title_sub_background = new FlxSprite(0, 110);
		_title_sub_background.makeGraphic(FlxG.width - 20, 50, FlxColor.WHITE); 
		_title_sub_background.scrollFactor.set(1, 0);
		_group.add(_title_sub_background);
		_group.members[(_count + 1)].scrollFactor.set(1, 0);
					
		var _t1 = new FlxText(35, 120, 0, "Username");
		_t1.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		_group.add(_t1);	
		_group.members[(_count + 2)].scrollFactor.set(1, 0);
		
		var _t2 = new FlxText(315, 120, 0, "Invite");
		_t2.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		_group.add(_t2);
		_group.members[(_count + 3)].scrollFactor.set(1, 0);
		
		var _t3 = new FlxText(540, 120, 0, "Chess ELO");
		_t3.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		_group.add(_t3);
		_group.members[(_count + 4)].scrollFactor.set(1, 0);
		
		var _t4 = new FlxText(720, 120, 0, "Points");
		_t4.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		_group.add(_t4);
		_group.members[(_count + 5)].scrollFactor.set(1, 0);
		
		var _t5 = new FlxText(960, 120, 0, "Win Percentage");
		_t5.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
		_group.add(_t5);
		_group.members[(_count + 6)].scrollFactor.set(1, 0);
	}
	
	public function populate_invite_list(i:Int):Void
	{
		//.......................
		if (_populated_table_body == false && RegTypedef._dataOnlinePlayers._usernamesOnline != null)
		{
			if (_onlineUserListUsernames[i] != null)
			{
				_group.remove(_onlineUserListUsernames[i]);
				_onlineUserListUsernames[i].destroy();
			}
			
			_onlineUserListUsernames[i] = new InviteUsername(35, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
			// even thou _data._usernamesDynamic[i] is a string, we need to say it here again or else the program will crash.
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_onlineUserListUsernames[i].text = Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]);
			_onlineUserListUsernames[i].font = Reg._fontDefault;
			_group.add(_onlineUserListUsernames[i]);
			
			//.......................
			// invite button, each for an online user not in room.
			if (_onlineUserListInvite[i] != null)
			{
				_group.remove(_onlineUserListInvite[i]);
				_onlineUserListInvite[i].destroy();
			}
			
			_onlineUserListInvite[i] = new ButtonGeneralNetworkYes(325, 140 - _offset_y + ((i + 1) * 70), "", 160, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, sendInviteConfirm.bind(i), RegCustom._button_color[Reg._tn],false, 1, true, (i + 7000));
			_onlineUserListInvite[i].label.font = Reg._fontDefault;
			_onlineUserListInvite[i].visible = false;
			_group.add(_onlineUserListInvite[i]);
			
			//chess Elo
			if (_chess_elo[i] != null)
			{
				_group.remove(_chess_elo[i]);
				_chess_elo[i].destroy();
			}
			
			_chess_elo[i] = new InviteELO(540, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
			if ( Std.string(RegTypedef._dataOnlinePlayers._chess_elo_rating[i]) != "0")
			_chess_elo[i].text = Std.string(RegTypedef._dataOnlinePlayers._chess_elo_rating[i]);
			_chess_elo[i].font = Reg._fontDefault;
			_group.add(_chess_elo[i]);
			
			//.....................
			// win, loss, draw points total.
			var _pointsGet:Float = (RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + (RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] * 0.5));
			var _points = FlxMath.roundDecimal(_pointsGet, 3);		
			
			if (_textPoints[i] != null)
			{
				_group.remove(_textPoints[i]);
				_textPoints[i].destroy();
			}
			
			_textPoints[i] = new InvitePoints(720, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_textPoints[i].text = Std.string(_points);
			_textPoints[i].font = Reg._fontDefault;
			_group.add(_textPoints[i]);
			
			//.....................
			// win percentage.
			var _totalGamesGet:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[i];
			var _winningPercentage:Float = _points / _totalGamesGet;				
			var _winnings:Float = FlxMath.roundDecimal(_winningPercentage * 100, 3);			
			
			if (_textPercentage[i] != null)
			{
				_group.remove(_textPercentage[i]);
				_textPercentage[i].destroy();
			}
			
			_textPercentage[i] = new InvitePercentage(960, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
			if ( Std.string(RegTypedef._dataOnlinePlayers._usernamesOnline[i]) != "")
			_textPercentage[i].text = Std.string(_winnings);
			_textPercentage[i].font = Reg._fontDefault;
			_group.add(_textPercentage[i]);
		}	
		
		if (i == Reg._maximum_server_connections + 1)
		{
			_populated_table_body = true;
			RegTriggers._waiting_room_refresh_invite_list = false;
		}
	}
	
	public function sendInviteConfirm(_num:Int):Void
	{
		Reg._messageId = 12003;
		Reg._buttonCodeValues = "o1000";
		SceneGameRoom.messageBoxMessageOrder();		
			
		RegTypedef._dataPlayers._usernameInvite = RegTypedef._dataOnlinePlayers._usernamesOnline[_num];			
	}

	
	override public function destroy():Void
	{			
		_populated_table_body = false; // do not new FlxText or button the second time. only one field at a coordinate permitted.	
		_doOnce = false;
		
			
		for (i in 0... Reg._maximum_server_connections + 1)
		{
			if (_onlineUserListUsernames[i] != null)
			{
				_group.remove(_onlineUserListUsernames[i]);
				_onlineUserListUsernames[i].destroy();
			}

			if (_onlineUserListInvite[i] != null)
			{
				_group.remove(_onlineUserListInvite[i]);
				_onlineUserListInvite[i].destroy();
			}

			if (_chess_elo[i] != null)
			{
				_group.remove(_chess_elo[i]);
				_chess_elo[i].destroy();
			}

			if (_textPoints[i] != null)
			{
				_group.remove(_textPoints[i]);
				_textPoints[i].destroy();
			}

			if (_textPercentage[i] != null)
			{
				_group.remove(_textPercentage[i]);
				_textPercentage[i].destroy();
			}
		}
		
		super.destroy();
	}
		
	override public function update(elapsed:Float):Void 
	{
		if (Reg._at_waiting_room == false) return;
		
		// this block of code is needed to make scrollable area not active when user clicks the chatter button. without this code, the chatter window would not be seen.
		if (GameChatter._chatterIsOpen == true)
		{
			__scene_waiting_room.__scrollable_area.active = false; // remove from camera, so that the chatter can be seen.			
		} else __scene_waiting_room.__scrollable_area.active = true;
		//...................................
		
		// invite player to room.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "o1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
			PlayState.send("Online Player Offer Invite", RegTypedef._dataPlayers);			
		}
		
		if (Reg._yesNoKeyPressValueAtMessage > 1 && Reg._buttonCodeValues == "o1000")
		{			
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
		}

		if (RegTriggers._waiting_room_refresh_invite_list == true
		&&  _ticks_invite_list <= Reg._maximum_server_connections + 1) 
		{
			// this speeds up the displaying of the online users list. this code limits to a small amount of online update() ticks and keeps the program from changing cursor to the busy icon and from freezing the display.
			while (_ticks_invite_list < 20 
			 || _ticks_invite_list > 20 && _ticks_invite_list < 40
			 || _ticks_invite_list > 40 && _ticks_invite_list < 60
			 || _ticks_invite_list > 60 && _ticks_invite_list < 80
			 || _ticks_invite_list > 80 && _ticks_invite_list < 100
			 || _ticks_invite_list > 100 && _ticks_invite_list < Reg._maximum_server_connections + 1)
			{
				populate_invite_list(_ticks_invite_list);
				_ticks_invite_list += 1;
			}			
			
			populate_invite_list(_ticks_invite_list);
			_ticks_invite_list += 1;
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
			// fix a camera display bug where the return to lobby an invite buttons can also be clicked from the right side of the screen because of the chatter scrollable area scrolling part of the scene.
			if (FlxG.mouse.x > FlxG.width / 2
			&&  FlxG.mouse.y >= FlxG.height - 50
			&&  Reg.__menu_bar4._button_return_to_lobby_from_waiting_room.visible == true
			&&  Reg.__menu_bar4._button_refresh_list.visible == true) 
			{
				Reg.__menu_bar4._button_return_to_lobby_from_waiting_room.label.color = 0xFFFFFFFF;
				Reg.__menu_bar4._button_refresh_list.label.color = 0xFFFFFFFF;
				
				Reg.__menu_bar4._button_return_to_lobby_from_waiting_room.active = false;
				Reg.__menu_bar4._button_refresh_list.active = false;
			}
			
			else
			
			{
				Reg.__menu_bar4._button_return_to_lobby_from_waiting_room.active = true;
				Reg.__menu_bar4._button_refresh_list.active = true;
			}
			
		}
		
		super.update(elapsed);
	}
}//