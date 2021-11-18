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
 * Display a grid of floor items on the map. a floor tile can be positioned on the map.
 * @author kboardgames.com
 */
class HouseMapFloor extends FlxSprite 
{	
	/******************************
	 * When this class instance is first created this var will hold the X value of the x value from the constructor. 
	 */
	private var _tileX:Int = 0;
	
	/******************************
	 * When this class instance is first created this var will hold the Y value of the y value from the constructor. 
	 */
	private var _tileY:Int = 0;
	
	private var __house:House;
	
	
	/******************************
	 * @param	x				image coordinate
	 * @param	y				image coordinate
	 * @param	id				this var refers to a unique piece on the grid. each piece on the grid has a different number. an ID can be called anything. it just refers to an instance of a class. it does not share data from other instances, it may not have the same values but holds the same variables. this var is used to move pieces from one unit to another. 
	 */
	public function new (x:Float, y:Float, xx:Int, yy:Int, house:House, id:Int)
	{
		super(x, y);		

		__house = house;
		ID = id;
		
		_tileX = Std.int(xx);
		_tileY = Std.int(yy);
		
		loadGraphic("modules/house/assets/images/house/foundation/put/floors/tiles.png", true, 208, 147);
		animation.add("0", [0], 30, false); // different tiles in this images.
		animation.add("1", [1], 30, false);
		animation.add("2", [2], 30, false);
		animation.add("3", [3], 30, false);
		
		animation.play(Std.string(RegHouse._floor[_tileX][_tileY]));
		
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
		
		// adding a floor tile.
		if (ActionInput.pressed() == true
		&& __house.__house_foundation_put._buttonItemRemoveTile.label.text == "Remove Tile On"
		&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x > FlxG.width - 373 - 208 - HouseScrollMap._map_offset_x 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y > 55 - HouseScrollMap._map_offset_y 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y < FlxG.height - 55 + HouseScrollMap._map_offset_y )
		{
			// on the map, at the map hover, if the mouse was clicked then change this class image at the instance of id.
			if (__house.__house_foundation_put._item_Selected_id > -1 
			&&  __house.__house_foundation_put._item_Selected_id < 3
			&&  __house._hover_p_value == ID)
			{
				animation.play(Std.string(__house.__house_foundation_put._item_Selected_id + 1));
				RegHouse._floor[_tileX][_tileY] = __house.__house_foundation_put._item_Selected_id + 1;			
				
			}
		}
		
		// removing a floor tile.
		if (ActionInput.pressed() == true
		&& __house.__house_foundation_put._buttonItemRemoveTile.label.text == "Remove Tile Off"
		&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x > FlxG.width - 373 - 208 - HouseScrollMap._map_offset_x 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y > 55 - HouseScrollMap._map_offset_y 
		&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y < FlxG.height - 55 + HouseScrollMap._map_offset_y )
		{
			// on the map, at the map hover, if the mouse was clicked then change this class image at the instance of id.
			if (__house.__house_foundation_put._item_Selected_id > -1 
			&&  __house.__house_foundation_put._item_Selected_id < 3
			&&  __house._hover_p_value == ID)
			{
				animation.play("0");
				RegHouse._floor[_tileX][_tileY] = 0;
			}
		}
		
		super.update(elapsed);
	}
	
}