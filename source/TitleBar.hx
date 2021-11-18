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
	* Saves the bool value of fullscreen.
	*/
	private var _gameMenu:FlxSave;
	
	/******************************
	 * menu bar background.
	 */
	public var _background:FlxSprite;
	
	/******************************
	 * at house, when map is moved, an scene XY offset is needed to position and move the items on the map correctly. the map is scrolled using a camera but that camera does all other scenes. so when that camera is displaying a different part of the scene then it does so for the other scenes. this is the fix so that the other scenes are not effected by an offset.
	 */
	public var _title:FlxText;
	
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
		
		_background = new FlxSprite(0, Reg.__title_bar_offset_y);
		_background.makeGraphic(FlxG.width, 55, _color);
		_background.color.brightness = RegCustom._title_bar_background_brightness[Reg._tn];
		_background.scrollFactor.set(0,0);
		add(_background);
		
		_title = new FlxText(15, 4 + Reg.__title_bar_offset_y, 0, _text);
		_title.setFormat(Reg._fontDefault, 50, RegCustomColors.title_bar_text_color());
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		if (Reg._at_lobby == true
		||	Reg._at_waiting_room == true) _title.scrollFactor.set(1,0);
		else _title.scrollFactor.set(0,0);
		add(_title);
		
		#if !html5
			if (Reg._at_menu_state == true)
			{
				// width is 35 + 15 extra pixels for the space between the button at the edge of screen.
				if (_button_disconnect != null)
				{
					remove(_button_disconnect);
					_button_disconnect.destroy();
				}
				
				_button_disconnect = new ButtonGeneralNetworkNo(FlxG.width - 60, 20, "X", 45, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, disconnect.bind(), 0xFFCC0000, false, 9999);
				_button_disconnect.scrollFactor.set(0, 0);
				_button_disconnect.label.font = Reg._fontDefault;
				_button_disconnect.active = true;
				add(_button_disconnect);
			}
		#end
	}
	
	/******************************
	 * "X" button on this menu bar.
	 */
	private function disconnect():Void
	{
		if (Reg._at_menu_state == true)
		{
			if (Reg2._ipAddressLoaded != "")
			{
				#if !html5
					// save data
					if (_gameMenu == null) _gameMenu = new FlxSave(); // initialize
					
					_gameMenu.bind("LoginData"); // bind to the named save slot.
					_gameMenu.data.fullscreen = FlxG.fullscreen;
					
					_gameMenu.flush();
					_gameMenu.close();
				#end
			}
			
			#if cpp
				Sys.exit(0);
			#else
				openfl.system.System.exit(0);
			#end
		}
	}
	
	public function update_text(_text:String):Void
	{	
		_title.text = _text;
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		#if !html5
			if (Reg._at_menu_state == true)
			{
				
				// This class has no onResize function. So, use this code here.
				if (FlxG.fullscreen == true 
				&&	_button_disconnect.active == false)
				{
					_button_disconnect.active = true;
					_button_disconnect.visible = true;
					
					if (Lib.application.window.resizable == false)
						Lib.application.window.resizable = true;
				}
			}
			
			if (Reg._at_menu_state == true)
			{
				if (FlxG.fullscreen == false 
				&&	_button_disconnect.active == true)
				{
					_button_disconnect.visible = false;
					_button_disconnect.active = false;
					
					if (Lib.application.window.resizable == true)
						Lib.application.window.resizable = false;
				}
			}
			
		#end
		
		super.update(elapsed);	
	}
}