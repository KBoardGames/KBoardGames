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
 * These are used in house classes.
 * @author kboardgames.com
 */
class RegHouse
{
	
	/******************************
	 * names of the furniture.
	 */
	public static var _namesCanPurchase:Array<String> = []; 
	
	
	/******************************
	 * width of frame
	 */
	public static var _item_animation_width:Array<Int> = []; 
	
	/******************************
	 * height of frame.
	 */
	public static var _item_animation_height:Array<Int> = []; 
		
	/******************************
	 * this value refers to the button that is toggled.
	 * 0:furniture get, 1:furniture put, 2:foundation put.
	 */
	public static var _house_main_menu_button_number:Int = 0;	
			
	/******************************
	 * this can go beyond the 200 array limit of other vars in this class. when an item is bought, this array will add an element to the beginning of the array, the "No item selected." text.
	 */
	public static var _namesPurchased:Array<String> = [];
	
	/******************************
	 * total furniture items available to purchase.
	 */
	public static var _totalCanPurchase = 38;
	
	/******************************
	 * total furniture items player has. a value of 0 = 1 item.
	 */
	public static var _totalPurchased = -1;
		
	/******************************
	 * how much a furniture item costs.
	 */
	public static var _coins:Array<Int> = []; 
		
	public static var _coinValueDividedBy:Int = 50;
	
	/******************************
	 * refers to a sprite that was bought to display at house. eg, 1.png. starts at 0.
	 */
	public static var _sprite_number:Array<Int> = [];
	
	/******************************
	 * all items x position that is separated by a comma.
	 */
	public static var _items_x:Array<Float> = [for (y in 0...200) 923];
	
	/******************************
	 * all items y position that is separated by a comma.
	 */
	public static var _items_y:Array<Float> = [for (y in 0...200) 375];
	
	/******************************
	 * map x coordinates on scene at the time the item was bought or mouse dragged then mouse released.
	 */
	public static var _map_x:Array<Float> = [for (y in 0...200) 693];
	
	/******************************
	 * map y coordinates on scene at the time the item was bought or mouse dragged then mouse released.
	 */
	public static var _map_y:Array<Float> = [for (y in 0...200) 378];
	
	/******************************
	 * a list of 1 and 0's separated by a comma. the first value in this list refers to item 1. if that value is 1 then that item was purchased. 0:false, 1:true.
	*/
	public static var _is_item_purchased:Array<Int> = [for (y in 0...200) 0];
	
	/******************************
	 * stores the direction that the furniture item is facing.
	 * values of 0=SE, 1:SW, 2:NE, 3:NW
	 */
	public static var _item_direction_facing:Array<Int> = [for (y in 0...200) 0];
		
	/******************************
	 * when the map is moved up, down, left or right, this value increases in size by those pixels. this var is used at House update() so that the map hover can be displayed when outside of its default map boundaries. it is also added or subtracted to the mouse coordinates at other classes so that the map or panel items can correctly be detected by the mouse. for example, the mouse.x cannot be at a value of 2000 when the stage has a width of 1400 and the map changes in width, but it can be there when this offset is added to mouse.x.
	 */
	public static var _map_offset_x:Array<Float> = [for (y in 0...200) 0];
 	public static var _map_offset_y:Array<Float> = [for (y in 0...200) 0];
	
	/******************************
	 * is this item hidden? starts at element zero.
	 */
	public static var _item_is_hidden:Array<Int> = [for (y in 0...200) 0];
	
	/******************************
	 * the order of the furniture items displayed.
	 */
	public static var _item_order:Array<Int> = [for (y in 0...200) y];
	
	/******************************
	 * when value is true the furniture item will be displayed on the map behind a wall. This string contains true and false values up to 200 furniture items separated by a comma.
	 */
	public static var _item_behind_walls:Array<Int> = [for (y in 0...200) 0];
	
	/******************************
	 * this holds all floor tiles on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 */
	public static var _floor:Array<Array<Int>> =
	[for (x in 0...11) [for (y in 0...22) 1]];
	
	/******************************
	 * this holds all wall tiles in the left position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 */
	public static var _wall_left:Array<Array<Int>> =
	[for (x in 0...11) [for (y in 0...22) 0]];
	
	/******************************
	 * this holds all wall tiles in the upward position on the map. This var is read from left to right but that data is placed on the map starting from the top left of map and then moving right and similar to reading words in a book.
	 * this var is shown under a left tile. so the wall is up but behind a left wall.
	 */
	public static var _wall_up_behind:Array<Array<Int>> =
	[for (x in 0...11) [for (y in 0...22) 0]];
	public static var _wall_up_in_front:Array<Array<Int>> =
	[for (x in 0...11) [for (y in 0...22) 0]];
	
	/******************************
	 * this var holds the visibility state of a floor at a unit.
	 * visibility value of 0:false, 1:true.
	 * y:y unit coordinates. so a value of 2 is from the top of the map move in the direction of down until the third unit is reached. the third unit because the first unit has a value of 0.
	 * x:x unit coordinates.
	 */
	public static var _floor_is_hidden:Array<Array<Int>> = 
	[for (x in 0...11) [for (y in 0...22) 0]];	
	
	/******************************
	 * each house map unit has two left walls but only one is visible. the reason for two is because one is in front of a up wall while the other at the same unit is behind.
	 * this var holds the visibility state of a left wall at a unit.
	 * a value of 0 is the first set of left walls that were drawn on the map while 1:the second set of left walls.
	 * y:y unit coordinates. so a value of 2 is from the top of the map move in the direction of down until the third unit is reached. the third unit because the first unit has a value of 0.
	 * x:x unit coordinates.
	 */
	public static var _wall_left_is_hidden:Array<Array<Int>> = 
	[for (x in 0...11) [for (y in 0...22) 1]];
	
	/******************************
	 * each house map unit has two up walls but only one is visible. the reason for two is because one is in front of a left wall while the other at the same unit is behind.
	 * this var holds the visibility state of a up wall at a unit.
	 * a value of 0 is the first set of up walls that were drawn on the map while 1:the second set of up walls.
	 * y:y unit coordinates. so a value of 2 is from the top of the map move in the direction of down until the third unit is reached. the third unit because the first unit has a value of 0.
	 * x:x unit coordinates.
	 */
	public static var _wall_up_is_hidden:Array<Array<Array<Int>>> = 
	[for (p in 0...2) [for (x in 0...11) [for (y in 0...22) 1]]];
	
	public static function resetHouseAtLobby():Void
	{
		//------------------------
		// the first value at math is the estimated current price divided by _coinValueDividedBy to get the value of coins needed to made a purchase for that item.
		_namesCanPurchase[0] = "Bathroom Cabinet Drawer";
		_coins[0] = Math.round(600 / _coinValueDividedBy);
		
		_namesCanPurchase[1] = "Bathtub";
		_coins[1] = Math.round(2000 / _coinValueDividedBy);
		
		_namesCanPurchase[2] = "Bed Double";
		_coins[2] = Math.round(1700 / _coinValueDividedBy);
		
		_namesCanPurchase[3] = "Bed Single";
		_coins[3] = Math.round(1300 / _coinValueDividedBy);
		
		_namesCanPurchase[4] = "Bench";
		_coins[4] = Math.round(400 / _coinValueDividedBy);
		
		_namesCanPurchase[5] = "Bookcase Open";
		_coins[5] = Math.round(350 / _coinValueDividedBy);
		
		_namesCanPurchase[6] = "Chair Desk";
		_coins[6] = Math.round(125 / _coinValueDividedBy);
		
		_namesCanPurchase[7] = "Computer Screen";
		_coins[7] = Math.round(175 / _coinValueDividedBy);
		
		_namesCanPurchase[8] = "Desk";
		_coins[8] = Math.round(350 / _coinValueDividedBy);
		
		_namesCanPurchase[9] = "Kitchen Cabinet Upper Corner";
		_coins[9] = Math.round(550 / _coinValueDividedBy);
		
		_namesCanPurchase[10] = "Kitchen Cabinet Upper Double";
		_coins[10] = Math.round(700 / _coinValueDividedBy);
		
		_namesCanPurchase[11] = "Kitchen Coffee Machine";
		_coins[11] = Math.round(75 / _coinValueDividedBy);
		
		_namesCanPurchase[12] = "Kitchen Stove";
		_coins[12] = Math.round(1300 / _coinValueDividedBy);
		
		_namesCanPurchase[13] = "Lounge Chair";
		_coins[13] = Math.round(350 / _coinValueDividedBy);
		
		_namesCanPurchase[14] = "Potted Plant";
		_coins[14] = Math.round(50 / _coinValueDividedBy);
		
		_namesCanPurchase[15] = "Speaker";
		_coins[15] = Math.round(400 / _coinValueDividedBy);
		
		_namesCanPurchase[16] = "Table Coffee";
		_coins[16] = Math.round(150 / _coinValueDividedBy);
		
		_namesCanPurchase[17] = "Television Modern";
		_coins[17] = Math.round(800 / _coinValueDividedBy);
		
		_namesCanPurchase[18] = "Television Vintage";
		_coins[18] = Math.round(350 / _coinValueDividedBy);		
		
		_namesCanPurchase[19] = "Bathroom Cabinet";
		_coins[19] = Math.round(700 / _coinValueDividedBy);
		
		_namesCanPurchase[20] = "Bathroom Mirror";
		_coins[20] = Math.round(130 / _coinValueDividedBy);
		
		_namesCanPurchase[21] = "Bathroom Sink";
		_coins[21] = Math.round(650 / _coinValueDividedBy);
		
		_namesCanPurchase[22] = "Bear";
		_coins[22] = Math.round(220 / _coinValueDividedBy);
		
		_namesCanPurchase[23] = "Washer Dryer Stacked";
		_coins[23] = Math.round(1900 / _coinValueDividedBy);
		
		_namesCanPurchase[24] = "Bathroom Sink Square";
		_coins[24] = Math.round(650 / _coinValueDividedBy);
		
		_namesCanPurchase[25] = "Bed Bunk";
		_coins[25] = Math.round(1850 / _coinValueDividedBy);
		
		_namesCanPurchase[26] = "Bench Cushion Low";
		_coins[26] = Math.round(19 / _coinValueDividedBy);
		
		_namesCanPurchase[27] = "Bookcase Open Low";
		_coins[27] = Math.round(23 / _coinValueDividedBy);
		
		_namesCanPurchase[28] = "Cardboard Box Open";
		_coins[28] = Math.round(3 / _coinValueDividedBy);
		
		_namesCanPurchase[29] = "Chair";
		_coins[29] = Math.round(40 / _coinValueDividedBy);
		
		_namesCanPurchase[30] = "Chair Modern Cushion";
		_coins[30] = Math.round(45 / _coinValueDividedBy);
		
		_namesCanPurchase[31] = "Chair Modern Frame Cushion";
		_coins[31] = Math.round(45 / _coinValueDividedBy);
		
		_namesCanPurchase[32] = "Kitchen Fridge";
		_coins[32] = Math.round(2700 / _coinValueDividedBy);
		
		_namesCanPurchase[33] = "Kitchen Sink";
		_coins[33] = Math.round(1000 / _coinValueDividedBy);
		
		_namesCanPurchase[34] = "Kitchen Stove Electric";
		_coins[34] = Math.round(2300 / _coinValueDividedBy);
		
		_namesCanPurchase[35] = "LampRound Table";
		_coins[35] = Math.round(45 / _coinValueDividedBy);
		
		_namesCanPurchase[36] = "Toaster";
		_coins[36] = Math.round(20 / _coinValueDividedBy);
		
		_namesCanPurchase[37] = "Toilet";
		_coins[37] = Math.round(1200 / _coinValueDividedBy);
		
		_namesCanPurchase[38] = "Toilet Square";
		_coins[38] = Math.round(1300 / _coinValueDividedBy);
		
		
		// -------------------------
		
		_item_animation_width[0] = 76;
		_item_animation_width[1] = 178;
		_item_animation_width[2] = 216;
		_item_animation_width[3] = 176;
		_item_animation_width[4] = 62;
		_item_animation_width[5] = 67;
		_item_animation_width[6] = 60;
		_item_animation_width[7] = 47;
		_item_animation_width[8] = 117;
		_item_animation_width[9] = 44;
		_item_animation_width[10] = 67;
		_item_animation_width[11] = 35;
		_item_animation_width[12] = 92;
		_item_animation_width[13] = 92;
		_item_animation_width[14] = 28;
		_item_animation_width[15] = 31;
		_item_animation_width[16] = 110;
		_item_animation_width[17] = 74;
		_item_animation_width[18] = 63;		
		_item_animation_width[19] = 37;
		_item_animation_width[20] = 46;
		_item_animation_width[21] = 58;
		_item_animation_width[22] = 51;
		_item_animation_width[23] = 77;	
		_item_animation_width[24] = 76;
		_item_animation_width[25] = 173;
		_item_animation_width[26] = 67;
		_item_animation_width[27] = 67;
		_item_animation_width[28] = 60;
		_item_animation_width[29] = 42;
		_item_animation_width[30] = 42;
		_item_animation_width[31] = 42;
		_item_animation_width[32] = 72;
		_item_animation_width[33] = 92;
		_item_animation_width[34] = 92;
		_item_animation_width[35] = 25;
		_item_animation_width[36] = 29;
		_item_animation_width[37] = 74;
		_item_animation_width[38] = 66;
				
		_item_animation_height[0] = 96;
		_item_animation_height[1] = 163;
		_item_animation_height[2] = 174;
		_item_animation_height[3] = 146;
		_item_animation_height[4] = 94;
		_item_animation_height[5] = 140;
		_item_animation_height[6] = 97;
		_item_animation_height[7] = 55;
		_item_animation_height[8] = 122;
		_item_animation_height[9] = 73;
		_item_animation_height[10] = 88;
		_item_animation_height[11] = 38;
		_item_animation_height[12] = 110;
		_item_animation_height[13] = 106;
		_item_animation_height[14] = 85;
		_item_animation_height[15] = 89;
		_item_animation_height[16] = 102;
		_item_animation_height[17] = 93;
		_item_animation_height[18] = 74;		
		_item_animation_height[19] = 68;
		_item_animation_height[20] = 74;
		_item_animation_height[21] = 87;
		_item_animation_height[22] = 54;
		_item_animation_height[23] = 151;		
		_item_animation_height[24] = 96;
		_item_animation_height[25] = 211;
		_item_animation_height[26] = 67;
		_item_animation_height[27] = 90;
		_item_animation_height[28] = 67;
		_item_animation_height[29] = 79;
		_item_animation_height[30] = 78;
		_item_animation_height[31] = 75;
		_item_animation_height[32] = 146;
		_item_animation_height[33] = 110;
		_item_animation_height[34] = 110;
		_item_animation_height[35] = 49;
		_item_animation_height[36] = 34;
		_item_animation_height[37] = 98;
		_item_animation_height[38] = 93;
		
		Reg._at_house = false;
		_house_main_menu_button_number = 0;		
		
		_namesPurchased.splice(0, _namesPurchased.length);
		_namesPurchased.push("No item selected.");
		
		//--------------------------------------
		_totalCanPurchase = 38;
		_totalPurchased = -1;
		_coinValueDividedBy = 50;
		
		_sprite_number.splice(0, _sprite_number.length);
		
		for (i in 0...200)
		{
			_items_x[i] = 923;
			_items_y[i] = 375;
			_map_x[i] = 693;
			_map_y[i] = 378;
			
			_is_item_purchased[i] = 0;
			_item_direction_facing[i] = 0;
			_map_offset_x[i] = 0;
			_map_offset_y[i] = 0;
			_item_is_hidden[i] = 0;
			_item_order[i] = i;
			_item_behind_walls[i] = 0;
		}
		
		for (y in 0...22)
		{
			for (x in 0...11)
			{
				_floor[x][y] = 1;
				_wall_left[x][y] = 0;
				_wall_up_behind[x][y] = 0;
				_wall_up_in_front[x][y] = 0;
				_floor_is_hidden[x][y] = 0;	
				_wall_left_is_hidden[x][y] =1;
				_wall_up_is_hidden[0][x][y] = 1;
				_wall_up_is_hidden[1][x][y] = 1;
			}
		}	
					
	}	
	
}//