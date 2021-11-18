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
 * displays a table of chess Elo, game points, win percentage data for for every player at lobby.
 * @author kboardgames.com
 */
class InviteUsername extends FlxText
{
	public var _rowNumber:Int = 0;				// table row number.
	
	public function new(x:Float = 0, y:Float = 0, _fieldWidth:Float = 0, _text:String, _textSize:Int = 20, rowNumber:Int = 0)	
	{	
		super(x, y, _fieldWidth, _text, _textSize);
		
		ID = _rowNumber = rowNumber;
	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (InviteTable._populated_table_body == false
		&&	RegTriggers._waiting_room_refresh_invite_list == true)
		{
			if (ID == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[ID] != "")
				text = RegTypedef._dataOnlinePlayers._usernamesOnline[ID];
				
			else if (ID == _rowNumber)
				text = "";
			
			super.update(elapsed);
		}
	}

}
