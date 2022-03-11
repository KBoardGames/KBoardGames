/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;
import flixel.system.scaleModes.RatioScaleMode;

/**
 * Currently the menu bar only has the disconnect button. most class new this class so to get the disconnect button on their scenes.
 * @author kboardgames.com
 */
class TitleBar extends FlxGroup
{
	/******************************
	 * The invite table needs time to populated its data. This spinner is displayed so that the user knows that there will be a delay in the loading of the data.
	 */
	public var _spinner:FlxSprite;
	
	/******************************
	 * menu bar background.
	 */
	public var _background:FlxSprite;
	
	/******************************
	 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
	 */
	public var _title:FlxText;
	public static var _title_for_screenshot:String;
	
	private var _button_disconnect:ButtonGeneralNetworkNo;
	
	public function new(_text:String, _from_menuState:Bool = false) 
	{
		super();		
		
		var _color = FlxColor.fromHSB(RegCustomColors.title_bar_background_color().hue, 1, RegCustom._title_bar_background_brightness[Reg._tn]);
		
		// no saturation for gray color.
		if (RegCustom._title_bar_background_number[Reg._tn] == 13)
			_color = FlxColor.fromHSB(_color.hue, 0, RegCustom._client_background_brightness[Reg._tn]);
		
		if (RegCustom._title_bar_background_number[Reg._tn] == 1)
			_color = FlxColor.WHITE;
		else if (RegCustom._title_bar_background_number[Reg._tn] == 12)
			_color = FlxColor.BLACK;
		
		if (_background != null) 
		{
			remove(_background);
			_background.destroy();
		}
		
		_background = new FlxSprite(0, Reg.__title_bar_offset_y);
		_background.makeGraphic(FlxG.width, 55, _color);
		_background.color.brightness = RegCustom._title_bar_background_brightness[Reg._tn];
		_background.scrollFactor.set(0,0);
		add(_background);
		
		var _offset_y:Int = -5;
		
		#if html5
			_offset_y = - 15;
		#end
		
		if (_title != null) 
		{
			remove(_title);
			_title.destroy();
		}
		
		_title = new FlxText(80, 4 + Reg.__title_bar_offset_y + _offset_y, 0, _text);
		_title.setFormat(Reg._fontDefault, 50, RegCustomColors.title_bar_text_color());
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		
		_title_for_screenshot = _title.text;
		
		if (Reg._at_lobby == true
		||	Reg._at_waiting_room == true) _title.scrollFactor.set(1,0);
		else _title.scrollFactor.set(0,0);
		add(_title);
		
		if (_spinner != null) 
		{
			remove(_spinner);
			_spinner.destroy();
		}
		
		_spinner = new FlxSprite(0, 0);
		_spinner.loadGraphic("assets/images/spinner.png", true, 64, 64);
		_spinner.animation.add("play", [0, 1, 2, 3, 4, 5, 6, 7], 45);
		_spinner.animation.play("play");
		_spinner.visible = false;
		if (Reg._at_lobby == true
		||	Reg._at_waiting_room == true) _spinner.scrollFactor.set(1,0);
		else _spinner.scrollFactor.set(0,0);
		add(_spinner);
	}
	
	public function update_text(_text:String):Void
	{	
		_title.text = _text;
	}
	
	override public function destroy():Void
	{
		if (_spinner != null)
		{
			remove(_spinner);
			_spinner.destroy();
			_spinner = null;
		}
		
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
			_title = null;
		}
		
		if (_button_disconnect != null)
		{
			remove(_button_disconnect);
			_button_disconnect.destroy();
			_button_disconnect = null;
		}
		
		super.destroy();
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		RegFunctions.sound(0);
		super.update(elapsed);
	}
}