package;

/**
 * all option and statistic buttons. Help checkers, instruction and exit buttons.
 * @author kboardgames.com
 */
class MiscellaneousMenu extends FlxGroup
{	
	public var __miscellaneous_menu_output:MiscellaneousMenuOutput;
	
	public var __menu_bar:MenuBar;
	
	public function new():Void
	{
		super();	
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height-50, FlxColor.BLACK);
		background.setPosition(0, 0);
		background.scrollFactor.set();	
		background.screenCenter(X);
		add(background);	
		
		var i:Int = 0;
		
		var _title = new FlxText(0, 0, 0, "Miscellaneous Menu");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3);
		_title.scrollFactor.set();
		_title.setPosition(15, 15);
		_title.screenCenter(X);
		add(_title);
		
		
		//#############################
		
		var _gameOptions = new FlxText(30, 125, 0, "Game options.");
		_gameOptions.setFormat(Reg._fontDefault, 24);
		_gameOptions.scrollFactor.set();
		_gameOptions.fieldWidth = FlxG.width - 100;
		add(_gameOptions);
		
		var _statisticsAll = new ButtonGeneralNetworkYes(30, 175, "Statistics", 200 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, statisticsAll);
		_statisticsAll.label.font = Reg._fontDefault;
		add(_statisticsAll);
		
		var _close = new ButtonGeneralNetworkYes(30, FlxG.height - 40, "Exit", 150 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, closeState, 0xFF000044, false);
		_close.label.font = Reg._fontDefault;
		_close.screenCenter(X);
		_close.x += 400;
		add(_close);
	}
	
	/******************************
	 * display the stats.
	 */
	private function statisticsAll():Void
	{
		Reg2._miscMenuIparameter = 30;
		
		PlayState.clientSocket.send("Get Statistics All", RegTypedef._dataStatistics);
		haxe.Timer.delay(function (){}, Reg2._event_sleep);
	}
	
	private function closeState():Void
	{
		//if (RegCustom._enable_sound == true
		//&&  Reg2._boxScroller_is_scrolling == false)
		//v	FlxG.sound.play("click", 1, false);
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		if (Reg.at_scene_menu == false)
		{
			Reg.at_scene_menu = true;
			return;
		}
		
		remove(__menu_bar);
		__menu_bar.destroy();
		__menu_bar = null;
		
		RegTriggers._returnToLobbyMakeButtonsActive = true;
		
		visible = false;
		active = false;
		
	}
	
	// go to the miscellaneous output to output the text. this _i is the button bind value that was clicked.
	private function openInstructionsSubState(_i:Int):Void
	{
		Reg2._miscMenuIparameter = _i;
		RegTriggers._miscellaneousMenuOutputClassActive = true;
	}
	
	override public function destroy()
	{
		super.destroy();
	}
}