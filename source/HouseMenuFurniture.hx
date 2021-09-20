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
 * when "furniture get" button is selected, the house coins text is displayed.
 * when "furniture put" button is selected, furniture items can either be placed in front/behind another member or placed in front or behind a wall.
 * @author kboardgames.com
 */
class HouseMenuFurniture extends FlxGroup
{
	/******************************
	 * hides the grid that would be shown underneath the lobby and disconnect buttons and also displays another horizontal bar at the top of the scene.
	 */
	public var _bgHorizontal:FlxSprite;
	
	/******************************
	 * displays the total amount of house coins the player has.
	 */
	private var _text_house_coins:FlxText;
	
	/******************************
	 * this is the text of the item selected.
	 */
	public var _text_of_item_selected:FlxText; 
	
	/******************************
	 * this is the text displayed beside the z-order buttons. those buttons are used to change the order of a selected item within the item members.
	 */
	public var _text_order:FlxText; 
	
	/******************************
	 * move sprite down 1 in the members z-order list.
	*/
	public var _stack_item_backwards:ButtonGeneralNetworkNo; 
	
	/******************************
	 * move sprite up 1 in the members z-order list.
	*/
	public var _stack_item_forwards:ButtonGeneralNetworkNo;
	
	/******************************
	 * HouseFurnitureItemsFront instance.
	*/
	private var _items:HouseFurnitureItemsFront;
	private var __house_furniture_put:HouseFurniturePut;
	private var __house_map_furniture:HouseMapFurniture;
	private var __house:House;
	
	/******************************
	 * this is the current member selected.
	 */
	public static var _members:Int = 0;
	
	/******************************
	 * true if the mouse clicked the drag window.
	 */
	private var _mouse_clicked_item:Bool = false; 
	
	
	/******************************
	 * is_hidden button. toggles the visibility of the furniture item on the map.
	 */
	public var _button_is_hidden:ButtonGeneralNetworkNo;
	
	
	/******************************
	 * button to toggle placing an item behind / in front of a walls.
	 */
	public var _button_item_behind_walls:ButtonGeneralNetworkNo;
	
	override public function new(house:House, items:HouseFurnitureItemsFront, house_furniture_put, house_map_furniture:HouseMapFurniture):Void
	{
		super();
		
		_members = 0;
		
		_items = items;
		
		__house = house;
		__house_furniture_put = house_furniture_put;	
		__house_map_furniture = house_map_furniture;
		
		
		// hides the grid that would be shown underneath the buttons and text.
		_bgHorizontal = new FlxSprite(0, 0);
		_bgHorizontal.makeGraphic(FlxG.width, 55, 0xFF000000);
		_bgHorizontal.scrollFactor.set(0, 0);
		_bgHorizontal.visible = false;
		add(_bgHorizontal);
		
		//---------------------- "furniture get" elements below this line.
		_text_house_coins = new FlxText(0, 10, 0, "", 24);
		_text_house_coins.text = "House Coins: " + Std.string(RegTypedef._dataStatistics._houseCoins);
		_text_house_coins.font = Reg._fontDefault;
		_text_house_coins.color = FlxColor.WHITE;
		_text_house_coins.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF222222, 2);
		_text_house_coins.scrollFactor.set(0, 0);
		_text_house_coins.visible = false;
		add(_text_house_coins);
		
		
		//---------------------- "furniture put" elements below this line.
		_text_of_item_selected = new FlxText(570, 18, 0, "No item selected.", 24);
		_text_of_item_selected.font = Reg._fontDefault;
		_text_of_item_selected.color = FlxColor.WHITE;
		_text_of_item_selected.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF222222, 2);
		_text_of_item_selected.scrollFactor.set(0, 0);
		_text_of_item_selected.visible = false;
		add(_text_of_item_selected);
			
		_text_order = new FlxText(570, 67, 0, "Item Z-order.", 24);
		_text_order.font = Reg._fontDefault;
		_text_order.color = FlxColor.WHITE;
		_text_order.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF222222, 2);
		_text_order.scrollFactor.set(0, 0);
		_text_order.visible = false;
		add(_text_order);
		
		// bring the selected image minus 1 in z-order.
		_stack_item_backwards = new ButtonGeneralNetworkNo(_text_order.x + 200, 57, "<", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, stack_item_backwards);	
		//_stack_item_backwards.label.font = Reg._fontDefault;	
		_stack_item_backwards.visible = false;
		_stack_item_backwards.active = false;
		add(_stack_item_backwards);	
		
		_stack_item_forwards = new ButtonGeneralNetworkNo(_text_order.x + 250, 57, ">", 35, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, stack_item_forwards);		
		//_stack_item_forwards.label.font = Reg._fontDefault;
		_stack_item_forwards.visible = false;
		_stack_item_forwards.active = false;
		add(_stack_item_forwards);
				
		_button_item_behind_walls = new ButtonGeneralNetworkNo(620 + 350, 57, "", 160 + 65, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, toggle_item_front_or_back_walls);		
		_button_item_behind_walls.label.font = Reg._fontDefault;
		_button_item_behind_walls.visible = false;
		_button_item_behind_walls.active = false;
		add(_button_item_behind_walls);
		
				// 620 = lobby button location. this button is hide/show.
		_button_is_hidden = new ButtonGeneralNetworkNo(620 + 600, 57, "", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, item_toggle_visibility);		
		_button_is_hidden.label.font = Reg._fontDefault;
		_button_is_hidden.visible = false;
		_button_is_hidden.active = false;
		add(_button_is_hidden);
	}
	
	override public function destroy()
	{
		if (_bgHorizontal != null)
		{
			_bgHorizontal.destroy();
			_bgHorizontal = null;
		}
		
		if (_text_house_coins != null)
		{
			_text_house_coins.destroy();
			_text_house_coins = null;
		}
		
		if (_text_of_item_selected != null)
		{
			_text_of_item_selected.destroy();
			_text_of_item_selected = null;
		}
		
		if (_stack_item_backwards != null)
		{
			_stack_item_backwards.destroy();
			_stack_item_backwards = null;
		}
		
		if (_stack_item_forwards != null)
		{
			_stack_item_forwards.destroy();
			_stack_item_forwards = null;
		}
		
		if (_button_is_hidden != null)
		{
			_button_is_hidden.destroy();
			_button_is_hidden = null;
		}
		
		if (_text_order != null)
		{
			_text_order.destroy();
			_text_order = null;
		}
		
		if (_button_item_behind_walls != null)
		{
			_button_item_behind_walls.destroy();
			_button_item_behind_walls = null;
		}
		
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		if (RegHouse._house_main_menu_button_number != 1)
		{
			// the background displayed behind the selected member is now hidden.
			__house_map_furniture._bg_behind_item.visible = false;
			__house_map_furniture._house_drag_icon.visible = false;
			__house_map_furniture._house_rotate_icon.visible = false;
		}
		
		else if (_members == 0)
		{
			__house_map_furniture._bg_behind_item.visible = false;
			__house_map_furniture._house_drag_icon.visible = false;
			__house_map_furniture._house_rotate_icon.visible = false;
		}
		
		else
		{
			__house_map_furniture._bg_behind_item.visible = true;
			__house_map_furniture._house_drag_icon.visible = true;
			__house_map_furniture._house_rotate_icon.visible = true;
		}
		
		// furniture get
		if (RegHouse._house_main_menu_button_number == 0)
		{
			_text_house_coins.visible = true;
		}
		
		// furniture put.
		if (RegHouse._house_main_menu_button_number == 1)
		{
			_text_house_coins.visible = false;
			
			if (_members > 0)
			{
				// this keeps the drag icon at the top left corner of the icon.
				__house_map_furniture._house_drag_icon.x = __house_map_furniture._bg_behind_item.x + 2;
				__house_map_furniture._house_drag_icon.y = __house_map_furniture._bg_behind_item.y + 2;
				
				__house_map_furniture._house_rotate_icon.x = __house_map_furniture._bg_behind_item.x + 2 + __house_map_furniture._bg_behind_item.width - 40;
				__house_map_furniture._house_rotate_icon.y = __house_map_furniture._bg_behind_item.y + 2;
				
				// move the _item but only if the mouse is not near the FlxButtons that are displayed at the edge of the screen.
				if (ActionInput.coordinateX()  - HouseScrollMap._map_offset_x > 373
				&&  ActionInput.coordinateY()  - HouseScrollMap._map_offset_y > 55
				&&  ActionInput.coordinateY() < (FlxG.height - 55) + HouseScrollMap._map_offset_y)
				{
					if (ActionInput.overlaps(__house_map_furniture._house_drag_icon)
					&& ActionInput.pressed() == true
					||  _mouse_clicked_item == true)
					{
						__house_map_furniture._house_drag_icon.x = ActionInput.coordinateX() - 16;
						__house_map_furniture._house_drag_icon.y = ActionInput.coordinateY() - 16;
						
						__house_map_furniture._bg_behind_item.x = __house_map_furniture._house_drag_icon.x - 2;
						__house_map_furniture._bg_behind_item.y = __house_map_furniture._house_drag_icon.y - 2;
						
						RegHouse._items_x[_members-1] = Std.int(__house_map_furniture._bg_behind_item.x) + 40;
						RegHouse._items_y[_members-1] = Std.int(__house_map_furniture._bg_behind_item.y);
						
						RegHouse._map_x[_members-1] = __house._tracker.x;
						RegHouse._map_y[_members-1] = __house._tracker.y;
						
						RegHouse._map_offset_x[_members-1] = HouseScrollMap._map_offset_x;
						RegHouse._map_offset_y[_members-1] = HouseScrollMap._map_offset_y;
					
						__house_map_furniture.member_move(_members);
						
						_mouse_clicked_item = true; // this is needed to keep dragging the __house_map_furniture._house_drag_icon until the mouse is released.					
					}
					
					// rotate the object if the rotate icon was mouse clicked.
					if (ActionInput.overlaps(__house_map_furniture._house_rotate_icon)
					&& ActionInput.justReleased())
					{
						if (RegCustom._sound_enabled[Reg._tn] == true
						&&  Reg2._boxScroller_is_scrolling == false)
							FlxG.sound.play("click", 1, false);
						
						if (RegHouse._item_direction_facing[_members-1] == 0)
						{
							RegHouse._item_direction_facing[_members-1] = 1;
							
							for (i in 0... RegHouse._totalPurchased + 1)
							{
								if (RegHouse._item_order[i] == HouseFurniturePut._value_from_item_order)
								{
									HouseFurnitureItemsFront._group_sprite[RegHouse._item_order[i]].animation.play("1");
									HouseFurnitureItemsBack._group_sprite[RegHouse._item_order[i]].animation.play("1");
								}
							}
						}
						
						else if (RegHouse._item_direction_facing[_members-1] == 1)
						{
							RegHouse._item_direction_facing[_members-1] = 2;
							
							for (i in 0... RegHouse._totalPurchased + 1)
							{
								if (RegHouse._item_order[i] == HouseFurniturePut._value_from_item_order)
								{
									HouseFurnitureItemsFront._group_sprite[RegHouse._item_order[i]].animation.play("2");
									HouseFurnitureItemsBack._group_sprite[RegHouse._item_order[i]].animation.play("2");
								}
							}
							
						}
						
						else if (RegHouse._item_direction_facing[_members-1] == 2)
						{
							RegHouse._item_direction_facing[_members-1] = 3;
							for (i in 0... RegHouse._totalPurchased + 1)
							{
								if (RegHouse._item_order[i] == HouseFurniturePut._value_from_item_order)
								{
									HouseFurnitureItemsFront._group_sprite[RegHouse._item_order[i]].animation.play("3");
									HouseFurnitureItemsBack._group_sprite[RegHouse._item_order[i]].animation.play("3");
								}
							}
						}
						
						else if (RegHouse._item_direction_facing[_members-1] == 3)
						{
							RegHouse._item_direction_facing[_members-1] = 0;
							for (i in 0... RegHouse._totalPurchased + 1)
							{
								if (RegHouse._item_order[i] == HouseFurniturePut._value_from_item_order)
								{
									HouseFurnitureItemsFront._group_sprite[RegHouse._item_order[i]].animation.play("0");
									HouseFurnitureItemsBack._group_sprite[RegHouse._item_order[i]].animation.play("0");
								}
							}
						}
					}
				}
				
				if (ActionInput.justReleased() == true
				&&  ActionInput.coordinateX()  - HouseScrollMap._map_offset_x > 373
				&&  _members-1 > -1)
				{
					_mouse_clicked_item = false;
				}
			}
		}			
		
		_text_house_coins.text = "House Coins: " + Std.string(RegTypedef._dataStatistics._houseCoins);
		_text_house_coins.x = -20 + FlxG.width - _text_house_coins.textField.textWidth;
		
		// an item at the panel was clicked so highlight that furniture item at the map.
		if (RegTriggers._item_select_triggered_from_put_panel == true)
			item_select_triggered_from_put_panel();
		
		if (ActionInput.justReleased() == true)
			RegTriggers._item_select_triggered_from_put_panel = false;
		
		super.update(elapsed);
	}
		
	public function stack_item_backwards():Void
	{
		if (_members == 0) return;
		
		if (_members > 1) 
		{			
			__house_map_furniture.members_bring_backward(_members, true);
			_members -= 1;
		}	
		
	}
	
	public function stack_item_forwards():Void
	{
		if (_members == 0) return;
		
		if (_members < _items.members.length) 
		{					
			__house_map_furniture.members_bring_forward(_members, true);
			_members += 1;
		}		
	}
	
	
	/******************************
	 * display an item in the list of bought items that was selected from the HouseFurniturePut.hx class.
	 */
	private function item_select_triggered_from_put_panel():Void
	{
		__house_map_furniture._bg_behind_item.visible = true;
		__house_map_furniture._house_drag_icon.visible = true;
		__house_map_furniture._house_rotate_icon.visible = true;
			
		_text_of_item_selected.text = RegHouse._namesPurchased[_members]+".";
		__house_map_furniture.member_bg_behind(_members);					
		
		__house.__house_menu_furniture._button_is_hidden.active = true;
		__house.__house_menu_furniture._button_item_behind_walls.active = true;
		__house.__house_menu_furniture._button_is_hidden.visible = true;
		__house.__house_menu_furniture._button_item_behind_walls.visible = true;
						
		mapCenterOnItem();
	}
	
	/******************************
	 * when this button is clicked, the furniture item visibility will be toggled.
	 */
	public function item_toggle_visibility():Void
	{
		if (HouseFurniturePut._value_from_item_order >= 0)
		{
			// first we toggle the furniture var then we toggle the furniture item on the map.
			if (RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] == 0)
			{
				RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] = 1;
				HouseFurnitureItemsFront._group.members[HouseFurniturePut._value_from_item_order].visible = false;
				HouseFurnitureItemsBack._group.members[HouseFurniturePut._value_from_item_order].visible = false;
			}
			else
			{
				RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] = 0;
				if (RegHouse._item_behind_walls[HouseFurniturePut._value_from_item_pressed] == 0)
					HouseFurnitureItemsFront._group.members[HouseFurniturePut._value_from_item_order].visible = true;
				else
					HouseFurnitureItemsBack._group.members[HouseFurniturePut._value_from_item_order].visible = true;
			}
		
			button_toggle_visibility_text();
		}
	}
	
	public function button_toggle_visibility_text():Void
	{
		if (RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] == 0)
			_button_is_hidden.label.text = "Hide Item";
		else
			_button_is_hidden.label.text = "Show Item";
	}
	
	/******************************
	 * this function either brings the selected furniture item in front or behind a wall.
	 */
	public function toggle_item_front_or_back_walls():Void
	{	
		if (HouseFurniturePut._value_from_item_order >= 0)
		{
			if (RegHouse._item_behind_walls[HouseFurniturePut._value_from_item_pressed] == 1)
			{
				if (RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] == 0)
				{
					RegHouse._item_behind_walls[HouseFurniturePut._value_from_item_pressed] = 0;
					HouseFurnitureItemsFront._group_sprite[HouseFurniturePut._value_from_item_order].visible = true;
					HouseFurnitureItemsBack._group_sprite[HouseFurniturePut._value_from_item_order].visible = false;
				}
			}
			
			else
			{
				if (RegHouse._item_is_hidden[HouseFurniturePut._value_from_item_pressed] == 0)
				{
					RegHouse._item_behind_walls[HouseFurniturePut._value_from_item_pressed] = 1;
					HouseFurnitureItemsFront._group_sprite[HouseFurniturePut._value_from_item_order].visible = false;
					HouseFurnitureItemsBack._group_sprite[HouseFurniturePut._value_from_item_order].visible = true;
				}
			}
			
			button_toggle_walls_text();
		}
	}
	
	/******************************
	 * this toggles the text of the _button_item_behind_walls.
	 */
	public function button_toggle_walls_text():Void
	{
		if (RegHouse._item_behind_walls[HouseFurniturePut._value_from_item_pressed] == 1)
			_button_item_behind_walls.label.text = "Front of Wall";
		else
			_button_item_behind_walls.label.text = "Behind Wall";
	}
	
	public function buttons_set_text_null():Void
	{
		_button_is_hidden.label.text = "";
		_button_item_behind_walls.label.text = "";
		
		_button_is_hidden.visible = false;
		_button_is_hidden.active = false;
		
		_button_item_behind_walls.visible = false;
		_button_item_behind_walls.active = false;
	}
	
	/******************************
	 * if the item is not displayed on the visible map but the item is somewhere beyond the area of the map displayed then this will center the item on the map by changing the map coordinates.
	 */
	private function mapCenterOnItem():Void
	{
		if ((_members - 1) > -1)
		{
			__house._tracker.x = RegHouse._map_x[_members-1];
			__house._tracker.y = RegHouse._map_y[_members-1];
			
			HouseScrollMap._map_offset_x = RegHouse._map_offset_x[_members-1];
			HouseScrollMap._map_offset_y = RegHouse._map_offset_y[_members-1];
		}
		
	}
	
}