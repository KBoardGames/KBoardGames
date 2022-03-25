/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * lobby scrollable area data, such as, room state, room game. 
 * @author kboardgames.com
 */
class SceneLobbyGameSpectatorsText extends FlxText
{
	public var _id:Int = 0;
	
	public function new(x:Float = 0, y:Float = 0, _fieldWidth:Float = 0, _text:String, _textSize:Int = 20, id:Int = 0)	
	{	
		super(x, y, _fieldWidth, _text, _textSize);
		
		_id = id;
	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (Reg._at_lobby == false) return;
		
		// this code is needed so that it refreshes the lobby scrollable area data without new the text.
		for (i in 0... SceneLobby._room_total)
		{
			var _host:String = RegTypedef._dataMisc._roomHostUsername[i];
			var _allow = RegTypedef._dataMisc._allowSpectators[i];
			var _title:String = "False";
		
			if (_allow == 1) _title = "True";
			
			if (i == _id ) 
			{
				if (_host != ""
				&&	RegTypedef._dataMisc._roomState[i] != 2) // if hosting a game.
				{
					if (_id < 2) // computer games.
					{
						text = "False";
					}
					
					else text = _title;
				}
				
				else text = " ";
			} 
		}
		
		
		super.update(elapsed);
	}

}
