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

package myLibs.house;

/**
 * Main class. draws the walls and floors of the room.
 * @author kboardgames.com
 */
class House extends FlxGroup
{
	/******************************
	 * background for scene and excluding the menu area.
	 */
	public var _bg:FlxSprite;
	
	/******************************
	 * all furniture items to place into the room that are in front of a wall.
	 */
	public var __house_furniture_items_front:HouseFurnitureItemsFront;
	
	/******************************
	 * all furniture items to place into the room that are behind a wall.
	 */
	public var __house_furniture_items_back:HouseFurnitureItemsBack;
	
	/******************************
	 * Menu used to buy a furniture item.
	 */
	public var __house_furniture_get:HouseFurnitureGet;
	
	/******************************
	 * furniture item functions such as members_bring_forward or members_change_z-order. these functions are called from the "houseMenuFurniture.hx" class.
	 */
	public var __house_map_furniture:HouseMapFurniture;
	
	/******************************
	 * when "furniture get" button is selected, the house coins text is displayed.
	 * when "furniture put" button is selected, furniture items can either be placed in front/behind another member or placed in front or behind a wall.
	 */
	public var __house_menu_furniture:HouseMenuFurniture;
	
	/******************************
	 * navigational buttons such as return to lobby or save layout.
	 */
	public var __house_menu_main:MenuBar;
	
	/******************************
	 * Menu used to select a floor or wall tiles to draw on scene.
	 */
	public var __house_foundation_put:HouseFoundationPut; 
	
	/******************************
	 * Menu of selectable bought furniture. 
	 */
	public var __house_furniture_put:HouseFurniturePut;
	
	/******************************
	 * scrolls the map when mouse is hovered near the edge of the map.
	 */
	public var __house_scroll_map:HouseScrollMap;
	
	/******************************
	 * this center of screen object is used to scroll the scene. The camera focuses on it.
	 */
	public var _tracker:FlxSprite;	
	
	/******************************
	 * this is the x value when _tracker is first positioned on the scene.
	 */
	public var _tracker_start_x:Float = 692.5;
	
	/******************************
	 * this is the y value when _tracker is first positioned on the scene.
	 */
	public var _tracker_start_y:Float = 377.5;
	
	/******************************
	 * size in pixel of a floor tile
	 */
	public var _floorTileSize:Float = 90;
	
	/******************************
	 * amount of floor tiles positioned vertically or horizontally on the map.
	 */
	public var _floorTileAmount:Int = 30;
	
	/******************************
	 * this var is used to offset every other map row.
	 */
	public var _trackerDefaultPosition:Float = 0;
	
	/******************************
	 * highlights a tile that surrounds the mouse but only for the map. So when the mouse moves around the map this hover highlights a tile.
	 */
	public var _housePageMapFloorHover:FlxSprite;
	
	/******************************
	 * this x coordinate of the hover sprite.
	 */
	public var _hover_x:Int = -1;
	
	/******************************
	 * this y coordinate of the hover sprite.
	 */
	public var _hover_y:Int = -1;
	
	/******************************
	 * holds the _p value of the selected tile.
	 */
	public var _hover_p_value:Int = -1;

	/******************************
	 * this moves all tiles once this many pixels from the 0 start location.
	 */
	private var _tile_start_offset_x:Float = 10;
	
	/******************************
	 * this moves all tiles once this many pixels from the 0 start location.
	 */
	private var _tile_start_offset_y:Float = 31;
	
	/******************************
	 * player entered house rooms and network event was sent to server to get house rooms data. house rooms arrays populated.
	 */
	public var _houseDataLoaded:Bool = false;
	
	
	/******************************
	 * 1 tick is needed to correctly display the menu bar buttons. without a tick the text would be display at top of button. the reason is those buttons are set to not active when mouse at the area where chatter would be because of a chatter camera bug, so when entering the house, the mouse is not at those buttons and therefore the buttons are not finish its drawing. is the bug text at the update() of this class for more information.
	 */
	private var _ticks_menu_bar:Int = 0;
	
	/******************************
	 * 1 tick is needed to correctly display the build buttons. without a tick the text would be display at top of button. the reason is those buttons are set to not active when mouse is not at the panel because of a chatter camera bug, so when entering the house, the mouse is not at the panel and therefore the buttons are not finish its drawing. is the bug text at the update() of this class for more information.
	 */
	private var _ticks_build_buttons:Int = 0;
	
	override public function new():Void
	{
		super();
		
		// Multiple overlap between two objects. https://github.com/HaxeFlixel/flixel/issues/1247 uncomment the following to fix the issue. might lose small computer performance. you don't use many callback so this is currently not a concern.
		FlxG.worldDivisions = 1;
		FlxG.worldBounds.set(0); 				
	}
	
	/******************************
	 * this function draws the default tiles and news all the classes needed for house such as "furniture put".
	 */
	private function initialize():Void
	{
		_tile_start_offset_x = 10 + 208 * 2; // 208 is width of tile.
		_tile_start_offset_y = 31 + 147 * 2;
		
		// do not display anything outside of this area.
		//FlxG.camera.setScrollBoundsRect(0, 0, _floorTileSize*_floorTileAmount, _floorTileSize*_floorTileAmount, true);
		FlxG.camera.setScrollBoundsRect(0, 0, 204*_floorTileAmount, 144*_floorTileAmount, true);
		
		// background for scene and excluding the menu area.
		_bg = new FlxSprite(373, 0);
		_bg.makeGraphic(Std.int(_floorTileSize * _floorTileAmount + 373), Std.int(_floorTileSize * _floorTileAmount));
		_bg.color = 0xFF000021;
		add(_bg);		
		
		
		/******************************
		 * this draws the floors on the scene.
		 */
		var _p:Int = 0;
			
		var _tile_offset_x:Float = 0;
		var _tile_offset_y:Float = 0;
		
		for (y in 0...21)
		{
			if (FlxMath.isOdd(y))
			{				
				// since y value in this loop is read after the row is drawn, these values refers to the first tile of the new row.
				_tile_offset_x = 101.5;
			}
			
			else
			{
				_tile_offset_x = 0;
			}			
			
			for (x in 0...11)
			{
				if (FlxMath.isOdd(y) && x < Std.int(_floorTileAmount/2)-5
				||  FlxMath.isEven(y))
				{
					// draw the floors
					var _houseMapFloor = new HouseMapFloor((x * 203) + _tile_offset_x + _tile_start_offset_x + 373, (y * _tile_offset_y) + _tile_start_offset_y, x, y, this, _p);
					add(_houseMapFloor);
						
				}
				
				_p += 1;
				
			}
			
			_tile_offset_y = 71.5;
		}
		
		//------------------------ items that the player can buy are displayed at the put panel and also on the map in front of the foundations.
		__house_furniture_items_back = new HouseFurnitureItemsBack();
		add(__house_furniture_items_back);
		
		/******************************
		 * this draws the foundation on the scene.
		 */
		for (_id in 0...3)
		{
			var _p:Int = 0;
			
			var _tile_offset_x:Float = 0;
			var _tile_offset_y:Float = 0;
			
			for (y in 0...21)
			{
				if (FlxMath.isOdd(y))
				{				
					// since y value in this loop is read after the row is drawn, these values refers to the first tile of the new row.
					_tile_offset_x = 101.5;
				}
				
				else
				{
					_tile_offset_x = 0;
				}			
				
				for (x in 0...11)
				{
					if (FlxMath.isOdd(y) && x < Std.int(_floorTileAmount/2)-5
					||  FlxMath.isEven(y))
					{						
						// draw the up wall. if the stack_order of this class is used then this wall will be behind a left wall. remember this code is called first so it will be displayed behind the left wall below this code.
						if  (_id == 0) 
						{
							var _houseMapFloor = new HouseMapWallUp((x * 203) + _tile_offset_x + _tile_start_offset_x + 373 + 101.5, (y * _tile_offset_y) + _tile_start_offset_y - 138.5, this, _p, 1, x, y);
							add(_houseMapFloor);
						}
						
						// draw the left walls.
						if (_id == 1)
						{
							var _houseMapFloor = new HouseMapWallLeft((x * 203) + _tile_offset_x + _tile_start_offset_x + 373, (y * _tile_offset_y) + _tile_start_offset_y - 138.5, this, _p, x, y);
							add(_houseMapFloor);
						}
						
						// draw the up wall. if the z-order of this class is used then this wall will be in front of all walls.
						if  (_id == 2) 
						{
							var _houseMapFloor = new HouseMapWallUp((x * 203) + _tile_offset_x + _tile_start_offset_x + 373 + 101.5, (y * _tile_offset_y) + _tile_start_offset_y - 138.5, this, _p, 0, x, y);
							add(_houseMapFloor);
						}
					}
					
					_p += 1;
					
				}
				
				_tile_offset_y = 71.5;
			}
		}
		
		RegTriggers._houseFirstPartComplete = true;
	}
		
	public function initialize2():Void
	{		
		//------------------------ items that the player can buy are displayed at the put panel and also on the map in front of the foundations.
		__house_furniture_items_front = new HouseFurnitureItemsFront();
		add(__house_furniture_items_front);
		
		_housePageMapFloorHover = new FlxSprite(_tile_start_offset_x + 373, _tile_start_offset_y);
		_housePageMapFloorHover.loadGraphic("myLibs/house/assets/images/houseMapFloorHover.png", false);
		add(_housePageMapFloorHover);
		
		__house_furniture_get = new HouseFurnitureGet(this);		
		
		__house_map_furniture = new HouseMapFurniture(this, __house_furniture_items_front, __house_furniture_items_back, __house_furniture_get);
		add(__house_map_furniture);
				
		__house_furniture_put = new HouseFurniturePut(this);
		__house_furniture_put.__scrollable_area.visible = false;
		__house_furniture_put.__scrollable_area.active = false;		
		__house_furniture_put.visible = false;
		__house_furniture_put.active = false;
		add(__house_furniture_put);
		add(__house_furniture_get);	
		
		__house_menu_furniture = new HouseMenuFurniture(this, __house_furniture_items_front, __house_furniture_put, __house_map_furniture);
		add(__house_menu_furniture);
				
		__house_foundation_put = new HouseFoundationPut(__house_furniture_put);
		__house_foundation_put.visible = false;
		__house_foundation_put.active = false;
		add(__house_foundation_put);
		
		__house_scroll_map = new HouseScrollMap(this);
		add(__house_scroll_map);
		
		initialize3();
	}
	
	/******************************
	 * this function draws the _tracker. that center of screen object is used to scroll the scene. The camera focuses on it.
	 */
	public function initialize3():Void
	{
		FlxG.mouse.enabled = true;
		
		_tracker = new FlxSprite(0, 0);
		_tracker.loadGraphic("myLibs/house/assets/images/tracker.png", false);
		_tracker.scrollFactor.set(_tracker_start_x, _tracker_start_y);
		add(_tracker);
		
		//--------------------------
		// initiate house.
		activeFurnitureGetElements();

		optionsMakeActive();
			
		// reset these vars.
		RegHouse._house_main_menu_button_number = 0;
		
		//HouseScrollMap._map_offset_x = 0;
		//HouseScrollMap._map_offset_y = 0;
		_tracker.screenCenter(XY);
		//--------------------------
		
		_houseDataLoaded = true;
	}
	
	public function optionsMakeActive():Void
	{
		if (__house_menu_main != null)
		{
			__house_menu_main.visible = false;
			remove(__house_menu_main);
			__house_menu_main = null;
		}
		
		__house_menu_main = new MenuBar(false, false, this, __house_furniture_items_front);
		add(__house_menu_main);
				
		__house_menu_main._buttonToFurnitureGetMenu.active = true;
		__house_menu_main._buttonToFurniturePutMenu.active = true;
		__house_menu_main._buttonToFoundationPutMenu.active = true;
		
		__house_menu_main._buttonToFurnitureGetMenu.has_toggle = true;
		__house_menu_main._buttonToFurnitureGetMenu.set_toggled(true);
		__house_menu_main._buttonToFurnitureGetMenu.label.bold = true;		
		
		__house_menu_main._buttonToFurniturePutMenu.has_toggle = false;
		__house_menu_main._buttonToFurniturePutMenu.set_toggled(false);
		__house_menu_main._buttonToFurniturePutMenu.label.bold = false;
		
		__house_menu_main._buttonToFoundationPutMenu.has_toggle = false;
		__house_menu_main._buttonToFoundationPutMenu.set_toggled(false);
		__house_menu_main._buttonToFoundationPutMenu.label.bold = false;
		
		__house_scroll_map.active = true;
		__house_scroll_map.visible = true;
		
		__house_scroll_map.initialize(); // clear vars.		
		
	}
		
	/******************************
	 * set this button not active when another toggle button at HouseMenuMain.hx is selected.
	 */
	public function buttonNotActiveFurniturePut():Void
	{
		__house_menu_main._buttonToFurniturePutMenu.label.bold = false;	
		
		__house_menu_main._buttonToFurniturePutMenu.has_toggle = false;
		__house_menu_main._buttonToFurniturePutMenu.set_toggled(false);
		
		__house_foundation_put.visible = false;
		__house_foundation_put.active = false;
		
		__house_furniture_put._background.visible = false;
		__house_furniture_put._bgTitle.visible = false;
		__house_furniture_put._title.visible = false;
		
		//Reg._updateScrollbarBringUp = true;
		
		__house_furniture_put.__scrollable_area.visible = false;
		__house_furniture_put.visible = false;
		__house_furniture_put.__scrollable_area.active = false;
		__house_furniture_put.active = false;
	}	
	
	public function buttonNotActiveFurnitureGet():Void
	{
		__house_menu_main._buttonToFurnitureGetMenu.label.bold = false;		
		
		__house_menu_main._buttonToFurnitureGetMenu.has_toggle = false;
		__house_menu_main._buttonToFurnitureGetMenu.set_toggled(false);	
		
		__house_foundation_put.visible = false;
		__house_foundation_put.active = false;
		
		__house_furniture_get._background.visible = false;
		__house_furniture_get._bgTitle.visible = false;
		__house_furniture_get._title.visible = false;
		
		//Reg._updateScrollbarBringUp = true;
		
		__house_furniture_get.__scrollable_area.visible = false;
		__house_furniture_get.visible = false;
		__house_furniture_get.__scrollable_area.active = false;
		__house_furniture_get.active = false;
	}
	
	public function buttonNotActiveFoundationPut():Void
	{
		__house_menu_main._buttonToFoundationPutMenu.label.bold = false;		
		
		__house_menu_main._buttonToFoundationPutMenu.has_toggle = false;
		__house_menu_main._buttonToFoundationPutMenu.set_toggled(false);
	}
	
	public function activeFurnitureMenuElements():Void
	{
		__house_menu_furniture._stack_item_backwards.active = true;
		__house_menu_furniture._stack_item_forwards.active = true;
		__house_menu_furniture._text_order.active = true;
		
		__house_menu_furniture._text_of_item_selected.visible = true;
		__house_menu_furniture._stack_item_backwards.visible = true;
		__house_menu_furniture._stack_item_forwards.visible = true;
		__house_menu_furniture._text_order.visible = true;
		
	}
	
	public function notActiveFurnitureMenuElements():Void
	{
		__house_menu_furniture._text_of_item_selected.visible = false;
		__house_menu_furniture._stack_item_backwards.visible = false;
		__house_menu_furniture._stack_item_forwards.visible = false;
		__house_menu_furniture._button_is_hidden.visible = false;
		__house_menu_furniture._button_item_behind_walls.visible = false;
		__house_menu_furniture._text_order.visible = false;
		
		__house_menu_furniture._stack_item_backwards.active = false;
		__house_menu_furniture._stack_item_forwards.active = false;
		__house_menu_furniture._button_is_hidden.active = false;
		__house_menu_furniture._button_item_behind_walls.active = false;
		__house_menu_furniture._text_order.active = false;
		
	}
	
	public function	activeFurnitureGetElements():Void
	{		
		__house_furniture_get.active = true;		
		__house_furniture_get.__scrollable_area.active = true;
		__house_furniture_get.__scrollable_area.visible = true;
		__house_furniture_get._background.visible = true;
		__house_furniture_get._bgTitle.visible = true;
		__house_furniture_get._title.visible = true;
		__house_furniture_get.visible = true;
		
	}
	
	public function	activeFurniturePutElements():Void
	{
		if (__house_furniture_put != null)
		{
			__house_furniture_put.active = true;		
			__house_furniture_put.__scrollable_area.active = true;
			__house_furniture_put.__scrollable_area.visible = true;
			__house_furniture_put._background.visible = true;
			__house_furniture_put._bgTitle.visible = true;
			__house_furniture_put._title.visible = true;
			__house_furniture_put.visible = true;
		}		
	}
	
	/******************************
	 * this is the furniture get toggle button at the house main menu.
	 */
	public function buttonToFurnitureGetMenu():Void
	{
		if (__house_menu_main != null)
		{
			RegHouse._house_main_menu_button_number = 0;
			
			__house_menu_main._buttonToFoundationPutMenu.active = true;
			__house_menu_main._buttonToFurniturePutMenu.active = true;
			
			__house_menu_main._buttonToFurnitureGetMenu.label.bold = true;		
			__house_menu_main._buttonToFurnitureGetMenu.has_toggle = true;
			__house_menu_main._buttonToFurnitureGetMenu.set_toggled(true);
			
			activeFurnitureGetElements();
			
			notActiveFurnitureMenuElements();
			buttonNotActiveFurniturePut();
			buttonNotActiveFoundationPut();	
			
			//__house_menu_main._buttonToFurnitureGetMenu.active = false;
			
			__house_furniture_get.active = true;
		}
	}
	
	public function buttonToFurniturePutMenu():Void
	{
		RegHouse._house_main_menu_button_number = 1;
		
		__house_menu_main._buttonToFurnitureGetMenu.active = true;
		__house_menu_main._buttonToFoundationPutMenu.active = true;		
		
		__house_menu_main._buttonToFurniturePutMenu.label.bold = true;
		__house_menu_main._buttonToFurniturePutMenu.has_toggle = true;
		__house_menu_main._buttonToFurniturePutMenu.set_toggled(true);
		
		activeFurniturePutElements();		
		activeFurnitureMenuElements();
		
		buttonNotActiveFurnitureGet();
		buttonNotActiveFoundationPut();
				
		//__house_menu_main._buttonToFurniturePutMenu.active = false;			
		__house_foundation_put.visible = false;
		__house_foundation_put.active = false;
		
		__house_furniture_put.active = true;
		__house_furniture_put.__scrollable_area.active = true;		
		__house_furniture_put.visible = true;
		__house_furniture_put.__scrollable_area.visible = true;
		
		__house_menu_furniture._stack_item_backwards.active = true;
		__house_menu_furniture._stack_item_forwards.active = true;
		__house_menu_furniture._button_is_hidden.active = true;
		__house_menu_furniture._button_item_behind_walls.active = true;
		__house_menu_furniture._text_order.active = true;
		
		__house_menu_furniture._text_of_item_selected.visible = true;
		__house_menu_furniture._stack_item_backwards.visible = true;
		__house_menu_furniture._stack_item_forwards.visible = true;
		__house_menu_furniture._text_order.visible = true;
		
		
	}
	
	public function buttonToFoundationPutMenu():Void
	{		
		RegHouse._house_main_menu_button_number = 2;
		
		__house_menu_main._buttonToFurniturePutMenu.active = true;
		__house_menu_main._buttonToFurnitureGetMenu.active = true;		
		
		__house_menu_main._buttonToFoundationPutMenu.label.bold = true;
		__house_menu_main._buttonToFoundationPutMenu.has_toggle = true;
		__house_menu_main._buttonToFoundationPutMenu.set_toggled(true);
		
		notActiveFurnitureMenuElements();
		buttonNotActiveFurnitureGet();
		buttonNotActiveFurniturePut();
		
		//__house_menu_main._buttonToFoundationPutMenu.active = false;

		
		__house_furniture_put.__scrollable_area.visible = false;
		__house_furniture_put.visible = false;
		__house_furniture_put.__scrollable_area.active = false;
		__house_furniture_put.active = false;
		
		__house_foundation_put.active = true;
		__house_foundation_put.visible = true;
		
		// reset vars.
		__house_foundation_put._item_selected_x = 0;
		__house_foundation_put._item_selected_y = 0;
	}	
	
	override public function destroy()
	{
		if (_bg != null)
		{
			_bg.destroy();
			_bg = null;
		}
		
		if (__house_furniture_items_front != null)
		{
			__house_furniture_items_front.destroy();
			__house_furniture_items_front = null;
		}
		
		if (__house_furniture_items_back != null)
		{
			__house_furniture_items_back.destroy();
			__house_furniture_items_back = null;
		}
		
		if (_housePageMapFloorHover != null)
		{
			_housePageMapFloorHover.destroy();
			_housePageMapFloorHover = null;
		}
		
		if (__house_furniture_get != null)
		{
			__house_furniture_get.destroy();
			__house_furniture_get = null;
		}
		
		if (__house_menu_furniture != null)
		{
			__house_menu_furniture.destroy();
			__house_menu_furniture = null;
		}
		
		if (__house_menu_main != null)
		{
			__house_menu_main.destroy();
			__house_menu_main = null;
		}
		
		if (_tracker != null)
		{
			_tracker.destroy();
			_tracker = null;
		}
		
		if (__house_foundation_put != null)
		{
			__house_foundation_put.destroy();
			__house_foundation_put = null;
		}
		
		if (__house_furniture_put != null)
		{
			__house_furniture_put.destroy();
			__house_furniture_put = null;
		}
		
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		
		if (RegTriggers._houseDrawSpritesDoNotEnter == true)
		{
			RegTriggers._houseDrawSpritesDoNotEnter = false;
			initialize();
			
			PlayState.__scene_lobby.__menu_bar.scene_house_return_to_lobby();
		}
		
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		
		if (_houseDataLoaded == true)
		{			
			if (RegHouse._house_main_menu_button_number <= 1) 
			{
				_housePageMapFloorHover.visible = false;
			}
			
			else
			{
				// this highlights the select unit. hide if at the panel.
				if (FlxG.mouse.x > 373) _housePageMapFloorHover.visible = true;
				else _housePageMapFloorHover.visible = false;
			}
			
			// fix a camera display bug where the following buttons can also be clicked from the right side of the screen because of the chatter scrollable area scrolling part of the scene.
			if (_ticks_menu_bar == 1)
			{
				if (FlxG.mouse.x > FlxG.width / 2 + HouseScrollMap._map_offset_x
				&&  FlxG.mouse.y >= FlxG.height - 50) 
				{
					__house_menu_main._buttonToFurnitureGetMenu.active = false;
					__house_menu_main._buttonToFurniturePutMenu.active = false;	
					__house_menu_main._buttonToFoundationPutMenu.active = false;
				}
				else
				{
					__house_menu_main._buttonToFurnitureGetMenu.active = true;
					__house_menu_main._buttonToFurniturePutMenu.active = true;
					__house_menu_main._buttonToFoundationPutMenu.active = true;
				}
			}
			
			// only enter this code after a update() elapsed so that the button's text is displayed correctly. 
			if (_ticks_build_buttons == 1)
			{
				if (FlxG.mouse.x > 373 + HouseScrollMap._map_offset_x) 
				{
					__house_foundation_put._buttonItemPosition1.active = false;
					__house_foundation_put._buttonItemPosition2.active = false;
					__house_foundation_put._buttonItemRemoveTile.active = false;
				}
				else
				{
					__house_foundation_put._buttonItemPosition1.active = true;
					__house_foundation_put._buttonItemPosition2.active = true;
					__house_foundation_put._buttonItemRemoveTile.active = true;
				}
			}
			
			_ticks_menu_bar = 1;
			if (__house_menu_main._buttonToFoundationPutMenu.has_toggle == true)
				_ticks_build_buttons = 1;
			
			// -------------------------- map hover needed to get map floor id.
			if (ActionInput.coordinateX() < FlxG.width + HouseScrollMap._map_offset_x
			&&  ActionInput.coordinateY() > 50 
			&&  ActionInput.coordinateY() < FlxG.height - 50 + HouseScrollMap._map_offset_y
			&& _housePageMapFloorHover.visible == true)
			{	
				var _tile_offset_x:Float = 0; // used to position the items on the map.
				var _tile_offset_y:Float = 0;
				
				// pixel of value 102 is the center of row 1. For each row after the first row, its value and minus 3 is used for the next row, for a if condition of mouse.x greater value. the _xx value of plus 3 is given to each row so that a if condition of mouse.x lesser value. when the mouse is within those coordinates then the hover image will display.
				var _xx:Int = 102;
				
				for (y in 0...21)
				{
					if (FlxMath.isOdd(y))
					{				
						// since y value in this loop is read after the row is drawn, these values refers to the first tile of the new row.
						_tile_offset_x = 101.5; // for every second row we use this value.
					}
					
					else
					{
						_tile_offset_x = 0;
					}			
					
					for (x in 0... 11)
					{// do every second row.
						
						// ii is used to minus its value when past the half was point of the images y value. so, at the top of the image, _xx is used to increase its value so the first few pixels at x center will highlight the hover image if mouse is overtop of those pixels. At the next row, the _xx value increases. When at the halfway point of the images y value, the _xx values needs to decrease. The ii var is used to do just that.
						var ii:Int = 0;
						
						// 72 row for the first vertical half of image.
						for (i in 1...73)
						{
							if (i >= 36) ii -= 1;
							else ii += 1;
							
							// if the mouse is within this region then display the hover image. a value of 203 is the images width. _tile_start_offset_x just moves the image over so many pixels from the edge of scene. i * 2 basically checks for two y rows.
							if (ActionInput.coordinateX() >= (x * 203) + (_tile_offset_x + _tile_start_offset_x + 373) + (_xx - (ii * 3))
							&&  ActionInput.coordinateX() <= (x * 203) + (_tile_offset_x + _tile_start_offset_x + 373) + (_xx + (ii * 3) - 1)
							&&  ActionInput.coordinateY() >= (y * _tile_offset_y) + _tile_start_offset_y + (i * 2) - 1
							&&  ActionInput.coordinateY() <= (y * _tile_offset_y) + _tile_start_offset_y + (i * 2) + 1	
							)
							{
								if (FlxMath.isOdd(y) && x < Std.int(_floorTileAmount/2)-5
								||  FlxMath.isEven(y))
								{
									_housePageMapFloorHover.x = (x * 203) + _tile_offset_x + _tile_start_offset_x + 373;
									_housePageMapFloorHover.y = (y * _tile_offset_y) + _tile_start_offset_y;
								}
								
								_hover_x = Std.int(x);
								_hover_y = Std.int(y);
								_hover_p_value = x + (y * Std.int(((_floorTileAmount/2)-4))); // this value is passed to a class to display the instance.
							}					
						}				
						
						
					}
					
					// a value of 71 is about half vertical of image.
					_tile_offset_y = 71.5;
				}
			}
			// ------------------------- end of map hover.
			
			
			_tracker.x = _tracker_start_x + HouseScrollMap._map_offset_x;
			_tracker.y = _tracker_start_y + HouseScrollMap._map_offset_y;
		}
		
		super.update(elapsed);
	}
	
}//