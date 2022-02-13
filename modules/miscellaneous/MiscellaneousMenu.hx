/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.miscellaneous;

/**
 * all option and statistic buttons. Help checkers, instruction and exit buttons.
 * @author kboardgames.com
 */
class MiscellaneousMenu extends FlxGroup
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar; 
	
	public var __miscellaneous_menu_output:MiscellaneousMenuOutput;	
		
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	public function new():Void
	{
		super();	
		
		FlxG.autoPause = false;
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		__scene_background = new SceneBackground();
		add(__scene_background);
		
		if (__title_bar != null)
		{
			remove(__title_bar);
			__title_bar.destroy();
		}
		
		__title_bar = new TitleBar("Miscellaneous");
		add(__title_bar);
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar();
		add(__menu_bar);
	
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
		
		PlayState.send("Get Statistics All", RegTypedef._dataStatistics);		
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