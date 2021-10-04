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
	
	public var _title_background:FlxSprite;
	public var _title:FlxText;
	
	/******************************
	 * Header columns text for the data rows.	
	*/
	public var _t1:FlxText;
	public var _t2:FlxText;
	public var _t3:FlxText;
	public var _t4:FlxText;
	public var _t5:FlxText;
	
	public function new():Void
	{
		super();	

		FlxG.autoPause = false;	// this application will pause when not in focus.

		RegTypedef._dataLeaderboards._username = RegTypedef._dataAccount._username;
		PlayState.clientSocket.send("Leaderboards", RegTypedef._dataLeaderboards);		
	}
	
	override public function update(elapsed:Float):Void
	{
		if (RegTriggers._leaderboards_show == true)
		{
			FlxG.mouse.enabled = true;
			RegTriggers._leaderboards_show = false;
			
			_group = cast add(new FlxSpriteGroup());
					
			// Create the text boxes underneath the buttons. Note that the last count ends before another loop, so only 26 loops will be made. 
			for (i in 1...52)
			{
				var slotBox = new FlxSprite(0, 0);
				slotBox.makeGraphic(FlxG.width - 60, 55, 0xFF001210);		
				slotBox.setPosition(20, 120 + (i * 70)); 
				slotBox.scrollFactor.set(0, 0);
				_group.add(slotBox);
			}		
						
			var _lb_users = RegTypedef._dataLeaderboards._usernames.split(",");
			var _lb_xp = RegTypedef._dataLeaderboards._experiencePoints.split(",");
			
			
			// this is the position number of the user.
			for (i in 1..._lb_users.length)
			{
				if (RegTypedef._dataLeaderboards._username == Std.string(_lb_users[(i-1)]))
				{
					var slotBox = new FlxSprite(0, 0);
					slotBox.makeGraphic(FlxG.width - 60, 55, RegCustom._button_color[Reg._tn]);		
					slotBox.setPosition(20, 120 + (i * 70)); 
					slotBox.scrollFactor.set(0, 0);
					_group.add(slotBox);
				}
				
				var _text = new FlxText(35, 133 + (i * 70), 0, Std.string(i)); 
				_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_text.scrollFactor.set(0, 0);
				_group.add(_text);
				
				var _text = new FlxText(110 - _offset, 133 + (i * 70), 0, Std.string(_lb_users[(i-1)])); 
				_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_text.scrollFactor.set(0, 0);
				_group.add(_text);
				
				var _text = new FlxText(395 - _offset - _offset2, 133 + (i * 70), 0, Std.string(_lb_xp[(i-1)])); 
				_text.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
				_text.scrollFactor.set(0, 0);
				_group.add(_text);
			}
			
			
			//.....................................
			// a black bar between table rows.
			// first column border. columns are minus 30 from Header column text.
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
			slotBox.setPosition(130 - _offset - _offset2, 120 + (1 * 70)); 
			slotBox.scrollFactor.set(0, 0);
			_group.add(slotBox);
			
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
			slotBox.setPosition(370 - _offset - _offset2, 120 + (1 * 70)); 
			slotBox.scrollFactor.set(0, 0);
			_group.add(slotBox);
			
			var slotBox = new FlxSprite(0, 0);
			slotBox.makeGraphic(10, 120 + (50 * 70), 0xFF000000);		
			slotBox.setPosition(680 - _offset - _offset2, 120 + (1 * 70)); 
			slotBox.scrollFactor.set(0, 0);
			_group.add(slotBox);
			
			
			// this is used to place a gap between the end of the scrollbar area and the SceneMenu.hx
			var _text = new FlxText(0, 120 + (55 * 70), 0, ""); 
			_text.scrollFactor.set(0, 0);
			_text.visible = false;
			_group.add(_text);
			
			// put the group off-screen
			_group.setPosition(0, 0);
					
			// make a scrollbar-enabled camera for it (a FlxScrollableArea)
			if (__scrollable_area != null) FlxG.cameras.remove(__scrollable_area);
			__scrollable_area = new FlxScrollableArea( new FlxRect( 0, 0, FlxG.width, FlxG.height - 45), _group.getHitbox(), ResizeMode.NONE, 0, 100, -1, FlxColor.LIME, null, 0, true);
			add(__scrollable_area);
			FlxG.cameras.add( __scrollable_area );
			__scrollable_area.antialiasing = true;
			__scrollable_area.pixelPerfectRender = true;
					
			
			var __menu_bar = new MenuBar();
			add(__menu_bar);
			
			// none scrollable background behind title.
			_title_background = new FlxSprite(0, 0);
			_title_background.makeGraphic(FlxG.width-20, 160, 0xFF000000);
			_title_background.setPosition(0, 0);
			_title_background.scrollFactor.set();
			add(_title_background);	
					
			_title = new FlxText(0, 0, 0, "Leaderboards");
			_title.setFormat(Reg._fontDefault, 50, FlxColor.YELLOW);
			_title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 3);
			_title.scrollFactor.set();
			_title.setPosition(0, 20);
			_title.visible = true;
			_title.screenCenter(X);
			add(_title);
		
		
			//---------------------------------------------- Header columns text for the data rows.		
			_t1 = new FlxText(110 - _offset, 130, 0, "Username");
			_t1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_t1.scrollFactor.set();
			add(_t1);
			
			_t2 = new FlxText(395 - _offset - _offset2, 130, 0, "Experience Points");
			_t2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.WHITE);
			_t2.scrollFactor.set();
			add(_t2);
			
			
		}
		
		super.update(elapsed);
	}
	
	private function fullCredits():Void
	{
		Reg._messageId = 8001;
		Reg._buttonCodeValues = "y1000";		
		SceneGameRoom.messageBoxMessageOrder();		
	}
	
	
	
}