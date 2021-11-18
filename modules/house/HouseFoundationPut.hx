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

package modules.house;

/**
 * Menu used to select a floor or wall tiles to draw on scene.
 * @author kboardgames.com
 */
class HouseFoundationPut extends FlxGroup
{
	/******************************
	 * the background for this class.
	 */
	private var _bg:FlxSprite;
	
	/******************************
	 * menu title
	 */
	private var _title:FlxText;
	
	/******************************
	 * location of the floor and tile icons that are drawn on the menu bg.
	 */
	private var _item_location_x:Array<Int> = 
	[17, 135, 253];
	
	/******************************
	 * location of the floor and tile icons that are drawn on the menu bg.
	 */
	private var _item_location_y:Array<Int> = 
	[110,  228,  346,  464, 582];
	
	/******************************
	 * used to new the hover which is a hollow square box that parameters the current item selected.
	 */
	private var _item_hover:FlxSprite;
	
	/******************************
	 * used to new the item so that it can be placed on the map.
	 */
	private var _item_selected:FlxSprite;
	
	/******************************
	 * location of the current item selected at the menu.
	 */
	public var _item_selected_x:Int = 0;
	
	/******************************
	 * location of the current item selected at the menu.
	 */
	public var _item_selected_y:Int = 0;
	
	/******************************
	 * this is the id value of the item selected.
	 */
	public var _item_Selected_id:Int = -1;
	
	/******************************
	 * used to position the sprites and text.
	 */
	private var _offset_y:Int = 50;
	
	/******************************
	 * the total items displayed.
	 */
	private var _item_total:Int = 0;
	
	/******************************
	 * from left to right then top to down. this is the item number that was mouse clicked.
	 */
	public var _item_number:Int = -1;
		
	/******************************
	 * when selecting an item, the item number starts at the first floor with a value of 0. when the mouse is used to select the second row, first column that would have a value of 3. that also refers to the first wall. since that first wall is called 1.png, we can subtract this vars value to get that correct floor name. hence, "+(_item_number - _floorTotal)+".png   
	 */
	public var _floorTotal:Int = 2;
	
	/******************************
	 * used to remove a tile from map.
	 */
	public var _buttonItemRemoveTile:ButtonGeneralNetworkNo;
	
	/******************************
	 * this is for selecting a north-west door or wall.
	 */
	public var _buttonItemPosition1:ButtonToggleFlxState;
	
	/******************************
	 * this is for selecting a north-east door or wall.
	 */
	public var _buttonItemPosition2:ButtonToggleFlxState;
	
	/******************************
	 * class instance. Menu of selectable bought furniture. 
	 */
	private var __house_furniture_put:HouseFurniturePut; 
	
	override public function new(house_furniture_put:HouseFurniturePut):Void
	{
		super();
		
		__house_furniture_put = house_furniture_put;
		
		// background. DO NOT change the x position of this var without also changing its x value at SceneGameRoom.toggleButtonsAsChatterScrolls();
		_bg = new FlxSprite(0, 0);
		_bg.makeGraphic(373, FlxG.height - 45, 0xFF002222);
		_bg.scrollFactor.set(0, 0);
		add(_bg);
		
		_title = new FlxText(17, 30+_offset_y - 55, 0, "Map Foundation tiles");
		_title.setFormat(Reg._fontDefault, 22, FlxColor.WHITE);
		_title.scrollFactor.set();
		add(_title);
		
		var i:Int = 0;
		
		// floor.
		for (y in 0...1)
		{
			for (x in 0...3)
			{
				var _tile_bg = new FlxSprite(_item_location_x[x], _item_location_y[y] + _offset_y);
				_tile_bg.makeGraphic(100, 100, 0xFF003333);
				_tile_bg.scrollFactor.set(0, 0);
				add(_tile_bg);
				
				var _tile = new FlxSprite(_item_location_x[x], _item_location_y[y] + _offset_y);
				_tile.loadGraphic("modules/house/assets/images/house/foundation/get/floors/"+i+".png", false);
				_tile.scrollFactor.set(0, 0);
				add(_tile);
			
				i += 1;
				_item_total += 1;
			}
		}
		
		var i:Int = 1;
		
		// walls.
		for (y in 1...3) // second row to minus 1 of this value. so if the value is 1...4 then its the second row to  forth row. remember 0 is the first row.
		{
			for (x in 0...3)
			{
				var _tile_bg = new FlxSprite(_item_location_x[x], _item_location_y[y] + _offset_y);
				_tile_bg.makeGraphic(100, 100, 0xFF003333);
				_tile_bg.scrollFactor.set(0, 0);
				add(_tile_bg);
				
				var _tile = new FlxSprite(_item_location_x[x], _item_location_y[y] + _offset_y);
				_tile.loadGraphic("modules/house/assets/images/house/foundation/get/walls/"+i+".png", false);
				_tile.scrollFactor.set(0, 0);
				add(_tile);
				
				i += 1;
				_item_total += 1;
			}
		}
		
		_item_selected = new FlxSprite(-1000, -1000);
		_item_selected.loadGraphic("modules/house/assets/images/houseItemSelected.png", false);
		_item_selected.scrollFactor.set(0, 0);
		add(_item_selected);
		
		_item_hover = new FlxSprite(_item_location_x[0], _item_location_y[4] + _offset_y);
		_item_hover.loadGraphic("modules/house/assets/images/houseItemHover.png", false);
		_item_hover.scrollFactor.set(0, 0);
		_item_hover.visible = false;
		add(_item_hover);
				
		_buttonItemPosition1 = new ButtonToggleFlxState(17, FlxG.height - 95-100, 1, "North-West", 160, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonPositionToggle1, RegCustom._button_color[Reg._tn]);
		_buttonItemPosition1.label.font = Reg._fontDefault;	
		_buttonItemPosition1.set_toggled(true);
		_buttonItemPosition1.has_toggle = true;
		add(_buttonItemPosition1);
		
		_buttonItemPosition2 = new ButtonToggleFlxState(160 + 30, FlxG.height - 95-100, 2, "North-East", 160, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonPositionToggle2, RegCustom._button_color[Reg._tn]);
		_buttonItemPosition2.label.font = Reg._fontDefault;		
		add(_buttonItemPosition2);
		
		_buttonItemRemoveTile = new ButtonGeneralNetworkNo(17+40+7, FlxG.height - 130, "Remove Tile On", 240 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, buttonRemoveTile, RegCustom._button_color[Reg._tn]);
		_buttonItemRemoveTile.label.font = Reg._fontDefault;
		add(_buttonItemRemoveTile);
		
	
	}
	
	/******************************
	 * button used to remove a tile. when this button text reads "Remove Tile Off" then when pressing the mouse button on a map tile that tile will be removed and an empty tile will be displayed at that location.
	 */
	private function buttonRemoveTile():Void
	{
		if (_buttonItemRemoveTile.label.text == "Remove Tile Off")
		{
			_buttonItemRemoveTile.label.text = "Remove Tile On";
		}
			
		else if (_buttonItemRemoveTile.label.text == "Remove Tile On")
		{
			_buttonItemRemoveTile.label.text = "Remove Tile Off";
		}
		
	}
	
	private function buttonPositionToggle1():Void
	{
		_buttonItemPosition1.set_toggled(true);
		_buttonItemPosition1.has_toggle = true;
		
		_buttonItemPosition2.set_toggled(false);
		_buttonItemPosition2.has_toggle = false;
	}
	
	private function buttonPositionToggle2():Void
	{
		_buttonItemPosition2.set_toggled(true);
		_buttonItemPosition2.has_toggle = true;
		
		_buttonItemPosition1.set_toggled(false);
		_buttonItemPosition1.has_toggle = false;
	}
	
	override public function destroy()
	{
		if (_bg != null)
		{
			remove(_bg);
			_bg.destroy();
			_bg = null;
		}
		
		if (_title != null)
		{
			remove(_title);
			_title.destroy();
			_title = null;
		}
		
		if (_item_selected != null)
		{
			remove(_item_selected);
			_item_selected.destroy();
			_item_selected = null;
		}
		
		if (_item_hover != null)
		{
			remove(_item_hover);
			_item_hover.destroy();
			_item_hover = null;
		}
		
		if (_buttonItemRemoveTile != null)
		{
			remove(_buttonItemRemoveTile);
			_buttonItemRemoveTile.destroy();
			_buttonItemRemoveTile = null;
		}
		
		if (_buttonItemPosition1 != null)
		{
			remove(_buttonItemPosition1);
			_buttonItemPosition1.destroy();
			_buttonItemPosition1 = null;
		}
		
		if (_buttonItemPosition2 != null)
		{
			remove(_buttonItemPosition2);
			_buttonItemPosition2.destroy();
			_buttonItemPosition2 = null;
		}
		
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		if (RegHouse._house_main_menu_button_number < 2) return;		
		
		var _found:Bool = false;
		var _count:Int = 0;
		
		
		// item are displayed 3 columns by 3 rows.
		for (y in 0...3)
		{
			for (x in 0...3)
			{
				if (_count < _item_total)
				{
					// is the mouse inside a region of a tile that can be selected?
					if (ActionInput.coordinateX() - HouseScrollMap._map_offset_x >= _item_location_x[x]
					&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x <= _item_location_x[x] + 100 
					&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y >= _item_location_y[y] + _offset_y 
					&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y <= _item_location_y[y] + _offset_y + 100)
					{
						// position the hover at the item where the mouse is located.
						_item_hover.setPosition(_item_location_x[x], _item_location_y[y] + _offset_y);
				
						_item_number = (y * 3) + x;
						_found = true; // set this so that hover item is not hidden.
						_item_hover.visible = true;
						
					}					
				}
				
				_count += 1;
			}
		}
		
		if (_found == false)
		{
			_item_number = -1;
			_item_hover.visible = false;
		}
		
		_count = 0;
		var _stop:Bool = false; // used to break out of a loop.
		
		// select the item by highlighting it when the mouse is clicked on an item.
		for (y in 0...3)
		{
			for (x in 0...3)
			{
				if (_count < _item_total)
				{
					// is the mouse inside a region of a tile that can be selected?
					if (ActionInput.coordinateX() - HouseScrollMap._map_offset_x >= _item_location_x[x]
					&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x <= _item_location_x[x] + 100 
					&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y >= _item_location_y[y] + _offset_y 
					&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y <= _item_location_y[y] + _offset_y + 100)
					{
						if (ActionInput.justPressed() == true)
						{
							if (RegCustom._sound_enabled[Reg._tn] == true
							&&  Reg2._scrollable_area_is_scrolling == false)
								FlxG.sound.play("click", 1, false);
						}
						
						if (ActionInput.justReleased() == true)
						{
							_item_selected_x = x;
							_item_selected_y = y;
							
							_item_Selected_id = (((_count + 1) * 3) - 3 + x);
							
							if (_item_Selected_id < 3)
							{
								_buttonItemPosition1.visible = false;
								_buttonItemPosition1.active = false;
		
								_buttonItemPosition2.visible = false;
								_buttonItemPosition2.active = false;
							}
							
							else
							{
								_buttonItemPosition1.active = true;
								_buttonItemPosition1.visible = true;	
								
								_buttonItemPosition2.active = true;
								_buttonItemPosition2.visible = true;
							}
							
							_stop = true;
						}
					}				
					
					if (_stop == true) break;
				}		
				
				if (_stop == true) break;
			}
			
			if (_stop == true) break;
			
			_count += 1;
		}
			
		// since the default value of _item_selected_x and _item_selected_y is 0, without a mouse click, this highlights on the first item displayed. if the mouse is clicked, then the code above will calculate its new position.
		if (_stop == true 
		||  _item_selected.x != -1000
		&&  _item_selected.y != -1000 
		)
		_item_selected.setPosition(_item_location_x[_item_selected_x], _item_location_y[_item_selected_y] + _offset_y);
		
		super.update(elapsed);
	}
	
}