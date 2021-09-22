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
 * all furniture items to place into the room that are behind a wall.
 * @author kboardgames.com
 */
class HouseFurnitureItemsBack extends FlxGroup
{
	/******************************
	 * value starts at 0. access members here.
	 */
	public static var _group_sprite:Array<FlxSprite> = [];
		
	/******************************
	 * the class HouseMenuFurniture.hx can use this var to toggle the visibility of a house item. _group_sprite cannot be used because it has no member property
	 */
	public static var _group:FlxSpriteGroup;	
	
	/******************************
	 * used to push members.
	 */
	public var _sprite:FlxSprite; 
	
	/******************************
	 * used to assign an id to the _group_sprite which are the members of the furniture items.
	 */
	public static var _id:Int = 1;
		
	override public function new():Void
	{
		super();
		
		_id = 1;
		
		_group = new FlxSpriteGroup();
		//add(_group);
		
		options();
	}	
	
	private function options():Void
	{
		// -1 because item 0.png refers to the first item. a value of 1 here is really two items.
		RegHouse._totalPurchased = RegHouse._sprite_number.length-1;
				
		_group_sprite.splice(0, _group_sprite.length);
		_group.members.splice(0, _group.members.length);
		
		var ii = 0;
		
		while (ii < RegHouse._totalPurchased + 1)
		{
			for (i in 0... RegHouse._totalPurchased+1)
			{
				if (RegHouse._item_order[i] == ii)
				{
					// load the furniture images.
					_sprite = new FlxSprite();
					_sprite.loadGraphic("assets/images/house/furniture/put/" + (RegHouse._sprite_number[ii]) + ".png", true, RegHouse._item_animation_width[RegHouse._sprite_number[ii]], RegHouse._item_animation_height[RegHouse._sprite_number[ii]]);
					
					add(_sprite);
										
					// add this member to _group_sprite.			
					_group_sprite.push(_sprite);
								
					// position this image on scene.
					_group_sprite[ii].setPosition(RegHouse._items_x[ii], RegHouse._items_y[ii]);
					
					_group_sprite[ii].animation.add("0", [0], 30, false);
					_group_sprite[ii].animation.add("1", [1], 30, false);
					_group_sprite[ii].animation.add("2", [2], 30, false);
					_group_sprite[ii].animation.add("3", [3], 30, false);
					_group_sprite[ii].animation.play(Std.string(RegHouse._item_direction_facing[ii]));
					_id = ii+1;
					// give this member an id. this id is used to move members in z-order.
					_group_sprite[ii].ID = _id;
													
					if (RegHouse._item_is_hidden[ii] == 1
					||  RegHouse._item_behind_walls[ii] == 1)
						_group_sprite[ii].visible = false;
					
					_group.add(_group_sprite[ii]);
					
					ii += 1;
				}
			}
		}
	}
	
	
	public function spriteBoughtAddToScene():Void
	{
		_sprite = new FlxSprite();
		_sprite.loadGraphic("assets/images/house/furniture/put/" + HouseFurnitureGet._idCurrentItemPurchased + ".png", true, RegHouse._item_animation_width[HouseFurnitureGet._idCurrentItemPurchased], RegHouse._item_animation_height[HouseFurnitureGet._idCurrentItemPurchased]);
		
		add(_sprite);
		
		// add this member to _group_sprite.			
		_group_sprite.push(_sprite);
					
		// position this image on scene.
		_group_sprite[RegHouse._totalPurchased].setPosition(RegHouse._items_x[RegHouse._totalPurchased], RegHouse._items_y[RegHouse._totalPurchased]);
		
		// give this member an id. this id is used to move members in z-order.
		_id = RegHouse._totalPurchased + 1;
		
		_group_sprite[RegHouse._totalPurchased].ID = _id;
		_group_sprite[RegHouse._totalPurchased].updateHitbox();
		
		_group_sprite[RegHouse._totalPurchased].animation.add("0", [0], 30, false);
		_group_sprite[RegHouse._totalPurchased].animation.add("1", [1], 30, false);
		_group_sprite[RegHouse._totalPurchased].animation.add("2", [2], 30, false);
		_group_sprite[RegHouse._totalPurchased].animation.add("3", [3], 30, false);
		_group_sprite[RegHouse._totalPurchased].animation.play("0");
		
		_group_sprite[RegHouse._totalPurchased].visible = false; // item that is behind wall is hidden when bought.
		
		_group.add(_group_sprite[RegHouse._totalPurchased]);
		
		if (RegHouse._namesPurchased.length == 0)
		{
			RegHouse._namesPurchased[0] = "No item selected.";
			RegHouse._namesPurchased.push("");
		}
		
		// RegHouse._totalPurchased starts at a value of -1. when an furniture item is bought the value is 0 for the first item. since the RegHouse._namesPurchased array starts at 0 and that array is used for the no text selected item, we need a +2 here.
		//RegHouse._namesPurchased[RegHouse._totalPurchased+2] = RegHouse._namesCanPurchase[HouseFurnitureGet._idCurrentItemPurchased];
		
	}
	
	override public function destroy()
	{
		super.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		
		if (RegTriggers._furnitureItemSpriteAddToMapBack == true)
		{
			RegTriggers._furnitureItemSpriteAddToMapBack = false;
			spriteBoughtAddToScene();
		}
		
		super.update(elapsed);
	}
	
}