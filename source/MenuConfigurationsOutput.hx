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
 * this class is created when clicking the gear button. It is used to display scrollbar configuration content of either games, general or profile category.
 * .
 * @author kboardgames.com
 */
class MenuConfigurationsOutput extends FlxGroup
{
	private var _offset_x:Int = -50;
	private var _offset_y:Int = 50;
	private var _offset:Int = 30;	
	
	private var _button_general:ButtonToggleFlxState;
	private var _button_profile:ButtonToggleFlxState;
	private var _button_games:ButtonToggleFlxState;
	
	/******************************
	 * An area of the screen that has automatic scrollbars, if needed.
	 */
	public var __boxscroller:FlxScrollableArea;	
	public var _bg_color:Int = 0;
	
	public var _title:FlxText; // title of a scene.
	
	// theme menu.
	private var _button_theme_minus:ButtonGeneralNetworkNo;
	private var _button_theme:ButtonGeneralNetworkNo;
	private var _button_theme_plus:ButtonGeneralNetworkNo;
	
	/******************************
	 * this is the "Configuration Menu: " for the title text that a scene can add to. when clicking a button at the SceneMenu, the scene name will append to this var. for example, "Configuration Menu: Avatars.".
	 */
	private var _text_for_title:String = "Configuration Menu: ";
	
	public var __menu_configurations_general:MenuConfigurationsGeneral;
	public var __menu_configurations_profile:MenuConfigurationsProfile;
	public var __menu_configurations_games:MenuConfigurationsGames;
	
	private var __menu_bar:MenuBar;
	private var _save:ButtonGeneralNetworkNo;
	
	override public function new():Void
	{
		super();
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		Reg2.resetRegVars();
		
		//------------------------------
		RegFunctions._gameMenu = new FlxSave(); // initialize		
		RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
		
		_title = new FlxText(15, 0, 0, _text_for_title + "General");
		_title.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title.scrollFactor.set(0, 0);
				
		initialize();
		
		// a negative x value moves the boxScroller in the opposite direction.
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea(new FlxRect( 0, 0, FlxG.width, FlxG.height - 50), __menu_configurations_profile._group.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 100, true);		
		_bg_color = FlxG.random.int(1, 360);
		__boxscroller.bgColor = FlxColor.fromHSB(_bg_color, 0.8, RegCustom._background_brightness[Reg._tn]);
		FlxG.cameras.add( __boxscroller );
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
		
		//----------------------------
		__menu_bar = new MenuBar(true);
		add(__menu_bar);
		
		// save. avatars, general configuration toggle buttons at menu bar.
		sceneMenuButtons();
				
		__menu_configurations_profile.active = false;
		__menu_configurations_games.active = false;
		__menu_configurations_general.active = true;
		__menu_configurations_general._group.visible = true;
		
		// do not add anymore button class here.
		buttonGeneral();		
		
		//-----------------------------
		// none scrollable background behind title.
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, 50, 0xFF000000);
		background.setPosition(0, 0);
		background.scrollFactor.set(0, 0);
		add(background);	
		
		add(_title);		
		
		theme_menu();
		button_theme_should_hide();
	}
	
	public function initialize():Void
	{
		if (__menu_configurations_general != null)
			remove(__menu_configurations_general);
		
		__menu_configurations_general = new MenuConfigurationsGeneral(this);
		add(__menu_configurations_general);
		
		if (__menu_configurations_profile != null)
			remove(__menu_configurations_profile);
		
		__menu_configurations_profile = new MenuConfigurationsProfile(this);
		add(__menu_configurations_profile);
		
		if (__menu_configurations_games != null)
			remove(__menu_configurations_games);
			
		__menu_configurations_games = new MenuConfigurationsGames(this);
		add(__menu_configurations_games);
		
	}
	
	public function buttonToggle():Void
	{
		if (_button_general != null)
		{
			_button_general.has_toggle = false;
			_button_general.set_toggled(false);
			
			__menu_configurations_general._group.active = false;
			__menu_configurations_general._group.visible = false;
		}
				
		if (_button_profile != null)
		{
			_button_profile.has_toggle = false;
			_button_profile.set_toggled(false);
			
			__menu_configurations_profile._group.active = false;
			__menu_configurations_profile._group.visible = false;
		}
				
		if (_button_games != null)
		{
			_button_games.has_toggle = false;
			_button_games.set_toggled(false);
			
			__menu_configurations_games._group.active = false;
			__menu_configurations_games._group.visible = false;		
		}
	
	}	
	
	/******************************
	 * this displays the avatars and player name fields for either player 1 or player 2.
	 */
	public function buttonProfile():Void
	{
		_title.text = _text_for_title + "Profile.";
		
		buttonToggle();
		
		if (__menu_configurations_profile != null
		&&	_button_profile != null)
		{
			_button_profile.has_toggle = true;
			_button_profile.set_toggled(true);	
		}
		
		__menu_configurations_profile.active = true;
		__menu_configurations_profile._group.active = true;
		__menu_configurations_profile._group.setPosition(0, 0);
		__menu_configurations_profile._group.visible = true;
		
		__menu_configurations_general.active = true;
		__menu_configurations_general._group.setPosition( -5000, 0);
		__menu_configurations_general.active = false;
		
		__menu_configurations_games.active = true;
		__menu_configurations_games._group.setPosition(-5000, 0);
		__menu_configurations_games.active = false;
		
		__boxscroller.content = __menu_configurations_profile._group.getHitbox();
		__boxscroller._verticalScrollbar._content_height = __menu_configurations_profile._group.height;
		__boxscroller.scroll.y = 0; // bring the scrollbar back to the top.
		__boxscroller._verticalScrollbar._stale = true; // redraw the bar.
	}
	
	/******************************
	 * this displays the game board and its colors.
	 */
	public function buttonGeneral():Void
	{
		_title.text = _text_for_title + "General.";
		
		buttonToggle();
		
		if (_button_general != null)
		{
			_button_general.has_toggle = true;
			_button_general.set_toggled(true);	
		}
		
		__menu_configurations_general.active = true;
		__menu_configurations_general._group.active = true;
		__menu_configurations_general._group.setPosition(0, 0);
		__menu_configurations_general._group.visible = true;		
		
		__menu_configurations_games.active = true;
		__menu_configurations_games._group.setPosition( -5000, 0);
		__menu_configurations_games.active = false;
		
		__menu_configurations_profile.active = true;
		__menu_configurations_profile._group.setPosition(-5000, 0);
		__menu_configurations_profile.active = false;
		
		__boxscroller.content = __menu_configurations_general._group.getHitbox();
		__boxscroller._verticalScrollbar._content_height = __menu_configurations_general._group.height;
		__boxscroller.scroll.y = 0; // bring the scrollbar back to the top.
		__boxscroller._verticalScrollbar._stale = true; // redraw the bar.
		
	}
	
	private function theme_menu():Void
	{
		var ii = 0;
		
		for (i in 0... Reg._tn + 1)
		{
			if (RegCustom._theme_name[i] == RegCustom._theme_name_current)
			{
				ii = i;
			}
		}
				
		var _text = new FlxText(870, 5, 0, "Theme", Reg._font_size);
		_text.font = Reg._fontDefault;
		_text.scrollFactor.set(0, 0);
		add(_text);
		
		_button_theme = new ButtonGeneralNetworkNo(960, 5, RegCustom._theme_name[ii].substr(0, RegCustom._theme_name[ii].length-5), 275, 35, Reg._font_size, 0xffffffff, 0, null, 0xff111111);
		_button_theme.label.font = Reg._fontDefault;
		add(_button_theme);
		
		_button_theme_minus = new ButtonGeneralNetworkNo(1250, 5, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_theme_minus, RegCustom._button_color[Reg._tn]);
		_button_theme_minus.label.font = Reg._fontDefault;
		_button_theme_minus.visible = false;
		_button_theme_minus.active = false;
		add(_button_theme_minus);
		
		_button_theme_plus = new ButtonGeneralNetworkNo(1300, 5, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_theme_plus, RegCustom._button_color[Reg._tn]);
		_button_theme_plus.label.font = Reg._fontDefault;
		_button_theme_plus.visible = false;
		_button_theme_plus.active = false;
		add(_button_theme_plus);
	}
	
	/******************************
	 * changes the current theme to a different theme.
	 */
	private function button_theme_minus():Void
	{			
		if (Reg._tn > 0)
		{
			Reg._tn -= 1;
			
			_button_theme.label.text = RegCustom._theme_name[Reg._tn].substr(0, RegCustom._theme_name[Reg._tn].length - 5);
			
			_button_theme_plus.visible = true;
			_button_theme_plus.active = true;
		}
		
		button_theme_should_hide();
				
		RegCustom.assign_colors();
		
		if (__menu_bar != null) 
		{
			__menu_bar.visible = false;
			remove(__menu_bar);
		}
		
		__menu_bar = new MenuBar(true);
			add(__menu_bar);
		
		sceneMenuButtons();
		initialize();
		buttonGeneral();
		
	}
	
	/******************************
	 * changes the current theme to a different theme.
	 */
	private function button_theme_plus():Void
	{		
		if (Reg._tn < Reg._tn_total)
		{
			Reg._tn += 1;
			
			_button_theme.label.text = RegCustom._theme_name[Reg._tn].substr(0, RegCustom._theme_name[Reg._tn].length - 5);
			
			_button_theme_minus.visible = true;
			_button_theme_minus.active = true;
		}
		
		button_theme_should_hide();
		
		RegCustom.assign_colors();
		
		if (__menu_bar != null) 
		{
			__menu_bar.visible = false;
			remove(__menu_bar);
		}
		
		__menu_bar = new MenuBar(true);
			add(__menu_bar);
			
		sceneMenuButtons();
		initialize();
		buttonGeneral();
		
	}
	
	private function button_theme_should_hide():Void
	{
		// hide the button if at the beginning of the list.
		if (Reg._tn > 0) {} 
		else if (Reg._tn <= 0 && Reg._tn_total > 0)
		{
			_button_theme_minus.active = false;
			_button_theme_minus.visible = false;
			
			_button_theme_plus.visible = true;
			_button_theme_plus.active = true;
		}
		
		if (Reg._tn < Reg._tn_total) {}
		else if (Reg._tn >= Reg._tn_total && Reg._tn_total > 0)
		{
			_button_theme_minus.active = true;
			_button_theme_minus.visible = true;
			
			_button_theme_plus.visible = false;
			_button_theme_plus.active = false;
		}
	}
	
	public function buttonGames():Void
	{
		_title.text = _text_for_title + "Games.";
		
		buttonToggle();
		
		if (_button_games != null)
		{
			_button_games.has_toggle = true;
			_button_games.set_toggled(true);	
		}
		
		__menu_configurations_games.active = true;
		__menu_configurations_games._group.active = true;
		__menu_configurations_games._group.setPosition(0, 0);
		__menu_configurations_games._group.visible = true;
		
		__menu_configurations_general.active = true;
		__menu_configurations_general._group.setPosition( -5000, 0);
		__menu_configurations_general.active = false;
		
		__menu_configurations_profile.active = true;
		__menu_configurations_profile._group.setPosition(-5000, 0);
		__menu_configurations_profile.active = false;
				
		__boxscroller.content = __menu_configurations_games._group.getHitbox();
		__boxscroller._verticalScrollbar._content_height = __menu_configurations_games._group.height;
		__boxscroller.scroll.y = 0; // bring the scrollbar back to the top.
		__boxscroller._verticalScrollbar._stale = true; // redraw the bar.
	}
	
	
	private function sceneMenuButtons():Void
	{
		if (_save != null) remove(_save); 
		_save = new ButtonGeneralNetworkNo(0, FlxG.height - 40, "Save Theme", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, saveConfig, RegCustom._button_color[Reg._tn], false, 1);
		_save.label.font = Reg._fontDefault;
		_save.screenCenter(X);
		_save.x += 400;
		add(_save);
		
		if (_button_profile != null)
		{
			_button_profile.visible = false;
			remove(_button_profile);
			_button_profile = null;
		}
		
		if (_button_general != null)
		{
			_button_general.visible = false;
			remove(_button_general);
			_button_general = null;
		}
		
		if (_button_games != null)
		{
			_button_games.visible = false;
			remove(_button_games);
			_button_games = null;
		}
				
		
	}

	/******************************
	 * when the save button is pressed this code saves the configurations made for all options made at the configuration menu.
	 */
	private function saveConfig():Void
	{
		if (__menu_configurations_profile._button_p1.has_toggle == true)
			__menu_configurations_profile._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1[Reg._tn]);
		else
			__menu_configurations_profile._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number2[Reg._tn]);
		
		RegFunctions.saveConfig();
	}
	
	override public function update(elapsed:Float):Void
	{
		// send the offset of the boxScroller to the button class so that when scrolling the boxScroller, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
		ButtonGeneralNetworkNo._scrollarea_offset_x = __boxscroller.scroll.x;
		ButtonGeneralNetworkNo._scrollarea_offset_y = __boxscroller.scroll.y;
		ButtonToggleFlxState._scrollarea_offset_x = __boxscroller.scroll.x;
		ButtonToggleFlxState._scrollarea_offset_y = __boxscroller.scroll.y;
		
		if (RegTriggers._config_menu_save_notice == true)
		{
			RegTriggers._config_menu_save_notice = false;
			
			__menu_configurations_general._button_shade_even_units_minus.active = false;
			__menu_configurations_general._button_shade_even_units_plus.active = false;		
			__menu_configurations_general._button_shade_odd_units_minus.active = false;
			__menu_configurations_general._button_shade_odd_units_plus.active = false;
			
			__menu_configurations_general._button_color_even_units_minus.active = false;
			__menu_configurations_general._button_color_even_units_plus.active = false;		
			__menu_configurations_general._button_color_odd_units_minus.active = false;
			__menu_configurations_general._button_color_odd_units_plus.active = false;
			
			Reg._messageId = 9001;
			Reg._buttonCodeValues = "v1000";			
			SceneGameRoom.messageBoxMessageOrder();			
		}
				
		if (__menu_bar != null)
		{
			if (_button_profile == null)
			{
				_button_profile = new ButtonToggleFlxState(15, FlxG.height - 40, 2, "Profile", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonProfile, RegCustom._button_color[Reg._tn]);
				_button_profile.label.font = Reg._fontDefault;
				_button_profile.has_toggle = false;
				_button_profile.set_toggled(false);
				_button_profile.screenCenter(X);
				_button_profile.x += 97; // half of button (90) + half of 15 rounded down (7);
				add(_button_profile);
				
				_button_general = new ButtonToggleFlxState(_button_profile.x - 195, FlxG.height - 40, 1, "General", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonGeneral, RegCustom._button_color[Reg._tn]);
				_button_general.label.font = Reg._fontDefault;
				_button_general.has_toggle = true;
				_button_general.set_toggled(true);
				add(_button_general);
						
				_button_games = new ButtonToggleFlxState(_button_general.x - 195, FlxG.height - 40, 2, "Games", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonGames, RegCustom._button_color[Reg._tn]);
				_button_games.label.font = Reg._fontDefault;
				_button_games.has_toggle = false;
				_button_games.set_toggled(false);
				add(_button_games);
			}
			
		}
				
		super.update(elapsed);
		_button_theme.active = false;
	}
}