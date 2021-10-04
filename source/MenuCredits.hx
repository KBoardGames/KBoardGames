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
 * ..
 * @author kboardgames.com
 */
class MenuCredits extends FlxState
{	
	public var _text:FlxText;
	
	private var _title:FlxText;
	private var _title_background:FlxSprite;
	
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
		
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width, 55, Reg._background_header_title_color); 
		_title_background.scrollFactor.set(0,0);
		add(_title_background);
		
		_title = new FlxText(15, 4, 0, "Credits");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		_title.scrollFactor.set(0,0);
		_title.visible = true;
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
	
	private function backToTitle():Void
	{
		FlxG.switchState(new MenuState());
	}
		
	override public function update(elapsed:Float):Void
	{
		FlxG.mouse.enabled = true;
		
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

}