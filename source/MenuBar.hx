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
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * Currently the menu bar only has the disconnect button. most class new this class so to get the disconnect button on their scenes.
 * @author kboardgames.com
 */
class MenuBar extends FlxGroup
{
	/******************************
	 * 
	 * @param	_from_menuState		true if somewhere at the menu state. The player has not connected yet and might be at the help scene or credits scene. this is needed because if at playState then the disconnect button will trigger a close but if not connected then this is used to return to menu state.
	 * @param	_at_chatter			is player at the chatter. This is used to create a small red bar underneath the chatter background. this is needed because at waiting room this red bar will not go in front of the chatter background, so another new to this class is needed at chatter.
	 */
	override public function new(_from_menuState:Bool = false, _at_chatter:Bool = false):Void
	{
		super();
		
		var _background:FlxSprite;
		
		if (_at_chatter == false) 
		{
			_background = new FlxSprite(0, FlxG.height - 50);
			_background.makeGraphic(FlxG.width, 50, Reg._menubar_color);
		}
		else 
		{
			_background = new FlxSprite(FlxG.width-373, FlxG.height - 50);
			_background.makeGraphic(FlxG.width-373, 50, Reg._menubar_color);
		}
		
		_background.scrollFactor.set(0, 0);	
		add(_background);
			
		// width is 35 + 15 extra pixels for the space between the button at the edge of screen.
		var _button_disconnect = new ButtonGeneralNetworkYes(FlxG.width - 60, FlxG.height - 40, "X", 45, 35, Reg._font_size, 0xFFCCFF33, 0, disconnect.bind(_from_menuState), 0xFFCC0000, false);
		_button_disconnect.scrollFactor.set(0, 0);
		_button_disconnect.label.font = Reg._fontDefault;
		add(_button_disconnect);
	}

	private function disconnect(_from_menuState:Bool = false):Void
	{
		RegCustom.resetConfigurationVars();
		Reg2._miscMenuIparameter = 0;
		
		if (GameChatter.__boxscroller2 != null)	GameChatter.__boxscroller2 = null;
		if (GameChatter.__boxscroller3 != null)	GameChatter.__boxscroller3 = null;
		if (GameChatter.__boxscroller4 != null)	GameChatter.__boxscroller4 = null;
		
		if (_from_menuState == false) Reg._disconnectNow = true;
		else FlxG.switchState(new MenuState());
	}
}