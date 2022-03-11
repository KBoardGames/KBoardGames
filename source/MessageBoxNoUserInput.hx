/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * general message. its a blue background that closes after time expires.
 * @author kboardgames.com
 */
class MessageBoxNoUserInput extends FlxSubState
{		
	/******************************
	 * when timer runs out then this var is true. only then can a mouse click close this message. do not change this because check and checkmate messages will not be seen.
	 */
	public static var _ticks_close:Bool = false;
	
	private var _text:FlxText;
	private var _background:FlxSprite;
	private var _message_box:FlxSprite;
	
	public function new():Void
	{
		super();	
		
		Reg._outputMessage = false;
		
		// color black the whole scene.
		_background = new FlxSprite(0, 0);
		_background.makeGraphic(FlxG.width, FlxG.height, 0xCC000000);
		_background.scrollFactor.set(0, 0);	
		add(_background);
		
		_message_box = new FlxSprite(0, 0);
		_message_box.loadGraphic("assets/images/messageBox.png", false);	
		_message_box.scrollFactor.set(0, 0);
		_message_box.color = 0xFF44aa44;
		_message_box.alpha = .90;
		_message_box.screenCenter(Y);
		_message_box.x = Reg2._messageBox_x;
		add(_message_box);	
					
		_text = new FlxText(Reg2._messageBox_x + Reg2._textMessage_x, Reg2._messageBox_y + Reg2._textMessage_y, 0, Reg._messageBoxNoUserInput);
		_text.setFormat(null, 25, FlxColor.WHITE, LEFT);
		_text.font = Reg._fontDefault;
		_text.fieldWidth = 500;
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text.scrollFactor.set(0, 0);
		add(_text);
		
		new FlxTimer().start(0.8, closeMessage, 1);
		
		visible = true;
	}
	
	private function closeMessage(i:FlxTimer):Void
	{
		_ticks_close = true;
	}

	override public function destroy()
	{
		if (_text != null)
		{
			remove(_text);
			_text.destroy();
			_text = null;
		}
		
		if (_background != null)
		{
			remove(_background);
			_background.destroy();
			_background = null;
		}
		
		if (_message_box != null)
		{
			remove(_message_box);
			_message_box.destroy();
		}
		
		super.destroy();
	}
	
	
	override public function update(elapsed:Float):Void 
	{
		// do not use key/mouse click. that will stop some message box, their buttons, from firing.
		if (_ticks_close == true)
		{
			visible = false;
			_ticks_close = false;
			
			close();
		}
		
		super.update(elapsed);
	}	
	
}