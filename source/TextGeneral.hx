/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

// TODO: think about filters and text

/**
 * Extends FlxSprite to support rendering text. Can tint, fade, rotate and scale just like a sprite. Doesn't really animate 
 * though. Also does nice pixel-perfect centering on pixel fonts as long as they are only one-liners.
 * @author kboardgames.com
 */
class TextGeneral extends FlxText
{
	/******************************
	 * When this class is first created this var will hold the X value of this class. If this class needs to be reset back to its start map location then X needs to equal this var.
	 */
	public var _startX:Float = 0;

	/******************************
	 * When this class is first created this var will hold the Y value of this class. If this class needs to be reset back to its start map location then Y needs to equal this var.
	 */
	public var _startY:Float = 0;
	
	/******************************
	 * used at __scrollable_area to offset the mouse x/y coordinates when the __scrollable_area is scrolled. without these vars when the __scrollable_area is scrolled stage objects underneath the __scrollable_area will fire.
	 * remember, a group is added to the stage and the group is added to the __scrollable_area. So the two objects, one not seen because it is behind the __scrollable_area camera, will fire unless these vars are used.
	 */
	public static var _scrollarea_offset_x:Float;

	/******************************
	 * used at __scrollable_area to offset the mouse x/y coordinates when the __scrollable_area is scrolled. without these vars when the __scrollable_area is scrolled stage objects underneath the __scrollable_area will fire.
	 * remember, a group is added to the stage and the group is added to the __scrollable_area. So the two objects, one not seen because it is behind the __scrollable_area camera, will fire unless these vars are used.
	 */
	public static var _scrollarea_offset_y:Float;
	
	private var _ticks:Float = 0;
	
	/******************************
	 * this stop a function from being called at every update() elapsed. 0: background has not been drawn to scene. 1: background is transparent behind text. 2: background is a highlight color.
	 */
	private var _text_state:Array<Int> = [];
		
	/******************************
	 * 2px gutter on both top and bottom
	 */
	static inline var VERTICAL_GUTTER:Int = 12;

	private var _multi_line:Bool = false;
	public var _background_width:Int = 0;
	public var _background_height:Int = 0;
	private var _background_visible:Bool = true;
	
	private var _id:Int = 0;
	private var _text:String = "";
	
	/**
	 * Creates a new `FlxText` object at the specified position.
	 * 
	 * @param   X				The x position of the text.
	 * @param   Y				The y position of the text.
	 * @param   FieldWidth		The `width` of the text object. Enables `autoSize` if `<= 0`.
	 *                         (`height` is determined automatically).
	 * @param   Text			The actual text you would like to display initially.
	 * @param   Size			The font size for this text object.
	 * @param   EmbeddedFont	Whether this text field uses embedded fonts or not.
	 * @param	multi_line		this trims the makeGraphic box underneath the text with this is true, so that no makeGraphic padding after the text is seen.
	 * @param	background_size		the size of the semitransparent table row underneath this FlxText.
	 */
	public function new(x:Float = 0, y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true, multi_line:Bool = false, background_width:Int = 0, background_height:Int = 0, background_visible:Bool = true)
	{
		super(x, y, FieldWidth, Text, Size, EmbeddedFont);
		
		_startX = x;
		_startY = y;
	
		_text = Text;
		_scrollarea_offset_x = 0;
		_scrollarea_offset_y = 0;
		
		// if we started this value at a very high value, we would receive a "too many heap sections" out of memory error.
		Reg._text_general_id += 1;
		_id = ID = Reg._text_general_id;
		
		_multi_line = multi_line;
		_background_width = background_width;
		_background_height = background_height;
		_background_visible = background_visible;
		
		_ticks = 0;
		_text_state.push(0);
	}

	// this function is needed. it draws this class background to some scenes.
	//override function regenGraphic():Void { if (_id != ID) return; }
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	// this function is needed to update the FlxSprite which is used as the text background.
	override public function update(elapsed:Float):Void
	{
		if (_id != ID) return;
		
		if (_ticks == 0)
		{
			// TODO when mouse is overtop of this class when this class is rendering, this class background and text will not show when the mouse is overtop of it. Note there was an issue where this command placed at SceneLobby will stop a message box buttons from working most of the time. only use this command here.
			FlxG.mouse.setGlobalScreenPositionUnsafe(0, 0);
			
			var oldWidth:Int = 0;
			var oldHeight:Int = VERTICAL_GUTTER;
			
			if (graphic != null)
			{
				oldWidth = graphic.width;
				oldHeight = graphic.height;
			}
			
			var newWidth:Float = textField.width;
			// Account for gutter
			var newHeight:Float = textField.textHeight + VERTICAL_GUTTER;
			
			// prevent text height from shrinking on flash if text == ""
			if (textField.textHeight == 0) 
			{
				newHeight = oldHeight;
			}
			
			if (oldWidth != newWidth
			||	oldHeight != newHeight)
			{
				// Need to generate a new buffer to store the text graphic
				height = newHeight;
				_background_height = Std.int(((newHeight + 27) / 2) + 5);
				var key:String = FlxG.bitmap.getUniqueKey("text");
				
				// draw a semitransparent table row underneath this FlxText.
				if (_multi_line == false)
				{
					// if variable is set.
					if (_background_width > 0)
					{
						if (_text_state[ID] != 1)
						{
							if (FlxG.mouse.y + _scrollarea_offset_y < _startY
							||  FlxG.mouse.y + _scrollarea_offset_y > _startY + _background_height)
							{
								_text_state[ID] = 1;
								makeGraphic(_background_width, _background_height, 0x33000044, true, key);
							}
						}
						
					}
					
					else
					{
						if (_text_state[ID] != 1)
						{
							if (FlxG.mouse.y + _scrollarea_offset_y < _startY
							||  FlxG.mouse.y + _scrollarea_offset_y > _startY + Std.int(newHeight + 27))
							{
								_text_state[ID] = 1;
								
								// if this var is false then user could be at the front door. at the right side of that screen the client text is displayed. if using the FlxText to draw the client text then the server text we show after a slight delay since this class draws the text after drawing the backgrould.
								if (_background_visible == true)
									makeGraphic(FlxG.width - 55, Std.int(newHeight + 27), 0x33000044, true, key);
								else // a background is needed.
									makeGraphic(FlxG.width - 55, Std.int(newHeight + 27), 0x00000000, true, key);
							}
						}
					}
					
				}
				
				else 
				{
					// if text started at half of screen then offset this graphic so that it ends at the end of the screen.
					if (_startX > 100)
					{
						if (_text_state[ID] != 1)
						{
							if (FlxG.mouse.y + _scrollarea_offset_y < _startY
							||  FlxG.mouse.y + _scrollarea_offset_y > _startY + Std.int(newHeight) - 2)
							{
								_text_state[ID] = 1;
								makeGraphic(Std.int(FlxG.width / 2 - 85), Std.int(newHeight) - 2, 0x33000044, true, key);
							}
						}
					}
					
					else
					{
						if (_text_state[ID] != 1)
						{
							if (FlxG.mouse.y + _scrollarea_offset_y < _startY
							||  FlxG.mouse.y + _scrollarea_offset_y > _startY + Std.int(newHeight) - 2)
							{
								_text_state[ID] = 1;
								makeGraphic(Std.int(FlxG.width - 55), Std.int(newHeight) - 2, 0x33000044, true, key);
							}
						}
					}
				}
					
				textField.height = height * 1.2;
				
			}			
			
			_ticks = 1;
		}
		
		if (_ticks == 1)
		{
			FlxG.mouse.visible = false;
			FlxG.mouse.enabled = false;
			
			_matrix.identity();
			
			applyBorderStyle();
			applyFormats(_formatAdjusted, false);
			
			drawTextFieldTo(graphic.bitmap);
			
			Reg._can_join_server = true;
			_ticks = 2;
			
			FlxG.mouse.visible = true;
			FlxG.mouse.enabled = true;
			FlxG.mouse.reset();
		}

		super.update(elapsed);
	}
}
 