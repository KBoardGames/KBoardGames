/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package modules.house;

/**
 * Display a grid of left wall items on the map. a wall tile can be positioned on the map.
 * @author kboardgames.com
 */
class HouseMapWallLeft extends FlxSprite 
{
	/******************************
	 * When this class instance is first created this var will hold the X value of the x value from the constructor. 
	 */
	private var _tileX:Int = 0;
	
	/******************************   * When this class instance is first created this var will hold the Y value of the y value from the constructor. 
	 */
	private var _tileY:Int = 0;
	
	/******************************
	 * this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	private var _id:Int = 0; 
	
	private var _ticks:Float = 0;
	private var __house:House;
		
	private var _hover_tileX:Int = 0;
	private var _hover_tileY:Int = 0;
	
	/******************************
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	id				an instance of this class. each time of a "new" an id increments in value.
	 * @param	tileX		unit coordinate (0-10) // total 11 units.
	 * @param	tileY		unit coordinate (0-10)
	 */
	public function new (x:Float, y:Float, house:House, _id:Int, xID:Int, yID:Int)
	{
		super(x, y);		

		// _stack_order is not needed for a left wall.
		
		__house = house;
		ID = _id;
		_tileX = xID;
		_tileY = yID;
		
		// when entering the house, all walls are first created using animation 0 to display it as an empty frame unless there is data that was saved that needs to be loaded. tp display a wall just change the animation frame.
		loadGraphic("modules/house/assets/images/house/foundation/put/walls/"+RegHouse._wall_left[_tileX][_tileY]+".png", true, 109, 212);
				
		animation.add("0", [0], 30, false);
		animation.play("0");
		animation.add("1", [1], 30, false);
		animation.play("1");
			
		
		if (RegHouse._wall_left_is_hidden[_tileX][_tileY] == 1)
		{
			visible = false;
		}
		
		else 
		{			
			visible = true;
		}
			
	}
	
	override public function destroy()
	{
		super.destroy();
	}

	override public function update(elapsed:Float)
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		if (RegHouse._house_main_menu_button_number < 2) return;
		
		// stop the drawing of a floor tile, wall or door when able to scroll map.
		if (HouseScrollMap._sprite_ticks_up.visible == true
		||  HouseScrollMap._sprite_ticks_left.visible == true
		||  HouseScrollMap._sprite_ticks_down.visible == true
		||  HouseScrollMap._sprite_ticks_right.visible == true
		) return;
		
		// adding a left wall tile from frame 1 when mouse is clicked.
		if (ActionInput.pressed() == true
		&& __house.__house_foundation_put._buttonItemPosition1.has_toggle == true
		&& __house.__house_foundation_put._buttonItemRemoveTile.label.text == "Remove Tile On"
		&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x > FlxG.width - 373 - 208 - HouseScrollMap._map_offset_x 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y > 55 - HouseScrollMap._map_offset_y 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y < FlxG.height - 55 + HouseScrollMap._map_offset_y )
		{
			// on the map, at the map hover, if the mouse was clicked then change this class image at the instance of id.
			if (__house.__house_foundation_put._item_Selected_id > 2 
			&&  __house._hover_p_value == ID)
			{
				loadGraphic("modules/house/assets/images/house/foundation/put/walls/"+ (__house.__house_foundation_put._item_Selected_id-__house.__house_foundation_put._floorTotal) +".png", true, 109, 212);
				animation.add("1", [1], 30, false);
				animation.play("1");
				
				RegHouse._wall_left[_tileX][_tileY] = __house.__house_foundation_put._item_Selected_id - __house.__house_foundation_put._floorTotal;
				RegHouse._wall_left_is_hidden[_tileX][_tileY] = 0;
				
				visible = true;
				
				_hover_tileX = __house._hover_x;
				_hover_tileY = __house._hover_y;
				
			}
		}
		
		
		// removing a floor tile.
		if (ActionInput.pressed() == true)
		{			
			if (__house.__house_foundation_put._buttonItemPosition1.has_toggle == true
			&&  __house.__house_foundation_put._buttonItemRemoveTile.label.text == "Remove Tile Off"
			&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x > FlxG.width - 373 - 208 - HouseScrollMap._map_offset_x 
			&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y > 55 - HouseScrollMap._map_offset_y 
			&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y < FlxG.height - 55 + HouseScrollMap._map_offset_y )
			{
				// on the map, at the map hover, if the mouse was clicked then change this class image at the instance of id.
				if (__house.__house_foundation_put._item_Selected_id > 2 
				&&  __house._hover_p_value == ID)
				{
					loadGraphic("modules/house/assets/images/house/foundation/put/walls/" + (__house.__house_foundation_put._item_Selected_id - __house.__house_foundation_put._floorTotal) +".png", true, 109, 212);
					
					RegHouse._wall_left[_tileX][_tileY] = 0;
					RegHouse._wall_left_is_hidden[_tileX][_tileY] = 1;
					
					visible = false;
					
					_hover_tileX = __house._hover_x;
					_hover_tileY = __house._hover_y;
					
					animation.add("0", [2], 30, false);
					animation.play("0");
				
					RegHouse._wall_left[_hover_tileX][_hover_tileY] = 0;
					RegHouse._wall_left_is_hidden[_hover_tileX][_hover_tileY] = 0;
						
				}
			}
		}
		
		super.update(elapsed);
	}
	
}