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

package modules.games.reversi;

/**
 * displays and updates a player's total captured units.
 * @author kboardgames.com
 */
class ReversiUnitsTotal extends FlxGroup
{	 	
	public var _player1_units_total:FlxText;
	public var _player2_units_total:FlxText;
	
	public function new() 
	{
		super();
		
		var _p1 = new FlxText(FlxG.width - 352, FlxG.height - 320, 0, "P1 Total Score: ", 20);
		_p1.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_p1.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_p1.scrollFactor.set(0, 0);
		add(_p1);
		
		_player1_units_total = new FlxText(FlxG.width - 97, FlxG.height - 320, 0, "0", 20);
		_player1_units_total.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_player1_units_total.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_player1_units_total.text = "0";
		_player1_units_total.scrollFactor.set(0, 0);
		add(_player1_units_total);
		
		var _p2 = new FlxText(FlxG.width - 352, FlxG.height - 287, 0, "P2 Total Score: ", 20);
		_p2.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_p2.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_p2.scrollFactor.set(0, 0);
		add(_p2);
		
		_player2_units_total = new FlxText(FlxG.width - 97, FlxG.height - 287, 0, "", 20);
		_player2_units_total.setFormat(Reg._fontDefault, Reg._font_size, RegCustomColors.client_text_color());
		_player2_units_total.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 2);
		_player2_units_total.text = "0";
		_player2_units_total.scrollFactor.set(0, 0);
		add(_player2_units_total);
	}
	
	override public function destroy()
	{		
		super.destroy();
	}
	
	override public function update(elapsed:Float)
	{
		if (Reg._gameOverForPlayer == false)
		{
			var _p1_total = 0;
			var _p2_total = 0;
			
			for (yy in 0...8)
			{
				for (xx in 0...8)
				{
					// how many units does player 1 have? this is the score. black piece always goes first.
					if (Reg._gamePointValueForPiece[yy][xx] == 11) 
						_p1_total += 1;
						
					if (Reg._gamePointValueForPiece[yy][xx] == 1) 
						_p2_total += 1;
				}
			}
			
			// output the total score for each player.
			_player1_units_total.text = Std.string(_p1_total);
			_player2_units_total.text = Std.string(_p2_total);
		}
		
		super.update(elapsed);
		
	}
		
}