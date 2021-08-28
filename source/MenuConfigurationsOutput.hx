package;

/**
 * this class is created when clicking the gear button. It has configuration stuff such as setting up the game board unit colors.
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
	
	public var _title:FlxText; // title of a scene.
	
	/******************************
	 * this is the "Configuration Menu: " for the title text that a scene can add to. when clicking a button at the SceneMenu, the scene name will append to this var. for example, "Configuration Menu: Avatars.".
	 */
	private var _text_for_title:String = "Configuration Menu: ";
	
	private var __menu_configurations_general:MenuConfigurationsGeneral;
	private var __menu_configurations_profile:MenuConfigurationsProfile;
	private var __menu_configurations_games:MenuConfigurationsGames;
	
	override public function new():Void
	{
		super();
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		Reg2.resetRegVars();
		
		//------------------------------
		RegFunctions._gameMenu = new FlxSave(); // initialize		
		RegFunctions._gameMenu.bind("ConfigurationsMenu"); // bind to the named save slot.
		
		// we use true here so that some items are loaded. a value of false is the default for this function so that so items are only loaded when a condition is met.
		RegFunctions.loadConfig(true);
				
		_title = new FlxText(0, 0, 0, _text_for_title);
		_title.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title.scrollFactor.set(0, 0);
		_title.setPosition(15, 15);
		_title.screenCenter(X);
		
		_title.text = _text_for_title + "General";
		_title.screenCenter(X); // needed again because we changed the text length.
		
		__menu_configurations_general = new MenuConfigurationsGeneral(this);
		add(__menu_configurations_general);
		
		__menu_configurations_profile = new MenuConfigurationsProfile(this);
		add(__menu_configurations_profile);
		
		__menu_configurations_games = new MenuConfigurationsGames(this);
		add(__menu_configurations_games);
		
		
		// a negative x value moves the boxScroller in the opposite direction.
		if (__boxscroller != null) FlxG.cameras.remove(__boxscroller);
		__boxscroller = new FlxScrollableArea(new FlxRect( 0, 0, FlxG.width, FlxG.height-50), __menu_configurations_profile._group.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 100, true);
		__boxscroller.bgColor = 0xFF000066;
		FlxG.cameras.add( __boxscroller );
		__boxscroller.antialiasing = true;
		__boxscroller.pixelPerfectRender = true;
		
		//----------------------------
		var __menu_bar = new MenuBar(true);
		add(__menu_bar);
		
		// save. avatars, general configuration buttons.
		sceneMenuButtons();
		
		__menu_configurations_general.active = false;
		__menu_configurations_games.active = false;
		
		// do not add anymore button class here.
		buttonProfile();		
		
		//-----------------------------
		// none scrollable background behind title.
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, 50, 0xFF000000);
		background.setPosition(0, 0);
		background.scrollFactor.set(0, 0);
		add(background);	
		
		add(_title);
	}
	
	private function buttonToggle():Void
	{
		if (_button_general != null)
		{
			_button_general.color = 0xFF550000;
			_button_general.has_toggle = false;
			_button_general.set_toggled(false);
		}
		
		__menu_configurations_general._group.active = false;
		__menu_configurations_general._group.visible = false;
		
		
		if (_button_profile != null)
		{
			_button_profile.color = 0xFF550000;
			_button_profile.has_toggle = false;
			_button_profile.set_toggled(false);
		}
		
		__menu_configurations_profile._group.active = false;
		__menu_configurations_profile._group.visible = false;
		
		
		if (_button_games != null)
		{
			_button_games.color = 0xFF550000;
			_button_games.has_toggle = false;
			_button_games.set_toggled(false);
		}
		
		__menu_configurations_games._group.active = false;
		__menu_configurations_games._group.visible = false;
	
	}
	
	
	/******************************
	 * this displays the avatars and player name fields for either player 1 or player 2.
	 */
	public function buttonProfile():Void
	{
		_title.text = _text_for_title + "Profile.";
		
		buttonToggle();
		
		if (__menu_configurations_profile != null)
		{
			_button_profile.color = 0xFF005500;
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
			_button_general.color = 0xFF005500;
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
	
	public function buttonGames():Void
	{
		_title.text = _text_for_title + "Games.";
		
		buttonToggle();
		
		if (_button_games != null)
		{
			_button_games.color = 0xFF005500;
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
		var _save = new ButtonGeneralNetworkNo(0, FlxG.height - 40, "Save", 160 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, saveConfig, 0xFF000044, false, 1);
		_save.label.font = Reg._fontDefault;
		_save.screenCenter(X);
		_save.x += 400;
		add(_save);
		
		_button_profile = new ButtonToggleFlxState(15, FlxG.height - 40, 2, "Profile", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buttonProfile, 0xFF550000);
		_button_profile.label.font = Reg._fontDefault;
		_button_profile.has_toggle = false;
		_button_profile.set_toggled(false);
		_button_profile.screenCenter(X);
		_button_profile.x += 97; // half of button (90) + half of 15 rounded down (7);
		add(_button_profile);
				
		_button_general = new ButtonToggleFlxState(_button_profile.x - 195, FlxG.height - 40, 1, "General", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buttonGeneral, 0xFF550000);
		_button_general.label.font = Reg._fontDefault;
		_button_general.has_toggle = true;
		_button_general.set_toggled(true);
		add(_button_general);
				
		_button_games = new ButtonToggleFlxState(_button_general.x - 195, FlxG.height - 40, 2, "Games", 180, 35, Reg._font_size, 0xFFCCFF33, 0, buttonGames, 0xFF550000);
		_button_games.label.font = Reg._fontDefault;
		_button_games.has_toggle = false;
		_button_games.set_toggled(false);
		add(_button_games);
	}

	/******************************
	 * when the save button is pressed this code saves the configurations made for all options made at the configuration menu.
	 */
	private function saveConfig():Void
	{
		if (__menu_configurations_profile._button_p1.has_toggle == true)
			__menu_configurations_profile._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number1);
		else
			__menu_configurations_profile._image_profile_avatar.loadGraphic("vendor/multiavatar/" + RegCustom._profile_avatar_number2);
		
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
			
			__menu_configurations_general._button_shader_even_units_minus.active = false;
			__menu_configurations_general._button_shader_even_units_plus.active = false;		
			__menu_configurations_general._button_shader_odd_units_minus.active = false;
			__menu_configurations_general._button_shader_odd_units_plus.active = false;
			
			__menu_configurations_general._button_color_even_units_minus.active = false;
			__menu_configurations_general._button_color_even_units_plus.active = false;		
			__menu_configurations_general._button_color_odd_units_minus.active = false;
			__menu_configurations_general._button_color_odd_units_plus.active = false;
			
			Reg._messageId = 9001;
			Reg._buttonCodeValues = "v1000";			
			SceneGameRoom.messageBoxMessageOrder();

		}
		
		super.update(elapsed);		
		
	}
}