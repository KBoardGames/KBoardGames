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
 * Menu of selectable bought furniture. 
 * @author kboardgames.com
 */
class HouseFurniturePut extends FlxState
{
	/******************************
	 * menu panel background
	 */
	public var _background:FlxSprite;
	
	/******************************
	 * the background behind the title. this does not move with scrollable area.
	 */
	public var _bgTitle:FlxSprite;
	
	/******************************
	 * title for menu panel
	 */
	public var _title:FlxText;
	
	/******************************
	 * if this var has the same value of the item clicked then the map will not move because it has already moved. this stops a bug where the map flickers position, showing the default map position for a millisecond. this value will reset to default when the map is scrolled.
	 * if the second item was clicked when this var will have a value of 2. if then changing the z-order, this value will then be increased or decreased by 1.
	 */
	public static var _value_from_item_pressed:Int = 0;
	
	/******************************
	 * at the put panel, if item 2 was clicked and that sprite had a name of 5.png then this value would be 5. this var is always plus 1 more than _value_from_item_pressed var.
	 */
	public static var _value_from_item_order:Int = 0;
		
	/******************************
	* anything added to this group will be placed inside of the scrollable area field. 
	*/
	public static var _group:FlxSpriteGroup;	
	
	/******************************
	 * An area of the screen that has automatic scrollbars, if needed.
	 */
	public var __scrollable_area:FlxScrollableArea;	
	
	/******************************
	 * the scrollable area would not work without at least one sprite added to the scrollable areaGroup.
	 */
	private	var _box:FlxSprite;
	
	/******************************
	 * used to position the sprites and text.
	 */
	private var _offset_y:Int = 440;
	
	/******************************
	 * the name of the item (furniture).
	 */
	private var _text:FlxText;
	
	/******************************
	 * starts at value 0. access members here.
	 */
	public static var _group_sprite:Array<FlxSprite> = [];
	
	/******************************
	 * access members here.
	 */
	public static var _group_text:Array<FlxText> = [];
	
	/******************************
	 * used to push members.
	 */
	private var _sprite:FlxSprite; 
	
	/******************************
	 * Main class. draws the walls and floors of the room.
	 */
	private var __house:House;
	
	override public function new(house:House):Void
	{
		super();
		
		_value_from_item_pressed = 0;
		_value_from_item_order = 0;
		
		__house = house;
		
		_background = new FlxSprite(0, 0);
		_background.makeGraphic(353,FlxG.height-45);
		_background.color = 0xFF002222;
		_background.scrollFactor.set(0, 0);
		add(_background);
		
		//if (_group != null) _group.destroy();
		_group = cast add(new FlxSpriteGroup());
		_group.setPosition(0, 0);
		
		// the scrollable area would not work without at least one sprite added to the scrollable areaGroup.
		_box = new FlxSprite();
		_box.makeGraphic(1, 1, FlxColor.BLACK);
		_box.setPosition(0, 0);
		add(_box);
		_group.add(_box);
		
		//--------------------------
		var _idSprite:Int = 1;
	
		for (i in 0...200)
		{
			if (i <= RegHouse._totalPurchased)
			{
				_text = new FlxText(17, (i * 200) + _offset_y - 48, 0, RegHouse._namesPurchased[i + 1] + ".");
				_text.fieldWidth = 240;
				_text.setFormat(Reg._fontDefault, 22, FlxColor.CYAN);
				_text.x = -10 + (373 / 2) - _text.width / 2; // -10 is scrollbar width. 373 is scene width - map width.
				_text.bold = false;
				add(_text);
				// add this member to _group_sprite.			
				_group_text.push(_text);
							
				_group_text[i].fieldWidth = 240;
				
				// give this member an id. this id is used to move members in z-order.
				_group_text[i].ID = _idSprite;
				_group.add(_group_text[i]);
					
				// load the furniture images.
				if (_sprite != null) remove(_sprite);
				_sprite = new FlxSprite();
				_sprite.loadGraphic("modules/house/assets/images/house/furniture/get/" + RegHouse._sprite_number[i] + ".png", true, 100, 100);
				add(_sprite);
				
				// add this member to _group_sprite.			
				_group_sprite.push(_sprite);
							
				// position this image on scene.
				_group_sprite[i].setPosition(136 - (20 / 2), (i * 200) + _offset_y); // 373 % 2 - 50 = 136. (373 = panel size. -50 is half of 100 which is the width of the image. 20 is the sidebar width.
				
				// give this member an id. this id is used to move members in z-order.
				_group_sprite[i].ID = _idSprite;
				
				_group_sprite[i].animation.add("0", [0], 30, false);
				_group_sprite[i].animation.add("1", [1], 30, false);
				_group_sprite[i].animation.play("0");
				
				_group.add(_group_sprite[i]);
				_idSprite += 1;
				
			}
						
			else
			{
				_text = new FlxText(17, (i * 200) + _offset_y - 48, 0, "Unit " + Std.string(i+1) + " is empty.");
				_text.setFormat(Reg._fontDefault, 22, FlxColor.CYAN);
				add(_text);
				// add this member to _group_sprite.			
				_group_text.push(_text);
							
				_group_text[i].fieldWidth = 240;
				_group_text[i].x = -10 + (373 / 2) - _text.width / 2; // -10 is scrollbar width. 373 is scene width - map width.
				_group_text[i].setPosition(-10 + (373 / 2) - _text.width / 2, (i * 200) + _offset_y - 48);
				
				// give this member an id. this id is used to move members in z-order.
				_group_text[i].ID = _idSprite;
				_group.add(_group_text[i]);
				
				// load the furniture images.
				_sprite = new FlxSprite();
				_sprite.loadGraphic("modules/house/assets/images/houseItem.png", true, 100, 100);
				_group.add(_sprite);
				
				// add this member to _group_sprite.			
				_group_sprite.push(_sprite);
							
				// position this image on scene.
				_group_sprite[i].setPosition(136 - (20 / 2), (i * 200) + _offset_y); 
				
				// give this member an id. this id is used to move members in z-order.
				_group_sprite[i].ID = _idSprite;
				
				_group_sprite[i].animation.add("0", [0], 30, false);
				_group_sprite[i].animation.add("1", [1], 30, false);
				_group_sprite[i].animation.play("0");
				
				_group.add(_group_sprite[i]);
				_idSprite += 1;
				
			}
		}
	

		// the scrollbar is  needed or else there will be a client crash when a request for the scrollbar is made.
		var _buttonForScrollBar = new ButtonGeneralNetworkNo(0, (((RegHouse._totalCanPurchase + 1 ) * 200) + 100) + _offset_y, "", 160 + 15, 35, Reg._font_size, RegCustom._button_text_color[Reg._tn], 0, null, RegCustom._button_color[Reg._tn]);
		_buttonForScrollBar.label.font = Reg._fontDefault;
		_buttonForScrollBar.visible = false;
		_group.add(_buttonForScrollBar);
		
		// make a scrollbar-enabled camera for it (a FlxScrollableArea)	
		if (__scrollable_area != null) FlxG.cameras.remove(__scrollable_area);
		__scrollable_area = new FlxScrollableArea( new FlxRect( 0, 0, 373, FlxG.height-50), new FlxRect( 0, 0, 350, 199 * 200), ResizeMode.NONE, 444, 100, -1, FlxColor.LIME, null, 100, true);
		add(__scrollable_area);
		
		fixScrollbarElementOffsetY();
		
		FlxG.cameras.add( __scrollable_area );
		__scrollable_area.antialiasing = true;
		__scrollable_area.pixelPerfectRender = true;
		
		_bgTitle = new FlxSprite(0, 0);
		_bgTitle.makeGraphic(353, 60);
		_bgTitle.scrollFactor.set();
		_bgTitle.color = 0xFF002222;
		add(_bgTitle);

		_title = new FlxText(17, 30, 0, "Furniture Put");
		_title.setFormat(Reg._fontDefault, 22, FlxColor.WHITE);
		_title.scrollFactor.set();
		add(_title);
		
	
	}
		
	public static function textAndspriteRefreshPanel():Void
	{
		for (i in 0...200)
		{
			if (i <= RegHouse._totalPurchased)
			{
				_group_text[i].text = RegHouse._namesPurchased[i+1] + ".";
				_group_text[i].x = -10 + (373 / 2) - _group_text[i].width / 2; // -10 is scrollbar width. 373 is scene width - map width.
				
				_group_sprite[i].loadGraphic("modules/house/assets/images/house/furniture/get/" + RegHouse._sprite_number[i] + ".png", true, 100, 100);
				_group_sprite[i].animation.add("0", [0], 30, false);
				_group_sprite[i].animation.add("1", [1], 30, false);
				_group_sprite[i].animation.play("0");
			}
			
			else if (_group_text[i] != null)
			{
				_group_text[i].text = "Unit " + Std.string(i+1) + " is empty.";
				
				_group_sprite[i].loadGraphic("modules/house/assets/images/houseItem.png", true, 100, 100);
				_group_sprite[i].animation.add("0", [0], 30, false);
				_group_sprite[i].animation.play("0");
				
			}
		}
		
	}
		
	/******************************
	 * this is needed to set the group at the top of the panel. scrollable area.scroll.y changes in value when its content changes. The result would be _group.y value offsetting at scrollable area. 
	 */
	public function fixScrollbarElementOffsetY():Void
	{
		// might need to recreate the scrollbar to bring it back up.
		
		// this is needed to set the group at the top of the panel. scrollable area.scroll.y changes in value when its content changes. The result would be _group.y value offsetting at scrollable area. 		
		_group.y = __scrollable_area.scroll.y - 260; // _offset_y;
			
		// now that the top of the scrollable area is fixed we need to set this so that the last element is correctly displayed. without this code the last element would not be seen or may be seen party cut off at the bottom of the scrollable area.
		__scrollable_area.content.height += Std.int(__scrollable_area.scroll.y) + _offset_y;
	}
	
	override public function destroy()
	{
		if (_group != null)
		{
			remove(_group);
			_group.destroy();
			_group = null;
		}
		
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
		
		if (_title != null)
		{
			remove(_title);			
			_title.destroy();
			_title = null;
		}		
		
		if (_box != null)
		{
			remove(_box);
			_box.destroy();
			_box = null;
		}
		
		if (_text != null)
		{
			remove(_text);
			_text.destroy();
			_text = null;
		}
		
		if (_sprite != null)
		{
			remove(_sprite);
			_sprite.destroy();
			_sprite = null;
		}
				
		if (__scrollable_area != null)
		{
			cameras.remove(__scrollable_area);
			__scrollable_area.destroy();
			__scrollable_area = null;
		}
		
		_group_text.splice(0, _group_text.length);
		_group_sprite.splice(0, _group_sprite.length);
			
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void
	{
		// if player returned to lobby then this var is false so don't update().
		if (Reg._at_house == false) return;
		if (RegHouse._house_main_menu_button_number != 1) return;
	
		if (RegTriggers._furnitureItemSpriteAddToPutPanel == true)
		{
			RegTriggers._furnitureItemSpriteAddToPutPanel = false;
			textAndspriteRefreshPanel();
		}
		
		// highlight item if mouse is hovering over it.
		for (i in 0...RegHouse._totalPurchased+1)
		{
			if (ActionInput.coordinateX() - HouseScrollMap._map_offset_x > _group_sprite[i].x
			&&  ActionInput.coordinateX() - HouseScrollMap._map_offset_x < _group_sprite[i].x + 100
			&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y + __scrollable_area.scroll.y > _group_sprite[i].y
			&&  ActionInput.coordinateY() - HouseScrollMap._map_offset_y + __scrollable_area.scroll.y < _group_sprite[i].y + 100)
			{
				_group_sprite[i].animation.play("1");
				
				if (ActionInput.justPressed() == true)
				{
					if (RegCustom._sound_enabled[Reg._tn] == true
					&&  Reg2._scrollable_area_is_scrolling == false)
						FlxG.sound.play("click", 1, false);
				}
				
				if (ActionInput.justReleased() == true)
				{
					_value_from_item_pressed = RegHouse._item_order[i];
					_value_from_item_order = RegHouse._item_order[i];

					// select the furniture item. set the .member_bg_behind sprite for it and set the HouseMenuFurniture._text_of_item_selected text for that item.
					HouseMenuFurniture._members = i + 1;
					__house.__house_menu_furniture.button_toggle_visibility_text();
					__house.__house_menu_furniture.button_toggle_walls_text();
					RegTriggers._item_select_triggered_from_put_panel = true;
				}
				
			}
			
			else _group_sprite[i].animation.play("0");
		}
		
		super.update(elapsed);
	}
	
}//