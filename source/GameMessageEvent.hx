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
 * When a event text is mouse clicked at the event schedule, this sub state is displayed. this class shows the event name and the event description with a close button that once clicked will return the user back to the event schedule scene.
 * @author kboardgames.com
 */
class GameMessageEvent extends FlxSubState
{	
	public function new(_str:String):Void
	{
		super();	
		
		persistentDraw = false;
		persistentUpdate = false;
		
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, 0xFF000066);
		background.setPosition(0, 0);
		background.scrollFactor.set();	
		background.screenCenter(X);
		add(background);	
		
		var i:Int = 0;
		
		// get the event name and description from the data passed to this class from EventSchedule.hx.
		for (ii in 0...40) // 40 is max for this board game.
		{
			if (_str == Reg2._eventName[ii]) 
			{
				i = ii; 
				break;
			}
		}
		
		var _title = new FlxText(0, 0, 0, "Event Discription");
		_title.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title.scrollFactor.set();
		_title.setPosition(15, 15);
		_title.screenCenter(X);
		add(_title);
		
		var _eventTitle = new FlxText(0, 0, 0, Reg2._eventName[i]);
		_eventTitle.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_eventTitle.scrollFactor.set();
		_eventTitle.setPosition(50, 75);
		add(_eventTitle);
		
		var _eventDescription = new FlxText(0, 0, 0, Reg2._eventDescription[i]);
		_eventDescription.setFormat(Reg._fontDefault, 24);
		_eventDescription.scrollFactor.set();
		_eventDescription.fieldWidth = FlxG.width - 100;
		_eventDescription.setPosition(50, 135);
		add(_eventDescription);
		
		var _close = new ButtonGeneralNetworkNo(FlxG.width - 178, FlxG.height - 85, "Exit", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, closeSubstate, RegCustom._button_color[Reg._tn]);
		_close.label.font = Reg._fontDefault;
		add(_close);
	}
	
	private function closeSubstate():Void
	{
		close();		
	}

}