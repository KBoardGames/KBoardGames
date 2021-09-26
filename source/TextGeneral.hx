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
import openfl.display.BitmapData;

// TODO: think about filters and text

/**
 * Extends FlxSprite to support rendering text. Can tint, fade, rotate and scale just like a sprite. Doesn't really animate 
 * though. Also does nice pixel-perfect centering on pixel fonts as long as they are only one-liners.
 */
class TextGeneral extends FlxText
{
	/**
	 * 2px gutter on both top and bottom
	 */
	static inline var VERTICAL_GUTTER:Int = 12;

	// this trims the makeGraphic box underneath the text with this is true, so that no makeGraphic padding after the text is seen.
	private var _multi_line:Bool = false;
	
	/**
	 * Creates a new `FlxText` object at the specified position.
	 * 
	 * @param   X              The x position of the text.
	 * @param   Y              The y position of the text.
	 * @param   FieldWidth     The `width` of the text object. Enables `autoSize` if `<= 0`.
	 *                         (`height` is determined automatically).
	 * @param   Text           The actual text you would like to display initially.
	 * @param   Size           The font size for this text object.
	 * @param   EmbeddedFont   Whether this text field uses embedded fonts or not.
	 */
	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true, multi_line:Bool = false)
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		_multi_line = multi_line;
	}

	
	override function regenGraphic():Void
	{
		if (textField == null || !_regen)
			return;
		
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
		
		if (oldWidth != newWidth || oldHeight != newHeight)
		{
			// Need to generate a new buffer to store the text graphic
			height = newHeight;
			var key:String = FlxG.bitmap.getUniqueKey("text");
			if (_multi_line == false)
				makeGraphic(FlxG.width - 55, Std.int(newHeight) + 27, 0x22777777, true, key);
			else 
			{
				// if text started at half of screen then offset this graphic so that it ends at the end of the screen.
				if (x > 100)
					makeGraphic(Std.int(FlxG.width / 2 - 85), Std.int(newHeight) - 2, 0x22777777, true, key);
				else
					makeGraphic(FlxG.width - 55, Std.int(newHeight) - 2, 0x22777777, true, key);
			}
				
			updateHitbox();
			frameHeight = Std.int(height) + 10;
			textField.height = height * 1.2;
			
		}
		else // Else just clear the old buffer before redrawing the text
		{
			graphic.bitmap.fillRect(_flashRect, FlxColor.TRANSPARENT);
			if (_hasBorderAlpha)
			{
				if (_borderPixels == null)
					_borderPixels = new BitmapData(frameWidth, frameHeight, true);
				else
					_borderPixels.fillRect(_flashRect, FlxColor.TRANSPARENT);
			}
		}
		
		if (textField != null && textField.text != null && textField.text.length > 0)
		{
			// Now that we've cleared a buffer, we need to actually render the text to it
			copyTextFormat(_defaultFormat, _formatAdjusted);
			
			_matrix.identity();
			
			applyBorderStyle();
			//applyBorderTransparency();
			applyFormats(_formatAdjusted, false);
			
			drawTextFieldTo(graphic.bitmap);
		}
		
		_regen = false;
		
	}
}
