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
 * navigational buttons such as return to lobby or save layout.
 * @author kboardgames.com
 */
class HouseMenuMain extends FlxGroup
{
	/******************************
	 * hides the grid that would be shown underneath the lobby and disconnect buttons and also displays another horizontal bar at the top of the scene.
	 */
	private	var _bgHorizontal:FlxSprite;
	
	private var _to_lobby:ButtonGeneralNetworkNo;
	
	private var __house:House;
	
	/******************************
	 * HouseFurnitureItemsFront instance.
	*/
	private var _items:HouseFurnitureItemsFront;
	
	public var _buttonToFoundationPutMenu:ButtonToggleHouse;
	public var _buttonToFurnitureGetMenu:ButtonToggleHouse;
	public var _buttonToFurniturePutMenu:ButtonToggleHouse;
	
	private var _save:ButtonGeneralNetworkYes;
	
	override public function new(house:House, items:HouseFurnitureItemsFront):Void
	{
		super();
		
		__house = house;
		_items = items;		
		
		// menu bar.
		var __menu_bar = new MenuBar();
		add(__menu_bar);
		
		_to_lobby = new ButtonGeneralNetworkNo(0, FlxG.height - 40, "To Lobby", 160 + 15, 35, Reg._font_size, 0xFFCCFF33, 0, returnToLobbyFromHouse);		
		_to_lobby.label.font = Reg._fontDefault;
		_to_lobby.screenCenter(X);
		_to_lobby.x += 200;
		add(_to_lobby);
		
		_buttonToFurnitureGetMenu = new ButtonToggleHouse(_to_lobby.x - 800, FlxG.height - 40, 1, "Item Get", 175, 35, Reg._font_size, 0xFFCCFF33, 0, __house.buttonToFurnitureGetMenu, 0xFF001100);
		_buttonToFurnitureGetMenu.label.font = Reg._fontDefault;
		add(_buttonToFurnitureGetMenu);
				
		_buttonToFurniturePutMenu = new ButtonToggleHouse(_to_lobby.x - 600, FlxG.height - 40, 2, "Item Put", 175, 35, Reg._font_size, 0xFFCCFF33, 0, __house.buttonToFurniturePutMenu, 0xFF001100);
		_buttonToFurniturePutMenu.label.font = Reg._fontDefault;
		add(_buttonToFurniturePutMenu);
		
		_buttonToFoundationPutMenu = new ButtonToggleHouse(_to_lobby.x - 400, FlxG.height - 40, 3, "Build", 175, 35, Reg._font_size, 0xFFCCFF33, 0, __house.buttonToFoundationPutMenu, 0xFF001100);
		_buttonToFoundationPutMenu.label.font = Reg._fontDefault;
		add(_buttonToFoundationPutMenu);
				
		_save = new ButtonGeneralNetworkYes(_to_lobby.x + 200, FlxG.height - 40, "Save", 175, 35, Reg._font_size, 0xFFCCFF33, 0, saveHouse, 0xFF000044, false, 1);
		_save.label.font = Reg._fontDefault;
		
		#if html5
			_save.alpha = 0.25;
		#end
		
		add(_save);
		
	}
	
	override public function destroy()
	{
		if (_bgHorizontal != null)
		{
			_bgHorizontal.destroy();
			_bgHorizontal = null;
		}
		
		if (_to_lobby != null)
		{
			_to_lobby.destroy();
			_to_lobby = null;
		}
		
		if (_buttonToFurniturePutMenu != null)
		{
			_buttonToFurniturePutMenu.destroy();
			_buttonToFurniturePutMenu = null;
		}
		
		if (_buttonToFoundationPutMenu != null)
		{
			_buttonToFoundationPutMenu.destroy();
			_buttonToFoundationPutMenu = null;
		}
	
		if (_save != null)
		{
			_save.destroy();
			_save = null;
		}
		
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (RegHouse._at_House == false)
		{
			active = false;
			return;
		}
		else 
		{
			FlxG.mouse.enabled = true;
			active = true;
		}
		
		// fix a camera display bug where the _buttonToFurnitureGetMenu can also be clicked from the right side of the screen because of the map scrolling part of the scene. setting this to active in an else statement is not needed because they are set active elsewhere in the code.
		if (FlxG.mouse.x > FlxG.width / 2
		&&  FlxG.mouse.y >= FlxG.height - 50) 
		{
			_buttonToFurnitureGetMenu.active = false;
			_buttonToFurniturePutMenu.active = false;
		}
		
			
		if (Reg._buttonCodeValues != "") buttonCodeValues();
		
		super.update(elapsed);
		
		
		#if html5
			_save.active = false;
		#end
		
	}
		
	private function saveHouse():Void
	{
		Reg._messageId = 7001;
		Reg._buttonCodeValues = "h1000";
		SceneGameRoom.messageBoxMessageOrder();
		
	}
	
	/******************************
	 * at the time a button is created, a Reg._buttonCodeValues will be given a value. that value is used here to determine what block of code to read. 
	 * a Reg._yesNoKeyPressValueAtMessage with a value of one means that the "yes" button was clicked. a value of two refers to button with text of "no". 
	 */
	public function buttonCodeValues():Void
	{
		// save house.
		if (Reg._yesNoKeyPressValueAtMessage == 1 && Reg._buttonCodeValues == "h1000")
		{
			Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
			Reg._yesNoKeyPressValueAtMessage = 0; // no button is clicked.
			
			//---------------------------
			Reg._messageId = 7002;
			Reg._buttonCodeValues = "h1010";
			SceneGameRoom.messageBoxMessageOrder();
			
			//---------------------------
			
			// clear these array because they will be populated with new data below these code.
			RegTypedef._dataHouse._sprite_number = "";
			RegTypedef._dataHouse._sprite_name = "";
			RegTypedef._dataHouse._items_x = "";
			RegTypedef._dataHouse._items_y = "";			
			RegTypedef._dataHouse._map_x = "";
			RegTypedef._dataHouse._map_y = "";			
			RegTypedef._dataHouse._is_item_purchased = "";
			RegTypedef._dataHouse._item_direction_facing = "";
			RegTypedef._dataHouse._map_offset_x = "";
			RegTypedef._dataHouse._map_offset_y = "";			
			RegTypedef._dataHouse._item_is_hidden = "";
			RegTypedef._dataHouse._item_order = "";
			RegTypedef._dataHouse._item_behind_walls = "";
			RegTypedef._dataHouse._floor = "";
			RegTypedef._dataHouse._wall_left = "";
			RegTypedef._dataHouse._wall_left_is_hidden = "";
			RegTypedef._dataHouse._wall_up_behind = "";
			RegTypedef._dataHouse._wall_up_behind_is_hidden = "";
			RegTypedef._dataHouse._wall_up_in_front = "";
			RegTypedef._dataHouse._wall_up_in_front_is_hidden = "";
			
			for (i in 0...RegHouse._totalPurchased + 1)
			{
				RegTypedef._dataHouse._sprite_number += RegHouse._sprite_number[i] + ",";
				// this is needed to remove the "No item selected" text because if only one item is bought then only one element will be saved in these array. if this is not removed then two elements in this example will never be saved.
				RegHouse._namesPurchased.remove("No item selected.");
				
				RegTypedef._dataHouse._sprite_name += RegHouse._namesPurchased[i] + ",";
				
				RegTypedef._dataHouse._items_x += RegHouse._items_x[i] + ",";
				RegTypedef._dataHouse._items_y += RegHouse._items_y[i] + ",";
				
				RegTypedef._dataHouse._map_x += RegHouse._map_x[i] + ",";
				RegTypedef._dataHouse._map_y += RegHouse._map_y[i] + ",";
				
				RegTypedef._dataHouse._is_item_purchased += RegHouse._is_item_purchased[i] + ",";
				RegTypedef._dataHouse._item_direction_facing += RegHouse._item_direction_facing[i] + ",";
				RegTypedef._dataHouse._map_offset_x += RegHouse._map_offset_x[i] + ",";
				RegTypedef._dataHouse._map_offset_y += RegHouse._map_offset_y[i] + ",";
				
				RegTypedef._dataHouse._item_is_hidden += RegHouse._item_is_hidden[i] + ",";
				RegTypedef._dataHouse._item_order += RegHouse._item_order[i] + ",";
				RegTypedef._dataHouse._item_behind_walls += RegHouse._item_behind_walls[i] + ",";				
				
			}			
			
			
			for (x in 0...11)
			{
				for (y in 0...22)
				{
					RegTypedef._dataHouse._floor += RegHouse._floor[x][y] + ",";
					RegTypedef._dataHouse._wall_left += RegHouse._wall_left[x][y]+ ",";
					RegTypedef._dataHouse._wall_left_is_hidden += RegHouse._wall_left_is_hidden[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_behind += RegHouse._wall_up_behind[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_behind_is_hidden += RegHouse._wall_up_is_hidden[1][x][y]+ ",";
					RegTypedef._dataHouse._wall_up_in_front += RegHouse._wall_up_in_front[x][y]+ ",";
					RegTypedef._dataHouse._wall_up_in_front_is_hidden += RegHouse._wall_up_is_hidden[0][x][y]+ ",";
				}
			}
			
			RegHouse._namesPurchased.unshift("No item selected.");
			PlayState.clientSocket.send("House Save", RegTypedef._dataHouse);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
			
			PlayState.clientSocket.send("Daily Reward Save", RegTypedef._dataStatistics);
			haxe.Timer.delay(function (){}, Reg2._event_sleep);
		}
		
		// message box saying that the house was saved.
		if (Reg._yesNoKeyPressValueAtMessage > 0 && Reg._buttonCodeValues == "h1010")
		{
			Reg._buttonCodeValues = ""; // do not enter this block of code the second time.
			Reg._yesNoKeyPressValueAtMessage = 0; // no button is clicked.
		}
	}
	
	public function returnToLobbyFromHouse():Void
	{
		PlayState.__scene_lobby.returnToLobbyFromHouse();
	}
}