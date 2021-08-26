package;

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
		_p1.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PINK);
		_p1.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_p1.scrollFactor.set(0, 0);
		add(_p1);
		
		_player1_units_total = new FlxText(FlxG.width - 97, FlxG.height - 320, 0, "0", 20);
		_player1_units_total.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PINK);
		_player1_units_total.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_player1_units_total.text = "0";
		_player1_units_total.scrollFactor.set(0, 0);
		add(_player1_units_total);
		
		var _p2 = new FlxText(FlxG.width - 352, FlxG.height - 287, 0, "P2 Total Score: ", 20);
		_p2.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PINK);
		_p2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_p2.scrollFactor.set(0, 0);
		add(_p2);
		
		_player2_units_total = new FlxText(FlxG.width - 97, FlxG.height - 287, 0, "", 20);
		_player2_units_total.setFormat(Reg._fontDefault, Reg._font_size, FlxColor.PINK);
		_player2_units_total.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 2);
		_player2_units_total.text = "0";
		_player2_units_total.scrollFactor.set(0, 0);
		add(_player2_units_total);
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
	
	override public function destroy()
	{		
		super.destroy();
	}
	
	
}