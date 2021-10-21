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
 * Currently the menu bar only has the disconnect button. most class new this class so to get the disconnect button on their scenes.
 * @author kboardgames.com
 */
class TitleBar extends FlxGroup
{
	/******************************
	 * menu bar background.
	 */
	public var _background:FlxSprite;
	
	/******************************
	 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
	 */
	private var _title:FlxText;
		 
	public function new(_text:String) 
	{
		super();
		
		var _color = FlxColor.fromHSB(RegCustomColors.title_bar_background_color().hue, 1, RegCustom._title_bar_background_brightness[Reg._tn]);
		
		_background = new FlxSprite(0, 0);
		_background.makeGraphic(FlxG.width, 55, _color);
		_background.color.brightness = RegCustom._title_bar_background_brightness[Reg._tn];
		_background.scrollFactor.set(0,0);
		add(_background);
		
		_title = new FlxText(15, 4, 0, _text);
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		if (Reg._at_lobby == true
		||	Reg._at_waiting_room == true) _title.scrollFactor.set(1,0);
		else _title.scrollFactor.set(0,0);
		add(_title);
	}
	
	public function update_text(_text:String):Void
	{
		_title.text = _text;
	}
}