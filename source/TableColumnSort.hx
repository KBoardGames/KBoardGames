/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * ...table header arrows that once clicked will change the order of the table column.
 * @author kboardgames.com
 */
class TableColumnSort extends FlxSprite
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var. 
	 */
	private var _startX:Float = 0;
		
	/******************************   * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var. 
	 */
	private var _startY:Float = 0;
	
	/******************************
	 * if the first row is now the last and the last the first then _sort[0] will have a value referring to the last row in the table.
	 */
	public static var _sorted:Array<Int> = [];
	
	/******************************
	 * instance of the class.
	 */
	private var _id:Int = -1;
	
	public static var _table_column:Array<Array<Dynamic>> = [];
	private var _scene_lobby:SceneLobby;
	private var _invite_table:InviteTable;
	public static var _column:Array<Dynamic> = [];
	public static var _flipY:Array<Bool> = [false];
	
	/******************************
	 * @param	x				x location of the arrow image.
	 * @param	y				y location.
	 * @param	table			the table to use. 0: lobby: 1: waiting room.
	 * @param	table_column	the column to use. 0: the first column. 1: second.
	 */
	public function new (x:Float, y:Float, id:Int, table_column:Array<Dynamic> = null, scene_lobby = null, invite_table = null)
	{
		super(x, y);
		
		_startX = x;
		_startY = y;
		
		_id = ID = id;
		_table_column[_id] = table_column;
		
		if (scene_lobby != null)
			_scene_lobby = scene_lobby;
		
		if (invite_table != null) 
			_invite_table = invite_table;
		
		// Asc: image of up arrow for sort order of 1,2,3 etc. Desc: down.
		loadGraphic("assets/images/arrow2.png", false, 24, 24, true);
	}	
	
	override public function draw():Void
	{
		// _scrollarea_offset is needed for this class. without this code, the arrows will move with the scrollable area but their x value will remain the same value. setting offset will not work. checking if overlap exists with the mouse will not work for the arrows y value. this code works.
		if (_id == ID
		&&	FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x >= _startX
		&&	FlxG.mouse.x + ButtonGeneralNetworkYes._scrollarea_offset_x <= _startX + 24
		&&	FlxG.mouse.y >= _startY
		&&	FlxG.mouse.y <= _startY + 24
		&&	FlxG.mouse.justPressed == true
		&&	_table_column[_id] != null)
		{
			Reg._tc = _id;
			_flipY[_id] = flipY = !flipY;
			
			sort(_id);
		}
		
		if (visible == true) super.draw();
	}
	
	/******************************
	 * @param	id			column number
	 */
	public static function sort(id:Int):Void
	{
		var _count = 0;

		if (Reg._at_lobby == true) 
			_count = SceneLobby._room_total - 1;
		
		if (Reg._at_waiting_room == true)
			_count = Reg._maximum_server_connections;
		
		if (_table_column[id] != null)
		{
			for (i in 0... _count)
			{
				// add a number referring to an array element number. Array element 2 will have ":2" added to the end of that text. when it is time to sort the other columns, those columns will use this number reference so that they will be sorted the same way. 
				if (Reg._at_lobby == true && id == 0
				|| 	Reg._at_waiting_room == true && id == 101) // label.text because first column is a button. // 101 is waiting room invite button id.
				{
					if (Reg._at_lobby == true)
						_column[i] = _table_column[0][i].label.text;
					if (Reg._at_waiting_room == true)
						_column[i] = _table_column[101][i].label.text;
					
					_column[i] += ";" + Std.string(i);
				}
				
				else
				{
					if (Reg._at_lobby == true)
					{
						_column[i] = _table_column[Reg._tc][(i + 1)];
					}
					
					if (Reg._at_waiting_room == true)
					{
						_column[i] = _table_column[Reg._tc][i];
					}
				}
				
			}
			
			// Cannot properly sort numbers using strings because all numbers that start with 2 will be before the number 3. therefore, since buttons should always be displayed in reverse order to what the are displayed, we use this code block instead of the sort function.
			if (_flipY[id] == true)
			{
				if (Reg._at_lobby == true && id == 0
				|| 	Reg._at_waiting_room == true && id == 101) // 101 is waiting room invite button id.
				{
					var _reverse:Int = _count - 1;
					var _column_new = _column.copy();
					
					// _column[0] is the first column in the table. if at lobby, yhis column holds the button data.
					for (i in 0... _column.length)
					{
						_column[i] = _column_new[_reverse];
						_reverse -= 1;
					}
				}
				
				// arrow pointing in down direction.
				else
				{
					for (i in 0... _count)
					{
						//	";" is used to store the order of the buttons from top of table to bottom of table. ";" will later be .split from the array. the array will a value of 1 will be displayed first.
						// the first column was not selected but we need to put back the table as it would be displayed when first logging in. this is needed or else the sort will not sort correctly.
						if (Reg._at_lobby == true)
							_column[i] = _table_column[0][i].label.text;
						if (Reg._at_waiting_room == true)
							_column[i] = _table_column[101][i].label.text;
							
						_column[i] += ";" + Std.string(i);
					}
					
					// set the table back to default.
					if (Reg._at_lobby == true)
					{
						lobby();
						
						// not sort the column that was selected. we need + 1 for these columns because room data starts at 1 not 0. 0 is reserved for the lobby.
						for (i in 0... _count)
						{
							_column[i] = _table_column[Reg._tc][(i + 1)];
						}
					}
					
					if (Reg._at_waiting_room == true) 
					{
						waiting_room();
						
						for (i in 0... _count)
						{
							_column[i] = _table_column[Reg._tc][i];
						}
					}
					
					// remember the layout before the sort begins.
					for (i in 0... _count)
					{
						_column[i] += ";" + Std.string(i);
					}
					
					// sort using Int if at this column.
					if (id > 101 && id < 105)
					{
						_column.sort(function(a, b) 
						{
							var _a:Array<String> = a.split(";");
							var __a:Int = Std.parseInt(_a[0]);
							
							var _b:Array<String> = b.split(";");
							var __b:Int = Std.parseInt(_b[0]);
							
							if (__a < __b) 
							{				
								return -1;
							}
							
							else if (__a > __b) 
							{
								return 1;
							}
							
							else
							{
								return 0;
							}					
						});
						
					}
					
					else
					{
						_column.sort(function(a:String, b:String):Int 
						{
							a = a.toUpperCase();
							b = b.toUpperCase();
							
							if (a < b) 
							{				
								return -1;
							}
							
							else if (a > b) 
							{
								return 1;
							}
							
							else
							{
								return 0;
							}					
						});
					}
						
				}
			}
			
			else
			{
				if (id != 0 && id != 101)
				{
					
					for (i in 0... _count)
					{
						if (Reg._at_lobby == true)
							_column[i] = _table_column[0][i].label.text;
						if (Reg._at_waiting_room == true)
							_column[i] = _table_column[101][i].label.text;
						
						_column[i] += ";" + Std.string(i);
					}
					
					if (Reg._at_lobby == true) 
					{
						lobby();
					
						for (i in 0... _count)
						{
							_column[i] = _table_column[Reg._tc][(i + 1)];
						}
					}
					
					if (Reg._at_waiting_room == true)
					{
						waiting_room();
							
						for (i in 0... _count)
						{
							_column[i] = _table_column[Reg._tc][i];
						}
					}
					
					for (i in 0... _count)
					{
						_column[i] += ";" + Std.string(i);
					}
					
					// sort using Int if at this column.
					if (id > 101 && id < 105)
					{
						_column.sort(function(a, b) 
						{
							var _a:Array<String> = a.split(";");
							var __a:Int = Std.parseInt(_a[0]);
							
							var _b:Array<String> = b.split(";");
							var __b:Int = Std.parseInt(_b[0]);
							
							if (__a > __b) 
							{				
								return -1;
							}
							
							else if (__a < __b) 
							{
								return 1;
							}
							
							else
							{
								return 0;
							}
						});
					}
					
					else
					{
						_column.sort(function(a:String, b:String):Int 
						{
							a = a.toUpperCase();
							b = b.toUpperCase();
							
							if (a > b) 
							{				
								return -1;
							}
							
							else if (a < b) 
							{
								return 1;
							}
							
							else
							{
								return 0;
							}
						});
					}
				}
			}
			
			if (Reg._at_lobby == true)
				lobby();
			
			if (Reg._at_waiting_room == true) 
				waiting_room();
		}
	}
	
	public static function lobby():Void
	{
		// loop until every button is completed.
		for (i in 0... SceneLobby._room_total - 1) 
		{
			// get the reference numbers.
			var _str = _column[i].split(";");
			
			// this second loop is need to get the reference number of element i.
			for (ii in 0... SceneLobby._room_total)
			{
				// for example, when the first column was selcted, the sort was made and element i now has a reference number of the last element. so, at this first loop the last element will be read first.
				if (ii == Std.parseInt(_str[1]))
				{
					// for example. the first loop of i is now the text of the last button because the ii will be used to give the first element the last element's text.
					
					// see SceneLobby.user_input()
					SceneLobby._group_button_for_room[i].label.text 
						= SceneLobby._column1[ii].label.text;
					
					RegTypedef._dataMisc._roomHostUsername[(i + 1)]
						= SceneLobby._column2[(ii + 1)];
					
					RegTypedef._dataMisc._roomGameIds[(i + 1)] 
						= SceneLobby._column3[(ii + 1)];
					
					var _str = SceneLobby._column4[(ii + 1)].split("/");
					RegTypedef._dataMisc._roomPlayerCurrentTotal[(i + 1)] 
						= Std.parseInt(_str[0]);
					RegTypedef._dataMisc._roomPlayerLimit[(i + 1)]
						= Std.parseInt(_str[1]);					
					
					RegTypedef._dataMisc._rated_game[(i + 1)] 
						= Std.parseInt(SceneLobby._column5[(ii + 1)]);
					
					RegTypedef._dataMisc._allowSpectators[(i + 1)]
						= Std.parseInt(SceneLobby._column6[(ii + 1)]);
				}
			}		
		}
		
		// update the table at lobby but only after a input click has been made. when mouse click or key press, at SceneLobby.update() the user_input() function is entered but only when this var is true. this var is used to stop executing the user.input() function at every update elapsed.
		Reg._table_column_sort_do_once = true;	
	}
	
	public static function waiting_room():Void
	{
		// loop until every button is completed.
		for (i in 0... Reg._maximum_server_connections) 
		{
			// get the reference numbers.
			var _str = _column[i].split(";");
			
			// this second loop is need to get the reference number of element i.
			for (ii in 0... Reg._maximum_server_connections)
			{
				// for example, when the first column was selcted, the sort was made and element i now has a reference number of the last element. so, at this first loop the last element will be read first.
				if (ii == Std.parseInt(_str[1]))
				{
					_sorted[i] = ii; // new sort value. see InviteTable.hx.
					
					// for example. the first loop of i is now the text of the last button because the ii will be used to give the first element the last element's text.
					Reg._usernamesOnline[i]
						= Std.string(InviteTable._column1[ii]);
						
					InviteTable._onlineUserListInvite[i].label.text 
						= InviteTable._column2[ii].label.text;
					
					Reg._chess_elo_rating[i]
						= Std.parseFloat(Std.string(InviteTable._column3[ii]));
					
					Reg._invite_points[i]
						= Std.parseFloat(Std.string(InviteTable._column4[ii]));
					
					Reg._invite_percentage[i]
						= Std.parseFloat(Std.string(InviteTable._column5[ii]));
				}
			
			}
		}
		
		// update the table at lobby but only after a input click has been made. when mouse click or key press, at SceneLobby.update() the user_input() function is entered but only when this var is true. this var is used to stop executing the user.input() function at every update elapsed.
		Reg._table_column_sort_do_once = true;	
	}
	
	override public function destroy():Void
	{
		for (i in 0... _table_column.length)
		{
			if (_table_column[i] != null)
			{
				_table_column[i].splice(0, _table_column.length);
			}
		}
		
		_table_column.splice(0, _table_column.length);
		_column.splice(0, _column.length);
		
		super.destroy();
	}	
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._at_waiting_room == true 
		&&	InviteTable._ticks_invite_list 
		<	Reg._maximum_server_connections)
			visible = false
		else
			visible = true;
		
		if (_id == ID && visible == true) super.update(elapsed);
	}
	
}

