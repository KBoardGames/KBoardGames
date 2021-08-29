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

class ScrollingText extends FlxSpriteGroup
{
	private var _scroller:FlxSprite;	// black coloured image. seen as a background.
	private var _tf:FlxText;		// text that the image will stamp. this text will be scrolled.
	private var _tfY:Int = 0;			// final offset value.
	private var _offsetY:Float = 0;
	
	public var _ticks_delay:Float = 0;
	
	public function new(x:Float = 0, y:Float = 0, width:Float = 128, height:Float = 14, text:String = "", textSize:Int = 10, tileHeight:Int = 16, upperCase:Bool = true) 
	{
		super();
		
		var textString = (upperCase) ? text.toUpperCase() : text;
		
		_offsetY = (tileHeight - height) / 2;

		_tfY = Std.int(_offsetY) - #if cpp 3 #else 1 #end;

		// the text used to scroll.
		_tf = new FlxText(width, y + _tfY, 0, textString, textSize);
		_tf.color = 0xFFFFFFFF;
		_tf.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_tf.font = Reg._fontDefault;
		_tf.autoSize = true;
		_tf.wordWrap = false;

		// image set as black.
		_scroller = new FlxSprite(x, y + _offsetY).makeGraphic(Std.int(width), Std.int(height), 0xFF000000, true);
		
		add(_scroller);
	}
	
	private function updateText(tf:FlxText):Void
	{
		if ((tf.x + tf.width) < x)
		{
			// do not restart the scrolling. tf.x = x + width; 
			destroy();
		}
		else
		{
			tf.x -= 4;
			// this rectangle is the border that surrounds the text.
			FlxSpriteUtil.drawRect(_scroller, 0, 0, width - 1, height - 1, 0xFF946c3c, { thickness: 1, color: 0xFF946c3c }); // the second color is the border.
			_scroller.stamp(_tf, Std.int(tf.x), _tfY + 6); // uses the text as an image.
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_scroller.isOnScreen())
		{
			super.update(elapsed);
			
			_ticks_delay = RegFunctions.incrementTicks(_ticks_delay, 60 / Reg._framerate);
			
			if (_ticks_delay > 2) 
			{
				updateText(_tf);
				_ticks_delay = 0;
			}
		}
	}
}
