package;

/**
 * ..
 * @author kboardgames.com
 */
class MenuCredits extends FlxState
{	
	public var _text:FlxText;
	
	public function new():Void
	{
		super();	
		
		persistentDraw = true;
		persistentUpdate = false;
		
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, 0xFF000066);
		background.setPosition(0, 0);
		background.scrollFactor.set();	
		background.screenCenter(X);
		add(background);	
		
		var _title = new FlxText(0, 0, 0, "Credits");
		_title.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title.scrollFactor.set();
		_title.setPosition(15, 15);
		_title.screenCenter(X);
		add(_title);
		
		var _title_sub = new FlxText(0, 0, 0, "Giving Credit");
		_title_sub.setFormat(Reg._fontDefault, 30, FlxColor.ORANGE);
		_title_sub.scrollFactor.set();
		_title_sub.setPosition(50, 75);
		add(_title_sub);
		
		var _text = new FlxText(0, 0, 0, "Thankyou to the following websites and authors that contributed in someway to help make this game possible.\n\nHouse items make by https://www.kenney.nl. This kenny furniture package was released under the CC0 1.0 Universal (CC0 1.0) public domain license.\n\nAvatars from multiavatar. https://multiavatar.com/\n\nAll images can be used freely for commercial and non-commercial purposes");
		_text.setFormat(Reg._fontDefault, Reg._font_size);
		_text.scrollFactor.set();
		_text.fieldWidth = FlxG.width - 100;
		_text.setPosition(50, 135);
		add(_text);
		
		var __menu_bar = new MenuBar(true);
		add(__menu_bar);
	}
	
	override public function update(elapsed:Float):Void
	{
		// should message box be displayed?
		if (Reg._messageId > 0 && Reg._messageId != 1000000
		&&	RegTriggers._buttons_set_not_active == false)
		{
			var _msg = new IdsMessageBox();
			add(_msg);
		}
		
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "y1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;

			FlxG.openURL("http://kboardgames.com/forum/credits","_blank"); 
		}
	
		if (Reg._yesNoKeyPressValueAtMessage >= 2 && Reg._buttonCodeValues == "y1000")
		{
			Reg._buttonCodeValues = "";
			Reg._yesNoKeyPressValueAtMessage = 0;
			
		}
		
		super.update(elapsed);
	}
	
	private function backToTitle():Void
	{
		FlxG.switchState(new MenuState());
	}
	
}