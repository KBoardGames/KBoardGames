/*
    Copyright (c) 2021 KBoardGames.com
    This program is part of KBoardGames client software.

    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

package;

/**
 * the dice wheel, highlights each number, in turn. from 1 to 6. the number highlighted, after a mouse click, is the number used to move a piece that many times from the piece's current location.
 * @author kboardgames.com
 */
class NumberWheelButton extends FlxSprite
{
	public function new(x:Float, y:Float) 
	{
		super(x, y-7);
		
		// if changing this size, the click me x and y coordinates at GameCreate.hx also needs changing. for example, search for SnakesAndLaddersClickMe.
		loadGraphic("assets/images/numberWheel-button.png", true, 110, 110);
		
		// faster = higher value.
		animation.add("run", [0, 1, 0], 12, false); 
		visible = false;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (RegTypedef._dataPlayers._spectatorWatching == false)
		{
			if (Reg._gameId == 3 || Reg._gameId == 4)
			{
				if (Reg._gameOverForPlayer == false
				&&	Reg._playerCanMovePiece == true)
				{
					visible = true;
					
					if (FlxG.mouse.justPressed == true
					&&	NumberWheelAnimation._animation_playing == true)
					{
						// number is really 29.5. we cannot have half a pixel so 1 is added to the right side of the image.
						if (FlxG.mouse.x >= x - 29
						&&	FlxG.mouse.x <= x + 138 + 30
						&&	FlxG.mouse.y >= y - 29
						&&	FlxG.mouse.y <= y + 138 + 30)
							animation.play("run");
					}						
				}
				
				else if (Reg._playerCanMovePiece == false 
				&&		 animation.finished == true)
					visible = false;
			}
		}
		
		super.update(elapsed);
		
		if (NumberWheelAnimation._animation_playing == true) alpha = 1;
		else alpha = 0.7;
		
	}
	
}