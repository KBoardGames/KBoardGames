/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * currently asks for a chess rank to set the chess Elo rating (named after its creator Arpad Elo) for the player but only once for a new account. a new account has an chess Elo rating of zero. if beginner rank is selected then player's Elo rating will be set to 800.
 * @author kboardgames.com
 */
class NewAccount extends FlxGroup
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar; 
	
	/******************************
	 * biginner chess skill level button.
	 */
	private var _button_b1:ButtonToggleFlxState;
	
	/******************************
	 * intermediate chess skill level button.
	 */
	private var _button_b2:ButtonToggleFlxState;
	
	/******************************
	 * advanced chess skill level button.
	 */
	private var _button_b3:ButtonToggleFlxState;
	
	/******************************
	 * save the player's chess skill level then close the scene to return to lobby.
	 */
	private var _close:ButtonGeneralNetworkNo;
	
	/******************************
	 * chess skill level text displayed on scene.
	 */
	private var _chess_skill_level:FlxText;
	
	public function new():Void
	{
		super();	
		
		FlxG.autoPause = false;
		RegTypedef._dataStatistics._chess_elo_rating = 800;
		
		if (__title_bar != null)
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("New Account");
		add(__title_bar);
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar();
		add(__menu_bar);		
		
		//#############################
		
		_chess_skill_level = new FlxText(30, 125, 0, "What is your chess skill level for online play?");
		_chess_skill_level.setFormat(Reg._fontDefault, 24);
		_chess_skill_level.scrollFactor.set();
		add(_chess_skill_level);
		
		_button_b1 = new ButtonToggleFlxState(_chess_skill_level.x + _chess_skill_level.textField.width + 15, 122, 1, "Beginner", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(1), RegCustom._button_color[Reg._tn], false);
		_button_b1.has_toggle = true;
		_button_b1.set_toggled(true);
		_button_b1.label.font = Reg._fontDefault;
		add(_button_b1);
		
		_button_b2 = new ButtonToggleFlxState(_button_b1.x + _button_b1.label.textField.width + 15, 122, 2, "Intermediate", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(2), RegCustom._button_color[Reg._tn], false);
		_button_b2.label.font = Reg._fontDefault;
		_button_b2.has_toggle = true;
		_button_b2.set_toggled(false);
		add(_button_b2);
		
		_button_b3 = new ButtonToggleFlxState(_button_b2.x + _button_b2.label.textField.width + 15, 122, 3, "Advance", 200, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, chess_skill_selected.bind(3), RegCustom._button_color[Reg._tn], false);
		_button_b3.label.font = Reg._fontDefault;
		_button_b3.has_toggle = true;
		_button_b3.set_toggled(false);
		add(_button_b3);
		
		// ButtonGeneralNetworkNo is needed here.
		_close = new ButtonGeneralNetworkNo(30, FlxG.height - 40, "Save", 150 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, saveAllConfigurations, RegCustom._button_color[Reg._tn], false, 1);
		_close.label.font = Reg._fontDefault;
		_close.screenCenter(X);
		#if html5
			_close.label.text = "Apply";
		#end
		_close.x += 400;
		add(_close);
	}
	
	private function saveAllConfigurations():Void
	{
		Reg._messageId = 11001;
		Reg._buttonCodeValues = "e1000";		
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	
	private function set_chess_elo_button_toggle():Void
	{
		_button_b1.set_toggled(false);
		_button_b1.has_toggle = false;
		
		_button_b2.set_toggled(false);
		_button_b2.has_toggle = false;
		
		_button_b3.set_toggled(false);
		_button_b3.has_toggle = false;
	}
	
	private function chess_skill_selected(_num:Int = 1):Void
	{
		set_chess_elo_button_toggle();
		
		switch (_num)
		{
			case 1:
			{
				_button_b1.set_toggled(true);
				_button_b1.has_toggle = true;
			}
			
			case 2:
			{
				_button_b2.set_toggled(true);
				_button_b2.has_toggle = true;
			}
			
			case 3:
			{
				_button_b3.set_toggled(true);
				_button_b3.has_toggle = true;
			}
				
		}
	}
	
	private function closeState():Void
	{
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		
		visible = false;
		active = false;		
	}
		
	override public function destroy()
	{		
		if (__title_bar != null)
		{
			remove(__title_bar);
			__title_bar.destroy();
			__title_bar = null;
		}
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
			__menu_bar = null;
		}
	
		if (_button_b1 != null)
		{			
			remove(_button_b1);
			_button_b1.destroy();
			_button_b1 = null;
		}
		
		if (_button_b2 != null)
		{			
			remove(_button_b2);
			_button_b2.destroy();
			_button_b2 = null;
		}
		
		if (_button_b3 != null)
		{			
			remove(_button_b3);
			_button_b3.destroy();
			_button_b3 = null;
		}
		
		if (_close != null)
		{			
			remove(_close);
			_close.destroy();
			_close = null;
		}
		
		if (_chess_skill_level != null)
		{			
			remove(_chess_skill_level);
			_chess_skill_level.destroy();
			_chess_skill_level = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "e1000")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
			if (_button_b1.has_toggle == true)
				RegTypedef._dataStatistics._chess_elo_rating = 800;
			
			else if (_button_b2.has_toggle == true)
				RegTypedef._dataStatistics._chess_elo_rating = 1200;
			
			else if (_button_b3.has_toggle == true)
				RegTypedef._dataStatistics._chess_elo_rating = 1600;
						
			PlayState.send("Save New Account Configurations", RegTypedef._dataStatistics);
			closeState();
		}
	
		// this is needed to hide lobby scrollable area when at NewAccount.hx.
		if (PlayState.__scene_lobby != null
		&&	PlayState.__scene_lobby.__scrollable_area != null)
		{
			PlayState.__scene_lobby.__scrollable_area.visible = false;
			PlayState.__scene_lobby.__scrollable_area.active = false;
		}
		
		super.update(elapsed);
	}
	
}