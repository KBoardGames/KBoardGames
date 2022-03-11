/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * When a event text is mouse clicked at the event schedule, this sub state is displayed. this class shows the event name and the event description with a close button that once clicked will return the user back to the event schedule scene.
 * @author kboardgames.com
 */
class EventDescription extends FlxSubState
{
	public static var __title_bar:TitleBar;
	public static var __menu_bar:MenuBar;
	
	public var __hotkeys:Hotkeys;
	
	/******************************
	 * background gradient, texture and plain color for a scene.
	 */
	private var __scene_background:SceneBackground;
	
	private var _topic_title:FlxText;
	private var _eventTitle:FlxText;
	private var _text:FlxText;
	
	private var _state:FlxState;
	
	public function new(_str:String, state:FlxState = null):Void
	{
		super();	
		
		openSubState(new SceneTransition());
		
		persistentDraw = true;
		persistentUpdate = false;
		
		_state = state;
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
		}
		
		__scene_background = new SceneBackground();
		add(__scene_background);
		
		var i:Int = 0;
		
		// get the event name and description from the data passed to this class from EventSchedule.hx.
		for (ii in 0...40) // 40 is max for this board game.
		{
			if (_str == Reg2._eventName[ii]) 
			{
				i = ii; 
				break;
			}
		}
		
		if (_topic_title != null)
		{
			remove(_topic_title);
			_topic_title.destroy();
		}
		
		_topic_title = new FlxText(0, 0, 0, "Event Description");
		_topic_title.setFormat(Reg._fontDefault, 30, RegCustomColors.client_topic_title_text_color());
		_topic_title.scrollFactor.set();
		_topic_title.setPosition(15, 15);
		_topic_title.screenCenter(X);
		add(_topic_title);
		
		if (_eventTitle != null)
		{
			remove(_eventTitle);
			_eventTitle.destroy();
		}
		
		_eventTitle = new FlxText(0, 0, 0, Reg2._eventName[i]);
		_eventTitle.setFormat(Reg._fontDefault, 30, RegCustomColors.client_topic_title_text_color());
		_eventTitle.scrollFactor.set();
		_eventTitle.setPosition(50, 75);
		add(_eventTitle);
		
		if (_text != null)
		{
			remove(_text);
			_text.destroy();
		}
		
		_text = new FlxText(0, 0, 0, Reg2._eventDescription[i]);
		_text.setFormat(Reg._fontDefault, 24, RegCustomColors.client_text_color());
		_text.scrollFactor.set();
		_text.fieldWidth = FlxG.width - 100;
		_text.setPosition(50, 135);
		add(_text);
		
		if (__menu_bar != null)
		{
			remove(__menu_bar);
			__menu_bar.destroy();
		}
		
		__menu_bar = new MenuBar(true);
		add(__menu_bar);
		
		var _close = new ButtonGeneralNetworkNo(FlxG.width - 240, FlxG.height - 40, "Exit", 165, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, close_substate, RegCustom._button_color[Reg._tn]);
		_close.label.font = Reg._fontDefault;
		add(_close);
		
		if (__hotkeys != null)
		{
			remove(__hotkeys);
			__hotkeys.destroy();
		}
		
		__hotkeys = new Hotkeys(); 
		add(__hotkeys);
	}
	
	private function close_substate():Void
	{
		if (__hotkeys != null)
		{
			remove(__hotkeys);
			__hotkeys.destroy();
			__hotkeys = null;
		}
		
		if (__scene_background != null)
		{
			remove(__scene_background);
			__scene_background.destroy();
			__scene_background = null;
		}
		
		if (_topic_title != null)
		{
			remove(_topic_title);
			_topic_title.destroy();
			_topic_title = null;
		}
		
		if (_eventTitle != null)
		{
			remove(_eventTitle);
			_eventTitle.destroy();
			_eventTitle = null;
		}
		
		if (_text != null)
		{
			remove(_text);
			_text.destroy();
			_text = null;
		}
		
		_state.visible = false;
		RegTriggers._run_flxstate_effects_for_calendar = true;
		
		Sys.sleep(0.2);
		
		close();		
	}

}