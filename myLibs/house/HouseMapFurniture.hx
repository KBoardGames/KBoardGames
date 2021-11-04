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
 * furniture item functions such as members_bring_forward or members_change_z-order. these functions are called from the "houseMenuFurniture.hx" class.
 * @author kboardgames.com
 */
class HouseMapFurniture extends FlxGroup
{
	/******************************
	 * furniture items in front of a wall. HouseFurnitureItemsFront instance.
	*/
	public var _itemsFront:HouseFurnitureItemsFront;
	public var _itemsBack:HouseFurnitureItemsBack;
	
	private var __house_furniture_get:HouseFurnitureGet;
	private var __house:House;
	
	/******************************
	 * this is the background behind the selected item to be moved.
	*/
	public var _bg_behind_item:FlxSprite;
	
	/******************************
	 * this is used to mouse drag the selected item.
	*/
	public var _house_drag_icon:FlxSprite;	
	
	/******************************
	 * this is used to rotate the selected item.
	*/
	public var _house_rotate_icon:FlxSprite;	
	
	/******************************
	 * this is the current member selected.
	 */
	public var _members:Int = 0;
	
	
	override public function new(house:House, itemsFront:HouseFurnitureItemsFront, itemsBack:HouseFurnitureItemsBack, house_furniture_get):Void
	{
		super();
		
		_itemsFront = itemsFront;
		_itemsBack = itemsBack;
		
		__house = house;
		__house_furniture_get = house_furniture_get;	
			
		//---------------------
		_bg_behind_item = new FlxSprite(50, 50);
		_bg_behind_item.makeGraphic(400, 400);
		_bg_behind_item.color = 0xFF000000;
		_bg_behind_item.alpha = 0.30;
		_bg_behind_item.visible = false;
		add(_bg_behind_item);		
				
		_house_drag_icon = new FlxSprite();
		_house_drag_icon.loadGraphic("myLibs/house/assets/images/houseDragIcon.png", true, 36, 36);
		_house_drag_icon.animation.add("play", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1], 30);
		_house_drag_icon.animation.play("play");
		_house_drag_icon.visible = false;
		add(_house_drag_icon);
		
		_house_rotate_icon = new FlxSprite();
		_house_rotate_icon.loadGraphic("myLibs/house/assets/images/houseRotateIcon.png", true, 36, 36);
		_house_rotate_icon.animation.add("play", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1], 30);
		_house_rotate_icon.animation.play("play");
		_house_rotate_icon.visible = false;
		add(_house_rotate_icon);
	}
		
	public function member_move(_member:Int):Void
	{
		for (i in 0...RegHouse._totalPurchased + 1)
		{
			if (_member == HouseFurnitureItemsFront._group_sprite[i].ID)
			{
				HouseFurnitureItemsFront._group_sprite[i].x = _bg_behind_item.x + 40;
				HouseFurnitureItemsFront._group_sprite[i].y = _bg_behind_item.y;
				
				HouseFurnitureItemsBack._group_sprite[i].x = _bg_behind_item.x + 40;
				HouseFurnitureItemsBack._group_sprite[i].y = _bg_behind_item.y;
			}
		}
		
	}
	
	public function stack_item_backwards():Void
	{
		
		if (_members > 1) 
		{			
			//_members -= 1;
			members_bring_backward(_members, true);
			
		}
		
		
	}
	
	public function stack_item_forwards():Void
	{
		if (_members < _itemsFront.members.length) 
		{
			//_members += 1;		
			members_bring_forward(_members, true);
			
		}		
	}
	
	
	// display a background behind this member.
	public function member_bg_behind(_member:Int):Void
	{
		// ID is set at HouseFurnitureItemsFront class.
		for (i in 0...RegHouse._totalPurchased + 1) 
		{
			if (_member == HouseFurnitureItemsFront._group_sprite[i].ID)
			{
				// change the size of the background to be the same size as the member but has the left side of the background 40 width bigger.
				_bg_behind_item.makeGraphic(Std.int(HouseFurnitureItemsFront._group_sprite[i].width) + 80, Std.int(HouseFurnitureItemsFront._group_sprite[i].height));
				
				if (RegHouse._item_behind_walls[i] == 0)
				{
					_bg_behind_item.x = HouseFurnitureItemsFront._group_sprite[i].x - 40;
					_bg_behind_item.y = HouseFurnitureItemsFront._group_sprite[i].y;			
				}
				
				else
				{
					_bg_behind_item.x = HouseFurnitureItemsBack._group_sprite[i].x - 40;
					_bg_behind_item.y = HouseFurnitureItemsBack._group_sprite[i].y;			
				}
				
				break;
			}
		}
		
	}
	
	/******************************
	 * this function is called when the previous members list button is mouse clicked. 
	 * order_backwards		used with stack_item_backwards and stack_item_forwards buttons.
	 */
	public function members_bring_backward(_member:Int, _order_backwards:Bool = false):Void
	{
		var member = _member;
			
		for (i in 0...RegHouse._totalPurchased + 1)
		{
			if (_member == HouseFurnitureItemsFront._group_sprite[i].ID
			&&  HouseFurnitureItemsFront._group_sprite[i].ID > 1 
			//&&  _itemsFront._is_item_purchased[i] == 1
			)
			{
				// remove the member from the end of the list, from the top of the stack, and then insert it at its original location. _member var is the original location.			
				if (_order_backwards == true)
				{
					members_change_order((_member - 1), member);
					
					HouseFurnitureItemsFront._group_sprite[i].ID = member - 1;
					HouseFurnitureItemsBack._group_sprite[i].ID = member - 1;
					
					_members = Std.int(HouseFurnitureItemsFront._group_sprite[i].ID); 
				}			
				
				_itemsFront.members.remove(HouseFurnitureItemsFront._group_sprite[i]);
				_itemsFront.members.insert((_member - 2), HouseFurnitureItemsFront._group_sprite[i]);
				
				_itemsBack.members.remove(HouseFurnitureItemsBack._group_sprite[i]);
				_itemsBack.members.insert((_member - 2), HouseFurnitureItemsBack._group_sprite[i]);
				
				member -= 1;
				
				//------------------------
				// without this code, when changing z-order, a different image would rotate.
				var _int:Int = 0;
				_int = RegHouse._item_order[member-1];
				
				RegHouse._item_order[member-1] = RegHouse._item_order[member];
				RegHouse._item_order[member] = _int;
				
				// also update the furniture arrays
				var _str = RegHouse._namesPurchased[member];
				RegHouse._namesPurchased[member] = RegHouse._namesPurchased[member+1];
				RegHouse._namesPurchased[member+1] = _str;
				
				var _int = RegHouse._sprite_number[member-1];
				RegHouse._sprite_number[member-1] = RegHouse._sprite_number[member];
				RegHouse._sprite_number[member] = _int;
				
				//var _str:String = HouseFurniturePut._group_text[member-1].text;
				// z-order changed for furniture items, so refresh the panel at HouseFurniturePut.hx class.
				//HouseFurniturePut._group_text[member-1].text = HouseFurniturePut._group_text[member].text;
				//HouseFurniturePut._group_text[member].text = _str;
				
				var _str = RegHouse._items_x[member-1];
				RegHouse._items_x[member-1] = RegHouse._items_x[member];
				RegHouse._items_x[member] = _str;
				
				var _str = RegHouse._items_y[member-1];
				RegHouse._items_y[member-1] = RegHouse._items_y[member];
				RegHouse._items_y[member] = _str;
				
				var _str = RegHouse._map_x[member-1];
				RegHouse._map_x[member-1] = RegHouse._map_x[member];
				RegHouse._map_x[member] = _str;
				
				var _str = RegHouse._map_y[member-1];
				RegHouse._map_y[member-1] = RegHouse._map_y[member];
				RegHouse._map_y[member] = _str;
				
				var _str = RegHouse._is_item_purchased[member-1];
				RegHouse._is_item_purchased[member-1] = RegHouse._is_item_purchased[member];
				RegHouse._is_item_purchased[member] = _str;
				
				var _int = RegHouse._item_direction_facing[member-1];
				RegHouse._item_direction_facing[member-1] = RegHouse._item_direction_facing[member];
				RegHouse._item_direction_facing[member] = _int;
				
				var _int = RegHouse._map_offset_x[member-1];
				RegHouse._map_offset_x[member-1] = RegHouse._map_offset_x[member];
				RegHouse._map_offset_x[member] = _int;
				
				var _int = RegHouse._map_offset_y[member-1];
				RegHouse._map_offset_y[member-1] = RegHouse._map_offset_y[member];
				RegHouse._map_offset_y[member] = _int;
				
				var _int = RegHouse._item_is_hidden[member-1];
				RegHouse._item_is_hidden[member-1] = RegHouse._item_is_hidden[member];
				RegHouse._item_is_hidden[member] = _int;
				
				var _int = RegHouse._item_behind_walls[member-1];
				RegHouse._item_behind_walls[member-1] = RegHouse._item_behind_walls[member];
				RegHouse._item_behind_walls[member] = _int;
				
					//__house.__house_menu_furniture.toggle_item_front_or_back_walls();
				//}
				
				var _str = RegHouse._coins[member-1];
				RegHouse._coins[member-1] = RegHouse._coins[member];
				RegHouse._coins[member] = _str;
				
				HouseFurniturePut._value_from_item_pressed -= 1;
				//HouseFurniturePut._value_from_item_order = RegHouse._item_order[member-1]; 
			
				HouseFurniturePut.textAndspriteRefreshPanel();
				//------------------------
				
				member_move(_members);
				
				break;
			}
		}
		
	}
	
	
	public function members_bring_forward(_member:Int, _order_forwards:Bool = false):Void
	{
		var member = _member;
		
		for (i in 0...RegHouse._totalPurchased + 1)
		{
			if (_member == HouseFurnitureItemsFront._group_sprite[i].ID
			&&  HouseFurnitureItemsFront._group_sprite[i].ID < _itemsFront.members.length
			//&&  _itemsFront._is_item_purchased[i] == 1
			)
			{
				// remove the item from its ID location and place it at the end of the list. the end of the list will display the member that the top of all other sprites in that members list.
				if (_order_forwards == true)
				{
					members_change_order((_member + 1), member);
						
					HouseFurnitureItemsFront._group_sprite[i].ID = member + 1;
					HouseFurnitureItemsBack._group_sprite[i].ID = member + 1;
					
					_members = Std.int(HouseFurnitureItemsFront._group_sprite[i].ID); 
				}
		
		
				_itemsFront.members.remove(HouseFurnitureItemsFront._group_sprite[i]);
				_itemsFront.members.insert(_member, HouseFurnitureItemsFront._group_sprite[i]);
				
				_itemsBack.members.remove(HouseFurnitureItemsBack._group_sprite[i]);
				_itemsBack.members.insert(_member, HouseFurnitureItemsBack._group_sprite[i]);
				
				member -= 1;
				
				//------------------------
				// without this code, when changing z-order, a different image would rotate.
				var _int:Int = 0;
				_int = RegHouse._item_order[member];
				
				RegHouse._item_order[member] = RegHouse._item_order[member+1];
				RegHouse._item_order[member+1] = _int;
				
				// also update the furniture arrays
				var _str = RegHouse._namesPurchased[member+1];
				RegHouse._namesPurchased[member+1] = RegHouse._namesPurchased[member+2];
				RegHouse._namesPurchased[member+2] = _str;
				
				var _int = RegHouse._sprite_number[member];
				RegHouse._sprite_number[member] = RegHouse._sprite_number[member+1];
				RegHouse._sprite_number[member+1] = _int;
				
				//var _str:String = HouseFurniturePut._group_text[member].text;
				// z-order changed for furniture items, so refresh the panel at HouseFurniturePut.hx class.
				//HouseFurniturePut._group_text[member].text = HouseFurniturePut._group_text[member+1].text;
				//HouseFurniturePut._group_text[member+1].text = _str;
				
				var _str = RegHouse._items_x[member];
				RegHouse._items_x[member] = RegHouse._items_x[member+1];
				RegHouse._items_x[member+1] = _str;
				
				var _str = RegHouse._items_y[member];
				RegHouse._items_y[member] = RegHouse._items_y[member+1];
				RegHouse._items_y[member+1] = _str;
				
				var _str = RegHouse._map_x[member];
				RegHouse._map_x[member] = RegHouse._map_x[member+1];
				RegHouse._map_x[member+1] = _str;
				
				var _str = RegHouse._map_y[member];
				RegHouse._map_y[member] = RegHouse._map_y[member+1];
				RegHouse._map_y[member+1] = _str;
				
				var _str = RegHouse._is_item_purchased[member];
				RegHouse._is_item_purchased[member] = RegHouse._is_item_purchased[member+1];
				RegHouse._is_item_purchased[member+1] = _str;
				
				var _int = RegHouse._item_direction_facing[member];
				RegHouse._item_direction_facing[member] = RegHouse._item_direction_facing[member+1];
				RegHouse._item_direction_facing[member+1] = _int;
				
				var _int = RegHouse._map_offset_x[member];
				RegHouse._map_offset_x[member] = RegHouse._map_offset_x[member+1];
				RegHouse._map_offset_x[member+1] = _int;
				
				var _int = RegHouse._map_offset_y[member];
				RegHouse._map_offset_y[member] = RegHouse._map_offset_y[member+1];
				RegHouse._map_offset_y[member+1] = _int;
				
				var _int = RegHouse._item_is_hidden[member];
				RegHouse._item_is_hidden[member] = RegHouse._item_is_hidden[member+1];
				RegHouse._item_is_hidden[member+1] = _int;
				
				var _int = RegHouse._item_behind_walls[member];
				RegHouse._item_behind_walls[member] = RegHouse._item_behind_walls[member+1];
				RegHouse._item_behind_walls[member+1] = _int;
								
				//__house.__house_menu_furniture.toggle_item_front_or_back_walls();
				//__house.__house_menu_furniture.toggle_item_front_or_back_walls();
								
				var _str = RegHouse._coins[member];
				RegHouse._coins[member] = RegHouse._coins[member+1];
				RegHouse._coins[member+1] = _str;
				
				HouseFurniturePut._value_from_item_pressed += 1;
				//HouseFurniturePut._value_from_item_order = RegHouse._item_order[member];
				 
				HouseFurniturePut.textAndspriteRefreshPanel();
				//------------------------
				
				member_move(_members);
				
				break;
			}
		}
		
	}
	
	/******************************
	 * changes the order that the images are displayed on the map.		
	 * 
	 * @param	_new_order		new z-order
	 * @param	_old_order		old z-order
	 */
	public function members_change_order(_new_order:Int, _old_order:Int):Void
	{
		for (i in 0...RegHouse._totalPurchased + 1)
		{
			if (HouseFurnitureItemsFront._group_sprite[i].ID == _new_order)
			{
				HouseFurnitureItemsFront._group_sprite[i].ID = _old_order;
				HouseFurnitureItemsBack._group_sprite[i].ID = _old_order;
					
				break;
			}
		}	
		
	}
	
	override public function destroy()
	{
		if (_bg_behind_item != null)
		{
			_bg_behind_item.destroy();
			_bg_behind_item = null;
		}
			
		if (_house_drag_icon != null)
		{
			_house_drag_icon.destroy();
			_house_drag_icon = null;
		}
		
		if (_house_rotate_icon != null)
		{
			_house_rotate_icon.destroy();
			_house_rotate_icon = null;
		}
		
		super.destroy();
		

	}

	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		if (RegHouse._house_main_menu_button_number != 1)
		{
			return;
		}
				
		super.update(elapsed);
	}
}