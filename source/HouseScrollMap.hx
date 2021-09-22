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
 * scrolls the map when mouse is hovered near the edge of the map.
 * @author kboardgames.com
 */
class HouseScrollMap extends FlxState
{
	private var __house:House;
	
	/******************************
	 * used to move map if mouse is within a region near edge of screen.
	 */
	private static var _ticks_up:Float = 0;
	private static var _ticks_down:Float = 0;
	private static var _ticks_left:Float = 0;
	private static var _ticks_right:Float = 0;
	
	/******************************
	 * after the map is moved to the left the first time, this var is used after the first move to move the map 2 times faster until the mouse exits the region or when the end of the map is reached.
	 * this value is minus from the _ticks_up var when the _ticks_up value reaches the value where the function is called to move the map. this value is set at the mapScrollUp function so that the next move this value is minus from the normal tick of _ticks_up.
	 */
	private static var _ticks_up_fast:Float = 0;
	private static var _ticks_down_fast:Float = 0;
	private static var _ticks_left_fast:Float = 0;
	private static var _ticks_right_fast:Float = 0;
		
	/******************************
	 * this is the sprite highlight used to show that the mouse is within a region where the map will be moved if the mouse stays at that place after so many ticks had been made.
	 */
	public static var _sprite_ticks_up:FlxSprite;
	public static var _sprite_ticks_down:FlxSprite;
	public static var _sprite_ticks_left:FlxSprite;
	public static var _sprite_ticks_right:FlxSprite;
	
	/******************************
	 * when the map is moved up, down, left or right, this value increases in size by those pixels. this var is used at House update() so that the map hover can be displayed when outside of its default map boundaries. it is also added or subtracted to the mouse coordinates at other classes so that the map or panel items can correctly be detected by the mouse. for example, the mouse.x cannot be at a value of 2000 when the stage has a width of 1400 and the map changes in width, but it can be there when this offset is added to mouse.x.
	 */
	public static var _map_offset_x:Float = 0;
 	public static var _map_offset_y:Float = 0;
	
	override public function new(house:House):Void
	{
		super();
		
		__house = house;
		
		FlxG.worldDivisions = 1;
		FlxG.worldBounds.set(0);
		
			
		// this is the sprite highlight used to show that the mouse is within a region where the map will be moved if the mouse stays at that place after so many ticks had been made.
		// this sprite runs from left to right.
		_sprite_ticks_up = new FlxSprite(375, 0);
		_sprite_ticks_up.makeGraphic(FlxG.width, 85, 0x55000000);
		_sprite_ticks_up.scrollFactor.set(0, 0);
		_sprite_ticks_up.visible = false;
		add(_sprite_ticks_up);
		
		// this sprite runs from left to right.
		_sprite_ticks_down = new FlxSprite(375, FlxG.height-50-85);
		_sprite_ticks_down.makeGraphic(FlxG.width, 85, 0x55000000);
		_sprite_ticks_down.scrollFactor.set(0, 0);
		_sprite_ticks_down.visible = false;
		add(_sprite_ticks_down);
		
		// this sprite runs from up to down.
		_sprite_ticks_left = new FlxSprite(375, 0);
		_sprite_ticks_left.makeGraphic(85, FlxG.height-45, 0x55000000);
		_sprite_ticks_left.scrollFactor.set(0, 0);
		_sprite_ticks_left.visible = false;
		add(_sprite_ticks_left);
		
		// this sprite runs from up to down.
		_sprite_ticks_right = new FlxSprite(FlxG.width - 85, 0);
		_sprite_ticks_right.makeGraphic(85, FlxG.height-45, 0x55000000);
		_sprite_ticks_right.scrollFactor.set(0, 0);
		_sprite_ticks_right.visible = false;
		add(_sprite_ticks_right);
	}
	
	// when returning the house, these vars need to be cleared so that the map works again.
	public function options():Void
	{
		_ticks_up = 0;
		_ticks_down = 0;
		_ticks_left = 0;
		_ticks_right = 0;
	
		_ticks_up_fast = 0;
		_ticks_down_fast = 0;
		_ticks_left_fast = 0;
		_ticks_right_fast = 0;
		
		_map_offset_x = 0;
		_map_offset_y = 0;
		
		__house._tracker_start_x = 692.5;
		__house._tracker_start_y = 377.5;
		__house._trackerDefaultPosition = 0;
		
		__house._trackerDefaultPosition = __house._tracker.x;		
		FlxG.camera.follow(__house._tracker, FlxCameraFollowStyle.LOCKON);

	}
	
	private function mapScrollUp():Void
	{
		_ticks_up = 0;
				
		if (__house._tracker.y > 377.5)
		{
			__house._tracker.y -= 72;
			_map_offset_y -= 72;
			
			_ticks_up_fast = 11;
		}
	}
	
	private function mapScrollDown():Void
	{
		_ticks_down = 0;
		
		if (__house._tracker.y < 72*(__house._floorTileAmount - 6) - __house._trackerDefaultPosition + 72)
		{
			__house._tracker.y += 72;
			_map_offset_y += 72;
			
			_ticks_down_fast = 11;
		}
	}
	
	private function mapScrollLeft():Void
	{
		_ticks_left = 0;
						
		if (__house._tracker.x > 692.5)
		{
			__house._tracker.x -= 102;
			_map_offset_x -= 102;
			
			_ticks_left_fast = 11;
		}
	}
	
	private function mapScrollRight():Void
	{
		_ticks_right = 0;
				
		if (__house._tracker.x < 102*(__house._floorTileAmount - 5) - __house._trackerDefaultPosition + 102)
		{
			__house._tracker.x += 102;
			_map_offset_x += 102;
			
			_ticks_right_fast = 11;
		}
	}
	
	override public function destroy()
	{		
		if (_sprite_ticks_up != null)
		{
			_sprite_ticks_up.destroy();
			_sprite_ticks_up = null;
		}
		
		if (_sprite_ticks_down != null)
		{
			_sprite_ticks_down.destroy();
			_sprite_ticks_down = null;
		}
		
		if (_sprite_ticks_left != null)
		{
			_sprite_ticks_left.destroy();
			_sprite_ticks_left = null;
		}
		
		if (_sprite_ticks_right != null)
		{
			_sprite_ticks_right.destroy();
			_sprite_ticks_right = null;
		}
		
			
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;

		// move map if mouse is within a region near edge of screen.
		// is move is near the upper region of map.
		// UP
		if (__house._tracker.y > 377.5
		&&  ActionInput.coordinateY() - _map_offset_y > 0
		&&  ActionInput.coordinateY() - _map_offset_y < 85
		&&  ActionInput.coordinateX() - _map_offset_x > 373
		&&  ActionInput.coordinateX() - _map_offset_x <= FlxG.width)
		{
			if (__house.__house_menu_main._buttonToFurnitureGetMenu.toggled == true
			||  __house.__house_menu_main._buttonToFurniturePutMenu.toggled == true
			&&  ActionInput.overlaps(__house.__house_map_furniture._house_drag_icon)
			||  __house.__house_menu_main._buttonToFoundationPutMenu.toggled == true
			)
			{
				_ticks_up = RegFunctions.incrementTicks(_ticks_up, 60 / Reg._framerate);
				_sprite_ticks_up.visible = true;
			}
		}
		else
		{
			_ticks_up = 0;
			_ticks_up_fast = 0;
			_sprite_ticks_up.visible = false;
		}
		
		// DOWN
		if (__house._tracker.y < 72 * (__house._floorTileAmount - 6) - __house._trackerDefaultPosition + 72
		&&  ActionInput.coordinateY() - _map_offset_y > FlxG.height - 50 - 85
		&&  ActionInput.coordinateY() - _map_offset_y <= FlxG.height - 50
		&&  ActionInput.coordinateX() - _map_offset_x > 373
		&&  ActionInput.coordinateX() - _map_offset_x <= FlxG.width)
		{
			if (__house.__house_menu_main._buttonToFurnitureGetMenu.toggled == true
			||  __house.__house_menu_main._buttonToFurniturePutMenu.toggled == true
			&&  ActionInput.overlaps(__house.__house_map_furniture._house_drag_icon)
			||  __house.__house_menu_main._buttonToFoundationPutMenu.toggled == true
			)
			{
				_ticks_down = RegFunctions.incrementTicks(_ticks_down, 60 / Reg._framerate);
				_sprite_ticks_down.visible = true;
			}
		}
		else
		{
			_ticks_down = 0;
			_ticks_down_fast = 0;
			_sprite_ticks_down.visible = false;
		}
		
		// LEFT
		if (__house._tracker.x > 692.5
		&&  ActionInput.coordinateX() - _map_offset_x > 375
		&&  ActionInput.coordinateX() - _map_offset_x <= 375 + 85
		&&  ActionInput.coordinateY() - _map_offset_y >= 0
		&&  ActionInput.coordinateY() - _map_offset_y <= FlxG.height - 45)
		{
			if (__house.__house_menu_main._buttonToFurnitureGetMenu.toggled == true
			||  __house.__house_menu_main._buttonToFurniturePutMenu.toggled == true
			&&  ActionInput.overlaps(__house.__house_map_furniture._house_drag_icon)
			||  __house.__house_menu_main._buttonToFoundationPutMenu.toggled == true
			)
			{
				_ticks_left = RegFunctions.incrementTicks(_ticks_left, 60 / Reg._framerate);
				_sprite_ticks_left.visible = true;
			}
		}
		else
		{
			_ticks_left = 0;
			_ticks_left_fast = 0;
			_sprite_ticks_left.visible = false;
		}
		
		// RIGHT
		if (__house._tracker.x < 102 * (__house._floorTileAmount - 5) - __house._trackerDefaultPosition + 102
		&&  ActionInput.coordinateX() - _map_offset_x > FlxG.width - 85
		&&  ActionInput.coordinateX() - _map_offset_x <= FlxG.width
		&&  ActionInput.coordinateY() - _map_offset_y >= 0
		&&  ActionInput.coordinateY() - _map_offset_y <= FlxG.height - 45)
		{
			if (__house.__house_menu_main._buttonToFurnitureGetMenu.toggled == true
			||  __house.__house_menu_main._buttonToFurniturePutMenu.toggled == true
			&&  ActionInput.overlaps(__house.__house_map_furniture._house_drag_icon)
			||  __house.__house_menu_main._buttonToFoundationPutMenu.toggled == true
			)
			{
				_ticks_right = RegFunctions.incrementTicks(_ticks_right, 60 / Reg._framerate);
				_sprite_ticks_right.visible = true;
			}
		}
		else
		{
			_ticks_right = 0;
			_ticks_right_fast = 0;
			_sprite_ticks_right.visible = false;
		}
				
		if (ActionInput.pressed() == true)
		{
			if (__house.__house_menu_main._buttonToFurnitureGetMenu.toggled == true
			||  __house.__house_menu_main._buttonToFurniturePutMenu.toggled == true
			&&  ActionInput.overlaps(__house.__house_map_furniture._house_drag_icon)
			||  __house.__house_menu_main._buttonToFoundationPutMenu.toggled == true
			)
			{
				if (_ticks_up 	 >= 25 - _ticks_up_fast) 	mapScrollUp();
				if (_ticks_down  >= 25 - _ticks_down_fast) 	mapScrollDown();
				if (_ticks_left  >= 25 - _ticks_left_fast) 	mapScrollLeft();
				if (_ticks_right >= 25 - _ticks_right_fast) mapScrollRight();
			}
		}
			
		super.update(elapsed);
	}
	
		
}//