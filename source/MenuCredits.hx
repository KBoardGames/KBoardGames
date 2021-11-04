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
 * ..
 * @author kboardgames.com
 */
class MenuCredits extends FlxState
{	
	public var _text:FlxText;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var _scene_background:SceneBackground;
	
	public function new():Void
	{
		super();	
		
		persistentDraw = true;
		persistentUpdate = false;
		
		if (_scene_background != null)
		{
			remove(_scene_background);
			_scene_background.destroy();
		}
		
		_scene_background = new SceneBackground();
		add(_scene_background);
				
		var _title_sub = new FlxText(0, 0, 0, "Giving Credit");
		_title_sub.setFormat(Reg._fontDefault, 30, RegCustomColors.client_topic_title_text_color());
		_title_sub.scrollFactor.set();
		_title_sub.setPosition(50, 75);
		add(_title_sub);
		
		var _text = new FlxText(0, 0, 0, "Thankyou to the following websites and authors that contributed in someway to help make this game possible.\r\nHouse items make by https://www.kenney.nl. This kenny furniture package was released under the CC0 1.0 Universal (CC0 1.0) public domain license.\r\nAvatars from multiavatar. https://multiavatar.com/\r\nTextures from https://opengameart.org/content/huge-texture-resource-pack-part-1\r\nWorld flags are released public domain by https://flagpedia.net\r\nAll images can be used freely for commercial and non-commercial purposes.");
		_text.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_text.scrollFactor.set();
		_text.fieldWidth = FlxG.width - 100;
		_text.setPosition(50, 135);
		add(_text);
		
		if (Reg.__title_bar2 != null) remove(Reg.__title_bar2);
		Reg.__title_bar2 = new TitleBar("Credits");
		add(Reg.__title_bar2);
		
		if (Reg.__menu_bar2 != null) remove(Reg.__menu_bar2);
		Reg.__menu_bar2 = new MenuBar(true);
		add(Reg.__menu_bar2);
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