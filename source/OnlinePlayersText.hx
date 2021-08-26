package;

/**
 * ...
 * @author kboardgames.com
 */
class OnlinePlayersText extends FlxText
{
	public var _rowNumber:Int = 0;				// table row number.
	
	public function new(x:Float = 0, y:Float = 0, _fieldWidth:Float = 0, _text:String, _textSize:Int = 20, rowNumber:Int = 0)	
	{	
		super(x, y, _fieldWidth, _text, _textSize);
		
		_rowNumber = rowNumber;
	}

	override public function destroy()
	{
		
		super.destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{			
		// when pressing the refresh online user list button, this code is needed so that it populates the table without creating text and buttons.
		for (i in 0...(Reg._maximum_server_connections + 1))
		{
			// no username found, so make that row empty.
			if (i == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "") text = "";
			if (i + (Reg._maximum_server_connections + 1) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "") text = "";
			if (i + ((Reg._maximum_server_connections + 1) * 2) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "") text = "";
			
			//#############################
			// this block displays the win, lose, draw data for the existing player that is only at the lobby. if the player is not at the lobby then the player's data will not display here at the players online table.
			if (i == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] != "")
				text = RegTypedef._dataOnlinePlayers._usernamesOnline[i];
			
			// chess Elo
			if (i + (Reg._maximum_server_connections + 1) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] != "")
			{
				text = Std.string(RegTypedef._dataOnlinePlayers._chess_elo_rating[i]);
			}
			
			// points.
			if (i + ((Reg._maximum_server_connections + 1) * 2) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] != "")
			{
				var _math:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + (RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] * 0.5);
				text = Std.string(FlxMath.roundDecimal(_math, 3)); // points.
			}
				
			// win percentage.
			if (i + ((Reg._maximum_server_connections + 1) * 3) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] != "")
			{
				// calculates the winning percentage. 
				var _totalGamesGet:Float = RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalLosses[i] + RegTypedef._dataOnlinePlayers._gamesAllTotalDraws[i];

				var _winningPercentage:Float = (RegTypedef._dataOnlinePlayers._gamesAllTotalWins[i] / _totalGamesGet);
				
				var _winnings:Float = FlxMath.roundDecimal(_winningPercentage * 100, 3);
				text = Std.string(_winnings); // win percentage.				
			} 
			
			else if (i + ((Reg._maximum_server_connections + 1) * 3) == _rowNumber && RegTypedef._dataOnlinePlayers._usernamesOnline[i] == "")
			{
				text = "";
			}
			
			//................................
		}
		
		
		super.update(elapsed);
	}

}
