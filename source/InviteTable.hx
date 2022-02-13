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
	public static var _do_once:Bool = true;
	
	/******************************
	 * table rows.
	 */
	private var _table_rows:Array<FlxSprite> = [for (i in 0... Reg._maximum_server_connections) new FlxSprite(0, 0)];
	
	/******************************
	 * the padding between rows.
	 */
	private var _table_horizontal_cell_padding:Array<FlxSprite> = [];
	
	/******************************
	* the padding between rows. this is the last padding of the table.
	 */
	private var _table_horizontal_bottom_cell_padding:Array<FlxSprite> = [];
	
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
	public var _onlineUserListUsernames:Array<InviteUsername> = [];	
	public static var _onlineUserListInvite:Array<ButtonGeneralNetworkYes> = []; 
	public var _chess_elo:Array<InviteELO> = [];
	public var _textPoints:Array<InvitePoints> = [];
	public var _textPercentage:Array<InvitePercentage> = [];
	
	// make a double copy of all wating room table columns.
	public static var _column1:Array<Dynamic> = [];
	public static var _column2:Array<ButtonGeneralNetworkYes> = [];
	public static var _column3:Array<Dynamic> = [];
	public static var _column4:Array<Dynamic> = [];
	public static var _column5:Array<Dynamic> = [];
	
	private var _table_column_sort1:TableColumnSort;
	private var _table_column_sort2:TableColumnSort;
	private var _table_column_sort3:TableColumnSort;
	private var _table_column_sort4:TableColumnSort;
	private var _table_column_sort5:TableColumnSort;
	
	/******************************
	* anything added to this group will be placed inside of the scrollbar field. 
	*/
	public var _group:FlxSpriteGroup;	
	public var _group2:FlxSpriteGroup;	
		
	public var __scene_waiting_room:SceneWaitingRoom; 
	
	public static var _ticks_invite_list:Int = 0;
		
	/******************************
	 * do not new FlxText or button the second time. only one field at a coordinate permitted.
	 */
	public static var _populated_table_body:Bool = false;
	
	/******************************
	* first vertical table padding between columns.
	*/
	private var	_table_vertical_cell_padding_first:Array<FlxSprite> = [];
	
	/******************************
	* before chess ELO
	*/
	private var	_table_vertical_cell_padding_chess_ELO:Array<FlxSprite> = [];
	
	/******************************
	* before points.
	*/
	private var	_table_vertical_cell_padding_points:Array<FlxSprite> = [];
	
	/******************************
	* before win percentage
	*/
	private var	_table_vertical_cell_padding_win_percentage:Array<FlxSprite> = [];
	
	/******************************
	 * table header background.
	 */
	private var _title_sub_background:FlxSprite;
	
	/******************************
	 * table header column text.
	 * username.
	 */
	private var _t1:FlxText;
	
	/******************************
	 * table header column text.
	 * invite.
	 */
	private var _t2:FlxText;
	
	/******************************
	 * table header column text.
	 * chess ELO.
	 */
	private var _t3:FlxText;
	
	/******************************
	 * table header column text.
	 * points.
	 */
	private var _t4:FlxText;
	
	/******************************
	 * table header column text.
	 * win precentage.
	 */
	private var _t5:FlxText;
	
	public function new (scene_waiting_room:SceneWaitingRoom)		
	{
		super();
		
		_ticks_invite_list = 0;
		
		RegFunctions.fontsSharpen();
		
		_populated_table_body = false;
		__scene_waiting_room = scene_waiting_room;
		

		var _color_table_rows = FlxColor.fromHSB((__scene_waiting_room._color_ra+25), 0.8, (RegCustom._client_background_brightness[Reg._tn]-0.10));
		
		if (RegCustom._client_background_enabled[Reg._tn] == true)
		{
			_color_table_rows = RegCustomColors.color_client_background();
			_color_table_rows.alphaFloat = 0.15;
		}
		
		reset_vars();
		
		_group = cast add(new FlxSpriteGroup());
		_group2 = cast add(new FlxSpriteGroup());
		
		if (_title_background_large != null)
		{
			remove(_title_background_large);
			_title_background_large.destroy();
		}
		
		_title_background_large = new FlxSprite(0, 0);
		_title_background_large.makeGraphic(FlxG.width, 110);
		_title_background_large.color = __scene_waiting_room._color;
		add(_title_background_large);
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
		}
		
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
			
			if (_table_horizontal_cell_padding[i] != null)
			{
				_group.remove(_table_horizontal_cell_padding[i]);
				_table_horizontal_cell_padding[i].destroy();
			}
			
			_table_horizontal_cell_padding[i] = new FlxSprite(0, 0);
			_table_horizontal_cell_padding[i].makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_cell_padding[i].setPosition(20, 120 - _offset_y + (i * 70)); 
			_table_horizontal_cell_padding[i].scrollFactor.set(0, 0);
			_group.add(_table_horizontal_cell_padding[i]);
			
			if (_table_horizontal_bottom_cell_padding[i] != null)
			{
				_group.remove(_table_horizontal_bottom_cell_padding[i]);
				_table_horizontal_bottom_cell_padding[i].destroy();
			}
			
			_table_horizontal_bottom_cell_padding[i] = new FlxSprite(0, 0);
			_table_horizontal_bottom_cell_padding[i].makeGraphic(FlxG.width - 60, 2, 0xff000000);		
			_table_horizontal_bottom_cell_padding[i].setPosition(20, 120 - _offset_y + (i * 70) - 15 + 70); 
			_table_horizontal_bottom_cell_padding[i].scrollFactor.set(0, 0);
			_group.add(_table_horizontal_bottom_cell_padding[i]);
		}
		
		table_columns();
	}
	
	private function table_columns():Void
	{
		// a black bar between table rows.
		// first column border. columns are minus 20 from Header column text.
		for (i in 1... Reg._maximum_server_connections + 1)
		{
			_table_vertical_cell_padding_first[i] = new FlxSprite(0, 0);
			_table_vertical_cell_padding_first[i].makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding_first[i].setPosition(295, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding_first[i].scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding_first[i]);
			
			// before chess Elo
			_table_vertical_cell_padding_chess_ELO[i] = new FlxSprite(0, 0);
			_table_vertical_cell_padding_chess_ELO[i].makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding_chess_ELO[i].setPosition(520, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding_chess_ELO[i].scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding_chess_ELO[i]);
			
			// before points.
			_table_vertical_cell_padding_points[i] = new FlxSprite(0, 0);
			_table_vertical_cell_padding_points[i].makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding_points[i].setPosition(700, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding_points[i].scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding_points[i]);
			
			// before win percentage
			_table_vertical_cell_padding_win_percentage[i] = new FlxSprite(0, 0);
			_table_vertical_cell_padding_win_percentage[i].makeGraphic(2, 55, 0xFF000000);		
			_table_vertical_cell_padding_win_percentage[i].setPosition(940, 120 - _offset_y + (i * 70) + 1); 
			_table_vertical_cell_padding_win_percentage[i].scrollFactor.set(0, 0);
			_group.add(_table_vertical_cell_padding_win_percentage[i]);
		}
	}
	
	private function table_header():Void
	{
		if (_title_sub_background == null)
		{
			_title_sub_background = new FlxSprite(0, 110);
			_title_sub_background.makeGraphic(FlxG.width - 20, 50, FlxColor.WHITE); 
			_title_sub_background.scrollFactor.set(1, 0);
			_group2.add(_title_sub_background);
			_group2.members[0].scrollFactor.set(1, 0);
		}
		
		if (_t1 == null)
		{
			_t1 = new FlxText(35, 120, 0, "Username");
			_t1.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
			_group2.add(_t1);	
			_group2.members[1].scrollFactor.set(1, 0);
		}
			
		if (_t2 == null)
		{
			_t2 = new FlxText(315, 120, 0, "Invite");
			_t2.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
			_group2.add(_t2);
			_group2.members[2].scrollFactor.set(1, 0);
		}
			
		if (_t3 == null)
		{
			_t3 = new FlxText(540, 120, 0, "Chess ELO");
			_t3.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
			_group2.add(_t3);
			_group2.members[3].scrollFactor.set(1, 0);
		}
		
		if (_t4 == null)
		{
			_t4 = new FlxText(720, 120, 0, "Points");
			_t4.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
			_group2.add(_t4);
			_group2.members[4].scrollFactor.set(1, 0);
		}
		
		if (_t5 == null)
		{
			_t5 = new FlxText(960, 120, 0, "Win Percentage");
			_t5.setFormat(Reg._fontDefault, (Reg._font_size-2), FlxColor.BLACK);
			_group2.add(_t5);
			_group2.members[5].scrollFactor.set(1, 0);
		}
	}
	
	private function table_header_data():Void
	{
		var _arror_offset_x:Int = 35;
	
		// create the arrows and pass the columns' data to the class.
		// start table column id at 100. id 0-99 is used for lobby.
		// this must not be changed to != null. there is a bug where most RegTypedef._dataOnlinePlayers._usernamesOnline elements will be destroyed.
		if (_table_column_sort1 == null)
		{
			_table_column_sort1 = new TableColumnSort(295 - _arror_offset_x, 121, 100, Reg._usernamesOnline, null, this);
			_table_column_sort1.scrollFactor.set(1, 0);
			_table_column_sort1.color = RegCustom._client_text_color_number[Reg._tn];
		}
		
		// invite send button
		if (_table_column_sort2 == null)
		{
			_table_column_sort2 = new TableColumnSort(520 - _arror_offset_x, 121, 101, _onlineUserListInvite, null, this);
			_table_column_sort2.scrollFactor.set(1, 0);
			_table_column_sort2.color = RegCustom._client_text_color_number[Reg._tn];
		}
		
		// InviteELO
		if (_table_column_sort3 == null)
		{
			_table_column_sort3 = new TableColumnSort(700 - _arror_offset_x, 121, 102, Reg._chess_elo_rating, null, this);
			_table_column_sort3.scrollFactor.set(1, 0);
			_table_column_sort3.color = RegCustom._client_text_color_number[Reg._tn];
		}
		
		// InvitePoints
		if (_table_column_sort4 == null)
		{
			_table_column_sort4 = new TableColumnSort(940 - _arror_offset_x, 121, 103, Reg._invite_points, null, this);
			_table_column_sort4.scrollFactor.set(1, 0);
			_table_column_sort4.color = RegCustom._client_text_color_number[Reg._tn];
		}
		
		//InvitePercentage			
		if (_table_column_sort5 == null)
		{
			_table_column_sort5 = new TableColumnSort(1160, 121, 104, Reg._invite_percentage, null, this);
			_table_column_sort5.scrollFactor.set(1, 0);
			_table_column_sort5.color = RegCustom._client_text_color_number[Reg._tn];
		}
		
		// after adding another column put add(_table_column_sort6) at update();
		
		// this is needed for the online list button.
		TableColumnSort.sort(Reg._tc);
	}
	
	public function populate_invite_list(i:Int):Void
	{
		if (i == 0)
		{
			// make a double copy of all lobby columns.
			for (ii in 0... Reg._maximum_server_connections)	
			{
				Reg._usernamesOnline[ii] = RegTypedef._dataOnlinePlayers._usernamesOnline[ii];
				_column1[ii] = Reg._usernamesOnline[ii];
				_column2[ii].label.text = _onlineUserListInvite[ii].label.text;
				Reg._chess_elo_rating[ii] = FlxMath.roundDecimal(RegTypedef._dataOnlinePlayers._chess_elo_rating[ii], 0);
				_column3[ii] = Std.string(Reg._chess_elo_rating[ii]);
				
				var _math:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[ii] + (RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[ii] * 0.5);
				Reg._invite_points[ii] = FlxMath.roundDecimal(_math, 0);
				
				_column4[ii] = Std.string(Reg._invite_points[ii]);	
				
				// calculates the winning percentage. 
				var _totalGamesGet:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[ii] + RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[ii] + RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[ii];

				var _winningPercentage:Float = (RegTypedef._dataOnlinePlayers._gamesAllTotalWins[ii] / _totalGamesGet);
				
				var _winnings:Float = FlxMath.roundDecimal(_winningPercentage * 100, 3);
				Reg._invite_percentage[ii] = _winnings;
				_column5[ii] = Std.string(Reg._invite_percentage[ii]);
				
			}
			
			// this is needed for the sort function below to work.
			table_header_data();
		}
		
		// do we need to use _onlineUserListUsernames[i].text = Std.string(_column1[i]); and the other columns in a loop when _populated_table_body is true?
		
		//.......................
		if (_populated_table_body == false && RegTypedef._dataOnlinePlayers._usernamesOnline != null)
		{

			// _data._usernamesDynamic[i] is a string, we need to say it here again or else the program will crash.
			if ( Std.string(_column1[i]) != "")
			_onlineUserListUsernames[i].text = Std.string(_column1[i]);
			_onlineUserListUsernames[i].font = Reg._fontDefault;
			if (_do_once == true) _group.add(_onlineUserListUsernames[i]);
			
			// invite button, each for an online user not in room.
			if (_do_once == true)
			{
				_onlineUserListInvite[i].label.font = Reg._fontDefault;
				_onlineUserListInvite[i].visible = false;
			
				_group.add(_onlineUserListInvite[i]);
			}
			
			//chess Elo
			if ( Std.string(_column3[i]) != "0")
			_chess_elo[i].text = Std.string(_column3[i]);
			_chess_elo[i].font = Reg._fontDefault;
			if (_do_once == true) _group.add(_chess_elo[i]);
			
			//.....................
			// win, loss, draw points total.
			var _pointsGet:Float = (RegTypedef._dataOnlinePlayers._gamesAllTotalWins[TableColumnSort._sorted[i]] + (RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[TableColumnSort._sorted[i]] * 0.5));
			var _points = FlxMath.roundDecimal(_pointsGet, 3);		
			
			if (Std.string(_column1[i]) == "") _textPoints[i].text = "";
			else _textPoints[i].text = Std.string(_points);
			_textPoints[i].font = Reg._fontDefault;
			if (_do_once == true) _group.add(_textPoints[i]);
			
			//.....................
			// win percentage.
			var _totalGamesGet:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[TableColumnSort._sorted[i]] + RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[TableColumnSort._sorted[i]] + RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[TableColumnSort._sorted[i]];
			var _winningPercentage:Float = _points / _totalGamesGet;				
			var _winnings:Float = FlxMath.roundDecimal(_winningPercentage * 100, 3);			
		
			if (Std.string(_column1[i]) == "") _textPercentage[i].text = "";
			else _textPercentage[i].text = Std.string(_column5[i]);
			_textPercentage[i].font = Reg._fontDefault;
			if (_do_once == true) _group.add(_textPercentage[i]);
			
		}	
		
		if (i == Reg._maximum_server_connections - 1) _do_once = false;
		
	}
	
	public function sendInviteConfirm(i:Int):Void
	{
		Reg._messageId = 12003;
		Reg._buttonCodeValues = "o1000";
		SceneGameRoom.messageBoxMessageOrder();		
			
		RegTypedef._dataPlayers._usernameInvite = Reg._usernamesOnline[i];			
	}

	/******************************
	 * when entering the waiting room these vars need to be cleared so this class can populate the invite table.
	 */
	private function reset_vars():Void
	{
		// the following vars in this function will always be in memory. they cannot be cleared because when exiting the waiting room, those classes are not cleared until returning to title.
		for (i in 0... Reg._maximum_server_connections + 1)
		{
			_onlineUserListUsernames[i] = new InviteUsername(35, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
		}
		
		for (i in 0... Reg._maximum_server_connections + 1)
		{
			_onlineUserListInvite[i] = new ButtonGeneralNetworkYes(325, 140 - _offset_y + ((i + 1) * 70), "", 160, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, sendInviteConfirm.bind(i), RegCustom._button_color[Reg._tn], false, 1, true, (i + 7000));
			_onlineUserListInvite[i].visible = false;
		}
		
		for (i in 0... Reg._maximum_server_connections + 1)
		{
			_chess_elo[i] = new InviteELO(540, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
		}
		
		for (i in 0... Reg._maximum_server_connections + 1)
		{
			_textPoints[i] = new InvitePoints(720, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
		}
		
		for (i in 0... Reg._maximum_server_connections + 1) 
		{
			_textPercentage[i] = new InvitePercentage(960, 145 - _offset_y + ((i + 1) * 70), 0, "", 20, i);
		}
		
		// the other columns do not need to be placed here because they are either string or int converted to string.
		_column2 = [for (i in 0... Reg._maximum_server_connections + 1) new ButtonGeneralNetworkYes(0, 0, "", 0, 0, 0, 0xfffffff, 0, null)];
	}
	
	override public function destroy():Void
	{			
		_populated_table_body = false; // do not new FlxText or button the second time. only one field at a coordinate permitted.	
		
		__scene_waiting_room = null;
		
		if (_group != null)
		{
			for (i in 0... Reg._maximum_server_connections + 1)
			{
				if (_onlineUserListUsernames[i] != null)
				{
					_group.remove(_onlineUserListUsernames[i]);
					_onlineUserListUsernames[i].destroy();
					_onlineUserListUsernames[i] = null;
				}

				if (_onlineUserListInvite[i] != null)
				{
					_group.remove(_onlineUserListInvite[i]);
					_onlineUserListInvite[i].destroy();
					_onlineUserListInvite[i] = null;
				}

				if (_chess_elo[i] != null)
				{
					_group.remove(_chess_elo[i]);
					_chess_elo[i].destroy();
					_chess_elo[i] = null;
				}

				if (_textPoints[i] != null)
				{
					_group.remove(_textPoints[i]);
					_textPoints[i].destroy();
					_textPoints[i] = null;
				}

				if (_textPercentage[i] != null)
				{
					_group.remove(_textPercentage[i]);
					_textPercentage[i].destroy();
					_textPercentage[i] = null;
				}
			}
			
			_column1.slice(0, _column1.length);
		
			if (_column2 != null)
			{
				for (i in 0... _column2.length)
				{
					if (_column2[i] != null)
					{
						_column2[i].destroy();
						_column2[i] = null;
					}
				}
			}
			
			_column3.slice(0, _column3.length);
			_column4.slice(0, _column4.length);
			_column5.slice(0, _column5.length);
		}
		
		if (_table_rows != null)
		{
			for (i in 0... _table_rows.length)
			{
				if (_table_rows[i] != null)
				{
					_group.remove(_table_rows[i]);
					_table_rows[i].destroy();
					_table_rows[i] = null;
				}
			}
		}
				
		if (_table_horizontal_cell_padding != null)
		{
			for (i in 0... _table_horizontal_cell_padding.length)
			{
				if (_table_horizontal_cell_padding[i] != null)
				{
					_group.remove(_table_horizontal_cell_padding[i]);
					_table_horizontal_cell_padding[i].destroy();
					_table_horizontal_cell_padding[i] = null;
				}
			}
		}
		
		if (_table_horizontal_bottom_cell_padding != null)
		{
			for (i in 0... _table_horizontal_bottom_cell_padding.length)
			{
				if (_table_horizontal_bottom_cell_padding[i] != null)
				{
					_group.remove(_table_horizontal_bottom_cell_padding[i]);
					_table_horizontal_bottom_cell_padding[i].destroy();
					_table_horizontal_bottom_cell_padding[i] = null;
				}
			}
		}
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
			_title = null;
		}
		
		if (_title != null)
		{
			remove(_title_background_large);
			_title_background_large.destroy();
			_title_background_large = null;
		}
		
		if (_table_vertical_cell_padding_first != null)
		{
			for (i in 0... _table_vertical_cell_padding_first.length)
			{
				if (_table_vertical_cell_padding_first[i] != null)
				{
					_group.remove(_table_vertical_cell_padding_first[i]);
					_table_vertical_cell_padding_first[i].destroy();
					_table_vertical_cell_padding_first[i] = null;
				}
			}
		}
		
		if (_table_vertical_cell_padding_chess_ELO != null)
		{
			for (i in 0... _table_vertical_cell_padding_chess_ELO.length)
			{
				if (_table_vertical_cell_padding_chess_ELO[i] != null)
				{
					_group.remove(_table_vertical_cell_padding_chess_ELO[i]);
					_table_vertical_cell_padding_chess_ELO[i].destroy();
					_table_vertical_cell_padding_chess_ELO[i] = null;
				}
			}
		}
		
		if (_table_vertical_cell_padding_points != null)
		{
			for (i in 0... _table_vertical_cell_padding_points.length)
			{
				if (_table_vertical_cell_padding_points[i] != null)
				{
					_group.remove(_table_vertical_cell_padding_points[i]);
					_table_vertical_cell_padding_points[i].destroy();
					_table_vertical_cell_padding_points[i] = null;
				}
			}
		}
		
		if (_table_vertical_cell_padding_win_percentage != null)
		{
			for (i in 0... _table_vertical_cell_padding_win_percentage.length)
			{
				if (_table_vertical_cell_padding_win_percentage[i] != null)
				{
					_group.remove(_table_vertical_cell_padding_win_percentage[i]);
					_table_vertical_cell_padding_win_percentage[i].destroy();
					_table_vertical_cell_padding_win_percentage[i] = null;
				}
			}	
		}
		
		if (_title_sub_background != null)
		{
			_group2.remove(_title_sub_background);
			_title_sub_background.destroy();
			_title_sub_background = null;
		}
		
		if (_t1 != null)
		{
			_group2.remove(_t1);
			_t1.destroy();
			_t1 = null;
		}
		
		if (_t2 != null)
		{
			_group2.remove(_t2);
			_t2.destroy();
			_t2 = null;
		}
		
		if (_t3 != null)
		{
			_group2.remove(_t3);
			_t3.destroy();
			_t3 = null;
		}
		
		if (_t4 != null)
		{
			_group2.remove(_t4);
			_t4.destroy();
			_t4 = null;
		}
		
		if (_t5 != null)
		{
			_group2.remove(_t5);
			_t5.destroy();
			_t5 = null;
		}
		
		if (_group != null)
		{
			remove(_group);
			_group.destroy();
			_group = null;
		}
		
		if (_group2 != null)
		{
			remove(_group2);
			_group2.destroy();
			_group2 = null;
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
		&&  _ticks_invite_list < Reg._maximum_server_connections)
		//&&	RegTypedef._dataOnlinePlayers._usernamesOnline[0] != "") 
		{			
			populate_invite_list(_ticks_invite_list);
			_ticks_invite_list += 1;
			
			SceneWaitingRoom.__title_bar._spinner.visible = true;
			
			// data is assigned to columns when _ticks_invite_list = 0. 
			// if this refresh users online list has already been populated then after columns have new data, do not reenter the populate_invite_list function because the invite buttons have already been created.
			if (_ticks_invite_list == 1 && _populated_table_body == true)
				_ticks_invite_list = Reg._maximum_server_connections;
		}
		
		else if (SceneWaitingRoom.__title_bar._spinner.visible == true
		&&		 _ticks_invite_list == Reg._maximum_server_connections)
		{			
			_populated_table_body = true;
			
			RegTriggers._waiting_room_refresh_invite_list = false;
			
			table_header();
			
			add(_table_column_sort1);
			add(_table_column_sort2);
			add(_table_column_sort3);
			add(_table_column_sort4);
			add(_table_column_sort5);
			
			SceneWaitingRoom.__title_bar._spinner.visible = false;
			
		}
		
		if (RegTypedef._dataOnlinePlayers._usernamesOnline[0] == "")
			SceneWaitingRoom.__title_bar._spinner.visible = false;
		
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
			&&  SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.visible == true
			&&  SceneWaitingRoom.__menu_bar._button_refresh_list.visible == true) 
			{
				SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.label.color = 0xFFFFFFFF;
				SceneWaitingRoom.__menu_bar._button_refresh_list.label.color = 0xFFFFFFFF;
				
				SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.active = false;
				SceneWaitingRoom.__menu_bar._button_refresh_list.active = false;
			}
			
			else
			
			{
				SceneWaitingRoom.__menu_bar._button_return_to_lobby_from_waiting_room.active = true;
				SceneWaitingRoom.__menu_bar._button_refresh_list.active = true;
			}
			
		}
		
		super.update(elapsed);
	}
}//