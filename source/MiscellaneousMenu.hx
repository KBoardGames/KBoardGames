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
 * all option and statistic buttons. Help checkers, instruction and exit buttons.
 * @author kboardgames.com
 */
class MiscellaneousMenu extends FlxGroup
{		
	public var __menu_bar:MenuBar;
	public var __miscellaneous_menu_output:MiscellaneousMenuOutput;	
	
	private var _title:FlxText;
	private var _title_background:FlxSprite;
	
	public function new():Void
	{
		super();	
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		
		__menu_bar = new MenuBar();
		add(__menu_bar);
		
		_title_background = new FlxSprite(0, 0);
		_title_background.makeGraphic(FlxG.width, 55, Reg._background_header_title_color); 
		_title_background.scrollFactor.set(0, 0);
		add(_title_background);
		
		_title = new FlxText(15, 4, 0, "Miscellaneous");
		_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
		_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
		_title.scrollFactor.set(0,0);
		_title.visible = true;
		add(_title);
	
		//#############################
		
		var _gameOptions = new FlxText(30, 125, 0, "Game options.");
		_gameOptions.setFormat(Reg._fontDefault, 24);
		_gameOptions.scrollFactor.set();
		_gameOptions.fieldWidth = FlxG.width - 100;
		add(_gameOptions);
		
		var _statisticsAll = new ButtonGeneralNetworkYes(30, 175, "Statistics", 200 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, statisticsAll, RegCustom._button_color[Reg._tn]);
		_statisticsAll.label.font = Reg._fontDefault;
		add(_statisticsAll);
		
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