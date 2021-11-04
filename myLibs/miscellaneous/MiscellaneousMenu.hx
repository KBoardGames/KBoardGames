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

package myLibs.miscellaneous;

/**
 * all option and statistic buttons. Help checkers, instruction and exit buttons.
 * @author kboardgames.com
 */
class MiscellaneousMenu extends FlxGroup
{		
	public var __miscellaneous_menu_output:MiscellaneousMenuOutput;	
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var _scene_background:SceneBackground;
	
	public function new():Void
	{
		super();	
		
		FlxG.mouse.reset();
		FlxG.mouse.enabled = true;
		
		FlxG.autoPause = false;	// this application will pause when not in focus.
		
		if (_scene_background != null)
		{
			remove(_scene_background);
			_scene_background.destroy();
		}
		
		_scene_background = new SceneBackground();
		add(_scene_background);
		
		if (Reg.__title_bar2 != null) remove(Reg.__title_bar2);
		Reg.__title_bar2 = new TitleBar("Miscellaneous");
		add(Reg.__title_bar2);
		
		if (Reg.__menu_bar2 != null) remove(Reg.__menu_bar2);
		Reg.__menu_bar2 = new MenuBar();
		add(Reg.__menu_bar2);
	
		//#############################
		var _statisticsAll = new ButtonGeneralNetworkYes(30, 125, "Statistics", 200 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, statisticsAll, RegCustom._button_color[Reg._tn]);
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