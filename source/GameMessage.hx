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
 * general message. its a blue background that can be closed when time expires or from a mouse button click.
 * @author kboardgames.com
 */
class GameMessage extends FlxSubState
{		
	/******************************
	 * the message.
	 */
	public var _text:FlxText;
	
	
	public function new():Void
	{
		super();	
				
		// color black the whole scene.
		var background = new FlxSprite(0, 0);
		background.makeGraphic(FlxG.width, FlxG.height, 0xCC000000);
		background.scrollFactor.set(0, 0);	
		add(background);
		
		var background2 = new FlxSprite(0, 0);
		background2.makeGraphic(630, 275, 0xBB000066);
		background2.scrollFactor.set(0, 0);	
		background2.screenCenter(XY);
		background2.x -= 20;
		add(background2);	
					
		var _text:FlxText = new FlxText(0, FlxG.height / 2 -75, 0, Reg._gameMessage);
		_text.setFormat(null, 25, FlxColor.WHITE, LEFT);
		_text.font = Reg._fontDefault;
		_text.fieldWidth = 500;
		_text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 1);
		_text.scrollFactor.set(0, 0);
		_text.screenCenter(XY);
		add(_text);
				
		new FlxTimer().start(0.8, closeMessage, 1);
		
		visible = true;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.mouse.pressed == true)
		{
			visible = false;
			close();
		}
		
		super.update(elapsed);
	}	
	
	override public function destroy()
	{
		super.destroy();
	}
	
	private function closeMessage(i:FlxTimer):Void
	{
		visible = false;
		close();
	}

}