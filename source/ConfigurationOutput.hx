/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

#if avatars
	import modules.avatars.Avatars;
#end


/**
 * this class is created when clicking the gear button. It is used to display scrollbar configuration content of either games, general or profile category.
 * .
 * @author kboardgames.com
 */
class ConfigurationOutput extends FlxGroup
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar;
	
	private var _offset_x:Int = -50;
	private var _offset_y:Int = 50;
	private var _offset:Int = 30;	
	
	private var _button_general:ButtonToggleFlxState;
	private var _button_profile:ButtonToggleFlxState;
	private var _button_games:ButtonToggleFlxState;
	
	/******************************
	 * loads a gradient background.
	 */
	private var _background_gradient_scene:FlxSprite;
	
	/******************************
	 * An area of the screen that has automatic scrollbars, if needed.
	 */
	public var __scrollable_area:FlxScrollableArea;	
	public var _bg_color:Int = 0;
	
	// theme menu.
	private var _button_theme_minus:ButtonGeneralNetworkNo;
	private var _button_theme:ButtonGeneralNetworkNo;
	private var _button_theme_plus:ButtonGeneralNetworkNo;
	
	public var __configurations_general:ConfigurationGeneral;
	public var __configurations_profile:ConfigurationProfile;
	public var __configurations_games:ConfigurationGames;
	
	private var _save:ButtonGeneralNetworkNo;
	
	override public function new():Void
	{
		super();
		
		FlxG.autoPause = false;
		Reg2.resetRegVars();
		
		CID3._user_account_row = 5;
		initialize();
		
		// a negative x value moves the scrollable area in the opposite direction.
		if (__scrollable_area != null) 
		{
			FlxG.cameras.remove(__scrollable_area);
			
			__scrollable_area.destroy();
			__scrollable_area = null;
		}
		
		__scrollable_area = new FlxScrollableArea(new FlxRect( 0, 0, FlxG.width, FlxG.height - 50), CID3._group.getHitbox(), ResizeMode.FIT_WIDTH, 0, 100, -1, FlxColor.LIME, null, 1000, true);
			
		FlxG.cameras.add( __scrollable_area );
		__scrollable_area.antialiasing = true;
		__scrollable_area.pixelPerfectRender = true;
		
		//-----------------------------
		if (__title_bar != null) 
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Configuration.");
		add(__title_bar);
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar(true);
		add(__menu_bar);
		
		// save. avatars, general configuration toggle buttons at menu bar.
		sceneMenuButtons();
				
		__configurations_profile.active = false;
		__configurations_games.active = false;
		__configurations_general.active = false;
		//CID2._group.visible = true;
		
		// do not add anymore button class here.
		switch (Reg2._configuration_jump_to_scene)
		{
			case 0: buttonGames();
			case 1: buttonGeneral();	
			case 2: buttonProfile();	
		}
		
		theme_menu();
		button_theme_should_hide();
	}
	
	public function initialize():Void
	{
		if (__configurations_general != null)
		{
			remove(__configurations_general);
			__configurations_general.destroy();
		}
		
		__configurations_general = new ConfigurationGeneral(this);
		add(__configurations_general);
		
		if (__configurations_profile != null)
		{
			remove(__configurations_profile);
			__configurations_profile.destroy();
		}
		
		__configurations_profile = new ConfigurationProfile(this);
		add(__configurations_profile);
		
		if (__configurations_games != null)
		{
			remove(__configurations_games);
			__configurations_games.destroy();
		}
		
		__configurations_games = new ConfigurationGames();
		add(__configurations_games);
		
	}
		
	public function buttonToggle():Void
	{
		if (_button_general != null)
		{
			_button_general.has_toggle = false;
			_button_general.set_toggled(false);
			
			CID2._group.active = false;
			CID2._group.visible = false;
		}
				
		if (_button_profile != null)
		{
			_button_profile.has_toggle = false;
			_button_profile.set_toggled(false);
			
			CID3._group.active = false;
			CID3._group.visible = false;
		}
				
		if (_button_games != null)
		{
			_button_games.has_toggle = false;
			_button_games.set_toggled(false);
			
			CID1._group.active = false;
			CID1._group.visible = false;		
		}
	
	}	
		
	public function buttonGames():Void
	{
		buttonToggle();
		
		if (_button_games != null)
		{
			_button_games.has_toggle = true;
			_button_games.set_toggled(true);	
		}
		
		__configurations_games.active = true;
		CID1._group.active = true;
		CID1._group.setPosition(0, 0);
		CID1._group.visible = true;
		
		__configurations_general.active = true;
		CID2._group.setPosition( -5000, 0);
		__configurations_general.active = false;
		
		__configurations_profile.active = true;
		CID3._group.setPosition(-5000, 0);
		__configurations_profile.active = false;
				
		__scrollable_area.content = CID1._group.getHitbox();
		__scrollable_area._verticalScrollbar._content_height = CID1._group.height;
		__scrollable_area._verticalScrollbar._stale = true; // redraw the bar.
		
		// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
		CID1._group.y = 770;
		__scrollable_area.content.y = 770;
		
		if (Reg.__scrollable_area_scroll_y > 0) 
		{			
			__scrollable_area.scroll.y = Reg.__scrollable_area_scroll_y;
			Reg.__scrollable_area_scroll_y = 0;
		}
		else __scrollable_area.scroll.y = 770;
	}
	
	/******************************
	 * this displays the game board and its colors.
	 */
	public function buttonGeneral():Void
	{	
		buttonToggle();
		
		if (_button_general != null)
		{
			_button_general.has_toggle = true;
			_button_general.set_toggled(true);	
		}
		
		__configurations_general.active = true;
		CID2._group.active = true;
		CID2._group.setPosition(0, 0);
		CID2._group.visible = true;		
		
		__configurations_games.active = true;
		CID1._group.setPosition( -5000, 0);
		__configurations_games.active = false;
		
		__configurations_profile.active = true;
		CID3._group.setPosition(-5000, 0);
		__configurations_profile.active = false;
		
		__scrollable_area.content = CID2._group.getHitbox();
		__scrollable_area._verticalScrollbar._content_height = CID2._group.height;
		__scrollable_area._verticalScrollbar._stale = true; // redraw the bar.
		
		// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
		CID2._group.y = 770;
		__scrollable_area.content.y = 770;
		
		if (Reg.__scrollable_area_scroll_y > 0) 
		{			
			__scrollable_area.scroll.y = Reg.__scrollable_area_scroll_y;
			Reg.__scrollable_area_scroll_y = 0;
		}
		else __scrollable_area.scroll.y = 770;
	}
	
	/******************************
	 * this displays the avatars and player name fields for either player 1 or player 2.
	 */
	public function buttonProfile():Void
	{
		buttonToggle();
		
		if (__configurations_profile != null
		&&	_button_profile != null)
		{
			_button_profile.has_toggle = true;
			_button_profile.set_toggled(true);	
		}
		
		__configurations_profile.active = true;
		CID3._group.active = true;
		CID3._group.setPosition(0, 0);
		CID3._group.visible = true;
		
		__configurations_general.active = true;
		CID2._group.setPosition( -5000, 0);
		__configurations_general.active = false;
		
		__configurations_games.active = true;
		CID1._group.setPosition(-5000, 0);
		__configurations_games.active = false;
		
		__scrollable_area.content = CID3._group.getHitbox();
		__scrollable_area._verticalScrollbar._content_height = CID3._group.height;
		__scrollable_area._verticalScrollbar._stale = true; // redraw the bar.
		
		// when using __scrollable_area we need to put the camera off screen so that the normal FlxStage buttons do not fire when the __scrollable_area y value is offset. So if the __scrollable_area is y offset by 300, the FlxState underneath will still fire the buttons that were added to the stage at the same FlxState y values.
		CID3._group.y = 770;
		__scrollable_area.content.y = 770;
		
		if (Reg.__scrollable_area_scroll_y > 0) 
		{			
			__scrollable_area.scroll.y = Reg.__scrollable_area_scroll_y;
			Reg.__scrollable_area_scroll_y = 0;
		}
		else __scrollable_area.scroll.y = 770;
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
				
		var _text = new FlxText(870, 15 + Reg.Reg.__title_bar_offset_y, 0, "Theme", Reg._font_size);
		_text.font = Reg._fontDefault;
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_text.color = RegCustomColors.client_text_color();
		_text.scrollFactor.set(0, 0);
		add(_text);
		
		_button_theme = new ButtonGeneralNetworkNo(960, 12 + Reg.__title_bar_offset_y, RegCustom._theme_name[ii].substr(0, RegCustom._theme_name[ii].length-5), 275, 35, Reg._font_size, 0xffffffff, 0, null, 0xff111111);
		_button_theme.label.font = Reg._fontDefault;
		add(_button_theme);
		
		_button_theme_minus = new ButtonGeneralNetworkNo(1250, 12 + Reg.__title_bar_offset_y, "-", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_theme_minus, RegCustom._button_color[Reg._tn]);
		_button_theme_minus.label.font = Reg._fontDefault;
		_button_theme_minus.visible = false;
		_button_theme_minus.active = false;
		add(_button_theme_minus);
		
		if (Reg._tn > 0)
		{
			_button_theme.label.text = RegCustom._theme_name[Reg._tn].substr(0, RegCustom._theme_name[Reg._tn].length - 5);
			
			_button_theme_minus.visible = true;
			_button_theme_minus.active = true;
		}		
		
		_button_theme_plus = new ButtonGeneralNetworkNo(1300, 12 + Reg.__title_bar_offset_y, "+", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, button_theme_plus, RegCustom._button_color[Reg._tn]);
		_button_theme_plus.label.font = Reg._fontDefault;
		_button_theme_plus.visible = false;
		_button_theme_plus.active = false;
		add(_button_theme_plus);
		
		if (Reg._tn < Reg._tn_total)
		{			
			_button_theme.label.text = RegCustom._theme_name[Reg._tn].substr(0, RegCustom._theme_name[Reg._tn].length - 5);
			
			_button_theme_plus.visible = true;
			_button_theme_plus.active = true;
		}
		
	}
	
	/******************************
	 * changes the current theme to a different theme.
	 */
	private function button_theme_minus():Void
	{			
		if (Reg._tn > 0) Reg._tn -= 1;
		
		FlxG.switchState(new Configuration());
	}
	
	/******************************
	 * changes the current theme to a different theme.
	 */
	private function button_theme_plus():Void
	{	
		if (Reg._tn < Reg._tn_total) Reg._tn += 1;
		
		FlxG.switchState(new Configuration());
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
			_button_profile.destroy();
			_button_profile = null;
		}
		
		if (_button_general != null)
		{
			_button_general.visible = false;
			remove(_button_general);
			_button_general.destroy();
			_button_general = null;
		}
		
		if (_button_games != null)
		{
			_button_games.visible = false;
			remove(_button_games);
			_button_games.destroy();
			_button_games = null;
		}
				
		
	}

	/******************************
	 * when the save button is pressed this code saves the configurations made for all options made at the configuration menu.
	 */
	private function saveConfig():Void
	{
		Reg.__scrollable_area_scroll_y = __scrollable_area.scroll.y;
	
		// email address regex. if result is false then the email address will not be saved. see if (CID3._button_p1.has_toggle == true) code block.
		var _email_address_regex = ~/[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z][A-Z][A-Z]*/i;
		
		if (CID3._button_p1.has_toggle == true)
		{
			#if avatars
				Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1[Reg._tn]);
			#end
		
			if (RegCustom._profile_username_p1[CID3._CRN] == ""
			||	CID3._username_input.text.toLowerCase() == "guest")
			{
				RegCustom._profile_username_p1[CID3._CRN] = "Guest1";
				CID3._username_input.text = "Guest1";
			}
			
			// Cannot save theme. Password field and email address field must be empty for guest accounts.
			else if (CID3._group_input_text_field[0][CID3._CRN].text.substr(0, 5).toLowerCase() == "guest"
			&&	CID3._group_input_text_field[1][CID3._CRN].text.length != 0
			||	CID3._group_input_text_field[0][CID3._CRN].text.substr(0, 5).toLowerCase() == "guest"
			&&	CID3._group_input_text_field[2][CID3._CRN].text.length != 0)
			{
				Reg._messageId = 9013;
				Reg._buttonCodeValues = "v1013";
				SceneGameRoom.messageBoxMessageOrder();
				return;
			}
			
			else if (CID3._group_input_text_field[1][CID3._CRN].text.length <= 2
			&&		 CID3._group_input_text_field[0][CID3._CRN].text.substr(0, 5).toLowerCase() != "guest"
			||		 CID3._group_input_text_field[0][CID3._CRN].text.length <= 2
			&&		 CID3._group_input_text_field[0][CID3._CRN].text.substr(0, 5).toLowerCase() != "guest")
			{
				Reg._messageId = 9012;
				Reg._buttonCodeValues = "v1012";
				SceneGameRoom.messageBoxMessageOrder();
				return;
			}
			
			else if (CID3._group_input_text_field[2][CID3._CRN].text != "" 
			&&	_email_address_regex.match(CID3._group_input_text_field[2][CID3._CRN].text) == false 
			&&	CID3._group_input_text_field[0][CID3._CRN].text.substr(0, 5).toLowerCase() != "guest")
			{
				Reg._messageId = 9014;
				Reg._buttonCodeValues = "v1014";
				SceneGameRoom.messageBoxMessageOrder();
				return;
			} 
			
			// RegCustom._profile_email_address_p1 is set at IdsMessageBox case 9001 
			RegCustom._profile_password_p1[CID3._CRN] = CID3._group_input_text_field[1][CID3._CRN].text;
			
		}
		else
		{
			#if avatars 
				Avatars._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number2[Reg._tn]);
			#end
				
		
			if (RegCustom._profile_username_p2 == "")
			{
				RegCustom._profile_username_p2 = "Guest2";
				CID3._username_input.text = "Guest2";
			}
		}
		
		// reset theme vars back to default if this value is zero.
		if (Reg._tn == 0) RegCustom.resetConfigurationVars2;
		
		RegFunctions.saveConfig();
	}
	
	override public function destroy():Void
	{
		if (__scrollable_area != null)
		{
			remove(__scrollable_area);	
			__scrollable_area.destroy();
			__scrollable_area = null;
		}
		
		if (__configurations_general != null)
		{
			remove(__configurations_general);
			__configurations_general.destroy();
			__configurations_general = null;
		}
		
		if (__configurations_profile != null)
		{
			remove(__configurations_profile);
			__configurations_profile.destroy();
			__configurations_profile = null;
		}
		
		if (__configurations_games != null)
		{
			remove(__configurations_games);
			__configurations_games.destroy();
			__configurations_games = null;
		}
		
		if (_button_general != null)
		{
			remove(_button_general);
			_button_general.destroy();
			_button_general = null;
		}
		
		if (_button_profile != null)
		{
			remove(_button_profile);
			_button_profile.destroy();
			_button_profile = null;
		}
		
		if (_button_games != null)
		{
			remove(_button_games);
			_button_games.destroy();
			_button_games = null;
		}
		
		if (_background_gradient_scene != null)
		{
			remove(_background_gradient_scene);
			_background_gradient_scene.destroy();
			_background_gradient_scene = null;
		}
		
		if (_button_theme_minus != null)
		{
			remove(_button_theme_minus);
			_button_theme_minus.destroy();
			_button_theme_minus = null;
		}
		
		if (_button_theme != null)
		{
			remove(_button_theme);
			_button_theme.destroy();
			_button_theme = null;
		}
		
		if (_button_theme_plus != null)
		{
			remove(_button_theme_plus);
			_button_theme_plus.destroy();
			_button_theme_plus = null;
		}
		
		if (_save != null)
		{
			remove(_save);
			_save.destroy();
			_save = null;
		}
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		// send the offset of the scrollable area to the button class so that when scrolling the scrollable area, the buttons will not be fired at an incorrect scene location. for example, without this offset, when scrolling to the right about 100 pixels worth, the button could fire at 100 pixels to the right of the button's far right location.
		ButtonGeneralNetworkNo._scrollarea_offset_x = __scrollable_area.scroll.x;
		ButtonGeneralNetworkNo._scrollarea_offset_y = __scrollable_area.scroll.y - 770;
		ButtonToggleFlxState._scrollarea_offset_x = __scrollable_area.scroll.x;
		ButtonToggleFlxState._scrollarea_offset_y = __scrollable_area.scroll.y - 770;
		
		// send the offset of the scrollable area to the TextGeneral class so that when scrolling the scrollable area, the text object will not be fired at an incorrect scene location.
		TextGeneral._scrollarea_offset_x = __scrollable_area.scroll.x;
		TextGeneral._scrollarea_offset_y = __scrollable_area.scroll.y - 770;
				
		if (RegTriggers._saveConfig_notice == true)
		{
			RegTriggers._saveConfig_notice = false;
			
			Reg._messageId = 9001;
			Reg._buttonCodeValues = "v1000";
			
			SceneGameRoom.messageBoxMessageOrder();			
		}
				
		if (_button_profile == null)
		{
			_button_profile = new ButtonToggleFlxState(15, FlxG.height - 40, 2, "Profile", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonProfile, RegCustom._button_color[Reg._tn]);
			_button_profile.label.font = Reg._fontDefault;
			_button_profile.has_toggle = true;
			
			if (Reg2._configuration_jump_to_scene == 2)
				_button_profile.set_toggled(true);
			else
				_button_profile.set_toggled(false);
			
			_button_profile.has_toggle = true;
			_button_profile.screenCenter(X);
			_button_profile.x += 97; // half of button (90) + half of 15 rounded down (7);
			add(_button_profile);
			
			_button_general = new ButtonToggleFlxState(_button_profile.x - 195, FlxG.height - 40, 1, "General", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonGeneral, RegCustom._button_color[Reg._tn]);
			_button_general.label.font = Reg._fontDefault;
			
			if (Reg2._configuration_jump_to_scene == 1)
				_button_general.set_toggled(true);
			else
				_button_general.set_toggled(false);
				
			_button_general.has_toggle = true;
			add(_button_general);
					
			_button_games = new ButtonToggleFlxState(_button_general.x - 195, FlxG.height - 40, 2, "Games", 180, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonGames, RegCustom._button_color[Reg._tn]);
			_button_games.label.font = Reg._fontDefault;
			
			if (Reg2._configuration_jump_to_scene == 0)
				_button_games.set_toggled(true);
			else
				_button_games.set_toggled(false);
				
			_button_games.has_toggle = true;
			add(_button_games);
		}
		
		// which saving a theme, profile password message about cannot save theme because username or password field has to few characters.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1012")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
		}
		
		// which saving a theme, profile password message about guest accounts must have an empty password.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1013")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
		}
		
		// while saving a theme, this is a message about email address is not valid.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "v1014")
		{
			Reg._yesNoKeyPressValueAtMessage = 0;
			Reg._buttonCodeValues = "";
			
		}
		
		super.update(elapsed);
		if (_button_theme != null) _button_theme.active = false;
	}
}