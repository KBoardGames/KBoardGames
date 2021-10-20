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
 * lobby scrollable area data, such as, room state, room game. 
 * @author kboardgames.com
 */
class SceneLobbyGameTitleText extends FlxText
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
		// this code is needed so that it refreshes the lobby scrollable area data without new the text.
		for (i in 0...27)
		{			
			if (i == _id) 
			{
				if (RegTypedef._dataMisc._roomHostUsername[i] != "")
				{
					var _title = RegFunctions.gameName(RegTypedef._dataMisc._roomGameIds[i]);
					text = _title;
				}
				
				else text = " ";
			}
		}	
		
		super.update(elapsed);
	}

}
