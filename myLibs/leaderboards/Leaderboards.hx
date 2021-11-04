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

package myLibs.leaderboards;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxRect;
import vendor.ibwwg.FlxScrollableArea;

#if flags
	import myLibs.worldFlags.WorldFlags;
#end

/**
 * ...
 * @author kboardgames.com
 */
class Leaderboards extends FlxGroup
{
	public var _text:FlxText;
	
	/******************************
	 * moves all row data to the left side.
	 */
	private var _offset:Int = 0;
	
	/******************************
	 * moves all row data, excluding the button row. to the left side.
	 */
	private var _offset2:Int = 43;
	
	/******************************
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public var _group:FlxSpriteGroup;	
	public var __scrollable_area:FlxScrollableArea;	
	
	/******************************
	 * Header columns text for the data rows.	
	*/
	public var _t1:FlxText;
	public var _t2:FlxText;
	
	public function new():Void
	{
		super();	

		FlxG.autoPause = false;	// this application will pause when not in focus.

		RegTypedef._dataLeaderboards._username = RegTypedef._dataAccount._username;
		PlayState.clientSocket.send("Leaderboards", RegTypedef._dataLeaderboards);		
	}
	
	private function table_data(i:Int):Void
	{
		var _lb_flag 	= RegTypedef._dataLeaderboards._worldFlag.split(",");
		var _lb_users 	= RegTypedef._dataLeaderboards._usernames.split(",");
		var _lb_xp		= RegTypedef._dataLeaderboards._experiencePoints.split(",");
			
		// this is the position number of the user.
		var _text = new FlxText(35, 133 + (i * 70), 0, Std.string(i)); 
		_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_text.scrollFactor.set(0, 0);
		_group.add(_text);
		
		// flag
		#if flags
			var _text = new FlxSprite(65, 126 + (i * 70));
		_text.loadGraphic("myLibs/worldFlags/assets/images/" + WorldFlags._flags_abbv_name[Std.parseInt( Std.string( _lb_flag[(i-1)]))].toLowerCase() + ".png");
			_text.scrollFactor.set(0, 0);
			_group.add(_text);
		#end
		
		// username
		var _text = new FlxText(180 - _offset, 133 + (i * 70), 0, Std.string(_lb_users[(i-1)])); 
		_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_text.scrollFactor.set(0, 0);
		_group.add(_text);
		
		// total xp of user.
		var _text = new FlxText(465 - _offset - _offset2, 133 + (i * 70), 0, Std.string(_lb_xp[(i-1)])); 
		_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_text.scrollFactor.set(0, 0);
		_group.add(_text);
	}
	
	/******************************
	 * a vertical bars between table rows. first column border. columns are minus 30 from Header column text.
	 */
	private function vertical_bars():Void
	{
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
		slotBox.setPosition(209 - _offset - _offset2, 120 + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		_group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
		slotBox.setPosition(440 - _offset - _offset2, 120 + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		_group.add(slotBox);
		
		var slotBox = new FlxSprite(0, 0);
		slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
		slotBox.setPosition(750 - _offset - _offset2, 120 + (1 * 70)); 
		slotBox.scrollFactor.set(0, 0);
		_group.add(slotBox);	
	}
	
	private function scrollable_area():Void
	{
		// make a scrollbar-enabled camera for it (a FlxScrollableArea)
		if (__scrollable_area != null)
		{
			remove(__scrollable_area);
			FlxG.cameras.remove(__scrollable_area);
			
			__scrollable_area.destroy();			
		}
		
		__scrollable_area = new FlxScrollableArea( new FlxRect( 0, 0, FlxG.width, FlxG.height - 45), _group.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, true);
		add(__scrollable_area);
		FlxG.cameras.add( __scrollable_area );
		__scrollable_area.antialiasing = true;
		__scrollable_area.pixelPerfectRender = true;
	}
	
	/******************************
	 * Header columns text for the data rows.		
	 */
	private function table_header_columns():Void
	{ 
		_t1 = new FlxText(180 - _offset, 130, 0, "Username");
		_t1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t1.scrollFactor.set();
		add(_t1);
		
		_t2 = new FlxText(465 - _offset - _offset2, 130, 0, "Experience Points");
		_t2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
		_t2.scrollFactor.set();
		add(_t2);
	}
	
	private function fullCredits():Void
	{
		Reg._messageId = 8001;
		Reg._buttonCodeValues = "y1000";		
		SceneGameRoom.messageBoxMessageOrder();		
	}
	
	override public function destroy():Void
	{
		
		if (_group != null)
		{
			remove(_group);
			_group.destroy();			
		}
		
		if (__scrollable_area != null)
		{
			remove(__scrollable_area);
			__scrollable_area.destroy();			
		}
		
		super.destroy();
		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (RegTriggers._leaderboards_show == true)
		{
			FlxG.mouse.enabled = true;
			RegTriggers._leaderboards_show = false;
			
			if (_group != null)
			{
				remove(_group);
				_group.destroy();			
			}
			
			_group = cast add(new FlxSpriteGroup());
					
			// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 50 loops will be made. 
			for (i in 1...52)
			{
				var slotBox = new FlxSprite(0, 0);
				slotBox.makeGraphic(FlxG.width - 60, 55, 0xFF001210);		
				slotBox.setPosition(20, 120 + (i * 70)); 
				slotBox.scrollFactor.set(0, 0);
				_group.add(slotBox);
			}		
			
			var _lb_users 	= RegTypedef._dataLeaderboards._usernames.split(",");
			
			for (i in 1..._lb_users.length)
			{
				// highlighted row showing where the user is at the leaderboard.
				if (RegTypedef._dataLeaderboards._username == Std.string(_lb_users[(i-1)]))
				{
					var slotBox = new FlxSprite(0, 0);
					slotBox.makeGraphic(FlxG.width - 60, 55, RegCustom._button_color[Reg._tn]);		
					slotBox.setPosition(20, 120 + (i * 70)); 
					slotBox.scrollFactor.set(0, 0);
					_group.add(slotBox);
				}
				
				table_data(i);
			}
			
			vertical_bars();
			
			// put the group off-screen
			_group.setPosition(0, 0);
			
			scrollable_area();
			
			if (Reg.__title_bar2 != null) remove(Reg.__title_bar2);
			Reg.__title_bar2 = new TitleBar("Leaderboards");
			add(Reg.__title_bar2);
			
			if (Reg.__menu_bar2 != null) remove(Reg.__menu_bar2);
			Reg.__menu_bar2 = new MenuBar();
			add(Reg.__menu_bar2);
			
			table_header_columns();
		}
		
		super.update(elapsed);
	}
	
}